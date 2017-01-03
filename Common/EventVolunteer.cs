using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class EventVolunteer:DTOBase
    {
        public int EventVolunteerId { get; set; }
        public DateTime LastUpdated { get; set; }
        public Event Event { get; set; }
        public Person Person { get; set; }

        public EventVolunteer()
        {
            EventVolunteerId = IntNullValue;
            LastUpdated = DateTimeNullValue;
            Event = null;
            Person = null;
            IsNew = true;
        }

        public EventVolunteer(int eventVolunteerId, DateTime lastUpdated, Event eventObj, Person person)
        {
            EventVolunteerId = eventVolunteerId;
            LastUpdated = lastUpdated;
            Event = eventObj;
            Person = person;
            IsNew = EventVolunteerId.Equals(IntNullValue);
        }
    }
}
