/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

#ifndef _ITEMINTERFACE_H
#define _ITEMINTERFACE_H

#define INVALID_BACKPACK_SLOT ((int8)(0xFF)) // In 1.8 client marked wrong slot like this

struct SlotResult
{
	SlotResult() { ContainerSlot = -1, Slot = -1, Result = false; }
	int16 ContainerSlot;
	int16 Slot;
	bool Result;
};

class Item;
class Container;
class Player;
class UpdateData;
class ByteBuffer;

enum CanAffordItem
{
	CAN_AFFORD_ITEM_ERROR_OK = 0,
	CAN_AFFORD_ITEM_ERROR_CURRENTLY_SOLD_OUT = 1,
	CAN_AFFORD_ITEM_ERROR_DONT_HAVE_ENOUGH_MONEY = 2,
	CAN_AFFORD_ITEM_ERROR_NOT_FOUND = 3,
	CAN_AFFORD_ITEM_ERROR_DOESNT_LIKE_YOU = 4,
	CAN_AFFORD_ITEM_ERROR_TOO_FAR_AWAY = 5,
	CAN_AFFORD_ITEM_ERROR_NO_MESSAGE = 6,
	CAN_AFFORD_ITEM_ERROR_CANT_CARRY_ANY_MORE = 8,
	CAN_AFFORD_ITEM_ERROR_NOT_REQUIRED_RANK = 11,
	CAN_AFFORD_ITEM_ERROR_REPUTATION = 12,
};

// sanity checking
enum AddItemResult
{
	ADD_ITEM_RESULT_ERROR = 0,
	ADD_ITEM_RESULT_OK = 1,
	ADD_ITEM_RESULT_DUPLICATED = 2,
};

class ARCTIC_DECL ItemInterface
{
private:
	SlotResult result;
	Player* m_pOwner;
	Item* m_pItems[MAX_INVENTORY_SLOT];
	Item* m_pBuyBack[MAX_BUYBACK_SLOT];

	AddItemResult m_AddItem(Item* item, int16 ContainerSlot, int16 slot);

public:
	friend class ItemIterator;
	ItemInterface( Player* pPlayer );
	~ItemInterface();

	Player* GetOwner() { return m_pOwner; }
	bool IsBagSlot(int16 slot);

	uint32 m_CreateForPlayer(ByteBuffer *data);
	void m_DestroyForPlayer();

	void mLoadItemsFromDatabase(QueryResult * result);
	void mSaveItemsToDatabase(bool first, QueryBuffer * buf);

	Item* GetInventoryItem(int16 slot);
	Item* GetInventoryItem(int16 ContainerSlot, int16 slot);
	int16 GetInventorySlotById(uint32 ID);
	int16 GetInventorySlotByGuid(uint64 guid);
	int16 GetInventorySlotByGuid2(uint64 guid);
	int16 GetBagSlotByGuid(uint64 guid);

	Item* SafeAddItem(uint32 ItemId, int16 ContainerSlot, int16 slot);
	AddItemResult SafeAddItem(Item* pItem, int16 ContainerSlot, int16 slot);
	Item* SafeRemoveAndRetreiveItemFromSlot(int16 ContainerSlot, int16 slot, bool destroy); //doesnt destroy item from memory
	Item* SafeRemoveAndRetreiveItemByGuid(uint64 guid, bool destroy);
	Item* SafeRemoveAndRetreiveItemByGuidRemoveStats(uint64 guid, bool destroy);
	bool SafeFullRemoveItemFromSlot(int16 ContainerSlot, int16 slot); //destroys item fully
	bool SafeFullRemoveItemByGuid(uint64 guid); //destroys item fully
	AddItemResult AddItemToFreeSlot(Item* item);
	AddItemResult AddItemToFreeBankSlot(Item* item);
	
	/* Finds a stack that didn't reach max capacity
	 * param itemid The entry of the item to search for
	 * param cnt The item count you wish to add to the stack
	 * param IncBank Should this search the player's bank as well?
	 * return An Item* to a stack of itemid which can contain cnt more items
	 */

	Item* FindItemLessMax(uint32 itemid, uint32 cnt, bool IncBank);
	uint32 GetItemCount(uint32 itemid, bool IncBank = false);
	uint32 RemoveItemAmt(uint32 id, uint32 amt);
	uint32 RemoveItemAmt_ProtectPointer(uint32 id, uint32 amt, Item** pointer);
	uint32 RemoveItemAmtByGuid(uint64 guid, uint32 amt);
	void RemoveAllConjured();
	void BuyItem(ItemPrototype *item, uint32 total_amount, Creature* pVendor, ItemExtendedCostEntry *ec);

	uint32 CalculateFreeSlots(ItemPrototype *proto);
	void ReduceItemDurability();

	uint16 LastSearchItemBagSlot(){return result.ContainerSlot;}
	uint16 LastSearchItemSlot(){return result.Slot;}
	SlotResult *LastSearchResult(){return &result;}

	// Searching functions
	SlotResult FindFreeInventorySlot(ItemPrototype *proto);
	SlotResult FindFreeBankSlot(ItemPrototype *proto);
	SlotResult FindAmmoBag();
	int16 FindFreeBackPackSlot();
	int16 FindFreeKeyringSlot();
	int16 FindSpecialBag(Item* item);

	int16 CanEquipItemInSlot(int16 DstInvSlot, int16 slot, ItemPrototype* item, bool ignore_combat = false, bool skip_2h_check = false);
	int8 CanReceiveItem(ItemPrototype * item, uint32 amount, ItemExtendedCostEntry *ec);
	int8 CanAffordItem(ItemPrototype * item,uint32 amount, Creature* pVendor, ItemExtendedCostEntry *ec);
	int8 GetItemSlotByType(uint32 type);
	Item* GetItemByGUID(uint64 itemGuid);

