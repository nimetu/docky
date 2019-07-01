-- MySQL dump 10.17  Distrib 10.3.15-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: db.ryzomcore.local    Database: ring_shard01
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
-- Table structure for table `characters`
--

CREATE DATABASE `ring_shard01`;
use `ring_shard01`;

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characters` (
  `char_id` int(10) unsigned NOT NULL DEFAULT 0,
  `char_name` varchar(20) NOT NULL DEFAULT '',
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `guild_id` int(10) unsigned NOT NULL DEFAULT 0,
  `best_combat_level` int(10) unsigned NOT NULL DEFAULT 0,
  `home_mainland_session_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ring_access` varchar(63) NOT NULL DEFAULT '',
  `race` enum('r_fyros','r_matis','r_tryker','r_zorai') NOT NULL DEFAULT 'r_fyros',
  `civilisation` enum('c_neutral','c_fyros','c_fyros','c_matis','c_tryker','c_zorai') NOT NULL DEFAULT 'c_neutral',
  `cult` enum('c_neutral','c_kami','c_karavan') NOT NULL DEFAULT 'c_neutral',
  `current_session` int(11) unsigned NOT NULL DEFAULT 0,
  `rrp_am` int(11) unsigned NOT NULL DEFAULT 0,
  `rrp_masterless` int(11) unsigned NOT NULL DEFAULT 0,
  `rrp_author` int(11) unsigned NOT NULL DEFAULT 0,
  `newcomer` tinyint(1) NOT NULL DEFAULT 1,
  `creation_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_played_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`char_id`),
  UNIQUE KEY `char_name_idx` (`char_name`,`home_mainland_session_id`),
  KEY `user_id_idx` (`user_id`),
  KEY `guild_idx` (`guild_id`),
  KEY `guild_id_idx` (`guild_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folder`
--

DROP TABLE IF EXISTS `folder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folder` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner` int(10) unsigned NOT NULL DEFAULT 0,
  `title` varchar(40) NOT NULL DEFAULT '',
  `comments` text NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `owner_idx` (`owner`),
  KEY `title_idx` (`title`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folder`
--

LOCK TABLES `folder` WRITE;
/*!40000 ALTER TABLE `folder` DISABLE KEYS */;
/*!40000 ALTER TABLE `folder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folder_access`
--

DROP TABLE IF EXISTS `folder_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folder_access` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `folder_id` int(10) unsigned NOT NULL DEFAULT 0,
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `folder_id_idx` (`folder_id`),
  KEY `user_idx` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folder_access`
--

LOCK TABLES `folder_access` WRITE;
/*!40000 ALTER TABLE `folder_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `folder_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guild_invites`
--

DROP TABLE IF EXISTS `guild_invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_invites` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(10) unsigned NOT NULL DEFAULT 0,
  `guild_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `guild_id_idx` (`guild_id`),
  KEY `session_id_idx` (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_invites`
--

LOCK TABLES `guild_invites` WRITE;
/*!40000 ALTER TABLE `guild_invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `guild_invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guilds`
--

DROP TABLE IF EXISTS `guilds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guilds` (
  `guild_id` int(10) unsigned NOT NULL DEFAULT 0,
  `guild_name` varchar(50) NOT NULL DEFAULT '',
  `shard_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`guild_id`),
  KEY `shard_id_idx` (`shard_id`),
  KEY `guild_name_idx` (`guild_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guilds`
--

LOCK TABLES `guilds` WRITE;
/*!40000 ALTER TABLE `guilds` DISABLE KEYS */;
/*!40000 ALTER TABLE `guilds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_entry`
--

DROP TABLE IF EXISTS `journal_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_entry` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(10) unsigned NOT NULL DEFAULT 0,
  `author` int(10) unsigned NOT NULL DEFAULT 0,
  `type` enum('jet_credits','jet_notes') NOT NULL DEFAULT 'jet_notes',
  `text` text NOT NULL,
  `time_stamp` datetime NOT NULL DEFAULT '2005-09-07 12:41:33',
  PRIMARY KEY (`Id`),
  KEY `session_id_idx` (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_entry`
--

LOCK TABLES `journal_entry` WRITE;
/*!40000 ALTER TABLE `journal_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `journal_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `known_users`
--

DROP TABLE IF EXISTS `known_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `known_users` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `owner` int(10) unsigned NOT NULL DEFAULT 0,
  `targer_user` int(10) unsigned NOT NULL DEFAULT 0,
  `targer_character` int(10) unsigned NOT NULL DEFAULT 0,
  `relation_type` enum('rt_friend','rt_banned','rt_friend_dm') NOT NULL DEFAULT 'rt_friend',
  `comments` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`),
  KEY `user_index` (`owner`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `known_users`
--

LOCK TABLES `known_users` WRITE;
/*!40000 ALTER TABLE `known_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `known_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfs_erased_mail_series`
--

DROP TABLE IF EXISTS `mfs_erased_mail_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfs_erased_mail_series` (
  `erased_char_id` int(11) unsigned NOT NULL DEFAULT 0,
  `erased_char_name` varchar(32) NOT NULL DEFAULT '',
  `erased_series` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `erase_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`erased_series`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfs_erased_mail_series`
--

LOCK TABLES `mfs_erased_mail_series` WRITE;
/*!40000 ALTER TABLE `mfs_erased_mail_series` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfs_erased_mail_series` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfs_guild_thread`
--

DROP TABLE IF EXISTS `mfs_guild_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfs_guild_thread` (
  `thread_id` int(11) NOT NULL AUTO_INCREMENT,
  `guild_id` int(11) unsigned NOT NULL DEFAULT 0,
  `topic` varchar(255) NOT NULL DEFAULT '',
  `author_name` varchar(32) NOT NULL DEFAULT '',
  `last_post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_count` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`thread_id`),
  KEY `guild_index` (`guild_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfs_guild_thread`
--

LOCK TABLES `mfs_guild_thread` WRITE;
/*!40000 ALTER TABLE `mfs_guild_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfs_guild_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfs_guild_thread_message`
--

DROP TABLE IF EXISTS `mfs_guild_thread_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfs_guild_thread_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) unsigned NOT NULL DEFAULT 0,
  `author_name` varchar(32) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfs_guild_thread_message`
--

LOCK TABLES `mfs_guild_thread_message` WRITE;
/*!40000 ALTER TABLE `mfs_guild_thread_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfs_guild_thread_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfs_mail`
--

DROP TABLE IF EXISTS `mfs_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfs_mail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_name` varchar(32) NOT NULL DEFAULT '',
  `subject` varchar(250) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` enum('ms_new','ms_read','ms_erased') NOT NULL DEFAULT 'ms_new',
  `dest_char_id` int(11) unsigned NOT NULL DEFAULT 0,
  `erase_series` int(11) unsigned NOT NULL DEFAULT 0,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dest_index` (`dest_char_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfs_mail`
--

LOCK TABLES `mfs_mail` WRITE;
/*!40000 ALTER TABLE `mfs_mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfs_mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outlands`
--

DROP TABLE IF EXISTS `outlands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outlands` (
  `session_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `island_name` text NOT NULL,
  `billing_instance_id` int(11) unsigned NOT NULL DEFAULT 0,
  `anim_session_id` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outlands`
--

LOCK TABLES `outlands` WRITE;
/*!40000 ALTER TABLE `outlands` DISABLE KEYS */;
/*!40000 ALTER TABLE `outlands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_rating`
--

DROP TABLE IF EXISTS `player_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_rating` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `scenario_id` int(10) unsigned NOT NULL DEFAULT 0,
  `session_id` int(10) unsigned NOT NULL DEFAULT 0,
  `rate_fun` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rate_difficulty` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rate_accessibility` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rate_originality` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rate_direction` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `author` int(10) unsigned NOT NULL DEFAULT 0,
  `rating` int(10) NOT NULL DEFAULT 0,
  `comments` text NOT NULL,
  `time_stamp` datetime NOT NULL DEFAULT '2005-09-07 12:41:33',
  PRIMARY KEY (`Id`),
  KEY `session_id_idx` (`scenario_id`),
  KEY `author_idx` (`author`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_rating`
--

LOCK TABLES `player_rating` WRITE;
/*!40000 ALTER TABLE `player_rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ring_users`
--

DROP TABLE IF EXISTS `ring_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ring_users` (
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `user_name` varchar(20) NOT NULL DEFAULT '',
  `user_type` enum('ut_character','ut_pioneer') NOT NULL DEFAULT 'ut_character',
  `current_session` int(10) unsigned NOT NULL DEFAULT 0,
  `current_activity` enum('ca_none','ca_play','ca_edit','ca_anim') NOT NULL DEFAULT 'ca_none',
  `current_status` enum('cs_offline','cs_logged','cs_online') NOT NULL DEFAULT 'cs_offline',
  `public_level` enum('ul_none','ul_public') NOT NULL DEFAULT 'ul_none',
  `account_type` enum('at_normal','at_gold') NOT NULL DEFAULT 'at_normal',
  `content_access_level` varchar(20) NOT NULL DEFAULT '',
  `description` text NOT NULL DEFAULT '',
  `lang` enum('lang_en','lang_fr','lang_de') NOT NULL DEFAULT 'lang_en',
  `cookie` varchar(30) NOT NULL DEFAULT '',
  `current_domain_id` int(10) NOT NULL DEFAULT -1,
  `pioneer_char_id` int(11) unsigned NOT NULL DEFAULT 0,
  `current_char` int(11) NOT NULL DEFAULT 0,
  `add_privileges` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name_idx` (`user_name`),
  KEY `cookie_idx` (`cookie`),
  KEY `current_session_idx` (`current_session`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ring_users`
--

LOCK TABLES `ring_users` WRITE;
/*!40000 ALTER TABLE `ring_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `ring_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scenario`
--

DROP TABLE IF EXISTS `scenario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `md5` varchar(64) NOT NULL DEFAULT '',
  `title` varchar(32) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `author` varchar(32) NOT NULL DEFAULT '',
  `rrp_total` int(11) unsigned NOT NULL DEFAULT 0,
  `anim_mode` enum('am_dm','am_autonomous') NOT NULL DEFAULT 'am_dm',
  `language` varchar(11) NOT NULL DEFAULT '',
  `orientation` enum('so_newbie_training','so_story_telling','so_mistery','so_hack_slash','so_guild_training','so_other') NOT NULL DEFAULT 'so_other',
  `level` enum('sl_a','sl_b','sl_c','sl_d','sl_e','sl_f') NOT NULL DEFAULT 'sl_a',
  `allow_free_trial` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenario`
--

LOCK TABLES `scenario` WRITE;
/*!40000 ALTER TABLE `scenario` DISABLE KEYS */;
/*!40000 ALTER TABLE `scenario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scenario_desc`
--

DROP TABLE IF EXISTS `scenario_desc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenario_desc` (
  `session_id` int(10) unsigned NOT NULL DEFAULT 0,
  `parent_scenario` int(10) unsigned NOT NULL DEFAULT 0,
  `description` text NOT NULL,
  `relation_to_parent` enum('rtp_same','rtp_variant','rtp_different') NOT NULL DEFAULT 'rtp_same',
  `title` varchar(40) NOT NULL DEFAULT '',
  `num_player` int(10) unsigned NOT NULL DEFAULT 0,
  `content_access_level` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `title_idx` (`title`),
  KEY `parent_idx` (`parent_scenario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scenario_desc`
--

LOCK TABLES `scenario_desc` WRITE;
/*!40000 ALTER TABLE `scenario_desc` DISABLE KEYS */;
/*!40000 ALTER TABLE `scenario_desc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_log`
--

DROP TABLE IF EXISTS `session_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_log` (
  `id` int(11) NOT NULL DEFAULT 0,
  `scenario_id` int(11) unsigned NOT NULL DEFAULT 0,
  `rrp_scored` int(11) unsigned NOT NULL DEFAULT 0,
  `scenario_point_scored` int(11) unsigned NOT NULL DEFAULT 0,
  `time_taken` int(11) unsigned NOT NULL DEFAULT 0,
  `participants` text NOT NULL,
  `launch_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `owner` varchar(32) NOT NULL DEFAULT '0',
  `guild_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_log`
--

LOCK TABLES `session_log` WRITE;
/*!40000 ALTER TABLE `session_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `session_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_participant`
--

DROP TABLE IF EXISTS `session_participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_participant` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(10) unsigned NOT NULL DEFAULT 0,
  `char_id` int(10) unsigned NOT NULL DEFAULT 0,
  `status` enum('sps_play_subscribed','sps_play_invited','sps_edit_invited','sps_anim_invited','sps_playing','sps_editing','sps_animating') NOT NULL DEFAULT 'sps_play_subscribed',
  `kicked` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `session_rated` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `session_idx` (`session_id`),
  KEY `user_idx` (`char_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_participant`
--

LOCK TABLES `session_participant` WRITE;
/*!40000 ALTER TABLE `session_participant` DISABLE KEYS */;
/*!40000 ALTER TABLE `session_participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `session_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_type` enum('st_edit','st_anim','st_outland','st_mainland') NOT NULL DEFAULT 'st_edit',
  `title` varchar(40) NOT NULL DEFAULT '',
  `owner` int(10) unsigned NOT NULL DEFAULT 0,
  `plan_date` datetime NOT NULL DEFAULT '2005-09-21 12:41:33',
  `start_date` datetime NOT NULL DEFAULT '2005-08-31 00:00:00',
  `description` text NOT NULL,
  `orientation` enum('so_newbie_training','so_story_telling','so_mistery','so_hack_slash','so_guild_training','so_other') NOT NULL DEFAULT 'so_other',
  `level` enum('sl_a','sl_b','sl_c','sl_d','sl_e','sl_f') NOT NULL DEFAULT 'sl_a',
  `rule_type` enum('rt_strict','rt_liberal') NOT NULL DEFAULT 'rt_strict',
  `access_type` enum('at_public','at_private') NOT NULL DEFAULT 'at_private',
  `state` enum('ss_planned','ss_open','ss_locked','ss_closed') NOT NULL DEFAULT 'ss_planned',
  `host_shard_id` int(11) NOT NULL DEFAULT 0,
  `subscription_slots` int(11) unsigned NOT NULL DEFAULT 0,
  `reserved_slots` int(10) unsigned NOT NULL DEFAULT 0,
  `free_slots` int(10) unsigned NOT NULL DEFAULT 0,
  `estimated_duration` enum('et_short','et_medium','et_long') NOT NULL DEFAULT 'et_short',
  `final_duration` int(10) unsigned NOT NULL DEFAULT 0,
  `folder_id` int(10) unsigned NOT NULL DEFAULT 0,
  `lang` varchar(20) NOT NULL DEFAULT '',
  `icone` varchar(70) NOT NULL DEFAULT '',
  `anim_mode` enum('am_dm','am_autonomous') NOT NULL DEFAULT 'am_dm',
  `race_filter` set('rf_fyros','rf_matis','rf_tryker','rf_zorai') NOT NULL DEFAULT '',
  `religion_filter` set('rf_kami','rf_karavan','rf_neutral') NOT NULL DEFAULT '',
  `guild_filter` enum('gf_only_my_guild','gf_any_player') DEFAULT 'gf_only_my_guild',
  `shard_filter` set('sf_shard00','sf_shard01','sf_shard02','sf_shard03','sf_shard04','sf_shard05','sf_shard06','sf_shard07','sf_shard08','sf_shard09','sf_shard10','sf_shard11','sf_shard12','sf_shard13','sf_shard14','sf_shard15','sf_shard16','sf_shard17','sf_shard18','sf_shard19','sf_shard20','sf_shard21','sf_shard22','sf_shard23','sf_shard24','sf_shard25','sf_shard26','sf_shard27','sf_shard28','sf_shard29','sf_shard30','sf_shard31') NOT NULL DEFAULT 'sf_shard00,sf_shard01,sf_shard02,sf_shard03,sf_shard04,sf_shard05,sf_shard06,sf_shard07,sf_shard08,sf_shard09,sf_shard10,sf_shard11,sf_shard12,sf_shard13,sf_shard14,sf_shard15,sf_shard16,sf_shard17,sf_shard18,sf_shard19,sf_shard20,sf_shard21,sf_shard22,sf_shard23,sf_shard24,sf_shard25,sf_shard26,sf_shard27,sf_shard28,sf_shard29,sf_shard30,sf_shard31',
  `level_filter` set('lf_a','lf_b','lf_c','lf_d','lf_e','lf_f') NOT NULL DEFAULT 'lf_a,lf_b,lf_c,lf_d,lf_e,lf_f',
  `subscription_closed` tinyint(1) NOT NULL DEFAULT 0,
  `newcomer` tinyint(1) unsigned zerofill NOT NULL DEFAULT 0,
  PRIMARY KEY (`session_id`),
  KEY `owner_idx` (`owner`),
  KEY `folder_idx` (`folder_id`),
  KEY `state_type_idx` (`state`,`session_type`)
) ENGINE=MyISAM AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shard`
--

DROP TABLE IF EXISTS `shard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shard` (
  `shard_id` int(10) NOT NULL DEFAULT 0,
  `WSOnline` tinyint(1) NOT NULL DEFAULT 0,
  `MOTD` text NOT NULL,
  `OldState` enum('ds_close','ds_dev','ds_restricted','ds_open') NOT NULL DEFAULT 'ds_restricted',
  `RequiredState` enum('ds_close','ds_dev','ds_restricted','ds_open') NOT NULL DEFAULT 'ds_dev',
  PRIMARY KEY (`shard_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shard`
--

LOCK TABLES `shard` WRITE;
/*!40000 ALTER TABLE `shard` DISABLE KEYS */;
/*!40000 ALTER TABLE `shard` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

