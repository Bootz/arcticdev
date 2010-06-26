/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

#include "StdAfx.h"
#pragma pack(push, 1)
typedef struct
{
	uint16 opcode;
	uint32 size;
}logonpacket;
#pragma pack(pop)

#ifndef CLUSTERING

ARCTIC_INLINE static void swap32(uint32* p) { *p = ((*p >> 24 & 0xff)) | ((*p >> 8) & 0xff00) | ((*p << 8) & 0xff0000) | (*p << 24); }

//����������� � ���������� ��� ������������ ����� � ��������
void *LogonCommClientSocket::operator new(size_t size)
{
	sLog.outDebug("New LogonCommClientSocket dynamic string in object.");
	return malloc(size);
}

void LogonCommClientSocket::operator delete(void* p)
{
	sLog.outDebug("Delete LogonCommClientSocket dynamic string in object.");
	free(p);
}

LogonCommClientSocket::LogonCommClientSocket(SOCKET fd) : Socket(fd, 724288, 262444)
{
	// do nothing
	last_ping = last_pong = (uint32)UNIXTIME;
	remaining = opcode = 0;
	_id=0;
	latency = 0;
	use_crypto = false;
	authenticated = 0;
}

void LogonCommClientSocket::OnRead()
{
	while(true)
	{
		if(!remaining)
		{
			if(readBuffer.GetSize() < 6)
				return;	 // no header

			// read header
			readBuffer.Read(&opcode, 2);
			readBuffer.Read(&remaining, 4);

			// decrypt the first two bytes
			if(use_crypto)
			{
				_recvCrypto.Process((uint8*)&opcode, (uint8*)&opcode, 2);
				_recvCrypto.Process((uint8*)&remaining, (uint8*)&remaining, 4);
			}

			// convert network byte order
			swap32(&remaining);
		}

		// do we have a full packet?
		if(readBuffer.GetSize() < remaining)
			return;

		// create the buffer
		WorldPacket buff(opcode, remaining);
		if(remaining)
		{
			buff.resize(remaining);
			readBuffer.Read((void*)buff.contents(), remaining);
		}

		// decrypt the rest of the packet
		if(use_crypto && remaining)
			_recvCrypto.Process((unsigned char*)buff.contents(), (unsigned char*)buff.contents(), remaining);

		// handle the packet
		HandlePacket(buff);
		
		remaining = 0;
		opcode = 0;
	}
}

void LogonCommClientSocket::HandlePacket(WorldPacket & recvData)
{
	static logonpacket_handler Handlers[RMSG_COUNT] = {
		NULL,												 // RMSG_NULL
		NULL,												 // RCMSG_REGISTER_REALM
		&LogonCommClientSocket::HandleRegister,				 // RSMSG_REALM_REGISTERED
		NULL,												 // RCMSG_REQUEST_SESSION
		&LogonCommClientSocket::HandleSessionInfo,			 // RSMSG_SESSION_RESULT
		NULL,												 // RCMSG_PING
		&LogonCommClientSocket::HandlePong,					 // RSMSG_PONG
		NULL,												 // RCMSG_SQL_EXECUTE
		NULL,												 // RCMSG_RELOAD_ACCOUNTS
		NULL,												 // RCMSG_AUTH_CHALLENGE
		&LogonCommClientSocket::HandleAuthResponse,			 // RSMSG_AUTH_RESPONSE
		&LogonCommClientSocket::HandleRequestAccountMapping, // RSMSG_REQUEST_ACCOUNT_CHARACTER_MAPPING
		NULL,												 // RCMSG_ACCOUNT_CHARACTER_MAPPING_REPLY
		NULL,												 // RCMSG_UPDATE_CHARACTER_MAPPING_COUNT
		&LogonCommClientSocket::HandleDisconnectAccount,	 // RSMSG_DISCONNECT_ACCOUNT
		NULL,												 // RCMSG_TEST_CONSOLE_LOGIN
		&LogonCommClientSocket::HandleConsoleAuthResult,	 // RSMSG_CONSOLE_LOGIN_RESULT
		NULL,												 // RCMSG_MODIFY_DATABASE
		&LogonCommClientSocket::HandleServerPing,			 // RCMSG_SERVER_PING
		NULL,												 // RSMSG_SERVER_PONG
		&LogonCommClientSocket::HandlePopulationRequest,	 // RSMSG_REALM_POP_REQ
		NULL,												 // RCMSG_REALM_POP_RES
	};

	if(recvData.GetOpcode() >= RMSG_COUNT || Handlers[recvData.GetOpcode()] == 0)
	{
		printf(GTAUNKNOWMSAI, recvData.GetOpcode());
		return;
	}

	(this->*(Handlers[recvData.GetOpcode()]))(recvData);
}

