/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

#ifndef _CHAIN_AGRO_ENTITY_H
#define _CHAIN_AGRO_ENTITY_H

// Class used to link multiple monsters together for agro.
class SERVER_DECL ChainAggroEntity
{
	friend class AIInterface;

private:
	set<CreaturePointer> m_agroEntitySet;
public:
	ChainAggroEntity(CreaturePointer pOwner);
	~ChainAggroEntity();

	//����������� � ���������� ��� ������������ ����� � ��������
	void *operator new(size_t);
	void operator delete(void*);

	static ChainAggroEntity* Create(CreaturePointer pCreature) { return new ChainAggroEntity(pCreature); }

	void AddAggroEntity(CreaturePointer pCreature);
	void RemoveAggroEntity(CreaturePointer pCreature);

	void Delete();

	void EventEnterCombat(UnitPointer pTarget);
};


#endif