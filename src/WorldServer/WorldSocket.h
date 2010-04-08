/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

// Class WorldSocket - Main network code functions, handles
// reading/writing of all packets.

#ifndef __WORLDSOCKET_H
#define __WORLDSOCKET_H

/* Normal WorldSocket when not using clustering */
#ifndef CLUSTERING

#define WORLDSOCKET_SENDBUF_SIZE 131078
#define WORLDSOCKET_RECVBUF_SIZE 16384

class WorldPacket;
class SocketHandler;
class WorldSession;

enum OUTPACKET_RESULT
{
	OUTPACKET_RESULT_SUCCESS = 1,
	OUTPACKET_RESULT_NO_ROOM_IN_BUFFER = 2,
	OUTPACKET_RESULT_NOT_CONNECTED = 3,
	OUTPACKET_RESULT_SOCKET_ERROR = 4,
};

class ARCTIC_DECL WorldSocket : public Socket
{
public:
	WorldSocket(SOCKET fd);
	~WorldSocket();

	// vs8 fix - send null on empty buffer
	ARCTIC_INLINE void SendPacket(WorldPacket* packet) { if(!packet) return; OutPacket(packet->GetOpcode(), packet->size(), (packet->size() ? (const void*)packet->contents() : NULL)); }
	ARCTIC_INLINE void SendPacket(StackPacket * packet) { if(!packet) return; OutPacket(packet->GetOpcode(), packet->GetSize(), (packet->GetSize() ? (const void*)packet->GetBufferPointer() : NULL)); }

	void __fastcall OutPacket(uint16 opcode, size_t len, const void* data);
	OUTPACKET_RESULT __fastcall _OutPacket(uint16 opcode, size_t len, const void* data);
   
	ARCTIC_INLINE uint32 GetLatency() { return _latency; }

	void Authenticate();
	void InformationRetreiveCallback(WorldPacket & recvData, uint32 requestid);

	void __fastcall UpdateQueuePosition(uint32 Position);

	void OnRead();
	void OnConnect();
	void OnDisconnect();

	ARCTIC_INLINE void SetSession(WorldSession * session) { mSession = session; }
	ARCTIC_INLINE WorldSession * GetSession() { return mSession; }
	bool Authed;

	void UpdateQueuedPackets();
	
protected:
	void _HandleAuthSession(WorldPacket* recvPacket);
	void _HandlePing(WorldPacket* recvPacket);

private:
	uint8 K[40];
	uint32 mOpcode;
	uint32 mRemaining;
	uint32 mSize;
	uint32 mSeed;
	uint32 mClientSeed;
	uint32 mClientBuild;
	uint32 mRequestID;

	WorldSession * mSession;
	WorldPacket * pAuthenticationPacket;
	FastQueue<WorldPacket*, DummyLock> _queue;
	Mutex queueLock;

	WowCrypt _crypt;
	uint32 _latency;
	bool mQueued;
	bool m_nagleEanbled;
	string * m_fullAccountName;
};

#endif

void FastGUIDPack(ByteBuffer & buf, const uint64 & oldguid);
void FastGUIDPack(StackBuffer & buf, const uint64 & oldguid);

// warning. This presumes that all guids can be compressed at least 1 byte
// make sure you choose highguids acordingly
unsigned int FastGUIDPack(const uint64 & oldguid, unsigned char * buffer, uint32 pos);

// Modified/Simplified WorldSocket for use with clustering
#ifdef CLUSTERING
class WorldSocket
{
public:
	WorldSocket(uint32 sessionid);
	~WorldSocket();

	void Disconnect();
	bool IsConnected();
	ARCTIC_INLINE string GetRemoteIP() { return string(inet_ntoa(m_address.sin_addr)); }
	ARCTIC_INLINE uint32 GetRemotePort() { return ntohs(m_address.sin_port); }

	ARCTIC_INLINE void SendPacket(WorldPacket* packet) { if(!packet) return; OutPacket(packet->GetOpcode(), (uint16)packet->size(), (packet->size() ? (const void*)packet->contents() : NULL)); }
	ARCTIC_INLINE void SendPacket(StackPacket * packet) { if(!packet) return; OutPacket(packet->GetOpcode(), packet->GetSize(), (packet->GetSize() ? (const void*)packet->GetBufferPointer() : NULL)); }
	void __fastcall OutPacket(uint16 opcode, uint16 len, const void* data);
	ARCTIC_INLINE uint32 GetSessionId() { return m_sessionId; }

protected:
	uint32 m_sessionId;
	sockaddr_in m_address;
};

#endif
#endif
