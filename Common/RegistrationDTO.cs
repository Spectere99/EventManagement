using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class RegistrationDTO:DTOBase
    {
        public int RegistrationId { get; set; }
        public DateTime RegistrationDate { get; set; }
        public string ConfirmationNumber { get; set; }
        public DateTime LastUpdated { get; set; }
        public EventDTO Event { get; set; }
        public PersonDTO Person { get; set; }

        public RegistrationDTO()
        {
            RegistrationId = IntNullValue;
            RegistrationDate = DateTimeNullValue;
            ConfirmationNumber = StringNullValue;
            LastUpdated = DateTimeNullValue;
            Event = null;
            Person = null;
            IsNew = true;
        }

        public RegistrationDTO(int registrationId, DateTime registrationDate, string confirmationNumber,
            DateTime lastUpdated, EventDTO eventObj, PersonDTO person)
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
