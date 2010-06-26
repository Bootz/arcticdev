-- MySQL dump 10.11
--
-- Host: localhost    Database: wow_arctic
-- ------------------------------------------------------
-- Server version	5.0.51b-community-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `millingloot`
--

DROP TABLE IF EXISTS `millingloot`;
CREATE TABLE `millingloot` (
  `entryid` int(11) unsigned NOT NULL default '0',
  `itemid` int(11) unsigned NOT NULL default '0',
  `percentchance` float NOT NULL default '0',
  `heroicpercentchance` float default '0',
  `mincount` int(30) default '1',
  `maxcount` int(30) default '1',
  `ffa_loot` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`entryid`,`itemid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `millingloot`
--

LOCK TABLES `millingloot` WRITE;
/*!40000 ALTER TABLE `millingloot` DISABLE KEYS */;
INSERT INTO `millingloot` VALUES (765,4604,0.369344,0,1,2,0),(765,39151,100,0,2,3,0),(785,4604,0.962237,0,1,2,0),(785,39151,2.74826,0,2,4,0),(785,39334,100,0,2,3,0),(785,39339,0.00346129,0,3,3,0),(785,43103,24.319,0,1,3,0),(785,43105,0.00346129,0,1,1,0),(2447,4604,0.382381,0,1,2,0),(2447,39151,100,0,2,4,0),(2449,4604,0.743068,0,1,2,0),(2449,39151,100,0,2,4,0),(2450,4605,1.07632,0,1,2,0),(2450,39151,0.0032715,0,3,3,0),(2450,39334,100,0,2,4,0),(2450,43103,24.3531,0,1,3,0),(2452,4605,0.907746,0,1,2,0),(2452,39334,100,0,2,4,0),(2452,43103,24.1528,0,1,3,0),(2453,4605,0.493771,0,1,2,0),(2453,39334,100,0,2,4,0),(2453,43103,48.9669,0,1,3,0),(3355,4606,0.0312188,0,1,2,0),(3355,39338,100,0,2,3,0),(3355,43103,0.0124875,0,3,3,0),(3355,43104,24.3881,0,1,3,0),(3356,4606,0.0418163,0,1,2,0),(3356,39338,100,0,2,4,0),(3356,43103,0.00983913,0,2,3,0),(3356,43104,50.064,0,1,3,0),(3357,4606,0.034662,0,1,2,0),(3357,39338,100,0,2,4,0),(3357,43104,49.5244,0,1,3,0),(3358,4607,0.0183244,0,1,2,0),(3358,39339,100,0,2,4,0),(3358,43105,49.978,0,1,3,0),(3369,39338,100,0,2,3,0),(3369,39340,0.021173,0,2,2,0),(3369,43104,24.5183,0,1,3,0),(3369,43106,0.021173,0,1,1,0),(3818,4607,0.0120569,0,1,2,0),(3818,39339,100,0,2,3,0),(3818,43105,24.0354,0,1,3,0),(3819,4607,0.0394789,0,1,1,0),(3819,39339,100,0,2,4,0),(3819,43105,47.5326,0,1,3,0),(3820,4605,0.466861,0,1,2,0),(3820,39334,100,0,2,4,0),(3820,43103,49.7707,0,1,3,0),(3821,4607,0.0151739,0,1,2,0),(3821,39339,100,0,2,3,0),(3821,43105,25.0635,0,1,3,0),(4625,39340,100,0,2,3,0),(4625,43106,24.946,0,1,3,0),(8831,39340,100,0,2,3,0),(8831,43106,24.7748,0,1,3,0),(8836,39340,100,0,2,3,0),(8836,43106,25.9386,0,1,3,0),(8838,39340,100,0,2,3,0),(8838,43106,25.1152,0,1,3,0),(8839,39340,100,0,2,4,0),(8839,43106,49.7281,0,1,3,0),(8845,39340,100,0,2,4,0),(8845,43106,52.2043,0,1,3,0),(8846,39340,100,0,2,4,0),(8846,43106,48.3611,0,1,3,0),(13463,39341,100,0,2,3,0),(13463,43107,25.0668,0,1,3,0),(13464,39341,100,0,2,3,0),(13464,43107,25.2136,0,1,3,0),(13465,39341,100,0,2,4,0),(13465,43107,49.7608,0,1,3,0),(13466,39341,100,0,2,4,0),(13466,43107,49.4925,0,1,3,0),(13467,39341,100,0,2,4,0),(13467,43107,48.6208,0,1,3,0),(22710,39151,100,0,2,3,0),(22785,39342,100,0,2,4,0),(22785,43108,24.8009,0,1,3,0),(22786,39342,100,0,2,3,0),(22786,43108,24.8941,0,1,3,0),(22787,39342,100,0,2,3,0),(22787,43108,24.4458,0,1,3,0),(22789,39342,100,0,2,3,0),(22789,43108,25.2813,0,1,3,0),(22790,39342,100,0,2,4,0),(22790,43108,49.2584,0,1,3,0),(22791,39342,100,0,2,4,0),(22791,43108,50.9472,0,1,3,0),(22792,39342,100,0,2,4,0),(22792,43108,50.3561,0,1,3,0),(22793,39342,100,0,2,4,0),(22793,43108,50.5019,0,1,3,0),(36901,39343,100,0,2,3,0),(36901,43109,24.9169,0,1,3,0),(36902,39343,100,0,2,3,0),(36902,43109,21.875,0,1,3,0),(36903,39343,100,0,2,4,0),(36903,43109,50.0156,0,1,4,0),(36904,39343,100,0,2,4,0),(36904,43109,25.0429,0,1,3,0),(36905,39343,100,0,2,4,0),(36905,43109,50.1514,0,1,3,0),(36906,39343,100,0,2,4,0),(36906,43109,50.0218,0,1,3,0),(36907,39343,100,0,2,3,0),(36907,43109,24.8157,0,1,3,0),(37921,39343,100,0,2,3,0),(37921,43109,24.8329,0,1,3,0),(39969,39343,100,0,2,3,0),(39969,43109,23.0769,0,1,3,0),(39970,39343,100,0,2,3,0),(39970,43109,28.5714,0,1,3,0);
/*!40000 ALTER TABLE `millingloot` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-08-03 14:50:13