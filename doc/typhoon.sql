-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: typhoon
-- ------------------------------------------------------
-- Server version	5.7.35-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `base_auth_function`
--

DROP TABLE IF EXISTS `base_auth_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_auth_function` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `route` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `route_UNIQUE` (`route`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_auth_function`
--

LOCK TABLES `base_auth_function` WRITE;
/*!40000 ALTER TABLE `base_auth_function` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_auth_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_auth_module`
--

DROP TABLE IF EXISTS `base_auth_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_auth_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `order` int(11) NOT NULL,
  `icon` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_auth_module`
--

LOCK TABLES `base_auth_module` WRITE;
/*!40000 ALTER TABLE `base_auth_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_auth_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_auth_page`
--

DROP TABLE IF EXISTS `base_auth_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_auth_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `route` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `order` int(11) NOT NULL,
  `icon` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `visible` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_auth_page`
--

LOCK TABLES `base_auth_page` WRITE;
/*!40000 ALTER TABLE `base_auth_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_auth_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_config`
--

DROP TABLE IF EXISTS `base_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `code` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `memo` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_config`
--

LOCK TABLES `base_config` WRITE;
/*!40000 ALTER TABLE `base_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_config_group`
--

DROP TABLE IF EXISTS `base_config_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_config_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `type` int(11) NOT NULL COMMENT '0 SYSTEM 1 CUSTOM',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_config_group`
--

LOCK TABLES `base_config_group` WRITE;
/*!40000 ALTER TABLE `base_config_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_config_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_department`
--

DROP TABLE IF EXISTS `base_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `code` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `status` int(11) NOT NULL,
  `memo` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_department`
--

LOCK TABLES `base_department` WRITE;
/*!40000 ALTER TABLE `base_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_i18n`
--

DROP TABLE IF EXISTS `base_i18n`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(11) NOT NULL,
  `code` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `text_en` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `text_zh` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_i18n`
--

LOCK TABLES `base_i18n` WRITE;
/*!40000 ALTER TABLE `base_i18n` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_i18n` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_i18n_module`
--

DROP TABLE IF EXISTS `base_i18n_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_i18n_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `type` int(11) NOT NULL COMMENT '0 SYSTEM 1 CUSTOM',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_i18n_module`
--

LOCK TABLES `base_i18n_module` WRITE;
/*!40000 ALTER TABLE `base_i18n_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_i18n_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_lov`
--

DROP TABLE IF EXISTS `base_lov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_lov` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `code` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_lov`
--

LOCK TABLES `base_lov` WRITE;
/*!40000 ALTER TABLE `base_lov` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_lov` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_lov_group`
--

DROP TABLE IF EXISTS `base_lov_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_lov_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_lov_group`
--

LOCK TABLES `base_lov_group` WRITE;
/*!40000 ALTER TABLE `base_lov_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_lov_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_lov_value`
--

DROP TABLE IF EXISTS `base_lov_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_lov_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lov_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `value` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `order` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `memo` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_lov_value`
--

LOCK TABLES `base_lov_value` WRITE;
/*!40000 ALTER TABLE `base_lov_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_lov_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_role`
--

DROP TABLE IF EXISTS `base_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `auth` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_role`
--

LOCK TABLES `base_role` WRITE;
/*!40000 ALTER TABLE `base_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_station`
--

DROP TABLE IF EXISTS `base_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `code` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `status` int(11) NOT NULL,
  `memo` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_station`
--

LOCK TABLES `base_station` WRITE;
/*!40000 ALTER TABLE `base_station` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_token`
--

DROP TABLE IF EXISTS `base_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_account` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `ip` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `ua` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `token` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `issued_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expired_at` datetime NOT NULL,
  `last_active_time` datetime NOT NULL,
  `revoked` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_token`
--

LOCK TABLES `base_token` WRITE;
/*!40000 ALTER TABLE `base_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_user`
--

DROP TABLE IF EXISTS `base_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `gender` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `birth` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `mobile` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `department` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `station` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `status` int(11) NOT NULL,
  `memo` varchar(512) COLLATE utf8mb4_bin NOT NULL,
  `last_login` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_user`
--

LOCK TABLES `base_user` WRITE;
/*!40000 ALTER TABLE `base_user` DISABLE KEYS */;
INSERT INTO `base_user` VALUES (1,'zhangjun01','e10adc3949ba59abbe56e057f20f883e','958','张俊','男','1984-12-16','zhangjun01@hesaitech.com','13761019032','0','0',0,'','','2022-03-02 09:48:17','','2022-03-02 09:56:58','');
/*!40000 ALTER TABLE `base_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_user_role`
--

DROP TABLE IF EXISTS `base_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_user_role`
--

LOCK TABLES `base_user_role` WRITE;
/*!40000 ALTER TABLE `base_user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `base_user_station`
--

DROP TABLE IF EXISTS `base_user_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `base_user_station` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `is_main` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(32) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `base_user_station`
--

LOCK TABLES `base_user_station` WRITE;
/*!40000 ALTER TABLE `base_user_station` DISABLE KEYS */;
/*!40000 ALTER TABLE `base_user_station` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-07 19:20:44
