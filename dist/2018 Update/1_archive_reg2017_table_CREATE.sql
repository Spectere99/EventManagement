CREATE TABLE `events`.`registrations_2017` (
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
