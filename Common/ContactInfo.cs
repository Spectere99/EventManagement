using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class ContactInfo:DTOBase
    {
        public int ContactInfoId { get; set; }
        public string Name { get; set; }
        public string HomePhone { get; set; }
        public string BusinessPhone { get; set; }
        public string CellPhone { get; set; }
        public string Email { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }

        public ContactInfo()
        {
            ContactInfoId = IntNullValue;
            Name = StringNullValue;
            HomePhone = StringNullValue;
            BusinessPhone = StringNullValue;
            CellPhone = StringNullValue;
            Email = StringNullValue;
            Address1 = StringNullValue;
            Address2 = StringNullValue;
            City = StringNullValue;
            State = StringNullValue;
            Zip = StringNullValue;
            IsNew = true;
        }
    }
}
