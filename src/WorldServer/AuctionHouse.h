/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

#ifndef AUCTIONHOUSE_H
#define AUCTIONHOUSE_H

enum AuctionRemoveType
{
	AUCTION_REMOVE_EXPIRED,
	AUCTION_REMOVE_WON,
	AUCTION_REMOVE_CANCELLED,
};
enum AUCTIONRESULT
{
	AUCTION_CREATE,
	AUCTION_CANCEL,
	AUCTION_BID,
	AUCTION_BUYOUT,
};
enum AUCTIONRESULTERROR
{
	AUCTION_ERROR_NONE,
	AUCTION_ERROR_UNK1,
	AUCTION_ERROR_INTERNAL,
	AUCTION_ERROR_MONEY,
	AUCTION_ERROR_ITEM,
};
enum AuctionMailResult
{
	AUCTION_OUTBID,
	AUCTION_WON,
	AUCTION_SOLD,
	AUCTION_EXPIRED,
	AUCTION_EXPIRED2,
	AUCTION_CANCELLED,
};

struct Auction
{
	uint32 Id;
	
	uint32 Owner;
	uint32 HighestBidder;
	uint32 HighestBid;
	
	uint32 BuyoutPrice;
	uint32 DepositAmount;
	
	uint32 ExpiryTime;
	ItemPointer pItem;

	void DeleteFromDB();
	void SaveToDB(uint32 AuctionHouseId);
	void UpdateInDB();
	void AddToPacket(WorldPacket & data);
	bool Deleted;
	uint32 DeletedReason;
};

class AuctionHouse
{
public:
	AuctionHouse(uint32 ID);
	~AuctionHouse();

	//����������� � ���������� ��� ������������ ����� � ��������
	void *operator new(size_t);
	void operator delete(void*);

	ARCTIC_INLINE uint32 GetID() { return dbc->id; }
	void LoadAuctions();

	void UpdateAuctions();
	void UpdateDeletionQueue();

	void RemoveAuction(Auction * auct);
	void AddAuction(Auction * auct);
	Auction * GetAuction(uint32 Id);
	void QueueDeletion(Auction * auct, uint32 Reason);

	void SendOwnerListPacket(PlayerPointer plr, WorldPacket * packet);
	void SendBidListPacket(PlayerPointer plr, WorldPacket * packet);
	void SendAuctionNotificationPacket(PlayerPointer plr, Auction * auct);
	void SendAuctionList(PlayerPointer plr, WorldPacket * packet);

	void UpdateItemOwnerships(uint32 oldGuid, uint32 newGuid);

private:
	RWLock itemLock;
	HM_NAMESPACE::hash_map<uint64, ItemPointer > auctionedItems;

	RWLock auctionLock;
	HM_NAMESPACE::hash_map<uint32, Auction*> auctions;

	Mutex removalLock;
	list<Auction*> removalList;

	AuctionHouseDBC * dbc;

public:
	float cut_percent;
	float deposit_percent;
};
#endif
