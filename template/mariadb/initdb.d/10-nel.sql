-- MySQL dump 10.17  Distrib 10.3.15-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: db.ryzomcore.local    Database: nel
-- ------------------------------------------------------
-- Server version	10.2.24-MariaDB-1:10.2.24+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `domain`
--

CREATE DATABASE `nel`;

use `nel`;

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain` (
  `domain_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(32) NOT NULL DEFAULT '',
  `status` enum('ds_close','ds_dev','ds_restricted','ds_open') NOT NULL DEFAULT 'ds_dev',
  `patch_version` int(10) unsigned NOT NULL DEFAULT 0,
  `backup_patch_url` varchar(255) DEFAULT NULL,
  `patch_urls` text DEFAULT NULL,
  `login_address` varchar(255) NOT NULL DEFAULT '',
  `session_manager_address` varchar(255) NOT NULL DEFAULT '',
  `ring_db_name` varchar(255) NOT NULL DEFAULT '',
  `web_host` varchar(255) NOT NULL DEFAULT '',
  `web_host_php` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`domain_id`),
  UNIQUE KEY `name_idx` (`domain_name`)
) DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `PermissionId` int(11) NOT NULL AUTO_INCREMENT,
  `UId` int(10) unsigned NOT NULL DEFAULT 0,
  `DomainId` int(11) NOT NULL DEFAULT -1,
  `ShardId` int(10) NOT NULL DEFAULT -1,
  `AccessPrivilege` set('OPEN','DEV','RESTRICTED') NOT NULL DEFAULT 'OPEN',
  PRIMARY KEY (`PermissionId`),
  KEY `UIDIndex` (`UId`)
) DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `UId` int(10) NOT NULL AUTO_INCREMENT,
  `Login` varchar(64) NOT NULL DEFAULT '',
  `State` enum('Offline','Online') NOT NULL DEFAULT 'Offline',
  `Privilege` varchar(255) NOT NULL DEFAULT '',
  `ExtendedPrivilege` varchar(128) NOT NULL DEFAULT '',
  `GMId` int(4) NOT NULL DEFAULT 0,
  `Password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`UId`),
  KEY `LoginIndex` (`Login`),
  KEY `GMId` (`GMId`)
) DEFAULT CHARSET=utf8mb4 COMMENT='contains all users information for login system';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

