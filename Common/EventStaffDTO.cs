using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class EventStaffDTO:DTOBase
    {
        public int EventStaffId { get; set; }
        public DateTime LastUpdated { get; set; }
        public PositionDTO Position { get; set; }
        public EventDTO Event { get; set; }
        public PersonDTO Person { get; set; }


        public EventStaffDTO()
        {
            EventStaffId = IntNullValue;
            LastUpdated = DateTimeNullValue;
            Position = null;
            Event = null;
            Person = null;
            IsNew = true;
        }

        public EventStaffDTO(int eventStaffId, DateTime lastUpdated, PositionDTO position, EventDTO eventVal, PersonDTO person)
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
