/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

/* Class InstanceScript
 * Instanced class created for each instance of the map, holds all 
 * scriptable exports
 */

/* Class MapScriptInterface
 * Provides an interface to mapmgr for scripts, to obtain objects,
 * get players, etc.
 */

#include "StdAfx.h"
createFileSingleton(StructFactory);

//����������� � ���������� ��� ������������ ����� � ��������
void *MapScriptInterface::operator new(size_t size)
{
	sLog.outDebug("New MapScriptInterface dynamic string in object.");
	return malloc(size);
}

void MapScriptInterface::operator delete(void* p)
{
	sLog.outDebug("Delete MapScriptInterface dynamic string in object.");
	free(p);
}

MapScriptInterface::MapScriptInterface(MapMgrPointer mgr)
{
	mapMgr = mgr;
}

MapScriptInterface::~MapScriptInterface()
{
	mapMgr->ScriptInterface = 0;
}

uint32 MapScriptInterface::GetPlayerCountInRadius(float x, float y, float z /* = 0.0f */, float radius /* = 5.0f */)
{
	// use a cell radius of 2
	uint32 PlayerCount = 0;
	uint32 cellX = mapMgr->GetPosX(x);
	uint32 cellY = mapMgr->GetPosY(y);

	uint32 endX = cellX < _sizeX ? cellX + 1 : _sizeX;
	uint32 endY = cellY < _sizeY ? cellY + 1 : _sizeY;
	uint32 startX = cellX > 0 ? cellX - 1 : 0;
	uint32 startY = cellY > 0 ? cellY - 1 : 0;
	MapCell * pCell;
	ObjectSet::iterator iter, iter_end;

	for(uint32 cx = startX; cx < endX; ++cx)
	{
		for(uint32 cy = startY; cy < endY; ++cy)
		{
			pCell = mapMgr->GetCell(cx, cy);
			if(pCell == 0 || pCell->GetPlayerCount() == 0)
				continue;

			iter = pCell->Begin();
			iter_end = pCell->End();

			for(; iter != iter_end; ++iter)
			{
				if((*iter)->GetTypeId() == TYPEID_PLAYER &&
					(*iter)->CalcDistance(x, y, (z == 0.0f ? (*iter)->GetPositionZ() : z)) < radius)
				{
					++PlayerCount;
				}
			}
		}
	}

	return PlayerCount;
}

GameObjectPointer MapScriptInterface::SpawnGameObject(uint32 Entry, float cX, float cY, float cZ, float cO, bool AddToWorld, uint32 Misc1, uint32 Misc2)
{
	GameObjectPointer pGameObject = mapMgr->CreateGameObject(Entry);
	if(pGameObject == NULL || !pGameObject->CreateFromProto(Entry, mapMgr->GetMapId(), cX, cY, cZ, cO, 0.0f, 0.0f, 0.0f, 0.0f))
		return NULLGOB;

	pGameObject->SetInstanceID(mapMgr->GetInstanceID());
	pGameObject->SetPhase(1);

	if(AddToWorld)
		pGameObject->PushToWorld(mapMgr);

	return pGameObject;
}

CreaturePointer MapScriptInterface::SpawnCreature(uint32 Entry, float cX, float cY, float cZ, float cO, bool AddToWorld, bool tmplate, uint32 Misc1, uint32 Misc2)
{
	CreatureProto * proto = CreatureProtoStorage.LookupEntry(Entry);
	CreatureInfo * info = CreatureNameStorage.LookupEntry(Entry);
	if(proto == 0 || info == 0)
	{
		return NULLCREATURE;
	}

	CreatureSpawn * sp = new CreatureSpawn;
	sp->entry = Entry;
	sp->form = 0;
	sp->id = 0;
	sp->movetype = 0;
	sp->x = cX;
	sp->y = cY;
	sp->z = cZ;
	sp->o = cO;
	sp->emote_state =0;
	sp->flags = 0;
	sp->factionid = proto->Faction;
	sp->bytes=0;
	sp->bytes1=0;
	sp->bytes2=0;
	sp->displayid=0;
	sp->stand_state = 0;
	sp->channel_spell=sp->channel_target_creature=sp->channel_target_go=0;
	sp->MountedDisplayID = 0;
	sp->phase = 1;
	sp->vehicle = proto->vehicle_entry;

	CreaturePointer p = this->mapMgr->CreateCreature(Entry);
	ASSERT(p);
	p->Load(sp, (uint32)NULL, NULL);
	p->spawnid = 0;
	p->m_spawn = NULL;
	delete sp;

	if( AddToWorld )
		p->PushToWorld(mapMgr);

	return p;
}

void MapScriptInterface::DeleteCreature(CreaturePointer ptr)
{
	ptr->Destructor();
	ptr = NULLCREATURE;
}

void MapScriptInterface::DeleteGameObject(GameObjectPointer ptr)
{
	ptr->Destructor();
	ptr = NULLGOB;
}

WayPoint * StructFactory::CreateWaypoint()
{
	return new WayPoint;
}