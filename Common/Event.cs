using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class Event:DTOBase
    {
        public int EventID { get; set; }
        public Venue Venue { get; set; }
        public string Name { get; set; }
        public DateTime Start { get; set; }
        public DateTime End { get; set; }
        public string Description { get; set; }
        public DateTime LastUpdated { get; set; }
        public EventType EventType { get; set; }
        public bool StaffPaymentRequired { get; set; }
        public DateTime RegistrationDeadline { get; set; }
        public int RequiredStaffCount { get; set; }
        public int RequiredVolunteersCount { get; set; }

    }
}
