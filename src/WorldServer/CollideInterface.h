/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

#ifndef _COLLIDEINTERFACE_H
#define _COLLIDEINTERFACE_H

// Imports.
#define NO_WMO_HEIGHT -100000.0f

extern VMAP::IVMapManager* CollisionMgr;

class ARCTIC_DECL CCollideInterface
{
public:
	void Init();
	void DeInit();

	void ActivateTile(uint32 mapId, uint32 tileX, uint32 tileY);
	void DeactivateTile(uint32 mapId, uint32 tileX, uint32 tileY);
	void ActivateMap(uint32 mapId);
	void DeactivateMap(uint32 mapId);

	bool CheckLOS(uint32 mapId, float x1, float y1, float z1, float x2, float y2, float z2);
	bool GetFirstPoint(uint32 mapId, float x1, float y1, float z1, float x2, float y2, float z2, float & outx, float & outy, float & outz, float distmod);
	bool IsIndoor(uint32 mapId, float x, float y, float z);
	bool IsOutdoor(uint32 mapId, float x, float y, float z);
	float GetHeight(uint32 mapId, float x, float y, float z);
};

extern ARCTIC_DECL CCollideInterface CollideInterface;

#endif
