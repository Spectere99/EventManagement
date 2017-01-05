using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class Reservation:DTOBase
    {
        public int ReservationId { get; set; }
        public DateTime ReservationDate { get; set; }
        public DateTime LastUpdated { get; set; }
        public Event Event { get; set; }
        public Person Person { get; set; }

        public Reservation()
        {
            ReservationId = IntNullValue;
            ReservationDate = DateTimeNullValue;
            LastUpdated = DateTimeNullValue;
            Event = null;
            Person = null;
            IsNew = true;
        }

        public Reservation(int reservationId, DateTime reservationDate, DateTime lastUpdated, Event eventObj,
            Person person)
        {
            ReservationId = reservationId;
            ReservationDate = reservationDate;
            LastUpdated = lastUpdated;
            Event = eventObj;
            Person = person;
            IsNew = ReservationId.Equals(IntNullValue);
        }
    }
}
