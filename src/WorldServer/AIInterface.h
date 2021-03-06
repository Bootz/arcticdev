/*
 * Arctic MMORPG Server Software
 * Copyright (c) 2008-2012 Arctic Server Team
 * See COPYING for license details.
 */

#pragma once

#include "AchievementDefines.h"

#define UNIT_MOVEMENT_INTERPOLATE_INTERVAL 400 /*750*/ // ms smoother server/client side moving vs less cpu/ less b/w
#define TARGET_UPDATE_INTERVAL 600 // ms
#define PLAYER_SIZE 1.5f

#define ENABLE_CREATURE_DAZE
#ifdef ENABLE_CREATURE_DAZE
	#define CREATURE_SPELL_TO_DAZE 1604
	#define CREATURE_DAZE_TRIGGER_ANGLE M_PI/2 // for the beginners this means 45 degrees
#endif

class Object;
class Creature;
class Unit;
class Player;
class WorldSession;
class SpellCastTargets;

struct SpellEntry;

struct AI_Spell
{
	~AI_Spell() { autocast_type=(uint32)-1; }

	uint32 entryId;
	uint16 agent;
	uint32 procChance;
	uint32 procCount;
	SpellEntry * spell;
	uint8 spellType;
	uint8 spelltargetType;
	uint32 cooldown;
	uint32 cooldowntime;
	float floatMisc1;
	uint32 Misc2;

	uint32 procCounter;
	float minrange;
	float maxrange;
	int32 autocast_type;
	bool custom_pointer;
};

bool isGuard(uint32 id);
uint32 getGuardId(uint32 id);
bool isTargetDummy(uint32 id);
typedef unordered_map< Unit*, int32> TargetMap;
#ifdef USE_PACKED_MOVEMENT
typedef map<uint32, LocationVector> LocationVectorMap;
#endif
#ifdef WIN32
template <>
class hash < Unit* > : public unary_function< Unit*, size_t>
{
public:
	size_t operator()(Unit* __x) const
	{
		return (size_t)__x;
	}
};
#else
#ifdef TRHAX
namespace std
{
	namespace tr1
	{
		template <>
		class hash < Unit* > : public unary_function< Unit*, size_t>
		{
		public:
			size_t operator()(Unit* __x) const
			{
				return (size_t)__x;
			}
		};
	};
};

#endif // TRHAX
#endif // WIN32

typedef unordered_set< Unit* > AssistTargetSet;
typedef std::map<uint32, AI_Spell*> SpellMap;

class ChainAggroEntity;
class SERVER_DECL AIInterface
{
	public:
		AIInterface();
		~AIInterface();

		// Misc
		void Init(Unit* un, AIType at, MovementType mt);
		void Init(Unit* un, AIType at, MovementType mt, Unit* owner); // used for pets
		Unit* GetUnit() { return m_Unit; }
		Unit* GetPetOwner() { return m_PetOwner; }
		void DismissPet();
		void SetUnitToFollow(Unit* un) { UnitToFollow = un; };
		void SetUnitToFear(Unit* un)  { UnitToFear = un; };
		void SetFollowDistance(float dist) { FollowDistance = dist; };
		void SetUnitToFollowAngle(float angle) { m_fallowAngle = angle; }
		bool setInFront(Unit* target);
		ARCTIC_INLINE Unit* getUnitToFollow() { return UnitToFollow; }
		void setCreatureState(CreatureState state){ m_creatureState = state; }
		ARCTIC_INLINE uint8 getAIState() { return m_AIState; }
		ARCTIC_INLINE uint8 getAIType() { return m_AIType; }
		ARCTIC_INLINE uint8 getCurrentAgent() { return m_aiCurrentAgent; }
		void setCurrentAgent(AI_Agent agent) { m_aiCurrentAgent = agent; }
		uint32	getThreatByGUID(uint64 guid);
		uint32	getThreatByPtr(Unit* obj);
		Unit* GetMostHated();
		Unit* GetSecondHated();

		bool modThreatByGUID(uint64 guid, int32 mod);
		bool modThreatByPtr(Unit* obj, int32 mod);
		void RemoveThreatByPtr(Unit* obj);

		ARCTIC_INLINE AssistTargetSet GetAssistTargets() { return m_assistTargets; }
		ARCTIC_INLINE TargetMap *GetAITargets() { return &m_aiTargets; }
		void addAssistTargets(Unit* Friends);
		void ClearHateList();
		void WipeHateList();
		void WipeTargetList();
		bool taunt(Unit* caster, bool apply = true);
		Unit* getTauntedBy();
		bool GetIsTaunted();
		ARCTIC_INLINE size_t getAITargetsCount() { return m_aiTargets.size(); }
		ARCTIC_INLINE uint32 getOutOfCombatRange() { return m_outOfCombatRange; }
		void setOutOfCombatRange(uint32 val) { m_outOfCombatRange = val; }

