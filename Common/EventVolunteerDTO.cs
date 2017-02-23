using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class EventVolunteerDTO:DTOBase
    {
        public int EventVolunteerId { get; set; }
        public DateTime LastUpdated { get; set; }
        public EventDTO Event { get; set; }
        public PersonDTO Person { get; set; }

        public bool Monday { get; set; }
        public bool Tuesday { get; set; }
        public bool Wednesday { get; set; }
        public bool Thursday { get; set; }
        public bool Friday { get; set; }
        public bool Saturday { get; set; }
        public bool Sunday { get; set; }
        public int VolunteerDays { get; set; }
            

        public EventVolunteerDTO()
        {
            EventVolunteerId = IntNullValue;
            LastUpdated = DateTimeNullValue;
            Event = null;
            Person = null;
            Monday = Tuesday = Wednesday = Thursday = Friday = Saturday = Sunday = false;
            VolunteerDays = 0;
            IsNew = true;
        }

        public EventVolunteerDTO(int eventVolunteerId, DateTime lastUpdated, EventDTO eventObj, PersonDTO person, bool mondayVol
                                 , bool tuesdayVol, bool wednesdayVol, bool thursdayVol, bool fridayVol, bool saturdayVol
                                 , bool sundayVol, int volunteerDays)
        {
            EventVolunteerId = eventVolunteerId;
            LastUpdated = lastUpdated;
            Event = eventObj;
            Person = person;
            Monday = mondayVol;
            Tuesday = tuesdayVol;
            Wednesday = wednesdayVol;
            Thursday = thursdayVol;
            Friday = fridayVol;
            Saturday = saturdayVol;
            Sunday = sundayVol;
            VolunteerDays = volunteerDays;
            IsNew = EventVolunteerId.Equals(IntNullValue);
        }
    }
}
