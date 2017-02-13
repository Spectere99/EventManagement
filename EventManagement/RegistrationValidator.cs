using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common;
using Common.Reader;

namespace EventManagement
{
    public class RegistrationValidator
    {
        public bool DayCampRegistrationValid(PersonDTO registrant, int eventId)
        {
            bool validRegistraion = false;
            try
            {
                //Get Unit Type and Number from registrant.
                EventVolunteerReader eventVolunteerReader = new EventVolunteerReader();
                RegistrationReader registrationReader = new RegistrationReader();

                List<RegistrationDTO> registrationList = registrationReader.GetByEventId(eventId);
                var registrationListUnitCount =
                    registrationList.Count(p => p.Person.Unit.UnitId == registrant.Unit.UnitId);

                List<EventVolunteerDTO> volunteerList = eventVolunteerReader.GetByEventId(eventId);

                var parentVolunteer =
                    volunteerList.FirstOrDefault(p => p.Person.PersonId == registrant.ParentPerson.PersonId);
                
                bool parentIsVolunteer = volunteerList.Any(p => p.Person.PersonId == registrant.ParentPerson.PersonId);

                if (parentVolunteer != null && (parentIsVolunteer && parentVolunteer.VolunteerDays == 5)) // Bypass other checks.  This person is automatically registered.
                {
                    validRegistraion = true;
                }
                else
                {
                    var unitVolunteers = volunteerList.Where(p => p.Person.Unit.UnitId == registrant.Unit.UnitId).ToList();

                    var totalVolunteerDays = unitVolunteers.Sum(s => s.VolunteerDays);
                    double volunteerCount = totalVolunteerDays / 5.0; //Specific to Summer DayCamp.  Need to make more Generic.

                    if (Math.Abs(((volunteerCount*5)%5)) == 0)
                    {
                        validRegistraion = registrationListUnitCount < (volunteerCount * 5);        
                    }
                    
                }
                
            }
            catch (Exception)
            {
                throw;
            }
            return validRegistraion;
        }

        public bool CheckForExistingRegistration(PersonDTO registrant, int eventId)
        {
            try
            {
                RegistrationReader registrationReader = new RegistrationReader();

                List<RegistrationDTO> registrationList = registrationReader.GetByEventId(eventId);

                return registrationList.Any(p => p.Person.PersonId == registrant.PersonId);
            }
            catch (Exception)
            {
                
                throw;
            }
        }
    }
}