		// Spell
		uint8 CastSpell(Unit* caster, SpellEntry *spellInfo, SpellCastTargets targets);
		SpellEntry *getSpellEntry(uint32 spellId);
		SpellCastTargets setSpellTargets(SpellEntry *spellInfo, Unit* target);
		AI_Spell *getSpell();
		void addSpellToList(AI_Spell *sp);
		// don't use this until i finish it !!
		void CancelSpellCast();

		// Event Handler
		void HandleEvent(uint32 event, Unit* pUnit, uint32 misc1);
		void OnDeath(Object* pKiller);
		void OnRespawn(Unit* unit); // We don't really need the unit anymore.
		void AttackReaction( Unit* pUnit, uint32 damage_dealt, uint32 spellId = 0);
		bool HealReaction(Unit* caster, Unit* victim, uint32 amount, SpellEntry * sp);
		void Event_Summon_Elemental(uint32 summon_duration, uint32 TotemEntry, int32 ResistanceType, uint8 Slot);

		// Update
		void Update(uint32 p_time);

		// Movement
		void SendMoveToPacket(float toX, float toY, float toZ, float toO, uint32 time, uint32 MoveFlags);
		// void SendMoveToSplinesPacket(std::list<Waypoint> wp, bool run);
		void MoveTo(float x, float y, float z, float o);
		uint32 getMoveFlags();
		void UpdateMove();
		void SendCurrentMove(Player* plyr/*uint64 guid*/);
		void StopMovement(uint32 time);
		uint32 getCurrentWaypoint() { return m_currentWaypoint; }
		void changeWayPointID(uint32 oldwpid, uint32 newwpid);
		bool addWayPoint(WayPoint* wp);
		bool saveWayPoints();
		bool showWayPoints(Player* pPlayer, bool Backwards);
		bool hideWayPoints(Player* pPlayer);
		WayPoint* getWayPoint(uint32 wpid);
		void deleteWayPoint(uint32 wpid);
		void deleteWaypoints();
		ARCTIC_INLINE bool hasWaypoints() { return m_waypoints!=NULL; }
		ARCTIC_INLINE void setMoveType(uint32 movetype) { m_moveType = movetype; }
		ARCTIC_INLINE uint32 getMoveType() { return m_moveType; }
		ARCTIC_INLINE void setMoveRunFlag(bool f) { m_moveRun = f; }
		ARCTIC_INLINE bool getMoveRunFlag() { return m_moveRun; }
		ARCTIC_INLINE void setCanMove(bool canmove) { m_canMove = canmove; }
		void setWaypointToMove(uint32 id) { m_currentWaypoint = id; }
		bool IsFlying();

		// Calculation
		float _CalcAggroRange(Unit* target);
		void _CalcDestinationAndMove( Unit* target, float dist);
		float _CalcCombatRange(Unit* target, bool ranged);
		float _CalcDistanceFromHome();
		uint32 _CalcThreat(uint32 damage, SpellEntry * sp, Unit* Attacker);

		void SetAllowedToEnterCombat(bool val) { m_AllowedToEnterCombat = val; }
		ARCTIC_INLINE bool GetAllowedToEnterCombat(void) { return m_AllowedToEnterCombat; }

		void CheckTarget(Unit* target);
		ARCTIC_INLINE void SetAIState(AI_State newstate) { m_AIState = newstate; }

		// Movement
		bool m_canMove;
		bool m_WayPointsShowing;
		bool m_WayPointsShowBackwards;
		uint32 m_currentWaypoint;
		bool m_moveBackward;
		uint32 m_moveType;
		bool m_moveRun;
		bool m_moveFly;
		bool m_moveSprint;
		CreatureState m_creatureState;
		size_t GetWayPointsCount()
		{
			if(m_waypoints && !m_waypoints->empty())
				return m_waypoints->size();
			else
				return 0;
		}
		bool m_canFlee;
		bool m_canCallForHelp;
		bool m_canRangedAttack;
		uint32 m_RangedAttackSpell;
		uint32 m_SpellSoundid;

		float m_FleeHealth;
		uint32 m_FleeDuration;
		float m_CallForHelpHealth;
		uint32 m_totemspelltimer;
		uint32 m_totemspelltime;
		SpellEntry * totemspell;

