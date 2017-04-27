using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Common;
using Common.Reader;

namespace EventManagement
{
    public class ReservationListActions
    {
        private ReservationReader _reservationReader = null;
        private PersonReader _personReader = null;
        
        public ReservationListActions()
        {
            _reservationReader = new ReservationReader();
            _personReader = new PersonReader();
        }

        public Boolean ValidateReservationByCode(string code)
        {
            ReservationDTO result = _reservationReader.GetByRegistrationCode(code);

            return result != null;
        }

        public List<ReservationDTO> GetReservationOpenings(PersonDTO volunteerPerson, int eventId)
        {
            //Will check the eventId for reservation openings based on
            // 1) The Person that has volunteered (passed in)
            // 2)  number of volunteer days
            // 3)  number of open slots.

            //Get Unit Type and Number from registrant.
            EventVolunteerReader eventVolunteerReader = new EventVolunteerReader();
            RegistrationReader registrationReader = new RegistrationReader();

            List<RegistrationDTO> registrationList = registrationReader.GetByEventId(eventId);
            var registrationListUnitCount =
                registrationList.Count(p => p.Person.Unit.UnitId == volunteerPerson.Unit.UnitId);

            List<EventVolunteerDTO> volunteerList = eventVolunteerReader.GetByEventId(eventId);

            var unitVolunteers = volunteerList.Where(p => p.Person.Unit.UnitId == volunteerPerson.Unit.UnitId).ToList();

            var totalVolunteerDays = unitVolunteers.Sum(s => s.VolunteerDays);
            double volunteerCount = totalVolunteerDays / 5.0; //Specific to Summer DayCamp.  Need to make more Generic.

            double availableSlots = 0;
            if (totalVolunteerDays >= 5)
            {
                int possibleSlots = totalVolunteerDays/5;
                availableSlots = (possibleSlots * 5) - registrationListUnitCount;
            }
            //if (Math.Abs(((volunteerCount*5)%5)) == 0)
            //{
            //    availableSlots = (volunteerCount*5) - registrationListUnitCount;
            //}
           
            var reservations = GetNextAvailableReservations(eventId, volunteerPerson.Unit.UnitId, (int)availableSlots);
            return reservations;
        }
        public void RemoveReservationCode(string code)
        {
            ReservationDTO result = _reservationReader.GetByRegistrationCode(code);

            result.RegistrationCode = null;
            result.ReservationDate = DateTime.Now;

            _reservationReader.Save(new List<ReservationDTO>() {result});
        }

        private List<ReservationDTO> GetNextAvailableReservations(int eventId, int unitId, int openSpots)
        {
            var result = _reservationReader.GetByEventId(eventId);
            var unitPersons = _personReader.GetList().Where(p => p.Unit.UnitId == unitId).ToList();

            List<ReservationDTO> openReservations = new List<ReservationDTO>();
            //Take the top number of open spots from the list of who reserved first.
            List<ReservationDTO> unitReservations = result.Where(aResult => unitPersons.Any(aPerson => aResult.Person.Unit.UnitId == aPerson.Unit.UnitId)).ToList();
            var orderedList = unitReservations.OrderBy(o => o.ReservationDate);
            var availableSlots = orderedList.Take(openSpots).ToList();
            foreach (var reservation in availableSlots)
            {
                var confirmationCode = Utilities.GenerateConfirmationCode();  //We are using the Confirmation code for the registration code.
                reservation.RegistrationCode = confirmationCode;
                reservation.CodeExpiration = DateTime.Now.AddDays(2);
                openReservations.Add(reservation);
            }
            //Need to update the reservations with the updated Confirmation codes
            _reservationReader.Save(openReservations);
            return openReservations;
        }

    }
}