using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class EventStaff:DTOBase
    {
        public int EventStaffId { get; set; }
        public DateTime LastUpdated { get; set; }
        public Position Position { get; set; }
        public Event Event { get; set; }
        public Person Person { get; set; }


        public EventStaff()
        {
            EventStaffId = IntNullValue;
            LastUpdated = DateTimeNullValue;
            Position = null;
            Event = null;
            Person = null;
            IsNew = true;
        }

        public EventStaff(int eventStaffId, DateTime lastUpdated, Position position, Event eventVal, Person person)
        {
            EventStaffId = eventStaffId;
            LastUpdated = lastUpdated;
            Position = position;
            Event = eventVal;
            Person = person;
            IsNew = EventStaffId.Equals(IntNullValue);
        }
    }
}
