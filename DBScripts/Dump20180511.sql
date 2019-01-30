-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: events
-- ------------------------------------------------------
-- Server version	5.6.33

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
-- Table structure for table `__migrationhistory`
--

DROP TABLE IF EXISTS `__migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__migrationhistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ContextKey` varchar(300) NOT NULL,
  `Model` longblob NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__migrationhistory`
--

LOCK TABLES `__migrationhistory` WRITE;
/*!40000 ALTER TABLE `__migrationhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `__migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetroles`
--

DROP TABLE IF EXISTS `aspnetroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aspnetroles` (
  `Id` varchar(128) NOT NULL,
  `Name` varchar(128) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`Name`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetroles`
--

LOCK TABLES `aspnetroles` WRITE;
/*!40000 ALTER TABLE `aspnetroles` DISABLE KEYS */;
INSERT INTO `aspnetroles` VALUES ('a94dcce1-c1ee-40a3-a20b-534939244d92','Administrator'),('e0a97b06-eda1-45d0-85b0-9b3e96b2501f','Leader'),('0811d9e2-5db7-4bb4-a310-48834862aeb8','Super User'),('0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35','User');
/*!40000 ALTER TABLE `aspnetroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetuserclaims`
--

DROP TABLE IF EXISTS `aspnetuserclaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aspnetuserclaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(128) NOT NULL,
  `ClaimType` longtext,
  `ClaimValue` longtext,
  PRIMARY KEY (`Id`),
  KEY `IX_UserId` (`UserId`) USING HASH,
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetuserclaims`
--

LOCK TABLES `aspnetuserclaims` WRITE;
/*!40000 ALTER TABLE `aspnetuserclaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserclaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetuserlogins`
--

DROP TABLE IF EXISTS `aspnetuserlogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aspnetuserlogins` (
  `LoginProvider` varchar(128) NOT NULL,
  `ProviderKey` varchar(128) NOT NULL,
  `UserId` varchar(128) NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`,`UserId`),
  KEY `IX_UserId` (`UserId`) USING HASH,
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetuserlogins`
--

LOCK TABLES `aspnetuserlogins` WRITE;
/*!40000 ALTER TABLE `aspnetuserlogins` DISABLE KEYS */;
/*!40000 ALTER TABLE `aspnetuserlogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetuserroles`
--

DROP TABLE IF EXISTS `aspnetuserroles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aspnetuserroles` (
  `UserId` varchar(128) NOT NULL,
  `RoleId` varchar(128) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_UserId` (`UserId`) USING HASH,
  KEY `IX_RoleId` (`RoleId`) USING HASH,
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetuserroles`
--

LOCK TABLES `aspnetuserroles` WRITE;
/*!40000 ALTER TABLE `aspnetuserroles` DISABLE KEYS */;
INSERT INTO `aspnetuserroles` VALUES ('00eba7fe-58fd-46d5-8db2-9f69c557e765','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('00ed25c9-7f73-4dd5-8a15-f6a82953934a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('027b0254-950c-488c-a2f0-45e95ed633a2','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('027c3a0b-41af-486b-afb7-58ae6be81963','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('02d6e4e8-d491-42b7-b0f7-3a6e8096f44b','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('045ffd11-26f8-48f4-ac6e-42aebc4f5d9b','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('0517def0-4682-432f-be56-5a132c7a5a13','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('06298a8d-c555-4c2c-8694-1445f9e007e1','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('07085b0f-75aa-4f8f-811b-42d6bbb20d75','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('07bc8c87-1771-441a-8519-abfcd89e6f6a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('0a093e08-a411-4fc6-8db9-aaab639601e0','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('0a290298-1658-47f0-95d0-e2f663cbf971','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('0ac6ee96-66cd-469a-a7a6-fd45ca1bd266','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('0baa0786-cf75-4b19-9abc-2120b39d96a2','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('0f4cfe52-3050-44d3-b228-5f822dd5dd75','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('0f4f225c-e241-481d-bc1b-634c44ee10d2','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('0f50f193-b477-4623-9284-f95c1f295729','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('101b293c-e0a4-4e6f-b939-857110ed71bd','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1077dfbc-6521-465f-9c07-390f00472131','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1460b2c9-23a9-439d-b88e-91282130a080','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('14d52cc9-7780-4630-b721-a4f54e1755ac','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('16a8a528-3a1f-45ca-b4f4-86c6a0b83ff2','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1748e932-04f4-449a-b677-25681d63120a','a94dcce1-c1ee-40a3-a20b-534939244d92'),('18c8dc1f-4d50-4d66-85ae-29fac05f0767','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('19a8b3da-19b8-4743-85a4-b7b3c1d45d5e','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('19b194b1-e689-4947-b418-69e5608877ef','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1ad48d61-bbcc-4f82-adbf-a3e45bd7f031','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1b388a36-a3ed-4feb-806c-e18d61981803','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1ba4c90a-163e-4e7f-85b2-c106813ca171','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1be33843-8af4-4a6f-8e5c-6e9d5614f801','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1e381f3b-61f7-4957-a1e6-b4ec8f72437e','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1eb3070f-1c1f-4021-8930-c31c9877f612','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1ebf9561-0178-48fb-bb2b-67987d0216a7','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('1f50ce58-1bc9-4f28-9e91-a8679a06fc7f','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('20cbb424-269d-4910-8b06-e870508089e5','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('211707fa-e981-4e28-81eb-71a44d0d64f7','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('21ea514e-e7bc-423e-ac77-95e1dba4f6b8','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('21f6aa27-5729-49d7-999d-ce7e188a2973','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('224ca510-c670-4540-9ebb-fe4dade6c0d3','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('22c6bfd9-41e8-435b-a1c2-e63f12595dd3','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('239249a7-0b34-42b3-9b31-9e2df9394a98','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('26a83b69-9630-403e-9dc7-4a10c39d56bf','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('27312fad-e13a-4f50-bd77-16c703c08f67','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('292325f7-e402-40da-9b95-c0a5114fb08b','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('29a56afd-3b27-4ee4-8b8d-f0a1db19b1dd','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('2aa1831d-83d8-4813-8536-0fb6d9ea30f4','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('2b102fd2-08b0-4fa2-983e-c04565f77463','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('30eddd4b-fbb9-4b7b-9f3d-010903c25923','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('314b3ba3-f01e-4256-872d-c07900d871bd','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('31c04f57-2034-4c70-afa3-6780cae9d64c','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('344b2f8f-e154-4d49-a486-6800f54e9752','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('35ac786d-c1c4-4fc8-98e7-20d7321aa8bd','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('3646a56a-d0fb-4569-8afc-83e7774fb053','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('3748f54e-1cc5-45f4-a7d5-b1cb77028f00','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('37d0e4b7-a905-4b3b-9048-3dad4a52e1fc','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('37efde0c-7727-42c9-af7f-d02fecd7073f','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('37efde0c-7727-42c9-af7f-d02fecd7073f','a94dcce1-c1ee-40a3-a20b-534939244d92'),('384bb297-d745-44b0-be74-faf235f2c7c9','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('38fb656b-dc16-4b2a-ba82-2d22d7ac654d','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('3b7e9783-43ad-4c3d-81b4-fe809a15df10','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('3e58cc4f-6898-4d8c-9731-a84dc89f2f2d','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('3e639382-c3b7-48a6-8551-89625dfc4e2c','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('3e67318d-7be6-4b4a-a024-fea248072e46','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('3f023c6a-02b6-4994-a9f8-e7208d32fb1b','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('40ff39df-73ba-44e2-b1ec-120a46e1ed5c','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('43d1853d-01bb-44a0-871c-044d65cd8aad','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('43dba1a7-9cd9-4594-894f-beed545b5ccb','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('44f8fb5e-f8a3-48a1-afba-1d27f240752b','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('45bd793e-6581-4542-9b79-99a7e88ab70c','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('4b78caa6-943d-4a57-a6ad-930b9fec9e08','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('4d605084-1054-4585-b401-361a56ef3a68','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('4e8966ed-5c90-44dc-907c-68ca0a6fa4ed','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('4ef3139a-9301-4331-8642-059eda722546','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('4f7f446b-a8b3-422e-8886-d20c3a4dee30','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('524d95a4-e506-4489-8402-122869902992','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('5494ec32-ba5e-445f-9936-907106a6256b','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('54a212ce-ea20-4347-a169-76f72905aba3','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('56184658-1de8-4c51-a433-cc870a757e16','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('56543503-4fa5-4f00-899e-9c48ec0802ac','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('57e2bf40-eb26-46ae-9fa9-3a3cb8137144','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('57fb10d2-de8e-4e35-b4b8-5034427f0433','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('5dbef02c-3b93-4c55-9971-63b44478c1c9','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('5efb75f5-390e-4dd9-92e7-4c5294d6841a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('6281692a-5c46-4f0e-88c8-00176d4fd320','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('62869908-34d2-43aa-a13c-7c8796eb9742','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('629fa4f3-c681-4044-9cff-6c2b0f08d2af','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('635c7f5d-50b5-46bf-9cde-33f9d1fe939c','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('64acf003-8222-40ce-9918-87af63d72b14','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('6598cc40-8b32-40e2-98e5-20973dee1aec','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('65aa4a33-cf54-4e10-831a-a4a5c14321d2','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('65e78625-6f04-4580-b490-8f30a30aba2a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('691a0468-3e44-42f7-8181-f51bd92604a4','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('6a7de375-00f4-49fe-986f-e7f407a4ea27','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('6aed5c05-b2cb-40e2-a26d-dbdf184ad864','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('6c232435-c11a-4ee0-8249-f62409a64d4c','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('6dd257e5-9f1f-4df9-84be-bf57bb1e9085','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('705a5c1b-af41-4b66-bfa7-c55c4d80a78a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('70d6accd-e02b-4d4c-a588-05bca3da7ce7','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('71789443-abf1-4a84-903f-e733ba3cb1d0','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('7b7423a9-c4a1-4ebd-9f7d-6d5a6759b454','e0a97b06-eda1-45d0-85b0-9b3e96b2501f'),('7bac523d-c4c4-457a-9b8e-8dc780417e84','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('7d898ec5-46b3-40de-8659-286882b5abf1','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('7ff58362-eb84-4b16-a2ec-8c724340d3b0','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('82c013da-8935-4573-9ecf-3242af4ef143','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('8454a5cb-eb52-46fe-b939-23594990a158','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('84e2f38c-4cf6-4ac5-9d3e-ea77c34322c1','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('84fea538-0b08-4768-9787-555af9d1d446','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('85ebbc73-ce79-409e-beeb-039d72d92234','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('89e6623b-9e50-404e-a3cc-2beec17ca3f2','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('8b7f96ab-7336-47ce-a8d7-72ec80ba4602','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('8befbf7b-b965-4970-843f-bb1ee96a47b9','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('8bf2f8da-f88a-4c37-8fc6-f2f20976809d','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('8bff64d1-8f56-4d72-a452-ab5094b9aaaa','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('8ca9f18b-dc83-47a6-b16a-625b836abb29','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('8db7c6aa-24e4-41fc-8b3d-84ee11abd0ff','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('8fd7dc00-62be-469d-9273-aa279cdcedaf','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('9006b136-ee19-42a4-a99a-72e281a445f1','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('90e9f1b7-a701-457d-ba42-4b795ddb093d','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('93ae4117-4290-42f2-8d49-706e58e85eed','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('93fd2d67-d2d4-4721-935a-8ace37c81b38','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('94b3e66b-efd9-4b20-a01e-5ceaa0f25e09','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('956d3fb2-f870-4a49-ac35-95f71bf41228','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('956d3fb2-f870-4a49-ac35-95f71bf41228','e0a97b06-eda1-45d0-85b0-9b3e96b2501f'),('96ca08f5-94f9-4a6e-9fa4-a2d715b6e729','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('9870dc6c-e8e6-482e-aae6-c74e8b4b6bbb','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('988aa69b-96eb-41b4-93cd-66b99562e9c4','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('9a15e243-7441-444a-a445-64f8dbc9fab4','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('9effa591-c078-4828-b290-914d456c2943','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('9f357deb-5b1e-4fdb-a1c5-4affeeea43f4','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('9f4ebc6e-da0b-414d-b09f-f385c2353be3','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a02dae7b-ca1a-4669-a1b5-def033a815cc','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a05b85b7-f4a5-4961-885b-a7948f25960c','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a2794caa-344a-4a61-9419-e829e9d7b3da','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a2b96ccd-b82c-4159-b2af-f8c83fe0f2ab','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a3443ba5-b5d6-47b1-831d-799c1ff19117','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a63e5840-d00c-48c1-9e38-4ca0d517c5b6','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a68de879-40c7-4869-8a67-91509ce726a5','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a7f18707-9f59-4a25-92aa-01bb0d620522','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a96e1a1d-f192-4ba4-b5f6-5740a6fe015d','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('a9d7bf94-6c4e-4f1c-9cac-a29a8f78dd12','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('abcc4d55-ed58-4861-97b4-706b3e13eaec','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('acfff69c-47d6-4089-902a-b1d4fedbf0c5','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('adf31776-af06-41f0-8da7-3259af1b3625','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('aeacca57-3b29-49b3-bccf-040d1df072ee','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('af0d61f4-186c-4d25-9cbd-756b31ad6c4a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b016cf73-eb43-40aa-98c5-f0cdedc39e90','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b145ab31-c99f-431e-9476-c25877d1aada','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b1be1e28-23a3-45e4-a380-18bfbb88d914','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b1e1fb41-6598-496d-a1db-148b75527d3a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b242b792-2091-4a8f-99da-9f8cb018f895','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b49e1c60-a9a0-4913-9ee1-b656e7150cde','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b4ac2b41-5bb9-46a4-9653-ef209bf0d23a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b5439bfb-5b28-4aa5-8f61-349d03d254d3','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b5854529-ac7b-4d53-bc69-a4a063f00c6e','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b70dfb96-8a33-4fa2-bf77-a7633eb971c1','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b8842823-0da8-4a88-bdce-25c155d0f951','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b8dd3e39-522c-4f7c-98a9-bab7bdbb6678','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('b9c18fb8-f02d-42e3-b9e2-c8a6a291588c','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('ba690cfe-47be-415f-bf8a-dc266f003c83','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('ba6b053a-72c6-423d-b5ec-9ec885a27d60','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('bc2fcec9-b39c-4f02-9e1f-5cdb86e734e7','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('bddce3b0-72a9-4d93-bc54-fca1faa1a0f1','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('beb6666a-30ee-41ae-aaa6-5c487c8f04c8','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('bf314160-5162-4994-b985-74eb1bd850c9','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('bf466859-6287-4abd-8f1f-dc85e4d06740','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('c194559c-9131-49b0-bd83-c544be756e01','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('c3836517-fefa-478c-810b-15aad1c21934','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('c4e433a8-b04e-4e7b-b760-610962c2a365','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('c843814f-0f1c-432f-8abb-9c201ba9d388','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('c9a6c169-aca8-42dc-b5a4-189208351da9','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('ccea9383-09f6-4587-8423-6756821f5d4c','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('cd2694b2-a799-4849-8b21-c56737dc9a88','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('d39a1a6d-4a9a-4df2-89d9-e7760a0b4105','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('d3fb0a13-b6a4-4701-8458-76134458b0a4','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('d43c48c4-8ea5-4bf3-93d2-ad131796f485','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('d632527c-5f7f-4d39-96e7-507748c69daa','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('d99295d8-33bf-499b-986d-b837daf837b9','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('da473ae4-faa4-45fd-b4c1-6adc561f7f1b','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('dac31629-2bf6-42d9-8c28-c38cb98b8e97','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('dbd65d40-5f14-4fec-9505-48297cfa9d8b','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('dc8d0d50-0b0b-436d-b1c8-39ead1ad56fe','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('ddd8df6f-21a1-472e-9de9-becf06141633','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('df1a708e-4702-4435-81f1-ea5d77fcb5ce','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('df8f6008-0a3d-46a8-81d9-6bc1938f05f1','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('dfed82f7-1f3c-4b61-b207-78b34370a283','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('e1156d3d-e021-452e-8af2-b37ff2e2cd3d','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('e1156d3d-e021-452e-8af2-b37ff2e2cd3d','e0a97b06-eda1-45d0-85b0-9b3e96b2501f'),('e14a5238-4db8-42a0-94f0-b32ea4e5d6c6','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('e2d55ec0-53e1-4c40-aa94-89f24281d037','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('e386fc69-c3ec-454c-afab-48b9114d4fd3','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('e640ea8a-c21e-4a7c-9f7d-08c07c0a0458','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('e6a43d37-3483-486e-91de-e5a1907a0bb0','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('e8c8aeb6-b008-4675-908e-1b3c09999558','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('eacb2c2d-a7eb-41c2-97cd-ef34152bc123','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('eb642bfb-ea0f-463b-b5ec-51aa3c011691','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('eba32934-ea6d-4464-b955-517bc7dba267','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('ed1a77a8-0169-48a0-8514-19a1effb8b8a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('ee2005fd-9c53-4efd-b19c-c45f3dd72bba','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('f03d24db-f39f-4e99-953b-4531e9771f6a','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('f07f4312-e438-4cca-bb77-a2039cba1049','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('f4a05e5f-0a86-436e-b442-c27332078ec5','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('f65ea58e-b319-43ff-9d12-41c766e2e68b','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('f7580f59-4b50-42d5-a8ec-d1867ab515f9','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('f8dfca4b-7f4f-4fa3-8c71-bdf5319e7f22','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('fa4a17cb-924b-4f92-b1e9-a447c1b4ec64','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('fad12849-4667-46ed-b8b1-e8372345b8ae','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('fc6b1dd3-4e21-4c14-9d93-9e084a55fba1','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35'),('fe9c51fb-147b-4e12-8f4c-5ed06aef8859','0e5cecf4-bc2d-44f7-b1e0-7aa70c7f4e35');
/*!40000 ALTER TABLE `aspnetuserroles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aspnetusers`
--

DROP TABLE IF EXISTS `aspnetusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aspnetusers` (
  `Id` varchar(128) NOT NULL,
  `Hometown` longtext,
  `Email` varchar(256) DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext,
  `SecurityStamp` longtext,
  `PhoneNumber` longtext,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEndDateUtc` datetime DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  `UserName` varchar(128) NOT NULL,
  `FirstName` varchar(65) DEFAULT NULL,
  `LastName` varchar(65) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`UserName`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aspnetusers`
--

LOCK TABLES `aspnetusers` WRITE;
/*!40000 ALTER TABLE `aspnetusers` DISABLE KEYS */;
INSERT INTO `aspnetusers` VALUES ('00eba7fe-58fd-46d5-8db2-9f69c557e765',NULL,'ronaldfletcher1990@gmail.com',0,'AISR/wF9b2KAgbguRzw/oMQW6R5vF+vlwDRWrJviv5qvZoDhh8DvhfMTwR7oMF3Zpw==','1c2b64c5-4f39-4f1f-8c6c-dadd8f538a78',NULL,0,0,NULL,1,0,'cubmasterron','RONALD','FLETCHER'),('00ed25c9-7f73-4dd5-8a15-f6a82953934a',NULL,'Tinatran275@hotmail.com',0,'AE4nQEPh3AAd+XpWpEaL59Zy/a8ChaXA/Mbwdogua2B3z46wB8JsxeCmrKoiPVEaFQ==','aaf58397-ef13-444a-9166-1d489a2ca3ea',NULL,0,0,NULL,1,0,'Thanhdam72','Tina ','Ngyuen '),('027b0254-950c-488c-a2f0-45e95ed633a2',NULL,'amydelling@yahoo.com',0,'AMNd1Xy0uK6FgqXpcp5aJRKaFlPcPaFLP5keoKbp1BbazWAwfD9OO2tVtLGRVACblg==','09ad2e36-1eb1-4633-bc77-e70d59699fba',NULL,0,0,NULL,1,0,'adelling','Amy','Dellinger'),('027c3a0b-41af-486b-afb7-58ae6be81963',NULL,'spectrallight@gmail.com',0,'ACK4KQJnoJflq9IgAHAMp6Bi+rdZNOdyEphJhJrWQmd/BADagKDpwAQYSN+8PEHVtg==','ec2cb4e9-6035-4c5f-b336-b8a804929314',NULL,0,0,NULL,1,0,'Test','Test','Test'),('02d6e4e8-d491-42b7-b0f7-3a6e8096f44b',NULL,'tina.byrd.2@gmail.com',0,'ADrCenHXg682j9Q4DghmWZU9OVjdEQi6LiX1cBdTW7YxuVH4GxWbG5I09Z3YqK997w==','e5354456-30fe-4133-8038-0f0724208e64',NULL,0,0,NULL,1,0,'tmbyrd','Tina','Byrd'),('045ffd11-26f8-48f4-ac6e-42aebc4f5d9b',NULL,'nikflippin@bellsouth.net',1,'AEePPJHUHunS6gt2pQ1lO2ems7BD/UcK4QBUNU1PK91PziAKY9g/zHWHjkcYp9hDJw==','5d7afb8a-8b3f-4365-a1cc-e6edb46e110e',NULL,0,0,NULL,1,0,'nikflippin','Nicole','Flippin'),('0517def0-4682-432f-be56-5a132c7a5a13',NULL,'laurac@comporium.net',0,'AEw2lbGv7RNkkEzXjNHUxRxsxzgbj7b7cnJ0i68A67PmFho1rXz2Bc4KHs0hwa8oZg==','841a07db-ad11-4102-84c8-8a6837c8e29b',NULL,0,0,NULL,1,0,'homeschool513','laura','cripe'),('06298a8d-c555-4c2c-8694-1445f9e007e1',NULL,'siwbaker@gmail.com',1,'AH8UVj3a6oLhL7WUlDRRdiiWvkJvKmfKyzvkWFTFJz1mSnes9Ev1NmcthCcASZyGSg==','22ce892c-8858-46ea-8c3a-3ac8a2e28d1c',NULL,0,0,NULL,1,0,'siwbaker','Sally','Baker'),('07085b0f-75aa-4f8f-811b-42d6bbb20d75',NULL,'amccorkle@gmail.com',0,'ABJKsyrTzj5iM64+Dr945dD0YjNoslTorS6bDHqq0lQDxQ7hYmYMP8v2mQDPSSJhNg==','13096a2c-70ef-4e45-b3b1-85b7a6fed531',NULL,0,0,NULL,1,0,'abrown043','William','McCorkle'),('07bc8c87-1771-441a-8519-abfcd89e6f6a',NULL,'crissypoetzl@gmail.com',0,'AHlAyAAyNDIb7Z4wDVeISZ45c1FFmLdBW+E00cKFUPI5IpYmmFY9qHDfOLTCWZSfxw==','00818736-101e-4381-b9f8-14c2e2265b95',NULL,0,0,NULL,1,0,'cpoetzl','Christina','Poetzl'),('0a093e08-a411-4fc6-8db9-aaab639601e0',NULL,'Cassieclark415@gmail.com',0,'AH3Oezh6MYCO5AmJXzF6vIhPJbt7O/iUlC0px3gazBb/DFpuJr0bjjrRNeZXLWU1ig==','26f495e1-7e25-4a6a-8f92-3fff0ea8e721',NULL,0,0,NULL,1,0,'Cassieclark415','Calvin','Lyle'),('0a290298-1658-47f0-95d0-e2f663cbf971',NULL,'10hust@gmail.com',0,'AAGnrAKRhG/csi6rPqnwKsoyM6AIl3UDKZtQb+bAX8+VsZhc9XMjcmDM/gIffDuA8w==','ce0bb2a6-a32b-4f7c-bd07-3c4467844356',NULL,0,0,NULL,1,0,'FreddyBear2010','Fred','Campbell, III'),('0ac6ee96-66cd-469a-a7a6-fd45ca1bd266',NULL,'Kstevensyork@yahoo.com',0,'AOCVjPhj+QEwykFY/Y41hgXTNqGjFRiLBcAI+7wFgZ3Zr2QO/iky8AuYeoEdJqT4bQ==','ee108a11-5166-42fd-9253-3810603c8bcb',NULL,0,0,NULL,1,0,'kstevens','Kellie','Stevens'),('0baa0786-cf75-4b19-9abc-2120b39d96a2',NULL,'pack333@yahoo.com',0,'AP29K10k0VxQZBESV/8LvyqXONl/NbYc/OYZx+ehYkX+iZw7zPP1YbAWNVxXdwMNOQ==','ee758f86-623e-4058-a7e6-1394ad5f308c',NULL,0,0,NULL,1,0,'packcpoe','Christina','Poetzl'),('0f4cfe52-3050-44d3-b228-5f822dd5dd75',NULL,'ANDREWHANE@ROCKETMAIL.COM',0,'APyeuQO4KW2rHfgpCkndlEO7cdRHGMhbeCoOCzWDck9UsAl9w6Pu6GH0VQRGItpMig==','667ccdcf-bd44-4efc-a17b-df944eb4d1bd',NULL,0,0,NULL,1,0,'ANDREWHANE@ROCKETMAIL.COM','ANDREW','HANE'),('0f4f225c-e241-481d-bc1b-634c44ee10d2',NULL,'royhboyd@gmail.com',1,'APEPk0svOYLuyjP9uk2B0r1ziF5lR1S0NoJNLCuD12V0FbTKMr4NChT5Cy28zBu+vg==','92fd311e-badf-4bd3-8347-4559fbbd4160',NULL,0,0,NULL,1,0,'rboyd','roy','boyd'),('0f50f193-b477-4623-9284-f95c1f295729',NULL,'xtinavincent80@gmail.com',0,'AFNaTK/kffec/3ZD+67lZjfhFFACKEi/UhEPNSXAkgYZ89FZMysjoRl53MSNeuiaZA==','8039a439-8621-47b1-8165-bb2e61462777',NULL,0,0,NULL,1,0,'CristinaRenzoni','Cristina','Renzoni'),('101b293c-e0a4-4e6f-b939-857110ed71bd',NULL,'Price@designbrothers.com',0,'AAngjJ4OsIIbG4XrvkbaboIcBX/+LX3qsM86h2j84La02AQxken3lHkxFuJeUDrxIg==','bcce6446-28aa-4c94-ac2a-e6d0ad3ac53b',NULL,0,0,NULL,1,0,'Price','Michael ','Feimster'),('1077dfbc-6521-465f-9c07-390f00472131',NULL,'debbielsavoie@aol.com',0,'AG9zsQTcUw44Fx97IxRM1ddin6k8sL4iQx+KRF0CCSzkeSKd3tYNsa7BMB/2ldlPtA==','e6e21086-0dc5-4604-b18a-431a2f99df9a',NULL,0,0,NULL,1,0,'rdaczs88','Debra','Savoie'),('1460b2c9-23a9-439d-b88e-91282130a080',NULL,'jwparris@gmail.com',0,'AJdBvAV6uUUA53r7NFCHoOrnMZigdvyDg9n60cUK0mYzuahO+ooT95kbsTO06jLY+A==','e93fa30b-d52e-4646-912d-1270005afe91',NULL,0,0,NULL,1,0,'jwparris@gmail.com','Jonathan','Parris'),('14d52cc9-7780-4630-b721-a4f54e1755ac',NULL,'kwilliamson@att.net',0,'AL9auiIpIbBXyeSSErui1MTPzEkBdHOoO0nOXwGSc7MRy3R6MtqsA4G2BeqfhtsE4w==','9d419522-a0a5-4ae4-9584-53479d5f8404',NULL,0,0,NULL,1,0,'williamsonkc','Kelly','Williamson'),('16a8a528-3a1f-45ca-b4f4-86c6a0b83ff2',NULL,'nscutie979@gmail.com',0,'ABxAUsfHKlDe0ASLs3paF9jR7UGQBirT+VPvMsvFtL5HpLGoMm6GBRXs1oNs6l+B3g==','26d982bb-a34e-4493-aa73-3663c8784092',NULL,0,0,NULL,1,0,'Chase229','Chase','Higgins'),('1748e932-04f4-449a-b677-25681d63120a',NULL,'flowersr99@gmail.com',1,'AL3Wlh31ll2cDGlfoXGknlFlVmy6wRWBSasvJGflumt+xzRUBTOyBmIBIgTNTqYCrg==','932858dc-83e6-410a-8648-60928b7241ed',NULL,0,0,NULL,1,0,'Rwflowers','ROBERT','FLOWERS'),('18c8dc1f-4d50-4d66-85ae-29fac05f0767',NULL,'roseburline@hotmail.com',0,'AJuW+JObWqUPcuTwFvarRwjLHhhmj/Zwj2yKenUJ/vYiDmcdRMmEjTApzLJl/qFiQA==','54a5f8ad-5566-48c8-8f52-bfb04920b27e',NULL,0,0,NULL,1,0,'roseburline','Billy','Bronson '),('19a8b3da-19b8-4743-85a4-b7b3c1d45d5e',NULL,'yorkdaycamp@gmail.com',0,'AN2RQa71MwYAZhNOmAK/cMa2HX0c1RE2si6U78GG8d0+fk8IsU0YBMomR9PKHAbFoA==','ae7012fa-141d-4bd6-ac96-164b3859e53a',NULL,0,0,NULL,1,0,'Deleteme','Delete','ME'),('19b194b1-e689-4947-b418-69e5608877ef',NULL,'agstrong1215@gmail.com',0,'AGUl+LmfBLLXXdNJByLauC20SV77VJcHP1lxsEgaqema3f+A7PmZTm83bV6euTIeWg==','8451a8f3-5f1d-4240-b860-d3118af604d2',NULL,0,0,NULL,1,0,'amynben','Amy','Strong'),('1ad48d61-bbcc-4f82-adbf-a3e45bd7f031',NULL,'tlollismitchell@msn.com',1,'AC+nc3GyPEmpp7TMlRpAImr6mXX3DqnjjZXmwfcFkGLFRV9yBI0L0519wvlIoShgvA==','beea808e-1a76-45f6-9ee7-ec46b79498dc',NULL,0,0,NULL,1,0,'Pack','Daniel','Collins'),('1b388a36-a3ed-4feb-806c-e18d61981803',NULL,'Kristypowell419@yahoo.com',0,'ABJgudp2rLNSWmqqSy7B/3nZ5KYMkxtcGhHX9gz2qRrOxdGXQaf1Ago3mRIDpUD4GA==','0d19cbdb-8ea8-423b-8ea0-f0744dd58767',NULL,0,0,NULL,1,0,'Kristypowell419','Kristy ','Powell '),('1ba4c90a-163e-4e7f-85b2-c106813ca171',NULL,'LPFitz05@gmail.com',0,'AMDvcD8/3jcY+VHuUZ2hE1gBouW2cdxWgh48uJ2FlFsgHf5wSBKTLsBpDcazPkvbXg==','96a85245-c7d5-4427-aeee-03804b00906d',NULL,0,0,NULL,1,0,'LoganFitz','Logan','FitzGibbon'),('1be33843-8af4-4a6f-8e5c-6e9d5614f801',NULL,'cararohlfs@gmail.com',0,'AAhRAsEuIuB9WYdgeRwtw0lbGcGD71j67gXPVuGbIjmCVR254+Z45zag1N7iaEeGhg==','406c6563-683e-46e2-8479-3a68ccd333a1',NULL,0,0,NULL,1,0,'cararohlfs','Cara','Rohlfs'),('1e381f3b-61f7-4957-a1e6-b4ec8f72437e',NULL,'Thressaelam@gmail.com',1,'AJkriDN0mMsxeOpehnIkC+HJ7vmA70OJIa5hgB9QCFj4NlRa9QWXewlLloRuTwx/KQ==','33a2b8fa-c2bd-40c5-b3da-1e431db02efd',NULL,0,0,NULL,1,0,'Telam','Thressa','Elam'),('1eb3070f-1c1f-4021-8930-c31c9877f612',NULL,'msprescott5@live.com',0,'AIZ7cMLejJkVFBJEIECeqh0s2uZ38Jh7Qz0b2lr29FGU+uzWcm5dPQEjy7QjtlEbZw==','c62927ac-232c-41f7-bf04-2c56200aaad4',NULL,0,0,NULL,1,0,'msprescott5 ','Mark','Prescott'),('1ebf9561-0178-48fb-bb2b-67987d0216a7',NULL,'TheBendtFamily@Comporium.net',1,'AD2jr/rFbmEd7JXMGD93adjZwNHCqTsahxj79YGLPD2aWJXqoaQMELKs6Edsuykzzg==','9e3cf22a-0194-4675-84a0-cae4c83201fd',NULL,0,0,NULL,1,0,'bbendt','Jacob','Bendt'),('1f50ce58-1bc9-4f28-9e91-a8679a06fc7f',NULL,'natashatarbrake@yahoo.com',0,'ANaYuOrZOyoVpthOp5aYSW4tsWHstQTaAQGoYC2jfDVYqbptcbAYXqoOjzMRq1GzLg==','f21b78ac-9c89-41a3-934b-7929d514a08d',NULL,0,0,NULL,1,0,'Ntarbrake','Natasha','Tarbrake'),('20cbb424-269d-4910-8b06-e870508089e5',NULL,'lakedude@bellsouth.net',0,'AA/tPLPbZEJuPQjZSRzJOlid2hlOrD7ghDd6Cvn0FSZOuz5YGNLJEl2K+NAg5X2jkw==','a4755e48-f80d-48df-a027-edf35a9d8f5e',NULL,0,0,NULL,1,0,'lakedude','Glenn','Stoner'),('211707fa-e981-4e28-81eb-71a44d0d64f7',NULL,'Vcschneider86@gmail.com',0,'AD7tEqM3AExYG2gKAejBdupgpqs9Dd6UUGOR/+cQajbkDZD0VvAAtQ1Dm6lkt8NPyg==','f773bc4c-b490-43ba-b422-718735d7e79a',NULL,0,0,NULL,1,0,'Colby104','Colby','Schneider'),('21ea514e-e7bc-423e-ac77-95e1dba4f6b8',NULL,'Amara278@gmail.com',0,'AKZNNulpESuohL/gR2NhjgNpc8g0r9GJaCi78+L4LbA3Ztjc+6ta40OmPda+RFdHFA==','b4e9c415-de4d-40b9-ad47-5d38faa2eaa5',NULL,0,0,NULL,1,0,'JCox79','Jacquelina','Cox'),('21f6aa27-5729-49d7-999d-ce7e188a2973',NULL,'gabecollins632@yahoo.com',0,'AFioDd2VKiXECGLVqdjBnXtwBsKTnJWdapocJK47Ug5eJw+n4orPshba5xs3l85+jw==','e93bf41f-e4a0-43a9-a7ad-3452aa9e49c7',NULL,0,0,NULL,1,0,'gabrielcollins','Gabriel','Collins'),('224ca510-c670-4540-9ebb-fe4dade6c0d3',NULL,'Soniacolon@yahoo.com',1,'ACfx/qriaDgPKsF8OsMkkKMUwHGaeiMrxN4wwOcZV2IaALedbcM2uPV8XQV46+wvBQ==','5cd66ea9-680a-4120-b85d-0aeba0e12362',NULL,0,0,NULL,1,0,'Fredonena','Sonia','Colon'),('22c6bfd9-41e8-435b-a1c2-e63f12595dd3',NULL,'Chiller725@gmail.com',0,'ANTV1IILCQ/F61ZaCiOfYpzv4doCvIYnFodzvP9VTshvH2CBgoyZiVXHALfSTE/qUA==','ddf99a1b-4d94-480d-ae98-c4d448a4cdd2',NULL,0,0,NULL,1,0,'Jbaker2 ','Jonas','Baker'),('239249a7-0b34-42b3-9b31-9e2df9394a98',NULL,'ffelix0907@gmail.com',0,'AEouEVIDHgDz1fco0w/VOi/ZJMvq/BxJ8hernCFW+3l1i1aVRuuJioEHDjEE/4frOQ==','8993a036-d0e5-4b75-944e-2a5bad77f151',NULL,0,0,NULL,1,0,'Ffelix0907','Frances','Felix'),('26a83b69-9630-403e-9dc7-4a10c39d56bf',NULL,'paswoope@hotmail.com',0,'AFvV82aNJNR0YWF1vL+CdK4vA/q3NkasggrUc/82i486ZfBZnqguoDbiF7WK2pVxjQ==','f9cfcfc6-bbe0-4752-a379-6fb5064a7a57',NULL,0,0,NULL,1,0,'paswoope@hotmail.com','Patricia','Swoope'),('27312fad-e13a-4f50-bd77-16c703c08f67',NULL,'tparrish@goencompass.com',0,'AHJ5cedQi58mEzVJ8DWiJ40mz/Y9z6Tajzy5MKLN2X9sI5XmqnyN+FCIIwSOf2W71Q==','e1a498c3-81dc-4b93-ac67-9b1b9eb80648',NULL,0,0,NULL,1,0,'parrish.trey ','James','Parrish'),('292325f7-e402-40da-9b95-c0a5114fb08b',NULL,'stevenjr@comporium.net',0,'AGCM42ET2OUS8Dn6985ujeS51Rc6h8uAY5l06fjC7G07IM1RgfS3PpvaI7p1AAB2yg==','7bebe6f9-ee52-4dd1-a55b-5b09bec8aadf',NULL,0,0,NULL,1,0,'Stevenjr','steven','schweninger'),('29a56afd-3b27-4ee4-8b8d-f0a1db19b1dd',NULL,'Katiehylton@gmail.com',1,'ADl+kCSbIJnJvU2dbrx7uL9NDtl0Zb83t11YugXiT6TAK29pQlrMD+0PP9klNnPepA==','96675d58-53bb-4ff1-b645-8bd560d64c5f',NULL,0,0,NULL,1,0,'Khylto01','Katherine','Hylton'),('2aa1831d-83d8-4813-8536-0fb6d9ea30f4',NULL,'chemphill3@gmail.com',0,'ANVFecRIgzK3IrEehz3EFwp8NOn8oLUcgvTc323GqWedfBKbhRVUyHpI7JhzPPrtZg==','5eba0cb8-0238-48e0-8c6c-3495be692201',NULL,0,0,NULL,1,0,'cqgrant','Courtney','Hemphill'),('2b102fd2-08b0-4fa2-983e-c04565f77463',NULL,'julie.m.piehl@gmail.com',0,'AEz50N5OM5fbu+BsuD6+Z3xP7wgyf1kEh6wziDSLGqhmDBwALnopj7xavqHdWpBu8A==','23c467cd-395c-458c-b70c-cc9ee3651780',NULL,0,0,NULL,1,0,'juberpiehl','Julie','Piehl'),('30eddd4b-fbb9-4b7b-9f3d-010903c25923',NULL,'amylynch1117@gmail.com',0,'ADnxO7ZCAdy7QZuvruORJtfFdRQvfxCX9NwXFP4nG1RnENq3+pPNO2yJC2iOVBNQxQ==','10714652-8c55-4912-a749-e4ad7a503ae0',NULL,0,0,NULL,1,0,'AmyLynch','Amy','Lynch'),('314b3ba3-f01e-4256-872d-c07900d871bd',NULL,'ljohnston@rhmail.org',0,'AKWI/ZuVaBuB4YaB47JKek/YOHbsUnHCNs7WHJIifeU/ePzS6L/bvteDAK+uPkFdtQ==','56fd4fd1-6aec-44b9-b5e3-b867742fe118',NULL,0,0,NULL,1,0,'ljohnston81','Laura','Johnston'),('31c04f57-2034-4c70-afa3-6780cae9d64c',NULL,'stuart.hildebrandt@gmail.com',0,'AMqvlXLCIm/OUTIQnkFmsbYDD02Y8JMf/3XsNp2WISi3JOgGJ2gw/2hrNTDDr7f92Q==','d27bdf6c-0eba-4757-932f-6ab5304bdb2c',NULL,0,0,NULL,1,0,'hildebrs1','Stuart','Hildebrandt'),('344b2f8f-e154-4d49-a486-6800f54e9752',NULL,'Tarheelmcgeeunc@yahoo.com',0,'AJ78Y+mZJrOR8GLlY116/19/rp2iM8NqmCFL3ybTy/ty062MOleBATrNpTqCr8V6Yg==','f98b5eeb-12de-45d6-8a23-0af7aca49afb',NULL,0,0,NULL,1,0,'Tarheelmcgeeunc','Jesse','McGee'),('35ac786d-c1c4-4fc8-98e7-20d7321aa8bd',NULL,'Robbye_24@yahoo.com',1,'AH1GpZqI38RACY3xH9gTuRn9m2XjRis65xWDyWt0Glrz61uIZX6qItTvpaWsFkEs6w==','dac7ab21-40f3-424f-808a-c2190f635506',NULL,0,0,NULL,1,0,'Robbye_24','Robbye','Helms'),('3646a56a-d0fb-4569-8afc-83e7774fb053',NULL,'Bam7_99@yahoo.com',1,'ALLAna0Ozqpa6ATlKTAqMFwirWcKIeuNSsNqdmpf8+MwiPotkOtllUmgq3ghs+o8fQ==','338a8d73-b80a-4642-a298-583e2007c6bd',NULL,0,0,NULL,1,0,'Mizelleb1','Betty Anne','Henson'),('3748f54e-1cc5-45f4-a7d5-b1cb77028f00',NULL,'Rgasperson@gmail.com',1,'ANRj0LqvUFbinI0w3dy7xPto44E2++x4XEALhSZkheygccapAIist61Vj7tY09DffA==','9007f4a6-3ad9-4007-aa7e-aff0170afed2',NULL,0,0,NULL,1,0,'Jenrob2006','Robert','Gasperson'),('37d0e4b7-a905-4b3b-9048-3dad4a52e1fc',NULL,'grissomrobie@hotmail.com',0,'AOCSfCp3mctLKNKpPfuSFaqMzvej+0EJbWJUekI3mY3ESExtzBjNVjFFIav8rBJTAQ==','ae55b2ba-da74-42cf-b90f-b63f54e2ad80',NULL,0,0,NULL,1,0,'Robie20','Robie','Grissom'),('37efde0c-7727-42c9-af7f-d02fecd7073f',NULL,'spectrallights@gmail.com',1,'AHwDY98KMghvkPuDfmaZyzhze+S7YZ1D0IXE9+yaejgMKQIKXAYnGbVnGq4UUXm9Kg==','0158a9f6-86cc-4f19-a453-9c6c8bbc8d79',NULL,0,0,NULL,1,0,'Spectrallight','Danny','Culver'),('384bb297-d745-44b0-be74-faf235f2c7c9',NULL,'Mattgandolfi@yahoo.com',0,'AA0bslJPTtduISCbkwVQR3ToWB54yBLzaKCNQJLauMhcprr7pQqCQAjqbQtv+cP5VA==','d72f1765-7a32-4c96-8881-95dfcdf074d4',NULL,0,0,NULL,1,0,'Mjlrgando2','Matthew ','Gandolfi'),('38fb656b-dc16-4b2a-ba82-2d22d7ac654d',NULL,'rwmagee90@hotmail.com',0,'ANsDxwevqw4tHGXu3M/Wdf/NgBvoJ3UDvjwYjOZJT7iHfJYfe1oyYxaMWUNw2FafNQ==','5abbd3d0-a4d2-4400-8c03-11429d38fc20',NULL,0,0,NULL,1,0,'rwmagee90','ryan','Magee'),('3b7e9783-43ad-4c3d-81b4-fe809a15df10',NULL,'spacecrow@aol.com',0,'AEBugdBjC6kbaPBoC+FBe/J6O5w/BRu2Uw9hyJ8vwss6iNbsQZXI29iLjFY5mLQpQA==','5ecd0b87-e444-44b0-950a-ba6c12f56ebc',NULL,0,0,NULL,1,0,'spacecrow','Larry','Caulder'),('3e58cc4f-6898-4d8c-9731-a84dc89f2f2d',NULL,'squeash2003@yahoo.com',0,'AHQ0N/k4gC/+tmrA6iyZjzC+GGxCL0pZBbGZlwdC47+5SFdl6ChaKJzGdegIdlAcJA==','22f65282-4ad2-46e2-8a80-5a5e1dbf611a',NULL,0,0,NULL,1,0,'Sandip','Sandi ','Patrick '),('3e639382-c3b7-48a6-8551-89625dfc4e2c',NULL,'rpellegrino369@gmail.com',0,'AD39FXdoTDLrdSzitG8XgsE9sHFqQtfw2JWMk0rXSrOfeLT+LQ6qJ7kKTl+FUGBKFQ==','f6c510b4-5ee7-4ccc-a523-4e1fe5e11027',NULL,0,0,NULL,1,0,'rpellegrino369','Bob','Pellegrino'),('3e67318d-7be6-4b4a-a024-fea248072e46',NULL,'stephaniescouts@gmail.com',0,'AK2kI1jmo90L1aZFD3BEOjgubQacWsqKEdQllD0lKSb2fRhrjhHKHMl1vDh2m2QIvw==','62045dd5-4a2a-4f0b-bca8-74681e1e5192',NULL,0,0,NULL,1,0,'JLOGANTINKER','James','Tinker'),('3f023c6a-02b6-4994-a9f8-e7208d32fb1b',NULL,'icuklop@hotmail.com',0,'AAoRILYoF2Q9/10E6yl2lZcRgayI3yqRbC/dghDx14KWgiC1kY9rU2/CLz74TgJu/A==','759865d0-7565-4e1d-bccf-e34eea90a774',NULL,0,0,NULL,1,0,'mklopens','Mark','Klopenstine'),('40ff39df-73ba-44e2-b1ec-120a46e1ed5c',NULL,'Sullylizj@gmail.com',0,'AOCMi6B1/+B/iJrDMUju9VuR8MlSg4YvpgRRW1y5jnuel/R67mUDxd/6ZYBOibYIxQ==','cf9e0702-6077-487b-b495-4955aa7da373',NULL,0,0,NULL,1,0,'Sullylizj','Elizabeth','Morgan'),('43d1853d-01bb-44a0-871c-044d65cd8aad',NULL,'amichalesko@me.com',0,'AAJeHMKSSs6NHWlA4q02sakD6Y6obbhiNBdzJfQ+msVBHNWP42bsWp+Wkn96GN4a2Q==','d4061e00-8ecd-4531-afe0-e8355bb9aaa8',NULL,0,0,NULL,1,0,'amichalesko','Amy','Michalesko'),('43dba1a7-9cd9-4594-894f-beed545b5ccb',NULL,'Lenziallison@gmail.com',0,'AMSzSxPKLg4BB/6A7lkt0lcJ0+WpiiYQTY3DSLtu1W8u2FfAPt+o8+98Hu08mSnXlw==','aa28e5a9-90d6-4e23-acde-e858ae472d81',NULL,0,0,NULL,1,0,'Lenzihome','Allison','Lenzi'),('44f8fb5e-f8a3-48a1-afba-1d27f240752b',NULL,'rosie09@bellsouth.net',0,'ADsAnHbfQwPfBKHD5bJ1990rmKBkh1/a/EvLTIoyD4EmSb5cae8UL8a4ZN6OlY/p1Q==','50220b04-9f71-43b0-9a6e-3843069f2410',NULL,0,0,NULL,1,0,'Rosie09','Rosie','Hopkins-Campbell'),('45bd793e-6581-4542-9b79-99a7e88ab70c',NULL,'Froggie_jg82@hotmail.com',0,'AOPxoROGi9/kU0E/mSIuUgnb2ru9Hk92YBCYVKoewLIFEG7MdH487XZwRAAhkGTYhA==','ed6c4b44-6f4d-49f1-afa8-793ba8240b2b',NULL,0,0,NULL,1,0,'juliemoore1182','Julie','Moore'),('4b78caa6-943d-4a57-a6ad-930b9fec9e08',NULL,'eetaylor74@yahoo.com',1,'AM5WtP3weEsgWuVj+/WG2VOoEiPkFRDZ96AeCK6mCtzV6zQvIXpYlLaIKhOsu2pfOw==','b72618bb-623e-4522-a567-db56ab5eb226',NULL,0,0,NULL,1,0,'eetaylor74@yahoo.com','Ellen','Taylor'),('4d605084-1054-4585-b401-361a56ef3a68',NULL,'stephanie.b.tinker@gmail.com',0,'AMVuKqMgI77uBlVwdX9dR2Ci/CSPjDwlQZqsrdgk+PRxhE8SxUSQz6wHdJ0mBVQRHQ==','86f617e1-eba9-43c5-ba8c-b0a11b35c5bc',NULL,0,0,NULL,1,0,'StephTink','Stephanie','Tinker'),('4e8966ed-5c90-44dc-907c-68ca0a6fa4ed',NULL,'parkscontractor@aol.com',0,'AAMTZDy1g6/kMM9mLq9vEtPIpyb0obC7rFnEnG+fUjGFhv7bW+lvHGJ+Dt4KoJYKyg==','eb84fb55-dee0-421e-af7f-8e2e58a082ed',NULL,0,0,NULL,1,0,'Parkscontractor','Randy','Parks '),('4ef3139a-9301-4331-8642-059eda722546',NULL,'Jenniferdulin85@yahoo.com',0,'AGovCYC+z7V8YI/UG6/8hOTTgF0NuXnPHbe+nmda0CdcW61XRYVqv8VkSkm6sLevJg==','8337d1aa-ad5e-4b62-ab5f-0dd48729e1dd',NULL,0,0,NULL,1,0,'Jenn68751','Jennifer','Dulin '),('4f7f446b-a8b3-422e-8886-d20c3a4dee30',NULL,'franklin.smith@scouting.org',0,'ABEqMtXmqNOjdYB6HFnkHyG2utGGROp8AEQNjE+iSlyy7LaYbjGXxu0ovy3Idsn6QQ==','95d08c46-44be-498d-9a66-c4f817298238',NULL,0,0,NULL,1,0,'frsmith1975','Franklin','Smith'),('524d95a4-e506-4489-8402-122869902992',NULL,'nmcbroom@gmail.com',0,'AP9kuqW4rM+vTuhOkolVCikIPC+gLYhZI4YTZKGmx+XDn6if/TxKjIskOcjuzPyoSA==','19839553-61f2-4350-afbb-fd4b150dcf93',NULL,0,0,NULL,1,0,'nmcbroom','Niki','McBroom'),('5494ec32-ba5e-445f-9936-907106a6256b',NULL,'Moonsheart1966@gmail.com',0,'AMxKb+8DVnZdS1fud/JvndMRUTlVnEasK1bm5xOLvmvyZXtosmFBQlfwY7X11OnBCQ==','f97b4b22-fc9a-4f58-ad50-17dc6887cbc9',NULL,0,0,NULL,1,0,'moonsheart1966@gmail.com','Angela','Moon'),('54a212ce-ea20-4347-a169-76f72905aba3',NULL,'meg@meghanwier.com',0,'AGQns3a6EG415SfRG8/bKhZjxSjdtisC9uwDWFm/aGmLU5OMC1QxfyrzsuOJAcrlOQ==','744223ee-b62a-44e5-b784-da67b0bde204',NULL,0,0,NULL,1,0,'meghanwier','meghan','wier'),('56184658-1de8-4c51-a433-cc870a757e16',NULL,'mariaewiebe@gmail.com',0,'AD2X6bxsDX82Fo2rYD9reiAxaP8A4vI3F7y2RWWQ/mJSKnSEXHD31y6rDrxxqSazOg==','f1c0ef5a-485e-42c2-97fa-ce12f96dd549',NULL,0,0,NULL,1,0,'mariaewiebe@gmail.com','Jerry','Wiebe'),('56543503-4fa5-4f00-899e-9c48ec0802ac',NULL,'rwflowers@comporium.net',1,'AJm41Z+vjVUUWUVkofJCF93kJSyldrYcnzlZPMIRKqeZPIvn/OeM+7Cj0JHMBmpUXQ==','4f0b104c-29c3-4c2e-b7a1-0a6c6befef2d',NULL,0,0,NULL,1,0,'rflowers','Robert','Flowers'),('57e2bf40-eb26-46ae-9fa9-3a3cb8137144',NULL,'bkelly@galvan-ize.com',0,'AMOeRlQEEgag15xb22gizx3oNnp26BXAUezgVRzQ9YWOeXurgXdr3fSLKNH96KRuEA==','3b9caef9-7ed3-4198-bab5-36cf2db27433',NULL,0,0,NULL,1,0,'benandcarrie1','Benjamin ','Kelly'),('57fb10d2-de8e-4e35-b4b8-5034427f0433',NULL,'eetaylor74@gmail.com',1,'AJloyV+kqALWxrmw1pPeD+8pNY4IY2HzIbmYdCHMzsz/7Ml3GWu3j05Rko2Jl9Nc6w==','7dc24cbb-250f-45e5-96b8-2501d3d9b31a',NULL,0,0,NULL,1,0,'eetaylor74@gmail.com','Ellen','Taylor'),('5dbef02c-3b93-4c55-9971-63b44478c1c9',NULL,'Pwilliams2448@gmail.com',0,'AAz1ECfZK0yF5s52V6+GFUSsuSI5owuXQmSe9z578cuNLx9lWKNXXVvC96jKQHypxQ==','d8f3f42a-217b-401c-9be2-5f9af8f88fe9',NULL,0,0,NULL,1,0,'Pwilliams2448','Patrick','Williams'),('5efb75f5-390e-4dd9-92e7-4c5294d6841a',NULL,'adelling@rhmail.org',0,'AJWPhE0D11QSbV2mojYFnUPXahy17l+LKZsD3flxbtLyH596JY3KEN9YMNCQRBuP9g==','a1bb47aa-bffb-4def-ba7a-fb91c43b9a63',NULL,0,0,NULL,1,0,'markamyd','Cullen ','Dellinger'),('6281692a-5c46-4f0e-88c8-00176d4fd320',NULL,'tclark@mccoroyconstruction.com',0,'APXUaM//fzLmPU0FfQTVn77FOZf08vtmzDwjIYhUDgTpc1MoyEiUMgPH786ZV+WmOA==','ac0c12e0-1062-4b68-b065-c9752b903e3b',NULL,0,0,NULL,1,0,'Gavin Clark ','Thomas ','Clark '),('62869908-34d2-43aa-a13c-7c8796eb9742',NULL,'lrobinson@wfcorp.com',0,'AD4GnhSdORh3EaQ5rHPJ8f7pcscHuMJdSON2+FcLZbc08rIB7h+ttlvyLSc2Xx5bfw==','8a0ce12d-b784-489c-be99-70e56a6d485d',NULL,0,0,NULL,1,0,'wrobinson','William','Robinson, Sr.'),('629fa4f3-c681-4044-9cff-6c2b0f08d2af',NULL,'vfulcher@gmail.com',0,'AB0JIb9P8nUhQO2IjdUtY5sw9q7jDugkQaNYjTx+aR/07dQVt6m1kLim2iveloW+cQ==','096b170d-a5e1-439c-9f27-a894c682e544',NULL,0,0,NULL,1,0,'vfulcher','Vanessa','Fulcher'),('635c7f5d-50b5-46bf-9cde-33f9d1fe939c',NULL,'tobias2614@gmail.com',0,'AKx3TeG2O+l2YRlhUJxdZF3rVHkhK26/tOzPzDtZaNjMhbX3+MemfooCQqG+ieWZfw==','44c15ffa-42f8-40b8-a211-5bf28038c636',NULL,0,0,NULL,1,0,'tobias2614@gmail.com','Pamela','Hutchison'),('64acf003-8222-40ce-9918-87af63d72b14',NULL,'janthony@comporium.net',0,'ANM+U1En6z3v/EaGbILs9ddq5hMHbUV/H+Jn/dbzXY78XrpEcL5OOMk8OjTJtDmV5A==','288d9eba-5ccd-4c13-a694-396283f8f796',NULL,0,0,NULL,1,0,'jackatnite','Jack','Anthony'),('6598cc40-8b32-40e2-98e5-20973dee1aec',NULL,'kikeblades@yahoo.com',0,'AC9/pn9ugSOE0eo0+V7uS2ICjj1mu5Q/4IayZU4u6CFokxlw+7E5dED9fz2w68oODA==','f3f1ad9d-2656-4972-afac-cbe7bdc05ad1',NULL,0,0,NULL,1,0,'Peyton blades','Peyton','Blades'),('65aa4a33-cf54-4e10-831a-a4a5c14321d2',NULL,'janacathey@gmail.com',1,'ALxGu9oW2rZU5sH1x2ZPmPrEYkCZrqj3FBOsNIyMBde1OYCC5RyH7usWnv0wu12tCA==','06511bf2-6c67-4c25-b477-9f22c0642e09',NULL,0,0,NULL,1,0,'janacathey','Jana','Cathey'),('65e78625-6f04-4580-b490-8f30a30aba2a',NULL,'cyndilynn@aol.com',0,'AKx6z/2pjlm3LwjYuJXi6ZToRRy0bzaFtZRsfsK/geddFi/FGKQ/X6jZXSVgs4hBEw==','2052b855-114a-43e4-a88c-6ff7b29ff545',NULL,0,0,NULL,1,0,'cyndilynn@aol.com','cindy','rebman'),('691a0468-3e44-42f7-8181-f51bd92604a4',NULL,'rflowers@saber98.com',0,'ANxWql+kcDQXThMh4OAZty6g6OmdmFgtLSN7bRYJKSEDBNiZqNfS8pAM4JlyvTyANQ==','a3f11bf1-5ce7-40e7-a016-b309980d195c',NULL,0,0,NULL,1,0,'flowersr99','Robert','Flowers'),('6a7de375-00f4-49fe-986f-e7f407a4ea27',NULL,'Champusa1@aol.com',0,'AFwc7dVJYezFLqM73fQFZkEThAyTF7j0XHB9/DKhXgzrvEbsB5MR0xbd1V7ZCvuVfA==','e0277817-4ab8-4b44-a30d-cd3ea4d3d927',NULL,0,0,NULL,1,0,'Erollyson0831','Elizabeth','Rollyson'),('6aed5c05-b2cb-40e2-a26d-dbdf184ad864',NULL,'spectrallights@hotmail.com',0,'AFDPuOSY4e7N5xctWjJ2uCn99iUCaT1L5e0ixHEAY7s7XMAuKvUyvrrgblllkQslUg==','b2f0c03f-c1c6-469e-ab9e-71a2262b593a',NULL,0,0,NULL,1,0,'Roenot','DTEst','TEstCUlver'),('6c232435-c11a-4ee0-8249-f62409a64d4c',NULL,'C_scar@yahoo.com',0,'AB+pQNoV491wqgOA2C6kfwrPoboJR3zORU1/V35caTciBb0l5N01HrZDazaYb3X62Q==','e91b1af2-ee0b-4be8-8d48-da49feeadad3',NULL,0,0,NULL,1,0,'Chris Scarborough ','Chris','Scarborough '),('6dd257e5-9f1f-4df9-84be-bf57bb1e9085',NULL,'Rtrclack@gmail.com',0,'ACPkyf/Q0dFdvxi4FsOAA77cbUaZNRHSnVIBPW3lDz1AM7cMpOMtkcA7nbXI85Fy4A==','9625f54c-3650-45e4-9613-15946234d335',NULL,0,0,NULL,1,0,'Cristyclack@gmail.com','Samuel','Clack'),('705a5c1b-af41-4b66-bfa7-c55c4d80a78a',NULL,'paigeharshbarger@yahoo.com',0,'AEwG7zwg0xldmglWLLB2D9COWxyB171+QYdbYrDJkA8I5dSEJyFJa6AUwqGfiIV4AQ==','610fda4a-b52f-46e1-a468-96cf19025954',NULL,0,0,NULL,1,0,'paigeharshbarger','Paige','Harshbarger'),('70d6accd-e02b-4d4c-a588-05bca3da7ce7',NULL,'Gump@rhmail.org',1,'AOK85oN/7AwujrhctJC1EvoIty53vanJpS89T6RaFmnAu1XJ4NdgUTIZ4L8NIVCrLQ==','4669fca7-e09d-4014-919f-4df4891a4a4f',NULL,0,0,NULL,1,0,'StacyGumphrey','Stacy','Gumphrey'),('71789443-abf1-4a84-903f-e733ba3cb1d0',NULL,'Godlygirl11@yahoo.com',0,'AMlEYN4LqmfvoNztIIXT5s45Foi9teDeFZ+ar9C8dLabCQ8XcTBj34+eKVWz6dkbmQ==','632183c8-c556-4c8c-9ffd-e296d2191004',NULL,0,0,NULL,1,0,'yankeeee2009','Alyssa','Lesmeister'),('7b7423a9-c4a1-4ebd-9f7d-6d5a6759b454',NULL,'ncpack132@msn.com',1,'ANB6KmTutvhrsp46WQSP50R9tWPHuVjfTnw+z7yyNFumYmke+IZYgxr633xaeysYGA==','32385f57-4528-4d76-8a0e-6dec0919743a',NULL,0,0,NULL,1,0,'Pack132','Rick','Mitchell'),('7bac523d-c4c4-457a-9b8e-8dc780417e84',NULL,'ktbugggg@gmail.com',0,'AACUUPv0DvszeH3/Ejaced3/6kskk8gjN0s/4sXCAAWjRCHJaLl5fhzvplKQE7yEoA==','a227831f-9c9e-4bd2-8611-cf4c48c8425c',NULL,0,0,NULL,1,0,'wyattjames','Wyatt','James'),('7d898ec5-46b3-40de-8659-286882b5abf1',NULL,'Christine.chavis@yahoo.com',0,'AD5EM3WQo2H9fzCr1iYjqmSBADe7F6zzg4AWJ3ZmqhhdcqsDX66N5MZY3/kxJDvWCg==','26feedf1-12d3-47b8-9b40-2017b1c655f3',NULL,0,0,NULL,1,0,'Chrchavis','Christine ','Chavis '),('7ff58362-eb84-4b16-a2ec-8c724340d3b0',NULL,'Pebblesebx@aim.com',0,'AEHExAwLEq++bhF9edg1enel3H5CxgflQkNUujYnaibhilLl1YEDbXHSwgrInyO4hA==','042dd5af-37a2-433a-99dd-593b038b016f',NULL,0,0,NULL,1,0,'Pebblesebx','Brenda','Stallworth'),('82c013da-8935-4573-9ecf-3242af4ef143',NULL,'mcarruth2001@yahoo.com',0,'AFwRrgPgew5rPHoWzKuGGuS9e7qcsiNhuzQ8KpFNJXtJWqN6QMaqdkhux5aZWN/OJg==','f012d100-98d4-4dd3-970e-b4ce50d7f514',NULL,0,0,NULL,1,0,'michaelcarruth','Michael','Carruth'),('8454a5cb-eb52-46fe-b939-23594990a158',NULL,'scoobynurse@yahoo.com',1,'AIVKJjUwkWuRqv/IZ8yYo7NKYm7rtExM5Ds3ip5W7Uxo+z0Cl59G5WYeYVxwzDoU2g==','1d066f1e-46f8-4f19-b58b-b4522bef3a63',NULL,0,0,NULL,1,0,'scoobynurse','Melissa','Daniels'),('84e2f38c-4cf6-4ac5-9d3e-ea77c34322c1',NULL,'fatheads5@hotmail.com',0,'ACzoCL22aAR/D1BdSUwo7HKxLsSDNcIvxcH/zwqqq2/ytz7uvI7SUhEFabrKAXlqUg==','109c4bcf-690a-4cb8-bdab-44e15d675c6c',NULL,0,0,NULL,1,0,'Jessicabennett','Levi','Bennett'),('84fea538-0b08-4768-9787-555af9d1d446',NULL,'tbert632@yahoo.com',0,'AK2IsiVyc4J3CjjFLGcvk7BajUKa3//YUP+giQFsHwH/hccR8oHfxZKHxwiQll6aRw==','af69944e-f79d-4ccb-ba3f-d260724f3a08',NULL,0,0,NULL,1,0,'tonysanders','Tony','Sanders'),('85ebbc73-ce79-409e-beeb-039d72d92234',NULL,'sierrashome2000@yahoo.com',1,'ANVMvavvRtLsBce5xt6ZVR7NXr1X7GVJEW3w9TSEKyd5f1Nq20yg9zhrLgimRq9MZA==','443b57a7-548c-45f6-b927-b9fffe995784',NULL,0,0,NULL,1,0,'sierrashome2000@yahoo.com','Deana','Williams'),('89e6623b-9e50-404e-a3cc-2beec17ca3f2',NULL,'p_horack@bellsouth.net',0,'AEop3dEkzvsGNl724vJ/GZDKqwdViCVgqQPywzb859TlGdu3Y3zYIY3PM7tzmbtstg==','ef00883c-6c5d-4d5f-8413-3667c73ed144',NULL,0,0,NULL,1,0,'p_horack@bellsouth.net','Pam','Horack'),('8b7f96ab-7336-47ce-a8d7-72ec80ba4602',NULL,'cmiller_advocate@live.com',0,'AFQJJMFqUPxY0DYiw/fAWNiQOVeVzp+cfxw2Mwq8rUXxacTRoPFMlmhkupP6F7Rrlw==','48b9345b-5b56-48ff-9e52-a709459df951',NULL,0,0,NULL,1,0,'Cmiller_advocate@live.com','Carolee','Adams'),('8befbf7b-b965-4970-843f-bb1ee96a47b9',NULL,'blueheronfty@yahoo.com',0,'AGCsZfdaP04TrqT+AzYynjm09rnGTTrG0kbzpD2RV1H/Jh/pTuldX6fqx3ebKGLenw==','1333c996-5e46-4d74-a717-46efe4476b7b',NULL,0,0,NULL,1,0,'blueheronfty@yahoo.com','Lora','Lindquist'),('8bf2f8da-f88a-4c37-8fc6-f2f20976809d',NULL,'Lgmadonna@aol.com',0,'ADkSuqEZqtNVLWOAiSJr/xa1yzTzWoTT1nmjJUC8q0MJrWrp1xnpNkgxSuL7tXrkiA==','7925be2f-753f-495d-bb00-c039d077ec23',NULL,0,0,NULL,1,0,'KRGGBG6','Kimberley ','Garrison '),('8bff64d1-8f56-4d72-a452-ab5094b9aaaa',NULL,'amandatja3@icloud.com',0,'AI6Q0UmVzUjQGUoQLQz43iT2zqp6zmQ+/aphAR2akDdEDwxlNYB/cN+YAukbul4Fxg==','c17c1af1-d18e-48ef-b0a0-4e3b63ae8af3',NULL,0,0,NULL,1,0,'Amandatja3@icloud.com','Amanda','Daum'),('8ca9f18b-dc83-47a6-b16a-625b836abb29',NULL,'Frailey.tammy@yahoo.com',0,'APiASGXepRqm5UnGZls6TFxNwgpTnpStCzHPYW0zYNnEZxXBZwPh6wvDQ8M/wSDtYQ==','ff91a337-1a94-472c-8108-942fb25fcfa5',NULL,0,0,NULL,1,0,'TFrailey','Tammy','Frailey '),('8db7c6aa-24e4-41fc-8b3d-84ee11abd0ff',NULL,'nscutie979@yahoo.com',0,'AA+FO8W3qWD4h9VjUab01+BvLZ8GkBYxpK0/0r/f32bN5ESTZikt0RwUmgOzAFpdng==','febb4c00-4cb4-4b28-9a7a-6278361cc3f1',NULL,0,0,NULL,1,0,'NatashaS979','Natasha','Slack'),('8fd7dc00-62be-469d-9273-aa279cdcedaf',NULL,'robrickey@gmail.com',0,'AFFmdOBCXixYXw/4jP7yWZXjRtf6sH/4LlDVBEWwkDonJmQdSIG/eAPLgKoBTKuang==','a769268f-fb83-45f1-9f15-0e9257bb17d5',NULL,0,0,NULL,1,0,'robrickey','Robert','Rickey'),('9006b136-ee19-42a4-a99a-72e281a445f1',NULL,'wilderbyrde@winthrop.edu',0,'ACWPqKY5EXzmWF5MXu4vPwuMbesDl9/2Hgyxhtwl0s/pS9/BEga8+FPwr4VboOobVQ==','63201aff-b510-42d2-acf3-d4f05e17708f',NULL,0,0,NULL,1,0,'wilderbyrde','Ellen','Wilder-Byrd'),('90e9f1b7-a701-457d-ba42-4b795ddb093d',NULL,'paigedon11@gmail.com',0,'ADE22ZviEgc4IFXCqAQcoeq/xk2blw0pRnOVjHz3WgCQhw7rPKZzMLrtqWjYfDwsOQ==','42b0c931-abf0-4a52-8f64-65e693fb3922',NULL,0,0,NULL,1,0,'paigedon11','Paige ','Donatello '),('93ae4117-4290-42f2-8d49-706e58e85eed',NULL,'jenculver@hotmail.com',1,'AE8hMpHWtTNUFavLaiknJvOhfMR6UZSPGJAkfqhJPoVZFZFT1eEkE5+W/QqpUQ2pYQ==','fc4fc0d7-115a-4bbe-bfa4-0a5333bdcf58',NULL,0,0,NULL,1,0,'Jenculver@hotmail.com ','Jennifer','Culver'),('93fd2d67-d2d4-4721-935a-8ace37c81b38',NULL,'nicholas.weller81@gmail.com',0,'AA28qPTpdS6Af9/OBwzMoCZ0aF7qraLkst6LvnH5XhN1in+E2542GdG0X+QyBUBfxg==','8cf86cde-bf48-47fc-ba46-db1ffe6aaaf6',NULL,0,0,NULL,1,0,'nicholas.weller81','Nicholas','Weller'),('94b3e66b-efd9-4b20-a01e-5ceaa0f25e09',NULL,'timsabella@hotmail.com',0,'AN27Qr/jI6MTzc1w5vmnNEkh4zq/RbCZ43oneUe70hp+6CG5nwzPNPtlbBhHkqjFRw==','3c4d9b2e-9428-46ec-a415-a3d688e9d48a',NULL,0,0,NULL,1,0,'Sabella','Tim','Sabella'),('956d3fb2-f870-4a49-ac35-95f71bf41228',NULL,'sherilichty@yahoo.com',0,'AIe6hoAA24ly6xbMkPplX8XaYeLOAqBt3LJi1+aM9Xl47L39ah/5UVmmrwZlSPVeLw==','99730d1b-5423-44cc-984b-9a3fe5a52a89',NULL,0,0,NULL,1,0,'slichty','Sheri','Lichty'),('96ca08f5-94f9-4a6e-9fa4-a2d715b6e729',NULL,'jspoulter@gmail.com',0,'ABMNfjp5wdrNx+7jWXB/UPg/PI+YxT8as73kkeJwm+8y4i0Do3fZ2oHH9Dtvj9Q2Jw==','e2422427-0af5-4b11-a8fc-38a057d87ddd',NULL,0,0,NULL,1,0,'jspoulter','Joshua','Poulter '),('9870dc6c-e8e6-482e-aae6-c74e8b4b6bbb',NULL,'asistare@installationsolutionsinc.com',0,'AEoGcXNCk82Keb7a/WxWZYurK+fEY2kYD+qazDo7Sl/XKy5Fr6ddy2aEwdwgjsAxnw==','a515b031-3e19-433b-aa65-f0e609e2647b',NULL,0,0,NULL,1,0,'ASistare','Jackson','Hayes'),('988aa69b-96eb-41b4-93cd-66b99562e9c4',NULL,'sabellaemail@gmail.com',0,'AHbNu0tMMZw4Nq7+Ait5enPMYfFpY52657WROPTk4NO1g4gLms/dA8jm/PIvU9jANg==','a15dc7c2-c647-451c-bb7e-fca2afc87198',NULL,0,0,NULL,1,0,'tjsabella','Jill','Sabella'),('9a15e243-7441-444a-a445-64f8dbc9fab4',NULL,'pete.martinez@woodpartners.com',0,'ABct5ua2ns6fyS1kQhbz38zLYhe62QZZ/r/k7EJlxgXIYQKWXUzai1BthUZt9WIEBA==','13c2df4f-3a75-4293-aa80-512c1fa624b2',NULL,0,0,NULL,1,0,'Pete.martinez@woodpartners.com','Peter','Martinez'),('9effa591-c078-4828-b290-914d456c2943',NULL,'eric_susan_george@yahoo.com',1,'ALxcXSc8R1SKcimQh679m8FABw9NUmtnasQX3Bi1kZwZkArAWMsOc3b0T2DTT/+dkQ==','283a701b-ebf4-4734-905c-5a4284bf7afe',NULL,0,0,NULL,1,0,'ericjaco','Eric ','JACOBS'),('9f357deb-5b1e-4fdb-a1c5-4affeeea43f4',NULL,'Cristyclack@gmail.com',0,'AMYwjGRJe0iGUFGbeKklV/+tkTIfoT3fxaUekyKEudt7P2fqp0vxCiUSa/lS6/OFag==','f64d9aae-ed17-40ba-b975-ae5302ad7074',NULL,0,0,NULL,1,0,'Cclack1204','Cristy','Clack'),('9f4ebc6e-da0b-414d-b09f-f385c2353be3',NULL,'Michael.Carruth@ycnga.com',0,'AOMisuKgY2+Y4I2uy9EWo3Mc8u4bUilmX6mYkSTEExTz4U07dvVQe9hkErcD9P0xxA==','e6b4ab11-040e-4ae2-8899-b2d0bfbabb82',NULL,0,0,NULL,1,0,'MCarruth1010','Michael','Carruth'),('a02dae7b-ca1a-4669-a1b5-def033a815cc',NULL,'cartermiller@bellsouth.net',0,'AKeFK9Dz7IGQpt4RoMj/Ff2zq8dNN5xSnhkDRJ7QcFwFxA092XMaKEVKyoBa7w2A+A==','b40b5718-e768-41ea-bce4-3a865ee4c116',NULL,0,0,NULL,1,0,'ScoutMaster1280','Paul','Miller'),('a05b85b7-f4a5-4961-885b-a7948f25960c',NULL,'isenhour9@gmail.com',0,'AAJ/+wf6+jWVjVg0T1rUzsk4Ax1UrtUQbz4QY/d8X3dJnqrDIYwlmv9SHfhBtatt6A==','eadfd1a2-45c3-4225-93de-7c02c8bdeecf',NULL,0,0,NULL,1,0,'becky','rebececca','isenhour'),('a2794caa-344a-4a61-9419-e829e9d7b3da',NULL,'littlehickorynut2@yahoo.com',0,'AOjyq9NYWUUTkqSDGvOfFtl2N5qVrpcs990bvGQceSIGdoVSmpFoYlzxdKE4ci6ODA==','9c801d4f-6373-4a71-b210-0cf13691c0e1',NULL,0,0,NULL,1,0,'littlehickorynut2','Lisa-Anne ','Williams'),('a2b96ccd-b82c-4159-b2af-f8c83fe0f2ab',NULL,'karahawkins@email.com',0,'ADakaQNYRE0sDb2MYcPgtvXg4krmuPWrOwBubDQVyvkmBzsYPoCPTkkt7J7JRypVzQ==','5346b43e-8d82-4f63-8847-b3518da4f147',NULL,0,0,NULL,1,0,'karahawk','Kara','Hawkins'),('a3443ba5-b5d6-47b1-831d-799c1ff19117',NULL,'Kristypowell4q9@gmail.com',0,'AEoI/SAownKVIKUjaPtTEs/+rZx08P+l8yEC+9RRMywWOG9Xt3alOdbPU+vjjOhZow==','62d049cb-f032-4f36-848d-87592c52ec47',NULL,0,0,NULL,1,0,'Kristypaul','Janice','Chadwick '),('a63e5840-d00c-48c1-9e38-4ca0d517c5b6',NULL,'shunter@rhmail.org',0,'AI2Ttj5QCubvX/89gT8jiPldKejIgloVaq3xSGGP4D9XrPaQmf/fy4ksQDPjXKCQKA==','b7c3e548-9075-478a-9e6e-a7fb2469fbbd',NULL,0,0,NULL,1,0,'Shunter','Stacey ','Hunter'),('a68de879-40c7-4869-8a67-91509ce726a5',NULL,'cynjackson24@aol.com',0,'AOgOyEf9umr1KIQ0M29/qZg+wWN8HxPFAlR66BC+/tka2UcrgDHxKmM2ufV9O6AhOQ==','52a6d547-e38c-4389-8fec-b521a22e7a23',NULL,0,0,NULL,1,0,'cynjackson24','Cynthia','Jackson'),('a7f18707-9f59-4a25-92aa-01bb0d620522',NULL,'calexander101299@gmail.com',0,'AG7U2zSVNzJP5nsqA6mqNl9IjUDOW33AAVU1iiYUnljp54vqwzRpCRlv7ujfLTKlQQ==','dc42c6c6-4fc0-49c4-8c9c-5411b384cbfa',NULL,0,0,NULL,1,0,'clintalexander','Graham','Alexander'),('a96e1a1d-f192-4ba4-b5f6-5740a6fe015d',NULL,'spectere99@hotmail.com',0,'ALujObrLJrWEvFGP80suYTuLsmUc4DuIySmMllT8K56oVslmx/W9lIoGWxkUwlEObw==','b4107de4-e814-48f9-9ecd-abe425666e14',NULL,0,0,NULL,1,0,'test_account','Test','Account'),('a9d7bf94-6c4e-4f1c-9cac-a29a8f78dd12',NULL,'Paulpowell419@gmail.com',0,'AGZy3VM0Uo5JK7p7edPN5sceLqmZNlVQMAaFAK854KeN6O3GS2KAiEHGeuUHTzlCFA==','011b1d47-d57b-4453-8dce-7f95ded32319',NULL,0,0,NULL,1,0,'Paulpowell419','Paul','Powell'),('abcc4d55-ed58-4861-97b4-706b3e13eaec',NULL,'annabowman1911@gmail.com',0,'AGAdCMRSWlPgVMhATED31IM7A6DkDBgCtNVGmv0LEymwb2jBMno59zD7+mVTD+Y9Mw==','4729a15c-06cd-47d5-88a9-bc44a104a526',NULL,0,0,NULL,1,0,'abowman6','Anna','Bowman'),('acfff69c-47d6-4089-902a-b1d4fedbf0c5',NULL,'Mattgandolfi@gmail.com',0,'APZvE8kpZ4e8HHsBJE8jl1AxUMFqBVulaalMRvXXc8dcl/V01TuI5WgPZVislLGfnw==','f54eb1f3-57b5-4798-b3e1-1146e1181248',NULL,0,0,NULL,1,0,'Mjlrgando','Matthew','Gandolfi'),('adf31776-af06-41f0-8da7-3259af1b3625',NULL,'prettyman5@live.com',1,'APbgacFlU/fRTkE9A9XqcIZt+rMINJv72XY9SbHTp7j/hS4o33fegF3/u/XXg/kU0w==','1b7c9af4-10ac-47e3-8195-ea2f0a00c9b9',NULL,0,0,NULL,1,0,'prettyman5@live.com','Manda','Prettyman'),('aeacca57-3b29-49b3-bccf-040d1df072ee',NULL,'pete.schreiber5@gmail.com',0,'AELnph6ZnZqz5kMhRB0Q8vpPhj7qcx9oqkrD11vrsJol4DDiAi9NNfVg00aJ85QtNA==','4c0b696a-fb9c-418d-9ca4-d40da5167061',NULL,0,0,NULL,1,0,'pete.schreiber5@gmail.com ','pete','schreiber'),('af0d61f4-186c-4d25-9cbd-756b31ad6c4a',NULL,'pinkhippo1978@aol.com',0,'AGW+e38qkrQ+5TrIgl7IeammFiTf51rlK1aA1fqd7sZlPyBsOqgeMTBclur1YN/vgA==','c723cd4b-3d6e-4848-aae2-6ec8809f2a99',NULL,0,0,NULL,1,0,'pinkhippo1978','Karen','Brogdon'),('b016cf73-eb43-40aa-98c5-f0cdedc39e90',NULL,'apaige2238@yahoo.com',0,'ADH1yX4F0FIhyfGbCQGsP9n1u3tWflQB5JyLpBIE0q7/ZOrSf6LaPxUGVyrGAc74QQ==','afd2f5f5-73cb-454d-8bf1-a60d18c49c26',NULL,0,0,NULL,1,0,'apaige2238','Amber','Paige'),('b145ab31-c99f-431e-9476-c25877d1aada',NULL,'ctephanie2014@gmail.com',0,'AEC+G10/qun27y9PIUrxE0zLLEs9v+NKC0c9Qe8LPtJEBXErVHgrdjQK4fb1nu4ShQ==','f92c4dc7-4583-424d-8d70-7233c245d24d',NULL,0,0,NULL,1,0,'Joshua','Joshua','Waldrop'),('b1be1e28-23a3-45e4-a380-18bfbb88d914',NULL,'brysonheights@hotmail.com',0,'ACwvHj9mTjzB3udk4Aickt541tln9+OQPxi2vTMZ+rjkMD3RIph0+XXPgJn+bmJDGw==','01265bf1-7eb5-4801-b970-9923c2006f75',NULL,0,0,NULL,1,0,'Monicabm1','Monica','McCoy'),('b1e1fb41-6598-496d-a1db-148b75527d3a',NULL,'copeba@alumni.clemson.edu',0,'ABBdl5j3k5Qm9NTp7GxSUn/0QxHD+pyKBJ1s2URodlyRgpwv8JDyPYO1ISL5CEZ5fw==','5d2bc3c3-c3e2-4294-b35a-f3a36adf57f0',NULL,0,0,NULL,1,0,'copeba@alumni.clemson.edu','Brian','Cope'),('b242b792-2091-4a8f-99da-9f8cb018f895',NULL,'taylor.thomas@scouting.org',0,'AC1sFpNyzRlsk2UG1gpKB1FL4MztkK0ePyw6YPfsksTjyQaAWNULnN5jIYhzgVaAbg==','51598e07-09a0-41e6-aafe-994444c8fa35',NULL,0,0,NULL,1,0,'thomastm','Thomas','Thomas'),('b49e1c60-a9a0-4913-9ee1-b656e7150cde',NULL,'kblair413@yahoo.com',0,'AEwaQ5JwPYVz8GPu+r2UWm3nqrtu6m4WfhHV+6vSpjjzP1mP0rOtqDatfMDatQE8sQ==','2632962a-d0e7-47a5-8617-98496bb0a80f',NULL,0,0,NULL,1,0,'kblair413','Kris','Blair'),('b4ac2b41-5bb9-46a4-9653-ef209bf0d23a',NULL,'rocco.bacelli@yahoo.com',0,'ADzyRwM40rV8uvN6RxiSiuECjsniHxdEg0f4xXgAJdlsZAnkz9fQRDKxTfPD8LgKtA==','e1b0a90d-2014-4ab2-9674-4aee0b9d412f',NULL,0,0,NULL,1,0,'daltonmom2','Samantha','Dill'),('b5439bfb-5b28-4aa5-8f61-349d03d254d3',NULL,'panetta76@mac.com',0,'ADta0H95xdJwbYi9k6RhNb2ysU5wjvHzdf64a7kxoOaYoyc/tbl6LF/6DND3deLxLg==','af211179-cbc4-444f-a618-1bb06293b1d0',NULL,0,0,NULL,1,0,'panetta76','Jennifer','Thompson'),('b5854529-ac7b-4d53-bc69-a4a063f00c6e',NULL,'Kelly_rockhill@yahoo.com',0,'AA85NHLsleFspbyronlq8QWmlQGTXWDFjINJJzl4kSe7B9SDzJh3YDIOcpHgO+ysUw==','80c8fffc-f585-4cd5-b19f-e5b271c9949d',NULL,0,0,NULL,1,0,'Kelly_rockhill@yahoo.com','Kelly','Schifferle'),('b70dfb96-8a33-4fa2-bf77-a7633eb971c1',NULL,'willisrljr@comporium.net',1,'AIG+DQjm1LW6SamjAGetpdNgKyveUOaYn/31lnvZdgWV8eBF+UEongruSg2+Bz2y+A==','cd783eab-c4aa-4327-8088-38383606cf88',NULL,0,0,NULL,1,0,'willisrljr','Robert','Willis'),('b8842823-0da8-4a88-bdce-25c155d0f951',NULL,'TaraBurgess@comporium.net',1,'AEAHvp/rlMZRW781YWZl4Vtd4PfbaWJJwME/6MQ5fLudOpyP6mn2XnJA1TXYHXvWPA==','b754d23f-161b-440b-acea-62f63ad54aed',NULL,0,0,NULL,1,0,'TaraBurgess@comporium.net','Tara','Burgess'),('b8dd3e39-522c-4f7c-98a9-bab7bdbb6678',NULL,'danalbjones@outlook.com',0,'ADTMHJD/2S5xx2dU4j1H70L/w8+TeGCkkm8HjCHHA2eqOrmAXaMIZfQflW/yF+Q1zw==','2d20889c-8121-4a05-8786-ea5a56585bce',NULL,0,0,NULL,1,0,'danalbjones@outlook.com','Dana','Jones'),('b9c18fb8-f02d-42e3-b9e2-c8a6a291588c',NULL,'christy.auburn@gmail.com',0,'AIQY34+WUDqqaRaxGmTi5f6B6JDqwF7XPFgR7Ir/v7XW7NjGrQ7jg3Q5Hezebma/tQ==','3f47d864-2e78-4a56-9683-8169770e9e50',NULL,0,0,NULL,1,0,'christyauburn','Christy','Moore'),('ba690cfe-47be-415f-bf8a-dc266f003c83',NULL,'nancy_Carruth@belk.com',0,'ABRLO5/y1nYzAJ1PuSEUMi6u3H/xBphGVYrypmfNxuRLkwc8GKnjvEis6QQDHa6HbQ==','a0807d13-7964-4ada-ab8c-095de284af25',NULL,0,0,NULL,1,0,'ccarruth','Cole','Carruth'),('ba6b053a-72c6-423d-b5ec-9ec885a27d60',NULL,'stephen.burkell72@gmail.com',1,'AFqbRnf4vJd7GkZhrzSclEunlzsmbj4gJ12S4RovVXnrQdyk+l1pp+UU25Z8+kMPVg==','edfda54b-02cd-4a87-8957-ec270a21a5bf',NULL,0,0,NULL,1,0,'sburkell','Stephen','Burkell'),('bc2fcec9-b39c-4f02-9e1f-5cdb86e734e7',NULL,'twins63008@hotmail.com',0,'ALD7PkBvlMjPwX2p3FGebxDW9aAAnVNS2p1SdK3xMeqdeN8IAt25izZp930oDrM3cQ==','7f69465a-a78d-4ff4-9d1f-af97f41f580f',NULL,0,0,NULL,1,0,'FuehrerSC','Eric','Fuehrer'),('bddce3b0-72a9-4d93-bc54-fca1faa1a0f1',NULL,'dbfletcher55@gmail.com',0,'AG70gwqLSVZT5/xUg61j13CvjE35VmRfPJLOYKYX7aeiWuOqOQ/sU74fgnLjM9/ISg==','d6e8d84c-ac59-43ab-aa6e-be2c990c2759',NULL,0,0,NULL,1,0,'dfletc00','Donna','Fletcher'),('beb6666a-30ee-41ae-aaa6-5c487c8f04c8',NULL,'jmsageser@hotmail.com',1,'ANyzLQYtENMtT4EZVner++FoyhuIeCWFxTpDekPfMb6YI1dJwhz0iTrZ9cEQV4f5ow==','09962449-33b3-4e07-bada-2a7d99dd8762',NULL,0,0,NULL,1,0,'jmsageser','Jane','Sageser'),('bf314160-5162-4994-b985-74eb1bd850c9',NULL,'natashafrancis76@yahoo.com',0,'AM9IjWRqm1bFpdrP1M3wi8yZ+lIsITbZEKqR0YXYKNchdlch5W4xe1/QSQOeI+qnXA==','7cdc9097-ea10-4963-909b-0b091753fc5b',NULL,0,0,NULL,1,0,'natasha','natasha','francis'),('bf466859-6287-4abd-8f1f-dc85e4d06740',NULL,'Leweidner@gmail.com',0,'AO4W67AkoNBMzD0jpTLmMt+qIj0mqjQ4ftAjhpfG9MZ8P3Hckh6mMzeYSF7vwecZOA==','e002da6a-563e-4820-b432-776eafff1e58',NULL,0,0,NULL,1,0,'Leweidner','Laura','Weidner'),('c194559c-9131-49b0-bd83-c544be756e01',NULL,'karenmcdonaldnc@gmail.com',0,'AJQAuba+DN0c5OlX9mQ7HFAWgQ09yMXuxXUb01ze1fDF37IXPsiGvp+Nv8fDvDTlcA==','8448248d-237d-4a9a-9ba8-e983f22a9933',NULL,0,0,NULL,1,0,'brycenm','Brycen','McDonald'),('c3836517-fefa-478c-810b-15aad1c21934',NULL,'Caseyxo1@gmail.com',0,'AC9Qqhf3HNMPgCEKQDHfLnizgjzap4K1UErOkvF914Y30D/u3bZnr1M2rCfES9Ql4A==','ec5337f5-415f-4566-8924-643490e48023',NULL,0,0,NULL,1,0,'Caseyxo1','Gabriel','Pollock'),('c4e433a8-b04e-4e7b-b760-610962c2a365',NULL,'dhunt88@live.com',0,'AMVO5Nyzh252X3NNbwgSnjlMHoz+h+4/cwL4IH+/KZk5UQ7LloH1lJ+nvMApaGzsqw==','38cc0512-40b9-48e5-b1ea-a51476438fe9',NULL,0,0,NULL,1,0,'dhunt88','Davidh','Hunt'),('c843814f-0f1c-432f-8abb-9c201ba9d388',NULL,'darrellm27@att.net',0,'AOQZ7WkxF3M/eFouYL1dqqUijSCbFcTB01mluIHfj4ZXNNXSb87rqOB9/dsZ5HRZgA==','f9d56289-ae4d-4471-8387-725cfbbf25a5',NULL,0,0,NULL,1,0,'Towtruck11','darrell','mcdaniel'),('c9a6c169-aca8-42dc-b5a4-189208351da9',NULL,'katherine_brett21@yahoo.com',0,'AOATSRNf2f4tBNo7f5byJGEheaceqi1zVq5ms5UpKEGqDX6HOdxH35l+rxk3qY55Jg==','e3091000-3e88-44e7-bf88-f569f6bb9daa',NULL,0,0,NULL,1,0,'katbrett37','Katherine','Brett'),('ccea9383-09f6-4587-8423-6756821f5d4c',NULL,'MWMaster901@gmail.com',0,'APDNXqvStqxOtMZNcJB9V99mbnZP62e7U7UhXZCOZNzHVnVVWEEKm+MDaDG9kwtU9w==','054bcd83-a7b4-4869-b7ce-562aeb797745',NULL,0,0,NULL,1,0,'Christopher S.','Christopher','Schweninger'),('cd2694b2-a799-4849-8b21-c56737dc9a88',NULL,'NCarruth7@gmail.com',0,'AGkXvBh/cR68pEoy7Mq/WOuv0/463DWB39AL2AwgN5WJpo/sKIQX0/IrjXToEy+QBw==','5523fe25-52a9-48da-9d50-07ea8b182dfe',NULL,0,0,NULL,1,0,'NCarruth7','Nancy','Carruth'),('d39a1a6d-4a9a-4df2-89d9-e7760a0b4105',NULL,'cschweninger@outlook.com',1,'ADeTahPywQrXFPaUS1iKc+btVrAP5i4a0hQx6DMwGFosadILAaQfS6kedlKsgpjmdA==','2047afe8-3249-4f98-8e28-bfb99d2d442c',NULL,0,0,NULL,1,0,'Christopher S','Christopher','Schweninger'),('d3fb0a13-b6a4-4701-8458-76134458b0a4',NULL,'elamscott47@gmail.com',0,'AOEL2wbYgAhKCcYdp7nYkysSYtxozsNmQ8+YLTP6togoBvmOmkwSLCFLI1gGm9hgkQ==','534be721-6b3f-48a9-81b9-e1e92bae8e13',NULL,0,0,NULL,1,0,'scottelam','william','elam'),('d43c48c4-8ea5-4bf3-93d2-ad131796f485',NULL,'karenmcdonald.nc@gmail.com',0,'AD1/WeFRmmTerDyXRlMP8VIAOIU1tb2n7Eks8txwFE1N87f1ADY3IJ8kSpZ2wryhzA==','2eedfa2a-53ff-48cf-95a7-87961babe93d',NULL,0,0,NULL,1,0,'karenm','Karen','McDonald'),('d632527c-5f7f-4d39-96e7-507748c69daa',NULL,'frankcarns4@gmail.com',0,'ALujObrLJrWEvFGP80suYTuLsmUc4DuIySmMllT8K56oVslmx/W9lIoGWxkUwlEObw==','aa3d0510-bd00-43fd-9d26-198aa8ee78dd',NULL,0,0,NULL,1,0,'Frankcarns4','Frankie','carns'),('d99295d8-33bf-499b-986d-b837daf837b9',NULL,'cacinance@hotmail.com',0,'AIudEds7WgeiuMX6XuCmYXMA4vr63KQz5Oz5JO2vSye6TSk5IzsGncml/Lg8mWwPow==','dd6ba4c6-b0fe-4257-a6ae-6ae2b3e8e13a',NULL,0,0,NULL,1,0,'Cnance','Caci','Nance'),('da473ae4-faa4-45fd-b4c1-6adc561f7f1b',NULL,'Pebblesebx@aol.com',0,'AKisW6C5sOJf/AWAimXIT5WccTnYp6K9gURZWLG4GKYwjqfu1NPedzSMd8x9Bn0FoQ==','a5d06357-5e2f-4802-a9b6-cce3b513a9a4',NULL,0,0,NULL,1,0,'Pebblesebx@aol.com','Brenda','Stallworth'),('dac31629-2bf6-42d9-8c28-c38cb98b8e97',NULL,'ngreen7992@gmail.com',0,'AKfwY9tG8LuOZoH/SR7SYBUNeXiPd1dKXpkKCShNdB/5kqnQlNx4b/pRXkpGSoD/OA==','940cd3e7-cb66-4109-bb82-237625a15c86',NULL,0,0,NULL,1,0,'Ngreen7992','Nathan','Green'),('dbd65d40-5f14-4fec-9505-48297cfa9d8b',NULL,'Richardemyrick@yahoo.com',0,'AIE3oFR9lFyUKoq696K9tOzPZKoiP2cIFWvoAxBczTcvxaiEoXynGPX4ppHuYxdRJQ==','17d05bde-e9d7-42b0-b152-fdf227522a54',NULL,0,0,NULL,1,0,'Richardemyrick','Richard','Myrick'),('dc8d0d50-0b0b-436d-b1c8-39ead1ad56fe',NULL,'mandaprettyman@gmail.com',1,'AB0QwiMywggb3t5AFysSnKEW4IHZpbqD/oo5vBqQJD6fXIftm6Sqym8URSpjx+CSIg==','3cb9807b-d657-4709-87b4-bbe28eb6ae08',NULL,0,0,NULL,1,0,'mandaprettyman@gmail.com','Manda','Prettyman'),('ddd8df6f-21a1-472e-9de9-becf06141633',NULL,'blairbigger@hotmail.com',0,'AIbyox1u73jx0GwV8M33rjU8K46bN2KVnD4frHxEFtpp6VoU4ZqUTkE4qZ3J2R6V7g==','6e300e61-ad47-4b77-b4dd-a7a13819f26f',NULL,0,0,NULL,1,0,'BlairB','Blair','Bigger'),('df1a708e-4702-4435-81f1-ea5d77fcb5ce',NULL,'jessica.l.mcmasters@gmail.com',0,'AHDSC8LsLhqSel3mAYJ5M0ICMYIb7ysk1ZqHDx39Fqy8YjzNaUP6N59CvCTspvp8QA==','378f4f12-b100-4fba-bbe0-3744c9a1d7a9',NULL,0,0,NULL,1,0,'J_McMasters','Jessica','McMasters'),('df8f6008-0a3d-46a8-81d9-6bc1938f05f1',NULL,'nflproductions@hotmail.com',0,'ANsZ+vw+3IT5EqCdzMcEcvwIcBB1A4SxDnWuTf+EYI/k6a8BbWFFYeuTZdO606WugA==','ad84e09e-e134-4525-997f-17ee6cbe4c54',NULL,0,0,NULL,1,0,'DallasCowboys','Fred','Campbell, Sr.'),('dfed82f7-1f3c-4b61-b207-78b34370a283',NULL,'samantha_dill@yahoo.com',1,'ALxBHwdJEK5YLKfsF2oOR+mwIuxt664yrJj5KaNqqJEyw3cJ5AoYKiSgkeSv7r8GbQ==','6c37683a-7315-4720-adf3-8fc853123032',NULL,0,0,NULL,1,0,'Daltonmom','Samantha','Dill'),('e1156d3d-e021-452e-8af2-b37ff2e2cd3d',NULL,'amylee.wd@gmail.com',0,'ABogzlMLFCP2dVXJ3yUShCIbD1MUqa++5gzmVCE4KLTQbJi7LiWmPlCcKDQt4SoIjQ==','ba69cc94-5cd6-4915-ae92-3d34811c253c',NULL,0,0,NULL,1,0,'Dalton2010','Amy','Lee'),('e14a5238-4db8-42a0-94f0-b32ea4e5d6c6',NULL,'duree78@gmail.com',0,'AAB3gK2rnbYJR2NtkPIcHWSJo2ni8nt25Gpxw6io4rMe7iIuNj4xPS57S4I0pVFxYg==','7f2d6fd8-1284-4960-95a0-cc22e1a03cc8',NULL,0,0,NULL,1,0,'DureeLove','Duree','Love'),('e2d55ec0-53e1-4c40-aa94-89f24281d037',NULL,'jcrawford@stjohnsrh.org',0,'ABbAGRciUAPw80YmOz2mMgwWSM5voRLz9OZMGX8oNHYJE0U37hCjY3uofycPPVpHrw==','7ba822d9-1b17-47f6-8e4b-766ab886a4fd',NULL,0,0,NULL,1,0,'jenifer','Jenifer','Crawford'),('e386fc69-c3ec-454c-afab-48b9114d4fd3',NULL,'pstevens97@hotmail.com',0,'ALCZdp66ZCNhBedIV4bA3IEqIqazrjYWUf5eejU2c7QT4GY1Tm7yW+NSOdnhERNGTg==','9e84e15e-f0ba-4aca-941d-312113c362f9',NULL,0,0,NULL,1,0,'pstevens','Phillip','Stevens'),('e640ea8a-c21e-4a7c-9f7d-08c07c0a0458',NULL,'mcarruth@comporium.net',0,'AP0K4EF09+CntHf5fiTLOvSy1Ek1e38LjtzifuIW98LzNWy04a3JH9UuvI0aex9F2g==','7de4c38b-2092-496c-92cb-d5942bddca5a',NULL,0,0,NULL,1,0,'mcarruth','Nancy','Carruth'),('e6a43d37-3483-486e-91de-e5a1907a0bb0',NULL,'robinyoungh@yahoo.com',1,'AIQp/Pyxiqak9ikU7toHVfoDvQFLKy42r0huNWcTE01oJkQziUALen/7byLwFDdIlw==','cc4defed-24fe-4946-b038-c05c06283d31',NULL,0,0,NULL,1,0,'robinyoung','Daniel','Collins'),('e8c8aeb6-b008-4675-908e-1b3c09999558',NULL,'Ramsey8487@me.com',0,'AK8TFare0p/wWqf0RkPVfymx5COg4Qb5QBDwUeXEi/o2JDUsxK4mOKNW8b+8UZzwzQ==','18feeb11-94e4-40e6-998f-a09486c6da02',NULL,0,0,NULL,1,0,'Ramsey8487','Amber','Ramsey'),('eacb2c2d-a7eb-41c2-97cd-ef34152bc123',NULL,'fcampbel@rhmail.org',0,'AMFO8yB5t1EdI60yh0us/eV6xiSp8N1eYI6xB6XM4uHjCdW0UeI+snn4raqxKPvxVw==','1340294a-d9a8-400c-ba6b-c99a3432b37e',NULL,0,0,NULL,1,0,'FreddyBear','Frederic','Campbell'),('eb642bfb-ea0f-463b-b5ec-51aa3c011691',NULL,'nmsmartinez@msn.com',0,'AMddZeRoCNUbTq13mT3RMlfHQocS3mToSbrWR+nEGmzLp/mL70sj2mE8WmIPqeiGiw==','ac61993d-c568-4ef6-8b8e-b81a9edb668b',NULL,0,0,NULL,1,0,'nmsmartinez','Sara ','Martinez'),('eba32934-ea6d-4464-b955-517bc7dba267',NULL,'tyronfrancis77@gmail.com',0,'ADwMMcBLrKNMLXV7sOtDLWuNOkKZF9usNi2yc0sror1IkSaHupVnlm35MSDgvxMYoQ==','de0a8d1c-93f5-4836-aca1-aed2a4aeaae9',NULL,0,0,NULL,1,0,'tyron','tyron','francis'),('ed1a77a8-0169-48a0-8514-19a1effb8b8a',NULL,'joshuaclifforddavis@gmail.com',0,'AKqGsclx/ZkYW8nU0snIDCBjnm0W0qR+tYMQcMdeK/qi0BUWrr6p5Ii9lMpPhaFWiw==','0f33d5d6-a2fb-4cac-bf4c-c40ee230943a',NULL,0,0,NULL,1,0,'Goal2b1','Joshua','Davis'),('ee2005fd-9c53-4efd-b19c-c45f3dd72bba',NULL,'delaroni101@gmail.com',0,'APCe5LBjuMEsDdau14/kXt3QHXtPff7TSK7DIGFiFdBilnac30cQh8Xzo6IKXhFXrA==','dae06920-9f29-4ef1-b3f4-390827f198e4',NULL,0,0,NULL,1,0,'delaroni@gmail.com','Della','Louthan'),('f03d24db-f39f-4e99-953b-4531e9771f6a',NULL,'bkhowe803@yahoo.com',0,'AC56u0ZdEaO9tZddRbO4iDiLMJ3IN6+/DMRLo2vE8Afg+Ng1rMwQfOO/TNjkBdEP+A==','94589d0f-bf25-493f-a1f7-c2571ba8d6b1',NULL,0,0,NULL,1,0,'bkhowe803@yahoo.com','Brenda','Benton'),('f07f4312-e438-4cca-bb77-a2039cba1049',NULL,'jess.mart84@yahoo.com',0,'AERjEP+6HU2f4O6vJrvg+CSrqAqpP7XGI7wiSKhvQ66x8lrcNF3GrdyRcBhgGMW+hw==','858d6846-bcbf-4dcb-b112-6fca027626e8',NULL,0,0,NULL,1,0,'Jess.mart84@yahoo.com','Jessica','Martinez'),('f4a05e5f-0a86-436e-b442-c27332078ec5',NULL,'dchastain@comporium.net',0,'AJyDM1zzCuaXZTNKPVlP0mLIEkW+tHxhx7/I3rgbZw12e5roB16/vj8TwEBi8mj2LQ==','5c82553b-e818-44f1-a60e-cebddc654b42',NULL,0,0,NULL,1,0,'mchastain','Martha','Chastain'),('f65ea58e-b319-43ff-9d12-41c766e2e68b',NULL,'amyflowers75@gmail.com',0,'AMOpBabYbHGGXV/uPcMIRl1kAWhPiZmoh7rIiIjy+lR4fvxtuNUnfR0tomuw8no+IA==','a6655fc5-9f61-4423-ac52-5bc5e6e9bd1e',NULL,0,0,NULL,1,0,'aflowers','Amy','Flowers'),('f7580f59-4b50-42d5-a8ec-d1867ab515f9',NULL,'cdwhisonant@gmail.com',1,'AKosYkXcNu9XO7yTGAeS+Vvj2Fj2ERPbztmGhEVrtxPMS1gH3iNj9/SmV5ns72SecQ==','2d2a5a9e-5df7-410d-8602-4ba8f375f3fb',NULL,0,0,NULL,1,0,'cdwhisonant','Cathy','Whisonant'),('f8dfca4b-7f4f-4fa3-8c71-bdf5319e7f22',NULL,'grimmdude06@gmail.com',0,'AJuT6qeAPzl9L1e6qZpTKg+reyBjXD6TNcCQijoE7s3G3qrqPNuA7WyCYm4d3N7Zsw==','470dfba6-8388-48d3-a498-6ed22f7f1355',NULL,0,0,NULL,1,0,'grimmdude06','Wyatt','Grimm'),('fa4a17cb-924b-4f92-b1e9-a447c1b4ec64',NULL,'constance.booth310@gmail.com',1,'AFxvDPN39FjAgHHTI4T5DWCih+2YxtOY77jYFDEAJRscozNUuLnWjpjxB3Bh3Dq2cw==','2b6a3d73-9f8c-4c69-b95f-e5923435560a',NULL,0,0,NULL,1,0,'boothconnie','constance','booth'),('fad12849-4667-46ed-b8b1-e8372345b8ae',NULL,'Jeancarlo@jcoversight.com',1,'ACrXpt2Vd5T5nhy12uPUinfWvxeoVIpQshL5a/iNJELPug1riI+bNUB8hEtZRFzbUQ==','71f77c6f-fe39-41ba-80ae-9ad6545b96fb',NULL,0,0,NULL,1,0,'JCTheKid','Jeancarlo','Cayo'),('fc6b1dd3-4e21-4c14-9d93-9e084a55fba1',NULL,'amyclark413@gmail.com',0,'AIn9ObWy3Iq8TbIJIsn6Is8HIoOcw4GVMeZYXPdNss+mWMztvlakxrWib324iCYIhQ==','c920a9f2-6915-41e7-af71-313f42032aea',NULL,0,0,NULL,1,0,'amyclark413@gmail.com','Amy','Clark'),('fe9c51fb-147b-4e12-8f4c-5ed06aef8859',NULL,'Denisecubb@gmail.com',0,'AITdMP6lDc7DPu+r9TmDRK0kLg7CxuFNkMZCNu+ukD8RJA46S0zIfgWQa0A90D9agw==','c0cf4242-5690-4414-8e15-2560f1d0cc2a',NULL,0,0,NULL,1,0,'Denisecubb','Denise','Cubbedge');
/*!40000 ALTER TABLE `aspnetusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactinfo`
--

DROP TABLE IF EXISTS `contactinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactinfo` (
  `ContactInfoID` int(11) NOT NULL AUTO_INCREMENT,
  `ContactName` varchar(45) NOT NULL,
  `HomePhone` varchar(15) DEFAULT NULL,
  `CellPhone` varchar(15) DEFAULT NULL,
  `Email` varchar(45) NOT NULL,
  `Address1` varchar(50) NOT NULL,
  `Address2` varchar(50) DEFAULT NULL,
  `City` varchar(45) NOT NULL,
  `State` varchar(2) NOT NULL,
  `Zip` varchar(10) NOT NULL,
  PRIMARY KEY (`ContactInfoID`)
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactinfo`
--