	void BuildInventoryChangeError(Item* SrcItem, Item* DstItem, uint8 Error);
	bool SwapItemSlots(int16 srcslot, int16 dstslot);

	int16 GetInternalBankSlotFromPlayer(int16 islot); //converts inventory slots into 0-x numbers
	// Checks if the player has slotted an item with an item ID
	bool HasGemEquipped( uint32 GemID , int8 IgnoreSlot = -1 ); // (GemID: The item ID of the gem)

	// buyback stuff
	ARCTIC_INLINE Item* GetBuyBack(int32 slot) 
	{ 
		if(slot >= 0 && slot <= 12)
			return m_pBuyBack[slot];
		else 
			return NULLITEM;
	}
	void AddBuyBackItem(Item* it, uint32 price);
	void RemoveBuyBackItem(uint32 index);
	void EmptyBuyBack();
	bool IsEquipped(uint32 itemid);

	void CheckAreaItems();

	uint32 GetItemCountByLimitId(uint32 LimitId, bool IncBank);
	uint32 GetEquippedCountByItemLimit(uint32 LimitId); 

public:
	ARCTIC_INLINE bool VerifyBagSlots(int16 ContainerSlot, int16 Slot)
	{
		if( ContainerSlot < -1 || Slot < 0 )
			return false;

		if( ContainerSlot > 0 && (ContainerSlot < INVENTORY_SLOT_BAG_START || ContainerSlot >= INVENTORY_SLOT_BAG_END) )
			return false;

		if( ContainerSlot == -1 && (Slot >= INVENTORY_SLOT_ITEM_END  || Slot <= EQUIPMENT_SLOT_END) )
			return false;
			
		return true;
	}

	bool AddItemById(uint32 itemid, uint32 count, int32 randomprop, bool created);

	ARCTIC_INLINE bool VerifyBagSlotsWithBank(int16 ContainerSlot, int16 Slot)
	{
		if( ContainerSlot < -1 || Slot < 0 )
			return false;

		if( ContainerSlot > 0 && (ContainerSlot < INVENTORY_SLOT_BAG_START || ContainerSlot >= INVENTORY_SLOT_BAG_END) )
			return false;

		if( ContainerSlot == -1 && (Slot >= MAX_INVENTORY_SLOT || Slot <= EQUIPMENT_SLOT_END) )
			return false;

		return true;
	}

	ARCTIC_INLINE bool VerifyBagSlotsWithInv(int16 ContainerSlot, int16 Slot)
	{
		if( ContainerSlot < -1 || Slot < 0 )
			return false;

		if( ContainerSlot > 0 && (ContainerSlot < INVENTORY_SLOT_BAG_START || ContainerSlot >= INVENTORY_SLOT_BAG_END) )
			return false;

		if( ContainerSlot == -1 && Slot >= MAX_INVENTORY_SLOT )
			return false;

		return true;
	}
};

class ItemIterator
{
	bool m_atEnd;
	bool m_searchInProgress;
	uint32 m_slot;
	uint32 m_containerSlot;
	Container* m_container;
	Item* m_currentItem;
	ItemInterface* m_target;
public:
	ItemIterator(ItemInterface* target) : m_atEnd(false),m_searchInProgress(false),m_slot(0),m_containerSlot(0),m_container(NULLCONTAINER),m_target(target) {}
	~ItemIterator() { if(m_searchInProgress) { EndSearch(); } }

	void BeginSearch()
	{
		// iteminterface doesn't use mutexes, maybe it should :P
		ASSERT(!m_searchInProgress);
		m_atEnd=false;
		m_searchInProgress=true;
		m_container=NULLCONTAINER;
		m_currentItem=NULLITEM;
		m_slot=0;
		Increment();
	}

	void EndSearch()
	{
		// nothing here either
		ASSERT(m_searchInProgress);
		m_atEnd=true;
		m_searchInProgress=false;
	}

	Item* operator*() const
	{
		return m_currentItem;
	}

	Item* operator->() const
	{
		return m_currentItem;
	}

	void Increment()
	{
		if(!m_searchInProgress)
			BeginSearch();

		// are we currently inside a container?
		if(m_container != NULL)
		{
			// loop the container.
			for(; m_containerSlot < m_container->GetProto()->ContainerSlots; ++m_containerSlot)
			{
				m_currentItem = m_container->GetItem(m_containerSlot);
				if(m_currentItem != NULL)
				{
					// increment the counter so we don't get the same item again
					++m_containerSlot;

					// exit
					return;
				}
			}

			// unset this
			m_container=NULLCONTAINER;
		}

		for(; m_slot < MAX_INVENTORY_SLOT; ++m_slot)
		{
			if(m_target->m_pItems[m_slot])
			{
				if(m_target->m_pItems[m_slot]->IsContainer())
				{
					// we are a container :O lets look inside the box!
					m_container = TO_CONTAINER(m_target->m_pItems[m_slot]);
					m_containerSlot = 0;

					// clear the pointer up. so we can tell if we found an item or not
					m_currentItem = NULLITEM;

					// increment m_slot so we don't search this container again
					++m_slot;

					// call increment() recursively. this will search the container.
					Increment();

					// jump out so we're not wasting cycles and skipping items
					return;
				}

				// we're not a container, just a regular item
				// set the pointer
				m_currentItem = m_target->m_pItems[m_slot];

				// increment the slot counter so we don't do the same item again
				++m_slot;

				// jump out
				return;
			}
		}

		// if we're here we've searched all items.
		m_atEnd = true;
		m_currentItem = NULLITEM;
	}

	ARCTIC_INLINE Item* Grab() { return m_currentItem; }
	ARCTIC_INLINE bool End() { return m_atEnd; }
};

#endif
