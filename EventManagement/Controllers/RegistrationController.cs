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
        // Sets up for the user to select the event that they want to register for.
        public ActionResult Index()
        {
            return View();
        }

        
        [Authorize]
        public ActionResult EventSelection()
        {
            //Get available Events
            EventReader eventReader = new EventReader();
            var eventDtos = eventReader.GetList().OrderBy(p => p.Start).ToList();

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
            registrationViewModel.Registration = new RegistrationDTO();

            //var dropDownEvents = new SelectList(events.OrderBy(p=>p.Start).ToList(), "EventId", "Name");
            //ViewBag.EventList = dropDownEvents;

            return View(registrationViewModel);
        }
        public ActionResult RegistrantEntry()
        {
            if (Session["RegistrationEvent"] != null)
            {
                UnitTypeReader unitTypeReader = new UnitTypeReader();
                var unitTypes = unitTypeReader.GetList();

                SelectList unitTypeList = new SelectList(unitTypes, "UnitTypeId", "Type");
                ReservationViewModel reservationViewModel = new ReservationViewModel
                {
                    ReservationDate = DateTime.Now,
                    Event = Session["RegistrationEvent"] as EventDTO,
                    UnitTypeList = unitTypeList
                };
                return View(reservationViewModel);
            }
            return View();
        }

        public ActionResult VolunteerEntry()
        {
            if (Session["RegistrationEvent"] != null)
            {
                PersonTypeReader personTypeReader = new PersonTypeReader();
                UnitTypeReader unitTypeReader = new UnitTypeReader();

                var personTypes = personTypeReader.GetList();
                var unitTypes = unitTypeReader.GetList();

                SelectList personTypeList = new SelectList(personTypes, "PersonTypeId", "Type");
                SelectList unitTypeList = new SelectList(unitTypes, "UnitTypeId", "Type");
                ReservationViewModel reservationViewModel = new ReservationViewModel
                {
                    ReservationDate = DateTime.Now,
                    Event = Session["RegistrationEvent"] as EventDTO,
                    PersonType = personTypeList,
                    UnitTypeList = unitTypeList
                };
                return View(reservationViewModel);
            }
            return View();
        }

        //[HttpPost]
        //public ActionResult RegisterForEvent(Models.RegistrationViewModel)
        //{
        //    return View();
        //}
    }
}