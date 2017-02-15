using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class ReservationDTO:DTOBase
    {
        public int ReservationId { get; set; }
        public DateTime ReservationDate { get; set; }
        public DateTime LastUpdated { get; set; }
        public EventDTO Event { get; set; }
        public PersonDTO Person { get; set; }
        public string RegistrationCode { get; set; }

        public ReservationDTO()
        {
            ReservationId = IntNullValue;
            ReservationDate = DateTimeNullValue;
            LastUpdated = DateTimeNullValue;
            Event = null;
            Person = null;
            RegistrationCode = null;
            IsNew = true;
        }

        public ReservationDTO(int reservationId, DateTime reservationDate, DateTime lastUpdated, EventDTO eventObj,
            PersonDTO person, string registrationCode)
        {
            ReservationId = reservationId;
            ReservationDate = reservationDate;
            LastUpdated = lastUpdated;
            Event = eventObj;
            Person = person;
            RegistrationCode = registrationCode;
            IsNew = ReservationId.Equals(IntNullValue);
        }
    }
}
