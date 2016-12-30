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

    }
}
