using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Diagnostics.Eventing.Reader;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class EventDTO:DTOBase
    {
        public int EventId { get; set; }
        public VenueDTO Venue { get; set; }
        public string Name { get; set; }
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
        public string Description { get; set; }
        public DateTime LastUpdated { get; set; }
        public EventTypeDTO EventType { get; set; }
        public bool StaffPaymentRequired { get; set; }
        public DateTime RegistrationDeadline { get; set; }
        public int RequiredStaffCount { get; set; }
        public int RequiredVolunteersCount { get; set; }

        public EventDTO()
        {
            EventId = IntNullValue;
            Venue = new VenueDTO();
            Name = StringNullValue;
            Start = DateTimeNullValue;
            End = DateTimeNullValue;
            Description = StringNullValue;
            LastUpdated = DateTimeNullValue;
            EventType = new EventTypeDTO();
            StaffPaymentRequired = false;
            RegistrationDeadline = DateTimeNullValue;
            RequiredStaffCount = 0;
            RequiredVolunteersCount = 0;
            IsNew = true;
        }

        public EventDTO(int eventId, VenueDTO venue, string name, DateTime start, DateTime end, string description,
            DateTime lastUpdate, EventTypeDTO eventType,
            bool staffPaymentReq, DateTime registrationDeadline, int requiredStaff, int requiredVolunteers)
        {
            EventId = eventId;
            Venue = venue;
            Name = name;
            Start = start;
            End = end;
            Description = description;
            LastUpdated = lastUpdate;
            EventType = eventType;
            StaffPaymentRequired = staffPaymentReq;
            RegistrationDeadline = registrationDeadline;
            RequiredStaffCount = requiredStaff;
            RequiredVolunteersCount = requiredVolunteers;

            IsNew = eventId.Equals(IntNullValue);
        }

    }
}
