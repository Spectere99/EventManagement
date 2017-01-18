using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common;
using Common.Reader;
using EventManagement.Models;
using EventManagement.Models.Extensions;

namespace EventManagement.Controllers
{
    public class RegistrationController : Controller
    {
        // GET: Registration
        public ActionResult Index()
        {
            //Get available Events
            EventReader eventReader = new EventReader();
            var eventDtos = eventReader.GetList().OrderBy(p=>p.Start).ToList();

            List<EventViewModel> events = new List<EventViewModel>();
            foreach (var eventDto in eventDtos)
            {
                EventViewModel anEvent = new EventViewModel();
                anEvent.EventId = eventDto.EventId;
                anEvent.EventType = new EventTypeModel
                {
                    EventTypeId = eventDto.EventType.EventTypeId,
                    EventType = eventDto.EventType.Type
                };
                anEvent.Description = eventDto.Description;
                anEvent.EventEnd = eventDto.End;
                anEvent.EventStart = eventDto.Start;
                anEvent.EventName = eventDto.Name;
                anEvent.LastUpdated = eventDto.LastUpdated;
                anEvent.RegistrationDeadline = eventDto.RegistrationDeadline;
                anEvent.RequiredStaff = eventDto.RequiredStaffCount;
                anEvent.RequiredVolunteers = eventDto.RequiredVolunteersCount;
                anEvent.StaffPaymentRequired = eventDto.StaffPaymentRequired;

                events.Add(anEvent);
            }
            RegistrationViewModel registrationViewModel = new RegistrationViewModel();
            registrationViewModel.EventList = events;
            registrationViewModel.Reservation = new ReservationDTO();

            //var dropDownEvents = new SelectList(events.OrderBy(p=>p.Start).ToList(), "EventId", "Name");
            //ViewBag.EventList = dropDownEvents;

            return View(registrationViewModel);
        }

        [HttpGet]
        public ActionResult GetVenueDetails(int eventId)
        {
            EventReader eventReader = new EventReader();

            var theEvent = eventReader.GetById(eventId).SingleOrDefault();
            if (theEvent != null)
            {
                return Json(theEvent.Venue, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return null;
            }

        }
    }
}