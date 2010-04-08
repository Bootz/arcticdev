/*
MySQL Data Transfer
Source Host: localhost
Source Database: arctic_character
Target Host: localhost
Target Database: arctic_character
Date: 07.01.2010 9:37:45
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for account_data
-- ----------------------------
DROP TABLE IF EXISTS `account_data`;
CREATE TABLE `account_data` (
  `acct` int(30) NOT NULL,
  `uiconfig0` blob,
  `uiconfig1` blob,
  `uiconfig2` blob,
  `uiconfig3` blob,
  `uiconfig4` blob,
  `uiconfig5` blob,
  `uiconfig6` blob,
  `uiconfig7` blob,
  `uiconfig8` blob,
  PRIMARY KEY  (`acct`),
  UNIQUE KEY `a` (`acct`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for account_forced_permissions
-- ----------------------------
DROP TABLE IF EXISTS `account_forced_permissions`;
CREATE TABLE `account_forced_permissions` (
  `login` varchar(50) NOT NULL,
  `permissions` varchar(100) NOT NULL,
  PRIMARY KEY  (`login`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for achievements
-- ----------------------------
DROP TABLE IF EXISTS `achievements`;
CREATE TABLE `achievements` (
  `player` int(11) NOT NULL,
  `achievementid` int(11) NOT NULL default '0',
  `progress` varchar(256) default NULL,
  `completed` int(11) NOT NULL default '0',
  PRIMARY KEY  (`player`,`achievementid`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for arenateams
-- ----------------------------
DROP TABLE IF EXISTS `arenateams`;
CREATE TABLE `arenateams` (
  `id` int(10) unsigned NOT NULL default '0' COMMENT 'Unique ID',
  `type` int(10) unsigned NOT NULL default '0' COMMENT 'Type: 0-2v2 1-3v3 2-5v5',
  `leader` int(10) unsigned NOT NULL default '0' COMMENT 'Leading character guid',
  `name` varchar(24) collate utf8_unicode_ci NOT NULL default '' COMMENT 'Team name',
  `emblemstyle` int(10) unsigned NOT NULL default '0',
  `emblemcolour` int(10) unsigned NOT NULL default '0',
  `borderstyle` int(10) unsigned NOT NULL default '0',
  `bordercolor` int(10) unsigned NOT NULL default '0',
  `backgroundcolor` int(10) unsigned NOT NULL default '0',
  `rating` int(10) unsigned NOT NULL default '0' COMMENT 'Server Rating',
  `data` varchar(24) collate utf8_unicode_ci NOT NULL COMMENT '(played_week) (won_week) (played_season) (won_season)',
  `ranking` int(10) unsigned NOT NULL COMMENT 'Server Ranking',
  `player_data1` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  `player_data2` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  `player_data3` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  `player_data4` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  `player_data5` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  `player_data6` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  `player_data7` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  `player_data8` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  `player_data9` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  `player_data10` varchar(32) collate utf8_unicode_ci NOT NULL COMMENT '(player_guid) (played_week) (won_week) (played_season) (won_season)',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Arena Teams';

-- ----------------------------
-- Table structure for auctions
-- ----------------------------
DROP TABLE IF EXISTS `auctions`;
CREATE TABLE `auctions` (
  `auctionId` int(10) unsigned NOT NULL auto_increment,
  `auctionHouse` int(32) unsigned NOT NULL default '1',
  `item` bigint(10) unsigned NOT NULL,
  `owner` bigint(10) unsigned NOT NULL,
  `buyout` int(32) unsigned NOT NULL,
  `time` int(32) unsigned NOT NULL,
  `bidder` bigint(10) unsigned NOT NULL,
  `bid` int(32) NOT NULL,
  `deposit` int(32) unsigned NOT NULL default '0',
  PRIMARY KEY  (`auctionId`),
  KEY `auctionHouse` (`auctionHouse`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for banned_names
-- ----------------------------
DROP TABLE IF EXISTS `banned_names`;
CREATE TABLE `banned_names` (
  `name` varchar(30) collate utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for character_declinedname
-- ----------------------------
DROP TABLE IF EXISTS `character_declinedname`;
CREATE TABLE `character_declinedname` (
  `guid` int(11) unsigned NOT NULL default '0' COMMENT 'Global Unique Identifier',
  `genitive` varchar(12) NOT NULL default '',
  `dative` varchar(12) NOT NULL default '',
  `accusative` varchar(12) NOT NULL default '',
  `instrumental` varchar(12) NOT NULL default '',
  `prepositional` varchar(12) NOT NULL default '',
  PRIMARY KEY  (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for character_pet_declinedname
-- ----------------------------
DROP TABLE IF EXISTS `character_pet_declinedname`;
CREATE TABLE `character_pet_declinedname` (
  `id` int(11) unsigned NOT NULL default '0',
  `owner` int(11) unsigned NOT NULL default '0',
  `genitive` varchar(12) NOT NULL default '',
  `dative` varchar(12) NOT NULL default '',
  `accusative` varchar(12) NOT NULL default '',
  `instrumental` varchar(12) NOT NULL default '',
  `prepositional` varchar(12) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters` (
  `guid` int(10) unsigned NOT NULL auto_increment,
  `acct` int(10) unsigned NOT NULL,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `race` tinyint(3) unsigned NOT NULL,
  `class` tinyint(3) unsigned NOT NULL,
  `gender` tinyint(3) unsigned NOT NULL,
  `custom_faction` int(10) unsigned NOT NULL default '0',
  `level` tinyint(3) unsigned NOT NULL,
  `xp` int(10) unsigned NOT NULL,
  `exploration_data` longtext collate utf8_unicode_ci NOT NULL,
  `skills` longtext collate utf8_unicode_ci NOT NULL,
  `watched_faction_index` bigint(30) NOT NULL default '0',
  `selected_pvp_title` int(10) unsigned NOT NULL default '0',
  `available_pvp_titles1` bigint(30) unsigned NOT NULL default '0',
  `available_pvp_titles2` bigint(30) unsigned NOT NULL,
  `gold` int(10) unsigned NOT NULL default '0',
  `ammo_id` int(10) unsigned NOT NULL default '0',
  `available_prof_points` tinyint(3) unsigned NOT NULL default '0',
  `total_talent_points` int(30) NOT NULL,
  `current_hp` int(10) unsigned NOT NULL default '0',
  `current_power` int(10) unsigned NOT NULL default '0',
  `pvprank` int(10) unsigned NOT NULL default '0',
  `bytes` int(10) unsigned NOT NULL default '0',
  `bytes2` int(10) unsigned NOT NULL default '0',
  `bytes3` int(30) NOT NULL,
  `player_flags` int(10) unsigned NOT NULL default '0',
  `player_bytes` int(10) unsigned NOT NULL default '0',
  `positionX` float NOT NULL default '0',
  `positionY` float NOT NULL default '0',
  `positionZ` float NOT NULL default '0',
  `orientation` float NOT NULL default '0',
  `mapId` int(10) unsigned NOT NULL default '0',
  `zoneId` int(10) unsigned NOT NULL default '0',
  `taximask` longtext collate utf8_unicode_ci NOT NULL,
  `banned` int(40) NOT NULL,
  `banReason` varchar(50) collate utf8_unicode_ci NOT NULL,
  `timestamp` int(10) unsigned NOT NULL default '0',
  `online` tinyint(3) unsigned NOT NULL default '0',
  `bindpositionX` float NOT NULL default '0',
  `bindpositionY` float NOT NULL default '0',
  `bindpositionZ` float NOT NULL default '0',
  `bindmapId` int(10) unsigned NOT NULL default '0',
  `bindzoneId` int(10) unsigned NOT NULL default '0',
  `isResting` tinyint(3) unsigned NOT NULL default '0',
  `restState` tinyint(3) unsigned NOT NULL default '0',
  `restTime` int(10) unsigned NOT NULL default '0',
  `playedtime` longtext collate utf8_unicode_ci NOT NULL,
  `deathstate` tinyint(3) unsigned NOT NULL default '0',
  `TalentResetTimes` int(10) unsigned NOT NULL default '0',
  `first_login` tinyint(3) unsigned NOT NULL default '0',
  `forced_rename_pending` tinyint(3) unsigned NOT NULL default '0',
  `arenaPoints` int(10) unsigned NOT NULL default '0',
  `totalstableslots` int(10) unsigned NOT NULL default '0',
  `instance_id` int(10) unsigned NOT NULL default '0',
  `entrypointmap` int(10) unsigned NOT NULL default '0',
  `entrypointx` float NOT NULL default '0',
  `entrypointy` float NOT NULL default '0',
  `entrypointz` float NOT NULL default '0',
  `entrypointo` float NOT NULL default '0',
  `entrypointinstance` int(10) unsigned NOT NULL default '0',
  `taxi_path` int(10) unsigned NOT NULL default '0',
  `taxi_lastnode` int(10) unsigned NOT NULL default '0',
  `taxi_mountid` int(10) unsigned NOT NULL default '0',
  `transporter` int(10) unsigned NOT NULL default '0',
  `transporter_xdiff` float NOT NULL default '0',
  `transporter_ydiff` float NOT NULL default '0',
  `transporter_zdiff` float NOT NULL default '0',
  `deleted_spells` longtext collate utf8_unicode_ci NOT NULL,
  `reputation` longtext collate utf8_unicode_ci NOT NULL,
  `actions` longtext collate utf8_unicode_ci NOT NULL,
  `auras` longtext collate utf8_unicode_ci NOT NULL,
  `finished_quests` longtext collate utf8_unicode_ci NOT NULL,
  `finished_daily_quests` longtext collate utf8_unicode_ci NOT NULL,
  `honorRolloverTime` int(30) NOT NULL default '0',
  `killsToday` int(10) unsigned NOT NULL default '0',
  `killsYesterday` int(10) unsigned NOT NULL default '0',
  `killsLifeTime` int(10) unsigned NOT NULL default '0',
  `honorToday` int(10) unsigned NOT NULL default '0',
  `honorYesterday` int(10) unsigned NOT NULL default '0',
  `honorPoints` int(10) unsigned NOT NULL default '0',
  `difficulty` int(10) unsigned NOT NULL default '0',
  `active_spec` tinyint(3) unsigned NOT NULL default '0',
  `specs_count` tinyint(3) unsigned NOT NULL default '1',
  `need_talent_reset` int(3) NOT NULL default '0',
  PRIMARY KEY  (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for characters_insert_queue
-- ----------------------------
DROP TABLE IF EXISTS `characters_insert_queue`;
CREATE TABLE `characters_insert_queue` (
  `guid` int(10) unsigned NOT NULL,
  `acct` int(10) unsigned NOT NULL,
  `name` varchar(21) character set utf8 collate utf8_unicode_ci NOT NULL,
  `race` tinyint(3) unsigned NOT NULL,
  `class` tinyint(3) unsigned NOT NULL,
  `gender` tinyint(3) unsigned NOT NULL,
  `custom_faction` int(10) unsigned NOT NULL default '0',
  `level` tinyint(3) unsigned NOT NULL,
  `xp` int(10) unsigned NOT NULL,
  `exploration_data` longtext NOT NULL,
  `skills` longtext NOT NULL,
  `watched_faction_index` int(10) unsigned NOT NULL default '0',
  `selected_pvp_title` int(10) unsigned NOT NULL default '0',
  `available_pvp_titles` int(10) unsigned NOT NULL default '0',
  `gold` int(10) unsigned NOT NULL default '0',
  `ammo_id` int(10) unsigned NOT NULL default '0',
  `available_prof_points` tinyint(3) unsigned NOT NULL default '0',
  `available_talent_points` tinyint(3) unsigned NOT NULL default '0',
  `current_hp` int(10) unsigned NOT NULL default '0',
  `current_power` int(10) unsigned NOT NULL default '0',
  `pvprank` int(10) unsigned NOT NULL default '0',
  `bytes` int(10) unsigned NOT NULL default '0',
  `bytes2` int(10) unsigned NOT NULL default '0',
  `player_flags` int(10) unsigned NOT NULL default '0',
  `player_bytes` int(10) unsigned NOT NULL default '0',
  `positionX` float NOT NULL default '0',
  `positionY` float NOT NULL default '0',
  `positionZ` float NOT NULL default '0',
  `orientation` float NOT NULL default '0',
  `mapId` int(10) unsigned NOT NULL default '0',
  `zoneId` int(10) unsigned NOT NULL default '0',
  `taximask` longtext NOT NULL,
  `banned` int(40) NOT NULL,
  `banReason` varchar(50) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL default '0',
  `online` tinyint(3) unsigned NOT NULL default '0',
  `bindpositionX` float NOT NULL default '0',
  `bindpositionY` float NOT NULL default '0',
  `bindpositionZ` float NOT NULL default '0',
  `bindmapId` int(10) unsigned NOT NULL default '0',
  `bindzoneId` int(10) unsigned NOT NULL default '0',
  `isResting` tinyint(3) unsigned NOT NULL default '0',
  `restState` tinyint(3) unsigned NOT NULL default '0',
  `restTime` int(10) unsigned NOT NULL default '0',
  `playedtime` longtext NOT NULL,
  `deathstate` tinyint(3) unsigned NOT NULL default '0',
  `TalentResetTimes` int(10) unsigned NOT NULL default '0',
  `first_login` tinyint(3) unsigned NOT NULL default '0',
  `forced_rename_pending` tinyint(3) unsigned NOT NULL default '0',
  `arenaPoints` int(10) unsigned NOT NULL default '0',
  `totalstableslots` int(10) unsigned NOT NULL default '0',
  `instance_id` int(10) unsigned NOT NULL default '0',
  `entrypointmap` int(10) unsigned NOT NULL default '0',
  `entrypointx` float NOT NULL default '0',
  `entrypointy` float NOT NULL default '0',
  `entrypointz` float NOT NULL default '0',
  `entrypointo` float NOT NULL default '0',
  `entrypointinstance` int(10) unsigned NOT NULL default '0',
  `taxi_path` int(10) unsigned NOT NULL default '0',
  `taxi_lastnode` int(10) unsigned NOT NULL default '0',
  `taxi_mountid` int(10) unsigned NOT NULL default '0',
  `transporter` int(10) unsigned NOT NULL default '0',
  `transporter_xdiff` float NOT NULL default '0',
  `transporter_ydiff` float NOT NULL default '0',
  `transporter_zdiff` float NOT NULL default '0',
  `spells` longtext NOT NULL,
  `deleted_spells` longtext NOT NULL,
  `reputation` longtext NOT NULL,
  `actions` longtext NOT NULL,
  `auras` longtext NOT NULL,
  `finished_quests` longtext NOT NULL,
  `honorPointsToAdd` int(11) NOT NULL,
  `killsToday` int(10) unsigned NOT NULL default '0',
  `killsYesterday` int(10) unsigned NOT NULL default '0',
  `killsLifeTime` int(10) unsigned NOT NULL default '0',
  `honorToday` int(10) unsigned NOT NULL default '0',
  `honorYesterday` int(10) unsigned NOT NULL default '0',
  `honorPoints` int(10) unsigned NOT NULL default '0',
  `difficulty` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`guid`),
  UNIQUE KEY `name` (`name`),
  KEY `acct` (`acct`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for charters
-- ----------------------------
DROP TABLE IF EXISTS `charters`;
CREATE TABLE `charters` (
  `charterId` int(10) unsigned NOT NULL,
  `chartertype` int(10) NOT NULL default '0',
  `leaderGuid` int(20) unsigned NOT NULL default '0',
  `guildName` varchar(32) NOT NULL default '',
  `itemGuid` bigint(40) unsigned NOT NULL default '0',
  `signer1` int(10) unsigned NOT NULL default '0',
  `signer2` int(10) unsigned NOT NULL default '0',
  `signer3` int(10) unsigned NOT NULL default '0',
  `signer4` int(10) unsigned NOT NULL default '0',
  `signer5` int(10) unsigned NOT NULL default '0',
  `signer6` int(10) unsigned NOT NULL default '0',
  `signer7` int(10) unsigned NOT NULL default '0',
  `signer8` int(10) unsigned NOT NULL default '0',
  `signer9` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`charterId`),
  UNIQUE KEY `leaderGuid` (`leaderGuid`),
  UNIQUE KEY `guildName` (`guildName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 11264 kB; InnoDB free: 18432 kB';

-- ----------------------------
-- Table structure for clientaddons
-- ----------------------------
CREATE TABLE `clientaddons` (
  `id` int(10) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `crc` bigint(50) default NULL,
  `banned` int(1) NOT NULL default '0',
  `showinlist` int(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `index` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for command_overrides
-- ----------------------------
DROP TABLE IF EXISTS `command_overrides`;
CREATE TABLE `command_overrides` (
  `command_name` varchar(100) NOT NULL,
  `access_level` varchar(10) NOT NULL,
  PRIMARY KEY  (`command_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for corpses
-- ----------------------------
DROP TABLE IF EXISTS `corpses`;
CREATE TABLE `corpses` (
  `guid` bigint(20) unsigned NOT NULL default '0',
  `positionX` float NOT NULL default '0',
  `positionY` float NOT NULL default '0',
  `positionZ` float NOT NULL default '0',
  `orientation` float NOT NULL default '0',
  `zoneId` int(11) NOT NULL default '38',
  `mapId` int(11) NOT NULL default '0',
  `instanceId` int(11) NOT NULL default '0',
  `data` longtext NOT NULL,
  PRIMARY KEY  (`guid`),
  KEY `b` (`mapId`),
  KEY `c` (`instanceId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for events_settings
-- ----------------------------
DROP TABLE IF EXISTS `events_settings`;
CREATE TABLE `events_settings` (
  `eventid` tinyint(2) unsigned NOT NULL,
  `lastactivated` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`eventid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gm_tickets
-- ----------------------------
DROP TABLE IF EXISTS `gm_tickets`;
CREATE TABLE `gm_tickets` (
  `guid` int(6) NOT NULL default '0',
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `level` int(6) NOT NULL default '0',
  `type` int(2) NOT NULL default '0',
  `posX` float NOT NULL default '0',
  `posY` float NOT NULL default '0',
  `posZ` float NOT NULL default '0',
  `message` text collate utf8_unicode_ci NOT NULL,
  `timestamp` text collate utf8_unicode_ci,
  PRIMARY KEY  (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for groups
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `group_id` int(30) NOT NULL,
  `group_type` tinyint(2) NOT NULL,
  `subgroup_count` tinyint(2) NOT NULL,
  `loot_method` tinyint(2) NOT NULL,
  `loot_threshold` tinyint(2) NOT NULL,
  `difficulty` int(30) NOT NULL default '0',
  `assistant_leader` int(30) NOT NULL default '0',
  `main_tank` int(30) NOT NULL default '0',
  `main_assist` int(30) NOT NULL default '0',
  `GroupInstanceID` int(30) unsigned NOT NULL default '0',
  `group1member1` int(50) NOT NULL,
  `group1member2` int(50) NOT NULL,
  `group1member3` int(50) NOT NULL,
  `group1member4` int(50) NOT NULL,
  `group1member5` int(50) NOT NULL,
  `group2member1` int(50) NOT NULL,
  `group2member2` int(50) NOT NULL,
  `group2member3` int(50) NOT NULL,
  `group2member4` int(50) NOT NULL,
  `group2member5` int(50) NOT NULL,
  `group3member1` int(50) NOT NULL,
  `group3member2` int(50) NOT NULL,
  `group3member3` int(50) NOT NULL,
  `group3member4` int(50) NOT NULL,
  `group3member5` int(50) NOT NULL,
  `group4member1` int(50) NOT NULL,
  `group4member2` int(50) NOT NULL,
  `group4member3` int(50) NOT NULL,
  `group4member4` int(50) NOT NULL,
  `group4member5` int(50) NOT NULL,
  `group5member1` int(50) NOT NULL,
  `group5member2` int(50) NOT NULL,
  `group5member3` int(50) NOT NULL,
  `group5member4` int(50) NOT NULL,
  `group5member5` int(50) NOT NULL,
  `group6member1` int(50) NOT NULL,
  `group6member2` int(50) NOT NULL,
  `group6member3` int(50) NOT NULL,
  `group6member4` int(50) NOT NULL,
  `group6member5` int(50) NOT NULL,
  `group7member1` int(50) NOT NULL,
  `group7member2` int(50) NOT NULL,
  `group7member3` int(50) NOT NULL,
  `group7member4` int(50) NOT NULL,
  `group7member5` int(50) NOT NULL,
  `group8member1` int(50) NOT NULL,
  `group8member2` int(50) NOT NULL,
  `group8member3` int(50) NOT NULL,
  `group8member4` int(50) NOT NULL,
  `group8member5` int(50) NOT NULL,
  `timestamp` int(30) NOT NULL,
  PRIMARY KEY  (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for guild_bankitems
-- ----------------------------
DROP TABLE IF EXISTS `guild_bankitems`;
CREATE TABLE `guild_bankitems` (
  `guildId` int(30) NOT NULL,
  `tabId` int(30) NOT NULL,
  `slotId` int(30) NOT NULL,
  `itemGuid` int(30) NOT NULL,
  PRIMARY KEY  (`guildId`,`tabId`,`slotId`),
  KEY `a` (`guildId`),
  KEY `b` (`tabId`),
  KEY `c` (`slotId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for guild_banklogs
-- ----------------------------
DROP TABLE IF EXISTS `guild_banklogs`;
CREATE TABLE `guild_banklogs` (
  `log_id` int(30) NOT NULL,
  `guildid` int(30) NOT NULL,
  `tabid` bigint(30) NOT NULL,
  `action` bigint(30) NOT NULL,
  `player_guid` bigint(30) NOT NULL,
  `item_entry` bigint(30) NOT NULL,
  `stack_count` bigint(30) NOT NULL,
  `timestamp` bigint(30) NOT NULL,
  PRIMARY KEY  (`log_id`,`guildid`),
  KEY `a` (`log_id`),
  KEY `b` (`guildid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for guild_banktabs
-- ----------------------------
DROP TABLE IF EXISTS `guild_banktabs`;
CREATE TABLE `guild_banktabs` (
  `guildId` int(30) NOT NULL,
  `tabId` int(30) NOT NULL,
  `tabName` varchar(200) NOT NULL,
  `tabIcon` varchar(200) NOT NULL,
  PRIMARY KEY  (`guildId`,`tabId`),
  KEY `a` (`guildId`),
  KEY `b` (`tabId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for guild_data
-- ----------------------------
DROP TABLE IF EXISTS `guild_data`;
CREATE TABLE `guild_data` (
  `guildid` int(30) NOT NULL,
  `playerid` int(30) NOT NULL,
  `guildRank` int(30) NOT NULL,
  `publicNote` varchar(300) collate utf8_unicode_ci NOT NULL,
  `officerNote` varchar(300) collate utf8_unicode_ci NOT NULL,
  `lastWithdrawReset` int(30) NOT NULL default '0',
  `withdrawlsSinceLastReset` int(30) NOT NULL default '0',
  `lastItemWithdrawReset0` int(30) NOT NULL default '0',
  `itemWithdrawlsSinceLastReset0` int(30) NOT NULL default '0',
  `lastItemWithdrawReset1` int(30) NOT NULL default '0',
  `itemWithdrawlsSinceLastReset1` int(30) NOT NULL default '0',
  `lastItemWithdrawReset2` int(30) NOT NULL default '0',
  `itemWithdrawlsSinceLastReset2` int(30) NOT NULL default '0',
  `lastItemWithdrawReset3` int(30) NOT NULL default '0',
  `itemWithdrawlsSinceLastReset3` int(30) NOT NULL default '0',
  `lastItemWithdrawReset4` int(30) NOT NULL default '0',
  `itemWithdrawlsSinceLastReset4` int(30) NOT NULL default '0',
  `lastItemWithdrawReset5` int(30) NOT NULL default '0',
  `itemWithdrawlsSinceLastReset5` int(30) NOT NULL default '0',
  PRIMARY KEY  (`playerid`,`guildRank`),
  UNIQUE KEY `guildid` (`guildid`,`playerid`),
  KEY `a` (`guildid`),
  KEY `b` (`playerid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for guild_logs
-- ----------------------------
DROP TABLE IF EXISTS `guild_logs`;
CREATE TABLE `guild_logs` (
  `log_id` int(30) NOT NULL,
  `guildid` int(30) NOT NULL,
  `timestamp` int(30) NOT NULL,
  `event_type` int(30) NOT NULL,
  `misc1` int(30) NOT NULL,
  `misc2` int(30) NOT NULL,
  `misc3` int(30) NOT NULL,
  PRIMARY KEY  (`log_id`,`guildid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for guild_ranks
-- ----------------------------
DROP TABLE IF EXISTS `guild_ranks`;
CREATE TABLE `guild_ranks` (
  `guildId` int(6) unsigned NOT NULL,
  `rankId` int(1) NOT NULL default '0',
  `rankName` varchar(255) collate utf8_unicode_ci NOT NULL,
  `rankRights` int(3) unsigned NOT NULL default '0',
  `goldLimitPerDay` int(30) NOT NULL default '0',
  `bankTabFlags0` int(30) NOT NULL default '0',
  `itemStacksPerDay0` int(30) NOT NULL default '0',
  `bankTabFlags1` int(30) NOT NULL default '0',
  `itemStacksPerDay1` int(30) NOT NULL default '0',
  `bankTabFlags2` int(30) NOT NULL default '0',
  `itemStacksPerDay2` int(30) NOT NULL default '0',
  `bankTabFlags3` int(30) NOT NULL default '0',
  `itemStacksPerDay3` int(30) NOT NULL default '0',
  `bankTabFlags4` int(30) NOT NULL default '0',
  `itemStacksPerDay4` int(30) NOT NULL default '0',
  `bankTabFlags5` int(30) NOT NULL default '0',
  `itemStacksPerDay5` int(30) NOT NULL default '0',
  PRIMARY KEY  (`guildId`,`rankId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for guilds
-- ----------------------------
DROP TABLE IF EXISTS `guilds`;
CREATE TABLE `guilds` (
  `guildId` bigint(20) NOT NULL auto_increment,
  `guildName` varchar(32) collate utf8_unicode_ci NOT NULL default '',
  `leaderGuid` bigint(20) NOT NULL default '0',
  `emblemStyle` int(10) NOT NULL default '0',
  `emblemColor` int(10) NOT NULL default '0',
  `borderStyle` int(10) NOT NULL default '0',
  `borderColor` int(10) NOT NULL default '0',
  `backgroundColor` int(10) NOT NULL default '0',
  `guildInfo` varchar(1024) collate utf8_unicode_ci NOT NULL,
  `motd` varchar(1024) collate utf8_unicode_ci NOT NULL,
  `createdate` int(30) NOT NULL default '0',
  `bankTabCount` int(30) NOT NULL default '0',
  `bankBalance` int(30) NOT NULL default '0',
  PRIMARY KEY  (`guildId`),
  UNIQUE KEY `guildName` (`guildName`),
  UNIQUE KEY `leaderGuid` (`leaderGuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for instances
-- ----------------------------
DROP TABLE IF EXISTS `instances`;
CREATE TABLE `instances` (
  `id` int(30) NOT NULL,
  `mapid` int(30) NOT NULL,
  `creation` int(30) NOT NULL,
  `expiration` int(30) NOT NULL,
  `killed_npc_guids` text NOT NULL,
  `difficulty` int(30) NOT NULL,
  `creator_group` int(30) NOT NULL,
  `creator_guid` int(30) NOT NULL,
  `active_members` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `a` (`mapid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for mailbox
-- ----------------------------
DROP TABLE IF EXISTS `mailbox`;
CREATE TABLE `mailbox` (
  `message_id` int(30) NOT NULL auto_increment,
  `message_type` int(30) NOT NULL default '0',
  `player_guid` int(30) NOT NULL default '0',
  `sender_guid` int(30) NOT NULL default '0',
  `subject` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `body` varchar(4096) collate utf8_unicode_ci NOT NULL,
  `money` int(30) NOT NULL default '0',
  `attached_item_guids` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `cod` int(30) NOT NULL default '0',
  `stationary` int(30) NOT NULL default '0',
  `expiry_time` int(30) NOT NULL default '0',
  `delivery_time` int(30) NOT NULL default '0',
  `copy_made` int(30) NOT NULL default '0',
  `read_flag` int(30) NOT NULL default '0',
  `deleted_flag` int(30) NOT NULL default '0',
  `returned_flag` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`message_id`),
  KEY `b` (`player_guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for mailbox_insert_queue
-- ----------------------------
DROP TABLE IF EXISTS `mailbox_insert_queue`;
CREATE TABLE `mailbox_insert_queue` (
  `sender_guid` int(30) NOT NULL,
  `receiver_guid` int(30) NOT NULL,
  `subject` varchar(200) collate utf8_unicode_ci NOT NULL,
  `body` varchar(500) collate utf8_unicode_ci NOT NULL,
  `stationary` int(30) NOT NULL,
  `money` int(30) NOT NULL,
  `item_id` int(30) NOT NULL,
  `item_stack` int(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for news_timers
-- ----------------------------
DROP TABLE IF EXISTS `news_timers`;
CREATE TABLE `news_timers` (
  `id` int(10) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for playercooldowns
-- ----------------------------
DROP TABLE IF EXISTS `playercooldowns`;
CREATE TABLE `playercooldowns` (
  `player_guid` int(30) NOT NULL,
  `cooldown_type` int(30) NOT NULL,
  `cooldown_misc` int(30) NOT NULL,
  `cooldown_expire_time` int(30) NOT NULL,
  `cooldown_spellid` int(30) NOT NULL,
  `cooldown_itemid` int(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for playerglyphs
-- ----------------------------
DROP TABLE IF EXISTS `playerglyphs`;
CREATE TABLE `playerglyphs` (
  `guid` int(10) unsigned NOT NULL,
  `spec` tinyint(3) unsigned NOT NULL default '0',
  `glyph1` smallint(5) unsigned default NULL,
  `glyph2` smallint(5) unsigned default NULL,
  `glyph3` smallint(5) unsigned default NULL,
  `glyph4` smallint(5) unsigned default NULL,
  `glyph5` smallint(5) unsigned default NULL,
  `glyph6` smallint(5) unsigned default NULL,
  PRIMARY KEY  (`guid`,`spec`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for playeritems
-- ----------------------------
DROP TABLE IF EXISTS `playeritems`;
CREATE TABLE `playeritems` (
  `ownerguid` int(10) unsigned NOT NULL default '0',
  `guid` bigint(10) NOT NULL auto_increment,
  `entry` int(10) unsigned NOT NULL default '0',
  `wrapped_item_id` int(30) NOT NULL default '0',
  `wrapped_creator` int(30) NOT NULL default '0',
  `creator` int(10) unsigned NOT NULL default '0',
  `count` int(10) unsigned NOT NULL default '0',
  `charges` int(10) unsigned NOT NULL default '0',
  `flags` int(10) unsigned NOT NULL default '0',
  `randomprop` int(10) unsigned NOT NULL default '0',
  `randomsuffix` int(30) default '0',
  `itemtext` int(10) unsigned NOT NULL default '0',
  `durability` int(10) unsigned NOT NULL default '0',
  `containerslot` int(11) default '-1',
  `slot` int(10) NOT NULL default '0',
  `enchantments` longtext NOT NULL,
  PRIMARY KEY  (`guid`),
  KEY `ownerguid` (`ownerguid`),
  KEY `itemtext` (`itemtext`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for playeritems_insert_queue
-- ----------------------------
DROP TABLE IF EXISTS `playeritems_insert_queue`;
CREATE TABLE `playeritems_insert_queue` (
  `ownerguid` int(10) unsigned NOT NULL default '0',
  `guid` int(10) NOT NULL auto_increment,
  `entry` int(10) unsigned NOT NULL default '0',
  `wrapped_item_id` int(30) NOT NULL default '0',
  `wrapped_creator` int(30) NOT NULL default '0',
  `creator` int(10) unsigned NOT NULL default '0',
  `count` int(10) unsigned NOT NULL default '0',
  `charges` int(10) unsigned NOT NULL default '0',
  `flags` int(10) unsigned NOT NULL default '0',
  `randomprop` int(10) unsigned NOT NULL default '0',
  `randomsuffix` int(30) NOT NULL,
  `itemtext` int(10) unsigned NOT NULL default '0',
  `durability` int(10) unsigned NOT NULL default '0',
  `containerslot` int(11) NOT NULL default '-1',
  `slot` tinyint(4) NOT NULL default '0',
  `enchantments` longtext collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`guid`),
  KEY `ownerguid` (`ownerguid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for playerpets
-- ----------------------------
DROP TABLE IF EXISTS `playerpets`;
CREATE TABLE `playerpets` (
  `ownerguid` bigint(20) NOT NULL default '0',
  `petnumber` int(11) NOT NULL default '0',
  `name` varchar(21) collate utf8_unicode_ci NOT NULL default '',
  `entry` bigint(20) NOT NULL default '0',
  `fields` longtext collate utf8_unicode_ci NOT NULL,
  `xp` int(11) NOT NULL default '0',
  `active` tinyint(1) NOT NULL default '1',
  `level` int(11) NOT NULL default '0',
  `happiness` int(11) NOT NULL default '0',
  `actionbar` varchar(200) collate utf8_unicode_ci NOT NULL default '',
  `happinessupdate` int(11) NOT NULL default '0',
  `summon` int(11) NOT NULL default '0',
  `loyaltypts` int(11) NOT NULL default '0',
  `loyaltyupdate` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ownerguid`,`petnumber`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for playerpetspells
-- ----------------------------
DROP TABLE IF EXISTS `playerpetspells`;
CREATE TABLE `playerpetspells` (
  `ownerguid` bigint(100) NOT NULL default '0',
  `petnumber` int(100) NOT NULL default '0',
  `spellid` int(100) NOT NULL default '0',
  `flags` int(4) NOT NULL default '0',
  KEY `a` (`ownerguid`),
  KEY `b` (`petnumber`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for playerskills
-- ----------------------------
DROP TABLE IF EXISTS `playerskills`;
CREATE TABLE `playerskills` (
  `player_guid` int(11) NOT NULL default '0',
  `skill_id` int(11) NOT NULL default '0',
  `type` int(11) NOT NULL,
  `currentlvl` int(11) NOT NULL default '1',
  `maxlvl` int(11) NOT NULL default '1',
  PRIMARY KEY  (`player_guid`,`skill_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for playerskills_insert_queue
-- ----------------------------
DROP TABLE IF EXISTS `playerskills_insert_queue`;
CREATE TABLE `playerskills_insert_queue` (
  `player_guid` int(11) NOT NULL default '0',
  `skill_id` int(11) NOT NULL default '0',
  `type` int(11) NOT NULL,
  `currentlvl` int(11) NOT NULL default '1',
  `maxlvl` int(11) NOT NULL default '1',
  PRIMARY KEY  (`player_guid`,`skill_id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for playerspells
-- ----------------------------
DROP TABLE IF EXISTS `playerspells`;
CREATE TABLE `playerspells` (
  `guid` int(10) unsigned NOT NULL,
  `spellid` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`guid`,`spellid`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for playersummonspells
-- ----------------------------
DROP TABLE IF EXISTS `playersummonspells`;
CREATE TABLE `playersummonspells` (
  `ownerguid` bigint(20) NOT NULL default '0',
  `entryid` bigint(4) NOT NULL default '0',
  `spellid` int(4) NOT NULL default '0',
  KEY `a` (`ownerguid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for playertalents
-- ----------------------------
DROP TABLE IF EXISTS `playertalents`;
CREATE TABLE `playertalents` (
  `guid` int(10) unsigned NOT NULL,
  `spec` tinyint(3) unsigned NOT NULL default '0',
  `tid` smallint(5) unsigned NOT NULL,
  `rank` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`guid`,`spec`,`tid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for prestartqueries
-- ----------------------------
DROP TABLE IF EXISTS `prestartqueries`;
CREATE TABLE `prestartqueries` (
  `Query` varchar(8192) NOT NULL,
  `SingleShot` int(1) unsigned NOT NULL default '1',
  `Seq` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`Seq`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for questlog
-- ----------------------------
DROP TABLE IF EXISTS `questlog`;
CREATE TABLE `questlog` (
  `player_guid` int(11) unsigned NOT NULL default '0',
  `quest_id` int(10) unsigned NOT NULL default '0',
  `slot` int(20) unsigned NOT NULL default '0',
  `time_left` int(10) NOT NULL default '0',
  `explored_area1` int(20) unsigned NOT NULL default '0',
  `explored_area2` int(20) NOT NULL default '0',
  `explored_area3` int(20) unsigned NOT NULL default '0',
  `explored_area4` int(20) unsigned NOT NULL default '0',
  `mob_kill1` int(20) NOT NULL default '0',
  `mob_kill2` int(20) NOT NULL default '0',
  `mob_kill3` int(20) NOT NULL default '0',
  `mob_kill4` int(20) NOT NULL default '0',
  `slain` int(20) NOT NULL default '0',
  PRIMARY KEY  (`player_guid`,`quest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for questlog_insert_queue
-- ----------------------------
DROP TABLE IF EXISTS `questlog_insert_queue`;
CREATE TABLE `questlog_insert_queue` (
  `player_guid` int(11) unsigned NOT NULL default '0',
  `quest_id` int(10) unsigned NOT NULL default '0',
  `slot` int(20) unsigned NOT NULL default '0',
  `time_left` int(10) NOT NULL default '0',
  `explored_area1` int(20) unsigned NOT NULL default '0',
  `explored_area2` int(20) NOT NULL default '0',
  `explored_area3` int(20) unsigned NOT NULL default '0',
  `explored_area4` int(20) unsigned NOT NULL default '0',
  `mob_kill1` int(20) NOT NULL default '0',
  `mob_kill2` int(20) NOT NULL default '0',
  `mob_kill3` int(20) NOT NULL default '0',
  `mob_kill4` int(20) unsigned zerofill NOT NULL default '00000000000000000000',
  `slain` int(20) NOT NULL default '0',
  PRIMARY KEY  (`player_guid`,`quest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251;

-- ----------------------------
-- Table structure for server_settings
-- ----------------------------
DROP TABLE IF EXISTS `server_settings`;
CREATE TABLE `server_settings` (
  `setting_id` varchar(200) NOT NULL,
  `setting_value` bigint(50) NOT NULL,
  PRIMARY KEY  (`setting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for social_friends
-- ----------------------------
DROP TABLE IF EXISTS `social_friends`;
CREATE TABLE `social_friends` (
  `character_guid` int(30) NOT NULL,
  `friend_guid` int(30) NOT NULL,
  `note` varchar(100) NOT NULL,
  PRIMARY KEY  (`character_guid`,`friend_guid`),
  KEY `a` (`character_guid`),
  KEY `b` (`friend_guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for social_ignores
-- ----------------------------
DROP TABLE IF EXISTS `social_ignores`;
CREATE TABLE `social_ignores` (
  `character_guid` int(30) NOT NULL,
  `ignore_guid` int(30) NOT NULL,
  PRIMARY KEY  (`character_guid`,`ignore_guid`),
  KEY `a` (`character_guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tutorials
-- ----------------------------
DROP TABLE IF EXISTS `tutorials`;
CREATE TABLE `tutorials` (
  `playerId` bigint(20) unsigned NOT NULL default '0',
  `tut0` bigint(20) unsigned NOT NULL default '0',
  `tut1` bigint(20) unsigned NOT NULL default '0',
  `tut2` bigint(20) unsigned NOT NULL default '0',
  `tut3` bigint(20) unsigned NOT NULL default '0',
  `tut4` bigint(20) unsigned NOT NULL default '0',
  `tut5` bigint(20) unsigned NOT NULL default '0',
  `tut6` bigint(20) unsigned NOT NULL default '0',
  `tut7` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`playerId`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for worldstate_save_data
-- ----------------------------
DROP TABLE IF EXISTS `worldstate_save_data`;
CREATE TABLE `worldstate_save_data` (
  `setting_id` varchar(50) NOT NULL,
  `setting_value` varchar(200) NOT NULL,
  PRIMARY KEY  (`setting_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------

