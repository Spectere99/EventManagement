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
INSERT INTO `aspnetusers` VALUES ('00eba7fe-58fd-46d5-8db2-9f69c557e765',NULL,'ronaldfletcher1990@gmail.com',0,'AISR/wF9b2KAgbguRzw/oMQW6R5vF+vlwDRWrJviv5qvZoDhh8DvhfMTwR7oMF3Zpw==','1c2b64c5-4f39-4f1f-8c6c-dadd8f538a78',NULL,0,0,NULL,1,0,'cubmasterron','RONALD','FLETCHER'),('027b0254-950c-488c-a2f0-45e95ed633a2',NULL,'amydelling@yahoo.com',0,'AMNd1Xy0uK6FgqXpcp5aJRKaFlPcPaFLP5keoKbp1BbazWAwfD9OO2tVtLGRVACblg==','09ad2e36-1eb1-4633-bc77-e70d59699fba',NULL,0,0,NULL,1,0,'adelling','Amy','Dellinger'),('027c3a0b-41af-486b-afb7-58ae6be81963',NULL,'spectrallight@gmail.com',0,'ACK4KQJnoJflq9IgAHAMp6Bi+rdZNOdyEphJhJrWQmd/BADagKDpwAQYSN+8PEHVtg==','ec2cb4e9-6035-4c5f-b336-b8a804929314',NULL,0,0,NULL,1,0,'Test','Test','Test'),('045ffd11-26f8-48f4-ac6e-42aebc4f5d9b',NULL,'nikflippin@bellsouth.net',1,'AEePPJHUHunS6gt2pQ1lO2ems7BD/UcK4QBUNU1PK91PziAKY9g/zHWHjkcYp9hDJw==','5d7afb8a-8b3f-4365-a1cc-e6edb46e110e',NULL,0,0,NULL,1,0,'nikflippin','Nicole','Flippin'),('0517def0-4682-432f-be56-5a132c7a5a13',NULL,'laurac@comporium.net',0,'AEw2lbGv7RNkkEzXjNHUxRxsxzgbj7b7cnJ0i68A67PmFho1rXz2Bc4KHs0hwa8oZg==','841a07db-ad11-4102-84c8-8a6837c8e29b',NULL,0,0,NULL,1,0,'homeschool513','laura','cripe'),('06298a8d-c555-4c2c-8694-1445f9e007e1',NULL,'siwbaker@gmail.com',0,'AOcrox7oJlSlgzi6352Da17DqaXbopwiZL1a46SLmIU8q01ERUwXSacumJjd/cUHxQ==','be16450e-5037-4130-a587-ec65320d7006',NULL,0,0,NULL,1,0,'siwbaker','Sally','Baker'),('07085b0f-75aa-4f8f-811b-42d6bbb20d75',NULL,'amccorkle@gmail.com',0,'ABJKsyrTzj5iM64+Dr945dD0YjNoslTorS6bDHqq0lQDxQ7hYmYMP8v2mQDPSSJhNg==','13096a2c-70ef-4e45-b3b1-85b7a6fed531',NULL,0,0,NULL,1,0,'abrown043','William','McCorkle'),('07bc8c87-1771-441a-8519-abfcd89e6f6a',NULL,'crissypoetzl@gmail.com',0,'AHlAyAAyNDIb7Z4wDVeISZ45c1FFmLdBW+E00cKFUPI5IpYmmFY9qHDfOLTCWZSfxw==','00818736-101e-4381-b9f8-14c2e2265b95',NULL,0,0,NULL,1,0,'cpoetzl','Christina','Poetzl'),('0a093e08-a411-4fc6-8db9-aaab639601e0',NULL,'Cassieclark415@gmail.com',0,'AH3Oezh6MYCO5AmJXzF6vIhPJbt7O/iUlC0px3gazBb/DFpuJr0bjjrRNeZXLWU1ig==','26f495e1-7e25-4a6a-8f92-3fff0ea8e721',NULL,0,0,NULL,1,0,'Cassieclark415','Calvin','Lyle'),('0baa0786-cf75-4b19-9abc-2120b39d96a2',NULL,'pack333@yahoo.com',0,'AP29K10k0VxQZBESV/8LvyqXONl/NbYc/OYZx+ehYkX+iZw7zPP1YbAWNVxXdwMNOQ==','ee758f86-623e-4058-a7e6-1394ad5f308c',NULL,0,0,NULL,1,0,'packcpoe','Christina','Poetzl'),('0f4cfe52-3050-44d3-b228-5f822dd5dd75',NULL,'ANDREWHANE@ROCKETMAIL.COM',0,'APyeuQO4KW2rHfgpCkndlEO7cdRHGMhbeCoOCzWDck9UsAl9w6Pu6GH0VQRGItpMig==','667ccdcf-bd44-4efc-a17b-df944eb4d1bd',NULL,0,0,NULL,1,0,'ANDREWHANE@ROCKETMAIL.COM','ANDREW','HANE'),('0f4f225c-e241-481d-bc1b-634c44ee10d2',NULL,'royhboyd@gmail.com',1,'APEPk0svOYLuyjP9uk2B0r1ziF5lR1S0NoJNLCuD12V0FbTKMr4NChT5Cy28zBu+vg==','92fd311e-badf-4bd3-8347-4559fbbd4160',NULL,0,0,NULL,1,0,'rboyd','roy','boyd'),('0f50f193-b477-4623-9284-f95c1f295729',NULL,'xtinavincent80@gmail.com',0,'AFNaTK/kffec/3ZD+67lZjfhFFACKEi/UhEPNSXAkgYZ89FZMysjoRl53MSNeuiaZA==','8039a439-8621-47b1-8165-bb2e61462777',NULL,0,0,NULL,1,0,'CristinaRenzoni','Cristina','Renzoni'),('101b293c-e0a4-4e6f-b939-857110ed71bd',NULL,'Price@designbrothers.com',0,'AAngjJ4OsIIbG4XrvkbaboIcBX/+LX3qsM86h2j84La02AQxken3lHkxFuJeUDrxIg==','bcce6446-28aa-4c94-ac2a-e6d0ad3ac53b',NULL,0,0,NULL,1,0,'Price','Michael ','Feimster'),('16a8a528-3a1f-45ca-b4f4-86c6a0b83ff2',NULL,'nscutie979@gmail.com',0,'ABxAUsfHKlDe0ASLs3paF9jR7UGQBirT+VPvMsvFtL5HpLGoMm6GBRXs1oNs6l+B3g==','26d982bb-a34e-4493-aa73-3663c8784092',NULL,0,0,NULL,1,0,'Chase229','Chase','Higgins'),('1748e932-04f4-449a-b677-25681d63120a',NULL,'flowersr99@gmail.com',1,'AJftjr5qa0ZLinbNubyRMizxHMxoE69gZ6qy50FUJ4bySAyedi5iXaEmo0xCG0rx9A==','00ca1cb1-5fdc-454d-a9f6-116461e761dc',NULL,0,0,NULL,1,0,'Rwflowers','ROBERT','FLOWERS'),('19a8b3da-19b8-4743-85a4-b7b3c1d45d5e',NULL,'yorkdaycamp@gmail.com',0,'AN2RQa71MwYAZhNOmAK/cMa2HX0c1RE2si6U78GG8d0+fk8IsU0YBMomR9PKHAbFoA==','ae7012fa-141d-4bd6-ac96-164b3859e53a',NULL,0,0,NULL,1,0,'Deleteme','Delete','ME'),('19b194b1-e689-4947-b418-69e5608877ef',NULL,'agstrong1215@gmail.com',0,'AGUl+LmfBLLXXdNJByLauC20SV77VJcHP1lxsEgaqema3f+A7PmZTm83bV6euTIeWg==','8451a8f3-5f1d-4240-b860-d3118af604d2',NULL,0,0,NULL,1,0,'amynben','Amy','Strong'),('1ad48d61-bbcc-4f82-adbf-a3e45bd7f031',NULL,'tlollismitchell@msn.com',1,'AC+nc3GyPEmpp7TMlRpAImr6mXX3DqnjjZXmwfcFkGLFRV9yBI0L0519wvlIoShgvA==','beea808e-1a76-45f6-9ee7-ec46b79498dc',NULL,0,0,NULL,1,0,'Pack','Daniel','Collins'),('1b388a36-a3ed-4feb-806c-e18d61981803',NULL,'Kristypowell419@yahoo.com',0,'ABJgudp2rLNSWmqqSy7B/3nZ5KYMkxtcGhHX9gz2qRrOxdGXQaf1Ago3mRIDpUD4GA==','0d19cbdb-8ea8-423b-8ea0-f0744dd58767',NULL,0,0,NULL,1,0,'Kristypowell419','Kristy ','Powell '),('1be33843-8af4-4a6f-8e5c-6e9d5614f801',NULL,'cararohlfs@gmail.com',0,'AAhRAsEuIuB9WYdgeRwtw0lbGcGD71j67gXPVuGbIjmCVR254+Z45zag1N7iaEeGhg==','406c6563-683e-46e2-8479-3a68ccd333a1',NULL,0,0,NULL,1,0,'cararohlfs','Cara','Rohlfs'),('1e381f3b-61f7-4957-a1e6-b4ec8f72437e',NULL,'Thressaelam@gmail.com',1,'AJkriDN0mMsxeOpehnIkC+HJ7vmA70OJIa5hgB9QCFj4NlRa9QWXewlLloRuTwx/KQ==','33a2b8fa-c2bd-40c5-b3da-1e431db02efd',NULL,0,0,NULL,1,0,'Telam','Thressa','Elam'),('1eb3070f-1c1f-4021-8930-c31c9877f612',NULL,'msprescott5@live.com',0,'AIZ7cMLejJkVFBJEIECeqh0s2uZ38Jh7Qz0b2lr29FGU+uzWcm5dPQEjy7QjtlEbZw==','c62927ac-232c-41f7-bf04-2c56200aaad4',NULL,0,0,NULL,1,0,'msprescott5 ','Mark','Prescott'),('1ebf9561-0178-48fb-bb2b-67987d0216a7',NULL,'TheBendtFamily@Comporium.net',0,'AO/L4AImVHhqd4JGhWsOfy74eO3fJT8msFJ3pbAyBQyUfxeA0HAMGF2P5/UNQuJLGA==','522db562-80ce-438d-b8cc-6dc22038de86',NULL,0,0,NULL,1,0,'bbendt','Jacob','Bendt'),('20cbb424-269d-4910-8b06-e870508089e5',NULL,'lakedude@bellsouth.net',0,'AA/tPLPbZEJuPQjZSRzJOlid2hlOrD7ghDd6Cvn0FSZOuz5YGNLJEl2K+NAg5X2jkw==','a4755e48-f80d-48df-a027-edf35a9d8f5e',NULL,0,0,NULL,1,0,'lakedude','Glenn','Stoner'),('21ea514e-e7bc-423e-ac77-95e1dba4f6b8',NULL,'Amara278@gmail.com',0,'AKZNNulpESuohL/gR2NhjgNpc8g0r9GJaCi78+L4LbA3Ztjc+6ta40OmPda+RFdHFA==','b4e9c415-de4d-40b9-ad47-5d38faa2eaa5',NULL,0,0,NULL,1,0,'JCox79','Jacquelina','Cox'),('224ca510-c670-4540-9ebb-fe4dade6c0d3',NULL,'Soniacolon@yahoo.com',1,'ACfx/qriaDgPKsF8OsMkkKMUwHGaeiMrxN4wwOcZV2IaALedbcM2uPV8XQV46+wvBQ==','5cd66ea9-680a-4120-b85d-0aeba0e12362',NULL,0,0,NULL,1,0,'Fredonena','Sonia','Colon'),('26a83b69-9630-403e-9dc7-4a10c39d56bf',NULL,'paswoope@hotmail.com',0,'AFvV82aNJNR0YWF1vL+CdK4vA/q3NkasggrUc/82i486ZfBZnqguoDbiF7WK2pVxjQ==','f9cfcfc6-bbe0-4752-a379-6fb5064a7a57',NULL,0,0,NULL,1,0,'paswoope@hotmail.com','Patricia','Swoope'),('27312fad-e13a-4f50-bd77-16c703c08f67',NULL,'tparrish@goencompass.com',0,'AHJ5cedQi58mEzVJ8DWiJ40mz/Y9z6Tajzy5MKLN2X9sI5XmqnyN+FCIIwSOf2W71Q==','e1a498c3-81dc-4b93-ac67-9b1b9eb80648',NULL,0,0,NULL,1,0,'parrish.trey ','James','Parrish'),('292325f7-e402-40da-9b95-c0a5114fb08b',NULL,'stevenjr@comporium.net',0,'AGCM42ET2OUS8Dn6985ujeS51Rc6h8uAY5l06fjC7G07IM1RgfS3PpvaI7p1AAB2yg==','7bebe6f9-ee52-4dd1-a55b-5b09bec8aadf',NULL,0,0,NULL,1,0,'Stevenjr','steven','schweninger'),('29a56afd-3b27-4ee4-8b8d-f0a1db19b1dd',NULL,'Katiehylton@gmail.com',1,'ADl+kCSbIJnJvU2dbrx7uL9NDtl0Zb83t11YugXiT6TAK29pQlrMD+0PP9klNnPepA==','96675d58-53bb-4ff1-b645-8bd560d64c5f',NULL,0,0,NULL,1,0,'Khylto01','Katherine','Hylton'),('314b3ba3-f01e-4256-872d-c07900d871bd',NULL,'ljohnston@rhmail.org',0,'AKWI/ZuVaBuB4YaB47JKek/YOHbsUnHCNs7WHJIifeU/ePzS6L/bvteDAK+uPkFdtQ==','56fd4fd1-6aec-44b9-b5e3-b867742fe118',NULL,0,0,NULL,1,0,'ljohnston81','Laura','Johnston'),('31c04f57-2034-4c70-afa3-6780cae9d64c',NULL,'stuart.hildebrandt@gmail.com',0,'AMqvlXLCIm/OUTIQnkFmsbYDD02Y8JMf/3XsNp2WISi3JOgGJ2gw/2hrNTDDr7f92Q==','d27bdf6c-0eba-4757-932f-6ab5304bdb2c',NULL,0,0,NULL,1,0,'hildebrs1','Stuart','Hildebrandt'),('344b2f8f-e154-4d49-a486-6800f54e9752',NULL,'Tarheelmcgeeunc@yahoo.com',0,'AJ78Y+mZJrOR8GLlY116/19/rp2iM8NqmCFL3ybTy/ty062MOleBATrNpTqCr8V6Yg==','f98b5eeb-12de-45d6-8a23-0af7aca49afb',NULL,0,0,NULL,1,0,'Tarheelmcgeeunc','Jesse','McGee'),('35ac786d-c1c4-4fc8-98e7-20d7321aa8bd',NULL,'Robbye_24@yahoo.com',1,'ANH6UWkk43YYzw/4jvuT8SWdpCn453LS4ISlAH60inUsD6RYzq13rI63Sg2UZI2apQ==','6eb8dd51-c77e-495f-83b1-9db1302179b3',NULL,0,0,NULL,1,0,'Robbye_24','Robbye','Helms'),('3748f54e-1cc5-45f4-a7d5-b1cb77028f00',NULL,'Rgasperson@gmail.com',1,'ANRj0LqvUFbinI0w3dy7xPto44E2++x4XEALhSZkheygccapAIist61Vj7tY09DffA==','9007f4a6-3ad9-4007-aa7e-aff0170afed2',NULL,0,0,NULL,1,0,'Jenrob2006','Robert','Gasperson'),('37d0e4b7-a905-4b3b-9048-3dad4a52e1fc',NULL,'grissomrobie@hotmail.com',0,'AOCSfCp3mctLKNKpPfuSFaqMzvej+0EJbWJUekI3mY3ESExtzBjNVjFFIav8rBJTAQ==','ae55b2ba-da74-42cf-b90f-b63f54e2ad80',NULL,0,0,NULL,1,0,'Robie20','Robie','Grissom'),('37efde0c-7727-42c9-af7f-d02fecd7073f',NULL,'spectrallights@gmail.com',1,'AFlzyR99MkThmVHF8uCJixgTwYsaSmmJKvaETGRo39+KWobB/GCXtbL5RyXUfoNGdA==','80365507-a227-4c65-8df5-0462df62b1b7',NULL,0,0,NULL,1,0,'Spectrallight','Danny','Culver'),('3b7e9783-43ad-4c3d-81b4-fe809a15df10',NULL,'spacecrow@aol.com',0,'AEBugdBjC6kbaPBoC+FBe/J6O5w/BRu2Uw9hyJ8vwss6iNbsQZXI29iLjFY5mLQpQA==','5ecd0b87-e444-44b0-950a-ba6c12f56ebc',NULL,0,0,NULL,1,0,'spacecrow','Larry','Caulder'),('3e58cc4f-6898-4d8c-9731-a84dc89f2f2d',NULL,'squeash2003@yahoo.com',0,'AHQ0N/k4gC/+tmrA6iyZjzC+GGxCL0pZBbGZlwdC47+5SFdl6ChaKJzGdegIdlAcJA==','22f65282-4ad2-46e2-8a80-5a5e1dbf611a',NULL,0,0,NULL,1,0,'Sandip','Sandi ','Patrick '),('3f023c6a-02b6-4994-a9f8-e7208d32fb1b',NULL,'icuklop@hotmail.com',0,'AAoRILYoF2Q9/10E6yl2lZcRgayI3yqRbC/dghDx14KWgiC1kY9rU2/CLz74TgJu/A==','759865d0-7565-4e1d-bccf-e34eea90a774',NULL,0,0,NULL,1,0,'mklopens','Mark','Klopenstine'),('43d1853d-01bb-44a0-871c-044d65cd8aad',NULL,'amichalesko@me.com',0,'AAJeHMKSSs6NHWlA4q02sakD6Y6obbhiNBdzJfQ+msVBHNWP42bsWp+Wkn96GN4a2Q==','d4061e00-8ecd-4531-afe0-e8355bb9aaa8',NULL,0,0,NULL,1,0,'amichalesko','Amy','Michalesko'),('43dba1a7-9cd9-4594-894f-beed545b5ccb',NULL,'Lenziallison@gmail.com',0,'AMSzSxPKLg4BB/6A7lkt0lcJ0+WpiiYQTY3DSLtu1W8u2FfAPt+o8+98Hu08mSnXlw==','aa28e5a9-90d6-4e23-acde-e858ae472d81',NULL,0,0,NULL,1,0,'Lenzihome','Allison','Lenzi'),('44f8fb5e-f8a3-48a1-afba-1d27f240752b',NULL,'rosie09@bellsouth.net',0,'ADsAnHbfQwPfBKHD5bJ1990rmKBkh1/a/EvLTIoyD4EmSb5cae8UL8a4ZN6OlY/p1Q==','50220b04-9f71-43b0-9a6e-3843069f2410',NULL,0,0,NULL,1,0,'Rosie09','Rosie','Hopkins-Campbell'),('4b78caa6-943d-4a57-a6ad-930b9fec9e08',NULL,'eetaylor74@yahoo.com',1,'AM5WtP3weEsgWuVj+/WG2VOoEiPkFRDZ96AeCK6mCtzV6zQvIXpYlLaIKhOsu2pfOw==','b72618bb-623e-4522-a567-db56ab5eb226',NULL,0,0,NULL,1,0,'eetaylor74@yahoo.com','Ellen','Taylor'),('4d605084-1054-4585-b401-361a56ef3a68',NULL,'stephanie.b.tinker@gmail.com',0,'AMVuKqMgI77uBlVwdX9dR2Ci/CSPjDwlQZqsrdgk+PRxhE8SxUSQz6wHdJ0mBVQRHQ==','86f617e1-eba9-43c5-ba8c-b0a11b35c5bc',NULL,0,0,NULL,1,0,'StephTink','Stephanie','Tinker'),('4e8966ed-5c90-44dc-907c-68ca0a6fa4ed',NULL,'parkscontractor@aol.com',0,'AAMTZDy1g6/kMM9mLq9vEtPIpyb0obC7rFnEnG+fUjGFhv7bW+lvHGJ+Dt4KoJYKyg==','eb84fb55-dee0-421e-af7f-8e2e58a082ed',NULL,0,0,NULL,1,0,'Parkscontractor','Randy','Parks '),('524d95a4-e506-4489-8402-122869902992',NULL,'nmcbroom@gmail.com',0,'AP9kuqW4rM+vTuhOkolVCikIPC+gLYhZI4YTZKGmx+XDn6if/TxKjIskOcjuzPyoSA==','19839553-61f2-4350-afbb-fd4b150dcf93',NULL,0,0,NULL,1,0,'nmcbroom','Niki','McBroom'),('54a212ce-ea20-4347-a169-76f72905aba3',NULL,'meg@meghanwier.com',0,'AGQns3a6EG415SfRG8/bKhZjxSjdtisC9uwDWFm/aGmLU5OMC1QxfyrzsuOJAcrlOQ==','744223ee-b62a-44e5-b784-da67b0bde204',NULL,0,0,NULL,1,0,'meghanwier','meghan','wier'),('56543503-4fa5-4f00-899e-9c48ec0802ac',NULL,'rwflowers@comporium.net',1,'AJm41Z+vjVUUWUVkofJCF93kJSyldrYcnzlZPMIRKqeZPIvn/OeM+7Cj0JHMBmpUXQ==','4f0b104c-29c3-4c2e-b7a1-0a6c6befef2d',NULL,0,0,NULL,1,0,'rflowers','Robert','Flowers'),('57fb10d2-de8e-4e35-b4b8-5034427f0433',NULL,'eetaylor74@gmail.com',1,'AJloyV+kqALWxrmw1pPeD+8pNY4IY2HzIbmYdCHMzsz/7Ml3GWu3j05Rko2Jl9Nc6w==','7dc24cbb-250f-45e5-96b8-2501d3d9b31a',NULL,0,0,NULL,1,0,'eetaylor74@gmail.com','Ellen','Taylor'),('5dbef02c-3b93-4c55-9971-63b44478c1c9',NULL,'Pwilliams2448@gmail.com',0,'AAz1ECfZK0yF5s52V6+GFUSsuSI5owuXQmSe9z578cuNLx9lWKNXXVvC96jKQHypxQ==','d8f3f42a-217b-401c-9be2-5f9af8f88fe9',NULL,0,0,NULL,1,0,'Pwilliams2448','Patrick','Williams'),('5efb75f5-390e-4dd9-92e7-4c5294d6841a',NULL,'adelling@rhmail.org',0,'AJWPhE0D11QSbV2mojYFnUPXahy17l+LKZsD3flxbtLyH596JY3KEN9YMNCQRBuP9g==','a1bb47aa-bffb-4def-ba7a-fb91c43b9a63',NULL,0,0,NULL,1,0,'markamyd','Cullen ','Dellinger'),('629fa4f3-c681-4044-9cff-6c2b0f08d2af',NULL,'vfulcher@gmail.com',0,'AB0JIb9P8nUhQO2IjdUtY5sw9q7jDugkQaNYjTx+aR/07dQVt6m1kLim2iveloW+cQ==','096b170d-a5e1-439c-9f27-a894c682e544',NULL,0,0,NULL,1,0,'vfulcher','Vanessa','Fulcher'),('64acf003-8222-40ce-9918-87af63d72b14',NULL,'janthony@comporium.net',0,'ANM+U1En6z3v/EaGbILs9ddq5hMHbUV/H+Jn/dbzXY78XrpEcL5OOMk8OjTJtDmV5A==','288d9eba-5ccd-4c13-a694-396283f8f796',NULL,0,0,NULL,1,0,'jackatnite','Jack','Anthony'),('6598cc40-8b32-40e2-98e5-20973dee1aec',NULL,'kikeblades@yahoo.com',0,'AC9/pn9ugSOE0eo0+V7uS2ICjj1mu5Q/4IayZU4u6CFokxlw+7E5dED9fz2w68oODA==','f3f1ad9d-2656-4972-afac-cbe7bdc05ad1',NULL,0,0,NULL,1,0,'Peyton blades','Peyton','Blades'),('65aa4a33-cf54-4e10-831a-a4a5c14321d2',NULL,'janacathey@gmail.com',0,'ALxGu9oW2rZU5sH1x2ZPmPrEYkCZrqj3FBOsNIyMBde1OYCC5RyH7usWnv0wu12tCA==','06511bf2-6c67-4c25-b477-9f22c0642e09',NULL,0,0,NULL,1,0,'janacathey','Jana','Cathey'),('65e78625-6f04-4580-b490-8f30a30aba2a',NULL,'cyndilynn@aol.com',0,'AKx6z/2pjlm3LwjYuJXi6ZToRRy0bzaFtZRsfsK/geddFi/FGKQ/X6jZXSVgs4hBEw==','2052b855-114a-43e4-a88c-6ff7b29ff545',NULL,0,0,NULL,1,0,'cyndilynn@aol.com','cindy','rebman'),('691a0468-3e44-42f7-8181-f51bd92604a4',NULL,'rflowers@saber98.com',0,'ANxWql+kcDQXThMh4OAZty6g6OmdmFgtLSN7bRYJKSEDBNiZqNfS8pAM4JlyvTyANQ==','a3f11bf1-5ce7-40e7-a016-b309980d195c',NULL,0,0,NULL,1,0,'flowersr99','Robert','Flowers'),('6a2fe218-d3d7-498d-9436-23bf743a8046',NULL,'jennwaters107@gmail.com',0,'ACZbfQbxBnakz3mfaqS3fYr9cX2M12JMtACq7fs4MGQN6o0G8R/K+5fgavP7j+oTvQ==','a937feb1-0a93-4a5f-bea5-656d60bf1c30',NULL,0,0,NULL,1,0,'jennwaters107','Jennifer','Waters'),('6a7de375-00f4-49fe-986f-e7f407a4ea27',NULL,'Champusa1@aol.com',0,'AFwc7dVJYezFLqM73fQFZkEThAyTF7j0XHB9/DKhXgzrvEbsB5MR0xbd1V7ZCvuVfA==','e0277817-4ab8-4b44-a30d-cd3ea4d3d927',NULL,0,0,NULL,1,0,'Erollyson0831','Elizabeth','Rollyson'),('6aed5c05-b2cb-40e2-a26d-dbdf184ad864',NULL,'spectrallights@hotmail.com',0,'AFDPuOSY4e7N5xctWjJ2uCn99iUCaT1L5e0ixHEAY7s7XMAuKvUyvrrgblllkQslUg==','b2f0c03f-c1c6-469e-ab9e-71a2262b593a',NULL,0,0,NULL,1,0,'Roenot','DTEst','TEstCUlver'),('6c232435-c11a-4ee0-8249-f62409a64d4c',NULL,'C_scar@yahoo.com',0,'AB+pQNoV491wqgOA2C6kfwrPoboJR3zORU1/V35caTciBb0l5N01HrZDazaYb3X62Q==','e91b1af2-ee0b-4be8-8d48-da49feeadad3',NULL,0,0,NULL,1,0,'Chris Scarborough ','Chris','Scarborough '),('6dd257e5-9f1f-4df9-84be-bf57bb1e9085',NULL,'Rtrclack@gmail.com',0,'ACPkyf/Q0dFdvxi4FsOAA77cbUaZNRHSnVIBPW3lDz1AM7cMpOMtkcA7nbXI85Fy4A==','9625f54c-3650-45e4-9613-15946234d335',NULL,0,0,NULL,1,0,'Cristyclack@gmail.com','Samuel','Clack'),('70d6accd-e02b-4d4c-a588-05bca3da7ce7',NULL,'Gump@rhmail.org',1,'AOK85oN/7AwujrhctJC1EvoIty53vanJpS89T6RaFmnAu1XJ4NdgUTIZ4L8NIVCrLQ==','4669fca7-e09d-4014-919f-4df4891a4a4f',NULL,0,0,NULL,1,0,'StacyGumphrey','Stacy','Gumphrey'),('71789443-abf1-4a84-903f-e733ba3cb1d0',NULL,'Godlygirl11@yahoo.com',0,'AMlEYN4LqmfvoNztIIXT5s45Foi9teDeFZ+ar9C8dLabCQ8XcTBj34+eKVWz6dkbmQ==','632183c8-c556-4c8c-9ffd-e296d2191004',NULL,0,0,NULL,1,0,'yankeeee2009','Alyssa','Lesmeister'),('7b7423a9-c4a1-4ebd-9f7d-6d5a6759b454',NULL,'ncpack132@msn.com',1,'ANB6KmTutvhrsp46WQSP50R9tWPHuVjfTnw+z7yyNFumYmke+IZYgxr633xaeysYGA==','32385f57-4528-4d76-8a0e-6dec0919743a',NULL,0,0,NULL,1,0,'Pack132','Rick','Mitchell'),('7bac523d-c4c4-457a-9b8e-8dc780417e84',NULL,'ktbugggg@gmail.com',0,'AACUUPv0DvszeH3/Ejaced3/6kskk8gjN0s/4sXCAAWjRCHJaLl5fhzvplKQE7yEoA==','a227831f-9c9e-4bd2-8611-cf4c48c8425c',NULL,0,0,NULL,1,0,'wyattjames','Wyatt','James'),('7d898ec5-46b3-40de-8659-286882b5abf1',NULL,'Christine.chavis@yahoo.com',0,'AD5EM3WQo2H9fzCr1iYjqmSBADe7F6zzg4AWJ3ZmqhhdcqsDX66N5MZY3/kxJDvWCg==','26feedf1-12d3-47b8-9b40-2017b1c655f3',NULL,0,0,NULL,1,0,'Chrchavis','Christine ','Chavis '),('82c013da-8935-4573-9ecf-3242af4ef143',NULL,'mcarruth2001@yahoo.com',0,'AFwRrgPgew5rPHoWzKuGGuS9e7qcsiNhuzQ8KpFNJXtJWqN6QMaqdkhux5aZWN/OJg==','f012d100-98d4-4dd3-970e-b4ce50d7f514',NULL,0,0,NULL,1,0,'michaelcarruth','Michael','Carruth'),('8454a5cb-eb52-46fe-b939-23594990a158',NULL,'scoobynurse@yahoo.com',1,'AIVKJjUwkWuRqv/IZ8yYo7NKYm7rtExM5Ds3ip5W7Uxo+z0Cl59G5WYeYVxwzDoU2g==','1d066f1e-46f8-4f19-b58b-b4522bef3a63',NULL,0,0,NULL,1,0,'scoobynurse','Melissa','Daniels'),('84e2f38c-4cf6-4ac5-9d3e-ea77c34322c1',NULL,'fatheads5@hotmail.com',0,'ACzoCL22aAR/D1BdSUwo7HKxLsSDNcIvxcH/zwqqq2/ytz7uvI7SUhEFabrKAXlqUg==','109c4bcf-690a-4cb8-bdab-44e15d675c6c',NULL,0,0,NULL,1,0,'Jessicabennett','Levi','Bennett'),('85ebbc73-ce79-409e-beeb-039d72d92234',NULL,'sierrashome2000@yahoo.com',1,'ANVMvavvRtLsBce5xt6ZVR7NXr1X7GVJEW3w9TSEKyd5f1Nq20yg9zhrLgimRq9MZA==','443b57a7-548c-45f6-b927-b9fffe995784',NULL,0,0,NULL,1,0,'sierrashome2000@yahoo.com','Deana','Williams'),('89e6623b-9e50-404e-a3cc-2beec17ca3f2',NULL,'p_horack@bellsouth.net',0,'AEop3dEkzvsGNl724vJ/GZDKqwdViCVgqQPywzb859TlGdu3Y3zYIY3PM7tzmbtstg==','ef00883c-6c5d-4d5f-8413-3667c73ed144',NULL,0,0,NULL,1,0,'p_horack@bellsouth.net','Pam','Horack'),('8bf2f8da-f88a-4c37-8fc6-f2f20976809d',NULL,'Lgmadonna@aol.com',0,'ADkSuqEZqtNVLWOAiSJr/xa1yzTzWoTT1nmjJUC8q0MJrWrp1xnpNkgxSuL7tXrkiA==','7925be2f-753f-495d-bb00-c039d077ec23',NULL,0,0,NULL,1,0,'KRGGBG6','Kimberley ','Garrison '),('8db7c6aa-24e4-41fc-8b3d-84ee11abd0ff',NULL,'nscutie979@yahoo.com',0,'AA+FO8W3qWD4h9VjUab01+BvLZ8GkBYxpK0/0r/f32bN5ESTZikt0RwUmgOzAFpdng==','febb4c00-4cb4-4b28-9a7a-6278361cc3f1',NULL,0,0,NULL,1,0,'NatashaS979','Natasha','Slack'),('8fd7dc00-62be-469d-9273-aa279cdcedaf',NULL,'robrickey@gmail.com',0,'AFFmdOBCXixYXw/4jP7yWZXjRtf6sH/4LlDVBEWwkDonJmQdSIG/eAPLgKoBTKuang==','a769268f-fb83-45f1-9f15-0e9257bb17d5',NULL,0,0,NULL,1,0,'robrickey','Robert','Rickey'),('9006b136-ee19-42a4-a99a-72e281a445f1',NULL,'wilderbyrde@winthrop.edu',0,'ACWPqKY5EXzmWF5MXu4vPwuMbesDl9/2Hgyxhtwl0s/pS9/BEga8+FPwr4VboOobVQ==','63201aff-b510-42d2-acf3-d4f05e17708f',NULL,0,0,NULL,1,0,'wilderbyrde','Ellen','Wilder-Byrd'),('93ae4117-4290-42f2-8d49-706e58e85eed',NULL,'jenculver@hotmail.com',1,'AE8hMpHWtTNUFavLaiknJvOhfMR6UZSPGJAkfqhJPoVZFZFT1eEkE5+W/QqpUQ2pYQ==','fc4fc0d7-115a-4bbe-bfa4-0a5333bdcf58',NULL,0,0,NULL,1,0,'Jenculver@hotmail.com ','Jennifer','Culver'),('94b3e66b-efd9-4b20-a01e-5ceaa0f25e09',NULL,'timsabella@hotmail.com',0,'AN27Qr/jI6MTzc1w5vmnNEkh4zq/RbCZ43oneUe70hp+6CG5nwzPNPtlbBhHkqjFRw==','3c4d9b2e-9428-46ec-a415-a3d688e9d48a',NULL,0,0,NULL,1,0,'Sabella','Tim','Sabella'),('956d3fb2-f870-4a49-ac35-95f71bf41228',NULL,'sherilichty@yahoo.com',0,'AIe6hoAA24ly6xbMkPplX8XaYeLOAqBt3LJi1+aM9Xl47L39ah/5UVmmrwZlSPVeLw==','99730d1b-5423-44cc-984b-9a3fe5a52a89',NULL,0,0,NULL,1,0,'slichty','Sheri','Lichty'),('9870dc6c-e8e6-482e-aae6-c74e8b4b6bbb',NULL,'asistare@installationsolutionsinc.com',0,'AEoGcXNCk82Keb7a/WxWZYurK+fEY2kYD+qazDo7Sl/XKy5Fr6ddy2aEwdwgjsAxnw==','a515b031-3e19-433b-aa65-f0e609e2647b',NULL,0,0,NULL,1,0,'ASistare','Jackson','Hayes'),('9effa591-c078-4828-b290-914d456c2943',NULL,'eric_susan_george@yahoo.com',1,'ALxcXSc8R1SKcimQh679m8FABw9NUmtnasQX3Bi1kZwZkArAWMsOc3b0T2DTT/+dkQ==','283a701b-ebf4-4734-905c-5a4284bf7afe',NULL,0,0,NULL,1,0,'ericjaco','Eric ','JACOBS'),('9f357deb-5b1e-4fdb-a1c5-4affeeea43f4',NULL,'Cristyclack@gmail.com',0,'AMYwjGRJe0iGUFGbeKklV/+tkTIfoT3fxaUekyKEudt7P2fqp0vxCiUSa/lS6/OFag==','f64d9aae-ed17-40ba-b975-ae5302ad7074',NULL,0,0,NULL,1,0,'Cclack1204','Cristy','Clack'),('a02dae7b-ca1a-4669-a1b5-def033a815cc',NULL,'cartermiller@bellsouth.net',0,'AKeFK9Dz7IGQpt4RoMj/Ff2zq8dNN5xSnhkDRJ7QcFwFxA092XMaKEVKyoBa7w2A+A==','b40b5718-e768-41ea-bce4-3a865ee4c116',NULL,0,0,NULL,1,0,'ScoutMaster1280','Paul','Miller'),('a2794caa-344a-4a61-9419-e829e9d7b3da',NULL,'littlehickorynut2@yahoo.com',0,'AOjyq9NYWUUTkqSDGvOfFtl2N5qVrpcs990bvGQceSIGdoVSmpFoYlzxdKE4ci6ODA==','9c801d4f-6373-4a71-b210-0cf13691c0e1',NULL,0,0,NULL,1,0,'littlehickorynut2','Lisa-Anne ','Williams'),('a2b96ccd-b82c-4159-b2af-f8c83fe0f2ab',NULL,'karahawkins@email.com',0,'ADakaQNYRE0sDb2MYcPgtvXg4krmuPWrOwBubDQVyvkmBzsYPoCPTkkt7J7JRypVzQ==','5346b43e-8d82-4f63-8847-b3518da4f147',NULL,0,0,NULL,1,0,'karahawk','Kara','Hawkins'),('a3443ba5-b5d6-47b1-831d-799c1ff19117',NULL,'Kristypowell4q9@gmail.com',0,'AEoI/SAownKVIKUjaPtTEs/+rZx08P+l8yEC+9RRMywWOG9Xt3alOdbPU+vjjOhZow==','62d049cb-f032-4f36-848d-87592c52ec47',NULL,0,0,NULL,1,0,'Kristypaul','Janice','Chadwick '),('a68de879-40c7-4869-8a67-91509ce726a5',NULL,'cynjackson24@aol.com',0,'AOgOyEf9umr1KIQ0M29/qZg+wWN8HxPFAlR66BC+/tka2UcrgDHxKmM2ufV9O6AhOQ==','52a6d547-e38c-4389-8fec-b521a22e7a23',NULL,0,0,NULL,1,0,'cynjackson24','Cynthia','Jackson'),('a7f18707-9f59-4a25-92aa-01bb0d620522',NULL,'calexander101299@gmail.com',0,'AG7U2zSVNzJP5nsqA6mqNl9IjUDOW33AAVU1iiYUnljp54vqwzRpCRlv7ujfLTKlQQ==','dc42c6c6-4fc0-49c4-8c9c-5411b384cbfa',NULL,0,0,NULL,1,0,'clintalexander','Graham','Alexander'),('a9d7bf94-6c4e-4f1c-9cac-a29a8f78dd12',NULL,'Paulpowell419@gmail.com',0,'AGZy3VM0Uo5JK7p7edPN5sceLqmZNlVQMAaFAK854KeN6O3GS2KAiEHGeuUHTzlCFA==','011b1d47-d57b-4453-8dce-7f95ded32319',NULL,0,0,NULL,1,0,'Paulpowell419','Paul','Powell'),('adf31776-af06-41f0-8da7-3259af1b3625',NULL,'prettyman5@live.com',1,'APbgacFlU/fRTkE9A9XqcIZt+rMINJv72XY9SbHTp7j/hS4o33fegF3/u/XXg/kU0w==','1b7c9af4-10ac-47e3-8195-ea2f0a00c9b9',NULL,0,0,NULL,1,0,'prettyman5@live.com','Manda','Prettyman'),('af0d61f4-186c-4d25-9cbd-756b31ad6c4a',NULL,'pinkhippo1978@aol.com',0,'AGW+e38qkrQ+5TrIgl7IeammFiTf51rlK1aA1fqd7sZlPyBsOqgeMTBclur1YN/vgA==','c723cd4b-3d6e-4848-aae2-6ec8809f2a99',NULL,0,0,NULL,1,0,'pinkhippo1978','Karen','Brogdon'),('b016cf73-eb43-40aa-98c5-f0cdedc39e90',NULL,'apaige2238@yahoo.com',0,'ADH1yX4F0FIhyfGbCQGsP9n1u3tWflQB5JyLpBIE0q7/ZOrSf6LaPxUGVyrGAc74QQ==','afd2f5f5-73cb-454d-8bf1-a60d18c49c26',NULL,0,0,NULL,1,0,'apaige2238','Amber','Paige'),('b1be1e28-23a3-45e4-a380-18bfbb88d914',NULL,'brysonheights@hotmail.com',0,'ACwvHj9mTjzB3udk4Aickt541tln9+OQPxi2vTMZ+rjkMD3RIph0+XXPgJn+bmJDGw==','01265bf1-7eb5-4801-b970-9923c2006f75',NULL,0,0,NULL,1,0,'Monicabm1','Monica','McCoy'),('b1e1fb41-6598-496d-a1db-148b75527d3a',NULL,'copeba@alumni.clemson.edu',0,'ABBdl5j3k5Qm9NTp7GxSUn/0QxHD+pyKBJ1s2URodlyRgpwv8JDyPYO1ISL5CEZ5fw==','5d2bc3c3-c3e2-4294-b35a-f3a36adf57f0',NULL,0,0,NULL,1,0,'copeba@alumni.clemson.edu','Brian','Cope'),('b242b792-2091-4a8f-99da-9f8cb018f895',NULL,'taylor.thomas@scouting.org',0,'AC1sFpNyzRlsk2UG1gpKB1FL4MztkK0ePyw6YPfsksTjyQaAWNULnN5jIYhzgVaAbg==','51598e07-09a0-41e6-aafe-994444c8fa35',NULL,0,0,NULL,1,0,'thomastm','Thomas','Thomas'),('b4ac2b41-5bb9-46a4-9653-ef209bf0d23a',NULL,'rocco.bacelli@yahoo.com',0,'ADzyRwM40rV8uvN6RxiSiuECjsniHxdEg0f4xXgAJdlsZAnkz9fQRDKxTfPD8LgKtA==','e1b0a90d-2014-4ab2-9674-4aee0b9d412f',NULL,0,0,NULL,1,0,'daltonmom2','Samantha','Dill'),('b5854529-ac7b-4d53-bc69-a4a063f00c6e',NULL,'Kelly_rockhill@yahoo.com',0,'AA85NHLsleFspbyronlq8QWmlQGTXWDFjINJJzl4kSe7B9SDzJh3YDIOcpHgO+ysUw==','80c8fffc-f585-4cd5-b19f-e5b271c9949d',NULL,0,0,NULL,1,0,'Kelly_rockhill@yahoo.com','Kelly','Schifferle'),('b70dfb96-8a33-4fa2-bf77-a7633eb971c1',NULL,'willisrljr@comporium.net',1,'AHFvp2d+ABctnzVUW1q6IzQzRrJJ/robHzZAIdAg7qDjaHo6Zo0W3Y7Nh8QOBZh8hA==','a4619db0-2fe4-46e2-9b2c-47081dc1cea4',NULL,0,0,NULL,1,0,'willisrljr','Robert','Willis'),('b8842823-0da8-4a88-bdce-25c155d0f951',NULL,'TaraBurgess@comporium.net',1,'AEAHvp/rlMZRW781YWZl4Vtd4PfbaWJJwME/6MQ5fLudOpyP6mn2XnJA1TXYHXvWPA==','b754d23f-161b-440b-acea-62f63ad54aed',NULL,0,0,NULL,1,0,'TaraBurgess@comporium.net','Tara','Burgess'),('b9c18fb8-f02d-42e3-b9e2-c8a6a291588c',NULL,'christy.auburn@gmail.com',0,'AIQY34+WUDqqaRaxGmTi5f6B6JDqwF7XPFgR7Ir/v7XW7NjGrQ7jg3Q5Hezebma/tQ==','3f47d864-2e78-4a56-9683-8169770e9e50',NULL,0,0,NULL,1,0,'christyauburn','Christy','Moore'),('ba690cfe-47be-415f-bf8a-dc266f003c83',NULL,'nancy_Carruth@belk.com',0,'ABRLO5/y1nYzAJ1PuSEUMi6u3H/xBphGVYrypmfNxuRLkwc8GKnjvEis6QQDHa6HbQ==','a0807d13-7964-4ada-ab8c-095de284af25',NULL,0,0,NULL,1,0,'ccarruth','Cole','Carruth'),('ba6b053a-72c6-423d-b5ec-9ec885a27d60',NULL,'stephen.burkell72@gmail.com',1,'AFqbRnf4vJd7GkZhrzSclEunlzsmbj4gJ12S4RovVXnrQdyk+l1pp+UU25Z8+kMPVg==','edfda54b-02cd-4a87-8957-ec270a21a5bf',NULL,0,0,NULL,1,0,'sburkell','Stephen','Burkell'),('bc2fcec9-b39c-4f02-9e1f-5cdb86e734e7',NULL,'twins63008@hotmail.com',0,'ALD7PkBvlMjPwX2p3FGebxDW9aAAnVNS2p1SdK3xMeqdeN8IAt25izZp930oDrM3cQ==','7f69465a-a78d-4ff4-9d1f-af97f41f580f',NULL,0,0,NULL,1,0,'FuehrerSC','Eric','Fuehrer'),('bddce3b0-72a9-4d93-bc54-fca1faa1a0f1',NULL,'dbfletcher55@gmail.com',0,'AG70gwqLSVZT5/xUg61j13CvjE35VmRfPJLOYKYX7aeiWuOqOQ/sU74fgnLjM9/ISg==','d6e8d84c-ac59-43ab-aa6e-be2c990c2759',NULL,0,0,NULL,1,0,'dfletc00','Donna','Fletcher'),('beb6666a-30ee-41ae-aaa6-5c487c8f04c8',NULL,'jmsageser@hotmail.com',1,'ANyzLQYtENMtT4EZVner++FoyhuIeCWFxTpDekPfMb6YI1dJwhz0iTrZ9cEQV4f5ow==','09962449-33b3-4e07-bada-2a7d99dd8762',NULL,0,0,NULL,1,0,'jmsageser','Jane','Sageser'),('c4e433a8-b04e-4e7b-b760-610962c2a365',NULL,'dhunt88@live.com',0,'AMVO5Nyzh252X3NNbwgSnjlMHoz+h+4/cwL4IH+/KZk5UQ7LloH1lJ+nvMApaGzsqw==','38cc0512-40b9-48e5-b1ea-a51476438fe9',NULL,0,0,NULL,1,0,'dhunt88','Davidh','Hunt'),('c843814f-0f1c-432f-8abb-9c201ba9d388',NULL,'darrellm27@att.net',0,'AOQZ7WkxF3M/eFouYL1dqqUijSCbFcTB01mluIHfj4ZXNNXSb87rqOB9/dsZ5HRZgA==','f9d56289-ae4d-4471-8387-725cfbbf25a5',NULL,0,0,NULL,1,0,'Towtruck11','darrell','mcdaniel'),('d39a1a6d-4a9a-4df2-89d9-e7760a0b4105',NULL,'cschweninger@outlook.com',1,'ADeTahPywQrXFPaUS1iKc+btVrAP5i4a0hQx6DMwGFosadILAaQfS6kedlKsgpjmdA==','2047afe8-3249-4f98-8e28-bfb99d2d442c',NULL,0,0,NULL,1,0,'Christopher S','Christopher','Schweninger'),('d632527c-5f7f-4d39-96e7-507748c69daa',NULL,'frankcarns4@gmail.com',0,'AKiIyEaBegCGHYQfkvJlcnPYLdFGhIuKnX18JCYKdiB7uJDciN/YsJayruMd0/MMIA==','aa3d0510-bd00-43fd-9d26-198aa8ee78dd',NULL,0,0,NULL,1,0,'Frankcarns4','Frankie','carns'),('d99295d8-33bf-499b-986d-b837daf837b9',NULL,'cacinance@hotmail.com',0,'AIudEds7WgeiuMX6XuCmYXMA4vr63KQz5Oz5JO2vSye6TSk5IzsGncml/Lg8mWwPow==','dd6ba4c6-b0fe-4257-a6ae-6ae2b3e8e13a',NULL,0,0,NULL,1,0,'Cnance','Caci','Nance'),('dac31629-2bf6-42d9-8c28-c38cb98b8e97',NULL,'ngreen7992@gmail.com',0,'AKfwY9tG8LuOZoH/SR7SYBUNeXiPd1dKXpkKCShNdB/5kqnQlNx4b/pRXkpGSoD/OA==','940cd3e7-cb66-4109-bb82-237625a15c86',NULL,0,0,NULL,1,0,'Ngreen7992','Nathan','Green'),('dbd65d40-5f14-4fec-9505-48297cfa9d8b',NULL,'Richardemyrick@yahoo.com',0,'AIE3oFR9lFyUKoq696K9tOzPZKoiP2cIFWvoAxBczTcvxaiEoXynGPX4ppHuYxdRJQ==','17d05bde-e9d7-42b0-b152-fdf227522a54',NULL,0,0,NULL,1,0,'Richardemyrick','Richard','Myrick'),('dc8d0d50-0b0b-436d-b1c8-39ead1ad56fe',NULL,'mandaprettyman@gmail.com',1,'AB0QwiMywggb3t5AFysSnKEW4IHZpbqD/oo5vBqQJD6fXIftm6Sqym8URSpjx+CSIg==','3cb9807b-d657-4709-87b4-bbe28eb6ae08',NULL,0,0,NULL,1,0,'mandaprettyman@gmail.com','Manda','Prettyman'),('ddd8df6f-21a1-472e-9de9-becf06141633',NULL,'blairbigger@hotmail.com',0,'AIbyox1u73jx0GwV8M33rjU8K46bN2KVnD4frHxEFtpp6VoU4ZqUTkE4qZ3J2R6V7g==','6e300e61-ad47-4b77-b4dd-a7a13819f26f',NULL,0,0,NULL,1,0,'BlairB','Blair','Bigger'),('df8f6008-0a3d-46a8-81d9-6bc1938f05f1',NULL,'nflproductions@hotmail.com',0,'ANsZ+vw+3IT5EqCdzMcEcvwIcBB1A4SxDnWuTf+EYI/k6a8BbWFFYeuTZdO606WugA==','ad84e09e-e134-4525-997f-17ee6cbe4c54',NULL,0,0,NULL,1,0,'DallasCowboys','Fred','Campbell, Sr.'),('dfed82f7-1f3c-4b61-b207-78b34370a283',NULL,'samantha_dill@yahoo.com',1,'ALxBHwdJEK5YLKfsF2oOR+mwIuxt664yrJj5KaNqqJEyw3cJ5AoYKiSgkeSv7r8GbQ==','6c37683a-7315-4720-adf3-8fc853123032',NULL,0,0,NULL,1,0,'Daltonmom','Samantha','Dill'),('e14a5238-4db8-42a0-94f0-b32ea4e5d6c6',NULL,'duree78@gmail.com',0,'AAB3gK2rnbYJR2NtkPIcHWSJo2ni8nt25Gpxw6io4rMe7iIuNj4xPS57S4I0pVFxYg==','7f2d6fd8-1284-4960-95a0-cc22e1a03cc8',NULL,0,0,NULL,1,0,'DureeLove','Duree','Love'),('e640ea8a-c21e-4a7c-9f7d-08c07c0a0458',NULL,'mcarruth@comporium.net',0,'AP0K4EF09+CntHf5fiTLOvSy1Ek1e38LjtzifuIW98LzNWy04a3JH9UuvI0aex9F2g==','7de4c38b-2092-496c-92cb-d5942bddca5a',NULL,0,0,NULL,1,0,'mcarruth','Nancy','Carruth'),('e6a43d37-3483-486e-91de-e5a1907a0bb0',NULL,'robinyoungh@yahoo.com',1,'AIQp/Pyxiqak9ikU7toHVfoDvQFLKy42r0huNWcTE01oJkQziUALen/7byLwFDdIlw==','cc4defed-24fe-4946-b038-c05c06283d31',NULL,0,0,NULL,1,0,'robinyoung','Daniel','Collins'),('e8c8aeb6-b008-4675-908e-1b3c09999558',NULL,'Ramsey8487@me.com',0,'AK8TFare0p/wWqf0RkPVfymx5COg4Qb5QBDwUeXEi/o2JDUsxK4mOKNW8b+8UZzwzQ==','18feeb11-94e4-40e6-998f-a09486c6da02',NULL,0,0,NULL,1,0,'Ramsey8487','Amber','Ramsey'),('eacb2c2d-a7eb-41c2-97cd-ef34152bc123',NULL,'fcampbel@rhmail.org',0,'AMFO8yB5t1EdI60yh0us/eV6xiSp8N1eYI6xB6XM4uHjCdW0UeI+snn4raqxKPvxVw==','1340294a-d9a8-400c-ba6b-c99a3432b37e',NULL,0,0,NULL,1,0,'FreddyBear','Frederic','Campbell'),('eb642bfb-ea0f-463b-b5ec-51aa3c011691',NULL,'nmsmartinez@msn.com',0,'AMddZeRoCNUbTq13mT3RMlfHQocS3mToSbrWR+nEGmzLp/mL70sj2mE8WmIPqeiGiw==','ac61993d-c568-4ef6-8b8e-b81a9edb668b',NULL,0,0,NULL,1,0,'nmsmartinez','Sara ','Martinez'),('f03d24db-f39f-4e99-953b-4531e9771f6a',NULL,'bkhowe803@yahoo.com',0,'AC56u0ZdEaO9tZddRbO4iDiLMJ3IN6+/DMRLo2vE8Afg+Ng1rMwQfOO/TNjkBdEP+A==','94589d0f-bf25-493f-a1f7-c2571ba8d6b1',NULL,0,0,NULL,1,0,'bkhowe803@yahoo.com','Brenda','Benton'),('f4a05e5f-0a86-436e-b442-c27332078ec5',NULL,'dchastain@comporium.net',0,'AJyDM1zzCuaXZTNKPVlP0mLIEkW+tHxhx7/I3rgbZw12e5roB16/vj8TwEBi8mj2LQ==','5c82553b-e818-44f1-a60e-cebddc654b42',NULL,0,0,NULL,1,0,'mchastain','Martha','Chastain'),('f65ea58e-b319-43ff-9d12-41c766e2e68b',NULL,'amyflowers75@gmail.com',0,'AMOpBabYbHGGXV/uPcMIRl1kAWhPiZmoh7rIiIjy+lR4fvxtuNUnfR0tomuw8no+IA==','a6655fc5-9f61-4423-ac52-5bc5e6e9bd1e',NULL,0,0,NULL,1,0,'aflowers','Amy','Flowers'),('f7580f59-4b50-42d5-a8ec-d1867ab515f9',NULL,'cdwhisonant@gmail.com',1,'AKosYkXcNu9XO7yTGAeS+Vvj2Fj2ERPbztmGhEVrtxPMS1gH3iNj9/SmV5ns72SecQ==','2d2a5a9e-5df7-410d-8602-4ba8f375f3fb',NULL,0,0,NULL,1,0,'cdwhisonant','Cathy','Whisonant'),('fa4a17cb-924b-4f92-b1e9-a447c1b4ec64',NULL,'constance.booth310@gmail.com',1,'AFxvDPN39FjAgHHTI4T5DWCih+2YxtOY77jYFDEAJRscozNUuLnWjpjxB3Bh3Dq2cw==','2b6a3d73-9f8c-4c69-b95f-e5923435560a',NULL,0,0,NULL,1,0,'boothconnie','constance','booth'),('fad12849-4667-46ed-b8b1-e8372345b8ae',NULL,'Jeancarlo@jcoversight.com',1,'ACrXpt2Vd5T5nhy12uPUinfWvxeoVIpQshL5a/iNJELPug1riI+bNUB8hEtZRFzbUQ==','71f77c6f-fe39-41ba-80ae-9ad6545b96fb',NULL,0,0,NULL,1,0,'JCTheKid','Jeancarlo','Cayo'),('fe9c51fb-147b-4e12-8f4c-5ed06aef8859',NULL,'Denisecubb@gmail.com',0,'AITdMP6lDc7DPu+r9TmDRK0kLg7CxuFNkMZCNu+ukD8RJA46S0zIfgWQa0A90D9agw==','c0cf4242-5690-4414-8e15-2560f1d0cc2a',NULL,0,0,NULL,1,0,'Denisecubb','Denise','Cubbedge');
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
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactinfo`
--

LOCK TABLES `contactinfo` WRITE;
/*!40000 ALTER TABLE `contactinfo` DISABLE KEYS */;
INSERT INTO `contactinfo` VALUES (1,'Bethelwoods','803-366-3722',NULL,'info@bethelwoods.org','922 W. Mount Gallant Rd.',NULL,'York','SC','29745'),(71,'ROBERT FLOWERS','8039845211','8039845211','flowersr99@gmail.com','1026 W. Mount Gallant Rd.',NULL,'York','SC','29732'),(72,'Danny Culver','8033714425','8033289938','spectrallights@gmail.com','2270 Eastview Road',NULL,'Rock HIll','SC','29732'),(74,'Jennifer Culver','8034487564','8034487564','jenculver@hotmail.com','2270 Eastview Rd',NULL,'Rock Hill','SC','29732'),(75,'Deana Williams','8036310607','7046812626','sierrashome2000@yahoo.com','6340 Royal Pines Dr',NULL,'Clover','SC','29710'),(76,'Manda Prettyman','8036270085','3364373820','prettyman5@live.com','7064 Sonja DR',NULL,'Clover ','SC','29710'),(77,'Manda Prettyman','3364373820',NULL,'mandaprettyman@gmail.com','7064 Sonja Dr',NULL,'Clover','SC','29710'),(78,'Samantha Dill','8039847518','8039847518','samantha_dill@yahoo.com','508 Sansberry Drive',NULL,'York','SC','29745'),(79,'Tara Burgess','8034933829','8034933829','TaraBurgess@comporium.net','607 Pondway Downs',NULL,'Rock Hill','SC','29730'),(80,'Robert Gasperson','8034931958','8034931958','Rgasperson@gmail.com','2534 Fire Tower Rd',NULL,'Rock Hill','SC','29730'),(81,'Sonia Colon','8032309796','8032309796','Soniacolon@yahoo.com','834 Von Buren Blvd',NULL,'Rock Hill','SC','29730'),(82,'constance booth','7047409231',NULL,'constance.booth310@gmail.com','125 bollin circle',NULL,'fort mill','SC','29715'),(83,'Rick Mitchell','803-328-9523',NULL,'ncpack132@msn.com','2175 Hall Spencer RD',NULL,'Edgemoor','SC','29712'),(84,'Thressa Elam','8033716950','8033716950','Thressaelam@gmail.com','1559 Springpoint Rd ',NULL,'Rock Hill ','SC','29732'),(85,'Nicole Flippin','8033247740','561-602-1464','nikflippin@bellsouth.net','2739 Lake Wylie Drive',NULL,'Rock Hill','SC','29732'),(86,'Stephen Burkell','2525147404','2525147404','stephen.burkell72@gmail.com','2818 Hord Rd',NULL,'York','SC','29745'),(87,'Jane Sageser','8035470594','8034316695','jmsageser@hotmail.com','108 Melrose Ct.',NULL,'Fort Mill','SC','29715'),(88,'roy boyd','803-230-0143','803-230-0143','royhboyd@gmail.com','1101 Neelys Creek Road',NULL,'Rock Hill','SC','29730'),(89,'Katherine Hylton','704-519-7959','704-519-7959','Katiehylton@gmail.com','121 W Gregg St',NULL,'Fort Mill','SC','29715'),(91,'Daniel Collins','803-981-0823','803-984-0823','robinyoungh@yahoo.com','3747 Walker Rd',NULL,'Rock Hill','SC','29730'),(92,'Eric  JACOBS','8034870972','8034870972','eric_susan_george@yahoo.com','170 Whitleymills rd',NULL,'Fort mill ','SC','29708'),(93,'Robert Flowers','(803)628-1949','(803)984-5211','rwflowers@comporium.net','1026 W. Mount Gallant Rd.',NULL,'York','SC','29745'),(94,'Christopher Schweninger','(803)487-5856','(803)487-5856','cschweninger@outlook.com','1413 Gordon Rd.',NULL,'Rock hill','SC','29732'),(95,'Melissa Daniels','8038106340','5857377808','scoobynurse@yahoo.com','226 Brown PElican Court',NULL,'Clover','SC','29710'),(96,'Jeancarlo Cayo','704 488 6313','704 406 7975','Jeancarlo@jcoversight.com','14624 Arlandes Dr',NULL,'Charlotte','NC','28278'),(97,'Ellen Taylor','5203000407','5203000407','eetaylor74@yahoo.com','3157 Tanglewood Dr',NULL,'Rock Hill','SC','29732'),(98,'Stacy Gumphrey','8034485957',NULL,'Gump@rhmail.org','1020 Our Road',NULL,'Rock Hill','SC','29732'),(99,'Ellen Taylor','5203000407','5203000407','eetaylor74@gmail.com','3157 Tanglewood Dr',NULL,'Rock Hill','SC','29732'),(100,'Cathy Whisonant','803-417-8220',NULL,'cdwhisonant@gmail.com','1572 Brandyhill drive',NULL,'rock hill','SC','29732'),(101,'Robert Willis','8039855584','8035176532','willisrljr@comporium.net','4062 Timber Crossing Dr.',NULL,'Rock Hill','SC','29730'),(102,'Robbye Helms','8033272641','8034172513','Robbye_24@yahoo.com','1521 W Decatur Dr',NULL,'Rock Hill','SC','29730'),(103,'Robert Flowers','8039845211','8039845211','rflowers@saber98.com','1026 W. Mount Gallant Rd.',NULL,'York','SC','29745'),(104,'DTEst TEstCUlver','8033714425',NULL,'spectrallights@hotmail.com','2270 Eastview Road',NULL,'Rock hill','SC','29732'),(105,'Amy Flowers','8039845210','8039845210','amyflowers75@gmail.com','1026 W. Mount Gallant Rd.',NULL,'York','SC','29745'),(106,'Mark Prescott','803-818-4455','803-322-6053','msprescott5@live.com','1218 Applewood Lane',NULL,'York ','SC','29745'),(107,'Jacquelina Cox','8036100112','3364607987','Amara278@gmail.com','2081 ROSCOMMON DR',NULL,'Clover','SC','29710'),(108,'darrell mcdaniel','8035246895','8035247823','darrellm27@att.net','1737 kenneth dr',NULL,'rockhill','SC','29730'),(109,'William McCorkle','(803)280-5194','(803)280-5194','amccorkle@gmail.com','116 Front Porch Dr',NULL,'Rock Hill','SC','29732'),(110,'Brian Cope','803-818-1053','803-818-1053','copeba@alumni.clemson.edu','200 Blue Heron Dr',NULL,'Rock Hill','SC','29732'),(111,'cindy rebman','757-831-6132','7578316132','cyndilynn@aol.com','1744 Betony Lane',NULL,'Tega Cay','SC','29708'),(112,'Thomas Thomas','8035198262','8035198262','taylor.thomas@scouting.org','151 Fernwood Drive','Apartment 151K','Spartanburg','SC','29307'),(113,'Amber Ramsey','8034488943','8034488943','Ramsey8487@me.com','512 sansberry dr',NULL,'York','SC','29745'),(114,'Sandi  Patrick ','8039815009','8032306937','squeash2003@yahoo.com','805 Bubbling Brook Drive ',NULL,'Rock Hill ','SC','29732'),(115,'Donna Fletcher','8033660150','8034871930','dbfletcher55@gmail.com','722 Catchpoint Drive',NULL,'Rock Hill','SC','29732'),(116,'RONALD FLETCHER','8033660150','8033660150','ronaldfletcher1990@gmail.com','722 CATCHPOINT DRIVE',NULL,'ROCK HILL','SC','29732'),(117,'Natasha Slack','803-524-0041','803-524-0041','nscutie979@yahoo.com','7107 Moores Creek',NULL,'Rock Hill','SC','29732'),(118,'Chase Higgins','803-524-0041','803-524-0041','nscutie979@gmail.com','7107 Moores Creek',NULL,'Rock Hill','SC','29732'),(119,'Stephanie Tinker','8034484976','8034484976','stephanie.b.tinker@gmail.com','735 South Cherry Road',NULL,'Rock Hill','SC','29732'),(120,'Michael  Feimster','7048078265','7048078265','Price@designbrothers.com','330 shurley st',NULL,'Rock hill','SC','29732'),(121,'Jackson Hayes','7047733551','7047733551','asistare@installationsolutionsinc.com','628 Wamsutter Ln',NULL,'Rock Hill','SC','29730'),(122,'Calvin Lyle','8033704043','8033704043','Cassieclark415@gmail.com','2310 wildwood dr',NULL,'York','SC','29745'),(123,'James Parrish','8034484510','8034484510','tparrish@goencompass.com','3989 firethorn lane',NULL,'Rock Hill','SC','29732'),(124,'Cara Rohlfs','704-236-9775','704-236-9775','cararohlfs@gmail.com','105 Melrose Ct',NULL,'Fort Mill','SC','29715'),(125,'Karen Brogdon','8033603241','8033603241','pinkhippo1978@aol.com','1890 Neely Store Road',NULL,'Rock Hill','SC','29730'),(126,'Cynthia Jackson','803-627-0005',NULL,'cynjackson24@aol.com','628 Drury Lane',NULL,'Clover','SC','29710'),(127,'Glenn Stoner','8645904432','8645904432','lakedude@bellsouth.net','476 Squirrel Lane',NULL,'Lake Wylie','SC','29710'),(128,'Larry Caulder','8032304389','803-230-4389','spacecrow@aol.com','2808 Wilmington Circle',NULL,'Fort Mill','SC','29715'),(129,'Jacob Bendt','8032302120','8034486174','TheBendtFamily@Comporium.net','1100 Hearthstone Ct',NULL,'ROCK HILL','SC','29732'),(130,'Duree Love','7046617636','7046617636','duree78@gmail.com','1875 Davis Circle',NULL,'Clover','SC','29710'),(131,'Nathan Green','3046177992','3046177992','ngreen7992@gmail.com','105 Benfield Ave',NULL,'York ','SC','29745'),(132,'Ellen Wilder-Byrd','803 366 4354','803 984 6070','wilderbyrde@winthrop.edu','395 Shurley Street',NULL,'Rock Hill','SC','29732'),(133,'Brenda Benton','8039849894','8039814994','bkhowe803@yahoo.com','1968 Pinevalley Rd',NULL,'Rock Hill','SC','29732'),(134,'Jesse McGee','3363171265','3363171265','Tarheelmcgeeunc@yahoo.com','2310 Meadow Sweet Way','Apt 202','Fort Mill','SC','29708'),(135,'Sara  Martinez','5059750509','5059750509','nmsmartinez@msn.com','1159 Ross Brook Trace',NULL,'york','SC','29745'),(136,'meghan wier','8034125770','8034125770','meg@meghanwier.com','1224 stonecrest blvd',NULL,'tega cay','SC','29708'),(137,'laura cripe','8037464795','8037464795','laurac@comporium.net','233 loch stone',NULL,'Fort Mill','SC','29715'),(138,'Samuel Clack','8039843119','8039843119','Rtrclack@gmail.com','161 WEATHERWOOD ST',NULL,'ROCK HILL','SC','29732-9152'),(139,'Sally Baker','8034484516','8034484516','siwbaker@gmail.com','1218 Thornwell Avenue',NULL,'Rock Hill','SC','29732'),(140,'Robie Grissom','8033709037','8033709037','grissomrobie@hotmail.com','191 E.Springdale rd',NULL,'Rock hill','SC','29730'),(141,'Frankie carns','7042806392','7042806392','frankcarns4@gmail.com','7402 Sheffingdell drive',NULL,'Charlotte','NC','28226'),(142,'Patricia Swoope','(803) 329-3439','803 554-0252','paswoope@hotmail.com','662 cannon drive',NULL,'Rock Hill','SC','29730'),(143,'Kara Hawkins','7049058648','7049058648','karahawkins@email.com','2570 Aspen Terrace',NULL,'Rock Hill','SC','29732'),(144,'Amy Michalesko','4105332901',NULL,'amichalesko@me.com','3158 Amaranth Drive',NULL,'Tega Cay','SC','29708'),(145,'Allison Lenzi','(910)520-5594','(910)520-5594','Lenziallison@gmail.com','5036 Sequoia Drive',NULL,'Rock Hill','SC','29732'),(146,'Randy Parks ','(803)415-7086',NULL,'parkscontractor@aol.com','2884 Chapman Circle ',NULL,'Rock Hill ','SC','29732'),(147,'Delete ME','8033714425',NULL,'yorkdaycamp@gmail.com','2270 Eastview Road',NULL,'Rock HIll','SC','29732'),(148,'Wyatt James','8034145955','803-414-5955','ktbugggg@gmail.com','5806 Fiesta Road',NULL,'Lake Wylie','SC','29710'),(149,'Jana Cathey','7045341723','7045341723','janacathey@gmail.com','1016 Swaying Oats Dr',NULL,'York','SC','29745-6392'),(150,'Amber Paige','8033893199','8033893199','apaige2238@yahoo.com','491 Lexie Ln.',NULL,'Rock Hill','SC','29732'),(151,'steven schweninger','(803)524-5219','(803)412-6054','stevenjr@comporium.net','1413 gordon rd',NULL,'rock hill','SC','29732'),(152,'Kristy  Powell ','8038995350','8038995350','Kristypowell419@yahoo.com','465 S Shiloh rd ',NULL,'York ','SC','29745'),(153,'Paul Powell','8038994841','8038994841','Paulpowell419@gmail.com','465 S Shiloh rd',NULL,'York','SC','29745'),(154,'Janice Chadwick ','8038995350','9106122068','Kristypowell4q9@gmail.com','465 S Shiloh rd ',NULL,'York','SC','29745'),(155,'Nancy Carruth','8034932387','8034932387','mcarruth@comporium.net','285 Peachtree Rd',NULL,'Rock Hill','SC','29730'),(156,'Niki McBroom','8032886536','8032886536','nmcbroom@gmail.com','1280 Pinewood Road',NULL,'Rock Hill','SC','29730'),(157,'Michael Carruth','8032420504','8032420504','mcarruth2001@yahoo.com','285 Peachtree Rd',NULL,'Rock Hill','SC','29730'),(158,'Cole Carruth','8034932387','8034932387','nancy_Carruth@belk.com','285 Peachtree Rd',NULL,'Rock Hill','SC','29730'),(159,'Christine  Chavis ','8033281585','6145063450','Christine.chavis@yahoo.com','4010 Galleria Pointe Circle ',NULL,'Rock Hill ','SC','29730'),(160,'Jennifer Waters','8034480880','8034480880','jennwaters107@gmail.com','3031 Sunshower Hts',NULL,'York','SC','29745'),(161,'Cristina Renzoni','8032090050','8032090050','xtinavincent80@gmail.com','1652 Old Nation Road',NULL,'Fort Mill','SC','29715'),(162,'Kimberley  Garrison ','8036274640','8036274640','Lgmadonna@aol.com','553 sandifer rd ',NULL,'York ','SC','29745'),(163,'Vanessa Fulcher','8034873292','8034873292','vfulcher@gmail.com','2335 Sparrow Dr.',NULL,'Rock Hill','SC','29732'),(164,'Blair Bigger','8034122867','8034122867','blairbigger@hotmail.com','2180 Nighthawk Dr',NULL,'Rock Hill','SC','29732'),(165,'Graham Alexander','8034483972','8034483972','calexander101299@gmail.com','2639 Aspen Ter',NULL,'Rock Hill','SC','29732-1566'),(166,'Robert Rickey','8033249445','8432402055','robrickey@gmail.com','512 Cool Creek Drive',NULL,'Rock Hill','SC','29732'),(167,'Tim Sabella','7046228591','17046228591','timsabella@hotmail.com','2919 Baird Rd',NULL,'Clover','SC','29710'),(168,'Mark Klopenstine','803-524-5898','5742744111','icuklop@hotmail.com','642 Bannerman Ln',NULL,'Fort Mill','SC','29715'),(169,'Peyton Blades','803-242-8018','803-242-8018','kikeblades@yahoo.com','404 Brookhollow dr',NULL,'York','SC','29745'),(170,'Chris Scarborough ','803-328-9784','803-524-6552','C_scar@yahoo.com','1617 The Crossing',NULL,'Rock Hill','SC','29732'),(171,'Amy Strong','404-538-3576','404-538-3576','agstrong1215@gmail.com','2502 ivy Creek Ford',NULL,'York ','SC','29745'),(172,'Samantha Dill','8039847518','8039847518','rocco.bacelli@yahoo.com','508 Sansberry Drive',NULL,'York','SC','29745'),(173,'Jack Anthony','8035176150','8035176150','janthony@comporium.net','1545 Nichole Lane',NULL,'Fort Mill','SC','29708'),(174,'Denise Cubbedge','803-230-6522','803-230-6522','Denisecubb@gmail.com','913 Gristmill Drive',NULL,'Rock Hill','SC','29732'),(175,'Martha Chastain','8034932157','8034932157','dchastain@comporium.net','333 Breckenridge Place',NULL,'Rock Hill','SC','29732'),(176,'Laura Johnston','8035178135','8035178135','ljohnston@rhmail.org','337 Limehouse Ct',NULL,'Rock Hill','SC','29732'),(177,'Rosie Hopkins-Campbell','704-813-6620',NULL,'rosie09@bellsouth.net','P.O. Box 113',NULL,'Clover','SC','29710'),(178,'Fred Campbell, Sr.','704-813-6617',NULL,'nflproductions@hotmail.com','104 Wilson St.',NULL,'Clover','SC','29710'),(179,'Eric Fuehrer','7045196361','7045196360','twins63008@hotmail.com','667 Hosta Drive',NULL,'Fort Mill','SC','29715'),(180,'Caci Nance','803-371-2416',NULL,'cacinance@hotmail.com','2350 Hwy 161',NULL,'York','SC','29745'),(181,'Alyssa Lesmeister','8034871601','7046007435','Godlygirl11@yahoo.com','200 Sheffield Drive',NULL,'York','SC','29745'),(182,'Davidh Hunt','(980)322-1127','9803221127','dhunt88@live.com','699 Winding Branch Rd',NULL,'Rock Hill','SC','29732'),(183,'ANDREW HANE','7045822931','7045822931','ANDREWHANE@ROCKETMAIL.COM','616 AIKEN AVE',NULL,'ROCK HILL','SC','29730'),(184,'Christy Moore','8035483745','7043618530','christy.auburn@gmail.com','857 Stratford Run Drive',NULL,'Fort Mill','SC','29708'),(185,'Cristy Clack','8039843119','8039843119','Cristyclack@gmail.com','161 weatherwood  st',NULL,'Rock hill','SC','29732'),(186,'Patrick Williams','8032300585','8032300585','Pwilliams2448@gmail.com','3430 Goodplace Rd',NULL,'Rock Hill','SC','29732'),(187,'Test Test','8033289938','8033714425','spectrallight@gmail.com','2270 Eastview Road',NULL,'Rock HIll','SC','29732'),(188,'Paul Miller','8038311991','3362104401','cartermiller@bellsouth.net','2570 S Paraham Rd',NULL,'York','SC','29745'),(189,'Monica McCoy','8038182186','8033709919','brysonheights@hotmail.com','1494 Andora Dr',NULL,'Rock Hill','SC','29732'),(190,'Kelly Schifferle','8032422358','8032422358','Kelly_rockhill@yahoo.com','4065 canvas ave',NULL,'Rock Hill','SC','29732'),(191,'Christina Poetzl','7176828865','7176828865','crissypoetzl@gmail.com','311 Windy Pine Dr',NULL,'Clover','SC','29710'),(192,'Richard Myrick','8038311174','8646305823','Richardemyrick@yahoo.com','291 Rippling Creek Drive',NULL,'York','SC','29745'),(193,'Frederic Campbell','7048136617','7048136617','fcampbel@rhmail.org','Po Box 113',NULL,'Clover','SC','29710'),(194,'Pam Horack','8038311929','7043017522','p_horack@bellsouth.net','8 Mischief Lane',NULL,'Lake Wylie','SC','29710'),(195,'Sheri Lichty','8033706642',NULL,'sherilichty@yahoo.com','3248 Wicklow Ln',NULL,'Lake Wylie','SC','29710'),(196,'Christina Poetzl','717-682-8865','717-682-8865','pack333@yahoo.com','US 311 Windy Pine Drive',NULL,'Clover','SC','29710'),(197,'Elizabeth Rollyson','3307148213','3307148213','Champusa1@aol.com','1862 Gingercake Cir','Apartment 308','Rock Hill','SC','29732-7421'),(198,'Lisa-Anne  Williams','915-867-2065',NULL,'littlehickorynut2@yahoo.com','2477 Westminster Dr',NULL,'Rock Hill','SC','29732'),(199,'Cullen  Dellinger','803-517-7133','803-517-7957','adelling@rhmail.org','421 Harvest Moon Lane',NULL,'Rock HIll','SC','29732'),(200,'Stuart Hildebrandt','8033517595','8033517595','stuart.hildebrandt@gmail.com','144 Gladstone Ct',NULL,'Rock Hill','SC','29730'),(201,'Levi Bennett','8016432478','18016432478','fatheads5@hotmail.com','5246 Lake Wylie Rd',NULL,'Clover','SC','29710'),(202,'Amy Dellinger','803-517-7957',NULL,'amydelling@yahoo.com','421 Harvest Moon Lane',NULL,'Rock Hill','SC','29732');
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
INSERT INTO `events` VALUES (1,1,'York Day Camp','2017-06-12 08:00:00','2017-06-16 16:00:00','Cub Scout Day Camp for York District','2017-02-20 00:00:00',1,NULL,'2017-05-17 00:00:00',10,30);
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
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventvolunteers`
--

