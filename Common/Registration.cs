using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class Registration:DTOBase
    {
        public int RegistrationId { get; set; }
        public DateTime RegistrationDate { get; set; }
        public string ConfirmationNumber { get; set; }
        public DateTime LastUpdated { get; set; }
        public Event Event { get; set; }
        public Person Person { get; set; }

        public Registration()
        {
            RegistrationId = IntNullValue;
            RegistrationDate = DateTimeNullValue;
            ConfirmationNumber = StringNullValue;
            LastUpdated = DateTimeNullValue;
            Event = null;
            Person = null;
            IsNew = true;
        }

        public Registration(int registrationId, DateTime registrationDate, string confirmationNumber,
            DateTime lastUpdated, Event eventObj, Person person)
        {
            RegistrationId = registrationId;
            RegistrationDate = registrationDate;
            ConfirmationNumber = confirmationNumber;
            LastUpdated = lastUpdated;
            Event = eventObj;
            Person = person;
            IsNew = RegistrationId.Equals(IntNullValue);
        }
    }
}