void LogonCommClientSocket::HandleRegister(WorldPacket & recvData)
{
	uint32 realmlid;
	uint32 error;
	string realmname;
	recvData >> error >> realmlid >> realmname;

	Log.Notice(ZDALOGONCOMAI, REALMREGISTAI, realmname.c_str(), realmlid);
	LogonCommHandler::getSingleton().AdditionAck(_id, realmlid);
	realm_ids.insert(realmlid);
}

void LogonCommClientSocket::HandleSessionInfo(WorldPacket & recvData)
{
	uint32 request_id;
	recvData >> request_id;

	Mutex & m = sLogonCommHandler.GetPendingLock();
	m.Acquire();

	// find the socket with this request
	WorldSocket * sock = sLogonCommHandler.GetSocketByRequest(request_id);
	if(sock == 0 || sock->Authed || !sock->IsConnected())	   // Expired/Client disconnected
	{
		m.Release();
		return;
	}

	// extract sessionkey / account information (done by WS)
	sock->Authed = true;
	sLogonCommHandler.RemoveUnauthedSocket(request_id);
	sock->InformationRetreiveCallback(recvData, request_id);
	m.Release();
}

void LogonCommClientSocket::HandlePong(WorldPacket & recvData)
{
	latency = getMSTime() - pingtime;
	last_pong = (uint32)UNIXTIME;
}

void LogonCommClientSocket::SendPing()
{
	pingtime = getMSTime();
	WorldPacket data(RCMSG_PING, 4);
	SendPacket(&data,false);

	last_ping = (uint32)UNIXTIME;
}

void LogonCommClientSocket::SendPacket(WorldPacket * data, bool no_crypto)
{
	logonpacket header;
	bool rv;
	if(!m_connected || m_deleted)
		return;

	BurstBegin();

	header.opcode = data->GetOpcode();
	header.size = (uint32)data->size();
	swap32(&header.size);

	if(use_crypto && !no_crypto)
		_sendCrypto.Process((unsigned char*)&header, (unsigned char*)&header, 6);

	rv = BurstSend((const uint8*)&header, 6);

	if(data->size() > 0 && rv)
	{
		if(use_crypto && !no_crypto)
			_sendCrypto.Process((unsigned char*)data->contents(), (unsigned char*)data->contents(), (unsigned int)data->size());

		rv = BurstSend((const uint8*)data->contents(), (uint32)data->size());
	}

	if(rv) BurstPush();
	BurstEnd();
}

void LogonCommClientSocket::OnDisconnect()
{
	if(_id != 0)
	{
		DEBUG_LOG(LOGONSCLIENAI, CANNECTIOSFAI);
		sLogonCommHandler.ConnectionDropped(_id);	
	}
}

LogonCommClientSocket::~LogonCommClientSocket()
{

}

void LogonCommClientSocket::SendChallenge()
{
	uint8 * key = sLogonCommHandler.sql_passhash;

	_recvCrypto.Setup(key, 20);
	_sendCrypto.Setup(key, 20);	

	/* packets are encrypted from now on */
	use_crypto = true;

	WorldPacket data(RCMSG_AUTH_CHALLENGE, 20);
	data.append(key, 20);
	SendPacket(&data, true);
}

void LogonCommClientSocket::HandleAuthResponse(WorldPacket & recvData)
{
	uint8 result;
	recvData >> result;
	if(result != 1)
	{
		authenticated = 0xFFFFFFFF;
	}
	else
	{
		authenticated = 1;
	}
}

void LogonCommClientSocket::UpdateAccountCount(uint32 account_id, uint8 add)
{
	WorldPacket data(RCMSG_UPDATE_CHARACTER_MAPPING_COUNT, 9);
	set<uint32>::iterator itr = realm_ids.begin();

	for(; itr != realm_ids.end(); ++itr)
	{
		data.clear();
		data << (*itr) << account_id << add;
		SendPacket(&data,false);
	}
}

