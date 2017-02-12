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
                RegistrationViewModel registrationViewModel = new RegistrationViewModel
                {
                    EventList = events,
                    Event = null,
                    Person = person
                };

                //var dropDownEvents = new SelectList(events.OrderBy(p=>p.Start).ToList(), "EventId", "Name");
                //ViewBag.EventList = dropDownEvents;
                TempData["EventRegistant"] = registrationViewModel;
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
                TempData["VolunteerRegistant"] = volunteerRegistration;
                return View(volunteerRegistration);
            }
            //If we dont' have a person passed in, we cannot continue and need to redirect to a login page.
            return RedirectToAction("Login", "Account");
        }
        public ActionResult RegistrantConfirm(RegistrationViewModel model)
        {
            RegistrationViewModel registrationEntry = TempData["EventRegistant"] as RegistrationViewModel;
            model.Event = Session["RegistrationEvent"] as EventDTO;
            if (model.Event != null)
            {
                Session["RegistrationEvent"] = null;
                if (registrationEntry != null)
                {
                    registrationEntry.Event = model.Event;
                    PersonReader personReader = new PersonReader();
                    var person = personReader.GetById(registrationEntry.Person.PersonId).FirstOrDefault();

                    if (person != null)
                    {
                        //Check to see if a registration exists for this person already.

                        //Check for Registration slots being open (ie. Enough volunteers from that person's unit).
                        RegistrationValidator regValidator = new RegistrationValidator();
                        bool validRegistration = regValidator.DayCampRegistrationValid(person, registrationEntry.Event.EventId);
                        
                        //Register the person  or Redirect to waiting list.
                        if (validRegistration)
                        {
                            //Generate Confirmation Code
                            var confirmationCode = Utilities.GenerateConfirmationCode();
                            RegistrationDTO registration = new RegistrationDTO()
                            {
                                ConfirmationNumber = confirmationCode,
                                Event = model.Event,
                                Person = person,
                                RegistrationDate = DateTime.Now
                            };
                            RegistrationReader registrationReader = new RegistrationReader();
                            List<RegistrationDTO> registrations = new List<RegistrationDTO>();
                            registrations.Add(registration);
                            registrationReader.Save(registrations);

                            return View(registrationEntry);
                        }
                        ReservationDTO reservation = new ReservationDTO()
                        {
                            Event = model.Event,
                            Person = person,
                            ReservationDate = DateTime.Now
                        };
                        ReservationReader reservationReader = new ReservationReader();
                        List<ReservationDTO> reservations = new List<ReservationDTO>();
                        reservations.Add(reservation);
                        reservationReader.Save(reservations);

                        ReservationViewModel reservationViewModel = new ReservationViewModel
                        {
                            Person = person,
                            Event = model.Event,
                            ReservationDate = reservation.ReservationDate
                        };

                        TempData["ReservationViewModel"] = reservationViewModel;
                        return RedirectToAction("WaitingListConfirm");       
                    }
                }
            }
            return View();
        }

        public ActionResult VolunteerConfirm(VolunteerRegistrationViewModel model)
        {
            VolunteerRegistrationViewModel volunteerEntry = TempData["VolunteerRegistant"] as VolunteerRegistrationViewModel;
            model.Event = Session["RegistrationEvent"] as EventDTO;
            if (model.Event != null) //if (ModelState.IsValid)
            {
                Session["RegistrationEvent"] = null;
                if (volunteerEntry != null)
                {
                    PersonReader personReader = new PersonReader();
                    EventVolunteerReader eventVolunteerReader = new EventVolunteerReader();

                    var person = personReader.GetById(volunteerEntry.Person.PersonId).FirstOrDefault();

                    if (person != null)
                    {
                        //Need to check for existing registration.
                        List<EventVolunteerDTO> volunteerList = new List<EventVolunteerDTO>();

                        EventVolunteerDTO newVolunteer = new EventVolunteerDTO();
                        newVolunteer.Event = model.Event;
                        newVolunteer.Person = person;
                        newVolunteer.VolunteerDays = model.VolunteerDays;

                        volunteerList.Add(newVolunteer);
                        eventVolunteerReader.Save(volunteerList);

                        volunteerEntry.Person = person;
                        volunteerEntry.Event = newVolunteer.Event;

                        
                        return View(volunteerEntry);
                    }
                }
            }
            return View();  //Need to redirect to Error Page because Event was not selected.
        }

        public ActionResult WaitingListConfirm(ReservationViewModel model)
        {
            ReservationViewModel reservationViewModel = TempData["ReservationViewModel"] as ReservationViewModel;
            return View(reservationViewModel);
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