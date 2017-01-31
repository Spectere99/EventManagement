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
using Microsoft.AspNet.Identity;
using WebGrease.Css.Ast.Selectors;

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
        public ActionResult AttendeeSelection()
        {
            AttendeeViewList attendeeList = new AttendeeViewList();

            PersonReader personReader = new PersonReader();
            var userId = User.Identity.GetUserId();
            //Get person based on their user id
            var person = personReader.GetByUserId(userId).FirstOrDefault();
            if (person != null)
            {
                attendeeList.AttendeeList = new List<AttendeeViewModel>();
                attendeeList.ParentId = person.PersonId;
                var attendee = TranslatePersonDTO(person);
                attendeeList.AttendeeList.Add(attendee);
                //Need to load the children now.
                var children = personReader.GetByParentId(person.PersonId);
                
                foreach (var child in children)
                {
                    var childViewModel = TranslatePersonDTO(child);
                    attendeeList.AttendeeList.Add(childViewModel);
                }
                
            }

            return View(attendeeList);
        }
        
        [Authorize]
        public ActionResult EventSelection(int id)
        {
            //Get available Events
            EventReader eventReader = new EventReader();
            PersonReader personReader = new PersonReader();

            var person = personReader.GetById(id).FirstOrDefault();

            if (person != null)
            {
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
                registrationViewModel.Registration.Person = person;

                //var dropDownEvents = new SelectList(events.OrderBy(p=>p.Start).ToList(), "EventId", "Name");
                //ViewBag.EventList = dropDownEvents;

                return View(registrationViewModel);
            }
            //If we dont' have a person passed in, we cannot continue and need to redirect to a login page.
            return RedirectToAction("Login", "Account");
        }

        [Authorize]
        public ActionResult EventVolunteerSelection(int id)
        {
            //Get available Events
            EventReader eventReader = new EventReader();
            PersonReader personReader = new PersonReader();

            var person = personReader.GetById(id).FirstOrDefault();

            if (person != null)
            {
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
                VolunteerRegistrationViewModel volunteerRegistration = new VolunteerRegistrationViewModel();
                volunteerRegistration.EventList = events;
                volunteerRegistration.Person = person;
                volunteerRegistration.Event = null;

                //var dropDownEvents = new SelectList(events.OrderBy(p=>p.Start).ToList(), "EventId", "Name");
                //ViewBag.EventList = dropDownEvents;

                return View(volunteerRegistration);
            }
            //If we dont' have a person passed in, we cannot continue and need to redirect to a login page.
            return RedirectToAction("Login", "Account");
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

        public ActionResult VolunteerEntry(int id)
        {
            if (Session["RegistrationEvent"] != null)
            {
                PersonReader personReader = new PersonReader();
                EventVolunteerReader eventVolunteerReader = new EventVolunteerReader();

                var person = personReader.GetById(id).FirstOrDefault();

                if (person != null)
                {
                    //Need to check for existing registration.
                    VolunteerRegistrationViewModel volunteerRegistration = new VolunteerRegistrationViewModel();
                    List<EventVolunteerDTO> volunteerList = new List<EventVolunteerDTO>();

                    EventVolunteerDTO newVolunteer = new EventVolunteerDTO();
                    newVolunteer.Event = Session["RegistrationEvent"] as EventDTO;
                    newVolunteer.Person = person;
                    
                    volunteerList.Add(newVolunteer);
                    eventVolunteerReader.Save(volunteerList);
                    
                    volunteerRegistration.Person = person;
                    volunteerRegistration.Event = newVolunteer.Event;

                    Session["RegistrationEvent"] = null;
                    return View(volunteerRegistration);
                }
                
            }
            return View();  //Need to redirect to Error Page because Event was not selected.
        }

        private AttendeeViewModel TranslatePersonDTO(PersonDTO person)
        {
            AttendeeViewModel attendeeViewModel = new AttendeeViewModel
            {
                PersonId = person.PersonId,
                FirstName = person.FirstName,
                MiddleName = person.MiddleName,
                LastName = person.LastName,
                PersonType = person.PersonType.Type,
                UnitType = person.Unit.UnitType.Type,
                Unit = person.Unit.UnitNumber.ToString(),
                UnitRank = person.Rank.Rank,
                ContactInfo = new ContactInfoViewModel
                {
                    ContactName = person.ContactInfo.Name,
                    Email = person.ContactInfo.Email,
                    Address1 = person.ContactInfo.Address1,
                    Address2 = person.ContactInfo.Address2,
                    CellPhone = person.ContactInfo.CellPhone,
                    HomePhone = person.ContactInfo.HomePhone,
                    City = person.ContactInfo.City,
                    State = person.ContactInfo.State,
                    Zip = person.ContactInfo.Zip
                }
            };

            return attendeeViewModel;
        }
        //[HttpPost]
        //public ActionResult RegisterForEvent(Models.RegistrationViewModel)
        //{
        //    return View();
        //}
    }
}