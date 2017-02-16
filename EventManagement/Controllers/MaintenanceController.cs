using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Common;
using Common.Reader;

namespace EventManagement.Controllers
{
    public class MaintenanceController : ApiController
    {
        [HttpPost]
        public string ExpireWaitingListCodes()
        {
            //pull the list of reservations and check the CodeExpiration property.
            // If they are past the current date, clear the code
            ReservationReader reservationReader = new ReservationReader();

            var reservations = reservationReader.GetList();
            List<ReservationDTO> resetReservations = new List<ReservationDTO>();
            foreach (ReservationDTO reservation in reservations)
            {
                if (reservation.CodeExpiration != null)
                {
                    if (DateTime.Now > reservation.CodeExpiration)
                    {
                        reservation.RegistrationCode = null;
                        resetReservations.Add(reservation);
                    }
                }
            }

            reservationReader.Save(resetReservations);
            return null;
        }
    }
}
