using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class VenueDTO : DTOBase
    {
        public int VenueId { get; set; }
        public string Name { get; set; }
        public string Contact { get; set; }
        public ContactInfoDTO ContactInfo { get; set; }

        public VenueDTO()
        {
            VenueId = IntNullValue;
            Name = StringNullValue;
            Contact = StringNullValue;
            ContactInfo = new ContactInfoDTO();
            IsNew = true;
        }

        public VenueDTO(int venueId, string name, string contact, ContactInfoDTO contactInfo)
        {
            VenueId = venueId;
            Name = name;
            Contact = contact;
            ContactInfo = contactInfo;
        }

    }
}
