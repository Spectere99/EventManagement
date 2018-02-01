CREATE TABLE `events`.`eventvolunteers_2017` (
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
