/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

#ifndef __FACTION_H
#define __FACTION_H

#include "Unit.h"
#define SANCTUARIES_NUM 2
static const uint32 SANCTUARY_ZONES[SANCTUARIES_NUM] =
{
	3703, /* Shattrath */
	4395  /* Dalaran   */
};

ARCTIC_DECL bool isHostile(ObjectPointer objA, ObjectPointer objB);                               // B is hostile for A?
ARCTIC_DECL bool isAttackable(ObjectPointer objA, ObjectPointer objB, bool CheckStealth = true);  // A can attack B?
ARCTIC_DECL bool isCombatSupport(ObjectPointer objA, ObjectPointer objB);                         // B combat supports A?;
ARCTIC_DECL bool isAlliance(ObjectPointer objA);                                                  // A is alliance?
ARCTIC_DECL bool isHostileNonPvP(ObjectPointer objA, ObjectPointer objB);                         // B is hostile for A? (without PvP flag check)

ARCTIC_INLINE bool isFriendly(ObjectPointer objA, ObjectPointer objB)                             // B is friendly to A if its not hostile
{
	return !isHostile(objA, objB);
}

ARCTIC_INLINE bool isSameFaction(ObjectPointer objA, ObjectPointer objB)
{
	// shouldn't be necessary but still
	if( objA->m_faction == NULL || objB->m_faction == NULL )
		return false;

	return (objB->m_faction->Faction == objA->m_faction->Faction);
}
ARCTIC_INLINE  PlayerPointer GetPlayerFromObject(ObjectPointer obj);  
#endif