DELETE FROM events.registrations
 WHERE RegistrationID > 0;
 
DELETE FROM events.eventvolunteers
  WHERE EventVolunteerID > 0;