void LogonCommClientSocket::HandleRequestAccountMapping(WorldPacket & recvData)
{
	uint32 t= getMSTime();
	uint32 realm_id;
	uint32 account_id;
	QueryResult * result;
	map<uint32, uint8> mapping_to_send;
	map<uint32, uint8>::iterator itr;

	// grab the realm id
	recvData >> realm_id;

	// fetch the character mapping
	result = CharacterDatabase.Query("SELECT acct FROM characters");

	if(result)
	{
		do 
		{
			account_id = result->Fetch()[0].GetUInt32();
			itr = mapping_to_send.find(account_id);
			if(itr != mapping_to_send.end())
				itr->second++;
			else
				mapping_to_send.insert( make_pair( account_id, 1 ) );
		} while(result->NextRow());
		delete result;
	}

	if(!mapping_to_send.size())
	{
		// no point sending empty shit
		return;
	}

	ByteBuffer uncompressed(40000 * 5 + 8);
	//uint32 Count = 0;
	uint32 Remaining = (uint32)mapping_to_send.size();
	itr = mapping_to_send.begin();
	for(;;)
	{
		// Send no more than 40000 characters at once.
		uncompressed << realm_id;
		
		if(Remaining > 40000)
			uncompressed << uint32(40000);
		else
			uncompressed << Remaining;

		for(uint32 i = 0; i < 40000; ++i, ++itr)
		{
            uncompressed << uint32(itr->first) << uint8(itr->second);
			if(!--Remaining)
				break;
		}

		CompressAndSend(uncompressed);
		if(!Remaining)
			break;

		uncompressed.clear();
	}	
	Log.Notice(ZDALOGONCOMAI, BUILDSCHARAAI, getMSTime()-t,mapping_to_send.size());
}

void LogonCommClientSocket::CompressAndSend(ByteBuffer & uncompressed)
{
	// I still got no idea where this came from :p
	size_t destsize = uncompressed.size() + uncompressed.size()/10 + 16;

	// w000t w000t kat000t for gzipped packets
	WorldPacket data(RCMSG_ACCOUNT_CHARACTER_MAPPING_REPLY, destsize + 4);
	data.resize(destsize + 4);

	z_stream stream;
	stream.zalloc = 0;
	stream.zfree  = 0;
	stream.opaque = 0;

	if(deflateInit(&stream, 1) != Z_OK)
	{
		OUT_DEBUG(DEFLATEINITAI);
		return;
	}

	// set up stream pointers
	stream.next_out  = (Bytef*)((uint8*)data.contents())+4;
	stream.avail_out = (uInt)destsize;
	stream.next_in   = (Bytef*)uncompressed.contents();
	stream.avail_in  = (uInt)uncompressed.size();

	// call the actual process
	if(deflate(&stream, Z_NO_FLUSH) != Z_OK ||
		stream.avail_in != 0)
	{
		OUT_DEBUG(DELETETINITAI);
		return;
	}

	// finish the deflate
	if(deflate(&stream, Z_FINISH) != Z_STREAM_END)
	{
		OUT_DEBUG(DELETESINITAI);
		return;
	}

	// finish up
	if(deflateEnd(&stream) != Z_OK)
	{
		OUT_DEBUG(DELETESIXCCAI);
		return;
	}

	*(uint32*)data.contents() = (uint32)uncompressed.size();
	data.resize(stream.total_out + 4);
	SendPacket(&data,false);
}

void LogonCommClientSocket::HandleDisconnectAccount(WorldPacket & recvData)
{
	uint32 id;
	recvData >> id;

	WorldSession * sess = sWorld.FindSession(id);
	if(sess != NULL)
		sess->Disconnect();
}

void ConsoleAuthCallback(uint32 request, uint32 result);
void LogonCommClientSocket::HandleConsoleAuthResult(WorldPacket & recvData)
{
	uint32 requestid, result;
	recvData >> requestid >> result;

	ConsoleAuthCallback(requestid, result);
}

void LogonCommClientSocket::HandlePopulationRequest(WorldPacket & recvData)
{
	uint32 realmId;
	// Grab the realm id
	recvData >> realmId;
	// Get online characters in realm
	uint32 chrCount =
		Database_Character->QueryNA("SELECT COUNT(guid) FROM characters WHERE online = 1;")->Fetch()[0].GetInt32();
	// Get realm player limit
	uint32 pLimit =
		Config.MainConfig.GetIntDefault("Server", "PlayerLimit", 5000);
	// Calc pop: 0 = low, 1 = med, 2 = hig, 3 = full
	float population = float((chrCount * 3) / pLimit);
	// Send the result
	WorldPacket data(RCMSG_REALM_POP_RES, 16);
	data << realmId << population;
	SendPacket(&data, false);
}

void LogonCommClientSocket::HandleServerPing(WorldPacket &recvData)
{
	uint32 r;
	recvData >> r;

	WorldPacket data(RCMSG_SERVER_PONG, 4);
	data << r;
	SendPacket(&data, false);
}

#else
void LogonCommHandler::LogonDatabaseReloadAccounts()
{
}

void LogonCommHandler::LogonDatabaseSQLExecute(const char* str, ...)
{
}

void LogonCommHandler::Startup()
{
}

void LogonCommHandler::UpdateAccountCount(uint32 account_id, uint8 add)
{
}

void LogonCommHandler::UpdateSockets()
{
}

LogonCommHandler::LogonCommHandler()
{
}

LogonCommHandler::~LogonCommHandler()
{
}

#endif