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

                List<EventVolunteerDTO> volunteerList = eventVolunteerReader.GetByEventId(eventId);
                var unitVolunteers = volunteerList.Where(p => p.Person.Unit.UnitId == registrant.Unit.UnitId).ToList();

                var totalVolunteerDays = unitVolunteers.Sum(s => s.VolunteerDays);
                var volunteerCount = totalVolunteerDays / 5;  //Specific to Summer DayCamp.  Need to make more Generic.

                validRegistraion = registrationList.Count < volunteerCount;
            }
            catch (Exception)
            {
                throw;
            }
            

            return validRegistraion;
        }
    }
}