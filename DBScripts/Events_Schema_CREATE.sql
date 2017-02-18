-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema events
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema events
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `events` DEFAULT CHARACTER SET utf8 ;
USE `events` ;

-- -----------------------------------------------------
-- Table `events`.`__migrationhistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`__migrationhistory` (
  `MigrationId` VARCHAR(150) NOT NULL,
  `ContextKey` VARCHAR(300) NOT NULL,
  `Model` LONGBLOB NOT NULL,
  `ProductVersion` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`MigrationId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`aspnetroles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`aspnetroles` (
  `Id` VARCHAR(128) NOT NULL,
  `Name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `RoleNameIndex` USING HASH (`Name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`aspnetusers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`aspnetusers` (
  `Id` VARCHAR(128) NOT NULL,
  `Hometown` LONGTEXT NULL DEFAULT NULL,
  `Email` VARCHAR(256) NULL DEFAULT NULL,
  `EmailConfirmed` TINYINT(1) NOT NULL,
  `PasswordHash` LONGTEXT NULL DEFAULT NULL,
  `SecurityStamp` LONGTEXT NULL DEFAULT NULL,
  `PhoneNumber` LONGTEXT NULL DEFAULT NULL,
  `PhoneNumberConfirmed` TINYINT(1) NOT NULL,
  `TwoFactorEnabled` TINYINT(1) NOT NULL,
  `LockoutEndDateUtc` DATETIME NULL DEFAULT NULL,
  `LockoutEnabled` TINYINT(1) NOT NULL,
  `AccessFailedCount` INT(11) NOT NULL,
  `UserName` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `UserNameIndex` USING HASH (`UserName` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`aspnetuserclaims`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`aspnetuserclaims` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `UserId` VARCHAR(128) NOT NULL,
  `ClaimType` LONGTEXT NULL DEFAULT NULL,
  `ClaimValue` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Id`),
  INDEX `IX_UserId` USING HASH (`UserId` ASC),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId`
    FOREIGN KEY (`UserId`)
    REFERENCES `events`.`aspnetusers` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`aspnetuserlogins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`aspnetuserlogins` (
  `LoginProvider` VARCHAR(128) NOT NULL,
  `ProviderKey` VARCHAR(128) NOT NULL,
  `UserId` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`LoginProvider`, `ProviderKey`, `UserId`),
  INDEX `IX_UserId` USING HASH (`UserId` ASC),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId`
    FOREIGN KEY (`UserId`)
    REFERENCES `events`.`aspnetusers` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`aspnetuserroles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`aspnetuserroles` (
  `UserId` VARCHAR(128) NOT NULL,
  `RoleId` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`UserId`, `RoleId`),
  INDEX `IX_UserId` USING HASH (`UserId` ASC),
  INDEX `IX_RoleId` USING HASH (`RoleId` ASC),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId`
    FOREIGN KEY (`RoleId`)
    REFERENCES `events`.`aspnetroles` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId`
    FOREIGN KEY (`UserId`)
    REFERENCES `events`.`aspnetusers` (`Id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`contactinfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`contactinfo` (
  `ContactInfoID` INT(11) NOT NULL AUTO_INCREMENT,
  `ContactName` VARCHAR(45) NOT NULL,
  `HomePhone` VARCHAR(15) NULL DEFAULT NULL,
  `CellPhone` VARCHAR(15) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Address1` VARCHAR(50) NOT NULL,
  `Address2` VARCHAR(50) NULL DEFAULT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(2) NOT NULL,
  `Zip` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`ContactInfoID`))
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`eventtypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`eventtypes` (
  `EventTypeID` INT(11) NOT NULL AUTO_INCREMENT,
  `EventType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`EventTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`events` (
  `EventID` INT(11) NOT NULL AUTO_INCREMENT,
  `VenueID` INT(11) NOT NULL,
  `EventName` VARCHAR(100) NOT NULL,
  `EventStart` DATETIME NOT NULL,
  `EventEnd` DATETIME NOT NULL,
  `EventDescription` VARCHAR(2000) NULL DEFAULT NULL,
  `LastUpdate` DATETIME NULL DEFAULT NULL,
  `EventTypes_EventTypeID` INT(11) NOT NULL,
  `StaffPaymentRequired` BIT(1) NULL DEFAULT NULL,
  `RegistrationDeadline` DATETIME NOT NULL,
  `RequiredStaff` INT(11) NOT NULL,
  `RequiredVolunteers` INT(11) NOT NULL,
  PRIMARY KEY (`EventID`, `EventTypes_EventTypeID`),
  UNIQUE INDEX `EventID_UNIQUE` (`EventID` ASC),
  INDEX `fk_Events_EventTypes_idx` (`EventTypes_EventTypeID` ASC),
  CONSTRAINT `fk_Events_EventTypes`
    FOREIGN KEY (`EventTypes_EventTypeID`)
    REFERENCES `events`.`eventtypes` (`EventTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`persontypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`persontypes` (
  `PersonTypeID` INT(11) NOT NULL AUTO_INCREMENT,
  `PersonType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PersonTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8
COMMENT = 'Stores what type of person is available (Leader, Parent, etc)';


-- -----------------------------------------------------
-- Table `events`.`person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`person` (
  `PersonID` INT(11) NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `MiddleName` VARCHAR(45) NULL DEFAULT NULL,
  `LastName` VARCHAR(45) NULL DEFAULT NULL,
  `LastUpdate` DATETIME NULL DEFAULT NULL,
  `contactInfo_ContactInfoID` INT(11) NOT NULL,
  `ParentPersonID` INT(11) NULL DEFAULT NULL,
  `persontype_PersonTypeID` INT(11) NOT NULL,
  `unitranks_UnitRankID` INT(11) NOT NULL,
  `units_UnitID` INT(11) NOT NULL,
  `user_id` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`PersonID`, `contactInfo_ContactInfoID`, `persontype_PersonTypeID`, `unitranks_UnitRankID`, `units_UnitID`),
  INDEX `fk_Person_ContactInfo1_idx` (`contactInfo_ContactInfoID` ASC),
  INDEX `fk_person_persontype1_idx` (`persontype_PersonTypeID` ASC),
  INDEX `fk_person_unitranks1_idx` (`unitranks_UnitRankID` ASC),
  INDEX `fk_person_units1_idx` (`units_UnitID` ASC),
  CONSTRAINT `fk_Person_ContactInfo1`
    FOREIGN KEY (`contactInfo_ContactInfoID`)
    REFERENCES `events`.`contactinfo` (`ContactInfoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_persontype1`
    FOREIGN KEY (`persontype_PersonTypeID`)
    REFERENCES `events`.`persontypes` (`PersonTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`positions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`positions` (
  `PositionID` INT(11) NOT NULL AUTO_INCREMENT,
  `Position` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PositionID`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`eventstaff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`eventstaff` (
  `EventStaffID` INT(11) NOT NULL AUTO_INCREMENT,
  `LastUpdated` DATETIME NOT NULL,
  `positions_PositionID` INT(11) NOT NULL,
  `events_EventID` INT(11) NOT NULL,
  `person_PersonID` INT(11) NOT NULL,
  PRIMARY KEY (`EventStaffID`, `positions_PositionID`, `events_EventID`, `person_PersonID`),
  INDEX `fk_eventstaff_positions1_idx` (`positions_PositionID` ASC),
  INDEX `fk_eventstaff_events1_idx` (`events_EventID` ASC),
  INDEX `fk_eventstaff_person1_idx` (`person_PersonID` ASC),
  CONSTRAINT `fk_eventstaff_events1`
    FOREIGN KEY (`events_EventID`)
    REFERENCES `events`.`events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventstaff_person1`
    FOREIGN KEY (`person_PersonID`)
    REFERENCES `events`.`person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventstaff_positions1`
    FOREIGN KEY (`positions_PositionID`)
    REFERENCES `events`.`positions` (`PositionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`eventvolunteers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`eventvolunteers` (
  `EventVolunteerID` INT(11) NOT NULL AUTO_INCREMENT,
  `LastUpdated` DATETIME NOT NULL,
  `events_EventID` INT(11) NOT NULL,
  `person_PersonID` INT(11) NOT NULL,
  `volunteerDays` INT(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`EventVolunteerID`, `events_EventID`, `person_PersonID`),
  INDEX `fk_eventvolunteers_events1_idx` (`events_EventID` ASC),
  INDEX `fk_eventvolunteers_person1_idx` (`person_PersonID` ASC),
  CONSTRAINT `fk_eventvolunteers_events1`
    FOREIGN KEY (`events_EventID`)
    REFERENCES `events`.`events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventvolunteers_person1`
    FOREIGN KEY (`person_PersonID`)
    REFERENCES `events`.`person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 27
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`registrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`registrations` (
  `RegistrationID` INT(11) NOT NULL AUTO_INCREMENT,
  `RegistrationDate` DATETIME NOT NULL,
  `Confirmation` VARCHAR(64) NOT NULL,
  `LastUpdated` DATETIME NULL DEFAULT NULL,
  `Events_EventID` INT(11) NOT NULL,
  `Person_PersonID` INT(11) NOT NULL,
  PRIMARY KEY (`RegistrationID`, `Events_EventID`, `Person_PersonID`),
  INDEX `fk_Registrations_Events1_idx` (`Events_EventID` ASC),
  INDEX `fk_Registrations_Person1_idx` (`Person_PersonID` ASC),
  CONSTRAINT `fk_Registrations_Events1`
    FOREIGN KEY (`Events_EventID`)
    REFERENCES `events`.`events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registrations_Person1`
    FOREIGN KEY (`Person_PersonID`)
    REFERENCES `events`.`person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`reservations` (
  `ReservationID` INT(11) NOT NULL AUTO_INCREMENT,
  `ReservationDate` DATETIME NOT NULL,
  `LastUpdated` DATETIME NOT NULL,
  `Events_EventID` INT(11) NOT NULL,
  `Person_PersonID` INT(11) NOT NULL,
  `RegistrationCode` VARCHAR(64) NULL DEFAULT NULL,
  `CodeExpiration` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`ReservationID`, `Events_EventID`, `Person_PersonID`),
  UNIQUE INDEX `RegistrationCode_UNIQUE` (`RegistrationCode` ASC),
  INDEX `fk_Reservations_Events1_idx` (`Events_EventID` ASC),
  INDEX `fk_Reservations_Person1_idx` (`Person_PersonID` ASC),
  CONSTRAINT `fk_Reservations_Events1`
    FOREIGN KEY (`Events_EventID`)
    REFERENCES `events`.`events` (`EventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservations_Person1`
    FOREIGN KEY (`Person_PersonID`)
    REFERENCES `events`.`person` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`unittypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`unittypes` (
  `UnitTypeID` INT(11) NOT NULL AUTO_INCREMENT,
  `UnitType` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`UnitTypeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`unitranks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`unitranks` (
  `UnitRankID` INT(11) NOT NULL AUTO_INCREMENT,
  `UnitRank` VARCHAR(45) NOT NULL,
  `unittypes_UnitTypeID` INT(11) NOT NULL,
  PRIMARY KEY (`UnitRankID`, `unittypes_UnitTypeID`),
  INDEX `fk_unitranks_unittypes1_idx` (`unittypes_UnitTypeID` ASC),
  CONSTRAINT `fk_unitranks_unittypes1`
    FOREIGN KEY (`unittypes_UnitTypeID`)
    REFERENCES `events`.`unittypes` (`UnitTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `events`.`units`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`units` (
  `UnitID` INT(11) NOT NULL AUTO_INCREMENT,
  `UnitNumber` INT(11) NOT NULL,
  `unittypes_UnitTypeID` INT(11) NOT NULL,
  PRIMARY KEY (`UnitID`, `UnitNumber`, `unittypes_UnitTypeID`),
  UNIQUE INDEX `UnitNumber_UNIQUE` (`UnitNumber` ASC, `unittypes_UnitTypeID` ASC),
  INDEX `fk_units_unittypes1_idx` (`unittypes_UnitTypeID` ASC),
  CONSTRAINT `fk_units_unittypes1`
    FOREIGN KEY (`unittypes_UnitTypeID`)
    REFERENCES `events`.`unittypes` (`UnitTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 91
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table of Unit groupings for organization of people.';


-- -----------------------------------------------------
-- Table `events`.`venue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `events`.`venue` (
  `VenueID` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(60) NOT NULL,
  `Contact` VARCHAR(45) NULL DEFAULT NULL,
  `contactinfo_ContactInfoID` INT(11) NOT NULL,
  PRIMARY KEY (`VenueID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;

USE `events` ;

-- -----------------------------------------------------
-- procedure delContactInfo
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delContactInfo`(IN pContactInfoID INT)
BEGIN
DELETE FROM `events`.`contactinfo`
WHERE ContactInfoID = pContactInfoID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delEvent
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delEvent`(IN pEventID INT)
BEGIN
DELETE FROM `events`.`events`
WHERE EventID = pEventID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delEventStaff
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delEventStaff`(IN pEventStaffID INT)
BEGIN
DELETE FROM `events`.`eventstaff`
WHERE EventStaffID = pEventStaffID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delEventType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delEventType`(IN pEventTypeID INT)
BEGIN
DELETE FROM `events`.`eventtypes`
WHERE EventTypeID = pEventTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delEventVolunteers
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delEventVolunteers`(IN pEventVolunteerID INT)
BEGIN
DELETE FROM `events`.`eventvolunteers`
WHERE EventVolunteerID = pEventVolunteerID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delPerson
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPerson`(IN pPersonID INT)
BEGIN
DELETE FROM `events`.`person`
WHERE PersonID = pPersonID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delPersonType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPersonType`(IN pPersonTypeID INT)
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delPosition
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delPosition`(IN pPositionID INT)
BEGIN
DELETE FROM `events`.`positions`
WHERE PositionID = pPositionID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delRegistration
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delRegistration`(IN pRegistrationID INT)
BEGIN
DELETE FROM `events`.`registrations`
WHERE RegistrationID = pRegistrationID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delReservation
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delReservation`(IN pReservationID INT)
BEGIN
DELETE FROM `events`.`reservations`
WHERE ReservationID = pReservationID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delUnit
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delUnit`(IN pUnitID INT)
BEGIN
DELETE FROM `events`.`units`
WHERE UnitID = pUnitID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delUnitRank
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delUnitRank`(IN pUnitRankID INT)
BEGIN
DELETE FROM `events`.`unitranks`
WHERE UnitRankID = pUnitRankID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delUnitType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delUnitType`(IN pUnitTypeID INT)
BEGIN
	DELETE FROM `events`.`unittypes`
WHERE UnitTypeID = pUnitTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delVenue
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delVenue`(IN pVenueID INT)
BEGIN
DELETE FROM `events`.`venue`
WHERE VenueID = pVenueID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insContactInfo
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insContactInfo`(IN pContactName VARCHAR(45)
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insEvent
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insEvent`(IN pVenueID INT
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insEventStaff
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insEventStaff`( IN pPositionID INT
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insEventType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insEventType`(IN pEventType VARCHAR(45), OUT oEventTypeID INT)
BEGIN
INSERT INTO `events`.`eventtypes`
(`EventType`)
VALUES
(pEventType);

SELECT LAST_INSERT_ID() INTO oEventTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insEventVolunteer
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insEventVolunteer`(IN pEventID INT, IN pPersonID INT, IN pvolunteerDays INT, OUT oEventVolunteerID INT)
BEGIN
INSERT INTO `events`.`eventvolunteers`
(`LastUpdated`,
`events_EventID`,
`person_PersonID`,
`volunteerDays`)
VALUES
(SYSDATE(),
pEventID,
pPersonID,
pvolunteerDays);

SELECT LAST_INSERT_ID() INTO oEventVolunteerID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insPerson
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPerson`(IN pFirstName VARCHAR(45)
							   , IN pMiddleName VARCHAR(45)
                               , IN pLastName VARCHAR(45)
                               , IN pContactInfoID INT
                               , IN pParentPersonID INT
                               , IN pPersonTypeID INT
                               , IN pUnitRankID INT
                               , IN pUnitID INT
                               , IN pUserID VARCHAR(45)
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
`user_id`)
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
,pUserID);

SELECT LAST_INSERT_ID() INTO oPersonID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insPersonType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPersonType`(IN pPersonType VARCHAR(45), OUT oPersonTypeID INT)
BEGIN

INSERT INTO `events`.persontypes
	(PersonType)
	VALUES
	(pPersonType);
    
SELECT LAST_INSERT_ID() into oPersonTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insPosition
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insPosition`(IN pPosition VARCHAR(45), OUT oPositionID INT)
BEGIN
INSERT INTO `events`.`positions`
(`Position`)
VALUES
(pPosition);

SELECT LAST_INSERT_ID() INTO oPositionID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insRegistration
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insRegistration`(IN pRegistrationDate DATETIME
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insReservation
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insReservation`( IN pReservationDate DATETIME
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insUnit
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insUnit`(IN pUnitNumber INT, IN pUnitTypeID INT, OUT oUnitID INT)
BEGIN
INSERT INTO `events`.`units`
(`UnitNumber`,
`unittypes_UnitTypeID`)
VALUES
(pUnitNumber,
pUnitTypeID);

SELECT LAST_INSERT_ID() INTO oUnitID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insUnitRank
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insUnitRank`(IN pUnitRank VARCHAR(45), IN pUnitTypeID INT, OUT oUnitRankID INT)
BEGIN
INSERT INTO `events`.`unitranks`
(`UnitRank`,
`unittypes_UnitTypeID`)
VALUES
(pUnitRank,
 pUnitTypeID);

SELECT LAST_INSERT_ID() INTO oUnitRankID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insUnitType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insUnitType`(IN pUnitType VARCHAR(45), OUT oUnitTypeID INT)
BEGIN
INSERT INTO `events`.`unittypes`
(`UnitType`)
VALUES
(pUnitType);

SELECT LAST_INSERT_ID() into oUnitTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure insVenue
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insVenue`(IN pName VARCHAR(60)

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



END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selContactInfo
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selContactInfo`()
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selContactInfoByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selContactInfoByID`(IN pContactInfoID INT)
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selEventByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selEventByID`(IN pEventID INT)
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selEventStaff
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selEventStaff`()
BEGIN
SELECT `eventstaff`.`EventStaffID`,
    `eventstaff`.`LastUpdated`,
    `eventstaff`.`positions_PositionID`,
    `eventstaff`.`events_EventID`,
    `eventstaff`.`person_PersonID`
FROM `events`.`eventstaff`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selEventStaffByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selEventStaffByID`(IN pEventStaffID INT)
BEGIN
SELECT `eventstaff`.`EventStaffID`,
    `eventstaff`.`LastUpdated`,
    `eventstaff`.`positions_PositionID`,
    `eventstaff`.`events_EventID`,
    `eventstaff`.`person_PersonID`
FROM `events`.`eventstaff`
WHERE EventStaffID = pEventStaffID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selEventTypeByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selEventTypeByID`(IN pEventTypeID INT)
BEGIN
SELECT `eventtypes`.`EventTypeID`,
    `eventtypes`.`EventType`
FROM `events`.`eventtypes`
WHERE EventTypeID = pEventTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selEventTypes
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selEventTypes`()
BEGIN
SELECT `eventtypes`.`EventTypeID`,
    `eventtypes`.`EventType`
FROM `events`.`eventtypes`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selEventVolunteerByEventID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selEventVolunteerByEventID`(IN pEventID INT)
BEGIN
SELECT `eventvolunteers`.`EventVolunteerID`,
    `eventvolunteers`.`LastUpdated`,
    `eventvolunteers`.`events_EventID`,
    `eventvolunteers`.`person_PersonID`,
    `eventvolunteers`.`volunteerDays`
FROM `events`.`eventvolunteers`
WHERE events_EventID = pEventID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selEventVolunteerByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selEventVolunteerByID`(IN pEventVolunteerID INT)
BEGIN
SELECT `eventvolunteers`.`EventVolunteerID`,
    `eventvolunteers`.`LastUpdated`,
    `eventvolunteers`.`events_EventID`,
    `eventvolunteers`.`person_PersonID`,
    `eventvolunteers`.`volunteerDays`
FROM `events`.`eventvolunteers`
WHERE EventVolunteerID = pEventVolunteerID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selEventVolunteers
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selEventVolunteers`()
BEGIN
SELECT `eventvolunteers`.`EventVolunteerID`,
    `eventvolunteers`.`LastUpdated`,
    `eventvolunteers`.`events_EventID`,
    `eventvolunteers`.`person_PersonID`,
    `eventvolunteers`.`volunteerDays`
FROM `events`.`eventvolunteers`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selEvents
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selEvents`()
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selPersonByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selPersonByID`(IN pPersonID INT)
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
    `person`.`user_id`
FROM `events`.`person`
WHERE PersonID = pPersonID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selPersonByParentID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selPersonByParentID`(IN pParentID INT)
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
    `person`.`user_id`
FROM `events`.`person`
WHERE ParentPersonID = pParentID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selPersonByUserId
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selPersonByUserId`(IN pUserId VARCHAR(45))
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
    `person`.`user_id`
FROM `events`.`person`
WHERE user_id = pUserID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selPersonType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selPersonType`()
BEGIN

SELECT persontypes.`PersonTypeID`,
    persontypes.`PersonType`
FROM `events`.persontypes;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selPersonTypeByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selPersonTypeByID`(IN pPersonTypeID INT)
BEGIN
SELECT persontypes.PersonTypeID,
    persontypes.PersonType
FROM `events`.persontypes
WHERE persontypes.PersonTypeID = pPersonTypeID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selPersons
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selPersons`()
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
    `person`.`user_id`
FROM `events`.`person`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selPositionByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selPositionByID`(IN pPositionID INT)
BEGIN
SELECT `positions`.`PositionID`,
    `positions`.`Position`
FROM `events`.`positions`
WHERE PositionID = pPositionID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selPositions
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selPositions`()
BEGIN
SELECT `positions`.`PositionID`,
    `positions`.`Position`
FROM `events`.`positions`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selRegistrationByEventID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selRegistrationByEventID`(IN pEventID INT)
BEGIN
SELECT `registrations`.`RegistrationID`,
    `registrations`.`RegistrationDate`,
    `registrations`.`Confirmation`,
    `registrations`.`LastUpdated`,
    `registrations`.`Events_EventID`,
    `registrations`.`Person_PersonID`
FROM `events`.`registrations`
WHERE Events_EventID = pEventID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selRegistrationByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selRegistrationByID`(IN pRegistrationID INT)
BEGIN
SELECT `registrations`.`RegistrationID`,
    `registrations`.`RegistrationDate`,
    `registrations`.`Confirmation`,
    `registrations`.`LastUpdated`,
    `registrations`.`Events_EventID`,
    `registrations`.`Person_PersonID`
FROM `events`.`registrations`
WHERE RegistrationID = pRegistrationID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selRegistrations
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selRegistrations`()
BEGIN
SELECT `registrations`.`RegistrationID`,
    `registrations`.`RegistrationDate`,
    `registrations`.`Confirmation`,
    `registrations`.`LastUpdated`,
    `registrations`.`Events_EventID`,
    `registrations`.`Person_PersonID`
FROM `events`.`registrations`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selReservation
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selReservation`()
BEGIN
SELECT `reservations`.`ReservationID`,
    `reservations`.`ReservationDate`,
    `reservations`.`LastUpdated`,
    `reservations`.`Events_EventID`,
    `reservations`.`Person_PersonID`,
    `reservations`.`RegistrationCode`,
    `reservations`.`CodeExpiration`
FROM `events`.`reservations`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selReservationByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selReservationByID`(IN pReservationID INT)
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selReservationByRegistrationCode
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selReservationByRegistrationCode`(IN pRegistrationCode VARCHAR(64))
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selReservations
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selReservations`()
BEGIN
SELECT `reservations`.`ReservationID`,
    `reservations`.`ReservationDate`,
    `reservations`.`LastUpdated`,
    `reservations`.`Events_EventID`,
    `reservations`.`Person_PersonID`,
    `reservations`.`RegistrationCode`,
    `reservations`.`CodeExpiration`
FROM `events`.`reservations`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selReservationsByEventID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selReservationsByEventID`(IN pEventID INT)
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selUnitByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selUnitByID`(IN pUnitID INT)
BEGIN
SELECT `units`.`UnitID`,
    `units`.`UnitNumber`,
    `units`.`unittypes_UnitTypeID`
FROM `events`.`units`
WHERE UnitID = pUnitID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selUnitRankByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selUnitRankByID`(IN pUnitRankID INT)
BEGIN
SELECT `unitranks`.`UnitRankID`,
    `unitranks`.`UnitRank`,
    `unitranks`.`unittypes_UnitTypeID`
FROM `events`.`unitranks`
WHERE UnitRankID = pUnitRankID;



END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selUnitRanks
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selUnitRanks`()
BEGIN
SELECT `unitranks`.`UnitRankID`,
    `unitranks`.`UnitRank`,
    `unitranks`.`unittypes_UnitTypeID`
FROM `events`.`unitranks`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selUnitType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selUnitType`()
BEGIN
SELECT `unittypes`.`UnitTypeID`,
    `unittypes`.`UnitType`
FROM `events`.`unittypes`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selUnitTypeByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selUnitTypeByID`(IN pUnitTypeID INT)
BEGIN
	SELECT `unittypes`.`UnitTypeID`,
    `unittypes`.`UnitType`
FROM `events`.`unittypes`
WHERE UnitTypeID = pUnitTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selUnits
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selUnits`()
BEGIN
SELECT `units`.`UnitID`,
    `units`.`UnitNumber`,
    `units`.`unittypes_UnitTypeID`
FROM `events`.`units`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selVenueByID
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selVenueByID`(IN pVenueID INT)
BEGIN
SELECT `venue`.`VenueID`,
    `venue`.`Name`,
    `venue`.`Contact`,
    `venue`.`contactinfo_ContactInfoID`
FROM `events`.`venue`
WHERE VenueID = pVenueID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure selVenues
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `selVenues`()
BEGIN
SELECT `venue`.`VenueID`,
    `venue`.`Name`,
    `venue`.`Contact`,
    `venue`.`contactinfo_ContactInfoID`
FROM `events`.`venue`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updContactInfo
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updContactInfo`(IN pContactInfoID INT
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updEvent
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updEvent`(IN pEventID int
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updEventStaff
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updEventStaff`(IN pEventStaffID INT
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updEventType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updEventType`(IN pEventTypeID INT, IN pEventType VARCHAR(45))
BEGIN
UPDATE `events`.`eventtypes`
SET
`EventType` = pEventType
WHERE `EventTypeID` = pEventTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updEventVolunteer
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updEventVolunteer`(IN pEventVolunteerID INT, IN pEventID INT, IN pPersonID INT, IN pvolunteerDays INT)
BEGIN
UPDATE `events`.`eventvolunteers`
SET
`LastUpdated` = SYSDATE(),
`events_EventID` = pEventID,
`person_PersonID` = pPersonID,
`volunteerDays` = pvolunteerDays
WHERE `EventVolunteerID` = pEventVolunteerID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updPerson
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updPerson`(IN pPersonID INT
							   , IN pFirstName VARCHAR(45)
							   , IN pMiddleName VARCHAR(45)
                               , IN pLastName VARCHAR(45)
                               , IN pContactInfoID INT
                               , IN pParentPersonID INT
                               , IN pPersonTypeID INT
                               , IN pUnitRankID INT
                               , IN pUnitID INT
                               , IN pUserID VARCHAR(45))
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
`user_id` = pUserID
WHERE `PersonID` = pPersonID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updPersonType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updPersonType`(IN pPersonTypeID INT, IN pPersonType VARCHAR(45))
BEGIN
	UPDATE `events`.persontypes
	SET
	 PersonType = pPersonType
	WHERE PersonTypeID = pPersonTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updPosition
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updPosition`(IN pPositionID INT, IN pPosition VARCHAR(45))
BEGIN
UPDATE `events`.`positions`
SET
`Position` = pPosition
WHERE `PositionID` = pPositionID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updRegistration
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updRegistration`(IN pRegistrationID INT
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updReservation
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updReservation`( IN pReservationID INT
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

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updUnit
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updUnit`(IN pUnitID INT, IN pUnitNumber INT, IN pUnitTypeID INT)
BEGIN
UPDATE `events`.`units`
SET
`UnitNumber` = pUnitNumber,
`unittypes_UnitTypeID` = pUnitTypeID
WHERE `UnitID` = pUnitID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updUnitRank
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updUnitRank`(IN pUnitRankID INT, IN pUnitRank VARCHAR(45), IN pUnitTypeID INT)
BEGIN
UPDATE `events`.`unitranks`
SET
`UnitRank` = pUnitRank,
`unittypes_UnitTypeID` = pUnitTypeID
WHERE `UnitRankID` = pUnitRankID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updUnitType
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updUnitType`(IN pUnitTypeID INT, IN pUnitType VARCHAR(45))
BEGIN
UPDATE `events`.`unittypes`
SET
`UnitType` = pUnitType
WHERE `UnitTypeID` = pUnitTypeID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure updVenue
-- -----------------------------------------------------

DELIMITER $$
USE `events`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updVenue`(IN pVenueID INT
							 , IN pName VARCHAR(60)
                             , IN pContact VARCHAR(45)
                             , IN pContactInfoID INT)
BEGIN
UPDATE `events`.`venue`
SET `Name` =pName,
`Contact` = pContact,
`contactinfo_ContactInfoID` = pContactInfoID
WHERE `VenueID` = pVenueID;

END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
