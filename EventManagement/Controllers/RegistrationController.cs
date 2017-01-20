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
                //UnitReader unitReader = new UnitReader();
                var unitTypes = unitTypeReader.GetList();
                //var units = unitReader.GetList();

                //SelectList unitList = new SelectList(units, "UnitId", "UnitNumber");
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
        [HttpGet]
        public ActionResult GetVenueDetails(int eventId)
        {
            EventReader eventReader = new EventReader();

            var theEvent = eventReader.GetById(eventId).SingleOrDefault();
            if (theEvent != null)
            {
                //Store in Session object for use during the other registration areas
                Session["RegistrationEvent"] = theEvent;
                return Json(theEvent.Venue, JsonRequestBehavior.AllowGet);
            }
            return null;
            
        }

        [HttpGet]
        public ActionResult GetEventDate(int eventId)
        {
            EventReader eventReader = new EventReader();

            var theEvent = eventReader.GetById(eventId).SingleOrDefault();
            if (theEvent != null)
            {
                var dates = theEvent.Start + " thru " + theEvent.End;
                return Json(dates, JsonRequestBehavior.AllowGet);
            }
            return null;
            
        }
        [HttpGet]
        public ActionResult GetUnits(int typeId)
        {
            UnitReader unitReader = new UnitReader();
            var units = unitReader.GetList();
            //List<SelectListItem> unitList = new List<SelectListItem>();

            SelectList unitList = new SelectList(units.Where(p => p.UnitType.UnitTypeId.Equals(typeId)).ToList(), "UnitId", "UnitNumber");
            return Json(unitList, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult GetRanks(int typeId)
        {
            UnitRankReader unitRankReader = new UnitRankReader();
            var unitRanks = unitRankReader.GetList();
            SelectList rankList = new SelectList(unitRanks.Where(p=>p.UnitType.UnitTypeId.Equals(typeId)).ToList(), "UnitRankId", "Rank");

            return Json(rankList, JsonRequestBehavior.AllowGet);
        }
        //[HttpPost]
        //public ActionResult RegisterForEvent(Models.RegistrationViewModel)
        //{
        //    return View();
        //}
    }
}