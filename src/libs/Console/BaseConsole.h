/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2012 Arctic Server Team
 * See COPYING for license details.
 */

#ifndef _BASECONSOLE_LIB
#define _BASECONSOLE_LIB

class BaseConsole
{
public:
	virtual ~BaseConsole() {}
	virtual void Write(const char * Format, ...) = 0;
	virtual void WriteNA(const char * Format) = 0;
};

class LocalConsole : public BaseConsole
{
public:
	void Write(const char * Format, ...);
	void WriteNA(const char * Format);
};

void HandleConsoleInput(BaseConsole * pConsole, const char * szInput);

#endif