LOCK TABLES `eventvolunteers` WRITE;
/*!40000 ALTER TABLE `eventvolunteers` DISABLE KEYS */;
INSERT INTO `eventvolunteers` VALUES (79,'2017-02-27 08:40:09',1,78,5,'Y','Y','Y','Y','Y','N','N'),(80,'2017-02-27 08:51:48',1,100,5,'Y','Y','Y','Y','Y','N','N'),(81,'2017-03-13 23:35:25',1,103,5,'Y','Y','Y','Y','Y','N','N'),(82,'2017-03-16 14:16:33',1,112,5,'Y','Y','Y','Y','Y','N','N'),(83,'2017-03-16 15:35:44',1,111,5,'Y','Y','Y','Y','Y','N','N'),(84,'2017-03-16 15:43:55',1,113,5,'Y','Y','Y','Y','Y','N','N'),(85,'2017-03-20 17:56:17',1,115,5,'Y','Y','Y','Y','Y','N','N'),(86,'2017-03-20 20:22:55',1,117,5,'Y','Y','Y','Y','Y','N','N'),(90,'2017-03-28 20:40:16',1,126,5,'Y','Y','Y','Y','Y','N','N'),(91,'2017-03-28 20:51:49',1,128,5,'Y','Y','Y','Y','Y','N','N'),(92,'2017-03-31 14:12:27',1,125,5,'Y','Y','Y','Y','Y','N','N'),(93,'2017-04-03 20:27:37',1,131,5,'Y','Y','Y','Y','Y','N','N'),(94,'2017-04-04 17:05:00',1,135,5,'Y','Y','Y','Y','Y','N','N'),(95,'2017-04-04 18:01:33',1,136,5,'Y','Y','Y','Y','Y','N','N'),(96,'2017-04-14 08:42:46',1,145,5,'Y','Y','Y','Y','Y','N','N'),(97,'2017-04-14 08:46:16',1,147,5,'Y','Y','Y','Y','Y','N','N'),(98,'2017-04-17 20:15:46',1,157,4,'Y','Y','Y','Y','N','N','N'),(99,'2017-04-17 20:19:12',1,158,5,'Y','Y','Y','Y','Y','N','N'),(100,'2017-04-18 11:37:11',1,159,5,'Y','Y','Y','Y','Y','N','N'),(101,'2017-04-20 08:02:58',1,171,5,'Y','Y','Y','Y','Y','N','N'),(102,'2017-04-20 08:05:05',1,172,5,'Y','Y','Y','Y','Y','N','N'),(103,'2017-04-20 09:05:11',1,173,5,'Y','Y','Y','Y','Y','N','N'),(104,'2017-04-20 13:38:59',1,176,5,'Y','Y','Y','Y','Y','N','N'),(105,'2017-04-20 13:43:39',1,177,5,'Y','Y','Y','Y','Y','N','N'),(106,'2017-04-20 14:24:38',1,114,4,'Y','N','Y','Y','Y','N','N'),(107,'2017-04-20 21:44:04',1,165,3,'Y','N','N','Y','Y','N','N'),(108,'2017-04-21 12:54:13',1,180,5,'Y','Y','Y','Y','Y','N','N'),(109,'2017-04-21 12:57:58',1,181,5,'Y','Y','Y','Y','Y','N','N'),(110,'2017-04-23 18:56:21',1,186,5,'Y','Y','Y','Y','Y','N','N'),(111,'2017-04-23 19:44:54',1,189,5,'Y','Y','Y','Y','Y','N','N'),(112,'2017-04-24 08:41:33',1,190,2,'N','Y','Y','N','N','N','N'),(113,'2017-04-25 15:28:43',1,188,5,'Y','Y','Y','Y','Y','N','N'),(114,'2017-04-25 22:07:06',1,199,1,'Y','N','N','N','N','N','N'),(115,'2017-04-26 07:05:35',1,200,5,'Y','Y','Y','Y','Y','N','N'),(116,'2017-04-26 10:12:18',1,205,5,'Y','Y','Y','Y','Y','N','N'),(117,'2017-04-27 20:17:15',1,118,5,'Y','Y','Y','Y','Y','N','N'),(118,'2017-04-30 14:02:01',1,222,5,'Y','Y','Y','Y','Y','N','N'),(119,'2017-04-30 14:07:35',1,224,5,'Y','Y','Y','Y','Y','N','N'),(120,'2017-05-01 10:37:31',1,185,5,'Y','Y','Y','Y','Y','N','N'),(121,'2017-05-01 18:06:34',1,229,3,'Y','Y','Y','N','N','N','N'),(122,'2017-05-01 22:11:39',1,234,5,'Y','Y','Y','Y','Y','N','N'),(123,'2017-05-02 09:56:16',1,237,2,'N','Y','N','Y','N','N','N'),(124,'2017-05-02 10:11:44',1,233,5,'Y','Y','Y','Y','Y','N','N'),(126,'2017-05-04 18:53:32',1,258,1,'N','N','N','N','Y','N','N'),(127,'2017-05-05 06:00:46',1,259,5,'Y','Y','Y','Y','Y','N','N'),(128,'2017-05-05 06:26:03',1,261,3,'Y','Y','Y','N','N','N','N'),(129,'2017-05-05 06:44:30',1,262,5,'Y','Y','Y','Y','Y','N','N'),(130,'2017-05-05 11:20:15',1,263,5,'Y','Y','Y','Y','Y','N','N'),(131,'2017-05-05 11:36:50',1,267,5,'Y','Y','Y','Y','Y','N','N'),(132,'2017-05-05 11:48:53',1,268,5,'Y','Y','Y','Y','Y','N','N'),(133,'2017-05-06 19:00:06',1,270,5,'Y','Y','Y','Y','Y','N','N'),(134,'2017-05-06 20:19:27',1,273,5,'Y','Y','Y','Y','Y','N','N'),(135,'2017-05-06 20:24:59',1,275,5,'Y','Y','Y','Y','Y','N','N'),(136,'2017-05-07 01:56:15',1,277,5,'Y','Y','Y','Y','Y','N','N'),(137,'2017-05-07 08:13:21',1,279,2,'Y','Y','N','N','N','N','N'),(138,'2017-05-07 15:58:48',1,76,2,'Y','N','N','N','Y','N','N'),(139,'2017-05-07 22:34:35',1,150,5,'Y','Y','Y','Y','Y','N','N'),(140,'2017-05-08 09:48:48',1,299,5,'Y','Y','Y','Y','Y','N','N'),(141,'2017-05-08 10:53:34',1,302,5,'Y','Y','Y','Y','Y','N','N'),(143,'2017-05-08 16:01:36',1,308,5,'Y','Y','Y','Y','Y','N','N'),(144,'2017-05-08 16:58:40',1,311,1,'N','N','Y','N','N','N','N'),(145,'2017-05-08 17:20:18',1,315,5,'Y','Y','Y','Y','Y','N','N'),(146,'2017-05-08 19:38:12',1,243,5,'Y','Y','Y','Y','Y','N','N'),(147,'2017-05-08 19:39:09',1,284,5,'Y','Y','Y','Y','Y','N','N'),(148,'2017-05-08 19:42:12',1,256,2,'N','Y','N','Y','N','N','N'),(149,'2017-05-08 20:03:37',1,320,5,'Y','Y','Y','Y','Y','N','N'),(150,'2017-05-08 20:37:08',1,129,2,'Y','Y','N','N','N','N','N'),(151,'2017-05-08 20:43:49',1,322,2,'N','N','N','Y','Y','N','N'),(152,'2017-05-08 22:31:15',1,141,5,'Y','Y','Y','Y','Y','N','N'),(153,'2017-05-09 12:05:08',1,213,2,'Y','N','Y','N','N','N','N'),(154,'2017-05-09 14:13:30',1,163,1,'N','N','N','N','Y','N','N'),(155,'2017-05-09 23:21:54',1,331,2,'Y','Y','N','N','N','N','N'),(156,'2017-05-13 15:08:22',1,336,5,'Y','Y','Y','Y','Y','N','N'),(157,'2017-05-15 17:18:03',1,340,5,'Y','Y','Y','Y','Y','N','N'),(158,'2017-05-15 20:26:55',1,345,5,'Y','Y','Y','Y','Y','N','N'),(159,'2017-05-16 11:57:39',1,350,5,'Y','Y','Y','Y','Y','N','N'),(160,'2017-05-17 14:40:04',1,352,5,'Y','Y','Y','Y','Y','N','N'),(161,'2017-05-19 20:34:09',1,119,5,'Y','Y','Y','Y','Y','N','N'),(162,'2017-05-24 12:37:43',1,358,5,'Y','Y','Y','Y','Y','N','N'),(163,'2017-05-24 12:40:03',1,359,5,'Y','Y','Y','Y','Y','N','N'),(164,'2017-05-24 12:40:49',1,360,5,'Y','Y','Y','Y','Y','N','N'),(165,'2017-06-01 10:57:13',1,363,5,'Y','Y','Y','Y','Y','N','N'),(166,'2017-06-09 13:11:35',1,364,3,'N','Y','Y','Y','N','N','N');
/*!40000 ALTER TABLE `eventvolunteers` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (76,'Robert','W','Flowers','2017-04-18 20:03:33',71,NULL,2,-1,55,'1748e932-04f4-449a-b677-25681d63120a',NULL,NULL),(78,'Danny',NULL,'Culver','2017-02-25 13:37:10',72,NULL,2,-1,21,'37efde0c-7727-42c9-af7f-d02fecd7073f',NULL,NULL),(99,'Conner','Brandon','Culver','2017-02-27 08:37:20',72,78,3,5,21,'',NULL,'2008-03-05'),(100,'Jennifer',NULL,'Culver','2017-02-27 08:49:57',74,NULL,2,-1,21,'93ae4117-4290-42f2-8d49-706e58e85eed',NULL,NULL),(101,'Deana',NULL,'Williams','2017-03-12 15:33:46',75,NULL,3,-1,29,'85ebbc73-ce79-409e-beeb-039d72d92234',NULL,NULL),(102,'Christopher','Joseph','Williams','2017-03-12 15:41:40',75,101,3,4,29,'','Nuts','2012-01-17'),(103,'Will','G','Flowers','2017-03-13 22:38:46',71,76,4,10,55,'','Allergic to Penicillin','2004-10-04'),(104,'Manda','Stanley','Prettyman','2017-03-14 07:46:39',76,NULL,1,-1,13,'adf31776-af06-41f0-8da7-3259af1b3625',NULL,NULL),(105,'Manda','S','Prettyman','2017-03-15 14:11:09',77,NULL,1,-1,13,'dc8d0d50-0b0b-436d-b1c8-39ead1ad56fe',NULL,NULL),(106,'Zachary','Phillip','Prettyman','2017-03-15 14:13:42',77,105,3,3,13,'',NULL,'2008-10-03'),(107,'Joseph','Clay','Prettyman','2017-03-15 14:14:35',77,105,4,11,36,'',NULL,'2003-08-02'),(108,'Samantha',NULL,'Dill','2017-03-15 18:59:07',78,NULL,1,-1,21,'dfed82f7-1f3c-4b61-b207-78b34370a283',NULL,NULL),(109,'Tara',NULL,'Burgess','2017-03-15 19:04:17',79,NULL,1,-1,6,'b8842823-0da8-4a88-bdce-25c155d0f951',NULL,NULL),(110,'Mason','James','Burgess','2017-03-15 19:06:16',79,109,3,6,6,'',NULL,'2007-03-13'),(111,'Robert',NULL,'Gasperson','2017-03-15 22:06:34',80,NULL,2,-1,6,'3748f54e-1cc5-45f4-a7d5-b1cb77028f00',NULL,NULL),(112,'Lauren','E','Flowers','2017-03-16 14:16:20',71,76,6,17,55,'',NULL,'2001-12-25'),(113,'Alyssa',NULL,'Gasperson','2017-03-16 15:43:35',80,111,6,16,6,'','Nuts/Peanuts','2007-04-02'),(114,'Sonia',NULL,'Colon','2017-03-18 15:49:06',81,NULL,1,-1,1,'224ca510-c670-4540-9ebb-fe4dade6c0d3',NULL,NULL),(115,'constance',NULL,'booth','2017-03-20 17:54:45',82,NULL,2,-1,11,'fa4a17cb-924b-4f92-b1e9-a447c1b4ec64',NULL,NULL),(116,'jacob',NULL,'langley','2017-03-20 20:20:48',82,115,3,2,11,'','none','2010-03-25'),(117,'brandon',NULL,'langley','2017-03-20 20:21:48',82,115,4,7,45,'','seasonal','2005-05-18'),(118,'Rick','E','Mitchell','2017-03-21 14:04:34',83,NULL,2,-1,6,'7b7423a9-c4a1-4ebd-9f7d-6d5a6759b454','raw carrot potato onion','1953-10-03'),(119,'Matthew','A','Culver','2017-03-22 20:53:28',72,78,2,13,55,'',NULL,'1998-06-09'),(120,'Wilfredo','M','Houston Colon','2017-03-23 05:19:05',81,114,3,5,1,'',NULL,'2007-03-29'),(121,'Thressa','McMains ','Elam','2017-03-23 12:00:35',84,NULL,1,-1,6,'1e381f3b-61f7-4957-a1e6-b4ec8f72437e',NULL,NULL),(122,'William','Elijah ','Elam','2017-03-23 12:08:39',84,121,3,5,6,'',NULL,'2007-12-19'),(123,'Nicole','Leigh','Flippin','2017-03-25 15:11:50',85,NULL,3,-1,30,'045ffd11-26f8-48f4-ac6e-42aebc4f5d9b',NULL,NULL),(125,'Stephen','Nicholas','Burkell','2017-03-27 12:12:22',86,NULL,2,-1,21,'ba6b053a-72c6-423d-b5ec-9ec885a27d60',NULL,NULL),(126,'Jane','M','Sageser','2017-03-27 20:08:44',87,NULL,1,-1,11,'beb6666a-30ee-41ae-aaa6-5c487c8f04c8',NULL,NULL),(127,'Evan','Bennett','Sageser','2017-03-28 20:46:44',87,126,3,6,11,'',NULL,'2007-04-28'),(128,'Nathan','Riley','Sageser','2017-03-28 20:51:29',87,126,4,11,45,'','Bee/Wasp Stings','2004-01-27'),(129,'roy','hayes','boyd','2017-03-30 06:04:05',88,NULL,2,-1,40,'0f4f225c-e241-481d-bc1b-634c44ee10d2',NULL,NULL),(130,'Xavier','Thomas','Powell','2017-03-31 14:17:52',86,125,3,4,21,'',NULL,'2008-12-01'),(131,'Katherine','Rose','Hylton','2017-04-03 20:25:19',89,NULL,2,-1,11,'29a56afd-3b27-4ee4-8b8d-f0a1db19b1dd',NULL,NULL),(132,'Ellis','Edward','Hylton','2017-04-03 20:36:58',89,131,3,5,11,'','Peanuts, pecans, tree nuts','2008-07-04'),(134,'Daniel',NULL,'Collins','2017-04-04 14:59:38',91,118,3,6,6,'e6a43d37-3483-486e-91de-e5a1907a0bb0',NULL,'2006-09-29'),(135,'Eric ','D','JACOBS','2017-04-04 16:58:50',92,NULL,2,-1,45,'9effa591-c078-4828-b290-914d456c2943',NULL,NULL),(136,'George','F','Jacobs ','2017-04-04 18:01:10',92,135,4,7,45,'','Non','2005-09-20'),(137,'Robert','W.','Flowers','2017-04-04 19:54:58',93,NULL,2,-1,55,'56543503-4fa5-4f00-899e-9c48ec0802ac',NULL,NULL),(138,'Christopher','Sebastion','Schweninger','2017-04-05 16:35:11',94,NULL,4,-1,55,'d39a1a6d-4a9a-4df2-89d9-e7760a0b4105',NULL,NULL),(139,'Melissa','Rooney','Daniels','2017-04-07 21:22:20',95,NULL,1,-1,13,'8454a5cb-eb52-46fe-b939-23594990a158',NULL,NULL),(140,'Nolan','Charles','Daniels','2017-04-07 21:24:15',95,139,3,4,13,'','none','2008-12-08'),(141,'Jeancarlo',NULL,'Cayo','2017-04-13 17:04:42',96,NULL,4,-1,45,'fad12849-4667-46ed-b8b1-e8372345b8ae',NULL,NULL),(142,'Ellen',NULL,'Taylor','2017-04-13 17:09:16',97,NULL,2,-1,5,'4b78caa6-943d-4a57-a6ad-930b9fec9e08',NULL,NULL),(143,'Stacy',NULL,'Gumphrey','2017-04-13 21:39:06',98,NULL,1,-1,18,'70d6accd-e02b-4d4c-a588-05bca3da7ce7',NULL,NULL),(144,'Colson','Lawrence ','Gumphrey','2017-04-13 21:42:57',98,143,3,6,18,'','Peanuts, tree nuts, shellfish ','2007-02-23'),(145,'Ellen',NULL,'Taylor','2017-04-14 08:37:35',99,NULL,2,-1,5,'57fb10d2-de8e-4e35-b4b8-5034427f0433',NULL,NULL),(146,'Eli',NULL,'Taylor','2017-04-14 08:40:39',99,145,3,3,5,'','none','2010-03-18'),(147,'Max',NULL,'Taylor','2017-04-14 08:41:24',99,145,4,7,39,'','none','2006-02-14'),(148,'Cathy',NULL,'Whisonant','2017-04-16 15:57:17',100,NULL,1,-1,28,'f7580f59-4b50-42d5-a8ec-d1867ab515f9',NULL,NULL),(149,'Eben','J','Whisonant','2017-04-16 15:59:35',100,148,3,5,28,'','Wasp','2008-05-07'),(150,'Robert','Lanier','Willis','2017-04-17 11:07:07',101,NULL,2,-1,18,'b70dfb96-8a33-4fa2-bf77-a7633eb971c1',NULL,NULL),(151,'Robbye','S','Helms','2017-04-17 12:45:57',102,NULL,1,-1,6,'35ac786d-c1c4-4fc8-98e7-20d7321aa8bd',NULL,NULL),(152,'Robert','W.','Flowers','2017-04-17 15:01:43',103,NULL,-1,-1,-1,'691a0468-3e44-42f7-8181-f51bd92604a4',NULL,NULL),(153,'DTEst',NULL,'TEstCUlver','2017-04-17 15:06:01',104,NULL,2,-1,21,'6aed5c05-b2cb-40e2-a26d-dbdf184ad864',NULL,NULL),(154,'Amy',NULL,'Flowers','2017-04-17 15:09:42',105,NULL,-1,-1,-1,'f65ea58e-b319-43ff-9d12-41c766e2e68b',NULL,NULL),(155,'Matthew','Everett','Willis','2017-04-17 16:08:26',101,150,3,4,18,'','Severe Anaphylactic allergy to peanuts.  Allergic to all other nuts.  Must have EpiPens with him at all times.  I\'ll be with him as his den leader.','2008-12-02'),(156,'Mark','Shannon ','Prescott','2017-04-17 20:08:56',106,NULL,2,-1,55,'1eb3070f-1c1f-4021-8930-c31c9877f612',NULL,NULL),(157,'Nicolas','Joseph','Prescott','2017-04-17 20:13:18',106,156,4,8,55,'','Milk','2012-04-17'),(158,'Jessie','Warren ','Prescott','2017-04-17 20:15:00',106,156,4,7,55,'','None','2005-07-01'),(159,'Jacquelina','Rose','Cox','2017-04-18 11:00:12',107,NULL,1,-1,13,'21ea514e-e7bc-423e-ac77-95e1dba4f6b8',NULL,NULL),(160,'Elias','Samuel','Cox','2017-04-18 11:01:41',107,159,3,4,13,'','Autism Spectrum, ADHD ','2008-08-20'),(161,'darrell','eugene','mcdaniel','2017-04-18 12:23:33',108,NULL,3,-1,6,'c843814f-0f1c-432f-8abb-9c201ba9d388',NULL,NULL),(162,'jason','darrell','mcdaniel','2017-04-18 12:30:42',108,161,3,5,6,'','none','2008-03-28'),(163,'Amy','Brown','McCorkle','2017-05-09 14:13:12',109,NULL,1,-1,30,'07085b0f-75aa-4f8f-811b-42d6bbb20d75',NULL,NULL),(164,'William','Brown','McCorkle','2017-04-18 16:39:30',109,163,3,4,30,'',NULL,'2009-08-05'),(165,'Brian',NULL,'Cope','2017-04-18 20:48:32',110,NULL,1,-1,28,'b1e1fb41-6598-496d-a1db-148b75527d3a',NULL,NULL),(166,'Scott',NULL,'Cope','2017-04-18 20:50:15',110,165,3,5,28,'',NULL,'2012-05-30'),(167,'cindy',NULL,'rebman','2017-04-19 09:32:16',111,NULL,1,-1,14,'65e78625-6f04-4580-b490-8f30a30aba2a',NULL,NULL),(168,'Alex',NULL,'Rebman','2017-04-19 09:34:09',111,167,3,6,14,'',NULL,'2007-08-28'),(169,'Chase',NULL,'Rebman','2017-04-19 09:35:18',111,167,3,4,14,'',NULL,'2009-06-24'),(170,'Thomas','McGuire','Thomas','2017-04-19 13:37:25',112,NULL,-1,-1,-1,'b242b792-2091-4a8f-99da-9f8cb018f895',NULL,NULL),(171,'Amber','L','Ramsey','2017-04-20 07:59:17',113,NULL,1,-1,55,'e8c8aeb6-b008-4675-908e-1b3c09999558',NULL,NULL),(172,'Nathan',NULL,'Ramsey','2017-04-20 08:04:39',113,171,4,7,55,'',NULL,'2005-03-26'),(173,'Sandi ','Lee','Patrick ','2017-04-24 10:33:12',114,NULL,2,-1,28,'3e58cc4f-6898-4d8c-9731-a84dc89f2f2d','Chocolate','1976-07-27'),(174,'Ryan ','Cooper','Patrick ','2017-04-20 09:18:57',114,173,3,4,28,'',NULL,'2008-09-21'),(175,'Seth ','Michael','Patrick ','2017-04-20 09:20:10',114,173,3,4,28,'','Oxybutin','2008-09-21'),(176,'Donna','Marie','Fletcher','2017-04-20 09:42:13',115,NULL,2,-1,25,'bddce3b0-72a9-4d93-bc54-fca1faa1a0f1',NULL,NULL),(177,'RONALD','W','FLETCHER','2017-04-20 13:43:08',116,NULL,2,-1,25,'00eba7fe-58fd-46d5-8db2-9f69c557e765',NULL,NULL),(178,'Natasha','L','Slack','2017-04-20 16:43:56',117,NULL,1,-1,19,'8db7c6aa-24e4-41fc-8b3d-84ee11abd0ff',NULL,NULL),(179,'Chase','E','Higgins','2017-04-20 16:51:40',118,NULL,3,-1,19,'16a8a528-3a1f-45ca-b4f4-86c6a0b83ff2',NULL,NULL),(180,'Stephanie',NULL,'Tinker','2017-04-21 12:53:30',119,NULL,4,-1,40,'4d605084-1054-4585-b401-361a56ef3a68',NULL,NULL),(181,'James','Logan','Tinker','2017-04-21 12:57:44',119,180,4,9,40,'','None','2005-03-15'),(182,'Joshua','Scott','Helms','2017-04-22 08:18:26',102,151,3,4,6,'','none','2008-11-08'),(183,'Michael ','Price','Feimster','2017-04-22 13:00:36',120,NULL,1,-1,28,'101b293c-e0a4-4e6f-b939-857110ed71bd',NULL,NULL),(184,'Kingston','Price','Feimster','2017-04-22 13:04:01',120,183,3,4,28,'','NA','2009-06-15'),(185,'Jackson','Alexander','Hayes','2017-04-23 18:36:13',121,NULL,4,-1,40,'9870dc6c-e8e6-482e-aae6-c74e8b4b6bbb',NULL,NULL),(186,'Cassie','ODell','Clark','2017-04-23 18:56:01',122,NULL,2,-1,21,'0a093e08-a411-4fc6-8db9-aaab639601e0',NULL,'1983-09-30'),(187,'Calvin','Eugene','Lyle','2017-04-23 18:51:57',122,186,3,5,21,'',NULL,'2008-03-22'),(188,'Heather',NULL,'Culver','2017-04-23 19:41:12',72,78,6,16,21,'',NULL,'2003-07-30'),(189,'Robert ','Brantley','Davies','2017-04-23 19:44:38',122,186,6,16,21,'',NULL,'2003-02-22'),(190,'James','Clifford','Parrish','2017-04-24 08:37:45',123,NULL,1,-1,28,'27312fad-e13a-4f50-bd77-16c703c08f67',NULL,NULL),(191,'Lukas','Riley','Parrish','2017-04-24 08:39:37',123,190,3,5,28,'',NULL,'2012-04-13'),(193,'Cara',NULL,'Rohlfs','2017-04-25 12:44:44',124,NULL,4,-1,11,'1be33843-8af4-4a6f-8e5c-6e9d5614f801',NULL,NULL),(194,'Aidan','Christopher','Rohlfs','2017-04-25 12:45:54',124,193,3,6,11,'',NULL,'2007-07-24'),(195,'Karen',NULL,'Brogdon','2017-04-25 13:38:28',125,NULL,2,-1,6,'af0d61f4-186c-4d25-9cbd-756b31ad6c4a',NULL,NULL),(196,'Brayden','Cole','Brogdon','2017-04-25 13:40:09',125,195,3,4,6,'',NULL,'2008-11-17'),(197,'Cynthia','A','Jackson','2017-04-25 21:42:15',126,NULL,3,-1,54,'a68de879-40c7-4869-8a67-91509ce726a5',NULL,NULL),(198,'Matthew','B','Jackson','2017-04-25 21:45:00',126,197,3,5,20,'','None','2007-11-29'),(199,'Glenn','C','Stoner','2017-04-25 22:06:15',127,NULL,-1,-1,-1,'20cbb424-269d-4910-8b06-e870508089e5',NULL,NULL),(200,'Larry','Brian','Caulder','2017-04-26 07:04:38',128,NULL,2,-1,3,'3b7e9783-43ad-4c3d-81b4-fe809a15df10',NULL,NULL),(201,'Larry \"Brian\"','Brian','Caulder','2017-04-26 07:11:18',128,200,3,6,3,'',NULL,'2007-04-15'),(202,'Zachary \"Zac\"','Aaron','Caulder','2017-04-26 07:12:33',128,200,3,4,3,'',NULL,'2009-02-13'),(203,'Wesley','Randall','Caulder','2017-04-26 07:13:57',128,200,3,3,3,'',NULL,'2010-05-28'),(204,'Declan','Samuel','Caulder','2017-04-26 07:15:33',128,200,6,16,3,'',NULL,'2015-06-20'),(205,'Jacob','Anthony','Bendt','2017-04-26 10:11:39',129,NULL,4,-1,34,'1ebf9561-0178-48fb-bb2b-67987d0216a7',NULL,NULL),(206,'Duree',NULL,'Love','2017-04-26 11:21:15',130,NULL,1,-1,29,'e14a5238-4db8-42a0-94f0-b32ea4e5d6c6',NULL,NULL),(207,'Nathaniel','Scott','Woolard','2017-04-26 11:22:28',130,206,3,5,29,'',NULL,'2008-03-05'),(208,'Zachary','David','Woolard','2017-04-26 11:23:09',130,206,3,3,29,'',NULL,'2009-11-16'),(209,'Nathan','Matthew','Green','2017-04-26 19:13:28',131,NULL,3,-1,21,'dac31629-2bf6-42d9-8c28-c38cb98b8e97',NULL,NULL),(210,'Saylor','Spence','Green','2017-04-26 19:16:56',131,209,3,4,21,'',NULL,'2009-03-04'),(211,'Ellen',NULL,'Wilder-Byrd','2017-04-27 13:03:05',132,NULL,3,-1,4,'9006b136-ee19-42a4-a99a-72e281a445f1',NULL,NULL),(212,'Robert','Kaden','McClure','2017-04-27 13:10:31',132,211,3,4,4,'',NULL,'2005-03-09'),(213,'Brenda','Howe','Benton','2017-05-09 12:04:31',133,NULL,1,-1,30,'f03d24db-f39f-4e99-953b-4531e9771f6a',NULL,'1968-08-17'),(214,'Richard','Michael','Benton','2017-04-27 14:11:20',133,213,3,5,30,'','n/a','2006-09-06'),(215,'Brendan','Caleb','Benton','2017-04-27 14:12:18',133,213,3,4,30,'','n/a','2008-05-06'),(216,'Jesse','Ray','McGee','2017-04-27 17:48:13',134,NULL,1,-1,14,'344b2f8f-e154-4d49-a486-6800f54e9752',NULL,NULL),(217,'Joshua','Thomas','Harrell','2017-04-27 17:51:13',134,216,3,4,14,'',NULL,'2009-04-01'),(218,'Sara ','L','Martinez','2017-04-28 10:12:04',135,NULL,3,-1,23,'eb642bfb-ea0f-463b-b5ec-51aa3c011691',NULL,NULL),(219,'Chase','E.','Higgins','2017-04-28 15:09:42',117,178,3,5,19,'',NULL,'2008-02-29'),(220,'meghan',NULL,'wier','2017-04-30 12:20:59',136,NULL,3,-1,14,'54a212ce-ea20-4347-a169-76f72905aba3',NULL,NULL),(221,'Morgan',NULL,'Wier','2017-04-30 12:22:42',136,220,3,4,14,'',NULL,'2012-04-17'),(222,'laura',NULL,'cripe','2017-04-30 13:46:00',137,NULL,2,-1,5,'0517def0-4682-432f-be56-5a132c7a5a13',NULL,NULL),(223,'Thomas','Christopher','Cripe','2017-04-30 13:48:11',137,222,3,3,5,'',NULL,'2010-06-14'),(224,'Samuel','Allen','Cripe','2017-04-30 13:49:09',137,222,4,7,39,'',NULL,'2006-03-07'),(225,'Benjamin','Wesley','Cripe','2017-04-30 13:50:38',137,222,5,14,64,'',NULL,'1998-02-16'),(226,'Samuel',NULL,'Clack','2017-04-30 15:48:15',138,NULL,3,-1,28,'6dd257e5-9f1f-4df9-84be-bf57bb1e9085',NULL,NULL),(227,'Sally',NULL,'Baker','2017-04-30 20:39:19',139,NULL,1,-1,18,'06298a8d-c555-4c2c-8694-1445f9e007e1',NULL,NULL),(228,'Logan',NULL,'Baker','2017-04-30 20:41:46',139,227,3,5,18,'','Several antibiotics: penicillins (including augmentin); macrolides; cephalosporins','2007-09-22'),(229,'Robie',NULL,'Grissom','2017-05-01 17:18:08',140,NULL,1,-1,6,'37d0e4b7-a905-4b3b-9048-3dad4a52e1fc',NULL,NULL),(230,'Andrew','Scott','Blackwood jr','2017-05-01 17:42:46',140,229,3,4,6,'','None','2008-04-27'),(231,'Frankie',NULL,'carns','2017-05-01 20:04:49',141,NULL,1,-1,11,'d632527c-5f7f-4d39-96e7-507748c69daa',NULL,NULL),(232,'Warren ',NULL,'Carns','2017-05-01 20:07:47',141,231,3,5,11,'',NULL,'2008-01-14'),(233,'Will',NULL,'Carns','2017-05-01 20:09:16',141,231,4,10,45,'',NULL,'2003-09-03'),(234,'Patricia','ann','Swoope','2017-05-01 22:03:16',142,NULL,1,-1,18,'26a83b69-9630-403e-9dc7-4a10c39d56bf',NULL,NULL),(235,'Kannon','Rilee','Swoope','2017-05-01 22:06:35',142,234,3,4,18,'',NULL,'2008-11-10'),(236,'Ryan','Sean','Swoope','2017-05-01 22:09:44',142,234,3,6,18,'',NULL,'2012-05-01'),(237,'Kara',NULL,'Hawkins','2017-05-02 09:51:34',143,NULL,1,-1,30,'a2b96ccd-b82c-4159-b2af-f8c83fe0f2ab',NULL,NULL),(238,'R.','Blake','Hawkins','2017-05-02 09:53:28',143,237,3,6,30,'',NULL,'2007-06-29'),(239,'Dylan','Toby','Hawkins','2017-05-02 09:54:25',143,237,3,4,30,'',NULL,'2009-05-27'),(240,'Amy','Hypes','Michalesko','2017-05-02 14:38:24',144,NULL,1,-1,14,'43d1853d-01bb-44a0-871c-044d65cd8aad',NULL,NULL),(242,'Nicholas','David','Michalesko','2017-05-02 14:39:37',144,240,3,4,14,'',NULL,'2008-08-27'),(243,'Allison','Louise','Lenzi','2017-05-02 15:22:29',145,NULL,2,-1,19,'43dba1a7-9cd9-4594-894f-beed545b5ccb',NULL,NULL),(244,'Alessandro','James','Lenzi','2017-05-02 15:24:24',145,243,3,5,19,'',NULL,'2012-03-10'),(245,'Oliver ','James','Lenzi','2017-05-02 15:25:07',145,243,3,5,19,'',NULL,'2012-03-10'),(246,'Owen ','Stefano','Lenzi','2017-05-02 15:25:57',145,243,3,2,19,'',NULL,'2011-02-26'),(247,'Massimo ','Daniel','Lenzi','2017-05-02 15:28:49',145,243,3,2,19,'',NULL,'2011-02-26'),(248,'Randy','Clayton ','Parks ','2017-05-02 17:57:56',146,NULL,1,-1,23,'4e8966ed-5c90-44dc-907c-68ca0a6fa4ed',NULL,NULL),(249,'Clayton ','Micheal','Parks','2017-05-02 18:33:54',146,248,3,4,23,'',NULL,'2008-02-25'),(250,'Delete',NULL,'ME','2017-05-03 10:10:56',147,NULL,1,-1,21,'19a8b3da-19b8-4743-85a4-b7b3c1d45d5e',NULL,NULL),(251,'Delete',NULL,'metoo','2017-05-03 10:33:20',147,250,3,4,21,'',NULL,'2012-05-03'),(252,'Katie','O','James','2017-05-11 20:33:27',148,NULL,3,-1,20,'7bac523d-c4c4-457a-9b8e-8dc780417e84',NULL,'1981-09-23'),(253,'Jana','A','Cathey','2017-05-03 15:11:58',149,NULL,2,-1,29,'65aa4a33-cf54-4e10-831a-a4a5c14321d2',NULL,NULL),(254,'Liam',NULL,'Cathey','2017-05-03 15:11:42',149,253,3,3,29,'',NULL,'2012-09-18'),(255,'Colin',NULL,'Cathey','2017-05-03 15:12:41',149,253,3,2,29,'',NULL,'2011-06-25'),(256,'Amber',NULL,'Paige','2017-05-03 16:42:52',150,NULL,1,-1,19,'b016cf73-eb43-40aa-98c5-f0cdedc39e90',NULL,NULL),(257,'Nathan',NULL,'Paige','2017-05-03 16:47:55',150,256,3,6,19,'',NULL,'2007-07-23'),(258,'steven','charles','schweninger','2017-05-04 18:51:55',151,NULL,4,-1,55,'292325f7-e402-40da-9b95-c0a5114fb08b',NULL,NULL),(259,'Kristy ','Beasley ','Powell ','2017-05-05 06:14:05',152,NULL,2,-1,21,'1b388a36-a3ed-4feb-806c-e18d61981803',NULL,NULL),(260,'Benjamin ','Wilson ','Powell ','2017-05-05 05:59:32',152,259,3,4,21,'','None','2008-10-26'),(261,'Paul','Wilson ','Powell','2017-05-05 06:25:24',153,NULL,2,-1,21,'a9d7bf94-6c4e-4f1c-9cac-a29a8f78dd12',NULL,NULL),(262,'Janice',NULL,'Chadwick ','2017-05-05 06:43:54',154,NULL,1,-1,21,'a3443ba5-b5d6-47b1-831d-799c1ff19117',NULL,NULL),(263,'Nancy',NULL,'Carruth','2017-05-05 11:31:52',155,NULL,2,-1,6,'e640ea8a-c21e-4a7c-9f7d-08c07c0a0458',NULL,NULL),(264,'Niki',NULL,'McBroom','2017-05-05 11:30:09',156,NULL,2,-1,19,'524d95a4-e506-4489-8402-122869902992',NULL,NULL),(265,'Jax',NULL,'Carruth','2017-05-05 11:30:14',155,263,3,4,6,'',NULL,'2009-08-03'),(266,'James','Sebastian','Boyd','2017-05-05 11:32:27',156,264,3,4,19,'',NULL,'2009-04-27'),(267,'Michael',NULL,'Carruth','2017-05-05 11:35:09',157,NULL,2,-1,6,'82c013da-8935-4573-9ecf-3242af4ef143',NULL,NULL),(268,'Cole',NULL,'Carruth','2017-05-05 11:48:29',158,NULL,4,-1,40,'ba690cfe-47be-415f-bf8a-dc266f003c83',NULL,NULL),(269,'Landon',NULL,'Hickson','2017-05-05 11:48:50',156,264,3,5,19,'',NULL,'2008-03-07'),(270,'Christine ','Ann','Chavis ','2017-05-06 18:16:45',159,NULL,1,-1,18,'7d898ec5-46b3-40de-8659-286882b5abf1',NULL,NULL),(271,'Amari','Everett','Chavis','2017-05-06 18:56:35',159,270,3,2,18,'','none','2011-08-21'),(272,'Zane','Alexander','Chavis','2017-05-06 18:57:42',159,270,3,4,18,'','none','2009-02-17'),(273,'Jennifer','M','Waters','2017-05-07 09:24:09',160,NULL,1,-1,23,'6a2fe218-d3d7-498d-9436-23bf743a8046',NULL,NULL),(274,'Evan','Michael','Waters','2017-05-06 20:17:09',160,273,3,5,23,'',NULL,'2007-06-27'),(275,'Cristina','Vincent','Renzoni','2017-05-06 20:24:29',161,NULL,2,-1,11,'0f50f193-b477-4623-9284-f95c1f295729',NULL,NULL),(276,'Nicky',NULL,'Renzoni','2017-05-06 20:28:10',161,275,3,4,11,'','None','2012-08-05'),(277,'Kimberley ','R.','Garrison ','2017-05-07 01:49:01',162,NULL,1,-1,21,'8bf2f8da-f88a-4c37-8fc6-f2f20976809d',NULL,NULL),(278,'Gage','B','Garrison ','2017-05-07 02:00:12',162,277,3,3,21,'','None','2013-04-26'),(279,'Vanessa','R','Fulcher','2017-05-07 08:12:21',163,NULL,1,-1,4,'629fa4f3-c681-4044-9cff-6c2b0f08d2af',NULL,NULL),(280,'Carson','Grant','Fulcher','2017-05-07 08:16:01',163,279,3,3,4,'','Penicillin','2009-10-13'),(281,'Blair',NULL,'Bigger','2017-05-07 19:13:27',164,NULL,2,-1,2,'ddd8df6f-21a1-472e-9de9-becf06141633',NULL,NULL),(282,'Brody',NULL,'Bigger','2017-05-07 19:15:32',164,281,3,4,2,'',NULL,'2009-02-11'),(283,'Ronald','Clinton','Alexander','2017-05-07 22:35:34',165,NULL,1,-1,18,'a7f18707-9f59-4a25-92aa-01bb0d620522',NULL,'1968-11-05'),(284,'Robert','C','Rickey','2017-05-08 19:38:54',166,NULL,1,-1,30,'8fd7dc00-62be-469d-9273-aa279cdcedaf',NULL,'1978-12-22'),(285,'Nathan','J','Rickey','2017-05-07 20:49:05',166,284,3,3,30,'','None','2010-03-19'),(286,'Brayden','H','Rickey','2017-05-07 20:49:48',166,284,3,2,30,'','None','2011-04-15'),(287,'Tim',NULL,'Sabella','2017-05-07 21:17:52',167,NULL,1,-1,15,'94b3e66b-efd9-4b20-a01e-5ceaa0f25e09',NULL,NULL),(288,'Michael',NULL,'Sabella','2017-05-07 21:20:35',167,287,3,6,15,'','None','2007-03-11'),(289,'Timmy',NULL,'Sabella','2017-05-07 21:23:10',167,287,3,3,15,'','None','2010-08-22'),(290,'Mark',NULL,'Klopenstine','2017-05-07 22:24:31',168,NULL,3,-1,18,'3f023c6a-02b6-4994-a9f8-e7208d32fb1b',NULL,NULL),(291,'Caden','Cole','Klopenstine','2017-05-07 22:27:42',168,290,3,4,18,'',NULL,'2007-11-10'),(292,'Graham',NULL,'Alexander','2017-05-07 22:36:31',165,283,3,4,18,'',NULL,'2007-11-10'),(293,'Kike','Holland','Blades','2017-05-08 20:23:16',169,NULL,1,-1,23,'6598cc40-8b32-40e2-98e5-20973dee1aec','peanuts ','1966-06-08'),(294,'Chris',NULL,'Scarborough ','2017-05-08 06:58:04',170,NULL,3,-1,18,'6c232435-c11a-4ee0-8249-f62409a64d4c',NULL,NULL),(295,'Noah',NULL,'Scarborough ','2017-05-08 07:00:15',170,294,3,6,18,'','None','2006-09-10'),(296,'Amy','Gulig','Strong','2017-05-08 09:09:04',171,NULL,1,-1,15,'19b194b1-e689-4947-b418-69e5608877ef',NULL,NULL),(297,'Winston','William','Strong','2017-05-08 09:10:39',171,296,3,6,15,'',NULL,'2006-12-08'),(298,'Tyler','Neal','Strong','2017-05-08 09:11:10',171,296,3,3,15,'',NULL,'2009-12-17'),(299,'Samantha','Ann','Dill','2017-05-08 09:44:25',172,NULL,1,-1,21,'b4ac2b41-5bb9-46a4-9653-ef209bf0d23a',NULL,NULL),(300,'Dalton','Lee','Montgomery','2017-05-08 09:46:06',172,299,3,2,21,'',NULL,'2011-07-13'),(302,'Jack','Lee','Anthony','2017-05-08 10:52:44',173,NULL,-1,-1,-1,'64acf003-8222-40ce-9918-87af63d72b14',NULL,NULL),(303,'Alexander','Sebastian','Anthony','2017-05-08 10:58:24',173,302,3,6,27,'','Asthma','2005-09-21'),(304,'Denise',NULL,'Cubbedge','2017-05-08 11:03:35',174,NULL,1,-1,28,'fe9c51fb-147b-4e12-8f4c-5ed06aef8859',NULL,NULL),(305,'Edison',NULL,'Cubbedge','2017-05-08 11:08:04',174,304,3,5,28,'','None','2007-11-26'),(306,'Martha','Pearson','Chastain','2017-05-08 15:34:32',175,NULL,3,-1,18,'f4a05e5f-0a86-436e-b442-c27332078ec5',NULL,NULL),(307,'Garrison','Blake','Chastatin','2017-05-08 15:48:32',175,306,3,5,18,'','None','2007-11-17'),(308,'Laura','Ann','Johnston','2017-05-08 15:52:47',176,NULL,1,-1,28,'314b3ba3-f01e-4256-872d-c07900d871bd',NULL,NULL),(309,'Jacob','Scott','Limerick','2017-05-08 15:54:51',176,308,3,5,28,'',NULL,'2008-06-08'),(310,'Aiden','Michael','Limerick','2017-05-08 15:55:59',176,308,3,2,28,'','Seasonal allergies, is prone to nose bleeds','2011-02-20'),(311,'Rosie',NULL,'Hopkins-Campbell','2017-05-08 16:53:34',177,NULL,1,-1,63,'44f8fb5e-f8a3-48a1-afba-1d27f240752b',NULL,NULL),(314,'Fred','Norman','Campbell','2017-05-08 17:05:48',177,311,3,3,29,'','Outdoor/seasonal','2010-02-05'),(315,'Fred',NULL,'Campbell, Sr.','2017-05-08 17:11:25',178,NULL,1,-1,29,'df8f6008-0a3d-46a8-81d9-6bc1938f05f1',NULL,NULL),(316,'Fred','Norman','Campbell','2017-05-08 17:16:19',178,315,3,3,29,'','seasonal/outdoor','2010-02-05'),(317,'Eric','John','Fuehrer','2017-05-09 20:20:25',179,NULL,2,-1,4,'bc2fcec9-b39c-4f02-9e1f-5cdb86e734e7',NULL,NULL),(318,'Dane','Robert','Fuehrer','2017-05-08 17:24:07',179,317,3,5,4,'',NULL,'2008-06-30'),(319,'Austin','Lee','Fuehrer','2017-05-08 17:24:38',179,317,3,5,4,'',NULL,'2008-06-30'),(320,'Caci',NULL,'Nance','2017-05-08 20:02:59',180,NULL,-1,-1,-1,'d99295d8-33bf-499b-986d-b837daf837b9',NULL,NULL),(321,'Peyton','Lee','Blades','2017-05-08 20:29:33',169,293,3,6,23,'','peanuts','2006-08-10'),(322,'Alyssa',NULL,'Lesmeister','2017-05-08 20:42:56',181,NULL,1,-1,21,'71789443-abf1-4a84-903f-e733ba3cb1d0',NULL,NULL),(323,'Davidh','John','Hunt','2017-05-08 20:46:18',182,NULL,1,-1,15,'c4e433a8-b04e-4e7b-b760-610962c2a365',NULL,NULL),(324,'Ethan','Alexander','Hunt','2017-05-08 20:46:05',182,323,3,2,15,'',NULL,'2012-03-02'),(325,'ANDREW','WESLEY','HANE','2017-05-08 21:19:18',183,NULL,3,-1,18,'0f4cfe52-3050-44d3-b228-5f822dd5dd75',NULL,NULL),(326,'Wesley','Joseph ','Hane','2017-05-08 21:21:30',183,325,3,4,18,'','none','2012-01-28'),(327,'Christy',NULL,'Moore','2017-05-08 21:45:56',184,NULL,3,-1,27,'b9c18fb8-f02d-42e3-b9e2-c8a6a291588c',NULL,NULL),(328,'Charlie',NULL,'Moore','2017-05-08 21:47:56',184,327,3,6,27,'','seasonal','2006-12-26'),(329,'Sam',NULL,'Moore','2017-05-08 21:48:34',184,327,3,3,27,'',NULL,'2010-06-06'),(330,'Cristy',NULL,'Clack','2017-05-09 07:03:28',185,NULL,3,-1,28,'9f357deb-5b1e-4fdb-a1c5-4affeeea43f4',NULL,NULL),(331,'Patrick',NULL,'Williams','2017-05-09 23:20:16',186,NULL,2,-1,51,'5dbef02c-3b93-4c55-9971-63b44478c1c9',NULL,NULL),(332,'Wyatt','Charles','James','2017-05-11 20:34:34',148,252,3,4,20,'',NULL,'2009-03-23'),(333,'Test',NULL,'Test','2017-05-12 15:38:42',187,NULL,-1,-1,-1,'027c3a0b-41af-486b-afb7-58ae6be81963',NULL,NULL),(334,'TEstchild',NULL,'Testchild','2017-05-12 15:39:50',187,333,3,6,21,'',NULL,'2012-05-12'),(335,'Paul','Carter','Miller','2017-05-13 15:05:04',188,NULL,2,-1,29,'a02dae7b-ca1a-4669-a1b5-def033a815cc',NULL,NULL),(336,'Grant ','Thomas','Miller','2017-05-13 15:07:28',188,335,4,7,63,'','Peanut','2006-02-02'),(337,'Monica',NULL,'McCoy','2017-05-13 19:00:02',189,NULL,1,-1,30,'b1be1e28-23a3-45e4-a380-18bfbb88d914',NULL,NULL),(338,'Noah',NULL,'McCoy','2017-05-13 18:59:37',189,337,3,5,30,'','phenoxyethanol\r\nmethylisothiazolinone','2008-03-03'),(339,'Sam',NULL,'Clack','2017-05-15 15:38:50',185,330,3,3,28,'',NULL,'2009-02-10'),(340,'Kelly',NULL,'Schifferle','2017-05-15 17:14:34',190,NULL,1,-1,22,'b5854529-ac7b-4d53-bc69-a4a063f00c6e',NULL,NULL),(341,'Xavier',NULL,'Schifferle','2017-05-15 17:16:32',190,340,3,3,22,'',NULL,'2009-11-27'),(342,'Christina',NULL,'Poetzl','2017-05-15 18:27:39',191,NULL,1,-1,20,'07bc8c87-1771-441a-8519-abfcd89e6f6a',NULL,NULL),(343,'Matthew','Joseph','Poetzl','2017-05-15 18:29:03',191,342,3,4,20,'',NULL,'2012-08-28'),(344,'Richard',NULL,'Myrick','2017-05-15 19:20:13',192,NULL,1,-1,29,'dbd65d40-5f14-4fec-9505-48297cfa9d8b',NULL,NULL),(345,'Frederic',NULL,'Campbell','2017-05-15 20:03:59',193,NULL,1,-1,29,'eacb2c2d-a7eb-41c2-97cd-ef34152bc123',NULL,NULL),(346,'Fred','Norman','Campbell','2017-05-15 20:11:05',193,345,3,3,29,'','Outdoor seasonal:hickory, oak, pigweed, ragweed, dust mite, Alturia mold','2010-02-05'),(347,'Ernest','Peyton','Myrick','2017-05-15 21:17:33',192,344,3,3,29,'',NULL,'2010-01-10'),(348,'Pam',NULL,'Horack','2017-05-16 11:30:31',194,NULL,1,-1,20,'89e6623b-9e50-404e-a3cc-2beec17ca3f2',NULL,NULL),(349,'Kevin',NULL,'Horack','2017-05-16 11:32:11',194,348,3,6,20,'','penicillin, shrimp','2006-12-25'),(350,'Donald',NULL,'Horack','2017-05-16 11:32:47',194,348,4,8,54,'','none','2004-08-08'),(351,'Sheri',NULL,'Lichty','2017-05-17 14:30:07',195,NULL,2,-1,20,'956d3fb2-f870-4a49-ac35-95f71bf41228',NULL,NULL),(352,'Christina',NULL,'Poetzl','2017-05-17 14:38:04',196,NULL,2,-1,20,'0baa0786-cf75-4b19-9abc-2120b39d96a2',NULL,NULL),(353,'Elizabeth',NULL,'Rollyson','2017-05-19 22:43:40',197,NULL,3,-1,1,'6a7de375-00f4-49fe-986f-e7f407a4ea27',NULL,NULL),(354,'Tucker',NULL,'Rollyson','2017-05-19 22:46:49',197,353,3,4,1,'','Penecilin','2009-05-04'),(355,'Lisa-Anne ',NULL,'Williams','2017-05-22 12:09:11',198,NULL,3,-1,2,'a2794caa-344a-4a61-9419-e829e9d7b3da',NULL,NULL),(356,'Cullen ','James','Dellinger','2017-05-23 11:11:57',199,NULL,3,-1,30,'5efb75f5-390e-4dd9-92e7-4c5294d6841a',NULL,NULL),(357,'Zander',NULL,'Kirkland','2017-05-23 21:11:50',82,115,6,16,11,'',NULL,'2005-05-17'),(358,'Sarah ','B','Garrison','2017-05-24 12:09:09',162,277,6,17,55,'','No','1999-06-11'),(359,'Georgia','B','Garrison ','2017-05-24 12:10:09',162,277,6,17,55,'','None','2002-03-07'),(360,'Geneva','B','Garrison ','2017-05-24 12:11:12',162,277,6,17,55,'','None','2013-08-04'),(361,'Stuart',NULL,'Hildebrandt','2017-05-30 08:16:35',200,NULL,1,-1,28,'31c04f57-2034-4c70-afa3-6780cae9d64c',NULL,NULL),(362,'Liam',NULL,'Hildebrandt','2017-05-30 08:17:31',200,361,3,4,28,'',NULL,'2009-01-13'),(363,'Levi','Glen','Bennett','2017-06-01 10:53:10',201,NULL,4,-1,57,'84e2f38c-4cf6-4ac5-9d3e-ea77c34322c1',NULL,NULL),(364,'Amy',NULL,'Dellinger','2017-06-09 13:03:43',202,NULL,1,-1,30,'027b0254-950c-488c-a2f0-45e95ed633a2',NULL,NULL),(365,'Cullen','James','Dellinger','2017-06-09 13:09:25',202,364,3,3,30,'',NULL,'2010-03-03');
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
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registrations`
--

LOCK TABLES `registrations` WRITE;
/*!40000 ALTER TABLE `registrations` DISABLE KEYS */;
INSERT INTO `registrations` VALUES (39,'2017-02-27 08:43:43','1fcf975485f21c70','2017-02-27 08:43:43',1,99),(40,'2017-03-16 16:37:20','56e9e679334d5640','2017-03-16 16:37:20',1,110),(41,'2017-03-20 20:22:12','51bfec8857853e40','2017-03-20 20:22:12',1,116),(42,'2017-03-23 12:09:08','e14bda79eef17cf0','2017-03-23 12:09:08',1,122),(43,'2017-03-28 20:47:47','4dce8248b256e365','2017-03-28 20:47:46',1,127),(44,'2017-03-31 14:18:07','51df407fcbbcbb20','2017-03-31 14:18:06',1,130),(45,'2017-04-03 20:37:18','27659b6b9f8fdb79','2017-04-03 20:37:17',1,132),(46,'2017-04-14 08:45:51','ad47a92512520e2b','2017-04-14 08:45:51',1,146),(47,'2017-04-18 11:40:10','aa605a54f8d27f8','2017-04-18 11:40:09',1,160),(48,'2017-04-18 12:30:59','7e200376a1c006eb','2017-04-18 12:30:59',1,162),(49,'2017-04-18 18:43:57','feb035b25eb89c4','2017-04-18 18:43:56',1,140),(50,'2017-04-19 21:40:45','e9065aad995d152e','2017-04-19 21:40:45',1,106),(51,'2017-04-20 09:20:27','de81e4f479318957','2017-04-20 09:20:26',1,174),(52,'2017-04-20 09:21:04','cbc716f06e9adc35','2017-04-20 09:21:03',1,175),(53,'2017-04-20 10:36:50','f8c7fbdacaa5e91c','2017-04-20 10:36:50',1,149),(54,'2017-04-20 21:14:04','58269704815d086','2017-04-20 21:14:04',1,166),(55,'2017-04-22 08:18:38','a070d2649ec66512','2017-04-22 08:18:38',1,182),(56,'2017-04-23 18:52:11','bdf8881a5a08bd31','2017-04-23 18:52:10',1,187),(57,'2017-04-24 08:44:38','cb3fbb9b97cdacc7','2017-04-24 08:44:38',1,191),(58,'2017-04-24 09:05:46','6c7de4b7dd9bc755','2017-04-24 09:05:46',1,184),(59,'2017-04-25 12:46:17','547c3f7c2070863d','2017-04-25 12:46:17',1,194),(60,'2017-04-25 13:40:30','bc6fe9e9dc400e2f','2017-04-25 13:40:30',1,196),(61,'2017-04-26 07:16:52','a481dc0a5c8de801','2017-04-26 07:16:52',1,201),(62,'2017-04-26 07:17:12','ee6b86bbbc1aa5ce','2017-04-26 07:17:12',1,202),(63,'2017-04-26 07:17:25','1db49497ebdc0e8a','2017-04-26 07:17:25',1,203),(64,'2017-04-26 19:17:16','c60b6b25267b0e95','2017-04-26 19:17:15',1,210),(65,'2017-04-27 20:39:22','6c9e7a40a4f1fac9','2017-04-27 20:39:22',1,134),(66,'2017-04-30 13:58:28','d6ba2ff42ee6cf2a','2017-04-30 13:58:28',1,223),(67,'2017-05-01 17:43:03','5ea3c23685fcf5bb','2017-05-01 17:43:02',1,230),(68,'2017-05-01 20:14:23','a3779049a36cc94d','2017-05-01 20:14:23',1,232),(69,'2017-05-01 22:14:06','46e5327b078a84b2','2017-05-01 22:14:06',1,228),(70,'2017-05-02 04:29:49','51374b62a74b4b5c','2017-05-02 04:29:48',1,144),(71,'2017-05-03 09:07:50','b535b4839ecc8f32','2017-05-03 09:07:50',1,235),(72,'2017-05-03 09:08:53','9070d4cbdc526fb6','2017-05-03 09:08:52',1,236),(74,'2017-05-05 06:07:46','f60079e2412bb935','2017-05-05 06:07:46',1,260),(75,'2017-05-05 11:30:31','912774789a185e5d','2017-05-05 11:30:31',1,265),(76,'2017-05-06 18:58:53','d7faa6ef8587d356','2017-05-06 18:58:52',1,271),(77,'2017-05-06 19:47:12','c427904bad0c781c','2017-05-06 19:47:11',1,272),(78,'2017-05-06 20:28:23','984da599a3bd2676','2017-05-06 20:28:23',1,276),(79,'2017-05-07 02:08:01','b81391b5a1db076c','2017-05-07 02:08:01',1,278),(80,'2017-05-07 22:27:51','52a4e642e41ddbc2','2017-05-07 22:27:51',1,291),(81,'2017-05-07 22:36:06','ffdc6fd361952c53','2017-05-07 22:36:05',1,155),(82,'2017-05-07 22:36:48','7e98e28dbb8154c6','2017-05-07 22:36:47',1,292),(83,'2017-05-08 07:01:12','1c43e79883dc387e','2017-05-08 07:01:12',1,295),(84,'2017-05-08 09:04:31','722d3130187c2b91','2017-05-08 09:04:30',1,249),(85,'2017-05-08 09:04:49','dddc4fb04a9aa43e','2017-05-08 09:04:49',1,274),(86,'2017-05-08 10:10:25','1829ac99826a962c','2017-05-08 10:10:25',1,300),(87,'2017-05-08 11:10:37','6ab7a5fb82782e04','2017-05-08 11:10:37',1,305),(88,'2017-05-08 13:08:44','6ac7cf8761de5dc8','2017-05-08 13:08:43',1,303),(89,'2017-05-08 15:49:34','7ed49f06b928c27b','2017-05-08 15:49:34',1,307),(90,'2017-05-08 15:56:14','776e81d876872474','2017-05-08 15:56:14',1,309),(91,'2017-05-08 15:58:52','7cebbea5b8ae5e8a','2017-05-08 15:58:51',1,310),(92,'2017-05-08 19:42:49','f29308f6323fa111','2017-05-08 19:42:48',1,245),(93,'2017-05-08 19:43:56','139373b685e8700f','2017-05-08 19:43:56',1,244),(94,'2017-05-08 19:44:38','d4bbb853ffac3c12','2017-05-08 19:44:37',1,246),(95,'2017-05-08 19:47:09','f2b44e1c01b60347','2017-05-08 19:47:09',1,219),(96,'2017-05-08 19:50:05','e5012bb0473508ad','2017-05-08 19:50:04',1,257),(97,'2017-05-08 20:29:55','3ba4b9f97a823122','2017-05-08 20:29:54',1,321),(98,'2017-05-08 20:46:24','75c96a3546b091a4','2017-05-08 20:46:24',1,254),(99,'2017-05-08 21:21:50','d0867d97e7ce3dce','2017-05-08 21:21:50',1,326),(100,'2017-05-08 22:07:36','8044431f86332e26','2017-05-08 22:07:36',1,247),(101,'2017-05-09 19:40:29','58bddb840e9f38a0','2017-05-09 19:40:29',1,212),(102,'2017-05-09 19:40:49','8840659529c15b11','2017-05-09 19:40:49',1,280),(103,'2017-05-09 19:41:06','2280d674f6455a88','2017-05-09 19:41:06',1,318),(104,'2017-05-09 19:41:23','6cb7b4a38b6a8905','2017-05-09 19:41:23',1,319),(105,'2017-05-09 19:41:41','862f737d75611bb3','2017-05-09 19:41:41',1,215),(106,'2017-05-09 19:41:54','932ba3aabf3860c2','2017-05-09 19:41:53',1,168),(107,'2017-05-09 19:42:12','3b6da785a0720245','2017-05-09 19:42:11',1,169),(108,'2017-05-09 19:42:25','e86b6096c8861771','2017-05-09 19:42:24',1,217),(109,'2017-05-09 19:42:42','d6877b74b4a5de98','2017-05-09 19:42:42',1,221),(110,'2017-05-09 19:42:59','e5550bf4244fc005','2017-05-09 19:42:58',1,242),(111,'2017-05-09 19:43:11','be568a70f0370a9d','2017-05-09 19:43:10',1,288),(112,'2017-05-09 19:43:24','b0c1526822e96912','2017-05-09 19:43:23',1,289),(113,'2017-05-09 19:43:36','ca224a6fa9611481','2017-05-09 19:43:35',1,297),(114,'2017-05-09 19:43:49','e0b03df77d0685c9','2017-05-09 19:43:48',1,298),(116,'2017-05-09 19:44:43','c69cdd7c66c72d93','2017-05-09 19:44:42',1,120),(117,'2017-05-09 19:45:11','1fb074ce35b6ef6a','2017-05-09 19:45:11',1,266),(118,'2017-05-09 19:45:30','a990d7483288dbc5','2017-05-09 19:45:30',1,269),(119,'2017-05-09 19:45:52','41e8a5567817011e','2017-05-09 19:45:51',1,282),(120,'2017-05-09 19:46:07','1c4ddded1e36fade','2017-05-09 19:46:07',1,198),(121,'2017-05-09 19:46:20','fa7d70429bf3e953','2017-05-09 19:46:19',1,328),(122,'2017-05-09 19:46:35','9534590c75836591','2017-05-09 19:46:34',1,329),(123,'2017-05-12 15:54:21','9ab2c17c97668dd2','2017-05-12 15:54:21',1,334),(124,'2017-05-13 19:00:20','9ae32674027154d1','2017-05-13 19:00:19',1,338),(125,'2017-05-15 15:39:06','cc08976633fd2f15','2017-05-15 15:39:06',1,339),(126,'2017-05-15 20:13:06','6f4f27ea1eaef082','2017-05-15 20:13:06',1,346),(127,'2017-05-15 21:17:48','472793c0d8b1f22a','2017-05-15 21:17:48',1,347);
/*!40000 ALTER TABLE `registrations` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (1,'2017-05-09 19:44:00','2017-05-09 19:44:00',1,324,NULL,NULL),(86,'2017-05-15 17:16:53','2017-05-15 17:18:04',1,341,'bc27f1fea53f6e94','2017-05-17 17:18:04');
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

-- Dump completed on 2018-01-31  9:23:13
