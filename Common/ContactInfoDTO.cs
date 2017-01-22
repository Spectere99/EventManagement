using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class ContactInfoDTO:DTOBase
    {
        public int ContactInfoId { get; set; }
        public string Name { get; set; }
        public string HomePhone { get; set; }
        public string CellPhone { get; set; }
        public string Email { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }

        public ContactInfoDTO()
        {
            ContactInfoId = IntNullValue;
            Name = StringNullValue;
            HomePhone = StringNullValue;
            CellPhone = StringNullValue;
            Email = StringNullValue;
            Address1 = StringNullValue;
            Address2 = StringNullValue;
            City = StringNullValue;
            State = StringNullValue;
            Zip = StringNullValue;
            IsNew = true;
        }

        public ContactInfoDTO(int contactInfoId, string name, string homePhone, string cellPhone,
            string email, string address1, string address2, string city, string state, string zip)
        {
            ContactInfoId = contactInfoId;
            Name = name;
            HomePhone = homePhone;
            CellPhone = cellPhone;
            Email = email;
            Address1 = address1;
            Address2 = address2;
            City = city;
            State = state;
            Zip = zip;
            IsNew = contactInfoId.Equals(IntNullValue);
        }
    }
}