LOCK TABLES `contactinfo` WRITE;
/*!40000 ALTER TABLE `contactinfo` DISABLE KEYS */;
INSERT INTO `contactinfo` VALUES (1,'Bethelwoods','803-366-3722',NULL,'info@bethelwoods.org','922 W. Mount Gallant Rd.',NULL,'York','SC','29745'),(71,'ROBERT FLOWERS','8039845211','8039845211','flowersr99@gmail.com','1026 W. Mount Gallant Rd.',NULL,'York','SC','29732'),(72,'Danny Culver','8033714425','8033289938','spectrallights@gmail.com','2270 Eastview Road',NULL,'Rock HIll','SC','29732'),(74,'Jennifer Culver','8034487564','8034487564','jenculver@hotmail.com','2270 Eastview Rd',NULL,'Rock Hill','SC','29732'),(75,'Deana Williams','8036310607','7046812626','sierrashome2000@yahoo.com','6340 Royal Pines Dr',NULL,'Clover','SC','29710'),(76,'Manda Prettyman','8036270085','3364373820','prettyman5@live.com','7064 Sonja DR',NULL,'Clover ','SC','29710'),(77,'Manda Prettyman','3364373820',NULL,'mandaprettyman@gmail.com','7064 Sonja Dr',NULL,'Clover','SC','29710'),(78,'Samantha Dill','8039847518','8039847518','samantha_dill@yahoo.com','508 Sansberry Drive',NULL,'York','SC','29745'),(79,'Tara Burgess','8034933829','8034933829','TaraBurgess@comporium.net','607 Pondway Downs',NULL,'Rock Hill','SC','29730'),(80,'Robert Gasperson','8034931958','8034931958','Rgasperson@gmail.com','2534 Fire Tower Rd',NULL,'Rock Hill','SC','29730'),(81,'Sonia Colon','8032309796','8032309796','Soniacolon@yahoo.com','834 Von Buren Blvd',NULL,'Rock Hill','SC','29730'),(82,'constance booth','7047409231',NULL,'constance.booth310@gmail.com','125 bollin circle',NULL,'fort mill','SC','29715'),(83,'Rick Mitchell','803-328-9523',NULL,'ncpack132@msn.com','2175 Hall Spencer RD',NULL,'Edgemoor','SC','29712'),(84,'Thressa Elam','8033716950','8033716950','Thressaelam@gmail.com','1559 Springpoint Rd ',NULL,'Rock Hill ','SC','29732'),(85,'Nicole Flippin','8033247740','561-602-1464','nikflippin@bellsouth.net','2739 Lake Wylie Drive',NULL,'Rock Hill','SC','29732'),(86,'Stephen Burkell','2525147404','2525147404','stephen.burkell72@gmail.com','2818 Hord Rd',NULL,'York','SC','29745'),(87,'Jane Sageser','8035470594','8034316695','jmsageser@hotmail.com','108 Melrose Ct.',NULL,'Fort Mill','SC','29715'),(88,'roy boyd','803-230-0143','803-230-0143','royhboyd@gmail.com','1101 Neelys Creek Road',NULL,'Rock Hill','SC','29730'),(89,'Katherine Hylton','704-519-7959','704-519-7959','Katiehylton@gmail.com','121 W Gregg St',NULL,'Fort Mill','SC','29715'),(91,'Daniel Collins','803-981-0823','803-984-0823','robinyoungh@yahoo.com','3747 Walker Rd',NULL,'Rock Hill','SC','29730'),(92,'Eric  JACOBS','8034870972','8034870972','eric_susan_george@yahoo.com','170 Whitleymills rd',NULL,'Fort mill ','SC','29708'),(93,'Robert Flowers','(803)628-1949','(803)984-5211','rwflowers@comporium.net','1026 W. Mount Gallant Rd.',NULL,'York','SC','29745'),(94,'Christopher Schweninger','(803)487-5856','(803)487-5856','cschweninger@outlook.com','1413 Gordon Rd.',NULL,'Rock hill','SC','29732'),(95,'Melissa Daniels','8038106340','5857377808','scoobynurse@yahoo.com','226 Brown PElican Court',NULL,'Clover','SC','29710'),(96,'Jeancarlo Cayo','704 488 6313','704 406 7975','Jeancarlo@jcoversight.com','14624 Arlandes Dr',NULL,'Charlotte','NC','28278'),(97,'Ellen Taylor','5203000407','5203000407','eetaylor74@yahoo.com','3157 Tanglewood Dr',NULL,'Rock Hill','SC','29732'),(98,'Stacy Gumphrey','8034485957',NULL,'Gump@rhmail.org','1020 Our Road',NULL,'Rock Hill','SC','29732'),(99,'Ellen Taylor','5203000407','5203000407','eetaylor74@gmail.com','3157 Tanglewood Dr',NULL,'Rock Hill','SC','29732'),(100,'Cathy Whisonant','803-417-8220',NULL,'cdwhisonant@gmail.com','1572 Brandyhill drive',NULL,'rock hill','SC','29732'),(101,'Robert Willis','8039855584','8035176532','willisrljr@comporium.net','4062 Timber Crossing Dr.',NULL,'Rock Hill','SC','29730'),(102,'Robbye Helms','8033272641','8034172513','Robbye_24@yahoo.com','1521 W Decatur Dr',NULL,'Rock Hill','SC','29730'),(103,'Robert Flowers','8039845211','8039845211','rflowers@saber98.com','1026 W. Mount Gallant Rd.',NULL,'York','SC','29745'),(104,'DTEst TEstCUlver','8033714425',NULL,'spectrallights@hotmail.com','2270 Eastview Road',NULL,'Rock hill','SC','29732'),(105,'Amy Flowers','8039845210','8039845210','amyflowers75@gmail.com','1026 W. Mount Gallant Rd.',NULL,'York','SC','29745'),(106,'Mark Prescott','803-818-4455','803-322-6053','msprescott5@live.com','1218 Applewood Lane',NULL,'York ','SC','29745'),(107,'Jacquelina Cox','8036100112','3364607987','Amara278@gmail.com','2081 ROSCOMMON DR',NULL,'Clover','SC','29710'),(108,'darrell mcdaniel','8035246895','8035247823','darrellm27@att.net','1737 kenneth dr',NULL,'rockhill','SC','29730'),(109,'William McCorkle','(803)280-5194','(803)280-5194','amccorkle@gmail.com','116 Front Porch Dr',NULL,'Rock Hill','SC','29732'),(110,'Brian Cope','803-818-1053','803-818-1053','copeba@alumni.clemson.edu','200 Blue Heron Dr',NULL,'Rock Hill','SC','29732'),(111,'cindy rebman','757-831-6132','7578316132','cyndilynn@aol.com','1744 Betony Lane',NULL,'Tega Cay','SC','29708'),(112,'Thomas Thomas','8035198262','8035198262','taylor.thomas@scouting.org','151 Fernwood Drive','Apartment 151K','Spartanburg','SC','29307'),(113,'Amber Ramsey','8034488943','8034488943','Ramsey8487@me.com','512 sansberry dr',NULL,'York','SC','29745'),(114,'Sandi  Patrick ','8039815009','8032306937','squeash2003@yahoo.com','805 Bubbling Brook Drive ',NULL,'Rock Hill ','SC','29732'),(115,'Donna Fletcher','8033660150','8034871930','dbfletcher55@gmail.com','722 Catchpoint Drive',NULL,'Rock Hill','SC','29732'),(116,'RONALD FLETCHER','8033660150','8033660150','ronaldfletcher1990@gmail.com','722 CATCHPOINT DRIVE',NULL,'ROCK HILL','SC','29732'),(117,'Natasha Slack','803-524-0041','803-524-0041','nscutie979@yahoo.com','7107 Moores Creek',NULL,'Rock Hill','SC','29732'),(118,'Chase Higgins','803-524-0041','803-524-0041','nscutie979@gmail.com','7107 Moores Creek',NULL,'Rock Hill','SC','29732'),(119,'Stephanie Tinker','8034484976','8034484976','stephanie.b.tinker@gmail.com','735 South Cherry Road',NULL,'Rock Hill','SC','29732'),(120,'Michael  Feimster','7048078265','7048078265','Price@designbrothers.com','330 shurley st',NULL,'Rock hill','SC','29732'),(121,'Jackson Hayes','7047733551','7047733551','asistare@installationsolutionsinc.com','628 Wamsutter Ln',NULL,'Rock Hill','SC','29730'),(122,'Calvin Lyle','8033704043','8033704043','Cassieclark415@gmail.com','2310 wildwood dr',NULL,'York','SC','29745'),(123,'James Parrish','8034484510','8034484510','tparrish@goencompass.com','3989 firethorn lane',NULL,'Rock Hill','SC','29732'),(124,'Cara Rohlfs','704-236-9775','704-236-9775','cararohlfs@gmail.com','105 Melrose Ct',NULL,'Fort Mill','SC','29715'),(125,'Karen Brogdon','8033603241','8033603241','pinkhippo1978@aol.com','1890 Neely Store Road',NULL,'Rock Hill','SC','29730'),(126,'Cynthia Jackson','803-627-0005',NULL,'cynjackson24@aol.com','628 Drury Lane',NULL,'Clover','SC','29710'),(127,'Glenn Stoner','8645904432','8645904432','lakedude@bellsouth.net','476 Squirrel Lane',NULL,'Lake Wylie','SC','29710'),(128,'Larry Caulder','8032304389','803-230-4389','spacecrow@aol.com','2808 Wilmington Circle',NULL,'Fort Mill','SC','29715'),(129,'Jacob Bendt','8032302120','8034486174','TheBendtFamily@Comporium.net','1100 Hearthstone Ct',NULL,'ROCK HILL','SC','29732'),(130,'Duree Love','7046617636','7046617636','duree78@gmail.com','1875 Davis Circle',NULL,'Clover','SC','29710'),(131,'Nathan Green','3046177992','3046177992','ngreen7992@gmail.com','105 Benfield Ave',NULL,'York ','SC','29745'),(132,'Ellen Wilder-Byrd','803 366 4354','803 984 6070','wilderbyrde@winthrop.edu','395 Shurley Street',NULL,'Rock Hill','SC','29732'),(133,'Brenda Benton','8039849894','8039814994','bkhowe803@yahoo.com','1968 Pinevalley Rd',NULL,'Rock Hill','SC','29732'),(134,'Jesse McGee','3363171265','3363171265','Tarheelmcgeeunc@yahoo.com','2310 Meadow Sweet Way','Apt 202','Fort Mill','SC','29708'),(135,'Sara  Martinez','5059750509','5059750509','nmsmartinez@msn.com','1159 Ross Brook Trace',NULL,'york','SC','29745'),(136,'meghan wier','8034125770','8034125770','meg@meghanwier.com','1224 stonecrest blvd',NULL,'tega cay','SC','29708'),(137,'laura cripe','8037464795','8037464795','laurac@comporium.net','233 loch stone',NULL,'Fort Mill','SC','29715'),(138,'Samuel Clack','8039843119','8039843119','Rtrclack@gmail.com','161 WEATHERWOOD ST',NULL,'ROCK HILL','SC','29732-9152'),(139,'Sally Baker','8034484516','8034484516','siwbaker@gmail.com','1218 Thornwell Avenue',NULL,'Rock Hill','SC','29732'),(140,'Robie Grissom','8033709037','8033709037','grissomrobie@hotmail.com','191 E.Springdale rd',NULL,'Rock hill','SC','29730'),(141,'Frankie carns','7042806392','7042806392','frankcarns4@gmail.com','7402 Sheffingdell drive',NULL,'Charlotte','NC','28226'),(142,'Patricia Swoope','(803) 329-3439','803 554-0252','paswoope@hotmail.com','662 cannon drive',NULL,'Rock Hill','SC','29730'),(143,'Kara Hawkins','7049058648','7049058648','karahawkins@email.com','2570 Aspen Terrace',NULL,'Rock Hill','SC','29732'),(144,'Amy Michalesko','4105332901',NULL,'amichalesko@me.com','3158 Amaranth Drive',NULL,'Tega Cay','SC','29708'),(145,'Allison Lenzi','(910)520-5594','(910)520-5594','Lenziallison@gmail.com','5036 Sequoia Drive',NULL,'Rock Hill','SC','29732'),(146,'Randy Parks ','(803)415-7086',NULL,'parkscontractor@aol.com','2884 Chapman Circle ',NULL,'Rock Hill ','SC','29732'),(147,'Delete ME','8033714425',NULL,'yorkdaycamp@gmail.com','2270 Eastview Road',NULL,'Rock HIll','SC','29732'),(148,'Wyatt James','8034145955','803-414-5955','ktbugggg@gmail.com','5806 Fiesta Road',NULL,'Lake Wylie','SC','29710'),(149,'Jana Cathey','7045341723','7045341723','janacathey@gmail.com','1016 Swaying Oats Dr',NULL,'York','SC','29745-6392'),(150,'Amber Paige','8033893199','8033893199','apaige2238@yahoo.com','491 Lexie Ln.',NULL,'Rock Hill','SC','29732'),(151,'steven schweninger','(803)524-5219','(803)412-6054','stevenjr@comporium.net','1413 gordon rd',NULL,'rock hill','SC','29732'),(152,'Kristy  Powell ','8038995350','8038995350','Kristypowell419@yahoo.com','465 S Shiloh rd ',NULL,'York ','SC','29745'),(153,'Paul Powell','8038994841','8038994841','Paulpowell419@gmail.com','465 S Shiloh rd',NULL,'York','SC','29745'),(154,'Janice Chadwick ','8038995350','9106122068','Kristypowell4q9@gmail.com','465 S Shiloh rd ',NULL,'York','SC','29745'),(155,'Nancy Carruth','8034932387','8034932387','mcarruth@comporium.net','285 Peachtree Rd',NULL,'Rock Hill','SC','29730'),(156,'Niki McBroom','8032886536','8032886536','nmcbroom@gmail.com','1280 Pinewood Road',NULL,'Rock Hill','SC','29730'),(157,'Michael Carruth','8032420504','8032420504','mcarruth2001@yahoo.com','285 Peachtree Rd',NULL,'Rock Hill','SC','29730'),(158,'Cole Carruth','8034932387','8034932387','nancy_Carruth@belk.com','285 Peachtree Rd',NULL,'Rock Hill','SC','29730'),(159,'Christine  Chavis ','8033281585','6145063450','Christine.chavis@yahoo.com','4010 Galleria Pointe Circle ',NULL,'Rock Hill ','SC','29730'),(160,'Jennifer Waters','8034480880','8034480880','jennwaters107@gmail.com','3031 Sunshower Hts',NULL,'York','SC','29745'),(161,'Cristina Renzoni','8032090050','8032090050','xtinavincent80@gmail.com','1652 Old Nation Road',NULL,'Fort Mill','SC','29715'),(162,'Kimberley  Garrison ','8036274640','8036274640','Lgmadonna@aol.com','553 sandifer rd ',NULL,'York ','SC','29745'),(163,'Vanessa Fulcher','8034873292','8034873292','vfulcher@gmail.com','2335 Sparrow Dr.',NULL,'Rock Hill','SC','29732'),(164,'Blair Bigger','8034122867','8034122867','blairbigger@hotmail.com','2180 Nighthawk Dr',NULL,'Rock Hill','SC','29732'),(165,'Graham Alexander','8034483972','8034483972','calexander101299@gmail.com','2639 Aspen Ter',NULL,'Rock Hill','SC','29732-1566'),(166,'Robert Rickey','8033249445','8432402055','robrickey@gmail.com','512 Cool Creek Drive',NULL,'Rock Hill','SC','29732'),(167,'Tim Sabella','7046228591','17046228591','timsabella@hotmail.com','2919 Baird Rd',NULL,'Clover','SC','29710'),(168,'Mark Klopenstine','803-524-5898','5742744111','icuklop@hotmail.com','642 Bannerman Ln',NULL,'Fort Mill','SC','29715'),(169,'Peyton Blades','803-242-8018','803-242-8018','kikeblades@yahoo.com','404 Brookhollow dr',NULL,'York','SC','29745'),(170,'Chris Scarborough ','803-328-9784','803-524-6552','C_scar@yahoo.com','1617 The Crossing',NULL,'Rock Hill','SC','29732'),(171,'Amy Strong','404-538-3576','404-538-3576','agstrong1215@gmail.com','2502 ivy Creek Ford',NULL,'York ','SC','29745'),(172,'Samantha Dill','8039847518','8039847518','rocco.bacelli@yahoo.com','508 Sansberry Drive',NULL,'York','SC','29745'),(173,'Jack Anthony','8035176150','8035176150','janthony@comporium.net','1545 Nichole Lane',NULL,'Fort Mill','SC','29708'),(174,'Denise Cubbedge','803-230-6522','803-230-6522','Denisecubb@gmail.com','913 Gristmill Drive',NULL,'Rock Hill','SC','29732'),(175,'Martha Chastain','8034932157','8034932157','dchastain@comporium.net','333 Breckenridge Place',NULL,'Rock Hill','SC','29732'),(176,'Laura Johnston','8035178135','8035178135','ljohnston@rhmail.org','337 Limehouse Ct',NULL,'Rock Hill','SC','29732'),(177,'Rosie Hopkins-Campbell','704-813-6620',NULL,'rosie09@bellsouth.net','P.O. Box 113',NULL,'Clover','SC','29710'),(178,'Fred Campbell, Sr.','704-813-6617',NULL,'nflproductions@hotmail.com','104 Wilson St.',NULL,'Clover','SC','29710'),(179,'Eric Fuehrer','7045196361','7045196360','twins63008@hotmail.com','667 Hosta Drive',NULL,'Fort Mill','SC','29715'),(180,'Caci Nance','803-371-2416',NULL,'cacinance@hotmail.com','2350 Hwy 161',NULL,'York','SC','29745'),(181,'Alyssa Lesmeister','8034871601','7046007435','Godlygirl11@yahoo.com','200 Sheffield Drive',NULL,'York','SC','29745'),(182,'Davidh Hunt','(980)322-1127','9803221127','dhunt88@live.com','699 Winding Branch Rd',NULL,'Rock Hill','SC','29732'),(183,'ANDREW HANE','7045822931','7045822931','ANDREWHANE@ROCKETMAIL.COM','616 AIKEN AVE',NULL,'ROCK HILL','SC','29730'),(184,'Christy Moore','8035483745','7043618530','christy.auburn@gmail.com','857 Stratford Run Drive',NULL,'Fort Mill','SC','29708'),(185,'Cristy Clack','8039843119','8039843119','Cristyclack@gmail.com','161 weatherwood  st',NULL,'Rock hill','SC','29732'),(186,'Patrick Williams','8032300585','8032300585','Pwilliams2448@gmail.com','3430 Goodplace Rd',NULL,'Rock Hill','SC','29732'),(187,'Test Test','8033289938','8033714425','spectrallight@gmail.com','2270 Eastview Road',NULL,'Rock HIll','SC','29732'),(188,'Paul Miller','8038311991','3362104401','cartermiller@bellsouth.net','2570 S Paraham Rd',NULL,'York','SC','29745'),(189,'Monica McCoy','8038182186','8033709919','brysonheights@hotmail.com','1494 Andora Dr',NULL,'Rock Hill','SC','29732'),(190,'Kelly Schifferle','8032422358','8032422358','Kelly_rockhill@yahoo.com','4065 canvas ave',NULL,'Rock Hill','SC','29732'),(191,'Christina Poetzl','7176828865','7176828865','crissypoetzl@gmail.com','311 Windy Pine Dr',NULL,'Clover','SC','29710'),(192,'Richard Myrick','8038311174','8646305823','Richardemyrick@yahoo.com','291 Rippling Creek Drive',NULL,'York','SC','29745'),(193,'Frederic Campbell','7048136617','7048136617','fcampbel@rhmail.org','Po Box 113',NULL,'Clover','SC','29710'),(194,'Pam Horack','8038311929','7043017522','p_horack@bellsouth.net','8 Mischief Lane',NULL,'Lake Wylie','SC','29710'),(195,'Sheri Lichty','8033706642',NULL,'sherilichty@yahoo.com','3248 Wicklow Ln',NULL,'Lake Wylie','SC','29710'),(196,'Christina Poetzl','717-682-8865','717-682-8865','pack333@yahoo.com','US 311 Windy Pine Drive',NULL,'Clover','SC','29710'),(197,'Elizabeth Rollyson','3307148213','3307148213','Champusa1@aol.com','1862 Gingercake Cir','Apartment 308','Rock Hill','SC','29732-7421'),(198,'Lisa-Anne  Williams','915-867-2065',NULL,'littlehickorynut2@yahoo.com','2477 Westminster Dr',NULL,'Rock Hill','SC','29732'),(199,'Cullen  Dellinger','803-517-7133','803-517-7957','adelling@rhmail.org','421 Harvest Moon Lane',NULL,'Rock HIll','SC','29732'),(200,'Stuart Hildebrandt','8033517595','8033517595','stuart.hildebrandt@gmail.com','144 Gladstone Ct',NULL,'Rock Hill','SC','29730'),(201,'Levi Bennett','8016432478','18016432478','fatheads5@hotmail.com','5246 Lake Wylie Rd',NULL,'Clover','SC','29710'),(202,'Amy Dellinger','803-517-7957',NULL,'amydelling@yahoo.com','421 Harvest Moon Lane',NULL,'Rock Hill','SC','29732'),(203,'Jessica McMasters','8035260648','8035260648','jessica.l.mcmasters@gmail.com','14 Hamiltons Bay Court','Apt. 516','Lake Wylie','SC','29710'),(204,'Amy Clark','803-517-1313','803-493-7576','amyclark413@gmail.com','1082 west hwy 324',NULL,'Rock hill','SC','29730'),(205,'pete schreiber','2252841474','2252841474','pete.schreiber5@gmail.com','2815 arrowwood ln',NULL,'rock hill','SC','29732'),(206,'Julie Piehl','980-322-4377','980-322-4377','julie.m.piehl@gmail.com','1100 Long Creek Ct',NULL,'Lake Wylie','SC','29710'),(207,'Natasha Tarbrake','4233942545','4233942545','natashatarbrake@yahoo.com','862 E Old Limestone Rd',NULL,'York','SC','29745'),(208,'Billy Bronson ','7044494557',NULL,'roseburline@hotmail.com','1873 Apple Blossom Road ',NULL,'York','SC','29745'),(209,'Anna Bowman','8035799578','8035799578','annabowman1911@gmail.com','2 Hall Street',NULL,'York','SC','29745'),(210,'ryan Magee','8033890755',NULL,'rwmagee90@hotmail.com','1822 Twin Lakes Rd',NULL,'Rock Hill','SC','29732'),(211,'Bob Pellegrino','7046163083','7046163083','rpellegrino369@gmail.com','377 Iron Club Dr',NULL,'York','SC','29745'),(212,'Thomas  Clark ','8035171313','8034937576','tclark@mccoroyconstruction.com','1082 west Hwy 324 ',NULL,'Rock Hill','SC','29730'),(213,'Lora Lindquist','8433186939','8433186939','blueheronfty@yahoo.com','648 Becker Avenue',NULL,'Fort Mill','SC','29715'),(214,'Della Louthan','8034172455','8034172455','delaroni101@gmail.com','112 Ritch St.',NULL,'Fort Mill','SC','29715'),(215,'Matthew Gandolfi','8034125625','9802083613','Mattgandolfi@gmail.com','327 Hawks Creek Pkwy',NULL,'Fort Mill ','SC','29708'),(216,'Matthew  Gandolfi','8034125625','9802083613','Mattgandolfi@yahoo.com','327 Hawks Creek',NULL,'Fort Mill ','SC','29708'),(217,'Tammy Frailey ','803-628-1385',NULL,'Frailey.tammy@yahoo.com','442 Crowders Bluff Crt ',NULL,'Cliver','SC','29710'),(218,'Angela Moon','8036758137',NULL,'Moonsheart1966@gmail.com','1335 dunmore court',NULL,'Clover','SC','29710'),(219,'Elizabeth Morgan','8034930296','8034930296','Sullylizj@gmail.com','1535 Museum Road',NULL,'Rock Hill','SC','29732'),(220,'Jenifer Crawford','8034173974','8034173974','jcrawford@stjohnsrh.org','1997 Cavendale Drive',NULL,'Rock Hill','SC','29732'),(221,'Franklin Smith','(704)807-2281','(704)807-2281','franklin.smith@scouting.org','2031 Manila Bay Lane',NULL,'Tega Cay','SC','29708'),(222,'Courtney Hemphill','704-796-0390',NULL,'chemphill3@gmail.com','1749 Williamsburg Dr.',NULL,'Rock Hill','SC','29732'),(223,'Kris Blair','(803) 493-4416','(803) 493-4416','kblair413@yahoo.com','1337 Jessica\'s Way',NULL,'Rock Hill','SC','29730'),(224,'natasha francis','6236281495','6236281495','natashafrancis76@yahoo.com','4531 summerside dr.',NULL,'lakewylie','SC','29710'),(225,'Joshua Davis','(704)649-2590','(704)649-2590','joshuaclifforddavis@gmail.com','614 Bayou Circle',NULL,'Lake Wylie','SC','29710'),(226,'Christopher Schweninger','(803)524-5219','(803)412-5546','MWMaster901@gmail.com','1413 Gordon Rd.',NULL,'SC','SC','29732'),(227,'Logan FitzGibbon','7045771110','7047873627','LPFitz05@gmail.com','12900 SEASCAPE LN',NULL,'Charlotte','NC','28278'),(228,'Benjamin  Kelly','8037928627','7047738329','bkelly@galvan-ize.com','152 Evening Shadow Rd',NULL,'Clover','SC','29710-884'),(229,'Amy Lynch','8033714622','8033714622','amylynch1117@gmail.com','478 Dutch White Dr',NULL,'Clover','SC','29710'),(230,'Jonathan Parris','6157961331','6157961331','jwparris@gmail.com','168 Misty Woods Drive',NULL,'Lake Wylie','SC','29710'),(231,'Tina  Ngyuen ','704-587-0080','980-475-7568','Tinatran275@hotmail.com','768 Irish green dr',NULL,'Clover ','SC','29710'),(232,'Amanda Daum','7042228368','7042228368','amandatja3@icloud.com','724 waterfall way',NULL,'Lake wylie','SC','29710'),(233,'tyron francis','6236281495','6236281802','tyronfrancis77@gmail.com','4531 summerside dr.',NULL,'lakewylie','SC','29710'),(234,'rebececca isenhour','8036274319','8036274319','isenhour9@gmail.com','4531 summerside dr.',NULL,'lakewylie','SC','29710'),(235,'Phillip Stevens','8032892704','8032892704','pstevens97@hotmail.com','2007 Delfin Ct',NULL,'Rock Hill','SC','29730'),(236,'Tina Byrd','704-779-3420','7047793420','tina.byrd.2@gmail.com','1513 Highcrest Way',NULL,'Rock Hill','SC','29730'),(237,'Betty Anne Henson','8039841194','8039841194','Bam7_99@yahoo.com','5515 Charter Oaks lane ',NULL,'York','SC','29745'),(238,'Laura Weidner','4109918599','4109918599','Leweidner@gmail.com','425 Inverness Place',NULL,'Rock Hill','SC','29730'),(239,'Test Account','5555555555','5555555555','spectere99@hotmail.com','1026 W. Mount Gallant Rd.',NULL,'York','SC','29732'),(240,'Stacey  Hunter','803-242-3968','803-242-3968','shunter@rhmail.org','3021 McCall Meadows Dr',NULL,'Rock Hill','SC','29730'),(241,'Frances Felix','7184504078','(718)450-4078','ffelix0907@gmail.com','480 Alysia Ct','#303','Rock Hill','SC','29732'),(242,'Jennifer Thompson','803620222','8034151310','panetta76@mac.com','2708 Runyon Ct',NULL,'York','SC','29745'),(243,'Jonas Baker','803-631-6288','786-443-5548','Chiller725@gmail.com','5888 Morning Star Rd',NULL,'Clover','SC','29710'),(244,'Joshua Poulter ','8033710728','8033710728','jspoulter@gmail.com','529 chasebrook dr',NULL,'Rock hill','SC','29732'),(245,'Jennifer Dulin ','8039854520','3046739665','Jenniferdulin85@yahoo.com','457 guiness place',NULL,'Rock hill','SC','29730'),(246,'Dana Jones','8032334941','7046091503','danalbjones@outlook.com','1000 Labrador Ln',NULL,'Lake Wylie','SC','29710'),(247,'Carolee Adams','7047909438','7047909438','cmiller_advocate@live.com','608 Red Hawk Way',NULL,'Clover','SC','29710'),(248,'Fred Campbell, III','803-222-9662','704-813-6620','10hust@gmail.com','PO Box 113',NULL,'Clover','SC','29710'),(249,'Paige  Donatello ','8609426756','8609426756','paigedon11@gmail.com','1569 Estes Drive',NULL,'Rock Hill ','SC','29732'),(250,'Jerry Wiebe','803-684-1537','704-507-9306','mariaewiebe@gmail.com','1338 Bryson Creek Rd',NULL,'McConnells','SC','29726'),(251,'Jill Sabella','(803) 526-1655','(803) 526-1655','sabellaemail@gmail.com','2919 Baird Road',NULL,'Clover','SC','29710'),(252,'Pamela Hutchison','8035240066','8032423721','tobias2614@gmail.com','Po Box 504',NULL,'Rock Hill','SC','29731'),(253,'Katherine Brett','8647352899','8647352899','katherine_brett21@yahoo.com','808 Cullybackey Dr','201','Rock Hill','SC','29730'),(254,'Joshua Waldrop','8032077944','8032077944','ctephanie2014@gmail.com','1233 singletary lane',NULL,'york','SC','29745'),(255,'Nancy Carruth','8034932387','8034932387','NCarruth7@gmail.com','285 Peachtree Rd',NULL,'Rock Hill','SC','29730'),(256,'william elam','8033716951','8033716951','elamscott47@gmail.com','1559 Springpoint Rd',NULL,'rock hill','SC','29732'),(257,'Karen McDonald','4197047348','4197047348','karenmcdonald.nc@gmail.com','1899 Hopewell Rd',NULL,'Rock Hill','SC','29730'),(258,'William Robinson, Sr.','8033240738',NULL,'lrobinson@wfcorp.com','322 Neely Store Rd',NULL,'Rock Hill','SC','29730'),(259,'Debra Savoie','8034743274','8034743274','debbielsavoie@aol.com','1233 Singletary Ln.',NULL,'York','SC','29745'),(260,'Gabriel Pollock','7169303257',NULL,'Caseyxo1@gmail.com','1809 Paces River Ave ','Apt. 201','Rock Hill','SC','29732'),(261,'Wyatt Grimm','8039813276','8039813276','grimmdude06@gmail.com','521 Brown Oates Rd',NULL,'YORK','SC','29745'),(262,'Tony Sanders','803 326-2085','704 201-5271','tbert632@yahoo.com','632 Goldflower Drive',NULL,'Rock Hill','SC','29732'),(263,'Gabriel Collins','803 326-2085','704 201-5271','gabecollins632@yahoo.com','623 Goldflower Drive',NULL,'Rock Hill','SC','29732'),(264,'Julie Moore','8033702235','8033702235','Froggie_jg82@hotmail.com','532 Chase Brook Drive',NULL,'Rock Hill','SC','29732'),(265,'Brycen McDonald','4197047348','4197047348','karenmcdonaldnc@gmail.com','1899 Hopewell',NULL,'Rock Hill','SC','29730'),(266,'Kellie Stevens','8032304207','8032304207','Kstevensyork@yahoo.com','2007 Delfin Ct',NULL,'Rock Hill','SC','29730'),(267,'Colby Schneider','8036161188',NULL,'Vcschneider86@gmail.com','104 durwood rd',NULL,'Rock hill','SC','29730'),(268,'Michael Carruth','8032420504','8032420504','Michael.Carruth@ycnga.com','285 Peachtree Rd',NULL,'Rock Hill','SC','29730'),(269,'Paige Harshbarger','8036194292','6096615531','paigeharshbarger@yahoo.com','439 CASTLEBURY CT',NULL,'C','SC','29710'),(270,'Amy Lee','8039813276',NULL,'amylee.wd@gmail.com','521 Brown Oates Rd',NULL,'YORK','SC','29745'),(271,'Peter Martinez','7043159544','7043159544','pete.martinez@woodpartners.com','1251 Birchwood Dr',NULL,'Clover ','SC','29710'),(272,'Jessica Martinez','8038187852','8038187852','jess.mart84@yahoo.com','1251 Birchwood Dr',NULL,'Clover','SC','29710'),(273,'James Tinker','8034484976',NULL,'stephaniescouts@gmail.com','735 South Cherry Road',NULL,'Rock Hill','SC','29732'),(274,'Kelly Williamson','8033666908','8033716058','kwilliamson@att.net','3511 McFarland Road',NULL,'York','SC','29745'),(275,'Nicholas Weller','7045608533','7045608533','nicholas.weller81@gmail.com','1920 Paces Landing Ave','1911','Rock Hill','SC','29732'),(276,'Brenda Stallworth','7042777109',NULL,'Pebblesebx@aol.com','141 edenvale rd',NULL,'Rock hill','SC','29730'),(277,'Brenda Stallworth','7042777109',NULL,'Pebblesebx@aim.com','141 edenvale rd ',NULL,'Rock Hill ','SC','29730');
/*!40000 ALTER TABLE `contactinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `dbveventcounts`
--

DROP TABLE IF EXISTS `dbveventcounts`;
/*!50001 DROP VIEW IF EXISTS `dbveventcounts`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `dbveventcounts` AS SELECT 
 1 AS `EventId`,
 1 AS `EventName`,
 1 AS `VolunteerCount`,
 1 AS `ReservationCount`,
 1 AS `RegistrationCount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dbveventcountsbyunit`
--

DROP TABLE IF EXISTS `dbveventcountsbyunit`;
/*!50001 DROP VIEW IF EXISTS `dbveventcountsbyunit`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `dbveventcountsbyunit` AS SELECT 
 1 AS `EventId`,
 1 AS `VolCount`,
 1 AS `RegCount`,
 1 AS `ResCount`,
 1 AS `UnitID`,
 1 AS `UnitType`,
 1 AS `UnitNumber`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dbveventdashboardtrend`
--

DROP TABLE IF EXISTS `dbveventdashboardtrend`;
/*!50001 DROP VIEW IF EXISTS `dbveventdashboardtrend`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `dbveventdashboardtrend` AS SELECT 
 1 AS `events_EventID`,
 1 AS `VolCount`,
 1 AS `RegCount`,
 1 AS `ResCount`,
 1 AS `LastUpdated`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dbveventvolunteerdetails`
--

DROP TABLE IF EXISTS `dbveventvolunteerdetails`;
/*!50001 DROP VIEW IF EXISTS `dbveventvolunteerdetails`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `dbveventvolunteerdetails` AS SELECT 
 1 AS `ID`,
 1 AS `FirstName`,
 1 AS `MiddleName`,
 1 AS `LastName`,
 1 AS `PersonType`,
 1 AS `BirthDate`,
 1 AS `UnitType`,
 1 AS `UnitNumber`,
 1 AS `Email`,
 1 AS `HomePhone`,
 1 AS `CellPhone`,
 1 AS `Address1`,
 1 AS `Address2`,
 1 AS `City`,
 1 AS `State`,
 1 AS `Zip`,
 1 AS `volunteerDays`,
 1 AS `MondayVol`,
 1 AS `TuesdayVol`,
 1 AS `WednesdayVol`,
 1 AS `ThursdayVol`,
 1 AS `FridayVol`,
 1 AS `SaturdayVol`,
 1 AS `SundayVol`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dbveventvolunteertrend`
--

DROP TABLE IF EXISTS `dbveventvolunteertrend`;
/*!50001 DROP VIEW IF EXISTS `dbveventvolunteertrend`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `dbveventvolunteertrend` AS SELECT 
 1 AS `events_EventID`,
 1 AS `DailyCount`,
 1 AS `LastUpdated`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dbvregistrationdetails`
--

DROP TABLE IF EXISTS `dbvregistrationdetails`;
/*!50001 DROP VIEW IF EXISTS `dbvregistrationdetails`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `dbvregistrationdetails` AS SELECT 
 1 AS `RegistrationID`,
 1 AS `RegistrationDate`,
 1 AS `Confirmation`,
 1 AS `Events_EventID`,
 1 AS `FirstName`,
 1 AS `MiddleName`,
 1 AS `LastName`,
 1 AS `BirthDate`,
 1 AS `UnitRank`,
 1 AS `UnitType`,
 1 AS `UnitNumber`,
 1 AS `Notes`,
 1 AS `Email`,
 1 AS `HomePhone`,
 1 AS `CellPhone`,
 1 AS `ParentName`,
 1 AS `Address1`,
 1 AS `Address2`,
 1 AS `City`,
 1 AS `State`,
 1 AS `Zip`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dbvregistrationtrend`
--

DROP TABLE IF EXISTS `dbvregistrationtrend`;
/*!50001 DROP VIEW IF EXISTS `dbvregistrationtrend`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `dbvregistrationtrend` AS SELECT 
 1 AS `events_EventID`,
 1 AS `DailyCount`,
 1 AS `LastUpdated`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dbvreservationdetails`
--

DROP TABLE IF EXISTS `dbvreservationdetails`;
/*!50001 DROP VIEW IF EXISTS `dbvreservationdetails`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `dbvreservationdetails` AS SELECT 
 1 AS `ReservationID`,
 1 AS `ReservationDate`,
 1 AS `RegistrationCode`,
 1 AS `Events_EventID`,
 1 AS `FirstName`,
 1 AS `MiddleName`,
 1 AS `LastName`,
 1 AS `BirthDate`,
 1 AS `UnitRank`,
 1 AS `UnitType`,
 1 AS `UnitNumber`,
 1 AS `Notes`,
 1 AS `Email`,
 1 AS `HomePhone`,
 1 AS `CellPhone`,
 1 AS `ParentName`,
 1 AS `Address1`,
 1 AS `Address2`,
 1 AS `City`,
 1 AS `State`,
 1 AS `Zip`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `dbvreservationtrend`
--

DROP TABLE IF EXISTS `dbvreservationtrend`;
/*!50001 DROP VIEW IF EXISTS `dbvreservationtrend`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `dbvreservationtrend` AS SELECT 
 1 AS `events_EventID`,
 1 AS `DailyCount`,
 1 AS `LastUpdated`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `event_reg_trends`
--

DROP TABLE IF EXISTS `event_reg_trends`;
/*!50001 DROP VIEW IF EXISTS `event_reg_trends`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `event_reg_trends` AS SELECT 
 1 AS `events_EventID`,
 1 AS `VolunteerCount`,
 1 AS `RegistrantCount`,
 1 AS `ReservationCount`,
 1 AS `LastUpdated`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `event_unit_counts_vw`
--

DROP TABLE IF EXISTS `event_unit_counts_vw`;
/*!50001 DROP VIEW IF EXISTS `event_unit_counts_vw`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `event_unit_counts_vw` AS SELECT 
 1 AS `EventId`,
 1 AS `Volunteers`,
 1 AS `Registrations`,
 1 AS `Reservations`,
 1 AS `units_UnitID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `event_unit_registration_count_vw`
--

DROP TABLE IF EXISTS `event_unit_registration_count_vw`;
/*!50001 DROP VIEW IF EXISTS `event_unit_registration_count_vw`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `event_unit_registration_count_vw` AS SELECT 
 1 AS `EventId`,
 1 AS `Registrations`,
 1 AS `units_UnitID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `event_unit_reservation_count_vw`
--

DROP TABLE IF EXISTS `event_unit_reservation_count_vw`;
/*!50001 DROP VIEW IF EXISTS `event_unit_reservation_count_vw`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `event_unit_reservation_count_vw` AS SELECT 
 1 AS `EventId`,
 1 AS `Reservations`,
 1 AS `units_UnitID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `event_unit_volunteer_count_vw`
--

DROP TABLE IF EXISTS `event_unit_volunteer_count_vw`;
/*!50001 DROP VIEW IF EXISTS `event_unit_volunteer_count_vw`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `event_unit_volunteer_count_vw` AS SELECT 
 1 AS `EventId`,
 1 AS `Volunteers`,
 1 AS `units_UnitID`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `EventID` int(11) NOT NULL AUTO_INCREMENT,
  `VenueID` int(11) NOT NULL,
  `EventName` varchar(100) NOT NULL,
  `EventStart` datetime NOT NULL,
  `EventEnd` datetime NOT NULL,
  `EventDescription` varchar(2000) DEFAULT NULL,
  `LastUpdate` datetime DEFAULT NULL,
  `EventTypes_EventTypeID` int(11) NOT NULL,
  `StaffPaymentRequired` bit(1) DEFAULT NULL,
  `RegistrationDeadline` datetime NOT NULL,
  `RequiredStaff` int(11) NOT NULL,
  `RequiredVolunteers` int(11) NOT NULL,
  PRIMARY KEY (`EventID`,`EventTypes_EventTypeID`),
  UNIQUE KEY `EventID_UNIQUE` (`EventID`),
  KEY `fk_Events_EventTypes_idx` (`EventTypes_EventTypeID`),
  CONSTRAINT `fk_Events_EventTypes` FOREIGN KEY (`EventTypes_EventTypeID`) REFERENCES `eventtypes` (`EventTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,1,'York Day Camp','2018-06-18 08:00:00','2018-06-22 16:00:00','Cub Scout Day Camp for York District','2018-01-31 00:00:00',1,NULL,'2018-05-18 00:00:00',10,30);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventstaff`
--

DROP TABLE IF EXISTS `eventstaff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventstaff` (
  `EventStaffID` int(11) NOT NULL AUTO_INCREMENT,
  `LastUpdated` datetime NOT NULL,
  `positions_PositionID` int(11) NOT NULL,
  `events_EventID` int(11) NOT NULL,
  `person_PersonID` int(11) NOT NULL,
  PRIMARY KEY (`EventStaffID`,`positions_PositionID`,`events_EventID`,`person_PersonID`),
  KEY `fk_eventstaff_positions1_idx` (`positions_PositionID`),
  KEY `fk_eventstaff_events1_idx` (`events_EventID`),
  KEY `fk_eventstaff_person1_idx` (`person_PersonID`),
  CONSTRAINT `fk_eventstaff_events1` FOREIGN KEY (`events_EventID`) REFERENCES `events` (`EventID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventstaff_person1` FOREIGN KEY (`person_PersonID`) REFERENCES `person` (`PersonID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventstaff_positions1` FOREIGN KEY (`positions_PositionID`) REFERENCES `positions` (`PositionID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventstaff`
--

LOCK TABLES `eventstaff` WRITE;
/*!40000 ALTER TABLE `eventstaff` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventstaff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventtypes`
--

DROP TABLE IF EXISTS `eventtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventtypes` (
  `EventTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `EventType` varchar(45) NOT NULL,
  PRIMARY KEY (`EventTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventtypes`
--

LOCK TABLES `eventtypes` WRITE;
/*!40000 ALTER TABLE `eventtypes` DISABLE KEYS */;
INSERT INTO `eventtypes` VALUES (1,'Day Camp');
/*!40000 ALTER TABLE `eventtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventvolunteers`
--

DROP TABLE IF EXISTS `eventvolunteers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventvolunteers` (
  `EventVolunteerID` int(11) NOT NULL AUTO_INCREMENT,
  `LastUpdated` datetime NOT NULL,
  `events_EventID` int(11) NOT NULL,
  `person_PersonID` int(11) NOT NULL,
  `volunteerDays` int(11) NOT NULL DEFAULT '0',
  `MondayVol` varchar(1) DEFAULT NULL,
  `TuesdayVol` varchar(1) DEFAULT NULL,
  `WednesdayVol` varchar(1) DEFAULT NULL,
  `ThursdayVol` varchar(1) DEFAULT NULL,
  `FridayVol` varchar(1) DEFAULT NULL,
  `SaturdayVol` varchar(1) DEFAULT NULL,
  `SundayVol` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`EventVolunteerID`,`events_EventID`,`person_PersonID`),
  KEY `fk_eventvolunteers_events1_idx` (`events_EventID`),
  KEY `fk_eventvolunteers_person1_idx` (`person_PersonID`),
  CONSTRAINT `fk_eventvolunteers_events1` FOREIGN KEY (`events_EventID`) REFERENCES `events` (`EventID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventvolunteers_person1` FOREIGN KEY (`person_PersonID`) REFERENCES `person` (`PersonID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventvolunteers`
--

LOCK TABLES `eventvolunteers` WRITE;
/*!40000 ALTER TABLE `eventvolunteers` DISABLE KEYS */;
INSERT INTO `eventvolunteers` VALUES (167,'2018-02-06 10:25:58',1,78,5,'Y','Y','Y','Y','Y','N','N'),(168,'2018-02-06 14:48:15',1,103,5,'Y','Y','Y','Y','Y','N','N'),(169,'2018-02-09 18:49:43',1,366,5,'Y','Y','Y','Y','Y','N','N'),(170,'2018-02-12 08:19:37',1,259,5,'Y','Y','Y','Y','Y','N','N'),(171,'2018-02-12 08:21:53',1,261,5,'Y','Y','Y','Y','Y','N','N'),(172,'2018-02-20 14:56:31',1,243,5,'Y','Y','Y','Y','Y','N','N'),(173,'2018-02-24 10:40:13',1,131,5,'Y','Y','Y','Y','Y','N','N'),(174,'2018-02-28 18:46:48',1,375,5,'Y','Y','Y','Y','Y','N','N'),(175,'2018-03-01 07:57:07',1,378,5,'Y','Y','Y','Y','Y','N','N'),(176,'2018-03-06 09:31:54',1,383,5,'Y','Y','Y','Y','Y','N','N'),(177,'2018-03-11 23:07:59',1,390,5,'Y','Y','Y','Y','Y','N','N'),(178,'2018-03-20 13:57:17',1,119,5,'Y','Y','Y','Y','Y','N','N'),(179,'2018-03-27 15:05:59',1,399,2,'N','N','N','Y','Y','N','N'),(181,'2018-04-13 15:59:27',1,115,5,'Y','Y','Y','Y','Y','N','N'),(182,'2018-04-13 16:00:47',1,117,5,'Y','Y','Y','Y','Y','N','N'),(183,'2018-04-13 16:01:52',1,357,5,'Y','Y','Y','Y','Y','N','N'),(184,'2018-04-15 13:14:44',1,200,5,'Y','Y','Y','Y','Y','N','N'),(185,'2018-04-15 19:49:25',1,415,5,'Y','Y','Y','Y','Y','N','N'),(186,'2018-04-15 22:31:56',1,416,5,'Y','Y','Y','Y','Y','N','N'),(187,'2018-04-19 06:50:23',1,419,5,'Y','Y','Y','Y','Y','N','N'),(189,'2018-04-19 18:46:32',1,424,1,'N','N','Y','N','N','N','N'),(190,'2018-04-19 20:53:58',1,429,2,'N','Y','N','Y','N','N','N'),(191,'2018-04-19 21:00:40',1,430,1,'N','N','Y','N','N','N','N'),(192,'2018-04-19 21:01:44',1,411,2,'Y','N','N','N','Y','N','N'),(193,'2018-04-20 12:34:59',1,190,2,'N','Y','N','Y','N','N','N'),(194,'2018-04-23 09:12:04',1,165,3,'Y','N','Y','N','Y','N','N'),(195,'2018-04-23 12:38:01',1,401,1,'N','N','N','N','Y','N','N'),(196,'2018-04-23 17:56:58',1,438,5,'Y','Y','Y','Y','Y','N','N'),(197,'2018-04-24 08:08:50',1,273,5,'Y','Y','Y','Y','Y','N','N'),(198,'2018-04-24 11:09:11',1,205,5,'Y','Y','Y','Y','Y','N','N'),(199,'2018-04-24 11:36:49',1,308,5,'Y','Y','Y','Y','Y','N','N'),(200,'2018-04-27 21:40:09',1,405,5,'Y','Y','Y','Y','Y','N','N'),(201,'2018-04-30 21:06:34',1,458,5,'Y','Y','Y','Y','Y','N','N'),(202,'2018-05-01 10:14:36',1,340,5,'Y','Y','Y','Y','Y','N','N'),(203,'2018-05-01 10:49:09',1,188,5,'Y','Y','Y','Y','Y','N','N'),(204,'2018-05-02 09:40:34',1,467,1,'Y','N','N','N','N','N','N'),(205,'2018-05-02 16:04:22',1,118,5,'Y','Y','Y','Y','Y','N','N'),(206,'2018-05-02 19:03:34',1,471,2,'N','N','Y','Y','N','N','N'),(207,'2018-05-02 19:12:25',1,474,5,'Y','Y','Y','Y','Y','N','N'),(208,'2018-05-02 19:21:23',1,476,2,'Y','Y','N','N','N','N','N'),(209,'2018-05-02 19:41:29',1,479,2,'Y','Y','N','N','N','N','N'),(210,'2018-05-02 19:51:10',1,481,5,'Y','Y','Y','Y','Y','N','N'),(211,'2018-05-02 20:54:31',1,483,5,'Y','Y','Y','Y','Y','N','N'),(212,'2018-05-04 08:54:07',1,487,5,'Y','Y','Y','Y','Y','N','N'),(213,'2018-05-06 15:14:50',1,496,2,'N','Y','N','Y','N','N','N'),(214,'2018-05-07 11:08:40',1,501,5,'Y','Y','Y','Y','Y','N','N'),(215,'2018-05-08 22:42:14',1,234,5,'Y','Y','Y','Y','Y','N','N'),(216,'2018-05-09 10:40:55',1,506,3,'Y','Y','Y','N','N','N','N'),(217,'2018-05-09 10:46:41',1,508,5,'Y','Y','Y','Y','Y','N','N'),(218,'2018-05-09 13:10:29',1,397,5,'Y','Y','Y','Y','Y','N','N'),(219,'2018-05-09 14:47:13',1,510,2,'Y','Y','N','N','N','N','N'),(220,'2018-05-10 21:53:46',1,519,2,'N','Y','N','N','Y','N','N');
/*!40000 ALTER TABLE `eventvolunteers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventvolunteers_2017`
--

DROP TABLE IF EXISTS `eventvolunteers_2017`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventvolunteers_2017` (
  `EventVolunteerID` int(11) NOT NULL AUTO_INCREMENT,
  `LastUpdated` datetime NOT NULL,
  `events_EventID` int(11) NOT NULL,
  `person_PersonID` int(11) NOT NULL,
  `volunteerDays` int(11) NOT NULL DEFAULT '0',
  `MondayVol` varchar(1) DEFAULT NULL,
  `TuesdayVol` varchar(1) DEFAULT NULL,
  `WednesdayVol` varchar(1) DEFAULT NULL,
  `ThursdayVol` varchar(1) DEFAULT NULL,
  `FridayVol` varchar(1) DEFAULT NULL,
  `SaturdayVol` varchar(1) DEFAULT NULL,
  `SundayVol` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`EventVolunteerID`,`events_EventID`,`person_PersonID`),
  KEY `fk_eventvolunteers2017_events1_idx` (`events_EventID`),
  KEY `fk_eventvolunteers2017_person1_idx` (`person_PersonID`),
  CONSTRAINT `fk_eventvolunteers2017_events1` FOREIGN KEY (`events_EventID`) REFERENCES `events` (`EventID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventvolunteers2017_person1` FOREIGN KEY (`person_PersonID`) REFERENCES `person` (`PersonID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventvolunteers_2017`
--

LOCK TABLES `eventvolunteers_2017` WRITE;
/*!40000 ALTER TABLE `eventvolunteers_2017` DISABLE KEYS */;
INSERT INTO `eventvolunteers_2017` VALUES (79,'2017-02-27 08:40:09',1,78,5,'Y','Y','Y','Y','Y','N','N'),(80,'2017-02-27 08:51:48',1,100,5,'Y','Y','Y','Y','Y','N','N'),(81,'2017-03-13 23:35:25',1,103,5,'Y','Y','Y','Y','Y','N','N'),(82,'2017-03-16 14:16:33',1,112,5,'Y','Y','Y','Y','Y','N','N'),(83,'2017-03-16 15:35:44',1,111,5,'Y','Y','Y','Y','Y','N','N'),(84,'2017-03-16 15:43:55',1,113,5,'Y','Y','Y','Y','Y','N','N'),(85,'2017-03-20 17:56:17',1,115,5,'Y','Y','Y','Y','Y','N','N'),(86,'2017-03-20 20:22:55',1,117,5,'Y','Y','Y','Y','Y','N','N'),(90,'2017-03-28 20:40:16',1,126,5,'Y','Y','Y','Y','Y','N','N'),(91,'2017-03-28 20:51:49',1,128,5,'Y','Y','Y','Y','Y','N','N'),(92,'2017-03-31 14:12:27',1,125,5,'Y','Y','Y','Y','Y','N','N'),(93,'2017-04-03 20:27:37',1,131,5,'Y','Y','Y','Y','Y','N','N'),(94,'2017-04-04 17:05:00',1,135,5,'Y','Y','Y','Y','Y','N','N'),(95,'2017-04-04 18:01:33',1,136,5,'Y','Y','Y','Y','Y','N','N'),(96,'2017-04-14 08:42:46',1,145,5,'Y','Y','Y','Y','Y','N','N'),(97,'2017-04-14 08:46:16',1,147,5,'Y','Y','Y','Y','Y','N','N'),(98,'2017-04-17 20:15:46',1,157,4,'Y','Y','Y','Y','N','N','N'),(99,'2017-04-17 20:19:12',1,158,5,'Y','Y','Y','Y','Y','N','N'),(100,'2017-04-18 11:37:11',1,159,5,'Y','Y','Y','Y','Y','N','N'),(101,'2017-04-20 08:02:58',1,171,5,'Y','Y','Y','Y','Y','N','N'),(102,'2017-04-20 08:05:05',1,172,5,'Y','Y','Y','Y','Y','N','N'),(103,'2017-04-20 09:05:11',1,173,5,'Y','Y','Y','Y','Y','N','N'),(104,'2017-04-20 13:38:59',1,176,5,'Y','Y','Y','Y','Y','N','N'),(105,'2017-04-20 13:43:39',1,177,5,'Y','Y','Y','Y','Y','N','N'),(106,'2017-04-20 14:24:38',1,114,4,'Y','N','Y','Y','Y','N','N'),(107,'2017-04-20 21:44:04',1,165,3,'Y','N','N','Y','Y','N','N'),(108,'2017-04-21 12:54:13',1,180,5,'Y','Y','Y','Y','Y','N','N'),(109,'2017-04-21 12:57:58',1,181,5,'Y','Y','Y','Y','Y','N','N'),(110,'2017-04-23 18:56:21',1,186,5,'Y','Y','Y','Y','Y','N','N'),(111,'2017-04-23 19:44:54',1,189,5,'Y','Y','Y','Y','Y','N','N'),(112,'2017-04-24 08:41:33',1,190,2,'N','Y','Y','N','N','N','N'),(113,'2017-04-25 15:28:43',1,188,5,'Y','Y','Y','Y','Y','N','N'),(114,'2017-04-25 22:07:06',1,199,1,'Y','N','N','N','N','N','N'),(115,'2017-04-26 07:05:35',1,200,5,'Y','Y','Y','Y','Y','N','N'),(116,'2017-04-26 10:12:18',1,205,5,'Y','Y','Y','Y','Y','N','N'),(117,'2017-04-27 20:17:15',1,118,5,'Y','Y','Y','Y','Y','N','N'),(118,'2017-04-30 14:02:01',1,222,5,'Y','Y','Y','Y','Y','N','N'),(119,'2017-04-30 14:07:35',1,224,5,'Y','Y','Y','Y','Y','N','N'),(120,'2017-05-01 10:37:31',1,185,5,'Y','Y','Y','Y','Y','N','N'),(121,'2017-05-01 18:06:34',1,229,3,'Y','Y','Y','N','N','N','N'),(122,'2017-05-01 22:11:39',1,234,5,'Y','Y','Y','Y','Y','N','N'),(123,'2017-05-02 09:56:16',1,237,2,'N','Y','N','Y','N','N','N'),(124,'2017-05-02 10:11:44',1,233,5,'Y','Y','Y','Y','Y','N','N'),(126,'2017-05-04 18:53:32',1,258,1,'N','N','N','N','Y','N','N'),(127,'2017-05-05 06:00:46',1,259,5,'Y','Y','Y','Y','Y','N','N'),(128,'2017-05-05 06:26:03',1,261,3,'Y','Y','Y','N','N','N','N'),(129,'2017-05-05 06:44:30',1,262,5,'Y','Y','Y','Y','Y','N','N'),(130,'2017-05-05 11:20:15',1,263,5,'Y','Y','Y','Y','Y','N','N'),(131,'2017-05-05 11:36:50',1,267,5,'Y','Y','Y','Y','Y','N','N'),(132,'2017-05-05 11:48:53',1,268,5,'Y','Y','Y','Y','Y','N','N'),(133,'2017-05-06 19:00:06',1,270,5,'Y','Y','Y','Y','Y','N','N'),(134,'2017-05-06 20:19:27',1,273,5,'Y','Y','Y','Y','Y','N','N'),(135,'2017-05-06 20:24:59',1,275,5,'Y','Y','Y','Y','Y','N','N'),(136,'2017-05-07 01:56:15',1,277,5,'Y','Y','Y','Y','Y','N','N'),(137,'2017-05-07 08:13:21',1,279,2,'Y','Y','N','N','N','N','N'),(138,'2017-05-07 15:58:48',1,76,2,'Y','N','N','N','Y','N','N'),(139,'2017-05-07 22:34:35',1,150,5,'Y','Y','Y','Y','Y','N','N'),(140,'2017-05-08 09:48:48',1,299,5,'Y','Y','Y','Y','Y','N','N'),(141,'2017-05-08 10:53:34',1,302,5,'Y','Y','Y','Y','Y','N','N'),(143,'2017-05-08 16:01:36',1,308,5,'Y','Y','Y','Y','Y','N','N'),(144,'2017-05-08 16:58:40',1,311,1,'N','N','Y','N','N','N','N'),(145,'2017-05-08 17:20:18',1,315,5,'Y','Y','Y','Y','Y','N','N'),(146,'2017-05-08 19:38:12',1,243,5,'Y','Y','Y','Y','Y','N','N'),(147,'2017-05-08 19:39:09',1,284,5,'Y','Y','Y','Y','Y','N','N'),(148,'2017-05-08 19:42:12',1,256,2,'N','Y','N','Y','N','N','N'),(149,'2017-05-08 20:03:37',1,320,5,'Y','Y','Y','Y','Y','N','N'),(150,'2017-05-08 20:37:08',1,129,2,'Y','Y','N','N','N','N','N'),(151,'2017-05-08 20:43:49',1,322,2,'N','N','N','Y','Y','N','N'),(152,'2017-05-08 22:31:15',1,141,5,'Y','Y','Y','Y','Y','N','N'),(153,'2017-05-09 12:05:08',1,213,2,'Y','N','Y','N','N','N','N'),(154,'2017-05-09 14:13:30',1,163,1,'N','N','N','N','Y','N','N'),(155,'2017-05-09 23:21:54',1,331,2,'Y','Y','N','N','N','N','N'),(156,'2017-05-13 15:08:22',1,336,5,'Y','Y','Y','Y','Y','N','N'),(157,'2017-05-15 17:18:03',1,340,5,'Y','Y','Y','Y','Y','N','N'),(158,'2017-05-15 20:26:55',1,345,5,'Y','Y','Y','Y','Y','N','N'),(159,'2017-05-16 11:57:39',1,350,5,'Y','Y','Y','Y','Y','N','N'),(160,'2017-05-17 14:40:04',1,352,5,'Y','Y','Y','Y','Y','N','N'),(161,'2017-05-19 20:34:09',1,119,5,'Y','Y','Y','Y','Y','N','N'),(162,'2017-05-24 12:37:43',1,358,5,'Y','Y','Y','Y','Y','N','N'),(163,'2017-05-24 12:40:03',1,359,5,'Y','Y','Y','Y','Y','N','N'),(164,'2017-05-24 12:40:49',1,360,5,'Y','Y','Y','Y','Y','N','N'),(165,'2017-06-01 10:57:13',1,363,5,'Y','Y','Y','Y','Y','N','N'),(166,'2017-06-09 13:11:35',1,364,3,'N','Y','Y','Y','N','N','N');
/*!40000 ALTER TABLE `eventvolunteers_2017` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `PersonID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) NOT NULL,
  `MiddleName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `LastUpdate` datetime DEFAULT NULL,
  `contactInfo_ContactInfoID` int(11) NOT NULL,
  `ParentPersonID` int(11) DEFAULT NULL,
  `persontype_PersonTypeID` int(11) NOT NULL,
  `unitranks_UnitRankID` int(11) NOT NULL,
  `units_UnitID` int(11) NOT NULL,
  `user_id` varchar(45) DEFAULT NULL,
  `Notes` varchar(4000) DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  PRIMARY KEY (`PersonID`,`contactInfo_ContactInfoID`,`persontype_PersonTypeID`,`unitranks_UnitRankID`,`units_UnitID`),
  KEY `fk_Person_ContactInfo1_idx` (`contactInfo_ContactInfoID`),
  KEY `fk_person_persontype1_idx` (`persontype_PersonTypeID`),
  KEY `fk_person_unitranks1_idx` (`unitranks_UnitRankID`),
  KEY `fk_person_units1_idx` (`units_UnitID`)
) ENGINE=InnoDB AUTO_INCREMENT=524 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (76,'Robert','W','Flowers','2017-04-18 20:03:33',71,NULL,2,-1,55,'1748e932-04f4-449a-b677-25681d63120a',NULL,NULL),(78,'Danny',NULL,'Culver','2017-02-25 13:37:10',72,NULL,2,-1,21,'37efde0c-7727-42c9-af7f-d02fecd7073f',NULL,NULL),(99,'Conner','Brandon','Culver','2017-02-27 08:37:20',72,78,3,6,21,'',NULL,'2008-03-05'),(100,'Jennifer',NULL,'Culver','2017-02-27 08:49:57',74,NULL,2,-1,21,'93ae4117-4290-42f2-8d49-706e58e85eed',NULL,NULL),(101,'Deana',NULL,'Williams','2017-03-12 15:33:46',75,NULL,3,-1,29,'85ebbc73-ce79-409e-beeb-039d72d92234',NULL,NULL),(102,'Christopher','Joseph','Williams','2017-03-12 15:41:40',75,101,3,5,29,'','Nuts','2012-01-17'),(103,'Will','G','Flowers','2017-03-13 22:38:46',71,76,4,10,55,'','Allergic to Penicillin','2004-10-04'),(104,'Manda','Stanley','Prettyman','2017-03-14 07:46:39',76,NULL,1,-1,13,'adf31776-af06-41f0-8da7-3259af1b3625',NULL,NULL),(105,'Manda','S','Prettyman','2017-03-15 14:11:09',77,NULL,1,-1,13,'dc8d0d50-0b0b-436d-b1c8-39ead1ad56fe',NULL,NULL),(106,'Zachary','Phillip','Prettyman','2017-03-15 14:13:42',77,105,3,4,13,'',NULL,'2008-10-03'),(107,'Joseph','Clay','Prettyman','2017-03-15 14:14:35',77,105,4,11,36,'',NULL,'2003-08-02'),(108,'Samantha',NULL,'Dill','2017-03-15 18:59:07',78,NULL,1,-1,21,'dfed82f7-1f3c-4b61-b207-78b34370a283',NULL,NULL),(109,'Tara',NULL,'Burgess','2017-03-15 19:04:17',79,NULL,1,-1,6,'b8842823-0da8-4a88-bdce-25c155d0f951',NULL,NULL),(110,'Mason','James','Burgess','2017-03-15 19:06:16',79,109,3,7,6,'',NULL,'2007-03-13'),(111,'Robert',NULL,'Gasperson','2017-03-15 22:06:34',80,NULL,2,-1,6,'3748f54e-1cc5-45f4-a7d5-b1cb77028f00',NULL,NULL),(112,'Lauren','E','Flowers','2017-03-16 14:16:20',71,76,6,17,55,'',NULL,'2001-12-25'),(113,'Alyssa',NULL,'Gasperson','2017-03-16 15:43:35',80,111,6,16,6,'','Nuts/Peanuts','2007-04-02'),(114,'Sonia',NULL,'Colon','2017-03-18 15:49:06',81,NULL,1,-1,1,'224ca510-c670-4540-9ebb-fe4dade6c0d3',NULL,NULL),(115,'constance',NULL,'booth','2018-04-13 16:11:07',82,NULL,1,-1,11,'fa4a17cb-924b-4f92-b1e9-a447c1b4ec64','none','1983-03-10'),(116,'jacob',NULL,'langley','2017-03-20 20:20:48',82,115,3,3,11,'','none','2010-03-25'),(117,'brandon',NULL,'langley','2017-03-20 20:21:48',82,115,4,7,45,'','seasonal','2005-05-18'),(118,'Rick','E','Mitchell','2017-03-21 14:04:34',83,NULL,2,-1,6,'7b7423a9-c4a1-4ebd-9f7d-6d5a6759b454','raw carrot potato onion','1953-10-03'),(119,'Matthew','A','Culver','2017-03-22 20:53:28',72,78,2,13,55,'',NULL,'1998-06-09'),(120,'Wilfredo','M','Houston Colon','2017-03-23 05:19:05',81,114,3,6,1,'',NULL,'2007-03-29'),(121,'Thressa','McMains ','Elam','2017-03-23 12:00:35',84,NULL,1,-1,6,'1e381f3b-61f7-4957-a1e6-b4ec8f72437e',NULL,NULL),(122,'William','Elijah ','Elam','2017-03-23 12:08:39',84,121,3,6,6,'',NULL,'2007-12-19'),(123,'Nicole','Leigh','Flippin','2017-03-25 15:11:50',85,NULL,3,-1,30,'045ffd11-26f8-48f4-ac6e-42aebc4f5d9b',NULL,NULL),(125,'Stephen','Nicholas','Burkell','2017-03-27 12:12:22',86,NULL,2,-1,21,'ba6b053a-72c6-423d-b5ec-9ec885a27d60',NULL,NULL),(126,'Jane','M','Sageser','2017-03-27 20:08:44',87,NULL,1,-1,11,'beb6666a-30ee-41ae-aaa6-5c487c8f04c8',NULL,NULL),(127,'Evan','Bennett','Sageser','2017-03-28 20:46:44',87,126,3,7,11,'',NULL,'2007-04-28'),(128,'Nathan','Riley','Sageser','2017-03-28 20:51:29',87,126,4,11,45,'','Bee/Wasp Stings','2004-01-27'),(129,'roy','hayes','boyd','2017-03-30 06:04:05',88,NULL,2,-1,40,'0f4f225c-e241-481d-bc1b-634c44ee10d2',NULL,NULL),(130,'Xavier','Thomas','Powell','2017-03-31 14:17:52',86,125,3,5,21,'',NULL,'2008-12-01'),(131,'Katherine','Rose','Hylton','2017-04-03 20:25:19',89,NULL,2,-1,11,'29a56afd-3b27-4ee4-8b8d-f0a1db19b1dd',NULL,NULL),(132,'Ellis','Edward','Hylton','2017-04-03 20:36:58',89,131,3,6,11,'','Peanuts, pecans, tree nuts','2008-07-04'),(134,'Daniel',NULL,'Collins','2017-04-04 14:59:38',91,118,3,7,6,'e6a43d37-3483-486e-91de-e5a1907a0bb0',NULL,'2006-09-29'),(135,'Eric ','D','JACOBS','2017-04-04 16:58:50',92,NULL,2,-1,45,'9effa591-c078-4828-b290-914d456c2943',NULL,NULL),(136,'George','F','Jacobs ','2017-04-04 18:01:10',92,135,4,7,45,'','Non','2005-09-20'),(137,'Robert','W.','Flowers','2017-04-04 19:54:58',93,NULL,2,-1,55,'56543503-4fa5-4f00-899e-9c48ec0802ac',NULL,NULL),(138,'Christopher','Sebastion','Schweninger','2017-04-05 16:35:11',94,NULL,4,-1,55,'d39a1a6d-4a9a-4df2-89d9-e7760a0b4105',NULL,NULL),(139,'Melissa','Rooney','Daniels','2017-04-07 21:22:20',95,NULL,1,-1,13,'8454a5cb-eb52-46fe-b939-23594990a158',NULL,NULL),(140,'Nolan','Charles','Daniels','2017-04-07 21:24:15',95,139,3,5,13,'','none','2008-12-08'),(141,'Jeancarlo',NULL,'Cayo','2017-04-13 17:04:42',96,NULL,4,-1,45,'fad12849-4667-46ed-b8b1-e8372345b8ae',NULL,NULL),(142,'Ellen',NULL,'Taylor','2017-04-13 17:09:16',97,NULL,2,-1,5,'4b78caa6-943d-4a57-a6ad-930b9fec9e08',NULL,NULL),(143,'Stacy',NULL,'Gumphrey','2017-04-13 21:39:06',98,NULL,1,-1,18,'70d6accd-e02b-4d4c-a588-05bca3da7ce7',NULL,NULL),(144,'Colson','Lawrence ','Gumphrey','2017-04-13 21:42:57',98,143,3,7,18,'','Peanuts, tree nuts, shellfish ','2007-02-23'),(145,'Ellen',NULL,'Taylor','2017-04-14 08:37:35',99,NULL,2,-1,5,'57fb10d2-de8e-4e35-b4b8-5034427f0433',NULL,NULL),(146,'Eli',NULL,'Taylor','2017-04-14 08:40:39',99,145,3,4,5,'','none','2010-03-18'),(147,'Max',NULL,'Taylor','2017-04-14 08:41:24',99,145,4,7,39,'','none','2006-02-14'),(148,'Cathy',NULL,'Whisonant','2017-04-16 15:57:17',100,NULL,1,-1,28,'f7580f59-4b50-42d5-a8ec-d1867ab515f9',NULL,NULL),(149,'Eben','J','Whisonant','2017-04-16 15:59:35',100,148,3,6,28,'','Wasp','2008-05-07'),(150,'Robert','Lanier','Willis','2017-04-17 11:07:07',101,NULL,2,-1,18,'b70dfb96-8a33-4fa2-bf77-a7633eb971c1',NULL,NULL),(151,'Robbye','S','Helms','2017-04-17 12:45:57',102,NULL,1,-1,6,'35ac786d-c1c4-4fc8-98e7-20d7321aa8bd',NULL,NULL),(152,'Robert','W.','Flowers','2017-04-17 15:01:43',103,NULL,-1,-1,-1,'691a0468-3e44-42f7-8181-f51bd92604a4',NULL,NULL),(153,'DTEst',NULL,'TEstCUlver','2017-04-17 15:06:01',104,NULL,2,-1,21,'6aed5c05-b2cb-40e2-a26d-dbdf184ad864',NULL,NULL),(154,'Amy',NULL,'Flowers','2017-04-17 15:09:42',105,NULL,-1,-1,-1,'f65ea58e-b319-43ff-9d12-41c766e2e68b',NULL,NULL),(155,'Matthew','Everett','Willis','2017-04-17 16:08:26',101,150,3,5,18,'','Severe Anaphylactic allergy to peanuts.  Allergic to all other nuts.  Must have EpiPens with him at all times.  I\'ll be with him as his den leader.','2008-12-02'),(156,'Mark','Shannon ','Prescott','2017-04-17 20:08:56',106,NULL,2,-1,55,'1eb3070f-1c1f-4021-8930-c31c9877f612',NULL,NULL),(157,'Nicolas','Joseph','Prescott','2017-04-17 20:13:18',106,156,4,8,55,'','Milk','2012-04-17'),(158,'Jessie','Warren ','Prescott','2017-04-17 20:15:00',106,156,4,7,55,'','None','2005-07-01'),(159,'Jacquelina','Rose','Cox','2017-04-18 11:00:12',107,NULL,1,-1,13,'21ea514e-e7bc-423e-ac77-95e1dba4f6b8',NULL,NULL),(160,'Elias','Samuel','Cox','2017-04-18 11:01:41',107,159,3,5,13,'','Autism Spectrum, ADHD ','2008-08-20'),(161,'darrell','eugene','mcdaniel','2017-04-18 12:23:33',108,NULL,3,-1,6,'c843814f-0f1c-432f-8abb-9c201ba9d388',NULL,NULL),(162,'jason','darrell','mcdaniel','2017-04-18 12:30:42',108,161,3,6,6,'','none','2008-03-28'),(163,'Amy','Brown','McCorkle','2017-05-09 14:13:12',109,NULL,1,-1,30,'07085b0f-75aa-4f8f-811b-42d6bbb20d75',NULL,NULL),(164,'William','Brown','McCorkle','2017-04-18 16:39:30',109,163,3,5,30,'',NULL,'2009-08-05'),(165,'Brian',NULL,'Cope','2017-04-18 20:48:32',110,NULL,1,-1,28,'b1e1fb41-6598-496d-a1db-148b75527d3a',NULL,NULL),(166,'Scott',NULL,'Cope','2017-04-18 20:50:15',110,165,3,6,28,'',NULL,'2012-05-30'),(167,'cindy',NULL,'rebman','2017-04-19 09:32:16',111,NULL,1,-1,14,'65e78625-6f04-4580-b490-8f30a30aba2a',NULL,NULL),(168,'Alex',NULL,'Rebman','2017-04-19 09:34:09',111,167,3,7,14,'',NULL,'2007-08-28'),(169,'Chase',NULL,'Rebman','2017-04-19 09:35:18',111,167,3,5,14,'',NULL,'2009-06-24'),(170,'Thomas','McGuire','Thomas','2017-04-19 13:37:25',112,NULL,-1,-1,-1,'b242b792-2091-4a8f-99da-9f8cb018f895',NULL,NULL),(171,'Amber','L','Ramsey','2017-04-20 07:59:17',113,NULL,1,-1,55,'e8c8aeb6-b008-4675-908e-1b3c09999558',NULL,NULL),(172,'Nathan',NULL,'Ramsey','2017-04-20 08:04:39',113,171,4,7,55,'',NULL,'2005-03-26'),(173,'Sandi ','Lee','Patrick ','2017-04-24 10:33:12',114,NULL,2,-1,28,'3e58cc4f-6898-4d8c-9731-a84dc89f2f2d','Chocolate','1976-07-27'),(174,'Ryan ','Cooper','Patrick ','2017-04-20 09:18:57',114,173,3,5,28,'',NULL,'2008-09-21'),(175,'Seth ','Michael','Patrick ','2017-04-20 09:20:10',114,173,3,5,28,'','Oxybutin','2008-09-21'),(176,'Donna','Marie','Fletcher','2017-04-20 09:42:13',115,NULL,2,-1,25,'bddce3b0-72a9-4d93-bc54-fca1faa1a0f1',NULL,NULL),(177,'RONALD','W','FLETCHER','2017-04-20 13:43:08',116,NULL,2,-1,25,'00eba7fe-58fd-46d5-8db2-9f69c557e765',NULL,NULL),(178,'Natasha','L','Slack','2017-04-20 16:43:56',117,NULL,1,-1,19,'8db7c6aa-24e4-41fc-8b3d-84ee11abd0ff',NULL,NULL),(179,'Chase','E','Higgins','2017-04-20 16:51:40',118,NULL,3,-1,19,'16a8a528-3a1f-45ca-b4f4-86c6a0b83ff2',NULL,NULL),(180,'Stephanie',NULL,'Tinker','2017-04-21 12:53:30',119,NULL,4,-1,40,'4d605084-1054-4585-b401-361a56ef3a68',NULL,NULL),(181,'James','Logan','Tinker','2017-04-21 12:57:44',119,180,4,9,40,'','None','2005-03-15'),(182,'Joshua','Scott','Helms','2017-04-22 08:18:26',102,151,3,5,6,'','none','2008-11-08'),(183,'Michael ','Price','Feimster','2017-04-22 13:00:36',120,NULL,1,-1,28,'101b293c-e0a4-4e6f-b939-857110ed71bd',NULL,NULL),(184,'Kingston','Price','Feimster','2017-04-22 13:04:01',120,183,3,5,28,'','NA','2009-06-15'),(185,'Jackson','Alexander','Hayes','2017-04-23 18:36:13',121,NULL,4,-1,40,'9870dc6c-e8e6-482e-aae6-c74e8b4b6bbb',NULL,NULL),(186,'Cassie','ODell','Clark','2017-04-23 18:56:01',122,NULL,2,-1,21,'0a093e08-a411-4fc6-8db9-aaab639601e0',NULL,'1983-09-30'),(187,'Calvin','Eugene','Lyle','2017-04-23 18:51:57',122,186,3,6,21,'',NULL,'2008-03-22'),(188,'Heather',NULL,'Culver','2017-04-23 19:41:12',72,78,6,16,21,'',NULL,'2003-07-30'),(189,'Robert ','Brantley','Davies','2017-04-23 19:44:38',122,186,6,16,21,'',NULL,'2003-02-22'),(190,'James','Clifford','Parrish','2017-04-24 08:37:45',123,NULL,1,-1,28,'27312fad-e13a-4f50-bd77-16c703c08f67',NULL,NULL),(191,'Lukas','Riley','Parrish','2017-04-24 08:39:37',123,190,3,6,28,'',NULL,'2012-04-13'),(193,'Cara',NULL,'Rohlfs','2017-04-25 12:44:44',124,NULL,4,-1,11,'1be33843-8af4-4a6f-8e5c-6e9d5614f801',NULL,NULL),(194,'Aidan','Christopher','Rohlfs','2017-04-25 12:45:54',124,193,3,7,11,'',NULL,'2007-07-24'),(195,'Karen',NULL,'Brogdon','2017-04-25 13:38:28',125,NULL,2,-1,6,'af0d61f4-186c-4d25-9cbd-756b31ad6c4a',NULL,NULL),(196,'Brayden','Cole','Brogdon','2017-04-25 13:40:09',125,195,3,5,6,'',NULL,'2008-11-17'),(197,'Cynthia','A','Jackson','2017-04-25 21:42:15',126,NULL,3,-1,54,'a68de879-40c7-4869-8a67-91509ce726a5',NULL,NULL),(198,'Matthew','B','Jackson','2017-04-25 21:45:00',126,197,3,6,20,'','None','2007-11-29'),(199,'Glenn','C','Stoner','2017-04-25 22:06:15',127,NULL,-1,-1,-1,'20cbb424-269d-4910-8b06-e870508089e5',NULL,NULL),(200,'Larry','Brian','Caulder','2017-04-26 07:04:38',128,NULL,2,-1,3,'3b7e9783-43ad-4c3d-81b4-fe809a15df10',NULL,NULL),(201,'Larry \"Brian\"','Brian','Caulder','2017-04-26 07:11:18',128,200,3,7,3,'',NULL,'2007-04-15'),(202,'Zachary \"Zac\"','Aaron','Caulder','2017-04-26 07:12:33',128,200,3,5,3,'',NULL,'2009-02-13'),(203,'Wesley','Randall','Caulder','2017-04-26 07:13:57',128,200,3,4,3,'',NULL,'2010-05-28'),(204,'Declan','Samuel','Caulder','2017-04-26 07:15:33',128,200,6,16,3,'',NULL,'2015-06-20'),(205,'Jacob','Anthony','Bendt','2017-04-26 10:11:39',129,NULL,4,-1,34,'1ebf9561-0178-48fb-bb2b-67987d0216a7',NULL,NULL),(206,'Duree',NULL,'Love','2017-04-26 11:21:15',130,NULL,1,-1,29,'e14a5238-4db8-42a0-94f0-b32ea4e5d6c6',NULL,NULL),(207,'Nathaniel','Scott','Woolard','2017-04-26 11:22:28',130,206,3,6,29,'',NULL,'2008-03-05'),(208,'Zachary','David','Woolard','2017-04-26 11:23:09',130,206,3,4,29,'',NULL,'2009-11-16'),(209,'Nathan','Matthew','Green','2017-04-26 19:13:28',131,NULL,3,-1,21,'dac31629-2bf6-42d9-8c28-c38cb98b8e97',NULL,NULL),(210,'Saylor','Spence','Green','2017-04-26 19:16:56',131,209,3,5,21,'',NULL,'2009-03-04'),(211,'Ellen',NULL,'Wilder-Byrd','2017-04-27 13:03:05',132,NULL,3,-1,4,'9006b136-ee19-42a4-a99a-72e281a445f1',NULL,NULL),(212,'Robert','Kaden','McClure','2017-04-27 13:10:31',132,211,3,5,4,'',NULL,'2005-03-09'),(213,'Brenda','Howe','Benton','2017-05-09 12:04:31',133,NULL,1,-1,30,'f03d24db-f39f-4e99-953b-4531e9771f6a',NULL,'1968-08-17'),(214,'Richard','Michael','Benton','2017-04-27 14:11:20',133,213,3,6,30,'','n/a','2006-09-06'),(215,'Brendan','Caleb','Benton','2017-04-27 14:12:18',133,213,3,5,30,'','n/a','2008-05-06'),(216,'Jesse','Ray','McGee','2017-04-27 17:48:13',134,NULL,1,-1,14,'344b2f8f-e154-4d49-a486-6800f54e9752',NULL,NULL),(217,'Joshua','Thomas','Harrell','2017-04-27 17:51:13',134,216,3,5,14,'',NULL,'2009-04-01'),(218,'Sara ','L','Martinez','2017-04-28 10:12:04',135,NULL,3,-1,23,'eb642bfb-ea0f-463b-b5ec-51aa3c011691',NULL,NULL),(219,'Chase','E.','Higgins','2017-04-28 15:09:42',117,178,3,6,19,'',NULL,'2008-02-29'),(220,'meghan',NULL,'wier','2017-04-30 12:20:59',136,NULL,3,-1,14,'54a212ce-ea20-4347-a169-76f72905aba3',NULL,NULL),(221,'Morgan',NULL,'Wier','2017-04-30 12:22:42',136,220,3,5,14,'',NULL,'2012-04-17'),(222,'laura',NULL,'cripe','2017-04-30 13:46:00',137,NULL,2,-1,5,'0517def0-4682-432f-be56-5a132c7a5a13',NULL,NULL),(223,'Thomas','Christopher','Cripe','2017-04-30 13:48:11',137,222,3,4,5,'',NULL,'2010-06-14'),(224,'Samuel','Allen','Cripe','2017-04-30 13:49:09',137,222,4,7,39,'',NULL,'2006-03-07'),(225,'Benjamin','Wesley','Cripe','2017-04-30 13:50:38',137,222,5,14,64,'',NULL,'1998-02-16'),(226,'Samuel',NULL,'Clack','2017-04-30 15:48:15',138,NULL,3,-1,28,'6dd257e5-9f1f-4df9-84be-bf57bb1e9085',NULL,NULL),(227,'Sally',NULL,'Baker','2017-04-30 20:39:19',139,NULL,1,-1,18,'06298a8d-c555-4c2c-8694-1445f9e007e1',NULL,NULL),(228,'Logan',NULL,'Baker','2017-04-30 20:41:46',139,227,3,6,18,'','Several antibiotics: penicillins (including augmentin); macrolides; cephalosporins','2007-09-22'),(229,'Robie',NULL,'Grissom','2017-05-01 17:18:08',140,NULL,1,-1,6,'37d0e4b7-a905-4b3b-9048-3dad4a52e1fc',NULL,NULL),(230,'Andrew','Scott','Blackwood jr','2017-05-01 17:42:46',140,229,3,5,6,'','None','2008-04-27'),(231,'Frankie',NULL,'carns','2017-05-01 20:04:49',141,NULL,1,-1,11,'d632527c-5f7f-4d39-96e7-507748c69daa',NULL,NULL),(232,'Warren ',NULL,'Carns','2017-05-01 20:07:47',141,231,3,6,11,'',NULL,'2008-01-14'),(233,'Will',NULL,'Carns','2017-05-01 20:09:16',141,231,4,10,45,'',NULL,'2003-09-03'),(234,'Patricia','ann','Swoope','2017-05-01 22:03:16',142,NULL,1,-1,18,'26a83b69-9630-403e-9dc7-4a10c39d56bf',NULL,NULL),(235,'Kannon','Rilee','Swoope','2017-05-01 22:06:35',142,234,3,5,18,'',NULL,'2008-11-10'),(236,'Ryan','Sean','Swoope','2017-05-01 22:09:44',142,234,3,7,18,'',NULL,'2012-05-01'),(237,'Kara',NULL,'Hawkins','2017-05-02 09:51:34',143,NULL,1,-1,30,'a2b96ccd-b82c-4159-b2af-f8c83fe0f2ab',NULL,NULL),(238,'R.','Blake','Hawkins','2017-05-02 09:53:28',143,237,3,7,30,'',NULL,'2007-06-29'),(239,'Dylan','Toby','Hawkins','2017-05-02 09:54:25',143,237,3,5,30,'',NULL,'2009-05-27'),(240,'Amy','Hypes','Michalesko','2017-05-02 14:38:24',144,NULL,1,-1,14,'43d1853d-01bb-44a0-871c-044d65cd8aad',NULL,NULL),(242,'Nicholas','David','Michalesko','2017-05-02 14:39:37',144,240,3,5,14,'',NULL,'2008-08-27'),(243,'Allison','Louise','Lenzi','2017-05-02 15:22:29',145,NULL,2,-1,19,'43dba1a7-9cd9-4594-894f-beed545b5ccb',NULL,NULL),(244,'Alessandro','James','Lenzi','2017-05-02 15:24:24',145,243,3,6,19,'',NULL,'2012-03-10'),(245,'Oliver ','James','Lenzi','2017-05-02 15:25:07',145,243,3,6,19,'',NULL,'2012-03-10'),(246,'Owen ','Stefano','Lenzi','2017-05-02 15:25:57',145,243,3,3,19,'',NULL,'2011-02-26'),(247,'Massimo ','Daniel','Lenzi','2017-05-02 15:28:49',145,243,3,3,19,'',NULL,'2011-02-26'),(248,'Randy','Clayton ','Parks ','2017-05-02 17:57:56',146,NULL,1,-1,23,'4e8966ed-5c90-44dc-907c-68ca0a6fa4ed',NULL,NULL),(249,'Clayton ','Micheal','Parks','2017-05-02 18:33:54',146,248,3,5,23,'',NULL,'2008-02-25'),(250,'Delete',NULL,'ME','2017-05-03 10:10:56',147,NULL,1,-1,21,'19a8b3da-19b8-4743-85a4-b7b3c1d45d5e',NULL,NULL),(251,'Delete',NULL,'metoo','2017-05-03 10:33:20',147,250,3,5,21,'',NULL,'2012-05-03'),(252,'Katie','O','James','2017-05-11 20:33:27',148,NULL,3,-1,20,'7bac523d-c4c4-457a-9b8e-8dc780417e84',NULL,'1981-09-23'),(253,'Jana','A','Cathey','2017-05-03 15:11:58',149,NULL,2,-1,29,'65aa4a33-cf54-4e10-831a-a4a5c14321d2',NULL,NULL),(254,'Liam',NULL,'Cathey','2017-05-03 15:11:42',149,253,3,4,29,'',NULL,'2012-09-18'),(255,'Colin',NULL,'Cathey','2017-05-03 15:12:41',149,253,3,3,29,'',NULL,'2011-06-25'),(256,'Amber',NULL,'Paige','2017-05-03 16:42:52',150,NULL,1,-1,19,'b016cf73-eb43-40aa-98c5-f0cdedc39e90',NULL,NULL),(257,'Nathan',NULL,'Paige','2017-05-03 16:47:55',150,256,3,7,19,'',NULL,'2007-07-23'),(258,'steven','charles','schweninger','2017-05-04 18:51:55',151,NULL,4,-1,55,'292325f7-e402-40da-9b95-c0a5114fb08b',NULL,NULL),(259,'Kristy ','Beasley ','Powell ','2017-05-05 06:14:05',152,NULL,2,-1,21,'1b388a36-a3ed-4feb-806c-e18d61981803',NULL,NULL),(260,'Benjamin ','Wilson ','Powell ','2017-05-05 05:59:32',152,259,3,5,21,'','None','2008-10-26'),(261,'Paul','Wilson ','Powell','2017-05-05 06:25:24',153,NULL,2,-1,21,'a9d7bf94-6c4e-4f1c-9cac-a29a8f78dd12',NULL,NULL),(262,'Janice',NULL,'Chadwick ','2017-05-05 06:43:54',154,NULL,1,-1,21,'a3443ba5-b5d6-47b1-831d-799c1ff19117',NULL,NULL),(263,'Nancy',NULL,'Carruth','2017-05-05 11:31:52',155,NULL,2,-1,6,'e640ea8a-c21e-4a7c-9f7d-08c07c0a0458',NULL,NULL),(264,'Niki',NULL,'McBroom','2017-05-05 11:30:09',156,NULL,2,-1,19,'524d95a4-e506-4489-8402-122869902992',NULL,NULL),(265,'Jax',NULL,'Carruth','2017-05-05 11:30:14',155,263,3,5,6,'',NULL,'2009-08-03'),(266,'James','Sebastian','Boyd','2017-05-05 11:32:27',156,264,3,5,19,'',NULL,'2009-04-27'),(267,'Michael',NULL,'Carruth','2017-05-05 11:35:09',157,NULL,2,-1,6,'82c013da-8935-4573-9ecf-3242af4ef143',NULL,NULL),(268,'Cole',NULL,'Carruth','2017-05-05 11:48:29',158,NULL,4,-1,40,'ba690cfe-47be-415f-bf8a-dc266f003c83',NULL,NULL),(269,'Landon',NULL,'Hickson','2017-05-05 11:48:50',156,264,3,6,19,'',NULL,'2008-03-07'),(270,'Christine ','Ann','Chavis ','2017-05-06 18:16:45',159,NULL,1,-1,18,'7d898ec5-46b3-40de-8659-286882b5abf1',NULL,NULL),(271,'Amari','Everett','Chavis','2017-05-06 18:56:35',159,270,3,3,18,'','none','2011-08-21'),(272,'Zane','Alexander','Chavis','2017-05-06 18:57:42',159,270,3,5,18,'','none','2009-02-17'),(273,'Jennifer','M','Waters','2017-05-07 09:24:09',160,NULL,1,-1,23,'6a2fe218-d3d7-498d-9436-23bf743a8046',NULL,NULL),(274,'Evan','Michael','Waters','2017-05-06 20:17:09',160,273,3,6,23,'',NULL,'2007-06-27'),(275,'Cristina','Vincent','Renzoni','2017-05-06 20:24:29',161,NULL,2,-1,11,'0f50f193-b477-4623-9284-f95c1f295729',NULL,NULL),(276,'Nicky',NULL,'Renzoni','2017-05-06 20:28:10',161,275,3,5,11,'','None','2012-08-05'),(277,'Kimberley ','R.','Garrison ','2017-05-07 01:49:01',162,NULL,1,-1,21,'8bf2f8da-f88a-4c37-8fc6-f2f20976809d',NULL,NULL),(278,'Gage','B','Garrison ','2017-05-07 02:00:12',162,277,3,4,21,'','None','2013-04-26'),(279,'Vanessa','R','Fulcher','2017-05-07 08:12:21',163,NULL,1,-1,4,'629fa4f3-c681-4044-9cff-6c2b0f08d2af',NULL,NULL),(280,'Carson','Grant','Fulcher','2017-05-07 08:16:01',163,279,3,4,4,'','Penicillin','2009-10-13'),(281,'Blair',NULL,'Bigger','2017-05-07 19:13:27',164,NULL,2,-1,2,'ddd8df6f-21a1-472e-9de9-becf06141633',NULL,NULL),(282,'Brody',NULL,'Bigger','2017-05-07 19:15:32',164,281,3,5,2,'',NULL,'2009-02-11'),(283,'Ronald','Clinton','Alexander','2017-05-07 22:35:34',165,NULL,1,-1,18,'a7f18707-9f59-4a25-92aa-01bb0d620522',NULL,'1968-11-05'),(284,'Robert','C','Rickey','2017-05-08 19:38:54',166,NULL,1,-1,30,'8fd7dc00-62be-469d-9273-aa279cdcedaf',NULL,'1978-12-22'),(285,'Nathan','J','Rickey','2017-05-07 20:49:05',166,284,3,4,30,'','None','2010-03-19'),(286,'Brayden','H','Rickey','2017-05-07 20:49:48',166,284,3,3,30,'','None','2011-04-15'),(287,'Tim',NULL,'Sabella','2017-05-07 21:17:52',167,NULL,1,-1,15,'94b3e66b-efd9-4b20-a01e-5ceaa0f25e09',NULL,NULL),(288,'Michael',NULL,'Sabella','2017-05-07 21:20:35',167,287,3,7,15,'','None','2007-03-11'),(289,'Timmy',NULL,'Sabella','2017-05-07 21:23:10',167,287,3,4,15,'','None','2010-08-22'),(290,'Mark',NULL,'Klopenstine','2017-05-07 22:24:31',168,NULL,3,-1,18,'3f023c6a-02b6-4994-a9f8-e7208d32fb1b',NULL,NULL),(291,'Caden','Cole','Klopenstine','2017-05-07 22:27:42',168,290,3,5,18,'',NULL,'2007-11-10'),(292,'Graham',NULL,'Alexander','2017-05-07 22:36:31',165,283,3,5,18,'',NULL,'2007-11-10'),(293,'Kike','Holland','Blades','2017-05-08 20:23:16',169,NULL,1,-1,23,'6598cc40-8b32-40e2-98e5-20973dee1aec','peanuts ','1966-06-08'),(294,'Chris',NULL,'Scarborough ','2017-05-08 06:58:04',170,NULL,3,-1,18,'6c232435-c11a-4ee0-8249-f62409a64d4c',NULL,NULL),(295,'Noah',NULL,'Scarborough ','2017-05-08 07:00:15',170,294,3,7,18,'','None','2006-09-10'),(296,'Amy','Gulig','Strong','2017-05-08 09:09:04',171,NULL,1,-1,15,'19b194b1-e689-4947-b418-69e5608877ef',NULL,NULL),(297,'Winston','William','Strong','2017-05-08 09:10:39',171,296,3,7,15,'',NULL,'2006-12-08'),(298,'Tyler','Neal','Strong','2017-05-08 09:11:10',171,296,3,4,15,'',NULL,'2009-12-17'),(299,'Samantha','Ann','Dill','2017-05-08 09:44:25',172,NULL,1,-1,21,'b4ac2b41-5bb9-46a4-9653-ef209bf0d23a',NULL,NULL),(300,'Dalton','Lee','Montgomery','2017-05-08 09:46:06',172,299,3,3,21,'',NULL,'2011-07-13'),(302,'Jack','Lee','Anthony','2017-05-08 10:52:44',173,NULL,-1,-1,-1,'64acf003-8222-40ce-9918-87af63d72b14',NULL,NULL),(303,'Alexander','Sebastian','Anthony','2017-05-08 10:58:24',173,302,3,7,27,'','Asthma','2005-09-21'),(304,'Denise',NULL,'Cubbedge','2017-05-08 11:03:35',174,NULL,1,-1,28,'fe9c51fb-147b-4e12-8f4c-5ed06aef8859',NULL,NULL),(305,'Edison',NULL,'Cubbedge','2017-05-08 11:08:04',174,304,3,6,28,'','None','2007-11-26'),(306,'Martha','Pearson','Chastain','2017-05-08 15:34:32',175,NULL,3,-1,18,'f4a05e5f-0a86-436e-b442-c27332078ec5',NULL,NULL),(307,'Garrison','Blake','Chastatin','2017-05-08 15:48:32',175,306,3,6,18,'','None','2007-11-17'),(308,'Laura','Ann','Johnston','2017-05-08 15:52:47',176,NULL,1,-1,28,'314b3ba3-f01e-4256-872d-c07900d871bd',NULL,NULL),(309,'Jacob','Scott','Limerick','2017-05-08 15:54:51',176,308,3,6,28,'',NULL,'2008-06-08'),(310,'Aiden','Michael','Limerick','2017-05-08 15:55:59',176,308,3,3,28,'','Seasonal allergies, is prone to nose bleeds','2011-02-20'),(311,'Rosie',NULL,'Hopkins-Campbell','2017-05-08 16:53:34',177,NULL,1,-1,63,'44f8fb5e-f8a3-48a1-afba-1d27f240752b',NULL,NULL),(314,'Fred','Norman','Campbell','2017-05-08 17:05:48',177,311,3,4,29,'','Outdoor/seasonal','2010-02-05'),(315,'Fred',NULL,'Campbell, Sr.','2017-05-08 17:11:25',178,NULL,1,-1,29,'df8f6008-0a3d-46a8-81d9-6bc1938f05f1',NULL,NULL),(316,'Fred','Norman','Campbell','2017-05-08 17:16:19',178,315,3,4,29,'','seasonal/outdoor','2010-02-05'),(317,'Eric','John','Fuehrer','2017-05-09 20:20:25',179,NULL,2,-1,4,'bc2fcec9-b39c-4f02-9e1f-5cdb86e734e7',NULL,NULL),(318,'Dane','Robert','Fuehrer','2017-05-08 17:24:07',179,317,3,6,4,'',NULL,'2008-06-30'),(319,'Austin','Lee','Fuehrer','2017-05-08 17:24:38',179,317,3,6,4,'',NULL,'2008-06-30'),(320,'Caci',NULL,'Nance','2017-05-08 20:02:59',180,NULL,-1,-1,-1,'d99295d8-33bf-499b-986d-b837daf837b9',NULL,NULL),(321,'Peyton','Lee','Blades','2017-05-08 20:29:33',169,293,3,7,23,'','peanuts','2006-08-10'),(322,'Alyssa',NULL,'Lesmeister','2017-05-08 20:42:56',181,NULL,1,-1,21,'71789443-abf1-4a84-903f-e733ba3cb1d0',NULL,NULL),(323,'Davidh','John','Hunt','2017-05-08 20:46:18',182,NULL,1,-1,15,'c4e433a8-b04e-4e7b-b760-610962c2a365',NULL,NULL),(324,'Ethan','Alexander','Hunt','2017-05-08 20:46:05',182,323,3,3,15,'',NULL,'2012-03-02'),(325,'ANDREW','WESLEY','HANE','2017-05-08 21:19:18',183,NULL,3,-1,18,'0f4cfe52-3050-44d3-b228-5f822dd5dd75',NULL,NULL),(326,'Wesley','Joseph ','Hane','2017-05-08 21:21:30',183,325,3,5,18,'','none','2012-01-28'),(327,'Christy',NULL,'Moore','2017-05-08 21:45:56',184,NULL,3,-1,27,'b9c18fb8-f02d-42e3-b9e2-c8a6a291588c',NULL,NULL),(328,'Charlie',NULL,'Moore','2017-05-08 21:47:56',184,327,3,7,27,'','seasonal','2006-12-26'),(329,'Sam',NULL,'Moore','2017-05-08 21:48:34',184,327,3,4,27,'',NULL,'2010-06-06'),(330,'Cristy',NULL,'Clack','2017-05-09 07:03:28',185,NULL,3,-1,28,'9f357deb-5b1e-4fdb-a1c5-4affeeea43f4',NULL,NULL),(331,'Patrick',NULL,'Williams','2017-05-09 23:20:16',186,NULL,2,-1,51,'5dbef02c-3b93-4c55-9971-63b44478c1c9',NULL,NULL),(332,'Wyatt','Charles','James','2017-05-11 20:34:34',148,252,3,5,20,'',NULL,'2009-03-23'),(333,'Test',NULL,'Test','2017-05-12 15:38:42',187,NULL,-1,-1,-1,'027c3a0b-41af-486b-afb7-58ae6be81963',NULL,NULL),(334,'TEstchild',NULL,'Testchild','2017-05-12 15:39:50',187,333,3,7,21,'',NULL,'2012-05-12'),(335,'Paul','Carter','Miller','2017-05-13 15:05:04',188,NULL,2,-1,29,'a02dae7b-ca1a-4669-a1b5-def033a815cc',NULL,NULL),(336,'Grant ','Thomas','Miller','2017-05-13 15:07:28',188,335,4,7,63,'','Peanut','2006-02-02'),(337,'Monica',NULL,'McCoy','2017-05-13 19:00:02',189,NULL,1,-1,30,'b1be1e28-23a3-45e4-a380-18bfbb88d914',NULL,NULL),(338,'Noah',NULL,'McCoy','2017-05-13 18:59:37',189,337,3,6,30,'','phenoxyethanol\r\nmethylisothiazolinone','2008-03-03'),(339,'Sam',NULL,'Clack','2017-05-15 15:38:50',185,330,3,4,28,'',NULL,'2009-02-10'),(340,'Kelly',NULL,'Schifferle','2017-05-15 17:14:34',190,NULL,1,-1,22,'b5854529-ac7b-4d53-bc69-a4a063f00c6e',NULL,NULL),(341,'Xavier',NULL,'Schifferle','2017-05-15 17:16:32',190,340,3,4,22,'',NULL,'2009-11-27'),(342,'Christina',NULL,'Poetzl','2017-05-15 18:27:39',191,NULL,1,-1,20,'07bc8c87-1771-441a-8519-abfcd89e6f6a',NULL,NULL),(343,'Matthew','Joseph','Poetzl','2017-05-15 18:29:03',191,342,3,5,20,'',NULL,'2012-08-28'),(344,'Richard',NULL,'Myrick','2017-05-15 19:20:13',192,NULL,1,-1,29,'dbd65d40-5f14-4fec-9505-48297cfa9d8b',NULL,NULL),(345,'Frederic',NULL,'Campbell','2017-05-15 20:03:59',193,NULL,1,-1,29,'eacb2c2d-a7eb-41c2-97cd-ef34152bc123',NULL,NULL),(346,'Fred','Norman','Campbell','2017-05-15 20:11:05',193,345,3,4,29,'','Outdoor seasonal:hickory, oak, pigweed, ragweed, dust mite, Alturia mold','2010-02-05'),(347,'Ernest','Peyton','Myrick','2017-05-15 21:17:33',192,344,3,4,29,'',NULL,'2010-01-10'),(348,'Pam',NULL,'Horack','2017-05-16 11:30:31',194,NULL,1,-1,20,'89e6623b-9e50-404e-a3cc-2beec17ca3f2',NULL,NULL),(349,'Kevin',NULL,'Horack','2017-05-16 11:32:11',194,348,3,7,20,'','penicillin, shrimp','2006-12-25'),(350,'Donald',NULL,'Horack','2017-05-16 11:32:47',194,348,4,8,54,'','none','2004-08-08'),(351,'Sheri',NULL,'Lichty','2018-05-09 10:19:43',195,NULL,2,-1,20,'956d3fb2-f870-4a49-ac35-95f71bf41228',NULL,'1973-12-11'),(352,'Christina',NULL,'Poetzl','2017-05-17 14:38:04',196,NULL,2,-1,20,'0baa0786-cf75-4b19-9abc-2120b39d96a2',NULL,NULL),(353,'Elizabeth',NULL,'Rollyson','2017-05-19 22:43:40',197,NULL,3,-1,1,'6a7de375-00f4-49fe-986f-e7f407a4ea27',NULL,NULL),(354,'Tucker',NULL,'Rollyson','2017-05-19 22:46:49',197,353,3,5,1,'','Penecilin','2009-05-04'),(355,'Lisa-Anne ',NULL,'Williams','2017-05-22 12:09:11',198,NULL,3,-1,2,'a2794caa-344a-4a61-9419-e829e9d7b3da',NULL,NULL),(356,'Cullen ','James','Dellinger','2017-05-23 11:11:57',199,NULL,3,-1,30,'5efb75f5-390e-4dd9-92e7-4c5294d6841a',NULL,NULL),(357,'Zander',NULL,'Kirkland','2017-05-23 21:11:50',82,115,6,16,11,'',NULL,'2005-05-17'),(358,'Sarah ','B','Garrison','2017-05-24 12:09:09',162,277,6,17,55,'','No','1999-06-11'),(359,'Georgia','B','Garrison ','2017-05-24 12:10:09',162,277,6,17,55,'','None','2002-03-07'),(360,'Geneva','B','Garrison ','2017-05-24 12:11:12',162,277,6,17,55,'','None','2013-08-04'),(361,'Stuart',NULL,'Hildebrandt','2017-05-30 08:16:35',200,NULL,1,-1,28,'31c04f57-2034-4c70-afa3-6780cae9d64c',NULL,NULL),(362,'Liam',NULL,'Hildebrandt','2017-05-30 08:17:31',200,361,3,5,28,'',NULL,'2009-01-13'),(363,'Levi','Glen','Bennett','2017-06-01 10:53:10',201,NULL,4,-1,57,'84e2f38c-4cf6-4ac5-9d3e-ea77c34322c1',NULL,NULL),(364,'Amy',NULL,'Dellinger','2017-06-09 13:03:43',202,NULL,1,-1,30,'027b0254-950c-488c-a2f0-45e95ed633a2',NULL,NULL),(365,'Cullen','James','Dellinger','2017-06-09 13:09:25',202,364,3,4,30,'',NULL,'2010-03-03'),(366,'Jessica','Lauren','McMasters','2018-02-09 18:48:27',203,NULL,2,-1,22,'df1a708e-4702-4435-81f1-ea5d77fcb5ce',NULL,NULL),(367,'Micah','WJ','McMasters','2018-02-09 18:50:55',203,366,3,3,22,'',NULL,'2008-10-10'),(368,'Sullivan','AT','McMasters','2018-02-09 18:52:46',203,366,3,16,22,'',NULL,'2011-12-01'),(369,'Amy',NULL,'Clark','2018-02-18 16:08:43',204,NULL,3,-1,1,'fc6b1dd3-4e21-4c14-9d93-9e084a55fba1',NULL,NULL),(370,'pete',NULL,'schreiber','2018-02-26 22:28:02',205,NULL,1,-1,11,'aeacca57-3b29-49b3-bccf-040d1df072ee',NULL,NULL),(371,'jacob',NULL,'schreiber','2018-02-26 22:29:52',205,370,3,6,11,'',NULL,'2007-10-10'),(372,'Julie',NULL,'Piehl','2018-02-27 15:00:45',206,NULL,3,-1,54,'2b102fd2-08b0-4fa2-983e-c04565f77463',NULL,NULL),(373,'Natasha',NULL,'Tarbrake','2018-02-28 15:20:56',207,NULL,1,-1,55,'1f50ce58-1bc9-4f28-9e91-a8679a06fc7f',NULL,NULL),(374,'Justice',NULL,'Williams','2018-02-28 15:21:47',207,373,3,7,55,'',NULL,'2007-06-07'),(375,'Billy',NULL,'Bronson ','2018-02-28 18:45:47',208,NULL,1,-1,21,'18c8dc1f-4d50-4d66-85ae-29fac05f0767',NULL,NULL),(377,'Aiden',NULL,'Bronson ','2018-02-28 18:51:25',208,375,3,5,21,'','None','2008-09-18'),(378,'Anna',NULL,'Bowman','2018-03-01 07:52:25',209,NULL,1,-1,21,'abcc4d55-ed58-4861-97b4-706b3e13eaec',NULL,NULL),(379,'David',NULL,'Bowman','2018-03-01 07:53:52',209,378,3,5,21,'',NULL,'2009-08-19'),(381,'DJ',NULL,'Bowman','2018-03-01 07:56:41',209,378,3,16,21,'',NULL,'2007-12-08'),(382,'Alex',NULL,'Piehl','2018-03-01 10:54:07',206,372,3,3,20,'',NULL,'2010-09-07'),(383,'ryan',NULL,'Magee','2018-03-06 09:31:20',210,NULL,1,-1,19,'38fb656b-dc16-4b2a-ba82-2d22d7ac654d',NULL,NULL),(384,'Rhett',NULL,'Magee','2018-03-06 09:32:53',210,383,3,4,19,'',NULL,'2010-06-19'),(385,'Bob',NULL,'Pellegrino','2018-03-07 09:22:24',211,NULL,1,-1,21,'3e639382-c3b7-48a6-8551-89625dfc4e2c',NULL,NULL),(386,'Mason',NULL,'Pellegrino','2018-03-07 09:24:48',211,385,3,4,21,'',NULL,'2008-11-02'),(387,'Thomas ','Wayne ','Clark ','2018-03-07 18:17:01',212,NULL,3,-1,1,'6281692a-5c46-4f0e-88c8-00176d4fd320',NULL,NULL),(388,'Lora','P','Lindquist','2018-03-11 22:55:35',213,NULL,2,-1,12,'8befbf7b-b965-4970-843f-bb1ee96a47b9',NULL,NULL),(389,'Cameron','S ','Lindquist','2018-03-11 22:59:06',213,388,3,5,12,'',NULL,'2008-05-30'),(390,'Della',NULL,'Louthan','2018-03-11 23:06:15',214,NULL,2,-1,12,'ee2005fd-9c53-4efd-b19c-c45f3dd72bba',NULL,NULL),(391,'Matthew',NULL,'Gandolfi','2018-03-17 23:09:52',215,NULL,3,-1,11,'acfff69c-47d6-4089-902a-b1d4fedbf0c5',NULL,NULL),(392,'James',NULL,'Gandolfi','2018-03-17 23:11:51',215,391,3,3,11,'','Pollen allergies. Rescue inhaler for emergencies ','2009-10-11'),(393,'Matthew ',NULL,'Gandolfi','2018-03-17 23:14:40',216,NULL,1,-1,11,'384bb297-d745-44b0-be74-faf235f2c7c9',NULL,NULL),(394,'James',NULL,'Gandolfi','2018-03-17 23:15:48',216,393,3,4,11,'','Pollen allergies. Rescue inhaler used as needed. ','2009-10-11'),(395,'Tammy','D','Frailey ','2018-03-19 21:59:03',217,NULL,1,-1,29,'8ca9f18b-dc83-47a6-b16a-625b836abb29',NULL,NULL),(396,'Tyler','Fredrick','Feailey','2018-03-19 22:01:33',217,395,3,5,29,'','None','2008-07-31'),(397,'Angela',NULL,'Moon','2018-05-09 13:09:55',218,NULL,1,-1,29,'5494ec32-ba5e-445f-9936-907106a6256b',NULL,NULL),(398,'Tristan','Tyler','Bickerstaff','2018-03-20 08:46:31',218,397,3,2,29,'',NULL,'2012-06-26'),(399,'Elizabeth',NULL,'Morgan','2018-03-27 15:01:29',219,NULL,1,-1,28,'40ff39df-73ba-44e2-b1ec-120a46e1ed5c',NULL,NULL),(400,'James',NULL,'Morgan','2018-03-27 15:05:13',219,399,3,4,28,'',NULL,'2009-09-29'),(401,'Jenifer',NULL,'Crawford','2018-03-27 15:59:22',220,NULL,1,-1,28,'e2d55ec0-53e1-4c40-aa94-89f24281d037',NULL,NULL),(402,'Copeland',NULL,'Crawford','2018-03-27 16:00:28',220,401,3,3,28,'','None','2010-03-02'),(403,'Franklin','W','Smith','2018-03-27 20:35:58',221,NULL,1,-1,47,'4f7f446b-a8b3-422e-8886-d20c3a4dee30',NULL,NULL),(404,'Maksim','W','Smith','2018-03-27 20:37:13',221,403,3,3,14,'',NULL,'2013-05-27'),(405,'Damon',NULL,'Hemphill','2018-04-27 21:39:30',222,NULL,1,-1,18,'2aa1831d-83d8-4813-8536-0fb6d9ea30f4',NULL,'1977-06-11'),(406,'Kris','Marie','Blair','2018-04-11 19:13:43',223,NULL,1,-1,18,'b49e1c60-a9a0-4913-9ee1-b656e7150cde',NULL,NULL),(408,'Devin','Patrick','Blair','2018-04-11 19:17:15',223,406,3,3,18,'',NULL,'2011-05-31'),(409,'Riley','Drew','Hemphill','2018-04-11 20:17:08',222,405,3,6,18,'',NULL,'2008-05-14'),(410,'Ryan','Grant','Hemphill','2018-04-11 20:18:08',222,405,3,3,18,'',NULL,'2011-07-13'),(411,'natasha','marie','francis','2018-04-13 12:12:25',224,NULL,1,-1,20,'bf314160-5162-4994-b985-74eb1bd850c9',NULL,NULL),(412,'julian','lee','francis','2018-04-13 12:06:43',224,411,3,3,20,'',NULL,'2010-12-04'),(413,'Joshua','Clifford','Davis','2018-04-23 20:07:23',225,NULL,1,-1,20,'ed1a77a8-0169-48a0-8514-19a1effb8b8a',NULL,NULL),(414,'Ethan','William','Davis','2018-04-14 13:27:42',225,413,3,4,20,'','Peanut, Tree Nut, Coconut','2009-12-01'),(415,'Christopher','Sebastion','Schweninger','2018-04-15 19:48:52',226,NULL,4,-1,55,'ccea9383-09f6-4587-8423-6756821f5d4c',NULL,NULL),(416,'Logan','Patrick','FitzGibbon','2018-04-15 22:31:08',227,NULL,4,-1,45,'1ba4c90a-163e-4e7f-85b2-c106813ca171',NULL,NULL),(417,'Benjamin ','N','Kelly','2018-04-17 08:52:57',228,NULL,1,-1,20,'57e2bf40-eb26-46ae-9fa9-3a3cb8137144',NULL,NULL),(418,'Nathan','Benjamin','Kelly','2018-04-17 08:54:54',228,417,3,3,20,'','none','2011-08-05'),(419,'Amy',NULL,'Lynch','2018-04-19 06:49:27',229,NULL,1,-1,20,'30eddd4b-fbb9-4b7b-9f3d-010903c25923',NULL,NULL),(420,'Aiden',NULL,'McGrade','2018-04-19 06:51:55',229,419,3,4,20,'','Asthma','2013-05-03'),(421,'Jonathan','Wayne','Parris','2018-04-24 19:31:36',230,NULL,1,-1,20,'1460b2c9-23a9-439d-b88e-91282130a080',NULL,NULL),(422,'Hayden','Nicholas','Parris','2018-04-19 07:46:59',230,421,3,3,2,'',NULL,'2010-05-16'),(423,'Wyatt','Nathaniel','Parris','2018-04-19 07:47:38',230,421,3,3,2,'',NULL,'2010-05-16'),(424,'Tina ',' None','Ngyuen ','2018-04-19 18:43:28',231,NULL,1,-1,22,'00ed25c9-7f73-4dd5-8a15-f6a82953934a',NULL,NULL),(425,'Amanda','B','Daum','2018-04-19 19:15:38',232,NULL,1,-1,20,'8bff64d1-8f56-4d72-a452-ab5094b9aaaa',NULL,'2009-09-08'),(426,'James','B','Daum','2018-04-19 19:16:38',232,425,4,3,20,'',NULL,'2009-09-08'),(427,'James','B','Daum','2018-04-19 19:18:29',232,425,3,4,20,'','None','2009-09-08'),(428,'Vayden ',NULL,'Nguyen ','2018-04-19 19:29:08',231,424,3,3,22,'','None','2009-10-08'),(429,'tyron','gerald','francis','2018-04-19 20:52:57',233,NULL,1,-1,20,'eba32934-ea6d-4464-b955-517bc7dba267',NULL,NULL),(430,'rebececca','lynn','isenhour','2018-04-19 20:59:02',234,NULL,1,-1,20,'a05b85b7-f4a5-4961-885b-a7948f25960c',NULL,NULL),(431,'Phillip',NULL,'Stevens','2018-04-20 18:52:53',235,NULL,1,-1,18,'e386fc69-c3ec-454c-afab-48b9114d4fd3',NULL,NULL),(432,'Colson',NULL,'Stevens','2018-04-20 18:55:02',235,431,3,3,18,'',NULL,'2011-03-01'),(433,'Tina',NULL,'Byrd','2018-04-22 18:06:09',236,NULL,2,-1,28,'02d6e4e8-d491-42b7-b0f7-3a6e8096f44b',NULL,NULL),(434,'Nico',NULL,'Byrd','2018-04-22 18:07:23',236,433,3,5,28,'',NULL,'2007-11-28'),(435,'Betty Anne',NULL,'Henson','2018-04-22 21:55:49',237,NULL,1,-1,48,'3646a56a-d0fb-4569-8afc-83e7774fb053',NULL,NULL),(436,'Kade','Mackinley','Henson ','2018-04-22 22:04:50',237,435,3,7,48,'',NULL,'2009-07-20'),(437,'Craig',NULL,'Crawford','2018-04-23 12:45:31',220,401,3,2,28,'','None','2012-06-07'),(438,'Laura','E','Weidner','2018-04-23 17:56:07',238,NULL,-1,-1,-1,'bf466859-6287-4abd-8f1f-dc85e4d06740',NULL,NULL),(439,'Christian ','Dow','Waters','2018-04-24 08:07:32',160,273,3,4,23,'',NULL,'2013-10-02'),(440,'Test','W','Account','2018-04-24 15:28:51',239,NULL,-1,-1,-1,'a96e1a1d-f192-4ba4-b5f6-5740a6fe015d',NULL,NULL),(441,'Hayden','Nicholas','Parris','2018-04-24 19:36:40',230,421,3,4,20,'',NULL,'2010-05-16'),(442,'Wyatt','Nathaniel','Parris','2018-04-24 19:37:20',230,421,3,4,20,'',NULL,'2010-05-16'),(443,'Stacey ',NULL,'Hunter','2018-04-25 09:36:32',240,NULL,1,-1,18,'a63e5840-d00c-48c1-9e38-4ca0d517c5b6',NULL,'1900-07-15'),(445,'Ethan','Morello','Hunter','2018-04-25 09:38:30',240,443,3,2,18,'',NULL,'2013-01-31'),(446,'Frances',NULL,'Felix','2018-04-26 19:52:37',241,NULL,1,-1,18,'239249a7-0b34-42b3-9b31-9e2df9394a98',NULL,NULL),(447,'Angel','Jaiden','Acosta','2018-04-26 19:56:12',241,446,3,5,18,'','None','2008-10-03'),(448,'Jennifer',NULL,'Thompson','2018-04-26 20:38:48',242,NULL,1,-1,18,'b5439bfb-5b28-4aa5-8f61-349d03d254d3',NULL,NULL),(449,'James','Connor','Thompson','2018-04-26 20:39:54',242,448,3,3,18,'','Connor is allergic to Amoxicillin and has an Epilepsy Diagnosis','2013-04-26'),(450,'Jennifer','Lynn','Baker','2018-04-26 21:37:21',243,NULL,3,-1,20,'22c6bfd9-41e8-435b-a1c2-e63f12595dd3','None','1973-03-17'),(451,'Julian','George','Baker','2018-04-26 21:28:52',243,450,3,3,20,'','None','2011-05-04'),(452,'Jordan ','Sheehan','Baker','2018-04-26 21:33:29',243,450,4,11,54,'','None','2013-10-06'),(453,'Joshua','Scott','Poulter ','2018-04-26 22:40:09',244,NULL,3,-1,30,'96ca08f5-94f9-4a6e-9fa4-a2d715b6e729',NULL,NULL),(454,'Jennifer',NULL,'Dulin ','2018-04-29 12:29:16',245,NULL,1,-1,9,'4ef3139a-9301-4331-8642-059eda722546',NULL,NULL),(455,'Joshua',NULL,'Trent','2018-04-29 12:31:20',245,454,3,4,9,'','None','2010-04-06'),(456,'Dana',NULL,'Jones','2018-04-30 20:10:27',246,NULL,1,-1,20,'b8dd3e39-522c-4f7c-98a9-bab7bdbb6678',NULL,NULL),(457,'Daniel','Joshua','Jones','2018-04-30 20:11:40',246,456,3,6,20,'',NULL,'2008-05-02'),(458,'Carolee','Renee','Adams','2018-04-30 21:05:24',247,NULL,1,-1,29,'8b7f96ab-7336-47ce-a8d7-72ec80ba4602',NULL,NULL),(459,'Harrison','Eric','Adams','2018-04-30 21:09:26',247,458,3,4,29,'','None','2010-03-26'),(460,'Rosie',NULL,'Hopkins-Campbell','2018-04-30 22:19:29',248,NULL,1,-1,29,'0a290298-1658-47f0-95d0-e2f663cbf971','None','1898-02-05'),(461,'Fred','Norman','Campbell, III','2018-04-30 22:21:02',248,460,3,4,29,'','Seasonal outdoor','2010-02-05'),(462,'Paige ',NULL,'Donatello ','2018-05-01 09:43:38',249,NULL,-1,-1,-1,'90e9f1b7-a701-457d-ba42-4b795ddb093d',NULL,NULL),(463,'Tanner',NULL,'Donatello','2018-05-01 09:46:19',249,462,3,5,21,'',NULL,'2007-12-27'),(464,'Jerry','D','Wiebe','2018-05-02 08:34:27',250,NULL,3,-1,21,'56184658-1de8-4c51-a433-cc870a757e16',NULL,NULL),(465,'JD',NULL,'Wiebe','2018-05-02 08:36:41',250,464,3,3,21,'',NULL,'2010-04-30'),(466,'Dawson',NULL,'Wiebe','2018-05-02 08:37:21',250,464,3,3,21,'',NULL,'2010-04-30'),(467,'Jill',NULL,'Sabella','2018-05-02 09:35:20',251,NULL,1,-1,15,'988aa69b-96eb-41b4-93cd-66b99562e9c4',NULL,NULL),(468,'Timmy',NULL,'Sabella','2018-05-02 09:35:08',251,467,3,4,15,'','none','2010-08-22'),(469,'Pamela',NULL,'Hutchison','2018-05-02 18:25:03',252,NULL,2,-1,6,'635c7f5d-50b5-46bf-9cde-33f9d1fe939c',NULL,NULL),(470,'Anthony',NULL,'Tobias','2018-05-02 18:33:15',252,469,3,6,6,'','NA','2018-07-23'),(471,'Katherine','Arlene','Brett','2018-05-02 18:54:18',253,NULL,1,-1,6,'c9a6c169-aca8-42dc-b5a4-189208351da9',NULL,NULL),(472,'Kameron','Chad','Linebarger','2018-05-02 18:56:58',253,471,3,6,6,'','Has small case of asthma and has eczema- can not lay in grass unless full clothed','2008-05-20'),(473,'Ctephanie','Denise','Savoie','2018-05-02 21:32:51',254,NULL,1,-1,21,'b145ab31-c99f-431e-9476-c25877d1aada',NULL,'1991-05-08'),(474,'Nancy',NULL,'Carruth','2018-05-02 19:11:19',255,NULL,2,-1,6,'cd2694b2-a799-4849-8b21-c56737dc9a88',NULL,NULL),(475,'Jax',NULL,'Carruth','2018-05-02 19:14:40',255,474,3,5,6,'','Peanuts','2009-08-03'),(476,'william','scott','elam','2018-05-02 19:15:12',256,NULL,1,-1,6,'d3fb0a13-b6a4-4701-8458-76134458b0a4',NULL,NULL),(477,'william','elijah','elam','2018-05-02 19:17:03',256,476,3,6,6,'',NULL,'2007-12-19'),(478,'Abram','seth','elam','2018-05-02 19:18:09',256,476,3,3,6,'',NULL,'2011-06-07'),(479,'Karen',NULL,'McDonald','2018-05-02 19:40:47',257,NULL,2,-1,6,'d43c48c4-8ea5-4bf3-93d2-ad131796f485',NULL,NULL),(480,'Brycen',NULL,'McDonald','2018-05-02 19:42:27',257,479,3,3,6,'','none','2010-10-25'),(481,'William',NULL,'Robinson, Sr.','2018-05-02 19:50:19',258,NULL,2,-1,6,'62869908-34d2-43aa-a13c-7c8796eb9742',NULL,NULL),(482,'William',NULL,'Robinson, II','2018-05-02 19:54:35',258,481,3,4,6,'','None','2010-07-07'),(483,'Debra','L','Savoie','2018-05-02 20:52:41',259,NULL,-1,-1,-1,'1077dfbc-6521-465f-9c07-390f00472131',NULL,NULL),(484,'Austin','Daniel','Savoie','2018-05-02 21:28:49',254,473,3,2,21,'',NULL,'2012-01-13'),(485,'Joshua','Brian','Waldrop','2018-05-02 21:33:32',254,473,3,4,21,'',NULL,'2010-07-31'),(486,'Casey',NULL,'Pollock','2018-05-04 12:35:42',260,NULL,1,-1,19,'c3836517-fefa-478c-810b-15aad1c21934',NULL,'1986-09-30'),(487,'Wyatt','Samuel','Grimm','2018-05-04 08:52:35',261,NULL,4,-1,55,'f8dfca4b-7f4f-4fa3-8c71-bdf5319e7f22',NULL,NULL),(488,'Tony',NULL,'Sanders','2018-05-04 10:38:23',262,NULL,1,-1,4,'84fea538-0b08-4768-9787-555af9d1d446',NULL,NULL),(489,'Gabriel',NULL,'Collins','2018-05-04 10:46:31',263,NULL,3,-1,4,'21f6aa27-5729-49d7-999d-ce7e188a2973',NULL,NULL),(490,'Gabriel','Dean','Collins','2018-05-04 10:59:05',262,488,3,3,4,'',NULL,'2000-01-15'),(491,'Gabriel',NULL,'Pollock','2018-05-04 12:37:10',260,486,3,4,19,'',NULL,'2009-12-18'),(492,'Julie',NULL,'Moore','2018-05-05 16:23:08',264,NULL,3,-1,21,'45bd793e-6581-4542-9b79-99a7e88ab70c',NULL,NULL),(493,'Nathan ',NULL,'Moore','2018-05-05 16:25:10',264,492,3,3,21,'','None','2011-05-08'),(494,'Brycen',NULL,'McDonald','2018-05-06 11:50:15',265,NULL,3,-1,6,'c194559c-9131-49b0-bd83-c544be756e01',NULL,NULL),(495,'Brycen',NULL,'McDonald','2018-05-06 11:51:37',265,494,3,3,6,'','none','2010-10-25'),(496,'Kellie',NULL,'Stevens','2018-05-06 15:12:22',266,NULL,1,-1,18,'0ac6ee96-66cd-469a-a7a6-fd45ca1bd266',NULL,NULL),(497,'Colby',NULL,'Schneider','2018-05-06 20:47:42',267,NULL,1,-1,6,'211707fa-e981-4e28-81eb-71a44d0d64f7',NULL,NULL),(498,'Landon','Cole','Schneider','2018-05-06 20:49:01',267,497,3,5,6,'',NULL,'2008-03-10'),(499,'Luke','Owen','Schneider','2018-05-06 20:49:51',267,497,3,2,6,'',NULL,'2011-04-14'),(500,'Carly','Nicole ','Powell','2018-05-07 04:10:46',153,261,3,4,21,'',NULL,'2010-07-07'),(501,'Michael',NULL,'Carruth','2018-05-07 11:07:52',268,NULL,2,-1,6,'9f4ebc6e-da0b-414d-b09f-f385c2353be3',NULL,NULL),(502,'Test',NULL,'Culver','2018-05-07 13:29:55',72,78,3,2,21,'','Female','2013-05-07'),(503,'Paige','E','Harshbarger','2018-05-08 10:11:32',269,NULL,3,-1,23,'705a5c1b-af41-4b66-bfa7-c55c4d80a78a',NULL,NULL),(504,'Bryce','Clark','Harshbarger','2018-05-08 10:13:56',269,503,3,4,23,'','none','2009-07-27'),(505,'Amy',NULL,'Lee','2018-05-09 15:03:12',270,NULL,2,-1,21,'e1156d3d-e021-452e-8af2-b37ff2e2cd3d',NULL,'1980-07-19'),(506,'Peter','A','Martinez','2018-05-09 10:39:52',271,NULL,2,-1,29,'9a15e243-7441-444a-a445-64f8dbc9fab4',NULL,NULL),(507,'Damian',NULL,'Martinez','2018-05-09 10:42:55',271,506,3,2,29,'','Has a speech disorder and gets severe migraines.  Is under medication for it but may need to sit out events','2011-02-17'),(508,'Jessica',NULL,'Martinez','2018-05-09 10:46:11',272,NULL,1,-1,29,'f07f4312-e438-4cca-bb77-a2039cba1049',NULL,NULL),(509,'Damian',NULL,'Martinez','2018-05-09 10:50:28',272,508,3,2,29,'','Has migraines.  Takes regular preventative medication for it.  May still have to sit out of activities.','2011-02-17'),(510,'James','Logan','Tinker','2018-05-09 14:25:08',273,NULL,4,-1,55,'3e67318d-7be6-4b4a-a024-fea248072e46',NULL,NULL),(511,'Dalton','Alan','Lee','2018-05-09 15:02:55',270,505,3,4,21,'','Fire Ants, Must wear ear plugs to swim. ','2010-04-01'),(512,'Kelly',NULL,'Williamson','2018-05-10 09:56:28',274,NULL,1,-1,9,'14d52cc9-7780-4630-b721-a4f54e1755ac',NULL,NULL),(513,'Chay','Edward','Williamson','2018-05-10 09:59:05',274,512,3,4,9,'','Sensitive to Insect Bites\r\n\r\nChay is a BOY','2009-08-01'),(514,'Seth','Charles','Williamson','2018-05-10 10:00:12',274,512,3,4,9,'','Sensitive to Insect Bites\r\nSensitive Skin\r\n\r\nSeth is a BOY','2009-08-01'),(515,'Meg',NULL,'Cope','2018-05-10 15:41:00',110,165,3,2,28,'','Female','2011-10-16'),(516,'Nicholas','Van Pelt','Weller','2018-05-10 19:39:02',275,NULL,1,-1,14,'93fd2d67-d2d4-4721-935a-8ace37c81b38',NULL,NULL),(517,'Miles','Van Pelt','Weller','2018-05-10 19:40:36',275,516,3,3,14,'','N/A','2011-06-28'),(518,'Brenda','Leigh','Stallworth','2018-05-10 21:39:58',276,NULL,1,-1,60,'da473ae4-faa4-45fd-b4c1-6adc561f7f1b',NULL,NULL),(519,'Brenda','Leigh','Stallworth','2018-05-10 21:46:26',277,NULL,1,-1,60,'7ff58362-eb84-4b16-a2ec-8c724340d3b0',NULL,NULL),(520,'Margaret','Loiuse','Stallworth ','2018-05-10 21:48:14',277,519,3,7,62,'','None','2010-11-12'),(522,'Deaglán ','Hunter','Stallworth','2018-05-10 21:50:57',277,519,3,2,28,'','None','2012-07-23'),(523,'Nevaeh','Dezmarea','Byrd','2018-05-11 09:05:05',236,433,3,4,28,'',NULL,'2009-11-14');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persontypes`
--

DROP TABLE IF EXISTS `persontypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persontypes` (
  `PersonTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `PersonType` varchar(45) NOT NULL,
  PRIMARY KEY (`PersonTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Stores what type of person ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persontypes`
--

LOCK TABLES `persontypes` WRITE;
/*!40000 ALTER TABLE `persontypes` DISABLE KEYS */;
INSERT INTO `persontypes` VALUES (-1,'NaN'),(1,'Parent'),(2,'Leader'),(3,'Cub Scout'),(4,'Boy Scout'),(5,'Venturer'),(6,'Youth');
/*!40000 ALTER TABLE `persontypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `positions` (
  `PositionID` int(11) NOT NULL AUTO_INCREMENT,
  `Position` varchar(45) NOT NULL,
  PRIMARY KEY (`PositionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registrations`
--

DROP TABLE IF EXISTS `registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registrations` (
  `RegistrationID` int(11) NOT NULL AUTO_INCREMENT,
  `RegistrationDate` datetime NOT NULL,
  `Confirmation` varchar(64) NOT NULL,
  `LastUpdated` datetime DEFAULT NULL,
  `Events_EventID` int(11) NOT NULL,
  `Person_PersonID` int(11) NOT NULL,
  PRIMARY KEY (`RegistrationID`,`Events_EventID`,`Person_PersonID`),
  KEY `fk_Registrations_Events1_idx` (`Events_EventID`),
  KEY `fk_Registrations_Person1_idx` (`Person_PersonID`),
  CONSTRAINT `fk_Registrations_Events1` FOREIGN KEY (`Events_EventID`) REFERENCES `events` (`EventID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registrations_Person1` FOREIGN KEY (`Person_PersonID`) REFERENCES `person` (`PersonID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registrations`
--

LOCK TABLES `registrations` WRITE;
/*!40000 ALTER TABLE `registrations` DISABLE KEYS */;
INSERT INTO `registrations` VALUES (128,'2018-02-09 09:00:24','77ef0fe2615e9656','2018-02-09 09:00:23',1,99),(129,'2018-02-09 18:51:19','d8f7d195121b8a5a','2018-02-09 18:51:18',1,367),(130,'2018-02-09 18:53:11','ba5b23e922aeb0c3','2018-02-09 18:53:10',1,368),(131,'2018-02-14 03:26:46','bcd0ade5e3b61ea1','2018-02-14 03:26:45',1,260),(132,'2018-02-20 14:58:15','b4121a2569cfc391','2018-02-20 14:58:14',1,246),(133,'2018-02-24 10:41:21','2e04e31990461a9f','2018-02-24 10:41:20',1,132),(134,'2018-02-24 13:00:42','58957aa5d021cab6','2018-02-24 13:00:42',1,244),(135,'2018-02-24 13:01:10','e599155d78cd4df0','2018-02-24 13:01:09',1,245),(136,'2018-02-24 13:01:37','485840713ca2e8a9','2018-02-24 13:01:37',1,247),(137,'2018-02-26 22:30:20','27b0b52a28caef0','2018-02-26 22:30:20',1,371),(139,'2018-02-28 18:51:50','258692ca9985362e','2018-02-28 18:51:50',1,377),(140,'2018-03-01 08:00:57','6c1d2ba7e77b6e76','2018-03-01 08:00:57',1,379),(141,'2018-03-01 08:01:21','fb77826db879818e','2018-03-01 08:01:21',1,381),(142,'2018-03-06 09:38:16','10965397dec04d39','2018-03-06 09:38:15',1,384),(143,'2018-03-07 09:25:29','9bb8a5e1758514aa','2018-03-07 09:25:29',1,386),(144,'2018-03-11 23:12:38','aedc98accc5b3aa0','2018-03-11 23:12:37',1,389),(145,'2018-03-17 23:16:04','f826f0653352657d','2018-03-17 23:16:04',1,394),(148,'2018-04-13 15:50:09','27d67fdc15d6c0bc','2018-04-13 15:50:08',1,116),(152,'2018-04-19 06:51:51','d030dda2631a8fd5','2018-04-19 06:51:51',1,414),(153,'2018-04-19 06:52:27','7741107f8e04fec2','2018-04-19 06:52:27',1,420),(154,'2018-04-19 07:45:38','ee2c57a6743a35d7','2018-04-19 07:45:38',1,382),(155,'2018-04-19 09:17:37','50fb5c7ddd7451af','2018-04-19 09:17:36',1,418),(156,'2018-04-19 19:18:51','3e2bb6c48a356d19','2018-04-19 19:18:51',1,427),(157,'2018-04-19 21:02:48','4b0b37485aef6998','2018-04-19 21:02:47',1,412),(158,'2018-04-19 21:22:46','df800fa0a142cd9c','2018-04-19 21:22:46',1,198),(159,'2018-04-20 09:01:26','1471f3622b9eaa67','2018-04-20 09:01:25',1,428),(160,'2018-04-20 16:52:32','43dfd4635c4cb8b2','2018-04-20 16:52:31',1,343),(161,'2018-04-21 08:30:38','dcfd70886ea782c0','2018-04-21 08:30:38',1,202),(162,'2018-04-21 08:31:05','5f623af70a5af860','2018-04-21 08:31:04',1,203),(165,'2018-04-24 08:11:38','86dfc8ce2e7e4829','2018-04-24 08:11:38',1,439),(166,'2018-04-24 10:51:59','ccd894b61fc20c92','2018-04-24 10:51:59',1,434),(167,'2018-04-24 10:52:14','6efbe4149f683715','2018-04-24 10:52:14',1,400),(168,'2018-04-24 10:52:40','b5e9463f44f092f9','2018-04-24 10:52:39',1,402),(169,'2018-04-24 10:53:14','a6529f8b5a44eb7f','2018-04-24 10:53:13',1,191),(170,'2018-04-24 10:53:28','fdca4c5d8975715c','2018-04-24 10:53:27',1,437),(171,'2018-04-24 10:53:45','30efb2f16be28c2f','2018-04-24 10:53:44',1,149),(172,'2018-04-24 10:53:55','f7b64823dda81ac3','2018-04-24 10:53:55',1,166),(173,'2018-04-24 11:39:36','b86387b9c92c5d8b','2018-04-24 11:39:36',1,310),(174,'2018-04-24 19:37:42','257aa1df707584','2018-04-24 19:37:41',1,441),(175,'2018-04-24 19:45:20','84b6274ea9f71662','2018-04-24 19:45:20',1,442),(176,'2018-04-25 10:10:36','71edd162c78772f6','2018-04-25 10:10:36',1,232),(177,'2018-04-27 21:41:06','846f02be9a898312','2018-04-27 21:41:06',1,410),(178,'2018-04-27 21:44:15','85abfa3ad9064e7f','2018-04-27 21:44:14',1,409),(179,'2018-04-27 21:44:41','90112a0790116835','2018-04-27 21:44:40',1,408),(180,'2018-04-28 15:52:53','879b802cf5b39abb','2018-04-28 15:52:53',1,445),(181,'2018-04-30 21:09:45','2487dd7c101ac94f','2018-04-30 21:09:45',1,459),(182,'2018-04-30 22:21:16','7729627a9ee3005e','2018-04-30 22:21:16',1,461),(183,'2018-05-01 09:46:43','e273c04c5224f454','2018-05-01 09:46:43',1,463),(184,'2018-05-01 10:14:59','749d3c8055c74e6c','2018-05-01 10:14:59',1,341),(185,'2018-05-02 08:38:42','d680b28cdd347997','2018-05-02 08:38:41',1,465),(186,'2018-05-02 08:39:33','249ace7bd27bdc93','2018-05-02 08:39:33',1,466),(187,'2018-05-02 18:57:18','dee52dcf43932060','2018-05-02 18:57:17',1,472),(188,'2018-05-02 19:15:27','2541460994840d7a','2018-05-02 19:15:26',1,475),(189,'2018-05-02 19:55:45','2d910149477f2033','2018-05-02 19:55:45',1,482),(190,'2018-05-02 21:30:45','43a75c063bf79ba0','2018-05-02 21:30:45',1,484),(191,'2018-05-02 21:33:43','5cea8114123803d4','2018-05-02 21:33:43',1,485),(192,'2018-05-03 14:42:04','55828880ce6861a9','2018-05-03 14:42:04',1,478),(193,'2018-05-03 14:42:28','e12cb72f03ae2a98','2018-05-03 14:42:27',1,477),(194,'2018-05-03 14:42:38','2d4018b6a4898598','2018-05-03 14:42:37',1,182),(195,'2018-05-03 14:42:50','f938b5d01a0cfe84','2018-05-03 14:42:50',1,480),(196,'2018-05-04 12:37:26','86a1c531540b723d','2018-05-04 12:37:25',1,491),(197,'2018-05-04 19:21:52','d94445d58af109b9','2018-05-04 19:21:51',1,432),(198,'2018-05-05 16:25:41','8f51d5cfe2c670c','2018-05-05 16:25:40',1,493),(199,'2018-05-08 10:14:13','ee0944d29c943848','2018-05-08 10:14:13',1,504),(200,'2018-05-08 22:49:52','7f4144e9fd26a499','2018-05-08 22:49:52',1,235),(201,'2018-05-09 10:50:42','231698fa213675d1','2018-05-09 10:50:42',1,509),(202,'2018-05-09 15:03:27','84260e97fb1411b9','2018-05-09 15:03:27',1,511),(203,'2018-05-09 17:13:46','dae379099b561426','2018-05-09 17:13:46',1,398),(204,'2018-05-10 09:47:56','6b5135f33ad9b24e','2018-05-10 09:47:55',1,266),(205,'2018-05-10 09:48:28','92af536ef24cdd15','2018-05-10 09:48:28',1,269),(206,'2018-05-11 05:18:02','1a279d9eaa717e4c','2018-05-11 05:18:02',1,500);
/*!40000 ALTER TABLE `registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registrations_2017`
--

DROP TABLE IF EXISTS `registrations_2017`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registrations_2017` (
  `RegistrationID` int(11) NOT NULL AUTO_INCREMENT,
  `RegistrationDate` datetime NOT NULL,
  `Confirmation` varchar(64) NOT NULL,
  `LastUpdated` datetime DEFAULT NULL,
  `Events_EventID` int(11) NOT NULL,
  `Person_PersonID` int(11) NOT NULL,
  PRIMARY KEY (`RegistrationID`,`Events_EventID`,`Person_PersonID`),
  KEY `fk_Registrations2017_Events1_idx` (`Events_EventID`),
  KEY `fk_Registrations2017_Person1_idx` (`Person_PersonID`),
  CONSTRAINT `fk_Registrations2017_Events1` FOREIGN KEY (`Events_EventID`) REFERENCES `events` (`EventID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registrations2017_Person1` FOREIGN KEY (`Person_PersonID`) REFERENCES `person` (`PersonID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registrations_2017`
--

LOCK TABLES `registrations_2017` WRITE;
/*!40000 ALTER TABLE `registrations_2017` DISABLE KEYS */;
INSERT INTO `registrations_2017` VALUES (39,'2017-02-27 08:43:43','1fcf975485f21c70','2017-02-27 08:43:43',1,99),(40,'2017-03-16 16:37:20','56e9e679334d5640','2017-03-16 16:37:20',1,110),(41,'2017-03-20 20:22:12','51bfec8857853e40','2017-03-20 20:22:12',1,116),(42,'2017-03-23 12:09:08','e14bda79eef17cf0','2017-03-23 12:09:08',1,122),(43,'2017-03-28 20:47:47','4dce8248b256e365','2017-03-28 20:47:46',1,127),(44,'2017-03-31 14:18:07','51df407fcbbcbb20','2017-03-31 14:18:06',1,130),(45,'2017-04-03 20:37:18','27659b6b9f8fdb79','2017-04-03 20:37:17',1,132),(46,'2017-04-14 08:45:51','ad47a92512520e2b','2017-04-14 08:45:51',1,146),(47,'2017-04-18 11:40:10','aa605a54f8d27f8','2017-04-18 11:40:09',1,160),(48,'2017-04-18 12:30:59','7e200376a1c006eb','2017-04-18 12:30:59',1,162),(49,'2017-04-18 18:43:57','feb035b25eb89c4','2017-04-18 18:43:56',1,140),(50,'2017-04-19 21:40:45','e9065aad995d152e','2017-04-19 21:40:45',1,106),(51,'2017-04-20 09:20:27','de81e4f479318957','2017-04-20 09:20:26',1,174),(52,'2017-04-20 09:21:04','cbc716f06e9adc35','2017-04-20 09:21:03',1,175),(53,'2017-04-20 10:36:50','f8c7fbdacaa5e91c','2017-04-20 10:36:50',1,149),(54,'2017-04-20 21:14:04','58269704815d086','2017-04-20 21:14:04',1,166),(55,'2017-04-22 08:18:38','a070d2649ec66512','2017-04-22 08:18:38',1,182),(56,'2017-04-23 18:52:11','bdf8881a5a08bd31','2017-04-23 18:52:10',1,187),(57,'2017-04-24 08:44:38','cb3fbb9b97cdacc7','2017-04-24 08:44:38',1,191),(58,'2017-04-24 09:05:46','6c7de4b7dd9bc755','2017-04-24 09:05:46',1,184),(59,'2017-04-25 12:46:17','547c3f7c2070863d','2017-04-25 12:46:17',1,194),(60,'2017-04-25 13:40:30','bc6fe9e9dc400e2f','2017-04-25 13:40:30',1,196),(61,'2017-04-26 07:16:52','a481dc0a5c8de801','2017-04-26 07:16:52',1,201),(62,'2017-04-26 07:17:12','ee6b86bbbc1aa5ce','2017-04-26 07:17:12',1,202),(63,'2017-04-26 07:17:25','1db49497ebdc0e8a','2017-04-26 07:17:25',1,203),(64,'2017-04-26 19:17:16','c60b6b25267b0e95','2017-04-26 19:17:15',1,210),(65,'2017-04-27 20:39:22','6c9e7a40a4f1fac9','2017-04-27 20:39:22',1,134),(66,'2017-04-30 13:58:28','d6ba2ff42ee6cf2a','2017-04-30 13:58:28',1,223),(67,'2017-05-01 17:43:03','5ea3c23685fcf5bb','2017-05-01 17:43:02',1,230),(68,'2017-05-01 20:14:23','a3779049a36cc94d','2017-05-01 20:14:23',1,232),(69,'2017-05-01 22:14:06','46e5327b078a84b2','2017-05-01 22:14:06',1,228),(70,'2017-05-02 04:29:49','51374b62a74b4b5c','2017-05-02 04:29:48',1,144),(71,'2017-05-03 09:07:50','b535b4839ecc8f32','2017-05-03 09:07:50',1,235),(72,'2017-05-03 09:08:53','9070d4cbdc526fb6','2017-05-03 09:08:52',1,236),(74,'2017-05-05 06:07:46','f60079e2412bb935','2017-05-05 06:07:46',1,260),(75,'2017-05-05 11:30:31','912774789a185e5d','2017-05-05 11:30:31',1,265),(76,'2017-05-06 18:58:53','d7faa6ef8587d356','2017-05-06 18:58:52',1,271),(77,'2017-05-06 19:47:12','c427904bad0c781c','2017-05-06 19:47:11',1,272),(78,'2017-05-06 20:28:23','984da599a3bd2676','2017-05-06 20:28:23',1,276),(79,'2017-05-07 02:08:01','b81391b5a1db076c','2017-05-07 02:08:01',1,278),(80,'2017-05-07 22:27:51','52a4e642e41ddbc2','2017-05-07 22:27:51',1,291),(81,'2017-05-07 22:36:06','ffdc6fd361952c53','2017-05-07 22:36:05',1,155),(82,'2017-05-07 22:36:48','7e98e28dbb8154c6','2017-05-07 22:36:47',1,292),(83,'2017-05-08 07:01:12','1c43e79883dc387e','2017-05-08 07:01:12',1,295),(84,'2017-05-08 09:04:31','722d3130187c2b91','2017-05-08 09:04:30',1,249),(85,'2017-05-08 09:04:49','dddc4fb04a9aa43e','2017-05-08 09:04:49',1,274),(86,'2017-05-08 10:10:25','1829ac99826a962c','2017-05-08 10:10:25',1,300),(87,'2017-05-08 11:10:37','6ab7a5fb82782e04','2017-05-08 11:10:37',1,305),(88,'2017-05-08 13:08:44','6ac7cf8761de5dc8','2017-05-08 13:08:43',1,303),(89,'2017-05-08 15:49:34','7ed49f06b928c27b','2017-05-08 15:49:34',1,307),(90,'2017-05-08 15:56:14','776e81d876872474','2017-05-08 15:56:14',1,309),(91,'2017-05-08 15:58:52','7cebbea5b8ae5e8a','2017-05-08 15:58:51',1,310),(92,'2017-05-08 19:42:49','f29308f6323fa111','2017-05-08 19:42:48',1,245),(93,'2017-05-08 19:43:56','139373b685e8700f','2017-05-08 19:43:56',1,244),(94,'2017-05-08 19:44:38','d4bbb853ffac3c12','2017-05-08 19:44:37',1,246),(95,'2017-05-08 19:47:09','f2b44e1c01b60347','2017-05-08 19:47:09',1,219),(96,'2017-05-08 19:50:05','e5012bb0473508ad','2017-05-08 19:50:04',1,257),(97,'2017-05-08 20:29:55','3ba4b9f97a823122','2017-05-08 20:29:54',1,321),(98,'2017-05-08 20:46:24','75c96a3546b091a4','2017-05-08 20:46:24',1,254),(99,'2017-05-08 21:21:50','d0867d97e7ce3dce','2017-05-08 21:21:50',1,326),(100,'2017-05-08 22:07:36','8044431f86332e26','2017-05-08 22:07:36',1,247),(101,'2017-05-09 19:40:29','58bddb840e9f38a0','2017-05-09 19:40:29',1,212),(102,'2017-05-09 19:40:49','8840659529c15b11','2017-05-09 19:40:49',1,280),(103,'2017-05-09 19:41:06','2280d674f6455a88','2017-05-09 19:41:06',1,318),(104,'2017-05-09 19:41:23','6cb7b4a38b6a8905','2017-05-09 19:41:23',1,319),(105,'2017-05-09 19:41:41','862f737d75611bb3','2017-05-09 19:41:41',1,215),(106,'2017-05-09 19:41:54','932ba3aabf3860c2','2017-05-09 19:41:53',1,168),(107,'2017-05-09 19:42:12','3b6da785a0720245','2017-05-09 19:42:11',1,169),(108,'2017-05-09 19:42:25','e86b6096c8861771','2017-05-09 19:42:24',1,217),(109,'2017-05-09 19:42:42','d6877b74b4a5de98','2017-05-09 19:42:42',1,221),(110,'2017-05-09 19:42:59','e5550bf4244fc005','2017-05-09 19:42:58',1,242),(111,'2017-05-09 19:43:11','be568a70f0370a9d','2017-05-09 19:43:10',1,288),(112,'2017-05-09 19:43:24','b0c1526822e96912','2017-05-09 19:43:23',1,289),(113,'2017-05-09 19:43:36','ca224a6fa9611481','2017-05-09 19:43:35',1,297),(114,'2017-05-09 19:43:49','e0b03df77d0685c9','2017-05-09 19:43:48',1,298),(116,'2017-05-09 19:44:43','c69cdd7c66c72d93','2017-05-09 19:44:42',1,120),(117,'2017-05-09 19:45:11','1fb074ce35b6ef6a','2017-05-09 19:45:11',1,266),(118,'2017-05-09 19:45:30','a990d7483288dbc5','2017-05-09 19:45:30',1,269),(119,'2017-05-09 19:45:52','41e8a5567817011e','2017-05-09 19:45:51',1,282),(120,'2017-05-09 19:46:07','1c4ddded1e36fade','2017-05-09 19:46:07',1,198),(121,'2017-05-09 19:46:20','fa7d70429bf3e953','2017-05-09 19:46:19',1,328),(122,'2017-05-09 19:46:35','9534590c75836591','2017-05-09 19:46:34',1,329),(123,'2017-05-12 15:54:21','9ab2c17c97668dd2','2017-05-12 15:54:21',1,334),(124,'2017-05-13 19:00:20','9ae32674027154d1','2017-05-13 19:00:19',1,338),(125,'2017-05-15 15:39:06','cc08976633fd2f15','2017-05-15 15:39:06',1,339),(126,'2017-05-15 20:13:06','6f4f27ea1eaef082','2017-05-15 20:13:06',1,346),(127,'2017-05-15 21:17:48','472793c0d8b1f22a','2017-05-15 21:17:48',1,347);
/*!40000 ALTER TABLE `registrations_2017` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservations` (
  `ReservationID` int(11) NOT NULL AUTO_INCREMENT,
  `ReservationDate` datetime NOT NULL,
  `LastUpdated` datetime NOT NULL,
  `Events_EventID` int(11) NOT NULL,
  `Person_PersonID` int(11) NOT NULL,
  `RegistrationCode` varchar(64) DEFAULT NULL,
  `CodeExpiration` datetime DEFAULT NULL,
  PRIMARY KEY (`ReservationID`,`Events_EventID`,`Person_PersonID`),
  UNIQUE KEY `RegistrationCode_UNIQUE` (`RegistrationCode`),
  KEY `fk_Reservations_Events1_idx` (`Events_EventID`),
  KEY `fk_Reservations_Person1_idx` (`Person_PersonID`),
  CONSTRAINT `fk_Reservations_Events1` FOREIGN KEY (`Events_EventID`) REFERENCES `events` (`EventID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservations_Person1` FOREIGN KEY (`Person_PersonID`) REFERENCES `person` (`PersonID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (97,'2018-03-19 22:02:07','2018-05-09 13:10:31',1,396,'1a0beb2f21b30aed','2018-05-11 13:10:31'),(98,'2018-03-20 08:46:59','2018-05-09 13:10:31',1,398,'91ffbc5a46660aed','2018-05-11 13:10:31'),(102,'2018-03-27 20:37:31','2018-03-27 20:37:30',1,404,NULL,NULL),(119,'2018-04-22 22:06:05','2018-04-22 22:06:04',1,436,NULL,NULL),(131,'2018-04-24 11:36:23','2018-04-24 11:36:50',1,310,'f3d7b8bae9dfc060','2018-04-26 11:36:50'),(137,'2018-04-26 21:31:31','2018-04-26 21:31:31',1,451,NULL,NULL),(138,'2018-04-30 20:12:02','2018-04-30 20:12:01',1,457,NULL,NULL),(139,'2018-05-02 09:35:44','2018-05-02 09:35:44',1,468,NULL,NULL),(145,'2018-05-04 11:00:24','2018-05-04 11:00:23',1,490,NULL,NULL),(148,'2018-05-06 20:50:12','2018-05-07 11:08:42',1,498,'ede1ed9e670cf798','2018-05-09 11:08:42'),(149,'2018-05-06 20:50:43','2018-05-07 11:08:42',1,499,'1f2910c8aaa95f98','2018-05-09 11:08:42'),(150,'2018-05-07 12:51:06','2018-05-07 12:51:05',1,495,NULL,NULL),(152,'2018-05-09 07:29:16','2018-05-09 07:29:15',1,449,NULL,NULL),(154,'2018-05-09 11:06:59','2018-05-09 13:10:31',1,507,'fc3b1e4a4a3b0aed','2018-05-11 13:10:31'),(155,'2018-05-09 12:03:57','2018-05-09 12:03:56',1,447,NULL,NULL),(157,'2018-05-09 21:41:48','2018-05-09 21:41:47',1,254,NULL,NULL),(158,'2018-05-09 21:42:25','2018-05-09 21:42:24',1,255,NULL,NULL),(159,'2018-05-10 09:56:00','2018-05-10 09:56:00',1,228,NULL,NULL),(160,'2018-05-10 10:00:37','2018-05-10 10:00:37',1,513,NULL,NULL),(161,'2018-05-10 10:00:59','2018-05-10 10:00:59',1,514,NULL,NULL),(162,'2018-05-10 15:41:21','2018-05-10 15:41:21',1,515,NULL,NULL),(163,'2018-05-10 19:41:03','2018-05-10 19:41:03',1,517,NULL,NULL),(164,'2018-05-10 21:52:12','2018-05-10 21:52:12',1,522,NULL,NULL),(165,'2018-05-10 21:52:53','2018-05-10 21:52:53',1,520,NULL,NULL),(166,'2018-05-11 09:05:18','2018-05-11 09:05:18',1,523,NULL,NULL);
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitranks`
--

DROP TABLE IF EXISTS `unitranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitranks` (
  `UnitRankID` int(11) NOT NULL AUTO_INCREMENT,
  `UnitRank` varchar(45) NOT NULL,
  `unittypes_UnitTypeID` int(11) NOT NULL,
  PRIMARY KEY (`UnitRankID`,`unittypes_UnitTypeID`),
  KEY `fk_unitranks_unittypes1_idx` (`unittypes_UnitTypeID`),
  CONSTRAINT `fk_unitranks_unittypes1` FOREIGN KEY (`unittypes_UnitTypeID`) REFERENCES `unittypes` (`UnitTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitranks`
--

LOCK TABLES `unitranks` WRITE;
/*!40000 ALTER TABLE `unitranks` DISABLE KEYS */;
INSERT INTO `unitranks` VALUES (-1,'NaN',-1),(2,'Tiger',1),(3,'Wolf',1),(4,'Bear',1),(5,'Webelos',1),(6,'Arrow of Light',1),(7,'Scout',2),(8,'Tenderfoot',2),(9,'First Class',2),(10,'Second Class',2),(11,'Star',2),(12,'Life',2),(13,'Eagle',2),(14,'Crew Member',3),(15,'Team Member',4),(16,'Sibling',1),(17,'Sibling',2),(18,'Sibling',3),(19,'Sibling',4);
/*!40000 ALTER TABLE `unitranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `UnitID` int(11) NOT NULL AUTO_INCREMENT,
  `UnitNumber` int(11) NOT NULL,
  `unittypes_UnitTypeID` int(11) NOT NULL,
  PRIMARY KEY (`UnitID`,`UnitNumber`,`unittypes_UnitTypeID`),
  UNIQUE KEY `UnitNumber_UNIQUE` (`UnitNumber`,`unittypes_UnitTypeID`),
  KEY `fk_units_unittypes1_idx` (`unittypes_UnitTypeID`),
  CONSTRAINT `fk_units_unittypes1` FOREIGN KEY (`unittypes_UnitTypeID`) REFERENCES `unittypes` (`UnitTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='Table of Unit groupings for organization of people.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (-1,0,-1),(1,31,1),(2,33,1),(3,108,1),(4,109,1),(5,130,1),(6,132,1),(7,133,1),(8,139,1),(9,161,1),(10,216,1),(11,219,1),(12,236,1),(13,237,1),(14,250,1),(15,255,1),(16,275,1),(17,276,1),(18,277,1),(19,316,1),(20,333,1),(21,349,1),(22,365,1),(23,376,1),(24,422,1),(25,476,1),(26,540,1),(27,832,1),(28,925,1),(29,1280,1),(30,1830,1),(31,1860,1),(32,1861,1),(33,31,2),(34,33,2),(35,37,2),(36,38,2),(37,108,2),(38,109,2),(39,130,2),(40,132,2),(41,133,2),(42,137,2),(43,140,2),(44,161,2),(45,219,2),(46,236,2),(47,250,2),(48,255,2),(49,275,2),(50,276,2),(51,277,2),(52,316,2),(53,323,2),(54,333,2),(55,349,2),(56,365,2),(57,376,2),(58,422,2),(59,476,2),(60,540,2),(61,832,2),(62,925,2),(63,1280,2),(64,250,3),(64,255,3),(64,275,3),(64,276,3),(64,376,3),(64,422,3),(64,1110,3),(64,4213,3),(64,276,4),(64,376,4);
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unittypes`
--

DROP TABLE IF EXISTS `unittypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unittypes` (
  `UnitTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `UnitType` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UnitTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unittypes`
--

LOCK TABLES `unittypes` WRITE;
/*!40000 ALTER TABLE `unittypes` DISABLE KEYS */;
INSERT INTO `unittypes` VALUES (-1,'NaN'),(1,'Pack'),(2,'Troop'),(3,'Crew'),(4,'Team');
/*!40000 ALTER TABLE `unittypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venue`
--

DROP TABLE IF EXISTS `venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venue` (
  `VenueID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(60) NOT NULL,
  `Contact` varchar(45) DEFAULT NULL,
  `contactinfo_ContactInfoID` int(11) NOT NULL,
  PRIMARY KEY (`VenueID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venue`
--

LOCK TABLES `venue` WRITE;
/*!40000 ALTER TABLE `venue` DISABLE KEYS */;
INSERT INTO `venue` VALUES (1,'Bethelwoods Camp and Conference Center','TBD',1);
/*!40000 ALTER TABLE `venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'events'
--
/*!50003 DROP PROCEDURE IF EXISTS `delContactInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delContactInfo`(IN pContactInfoID INT)
BEGIN
DELETE FROM `events`.`contactinfo`
WHERE ContactInfoID = pContactInfoID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delEvent`(IN pEventID INT)
BEGIN
DELETE FROM `events`.`events`
WHERE EventID = pEventID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delEventStaff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delEventStaff`(IN pEventStaffID INT)
BEGIN
DELETE FROM `events`.`eventstaff`
WHERE EventStaffID = pEventStaffID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delEventType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delEventType`(IN pEventTypeID INT)
BEGIN
DELETE FROM `events`.`eventtypes`
WHERE EventTypeID = pEventTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delEventVolunteers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delEventVolunteers`(IN pEventVolunteerID INT)
BEGIN
DELETE FROM `events`.`eventvolunteers`
WHERE EventVolunteerID = pEventVolunteerID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPerson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delPerson`(IN pPersonID INT)
BEGIN
DELETE FROM `events`.`person`
WHERE PersonID = pPersonID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPersonType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delPersonType`(IN pPersonTypeID INT)
BEGIN

-- All objects that reference that row (directly or indirectly) will be deleted when this snippet is executed.
-- To preview the rows to be deleted, use Select Row Dependencies
START TRANSACTION;
-- Provide the values of the primary key of the row to delete.
SET @PersonTypeID_to_delete = pPersonTypeID;

DELETE FROM persontypes
    USING persontypes
    WHERE persontypes.PersonTypeID = @PersonTypeID_to_delete;
COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delPosition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delPosition`(IN pPositionID INT)
BEGIN
DELETE FROM `events`.`positions`
WHERE PositionID = pPositionID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delRegistration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delRegistration`(IN pRegistrationID INT)
BEGIN
DELETE FROM `events`.`registrations`
WHERE RegistrationID = pRegistrationID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delReservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delReservation`(IN pReservationID INT)
BEGIN
DELETE FROM `events`.`reservations`
WHERE ReservationID = pReservationID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delUnit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delUnit`(IN pUnitID INT)
BEGIN
DELETE FROM `events`.`units`
WHERE UnitID = pUnitID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delUnitRank` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delUnitRank`(IN pUnitRankID INT)
BEGIN
DELETE FROM `events`.`unitranks`
WHERE UnitRankID = pUnitRankID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delUnitType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delUnitType`(IN pUnitTypeID INT)
BEGIN
	DELETE FROM `events`.`unittypes`
WHERE UnitTypeID = pUnitTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `delVenue`(IN pVenueID INT)
BEGIN
DELETE FROM `events`.`venue`
WHERE VenueID = pVenueID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insContactInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insContactInfo`(IN pContactName VARCHAR(45)
									, IN pHomePhone VARCHAR(15)
                                    , IN pCellPhone VARCHAR(15)
                                    , IN pEmail VARCHAR(45)
                                    , IN pAddress1 VARCHAR(50)
                                    , IN pAddress2 VARCHAR(50)
                                    , IN pCity VARCHAR(45)
                                    , IN pState VARCHAR(2)
                                    , IN pZip VARCHAR(10)
                                    , OUT oContactInfoID INT)
BEGIN
INSERT INTO `events`.`contactinfo`
(`ContactName`,
`HomePhone`,
`CellPhone`,
`Email`,
`Address1`,
`Address2`,
`City`,
`State`,
`Zip`)
VALUES
(pContactName
,pHomePhone
,pCellPhone
,pEmail
,pAddress1
,pAddress2
,pCity
,pState
,pZip);

SELECT LAST_INSERT_ID() INTO oContactInfoID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insEvent`(IN pVenueID INT
							 , IN pEventName VARCHAR(100)
                             , IN pEventStart DATETIME
                             , IN pEventEnd DATETIME
                             , IN pEventDescription VARCHAR(2000)
                             , IN pEventTypeID INT
                             , IN pStaffPaymentRequired BIT
                             , IN pRegistrationDeadline DATETIME
                             , IN pRequiredStaff INT
                             , IN pRequiredVolunteers INT
							 , OUT oEventID INT)
BEGIN
INSERT INTO `events`.`events`
(`VenueID`,
`EventName`,
`EventStart`,
`EventEnd`,
`EventDescription`,
`LastUpdate`,
`EventTypes_EventTypeID`,
`StaffPaymentRequired`,
`RegistrationDeadline`,
`RequiredStaff`,
`RequiredVolunteers`)
VALUES
(pVenueID
 , pEventName
 , pEventStart
 , pEventEnd
 , pEventDescription
 , SYSDATE() 
 , pEventTypeID
 , pStaffPaymentRequired
 , pRegistrationDeadline
 , pRequiredStaff
 , pRequiredVolunteers);

SELECT LAST_INSERT_ID() INTO oEventID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insEventStaff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insEventStaff`( IN pPositionID INT
									, IN pEventID INT
                                    , IN pPersonID INT
                                    ,OUT oEventStaffID INT)
BEGIN
INSERT INTO `events`.`eventstaff`
(`LastUpdated`,
`positions_PositionID`,
`events_EventID`,
`person_PersonID`)
VALUES
(SYSDATE()
, pPositionID
, pEventID
, pPersonID);

SELECT LAST_INSERT_ID() INTO oEventStaffID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insEventType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insEventType`(IN pEventType VARCHAR(45), OUT oEventTypeID INT)
BEGIN
INSERT INTO `events`.`eventtypes`
(`EventType`)
VALUES
(pEventType);

SELECT LAST_INSERT_ID() INTO oEventTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insEventVolunteer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insEventVolunteer`(IN pEventID INT
                                                                , IN pPersonID INT
                                                                , IN pvolunteerDays INT
                                                                , IN pMondayVol VARCHAR(1)
                                                                , IN pTuesdayVol VARCHAR(1)
                                                                , IN pWednesdayVol VARCHAR(1)
                                                                , IN pThursdayVol VARCHAR(1)
                                                                , IN pFridayVol VARCHAR(1)
                                                                , IN pSaturdayVol VARCHAR(1)
                                                                , IN pSundayVol VARCHAR(1)
                                                                , OUT oEventVolunteerID INT)
BEGIN
INSERT INTO `events`.`eventvolunteers`
(`LastUpdated`,
`events_EventID`,
`person_PersonID`,
`volunteerDays`,
`MondayVol`,
`TuesdayVol`,
`WednesdayVol`,
`ThursdayVol`,
`FridayVol`,
`SaturdayVol`,
`SundayVol`)
VALUES
(SYSDATE(),
pEventID,
pPersonID,
pvolunteerDays,
pMondayVol,
pTuesdayVol,
pWednesdayVol,
pThursdayVol,
pFridayVol,
pSaturdayVol,
pSundayVol);

SELECT LAST_INSERT_ID() INTO oEventVolunteerID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPerson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insPerson`(IN pFirstName VARCHAR(45)
							   , IN pMiddleName VARCHAR(45)
                               , IN pLastName VARCHAR(45)
                               , IN pContactInfoID INT
                               , IN pParentPersonID INT
                               , IN pPersonTypeID INT
                               , IN pUnitRankID INT
                               , IN pUnitID INT
                               , IN pUserID VARCHAR(45)
                               , IN pNotes VARCHAR(4000)
                               , IN pBirthDate DATE
							   , OUT oPersonID INT)
BEGIN
INSERT INTO `events`.`person`
(`FirstName`,
`MiddleName`,
`LastName`,
`LastUpdate`,
`contactInfo_ContactInfoID`,
`ParentPersonID`,
`persontype_PersonTypeID`,
`unitranks_UnitRankID`,
`units_UnitID`,
`user_id`,
`Notes`,
`BirthDate`)
VALUES
(pFirstName
,pMiddleName
,pLastName
,SYSDATE()
,pContactInfoID
,pParentPersonID
,pPersonTypeID
,pUnitRankID
,pUnitID
,pUserID
,pNotes
,pBirthDate);

SELECT LAST_INSERT_ID() INTO oPersonID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPersonType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insPersonType`(IN pPersonType VARCHAR(45), OUT oPersonTypeID INT)
BEGIN

INSERT INTO `events`.persontypes
	(PersonType)
	VALUES
	(pPersonType);
    
SELECT LAST_INSERT_ID() into oPersonTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insPosition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insPosition`(IN pPosition VARCHAR(45), OUT oPositionID INT)
BEGIN
INSERT INTO `events`.`positions`
(`Position`)
VALUES
(pPosition);

SELECT LAST_INSERT_ID() INTO oPositionID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insRegistration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insRegistration`(IN pRegistrationDate DATETIME
									, IN pConfirmation VARCHAR(64)
                                    , IN pEventID INT
                                    , IN pPersonID INT
									, OUT pRegistrationID INT)
BEGIN
INSERT INTO `events`.`registrations`
(`RegistrationDate`,
`Confirmation`,
`LastUpdated`,
`Events_EventID`,
`Person_PersonID`)
VALUES
(pRegistrationDate,
 pConfirmation,
 SYSDATE(),
 pEventID,
 pPersonID);

SELECT LAST_INSERT_ID() INTO pRegistrationID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insReservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insReservation`( IN pReservationDate DATETIME
									, IN pEventID INT
									, IN pPersonID INT
									, OUT oReservationID INT)
BEGIN
INSERT INTO `events`.`reservations`
(`ReservationDate`,
`LastUpdated`,
`Events_EventID`,
`Person_PersonID`)
VALUES
(pReservationDate,
  SYSDATE(),
pEventID,
pPersonID);

SELECT LAST_INSERT_ID() INTO oReservationID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insUnit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insUnit`(IN pUnitNumber INT, IN pUnitTypeID INT, OUT oUnitID INT)
BEGIN
INSERT INTO `events`.`units`
(`UnitNumber`,
`unittypes_UnitTypeID`)
VALUES
(pUnitNumber,
pUnitTypeID);

SELECT LAST_INSERT_ID() INTO oUnitID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insUnitRank` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insUnitRank`(IN pUnitRank VARCHAR(45), IN pUnitTypeID INT, OUT oUnitRankID INT)
BEGIN
INSERT INTO `events`.`unitranks`
(`UnitRank`,
`unittypes_UnitTypeID`)
VALUES
(pUnitRank,
 pUnitTypeID);

SELECT LAST_INSERT_ID() INTO oUnitRankID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insUnitType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insUnitType`(IN pUnitType VARCHAR(45), OUT oUnitTypeID INT)
BEGIN
INSERT INTO `events`.`unittypes`
(`UnitType`)
VALUES
(pUnitType);

SELECT LAST_INSERT_ID() into oUnitTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `insVenue`(IN pName VARCHAR(60)

							  , IN pContact VARCHAR(45)

                              , IN pContactInfoID int

                              , OUT oVenueID INT)
BEGIN

INSERT INTO `events`.`venue`

(`Name`,

`Contact`,

`contactinfo_ContactInfoID`)

VALUES

(pName,

pContact,

pContactInfoID);



SELECT LAST_INSERT_ID() INTO oVenueID;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selContactInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selContactInfo`()
BEGIN
SELECT `contactinfo`.`ContactInfoID`,
    `contactinfo`.`ContactName`,
    `contactinfo`.`HomePhone`,
    `contactinfo`.`CellPhone`,
    `contactinfo`.`Email`,
    `contactinfo`.`Address1`,
    `contactinfo`.`Address2`,
    `contactinfo`.`City`,
    `contactinfo`.`State`,
    `contactinfo`.`Zip`
FROM `events`.`contactinfo`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selContactInfoByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selContactInfoByID`(IN pContactInfoID INT)
BEGIN
SELECT `contactinfo`.`ContactInfoID`,
    `contactinfo`.`ContactName`,
    `contactinfo`.`HomePhone`,
    `contactinfo`.`CellPhone`,
    `contactinfo`.`Email`,
    `contactinfo`.`Address1`,
    `contactinfo`.`Address2`,
    `contactinfo`.`City`,
    `contactinfo`.`State`,
    `contactinfo`.`Zip`
FROM `events`.`contactinfo`
WHERE ContactInfoID = pContactInfoID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selEventByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selEventByID`(IN pEventID INT)
BEGIN
SELECT `events`.`EventID`,
    `events`.`VenueID`,
    `events`.`EventName`,
    `events`.`EventStart`,
    `events`.`EventEnd`,
    `events`.`EventDescription`,
    `events`.`LastUpdate`,
    `events`.`EventTypes_EventTypeID`,
    `events`.`StaffPaymentRequired`,
    `events`.`RegistrationDeadline`,
    `events`.`RequiredStaff`,
    `events`.`RequiredVolunteers`
FROM `events`.`events`
WHERE EventID = pEventID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selEvents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selEvents`()
BEGIN
SELECT `events`.`EventID`,
    `events`.`VenueID`,
    `events`.`EventName`,
    `events`.`EventStart`,
    `events`.`EventEnd`,
    `events`.`EventDescription`,
    `events`.`LastUpdate`,
    `events`.`EventTypes_EventTypeID`,
    `events`.`StaffPaymentRequired`,
    `events`.`RegistrationDeadline`,
    `events`.`RequiredStaff`,
    `events`.`RequiredVolunteers`
FROM `events`.`events`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selEventStaff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selEventStaff`()
BEGIN
SELECT `eventstaff`.`EventStaffID`,
    `eventstaff`.`LastUpdated`,
    `eventstaff`.`positions_PositionID`,
    `eventstaff`.`events_EventID`,
    `eventstaff`.`person_PersonID`
FROM `events`.`eventstaff`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selEventStaffByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selEventStaffByID`(IN pEventStaffID INT)
BEGIN
SELECT `eventstaff`.`EventStaffID`,
    `eventstaff`.`LastUpdated`,
    `eventstaff`.`positions_PositionID`,
    `eventstaff`.`events_EventID`,
    `eventstaff`.`person_PersonID`
FROM `events`.`eventstaff`
WHERE EventStaffID = pEventStaffID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selEventTypeByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selEventTypeByID`(IN pEventTypeID INT)
BEGIN
SELECT `eventtypes`.`EventTypeID`,
    `eventtypes`.`EventType`
FROM `events`.`eventtypes`
WHERE EventTypeID = pEventTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selEventTypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selEventTypes`()
BEGIN
SELECT `eventtypes`.`EventTypeID`,
    `eventtypes`.`EventType`
FROM `events`.`eventtypes`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selEventVolunteerByEventID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selEventVolunteerByEventID`(IN pEventID INT)
BEGIN
SELECT `eventvolunteers`.`EventVolunteerID`,
    `eventvolunteers`.`LastUpdated`,
    `eventvolunteers`.`events_EventID`,
    `eventvolunteers`.`person_PersonID`,
    `eventvolunteers`.`volunteerDays`,
    `eventvolunteers`.`MondayVol`,
    `eventvolunteers`.`TuesdayVol`,
    `eventvolunteers`.`WednesdayVol`,
    `eventvolunteers`.`ThursdayVol`,
    `eventvolunteers`.`FridayVol`,
    `eventvolunteers`.`SaturdayVol`,
    `eventvolunteers`.`SundayVol`
FROM `events`.`eventvolunteers`
WHERE events_EventID = pEventID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selEventVolunteerByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selEventVolunteerByID`(IN pEventVolunteerID INT)
BEGIN
SELECT `eventvolunteers`.`EventVolunteerID`,
    `eventvolunteers`.`LastUpdated`,
    `eventvolunteers`.`events_EventID`,
    `eventvolunteers`.`person_PersonID`,
    `eventvolunteers`.`volunteerDays`,
    `eventvolunteers`.`MondayVol`,
    `eventvolunteers`.`TuesdayVol`,
    `eventvolunteers`.`WednesdayVol`,
    `eventvolunteers`.`ThursdayVol`,
    `eventvolunteers`.`FridayVol`,
    `eventvolunteers`.`SaturdayVol`,
    `eventvolunteers`.`SundayVol`
FROM `events`.`eventvolunteers`
WHERE EventVolunteerID = pEventVolunteerID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selEventVolunteers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selEventVolunteers`()
BEGIN
SELECT `eventvolunteers`.`EventVolunteerID`,
    `eventvolunteers`.`LastUpdated`,
    `eventvolunteers`.`events_EventID`,
    `eventvolunteers`.`person_PersonID`,
    `eventvolunteers`.`volunteerDays`,
    `eventvolunteers`.`MondayVol`,
    `eventvolunteers`.`TuesdayVol`,
    `eventvolunteers`.`WednesdayVol`,
    `eventvolunteers`.`ThursdayVol`,
    `eventvolunteers`.`FridayVol`,
    `eventvolunteers`.`SaturdayVol`,
    `eventvolunteers`.`SundayVol`
FROM `events`.`eventvolunteers`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selPersonByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selPersonByID`(IN pPersonID INT)
BEGIN
SELECT `person`.`PersonID`,
    `person`.`FirstName`,
    `person`.`MiddleName`,
    `person`.`LastName`,
    `person`.`LastUpdate`,
    `person`.`contactInfo_ContactInfoID`,
    `person`.`ParentPersonID`,
    `person`.`persontype_PersonTypeID`,
    `person`.`unitranks_UnitRankID`,
    `person`.`units_UnitID`,
    `person`.`user_id`,
    `person`.`Notes`,
    `person`.`BirthDate`
FROM `events`.`person`
WHERE PersonID = pPersonID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selPersonByParentID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selPersonByParentID`(IN pParentID INT)
BEGIN

SELECT `person`.`PersonID`,
    `person`.`FirstName`,
    `person`.`MiddleName`,
    `person`.`LastName`,
    `person`.`LastUpdate`,
    `person`.`contactInfo_ContactInfoID`,
    `person`.`ParentPersonID`,
    `person`.`persontype_PersonTypeID`,
    `person`.`unitranks_UnitRankID`,
    `person`.`units_UnitID`,
    `person`.`user_id`,
    `person`.`Notes`,
    `person`.`BirthDate`
FROM `events`.`person`
WHERE ParentPersonID = pParentID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selPersonByUserId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selPersonByUserId`(IN pUserId VARCHAR(45))
BEGIN
SELECT `person`.`PersonID`,
    `person`.`FirstName`,
    `person`.`MiddleName`,
    `person`.`LastName`,
    `person`.`LastUpdate`,
    `person`.`contactInfo_ContactInfoID`,
    `person`.`ParentPersonID`,
    `person`.`persontype_PersonTypeID`,
    `person`.`unitranks_UnitRankID`,
    `person`.`units_UnitID`,
    `person`.`user_id`,
    `person`.`Notes`,
    `person`.`BirthDate`
FROM `events`.`person`
WHERE user_id = pUserID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selPersons` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selPersons`()
BEGIN
SELECT `person`.`PersonID`,
    `person`.`FirstName`,
    `person`.`MiddleName`,
    `person`.`LastName`,
    `person`.`LastUpdate`,
    `person`.`contactInfo_ContactInfoID`,
    `person`.`ParentPersonID`,
    `person`.`persontype_PersonTypeID`,
    `person`.`unitranks_UnitRankID`,
    `person`.`units_UnitID`,
    `person`.`user_id`,
    `person`.`Notes`,
    `person`.`BirthDate`
FROM `events`.`person`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selPersonType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selPersonType`()
BEGIN

SELECT persontypes.`PersonTypeID`,
    persontypes.`PersonType`
FROM `events`.persontypes;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selPersonTypeByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selPersonTypeByID`(IN pPersonTypeID INT)
BEGIN
SELECT persontypes.PersonTypeID,
    persontypes.PersonType
FROM `events`.persontypes
WHERE persontypes.PersonTypeID = pPersonTypeID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selPositionByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selPositionByID`(IN pPositionID INT)
BEGIN
SELECT `positions`.`PositionID`,
    `positions`.`Position`
FROM `events`.`positions`
WHERE PositionID = pPositionID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selPositions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selPositions`()
BEGIN
SELECT `positions`.`PositionID`,
    `positions`.`Position`
FROM `events`.`positions`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selRegistrationByEventID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selRegistrationByEventID`(IN pEventID INT)
BEGIN
SELECT `registrations`.`RegistrationID`,
    `registrations`.`RegistrationDate`,
    `registrations`.`Confirmation`,
    `registrations`.`LastUpdated`,
    `registrations`.`Events_EventID`,
    `registrations`.`Person_PersonID`
FROM `events`.`registrations`
WHERE Events_EventID = pEventID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selRegistrationByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selRegistrationByID`(IN pRegistrationID INT)
BEGIN
SELECT `registrations`.`RegistrationID`,
    `registrations`.`RegistrationDate`,
    `registrations`.`Confirmation`,
    `registrations`.`LastUpdated`,
    `registrations`.`Events_EventID`,
    `registrations`.`Person_PersonID`
FROM `events`.`registrations`
WHERE RegistrationID = pRegistrationID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selRegistrations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selRegistrations`()
BEGIN
SELECT `registrations`.`RegistrationID`,
    `registrations`.`RegistrationDate`,
    `registrations`.`Confirmation`,
    `registrations`.`LastUpdated`,
    `registrations`.`Events_EventID`,
    `registrations`.`Person_PersonID`
FROM `events`.`registrations`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selReservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selReservation`()
BEGIN
SELECT `reservations`.`ReservationID`,
    `reservations`.`ReservationDate`,
    `reservations`.`LastUpdated`,
    `reservations`.`Events_EventID`,
    `reservations`.`Person_PersonID`,
    `reservations`.`RegistrationCode`,
    `reservations`.`CodeExpiration`
FROM `events`.`reservations`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selReservationByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selReservationByID`(IN pReservationID INT)
BEGIN
SELECT `reservations`.`ReservationID`,
    `reservations`.`ReservationDate`,
    `reservations`.`LastUpdated`,
    `reservations`.`Events_EventID`,
    `reservations`.`Person_PersonID`,
    `reservations`.`RegistrationCode`,
    `reservations`.`CodeExpiration`
FROM `events`.`reservations`
WHERE ReservationID = pReservationID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selReservationByRegistrationCode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selReservationByRegistrationCode`(IN pRegistrationCode VARCHAR(64))
BEGIN
SELECT `reservations`.`ReservationID`,
    `reservations`.`ReservationDate`,
    `reservations`.`LastUpdated`,
    `reservations`.`Events_EventID`,
    `reservations`.`Person_PersonID`,
    `reservations`.`RegistrationCode`,
    `reservations`.`CodeExpiration`
FROM `events`.`reservations`
WHERE RegistrationCode = pRegistrationCode;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selReservations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selReservations`()
BEGIN
SELECT `reservations`.`ReservationID`,
    `reservations`.`ReservationDate`,
    `reservations`.`LastUpdated`,
    `reservations`.`Events_EventID`,
    `reservations`.`Person_PersonID`,
    `reservations`.`RegistrationCode`,
    `reservations`.`CodeExpiration`
FROM `events`.`reservations`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selReservationsByEventID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selReservationsByEventID`(IN pEventID INT)
BEGIN
SELECT `reservations`.`ReservationID`,
    `reservations`.`ReservationDate`,
    `reservations`.`LastUpdated`,
    `reservations`.`Events_EventID`,
    `reservations`.`Person_PersonID`,
    `reservations`.`RegistrationCode`,
    `reservations`.`CodeExpiration`
FROM `events`.`reservations`
WHERE Events_EventID = pEventID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selUnitByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selUnitByID`(IN pUnitID INT)
BEGIN
SELECT `units`.`UnitID`,
    `units`.`UnitNumber`,
    `units`.`unittypes_UnitTypeID`
FROM `events`.`units`
WHERE UnitID = pUnitID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selUnitRankByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selUnitRankByID`(IN pUnitRankID INT)
BEGIN
SELECT `unitranks`.`UnitRankID`,
    `unitranks`.`UnitRank`,
    `unitranks`.`unittypes_UnitTypeID`
FROM `events`.`unitranks`
WHERE UnitRankID = pUnitRankID;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selUnitRanks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selUnitRanks`()
BEGIN
SELECT `unitranks`.`UnitRankID`,
    `unitranks`.`UnitRank`,
    `unitranks`.`unittypes_UnitTypeID`
FROM `events`.`unitranks`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selUnits` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selUnits`()
BEGIN
SELECT `units`.`UnitID`,
    `units`.`UnitNumber`,
    `units`.`unittypes_UnitTypeID`
FROM `events`.`units`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selUnitType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selUnitType`()
BEGIN
SELECT `unittypes`.`UnitTypeID`,
    `unittypes`.`UnitType`
FROM `events`.`unittypes`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selUnitTypeByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selUnitTypeByID`(IN pUnitTypeID INT)
BEGIN
	SELECT `unittypes`.`UnitTypeID`,
    `unittypes`.`UnitType`
FROM `events`.`unittypes`
WHERE UnitTypeID = pUnitTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selVenueByID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selVenueByID`(IN pVenueID INT)
BEGIN
SELECT `venue`.`VenueID`,
    `venue`.`Name`,
    `venue`.`Contact`,
    `venue`.`contactinfo_ContactInfoID`
FROM `events`.`venue`
WHERE VenueID = pVenueID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selVenues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `selVenues`()
BEGIN
SELECT `venue`.`VenueID`,
    `venue`.`Name`,
    `venue`.`Contact`,
    `venue`.`contactinfo_ContactInfoID`
FROM `events`.`venue`;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updContactInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updContactInfo`(IN pContactInfoID INT
									, IN pContactName VARCHAR(45)
									, IN pHomePhone VARCHAR(15)
                                    , IN pCellPhone VARCHAR(15)
                                    , IN pEmail VARCHAR(45)
                                    , IN pAddress1 VARCHAR(50)
                                    , IN pAddress2 VARCHAR(50)
                                    , IN pCity VARCHAR(45)
                                    , IN pState VARCHAR(2)
                                    , IN pZip VARCHAR(10))
BEGIN
UPDATE `events`.`contactinfo`
SET
`ContactName` = pContactName,
`HomePhone` = pHomePhone,
`CellPhone` = pCellPhone,
`Email` = pEmail,
`Address1` = pAddress1,
`Address2` = pAddress2,
`City` = pCity,
`State` = pState,
`Zip` = pZip
WHERE `ContactInfoID` = pContactInfoID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updEvent`(IN pEventID int
							 , IN pVenueID INT
							 , IN pEventName VARCHAR(100)
                             , IN pEventStart DATETIME
                             , IN pEventEnd DATETIME
                             , IN pEventDescription VARCHAR(2000)
                             , IN pEventTypeID INT
                             , IN pStaffPaymentRequired BIT
                             , IN pRegistrationDeadline DATETIME
                             , IN pRequiredStaff INT
                             , IN pRequiredVolunteers INT)
BEGIN
UPDATE `events`.`events`
SET
`VenueID` = pVenueID,
`EventName` = pEventName,
`EventStart` = pEventStart,
`EventEnd` = pEventEnd,
`EventDescription` = pEventDescription,
`LastUpdate` = SYSDATE(),
`EventTypes_EventTypeID` = pEventTypeID,
`StaffPaymentRequired` = pStaffPaymentRequired,
`RegistrationDeadline` = pRegistrationDeadline,
`RequiredStaff` = pRequiredStaff,
`RequiredVolunteers` = pRequiredVolunteers
WHERE `EventID` = pEventID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updEventStaff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updEventStaff`(IN pEventStaffID INT
									, IN pPositionID INT
									, IN pEventID INT
                                    , IN pPersonID INT)
BEGIN
UPDATE `events`.`eventstaff`
SET
`LastUpdated` = SYSDATE(),
`positions_PositionID` = pPositionID,
`events_EventID` = pEventID,
`person_PersonID` = pPersonID
WHERE `EventStaffID` = pEventStaffID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updEventType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updEventType`(IN pEventTypeID INT, IN pEventType VARCHAR(45))
BEGIN
UPDATE `events`.`eventtypes`
SET
`EventType` = pEventType
WHERE `EventTypeID` = pEventTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updEventVolunteer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updEventVolunteer`(IN pEventVolunteerID INT
																, IN pEventID INT
																, IN pPersonID INT
                                                                , IN pvolunteerDays INT
                                                                , IN pMondayVol VARCHAR(1)
                                                                , IN pTuesdayVol VARCHAR(1)
                                                                , IN pWednesdayVol VARCHAR(1)
                                                                , IN pThursdayVol VARCHAR(1)
                                                                , IN pFridayVol VARCHAR(1)
                                                                , IN pSaturdayVol VARCHAR(1)
                                                                , IN pSundayVol VARCHAR(1))
BEGIN
UPDATE `events`.`eventvolunteers`
SET
`LastUpdated` = SYSDATE(),
`events_EventID` = pEventID,
`person_PersonID` = pPersonID,
`volunteerDays` = pvolunteerDays,
`MondayVol` = pMondayVol,
`TuesdayVol` = pTuesdayVol,
`WednesdayVol` = pWednesdayVol,
`ThursdayVol` = pThursdayVol,
`FridayVol` = pFridayVol,
`SaturdayVol` = pSaturdayVol,
`SundayVol` = pSaturdayVol
WHERE `EventVolunteerID` = pEventVolunteerID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updPerson` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updPerson`(IN pPersonID INT
							   , IN pFirstName VARCHAR(45)
							   , IN pMiddleName VARCHAR(45)
                               , IN pLastName VARCHAR(45)
                               , IN pContactInfoID INT
                               , IN pParentPersonID INT
                               , IN pPersonTypeID INT
                               , IN pUnitRankID INT
                               , IN pUnitID INT
                               , IN pUserID VARCHAR(45)
                               , IN pNotes VARCHAR(4000)
                               , IN pBirthDate DATE)
BEGIN
UPDATE `events`.`person`
SET `FirstName` = pFirstName,
`MiddleName` = pMiddleName,
`LastName` = pLastName,
`LastUpdate` = SYSDATE(),
`contactInfo_ContactInfoID` = pContactInfoID,
`ParentPersonID` = pParentPersonID,
`persontype_PersonTypeID` = pPersonTypeID,
`unitranks_UnitRankID` = pUnitRankID,
`units_UnitID` = pUnitID,
`user_id` = pUserID,
`Notes` = pNotes,
`BirthDate` = pBirthDate
WHERE `PersonID` = pPersonID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updPersonType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updPersonType`(IN pPersonTypeID INT, IN pPersonType VARCHAR(45))
BEGIN
	UPDATE `events`.persontypes
	SET
	 PersonType = pPersonType
	WHERE PersonTypeID = pPersonTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updPosition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updPosition`(IN pPositionID INT, IN pPosition VARCHAR(45))
BEGIN
UPDATE `events`.`positions`
SET
`Position` = pPosition
WHERE `PositionID` = pPositionID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updRegistration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updRegistration`(IN pRegistrationID INT
									, IN pRegistrationDate DATETIME
                                    , IN pConfirmation VARCHAR(64)
                                    , IN pEventID INT
                                    , IN pPersonID INT)
BEGIN
UPDATE `events`.`registrations`
SET
`RegistrationDate` = pRegistrationDate,
`Confirmation` = pConfirmation,
`LastUpdated` = SYSDATE(),
`Events_EventID` = pEventID,
`Person_PersonID` = pPersonID
WHERE `RegistrationID` = pRegistrationID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updReservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updReservation`( IN pReservationID INT
									,IN pReservationDate DATETIME
									, IN pEventID INT
									, IN pPersonID INT
                                    , IN pRegistrationCode VARCHAR(64)
                                    , IN pCodeExpiration DATETIME)
BEGIN
UPDATE `events`.`reservations`
SET
`ReservationDate` = pReservationDate,
`LastUpdated` = SYSDATE(),
`Events_EventID` = pEventID,
`Person_PersonID` = pPersonID,
`RegistrationCode` = pRegistrationCode,
`CodeExpiration` = pCodeExpiration
WHERE `ReservationID` = pReservationID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updUnit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updUnit`(IN pUnitID INT, IN pUnitNumber INT, IN pUnitTypeID INT)
BEGIN
UPDATE `events`.`units`
SET
`UnitNumber` = pUnitNumber,
`unittypes_UnitTypeID` = pUnitTypeID
WHERE `UnitID` = pUnitID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updUnitRank` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updUnitRank`(IN pUnitRankID INT, IN pUnitRank VARCHAR(45), IN pUnitTypeID INT)
BEGIN
UPDATE `events`.`unitranks`
SET
`UnitRank` = pUnitRank,
`unittypes_UnitTypeID` = pUnitTypeID
WHERE `UnitRankID` = pUnitRankID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updUnitType` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updUnitType`(IN pUnitTypeID INT, IN pUnitType VARCHAR(45))
BEGIN
UPDATE `events`.`unittypes`
SET
`UnitType` = pUnitType
WHERE `UnitTypeID` = pUnitTypeID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updVenue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`scoutApp`@`localhost` PROCEDURE `updVenue`(IN pVenueID INT
							 , IN pName VARCHAR(60)
                             , IN pContact VARCHAR(45)
                             , IN pContactInfoID INT)
BEGIN
UPDATE `events`.`venue`
SET `Name` =pName,
`Contact` = pContact,
`contactinfo_ContactInfoID` = pContactInfoID
WHERE `VenueID` = pVenueID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `dbveventcounts`
--

/*!50001 DROP VIEW IF EXISTS `dbveventcounts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dbveventcounts` AS select `e`.`EventID` AS `EventId`,`e`.`EventName` AS `EventName`,(select count(0) from `eventvolunteers` `ev` where (`ev`.`events_EventID` = `e`.`EventID`)) AS `VolunteerCount`,(select count(0) from `reservations` `ev` where (`ev`.`Events_EventID` = `e`.`EventID`)) AS `ReservationCount`,(select count(0) from `registrations` `ev` where (`ev`.`Events_EventID` = `e`.`EventID`)) AS `RegistrationCount` from `events` `e` order by `e`.`EventID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dbveventcountsbyunit`
--

/*!50001 DROP VIEW IF EXISTS `dbveventcountsbyunit`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dbveventcountsbyunit` AS select `totals`.`EventId` AS `EventId`,sum(`totals`.`Volunteers`) AS `VolCount`,sum(`totals`.`Registrations`) AS `RegCount`,sum(`totals`.`Reservations`) AS `ResCount`,`totals`.`units_UnitID` AS `UnitID`,`ut`.`UnitType` AS `UnitType`,`u`.`UnitNumber` AS `UnitNumber` from ((`event_unit_counts_vw` `totals` join `units` `u` on((`totals`.`units_UnitID` = `u`.`UnitID`))) join `unittypes` `ut` on((`u`.`unittypes_UnitTypeID` = `ut`.`UnitTypeID`))) group by `totals`.`EventId`,`totals`.`units_UnitID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dbveventdashboardtrend`
--

/*!50001 DROP VIEW IF EXISTS `dbveventdashboardtrend`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dbveventdashboardtrend` AS select `totals`.`events_EventID` AS `events_EventID`,sum(`totals`.`VolunteerCount`) AS `VolCount`,sum(`totals`.`RegistrantCount`) AS `RegCount`,sum(`totals`.`ReservationCount`) AS `ResCount`,`totals`.`LastUpdated` AS `LastUpdated` from `event_reg_trends` `totals` group by `totals`.`events_EventID`,`totals`.`LastUpdated` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dbveventvolunteerdetails`
--

/*!50001 DROP VIEW IF EXISTS `dbveventvolunteerdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dbveventvolunteerdetails` AS select `ev`.`EventVolunteerID` AS `ID`,`p`.`FirstName` AS `FirstName`,`p`.`MiddleName` AS `MiddleName`,`p`.`LastName` AS `LastName`,`pt`.`PersonType` AS `PersonType`,`p`.`BirthDate` AS `BirthDate`,`ut`.`UnitType` AS `UnitType`,`u`.`UnitNumber` AS `UnitNumber`,`c`.`Email` AS `Email`,`c`.`HomePhone` AS `HomePhone`,`c`.`CellPhone` AS `CellPhone`,`c`.`Address1` AS `Address1`,`c`.`Address2` AS `Address2`,`c`.`City` AS `City`,`c`.`State` AS `State`,`c`.`Zip` AS `Zip`,`ev`.`volunteerDays` AS `volunteerDays`,`ev`.`MondayVol` AS `MondayVol`,`ev`.`TuesdayVol` AS `TuesdayVol`,`ev`.`WednesdayVol` AS `WednesdayVol`,`ev`.`ThursdayVol` AS `ThursdayVol`,`ev`.`FridayVol` AS `FridayVol`,`ev`.`SaturdayVol` AS `SaturdayVol`,`ev`.`SundayVol` AS `SundayVol` from (((((`eventvolunteers` `ev` join `person` `p` on((`ev`.`person_PersonID` = `p`.`PersonID`))) join `persontypes` `pt` on((`p`.`persontype_PersonTypeID` = `pt`.`PersonTypeID`))) join `contactinfo` `c` on((`p`.`contactInfo_ContactInfoID` = `c`.`ContactInfoID`))) join `units` `u` on((`p`.`units_UnitID` = `u`.`UnitID`))) join `unittypes` `ut` on((`u`.`unittypes_UnitTypeID` = `ut`.`UnitTypeID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dbveventvolunteertrend`
--

/*!50001 DROP VIEW IF EXISTS `dbveventvolunteertrend`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dbveventvolunteertrend` AS select `eventvolunteers`.`events_EventID` AS `events_EventID`,count(0) AS `DailyCount`,`eventvolunteers`.`LastUpdated` AS `LastUpdated` from `eventvolunteers` group by `eventvolunteers`.`events_EventID`,`eventvolunteers`.`LastUpdated` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dbvregistrationdetails`
--

/*!50001 DROP VIEW IF EXISTS `dbvregistrationdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dbvregistrationdetails` AS select `reg`.`RegistrationID` AS `RegistrationID`,`reg`.`RegistrationDate` AS `RegistrationDate`,`reg`.`Confirmation` AS `Confirmation`,`reg`.`Events_EventID` AS `Events_EventID`,`prs`.`FirstName` AS `FirstName`,`prs`.`MiddleName` AS `MiddleName`,`prs`.`LastName` AS `LastName`,`prs`.`BirthDate` AS `BirthDate`,`ur`.`UnitRank` AS `UnitRank`,`ut`.`UnitType` AS `UnitType`,`unt`.`UnitNumber` AS `UnitNumber`,`prs`.`Notes` AS `Notes`,`contact`.`Email` AS `Email`,`contact`.`HomePhone` AS `HomePhone`,`contact`.`CellPhone` AS `CellPhone`,concat(`pntprs`.`FirstName`,' ',`pntprs`.`LastName`) AS `ParentName`,`contact`.`Address1` AS `Address1`,`contact`.`Address2` AS `Address2`,`contact`.`City` AS `City`,`contact`.`State` AS `State`,`contact`.`Zip` AS `Zip` from ((((((`registrations` `reg` join `person` `prs` on((`prs`.`PersonID` = `reg`.`Person_PersonID`))) join `units` `unt` on((`unt`.`UnitID` = `prs`.`units_UnitID`))) join `unittypes` `ut` on((`ut`.`UnitTypeID` = `unt`.`unittypes_UnitTypeID`))) join `unitranks` `ur` on((`prs`.`unitranks_UnitRankID` = `ur`.`UnitRankID`))) join `person` `pntprs` on((`prs`.`ParentPersonID` = `pntprs`.`PersonID`))) join `contactinfo` `contact` on((`prs`.`contactInfo_ContactInfoID` = `contact`.`ContactInfoID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dbvregistrationtrend`
--

/*!50001 DROP VIEW IF EXISTS `dbvregistrationtrend`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dbvregistrationtrend` AS select `registrations`.`Events_EventID` AS `events_EventID`,count(0) AS `DailyCount`,`registrations`.`LastUpdated` AS `LastUpdated` from `registrations` group by `registrations`.`Events_EventID`,`registrations`.`LastUpdated` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dbvreservationdetails`
--

/*!50001 DROP VIEW IF EXISTS `dbvreservationdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dbvreservationdetails` AS select `res`.`ReservationID` AS `ReservationID`,`res`.`ReservationDate` AS `ReservationDate`,`res`.`RegistrationCode` AS `RegistrationCode`,`res`.`Events_EventID` AS `Events_EventID`,`prs`.`FirstName` AS `FirstName`,`prs`.`MiddleName` AS `MiddleName`,`prs`.`LastName` AS `LastName`,`prs`.`BirthDate` AS `BirthDate`,`ur`.`UnitRank` AS `UnitRank`,`ut`.`UnitType` AS `UnitType`,`unt`.`UnitNumber` AS `UnitNumber`,`prs`.`Notes` AS `Notes`,`contact`.`Email` AS `Email`,`contact`.`HomePhone` AS `HomePhone`,`contact`.`CellPhone` AS `CellPhone`,concat(`pntprs`.`FirstName`,' ',`pntprs`.`LastName`) AS `ParentName`,`contact`.`Address1` AS `Address1`,`contact`.`Address2` AS `Address2`,`contact`.`City` AS `City`,`contact`.`State` AS `State`,`contact`.`Zip` AS `Zip` from ((((((`reservations` `res` join `person` `prs` on((`prs`.`PersonID` = `res`.`Person_PersonID`))) join `units` `unt` on((`unt`.`UnitID` = `prs`.`units_UnitID`))) join `unittypes` `ut` on((`ut`.`UnitTypeID` = `unt`.`unittypes_UnitTypeID`))) join `unitranks` `ur` on((`prs`.`unitranks_UnitRankID` = `ur`.`UnitRankID`))) join `person` `pntprs` on((`prs`.`ParentPersonID` = `pntprs`.`PersonID`))) join `contactinfo` `contact` on((`prs`.`contactInfo_ContactInfoID` = `contact`.`ContactInfoID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `dbvreservationtrend`
--

/*!50001 DROP VIEW IF EXISTS `dbvreservationtrend`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dbvreservationtrend` AS select `reservations`.`Events_EventID` AS `events_EventID`,count(0) AS `DailyCount`,`reservations`.`LastUpdated` AS `LastUpdated` from `reservations` group by `reservations`.`Events_EventID`,`reservations`.`LastUpdated` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `event_reg_trends`
--

/*!50001 DROP VIEW IF EXISTS `event_reg_trends`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `event_reg_trends` AS select `dbveventvolunteertrend`.`events_EventID` AS `events_EventID`,`dbveventvolunteertrend`.`DailyCount` AS `VolunteerCount`,0 AS `RegistrantCount`,0 AS `ReservationCount`,cast(`dbveventvolunteertrend`.`LastUpdated` as date) AS `LastUpdated` from `dbveventvolunteertrend` union all select `dbvregistrationtrend`.`events_EventID` AS `events_EventID`,0 AS `VolunteerCount`,`dbvregistrationtrend`.`DailyCount` AS `RegistrantCount`,0 AS `ReservationCount`,cast(`dbvregistrationtrend`.`LastUpdated` as date) AS `LastUpdated` from `dbvregistrationtrend` union all select `dbvreservationtrend`.`events_EventID` AS `events_EventID`,0 AS `VolunteerCount`,0 AS `RegistrantCount`,`dbvreservationtrend`.`DailyCount` AS `ReservationCount`,cast(`dbvreservationtrend`.`LastUpdated` as date) AS `LastUpdated` from `dbvreservationtrend` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `event_unit_counts_vw`
--

/*!50001 DROP VIEW IF EXISTS `event_unit_counts_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `event_unit_counts_vw` AS select `event_unit_volunteer_count_vw`.`EventId` AS `EventId`,`event_unit_volunteer_count_vw`.`Volunteers` AS `Volunteers`,0 AS `Registrations`,0 AS `Reservations`,`event_unit_volunteer_count_vw`.`units_UnitID` AS `units_UnitID` from `event_unit_volunteer_count_vw` union all select `event_unit_registration_count_vw`.`EventId` AS `EventId`,0 AS `Volunteers`,`event_unit_registration_count_vw`.`Registrations` AS `Registrations`,0 AS `Reservations`,`event_unit_registration_count_vw`.`units_UnitID` AS `units_UnitID` from `event_unit_registration_count_vw` union all select `event_unit_reservation_count_vw`.`EventId` AS `EventId`,0 AS `Volunteers`,0 AS `Registrations`,`event_unit_reservation_count_vw`.`Reservations` AS `Reservations`,`event_unit_reservation_count_vw`.`units_UnitID` AS `units_UnitID` from `event_unit_reservation_count_vw` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `event_unit_registration_count_vw`
--

/*!50001 DROP VIEW IF EXISTS `event_unit_registration_count_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `event_unit_registration_count_vw` AS select `e`.`EventID` AS `EventId`,count(0) AS `Registrations`,`p`.`units_UnitID` AS `units_UnitID` from (((`events` `e` left join `registrations` `ev` on((`ev`.`Events_EventID` = `e`.`EventID`))) left join `person` `p` on((`ev`.`Person_PersonID` = `p`.`PersonID`))) left join `persontypes` `pt` on((`p`.`persontype_PersonTypeID` = `pt`.`PersonTypeID`))) group by `e`.`EventID`,`p`.`units_UnitID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `event_unit_reservation_count_vw`
--

/*!50001 DROP VIEW IF EXISTS `event_unit_reservation_count_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `event_unit_reservation_count_vw` AS select `e`.`EventID` AS `EventId`,count(0) AS `Reservations`,`p`.`units_UnitID` AS `units_UnitID` from (((`events` `e` left join `reservations` `ev` on((`ev`.`Events_EventID` = `e`.`EventID`))) left join `person` `p` on((`ev`.`Person_PersonID` = `p`.`PersonID`))) left join `persontypes` `pt` on((`p`.`persontype_PersonTypeID` = `pt`.`PersonTypeID`))) group by `e`.`EventID`,`p`.`units_UnitID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `event_unit_volunteer_count_vw`
--

/*!50001 DROP VIEW IF EXISTS `event_unit_volunteer_count_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scoutApp`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `event_unit_volunteer_count_vw` AS select `e`.`EventID` AS `EventId`,count(0) AS `Volunteers`,`p`.`units_UnitID` AS `units_UnitID` from (((`events` `e` left join `eventvolunteers` `ev` on((`ev`.`events_EventID` = `e`.`EventID`))) left join `person` `p` on((`ev`.`person_PersonID` = `p`.`PersonID`))) left join `persontypes` `pt` on((`p`.`persontype_PersonTypeID` = `pt`.`PersonTypeID`))) group by `e`.`EventID`,`p`.`units_UnitID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-11 14:43:21
