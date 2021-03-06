/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2012 Arctic Server Team
 * See COPYING for license details.
 */

#ifndef _WOWCRYPT_H
#define _WOWCRYPT_H

#include <stdlib.h>
#include "../Common.h"
#include "HMAC.h"
#include "RC4Engine.h"
#include "BigNumber.h"
#include <vector>

class WowCrypt 
{
public:
	WowCrypt();
	~WowCrypt();

	void Init(uint8 *K);
	void DecryptRecv(uint8 * data, unsigned int len);
	void EncryptSend(uint8 * data, unsigned int len);

	bool IsInitialized() { return _initialized; }

private:
	bool _initialized;
	RC4Engine _Decrypt;
	RC4Engine _Encrypt;
};

#endif
