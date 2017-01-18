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

        public EventVolunteerDTO()
        {
            EventVolunteerId = IntNullValue;
            LastUpdated = DateTimeNullValue;
            Event = null;
            Person = null;
            IsNew = true;
        }

        public EventVolunteerDTO(int eventVolunteerId, DateTime lastUpdated, EventDTO eventObj, PersonDTO person)
        {
            EventVolunteerId = eventVolunteerId;
            LastUpdated = lastUpdated;
            Event = eventObj;
            Person = person;
            IsNew = EventVolunteerId.Equals(IntNullValue);
        }
    }
}
