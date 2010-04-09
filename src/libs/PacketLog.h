/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

#ifndef WOWARCTICSERVER_PACKETLOG_H
#define WOWARCTICSERVER_PACKETLOG_H

#include "Common.h"
#include "Singleton.h"
#include "RealmPacket.h"
#include "WorldPacket.h"

class PacketLog
{
    public:
        PacketLog();
        ~PacketLog();

        int hextoint(char c);
        char makehexchar(int i);

        void HexDump(const unsigned char* data, size_t length, const char* file);
        void HexDump(const char *data, size_t length, const char* file);
        void HexDumpStr(const char *msg, const char *data, size_t len, const char* file);

        void RealmHexDump(RealmPacket * data, uint32 socket, bool direction);

        void WorldHexDump(WorldPacket * data, uint32 socket, bool direction);
};

#define sPacketLog PacketLog::getSingleton()

#endif