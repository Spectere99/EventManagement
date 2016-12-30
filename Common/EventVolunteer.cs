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

    }
}
