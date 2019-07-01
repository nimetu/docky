-- MySQL dump 10.17  Distrib 10.3.15-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: db.ryzomcore.local    Database: nel_ams_lib
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
-- Table structure for table `ams_querycache`
--

CREATE DATABASE `nel_ams_lib`;
use `nel_ams_lib`;

DROP TABLE IF EXISTS `ams_querycache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ams_querycache` (
  `SID` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(64) NOT NULL,
  `query` varchar(512) NOT NULL,
  `db` varchar(80) NOT NULL,
  PRIMARY KEY (`SID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ams_querycache`
--

LOCK TABLES `ams_querycache` WRITE;
/*!40000 ALTER TABLE `ams_querycache` DISABLE KEYS */;
/*!40000 ALTER TABLE `ams_querycache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assigned`
--

DROP TABLE IF EXISTS `assigned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assigned` (
  `Ticket` int(10) unsigned NOT NULL,
  `User` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Ticket`,`User`),
  KEY `fk_assigned_ticket_idx` (`Ticket`),
  KEY `fk_assigned_ams_user_idx` (`User`),
  CONSTRAINT `fk_assigned_ams_user` FOREIGN KEY (`User`) REFERENCES `ticket_user` (`TUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigned_ticket` FOREIGN KEY (`Ticket`) REFERENCES `ticket` (`TId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assigned`
--

LOCK TABLES `assigned` WRITE;
/*!40000 ALTER TABLE `assigned` DISABLE KEYS */;
/*!40000 ALTER TABLE `assigned` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email` (
  `MailId` int(11) NOT NULL AUTO_INCREMENT,
  `Recipient` varchar(50) DEFAULT NULL,
  `Subject` varchar(60) DEFAULT NULL,
  `Body` varchar(400) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `Attempts` varchar(45) DEFAULT '0',
  `UserId` int(10) unsigned DEFAULT NULL,
  `MessageId` varchar(45) DEFAULT NULL,
  `TicketId` int(10) unsigned DEFAULT NULL,
  `Sender` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`MailId`),
  KEY `fk_email_ticket_user2` (`UserId`),
  KEY `fk_email_ticket1` (`TicketId`),
  KEY `fk_email_support_group1` (`Sender`),
  CONSTRAINT `fk_email_support_group1` FOREIGN KEY (`Sender`) REFERENCES `support_group` (`SGroupId`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_email_ticket1` FOREIGN KEY (`TicketId`) REFERENCES `ticket` (`TId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_email_ticket_user2` FOREIGN KEY (`UserId`) REFERENCES `ticket_user` (`TUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forwarded`
--

DROP TABLE IF EXISTS `forwarded`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forwarded` (
  `Group` int(10) unsigned NOT NULL,
  `Ticket` int(10) unsigned NOT NULL,
  KEY `fk_forwarded_support_group1` (`Group`),
  KEY `fk_forwarded_ticket1` (`Ticket`),
  CONSTRAINT `fk_forwarded_support_group1` FOREIGN KEY (`Group`) REFERENCES `support_group` (`SGroupId`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_forwarded_ticket1` FOREIGN KEY (`Ticket`) REFERENCES `ticket` (`TId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forwarded`
--

LOCK TABLES `forwarded` WRITE;
/*!40000 ALTER TABLE `forwarded` DISABLE KEYS */;
/*!40000 ALTER TABLE `forwarded` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_group`
--

DROP TABLE IF EXISTS `in_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `in_group` (
  `Ticket_Group` int(10) unsigned NOT NULL,
  `Ticket` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Ticket_Group`,`Ticket`),
  KEY `fk_in_group_ticket_group_idx` (`Ticket_Group`),
  KEY `fk_in_group_ticket_idx` (`Ticket`),
  CONSTRAINT `fk_in_group_ticket` FOREIGN KEY (`Ticket`) REFERENCES `ticket` (`TId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_in_group_ticket_group` FOREIGN KEY (`Ticket_Group`) REFERENCES `ticket_group` (`TGroupId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_group`
--

LOCK TABLES `in_group` WRITE;
/*!40000 ALTER TABLE `in_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_support_group`
--

DROP TABLE IF EXISTS `in_support_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `in_support_group` (
  `User` int(10) unsigned NOT NULL,
  `Group` int(10) unsigned NOT NULL,
  KEY `fk_in_support_group_ticket_user1` (`User`),
  KEY `fk_in_support_group_support_group1` (`Group`),
  CONSTRAINT `fk_in_support_group_support_group1` FOREIGN KEY (`Group`) REFERENCES `support_group` (`SGroupId`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_in_support_group_ticket_user1` FOREIGN KEY (`User`) REFERENCES `ticket_user` (`TUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_support_group`
--

LOCK TABLES `in_support_group` WRITE;
/*!40000 ALTER TABLE `in_support_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_support_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `Id` int(10) NOT NULL AUTO_INCREMENT,
  `FileName` varchar(255) NOT NULL,
  `Name` varchar(56) NOT NULL,
  `Type` varchar(12) NOT NULL,
  `Owner` varchar(25) NOT NULL,
  `Permission` varchar(5) NOT NULL,
  `Status` int(11) NOT NULL DEFAULT 0,
  `Weight` int(11) NOT NULL DEFAULT 0,
  `Info` text DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES (1,'API_key_management','API_key_management','automatic','','admin',0,0,'{\"PluginName\":\"API Key Management\",\"Description\":\"Provides public access to the API\'s by generating access tokens.\",\"Version\":\"1.0.0\",\"Type\":\"automatic\",\"TemplatePath\":\"..\\/..\\/..\\/private_php\\/ams\\/plugins\\/API_key_management\\/templates\\/index.tpl\",\"\":null}'),(2,'Achievements','Achievements','Manual','','admin',0,0,'{\"PluginName\":\"Achievements\",\"Description\":\"Returns the achievements of a user with respect to the character\",\"Version\":\"1.0.0\",\"TemplatePath\":\"..\\/..\\/..\\/private_php\\/ams\\/plugins\\/Achievements\\/templates\\/index.tpl\",\"Type\":\"Manual\",\"\":null}'),(3,'Domain_Management','Domain_Management','Manual','','admin',1,0,'{\"PluginName\":\"Domain Management\",\"Description\":\"Plug-in for Domain Management.\",\"Version\":\"1.0.0\",\"TemplatePath\":\"..\\/..\\/..\\/private_php\\/ams\\/plugins\\/Domain_Management\\/templates\\/index.tpl\",\"Type\":\"Manual\",\"\":null}');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `idSettings` int(11) NOT NULL AUTO_INCREMENT,
  `Setting` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Value` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`idSettings`),
  UNIQUE KEY `idSettings` (`idSettings`),
  KEY `idSettings_2` (`idSettings`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'userRegistration','0'),(2,'Domain_Auto_Add','1');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `support_group`
--

DROP TABLE IF EXISTS `support_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `support_group` (
  `SGroupId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(22) NOT NULL,
  `Tag` varchar(7) NOT NULL,
  `GroupEmail` varchar(45) DEFAULT NULL,
  `IMAP_MailServer` varchar(60) DEFAULT NULL,
  `IMAP_Username` varchar(45) DEFAULT NULL,
  `IMAP_Password` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`SGroupId`),
  UNIQUE KEY `Name_UNIQUE` (`Name`),
  UNIQUE KEY `Tag_UNIQUE` (`Tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `support_group`
--

LOCK TABLES `support_group` WRITE;
/*!40000 ALTER TABLE `support_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `support_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `TagId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Value` varchar(60) NOT NULL,
  PRIMARY KEY (`TagId`),
  UNIQUE KEY `Value_UNIQUE` (`Value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagged`
--

DROP TABLE IF EXISTS `tagged`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagged` (
  `Ticket` int(10) unsigned NOT NULL,
  `Tag` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Ticket`,`Tag`),
  KEY `fk_tagged_tag_idx` (`Tag`),
  CONSTRAINT `fk_tagged_tag` FOREIGN KEY (`Tag`) REFERENCES `tag` (`TagId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tagged_ticket` FOREIGN KEY (`Ticket`) REFERENCES `ticket` (`TId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagged`
--

LOCK TABLES `tagged` WRITE;
/*!40000 ALTER TABLE `tagged` DISABLE KEYS */;
/*!40000 ALTER TABLE `tagged` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `TId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Title` varchar(120) NOT NULL,
  `Status` int(11) DEFAULT 0,
  `Queue` int(11) DEFAULT 0,
  `Ticket_Category` int(10) unsigned NOT NULL,
  `Author` int(10) unsigned NOT NULL,
  `Priority` int(3) DEFAULT 0,
  PRIMARY KEY (`TId`),
  KEY `fk_ticket_ticket_category_idx` (`Ticket_Category`),
  KEY `fk_ticket_ams_user_idx` (`Author`),
  CONSTRAINT `fk_ticket_ams_user` FOREIGN KEY (`Author`) REFERENCES `ticket_user` (`TUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_ticket_category` FOREIGN KEY (`Ticket_Category`) REFERENCES `ticket_category` (`TCategoryId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_attachments`
--

DROP TABLE IF EXISTS `ticket_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_attachments` (
  `idticket_attachments` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ticket_TId` int(10) unsigned NOT NULL,
  `Filename` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Filesize` int(10) NOT NULL,
  `Uploader` int(10) unsigned NOT NULL,
  `Path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`idticket_attachments`),
  UNIQUE KEY `idticket_attachments_UNIQUE` (`idticket_attachments`),
  KEY `fk_ticket_attachments_ticket1_idx` (`ticket_TId`),
  KEY `fk_ticket_attachments_ticket_user1_idx` (`Uploader`),
  CONSTRAINT `fk_ticket_attachments_ticket1` FOREIGN KEY (`ticket_TId`) REFERENCES `ticket` (`TId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_attachments_ticket_user1` FOREIGN KEY (`Uploader`) REFERENCES `ticket_user` (`TUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_attachments`
--

LOCK TABLES `ticket_attachments` WRITE;
/*!40000 ALTER TABLE `ticket_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_category`
--

DROP TABLE IF EXISTS `ticket_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_category` (
  `TCategoryId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`TCategoryId`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_category`
--

LOCK TABLES `ticket_category` WRITE;
/*!40000 ALTER TABLE `ticket_category` DISABLE KEYS */;
INSERT INTO `ticket_category` VALUES (2,'Hacking'),(3,'Ingame-Bug'),(5,'Installation'),(1,'Uncategorized'),(4,'Website-Bug');
/*!40000 ALTER TABLE `ticket_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_content`
--

DROP TABLE IF EXISTS `ticket_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_content` (
  `TContentId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Content` text DEFAULT NULL,
  PRIMARY KEY (`TContentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_content`
--

LOCK TABLES `ticket_content` WRITE;
/*!40000 ALTER TABLE `ticket_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_group`
--

DROP TABLE IF EXISTS `ticket_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_group` (
  `TGroupId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(80) NOT NULL,
  PRIMARY KEY (`TGroupId`),
  UNIQUE KEY `Title_UNIQUE` (`Title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_group`
--

LOCK TABLES `ticket_group` WRITE;
/*!40000 ALTER TABLE `ticket_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_info`
--

DROP TABLE IF EXISTS `ticket_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_info` (
  `TInfoId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Ticket` int(10) unsigned NOT NULL,
  `ShardId` int(11) DEFAULT NULL,
  `UserPosition` varchar(65) DEFAULT NULL,
  `ViewPosition` varchar(65) DEFAULT NULL,
  `ClientVersion` varchar(65) DEFAULT NULL,
  `PatchVersion` varchar(65) DEFAULT NULL,
  `ServerTick` varchar(40) DEFAULT NULL,
  `ConnectState` varchar(40) DEFAULT NULL,
  `LocalAddress` varchar(70) DEFAULT NULL,
  `Memory` varchar(60) DEFAULT NULL,
  `OS` varchar(120) DEFAULT NULL,
  `Processor` varchar(120) DEFAULT NULL,
  `CPUID` varchar(50) DEFAULT NULL,
  `CpuMask` varchar(50) DEFAULT NULL,
  `HT` varchar(35) DEFAULT NULL,
  `NeL3D` varchar(120) DEFAULT NULL,
  `PlayerName` varchar(45) DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL,
  `TimeInGame` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`TInfoId`),
  KEY `fk_ticket_info_ticket1` (`Ticket`),
  CONSTRAINT `fk_ticket_info_ticket1` FOREIGN KEY (`Ticket`) REFERENCES `ticket` (`TId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_info`
--

LOCK TABLES `ticket_info` WRITE;
/*!40000 ALTER TABLE `ticket_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_log`
--

DROP TABLE IF EXISTS `ticket_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_log` (
  `TLogId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Query` varchar(255) NOT NULL,
  `Ticket` int(10) unsigned NOT NULL,
  `Author` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`TLogId`),
  KEY `fk_ticket_log_ticket1` (`Ticket`),
  KEY `fk_ticket_log_ticket_user1` (`Author`),
  CONSTRAINT `fk_ticket_log_ticket1` FOREIGN KEY (`Ticket`) REFERENCES `ticket` (`TId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_log_ticket_user1` FOREIGN KEY (`Author`) REFERENCES `ticket_user` (`TUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_log`
--

LOCK TABLES `ticket_log` WRITE;
/*!40000 ALTER TABLE `ticket_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_reply`
--

DROP TABLE IF EXISTS `ticket_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_reply` (
  `TReplyId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Ticket` int(10) unsigned NOT NULL,
  `Author` int(10) unsigned NOT NULL,
  `Content` int(10) unsigned NOT NULL,
  `Timestamp` timestamp NULL DEFAULT NULL,
  `Hidden` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`TReplyId`),
  KEY `fk_ticket_reply_ticket_idx` (`Ticket`),
  KEY `fk_ticket_reply_ams_user_idx` (`Author`),
  KEY `fk_ticket_reply_content_idx` (`Content`),
  CONSTRAINT `fk_ticket_reply_ams_user` FOREIGN KEY (`Author`) REFERENCES `ticket_user` (`TUserId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_reply_ticket` FOREIGN KEY (`Ticket`) REFERENCES `ticket` (`TId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_reply_ticket_content` FOREIGN KEY (`Content`) REFERENCES `ticket_content` (`TContentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_reply`
--

LOCK TABLES `ticket_reply` WRITE;
/*!40000 ALTER TABLE `ticket_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_user`
--

DROP TABLE IF EXISTS `ticket_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_user` (
  `TUserId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Permission` int(3) NOT NULL DEFAULT 1,
  `ExternId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`TUserId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_user`
--

LOCK TABLES `ticket_user` WRITE;
/*!40000 ALTER TABLE `ticket_user` DISABLE KEYS */;
INSERT INTO `ticket_user` VALUES (1,3,1),(2,1,2);
/*!40000 ALTER TABLE `ticket_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updates`
--

DROP TABLE IF EXISTS `updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updates` (
  `s.no` int(10) NOT NULL AUTO_INCREMENT,
  `PluginId` int(10) DEFAULT NULL,
  `UpdatePath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UpdateInfo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`s.no`),
  KEY `PluginId` (`PluginId`),
  CONSTRAINT `updates_ibfk_1` FOREIGN KEY (`PluginId`) REFERENCES `plugins` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updates`
--

LOCK TABLES `updates` WRITE;
/*!40000 ALTER TABLE `updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `updates` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

