using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class Venue : DTOBase
    {
        public int VenueId { get; set; }
        public string Name { get; set; }
        public string Contact { get; set; }
        public ContactInfo ContactInfo { get; set; }

    }
}