		ChainAggroEntity* m_ChainAgroSet;

		float m_sourceX, m_sourceY, m_sourceZ;
		uint32 m_totalMoveTime;
		ARCTIC_INLINE void AddStopTime(uint32 Time) { m_moveTimer += Time; }
		ARCTIC_INLINE void SetNextSpell(AI_Spell*sp) { m_nextSpell = sp; }
		ARCTIC_INLINE Unit* GetNextTarget() { return m_nextTarget; }
		ARCTIC_INLINE void SetNextTarget (Unit* nextTarget)
		{
			m_nextTarget = nextTarget;
			if(nextTarget)
			{
				m_Unit->SetTargetGUID(m_nextTarget->GetGUID());
#ifdef ENABLE_GRACEFULL_HIT
				have_graceful_hit = false;
#endif
			}
			else m_Unit->SetTargetGUID(0);
		}

		Creature* m_formationLinkTarget;
		float m_formationFollowDistance;
		float m_formationFollowAngle;
		uint32 m_formationLinkSqlId;

		void WipeReferences();
		WayPointMap *m_waypoints;
		ARCTIC_INLINE void SetPetOwner(Unit* owner) { m_PetOwner = owner; }

		list<AI_Spell*> m_spells;

		bool disable_combat;

		bool disable_melee;
		bool disable_ranged;
		bool disable_spell;
		bool disable_targeting;

		bool waiting_for_cooldown;

		uint32 next_spell_time;

		void CheckNextSpell(AI_Spell*sp)
		{
			if(m_nextSpell == sp)
				m_nextSpell = 0;
		}

		void ResetProcCounts();

		ARCTIC_INLINE void SetWaypointMap(WayPointMap * m) { m_waypoints = m; }
		bool m_isGuard;
		void CallGuards();
		void setGuardTimer(uint32 timer) { m_guardTimer = timer; }
		uint32 m_guardCallTimer;
		void _UpdateCombat(uint32 p_time);

	protected:
		bool m_AllowedToEnterCombat;

		// Update
		void _UpdateTargets();
		void _UpdateMovement(uint32 p_time);
		void _UpdateTimer(uint32 p_time);
		int m_updateAssist;
		int m_updateTargets;
		uint32 m_updateAssistTimer;
		uint32 m_updateTargetsTimer;

		// Misc
		bool firstLeaveCombat;
		Unit* FindTarget();
		Unit* FindTargetForSpell(AI_Spell *sp);
		Unit* FindHealTargetForSpell(AI_Spell *sp);
		bool FindFriends(float dist);
		AI_Spell *m_nextSpell;
		Unit* m_nextTarget;
		uint32 m_fleeTimer;
		bool m_hasFled;
		bool m_hasCalledForHelp;
		uint32 m_outOfCombatRange;

		Unit* m_Unit;
		Unit* m_PetOwner;

		float FollowDistance;
		float FollowDistance_backup;
		float m_fallowAngle;

		TargetMap m_aiTargets;
		AssistTargetSet m_assistTargets;
		AIType m_AIType;
		AI_State m_AIState;
		AI_Agent m_aiCurrentAgent;

		Unit* tauntedBy; // This mob will hit only tauntedBy mob.
		bool isTaunted;
		Unit* soullinkedWith; // This mob can be hitten only by soullinked unit
		bool isSoulLinked;

		// Movement
		float m_walkSpeed;
		float m_runSpeed;
		float m_flySpeed;
		float m_destinationX;
		float m_destinationY;
		float m_destinationZ;

		float m_nextPosX;
		float m_nextPosY;
		float m_nextPosZ;

		// Return position after attacking a mob
		float m_returnX;
		float m_returnY;
		float m_returnZ;

		float m_lastFollowX;
		float m_lastFollowY;
		Unit* UnitToFollow;
		Unit* UnitToFollow_backup; // used unly when forcing creature to wander (blind spell) so when effect wears off we can follow our master again (guardian)
		Unit* UnitToFear;
		uint32 m_timeToMove;
		uint32 m_timeMoved;
		uint32 m_moveTimer;
		uint32 m_FearTimer;
		uint32 m_WanderTimer;

		MovementType m_MovementType;
		MovementState m_MovementState;
		uint32 m_guardTimer;
		int32 m_currentHighestThreat;
	public:
		bool m_is_in_instance;
		bool skip_reset_hp;

		void WipeCurrentTarget();
		bool CheckCurrentTarget();
		bool TargetUpdateCheck(Unit* ptr);
};
