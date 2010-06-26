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
-- Table structure for table `reputation_creature_onkill`
--

DROP TABLE IF EXISTS `reputation_creature_onkill`;
CREATE TABLE `reputation_creature_onkill` (
  `creature_id` int(30) NOT NULL,
  `faction_change_alliance` int(30) NOT NULL,
  `faction_change_horde` int(30) NOT NULL,
  `change_value` int(30) NOT NULL,
  `rep_limit` int(30) NOT NULL,
  PRIMARY KEY  (`creature_id`,`faction_change_horde`,`faction_change_alliance`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Creature System';

--
-- Dumping data for table `reputation_creature_onkill`
--

LOCK TABLES `reputation_creature_onkill` WRITE;
/*!40000 ALTER TABLE `reputation_creature_onkill` DISABLE KEYS */;
INSERT INTO `reputation_creature_onkill` VALUES (674,21,21,5,42000),(675,21,21,5,42000),(677,21,21,5,42000),(737,87,87,1,42000),(737,21,21,-5,42000),(773,87,87,1,42000),(773,21,21,-5,42000),(921,21,21,5,42000),(1094,21,21,5,42000),(1095,21,21,5,42000),(1096,21,21,5,42000),(1097,21,21,5,42000),(1411,87,87,1,42000),(1411,21,21,-5,42000),(1561,21,21,5,42000),(1561,87,87,-25,42000),(1562,21,21,5,42000),(1562,87,87,-25,42000),(1563,21,21,5,42000),(1563,87,87,-25,42000),(1564,21,21,5,42000),(1564,87,87,-25,42000),(1565,21,21,5,42000),(1565,87,87,-25,42000),(1653,21,21,5,42000),(1653,87,87,-25,42000),(2482,87,87,1,42000),(2482,21,21,-5,42000),(2487,87,87,1,42000),(2487,21,21,-5,42000),(2488,87,87,1,42000),(2488,21,21,-5,42000),(2490,87,87,1,42000),(2490,21,21,-5,42000),(2491,87,87,1,42000),(2491,21,21,-5,42000),(2493,87,87,1,42000),(2493,21,21,-5,42000),(2494,87,87,1,42000),(2494,21,21,-5,42000),(2495,87,87,1,42000),(2495,21,21,-5,42000),(2496,87,87,5,42000),(2496,21,21,-25,42000),(2498,87,87,1,42000),(2498,21,21,-5,42000),(2499,87,87,1,42000),(2499,21,21,-5,42000),(2500,87,87,1,42000),(2500,21,21,-5,42000),(2501,87,87,1,42000),(2501,21,21,-5,42000),(2502,87,87,1,42000),(2502,21,21,-5,42000),(2542,87,87,1,42000),(2542,21,21,-5,42000),(2545,21,21,25,42000),(2545,87,87,-125,42000),(2546,21,21,25,42000),(2546,87,87,-125,42000),(2547,21,21,25,42000),(2547,87,87,-125,42000),(2548,21,21,25,42000),(2548,87,87,-125,42000),(2549,21,21,25,42000),(2549,87,87,-125,42000),(2550,21,21,25,42000),(2550,87,87,-125,42000),(2551,21,21,25,42000),(2551,87,87,-125,42000),(2594,87,87,1,42000),(2594,21,21,-5,42000),(2610,87,87,1,42000),(2610,21,21,-25,42000),(2622,87,87,1,42000),(2622,21,21,-5,42000),(2625,87,87,5,42000),(2625,21,21,-25,42000),(2627,87,87,1,42000),(2627,21,21,-5,42000),(2636,87,87,5,42000),(2636,21,21,-25,42000),(2663,87,87,1,42000),(2663,21,21,-5,42000),(2664,87,87,1,42000),(2664,21,21,-5,42000),(2670,87,87,1,42000),(2670,21,21,-5,42000),(2685,87,87,1,42000),(2685,21,21,-5,42000),(2699,87,87,1,42000),(2699,21,21,-5,42000),(2767,87,87,5,42000),(2767,21,21,-125,42000),(2768,87,87,1,42000),(2768,21,21,-25,42000),(2769,87,87,5,42000),(2769,21,21,-125,42000),(2774,87,87,1,42000),(2774,21,21,-25,42000),(2778,87,87,5,42000),(2778,21,21,-25,42000),(2817,87,87,1,42000),(2817,21,21,-25,42000),(2832,87,87,1,42000),(2832,21,21,-5,42000),(2834,87,87,1,42000),(2834,21,21,-5,42000),(2836,87,87,1,42000),(2836,21,21,-5,42000),(2837,87,87,1,42000),(2837,21,21,-5,42000),(2838,87,87,1,42000),(2838,21,21,-5,42000),(2839,87,87,1,42000),(2839,21,21,-5,42000),(2840,87,87,1,42000),(2840,21,21,-5,42000),(2842,87,87,1,42000),(2842,21,21,-5,42000),(2843,87,87,1,42000),(2843,21,21,-5,42000),(2844,87,87,1,42000),(2844,21,21,-5,42000),(2845,87,87,1,42000),(2845,21,21,-5,42000),(2846,87,87,1,42000),(2846,21,21,-5,42000),(2847,87,87,1,42000),(2847,21,21,-5,42000),(2848,87,87,1,42000),(2848,21,21,-5,42000),(2849,87,87,1,42000),(2849,21,21,-5,42000),(3381,470,470,1,42000),(3382,470,470,1,42000),(3383,470,470,1,42000),(3384,470,470,1,42000),(3467,470,470,5,42000),(3537,169,169,-25,42000),(3538,169,169,-25,42000),(3945,87,87,1,42000),(3945,21,21,-5,42000),(4260,21,21,5,42000),(4505,21,21,5,42000),(4505,87,87,-25,42000),(4506,21,21,5,42000),(4506,87,87,-25,42000),(4624,87,87,25,42000),(4624,21,21,-125,42000),(4631,87,87,1,42000),(4631,21,21,-5,42000),(4723,21,21,25,42000),(5134,0,729,1,42000),(5615,369,369,10,42000),(5616,369,369,10,42000),(5617,369,369,10,42000),(5618,369,369,10,42000),(5623,369,369,10,42000),(6707,70,70,1,2999),(6707,349,349,-25,42000),(6766,70,70,1,2999),(6766,349,349,-25,42000),(6768,70,70,1,2999),(6768,349,349,-25,42000),(6771,70,70,1,2999),(6771,349,349,-25,42000),(6777,70,70,1,2999),(6777,349,349,-25,42000),(6779,70,70,1,2999),(6779,349,349,-25,42000),(7032,749,749,5,42000),(7153,576,576,5,42000),(7154,576,576,5,42000),(7155,576,576,5,42000),(7156,576,576,5,42000),(7157,576,576,5,42000),(7158,576,576,5,42000),(7323,70,70,1,2999),(7323,349,349,-25,42000),(7324,70,70,1,2999),(7324,349,349,-25,42000),(7325,70,70,1,2999),(7325,349,349,-25,42000),(7406,87,87,1,42000),(7406,21,21,-5,42000),(7438,576,576,5,42000),(7439,576,576,5,42000),(7440,576,576,5,42000),(7441,576,576,5,42000),(7442,576,576,5,42000),(7794,87,87,1,42000),(7794,21,21,-5,42000),(7805,369,369,10,42000),(7847,369,369,25,42000),(7853,87,87,1,42000),(7853,21,21,-5,42000),(7855,369,369,5,42000),(7856,369,369,5,42000),(7857,369,369,5,42000),(7858,369,369,5,42000),(7883,369,369,25,42000),(8123,87,87,5,42000),(8123,21,21,-25,42000),(8305,169,169,-25,42000),(8309,70,70,1,2999),(8309,349,349,-25,42000),(8320,87,87,1,42000),(8320,21,21,-5,42000),(9017,749,749,15,42000),(9179,87,87,1,42000),(9179,21,21,-25,42000),(9462,576,576,15,42000),(9464,576,576,15,42000),(9536,169,169,-25,42000),(9559,87,87,5,42000),(9559,21,21,-25,42000),(9816,749,749,50,42000),(10060,87,87,5,42000),(10060,21,21,-25,42000),(10199,576,576,25,42000),(10267,169,169,-25,42000),(10738,576,576,25,42000),(10916,576,576,5,42000),(11502,749,749,200,42000),(11658,749,749,20,42000),(11659,749,749,40,42000),(11666,749,749,10,42000),(11667,749,749,10,42000),(11668,749,749,20,42000),(11672,749,749,4,42000),(11673,749,749,20,42000),(11744,749,749,5,42000),(11746,749,749,5,42000),(11747,749,749,5,42000),(11803,609,609,1,42000),(11804,609,609,1,42000),(11880,609,609,1,42000),(11881,609,609,1,9000),(11882,609,609,1,42000),(11883,609,609,1,42000),(11946,730,0,350,42000),(11947,730,0,125,42000),(11948,0,729,350,42000),(11949,0,729,125,42000),(11982,749,749,100,42000),(11988,749,749,150,42000),(12050,0,729,5,42000),(12051,730,0,5,42000),(12053,730,0,5,42000),(12056,749,749,100,42000),(12057,749,749,100,42000),(12076,749,749,10,42000),(12096,0,729,5,42000),(12098,749,749,100,42000),(12100,749,749,10,42000),(12101,749,749,20,42000),(12118,749,749,100,42000),(12122,730,0,5,42000),(12127,0,729,5,42000),(12136,21,21,-25,42000),(12259,749,749,100,42000),(12264,749,749,100,42000),(13085,70,70,5,2999),(13085,349,349,-125,42000),(13137,730,0,12,42000),(13138,0,729,12,42000),(13140,730,0,12,42000),(13143,730,0,12,42000),(13144,730,0,12,42000),(13145,730,0,12,42000),(13146,730,0,12,42000),(13147,730,0,12,42000),(13152,730,0,12,42000),(13153,730,0,12,42000),(13154,730,0,12,42000),(13179,730,0,5,42000),(13180,730,0,5,42000),(13181,730,0,5,42000),(13256,730,0,125,42000),(13284,730,0,5,42000),(13297,0,729,12,42000),(13298,0,729,12,42000),(13299,0,729,12,42000),(13318,0,729,12,42000),(13319,0,729,12,42000),(13320,0,729,12,42000),(13324,730,0,5,42000),(13326,730,0,5,42000),(13328,730,0,5,42000),(13358,0,729,5,42000),(13359,730,0,5,42000),(13419,0,729,125,42000),(13437,0,729,5,42000),(13438,0,729,5,42000),(13439,0,729,5,42000),(13440,730,0,5,42000),(13443,0,729,5,42000),(13577,0,729,5,42000),(13617,0,729,5,42000),(13797,0,729,5,42000),(13798,730,0,5,42000),(14282,730,0,5,42000),(14283,0,729,5,42000),(14284,0,729,5,42000),(14342,576,576,25,42000),(14372,576,576,5,42000),(14478,749,749,25,42000),(14479,609,609,5,42000),(15088,87,87,25,42000),(15088,21,21,-125,42000),(15168,609,609,5,42000),(15200,609,609,1,42000),(15201,609,609,1,42000),(15202,609,609,1,42000),(15204,609,609,50,42000),(15205,609,609,50,42000),(15206,609,609,10,42000),(15207,609,609,10,42000),(15208,609,609,10,42000),(15209,609,609,5,42000),(15211,609,609,5,42000),(15212,609,609,5,42000),(15213,609,609,1,42000),(15220,609,609,10,42000),(15229,609,609,5,42000),(15230,609,609,5,42000),(15235,609,609,5,42000),(15236,609,609,5,42000),(15240,609,609,5,42000),(15249,609,609,5,42000),(15262,609,609,5,42000),(15264,609,609,5,42000),(15277,609,609,5,42000),(15305,609,609,25,42000),(15307,609,609,5,42000),(15308,609,609,1,42000),(15333,609,609,5,42000),(15339,609,609,300,42000),(15340,609,609,150,42000),(15341,609,609,150,42000),(15343,609,609,5,42000),(15344,609,609,5,42000),(15348,609,609,150,42000),(15369,609,609,150,42000),(15370,609,609,150,42000),(15387,609,609,5,42000),(15461,609,609,5,42000),(15462,609,609,5,42000),(15541,609,609,1,42000),(15542,609,609,1,42000),(17134,978,941,10,42000),(17135,978,941,10,42000),(17136,978,941,10,42000),(17137,978,941,10,42000),(17138,978,941,10,42000),(17146,978,941,10,42000),(17147,978,941,10,42000),(17148,978,941,10,42000),(17416,946,0,1,8999),(17728,978,941,10,42000),(17729,978,941,10,42000),(17730,978,941,10,42000),(17734,970,970,15,42000),(17771,978,941,10,42000),(17826,978,941,10,42000),(18124,970,970,15,21000),(18037,978,941,10,42000),(18064,978,941,10,42000),(18065,978,941,10,42000),(18125,970,970,15,21000),(18127,970,970,15,21000),(17955,970,970,15,21000),(18137,970,970,15,42000),(18202,978,941,10,42000),(18203,978,941,10,42000),(18204,978,941,10,42000),(18207,978,941,2,42000),(18211,978,941,10,42000),(18238,978,941,10,42000),(18260,978,941,10,42000),(18352,978,941,10,42000),(18397,978,941,10,42000),(18399,978,941,10,42000),(18402,978,941,10,42000),(18440,978,941,10,42000),(18136,970,970,15,42000),(18658,978,941,10,42000),(19519,970,970,15,21000),(19402,970,970,15,21000),(21644,1031,1031,5,42000),(21649,1031,1031,5,42000),(21650,1031,1031,5,42000),(21651,1031,1031,5,42000),(21652,1031,1031,5,42000),(21728,1031,1031,5,42000),(21763,1031,1031,5,42000),(21787,1031,1031,5,42000),(21804,1031,1031,3,21000),(21911,1031,1031,5,42000),(21912,1031,1031,5,42000),(21985,1031,1031,5,42000),(23029,1031,1031,15,42000),(23066,1031,1031,5,42000),(23067,1031,1031,5,42000),(23068,1031,1031,5,42000);
/*!40000 ALTER TABLE `reputation_creature_onkill` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-08-03 14:50:24