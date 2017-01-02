using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
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

        public Venue()
        {
            VenueId = IntNullValue;
            Name = StringNullValue;
            Contact = StringNullValue;
            ContactInfo = new ContactInfo();
            IsNew = true;
        }

        public Venue(int venueId, string name, string contact, ContactInfo contactInfo)
        {
            VenueId = venueId;
            Name = name;
            Contact = contact;
            ContactInfo = contactInfo;
        }

    }
}
