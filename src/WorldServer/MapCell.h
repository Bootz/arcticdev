/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2010 Arctic Server Team
 * See COPYING for license details.
 */

//
// MapCell.h
//

#ifndef __MAP_CELL_H
#define __MAP_CELL_H

class Map;

#define MAKE_CELL_EVENT(x,y) ( ((x) * 1000) + 200 + y )
#define DECODE_CELL_EVENT(dest_x, dest_y, ev) (dest_x) = ((ev-200)/1000); (dest_y) = ((ev-200)%1000);

class SERVER_DECL MapCell
{
	friend class MapMgr;
public:
	MapCell();
	~MapCell();

	//����������� � ���������� ��� ������������ ����� � ��������
	void *operator new(size_t);
	void operator delete(void*);

	typedef unordered_set<ObjectPointer > ObjectSet;

	//Init
	void Init(uint32 x, uint32 y, uint32 mapid, MapMgrPointer mapmgr);

	ARCTIC_INLINE void AquireLock(){ m_objectlock.Acquire(); } 
 	ARCTIC_INLINE void ReleaseLock(){ m_objectlock.Release(); } 

	//Object Managing
	void AddObject(ObjectPointer obj); 
	void RemoveObject(ObjectPointer obj);
	bool HasObject(ObjectPointer obj) { return (_objects.find(obj) != _objects.end()); }
	bool HasPlayers() { return ((_playerCount > 0) ? true : false); }
	ARCTIC_INLINE size_t GetObjectCount() { return _objects.size(); }
	void RemoveObjects();
	ARCTIC_INLINE ObjectSet::iterator Begin() { return _objects.begin(); }
	ARCTIC_INLINE ObjectSet::iterator End() { return _objects.end(); }

	//State Related
	void SetActivity(bool state);

	ARCTIC_INLINE bool IsActive() { return _active; }
	ARCTIC_INLINE bool IsLoaded() { return _loaded; }

	//Object Loading Managing
	void LoadObjects(CellSpawns * sp);
	ARCTIC_INLINE uint32 GetPlayerCount() { return _playerCount; }

	//Events System
	void RemoveEventIdObjects(uint8 eventToRemove);
	void ModifyEventIdSetting(bool active, uint8 eventId);
	void LoadEventIdObjects(CellSpawns * sp, uint8 eventId);

	ARCTIC_INLINE bool IsUnloadPending() { return _unloadpending; }
	ARCTIC_INLINE void SetUnloadPending(bool up) { _unloadpending = up; }
	void QueueUnloadPending();
	void CancelPendingUnload();
	void Unload();

	void SetPermanentActivity(bool val) { _forcedActive = val; }
	bool IsForcedActive() { return _forcedActive; }

	uint16 GetPositionX() { return _x; }
	uint16 GetPositionY() { return _y; }

	ObjectSet _respawnObjects;

private:
	bool _forcedActive;
	uint16 _x,_y;
	ObjectSet _objects;
	bool _active, _loaded;
	bool _unloadpending;

	uint16 _playerCount;
	MapMgrPointer _mapmgr;

	Mutex m_objectlock;
};

#endif