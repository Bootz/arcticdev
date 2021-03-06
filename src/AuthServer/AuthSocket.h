/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2012 Arctic Server Team
 * See COPYING for license details.
 */

#pragma once

#include "AccountCache.h"
#include "AuthStructs.h"

class LogonCommServerSocket;
struct Patch;
class PatchJob;

class AuthSocket : public Socket
{
	friend class LogonCommServerSocket;
public:

	///////////////////////////////////////////////////
	// Netcore shit
	///////////////////////////////////////////////////

	AuthSocket(SOCKET fd);
	~AuthSocket();

	void OnRead();

	///////////////////////////////////////////////////
	// Client Packet Handlers
	///////////////////////////////////////////////////

	void HandleChallenge();
	void HandleProof();
	void HandleRealmlist();
	void HandleReconnectChallenge();
	void HandleReconnectProof();
	void HandleTransferAccept();
	void HandleTransferResume();
	void HandleTransferCancel();

	///////////////////////////////////////////////////
	// Server Packet Builders
	///////////////////////////////////////////////////

	void SendChallengeError(uint8 Error);
	void SendProofError(uint8 Error, uint8 * M2);
	ARCTIC_INLINE sAuthLogonChallenge_C * GetChallenge() { return &m_challenge; }
	ARCTIC_INLINE void SendPacket(const uint8* data, const uint16 len) { Send(data, len); }
	void OnDisconnect();
	ARCTIC_INLINE time_t GetLastRecv() { return last_recv; }
	bool removedFromSet;
	ARCTIC_INLINE uint32 GetAccountID() { return m_account ? m_account->AccountId : 0; }

protected:

	sAuthLogonChallenge_C m_challenge;
	Account * m_account;
	bool m_authenticated;
	std::string AccountName;

	///////////////////////////////////////////////////
	// Authentication BigNumbers
	///////////////////////////////////////////////////

	BigNumber N, s, g, v;
	BigNumber b, B;
	BigNumber K;
	BigNumber rs;

	///////////////////////////////////////////////////
	// Session Key
	///////////////////////////////////////////////////

	BigNumber m_sessionkey;
	time_t last_recv;

	///////////////////////////////////////////////////
	// Patching stuff
	///////////////////////////////////////////////////
public:
	Patch * m_patch;
	PatchJob * m_patchJob;
};
