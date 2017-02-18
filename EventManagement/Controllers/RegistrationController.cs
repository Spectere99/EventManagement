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

        public ActionResult ExpireWaitingListCodes()
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

        public ActionResult ConvertReservation(int userId, string code)
        {
            ReservationListActions reservationListActions = new ReservationListActions();
            //Get the reservation and validate the code
            ReservationReader reservationReader = new ReservationReader();
            if (reservationListActions.ValidateReservationByCode(code))
            {
                ReservationDTO reservation = reservationReader.GetByRegistrationCode(code);
    
                //Build a registrationViewModel to send to RegistrantConfirm page

                RegistrationViewModel registrationViewModel = new RegistrationViewModel();
                registrationViewModel.Person = reservation.Person;
                registrationViewModel.Event = reservation.Event;
                registrationViewModel.ConfirmationNumber = code;
                TempData["EventRegistant"] = registrationViewModel;
                Session["RegistrationEvent"] = reservation.Event;

                reservationReader.Remove(new List<ReservationDTO>() {reservation});

                return RedirectToAction("RegistrantConfirm", "Registration");
            }

            return View("ConfirmationFailed");
        }
        public ActionResult RegistrantConfirm(RegistrationViewModel model)
        {
            RegistrationViewModel registrationEntry = null;
            registrationEntry = TempData["EventRegistant"] as RegistrationViewModel;
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

                        RegistrationValidator regValidator = new RegistrationValidator();
                        //Check to see if a registration exists for this person already.
                        bool existingRegistration = regValidator.CheckForExistingRegistration(person,registrationEntry.Event.EventId);

                        if (existingRegistration)
                        {
                            ReservationViewModel tempReservationModel = new ReservationViewModel
                            {
                                Person = person,
                                Event = model.Event,
                                ReservationDate = DateTime.Now
                            };

                            TempData["ReservationViewModel"] = tempReservationModel;
                            return RedirectToAction("ExistingRegistration");  
                        }
                        //Check for Registration slots being open (ie. Enough volunteers from that person's unit).
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

                            registrationEntry.ConfirmationNumber = registration.ConfirmationNumber;

                            SendRegistrationConfirmEmail(registrationEntry);

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
                        SendWaitingListConfirmEmail(reservationViewModel);
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
            if (ModelState.IsValid)
            {
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

                            volunteerEntry.Person = person;
                            volunteerEntry.Event = newVolunteer.Event;
                            volunteerEntry.VolunteerDays = model.VolunteerDays;
                            RegistrationValidator regValidator = new RegistrationValidator();
                            //Check to see if a registration exists for this person already.
                            bool existingRegistration = regValidator.CheckForExistingVolunteer(person,
                                volunteerEntry.Event.EventId);

                            if (existingRegistration)
                            {
                                ReservationViewModel tempReservationModel = new ReservationViewModel
                                {
                                    Person = person,
                                    Event = model.Event,
                                    ReservationDate = DateTime.Now
                                };

                                TempData["ReservationViewModel"] = tempReservationModel;
                                return RedirectToAction("ExistingRegistration");
                            }

                            eventVolunteerReader.Save(volunteerList);

                            SendVolunteerConfirmEmail(volunteerEntry);

                            //Need to check for Open Reservations for this person's unit and send notifications
                            ReservationListActions reservationListActions = new ReservationListActions();
                            List<ReservationDTO> openReservations = reservationListActions.GetReservationOpenings(
                                person, model.Event.EventId);

                            foreach (ReservationDTO reservation in openReservations)
                            {
                                SendReservationOpeningEmail(reservation);
                            }

                            return View(volunteerEntry);
                        }
                    }
                }
                TempData["ErrorMsg"] = "Please select an Event.";
                TempData["PersonId"] = volunteerEntry.Person.PersonId;
                return View();
            }
            TempData["ErrorMsg"] = "Please select a Valid number of Days.";
            TempData["PersonId"] = volunteerEntry.Person.PersonId;
            return View();  //Need to redirect to Error Page because Event was not selected.
        }

        public ActionResult WaitingListConfirm(ReservationViewModel model)
        {
            ReservationViewModel reservationViewModel = TempData["ReservationViewModel"] as ReservationViewModel;
            return View(reservationViewModel);
        }

        public ActionResult ExistingRegistration(ReservationViewModel model)
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

        private void SendReservationOpeningEmail(ReservationDTO user)
        {
            var callbackUrl = Url.Action("ConvertReservation", "Registration", new { userId = user.Person.PersonId, code = user.RegistrationCode }, protocol: Request.Url.Scheme);

            System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
            new System.Net.Mail.MailAddress("registration@proeventlistings.com", "York Day Camp"),
            new System.Net.Mail.MailAddress(user.Person.ParentPerson.ContactInfo.Email));
            m.Subject = "Registration Opening - Notification";
            m.Body = string.Format("Dear {0} <BR/>A spot for {1} has become available. Click on the below link to complete your registration: <a href=\"{2}\"title=\"User Email Confirm\">REGISTER</a><BR/><BR/>" +
                                   "This link expires in 48 hours.  After that time your spot will be given to another person."
                                , user.Person.ParentPerson.FirstName, user.Event.Name, callbackUrl);
            m.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("mail.proeventlistings.com");
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential("admin@proeventlistings.com", "Sp3ct3r399");

            smtp.EnableSsl = false;
            smtp.Send(m);
        }

        private void SendWaitingListConfirmEmail(ReservationViewModel user)
        {
            //var callbackUrl = Url.Action("ConvertReservation", "Registration", new { userId = user.Person.PersonId, code = user.RegistrationCode }, protocol: Request.Url.Scheme);

            System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
            new System.Net.Mail.MailAddress("registration@proeventlistings.com", "York Day Camp"),
            new System.Net.Mail.MailAddress(user.Person.ParentPerson.ContactInfo.Email));
            m.Subject = "Waiting List Confirmation";
            m.Body = string.Format("Dear {0} <BR/>You are currently on the waiting list for {1}.  <BR/>" +
                                   "As soon as enough volunteers from your Unit register, more slots will open up and you will be notified." +
                                   "At that time, you will be able to register in one click. <BR/>" +
                                   "Please note that waiting list slots are notifed based on the order that they signed up for the event."
                                   , user.Person.ParentPerson.FirstName + " " + user.Person.ParentPerson.LastName, user.Event.Name);
            m.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("mail.proeventlistings.com");
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential("admin@proeventlistings.com", "Sp3ct3r399");

            smtp.EnableSsl = false;
            smtp.Send(m);
        }
        private void SendRegistrationConfirmEmail(RegistrationViewModel user)
        {
            //var callbackUrl = Url.Action("ConvertReservation", "Registration", new { userId = user.Person.PersonId, code = user.RegistrationCode }, protocol: Request.Url.Scheme);

            System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
            new System.Net.Mail.MailAddress("registration@proeventlistings.com", "York Day Camp"),
            new System.Net.Mail.MailAddress(user.Person.ParentPerson.ContactInfo.Email));
            m.Subject = "Registration Confirmed";
            m.Body = string.Format("Dear {0} <BR/>Congratulations!  Your registration to {1} has been confirmed.  <BR/>" +
                                   "Your confirmation number is: {2}. <BR/> Please make sure you have paid through the council web site." +
                                   " Please use the following link to pay: <a href=\"{3}\"title=\"User Email Confirm\">PAY HERE</a><BR/><BR/>" +
                                   " Your registration will not final until you have paid your camp fees."
                                   , user.Person.ParentPerson.FirstName, user.Event.Name, user.ConfirmationNumber, "http://www.paypal.com");
            m.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("mail.proeventlistings.com");
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential("admin@proeventlistings.com", "Sp3ct3r399");

            smtp.EnableSsl = false;
            smtp.Send(m);
        }

        private void SendVolunteerConfirmEmail(VolunteerRegistrationViewModel user)
        {
            //var callbackUrl = Url.Action("ConvertReservation", "Registration", new { userId = user.Person.PersonId, code = user.RegistrationCode }, protocol: Request.Url.Scheme);

            System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
            new System.Net.Mail.MailAddress("registration@proeventlistings.com", "York Day Camp"),
            new System.Net.Mail.MailAddress(user.Person.ContactInfo.Email));
            m.Subject = "Registration Confirmed";
            m.Body = string.Format("Dear {0} <BR/>Thank you for volunteering at {1} this year.<BR/>" +
                                   "You have volunteered for {2} days! <BR/> Be prepared to enrich the lives of young cub scouts!<BR/>" +
                                   "You will be contacted by the Camp coordinator with details on special training, and other instructions. <BR/>" +
                                   "Once again Thank you!"
                                   , user.Person.FirstName, user.Event.Name, user.VolunteerDays);
            m.IsBodyHtml = true;
            System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient("mail.proeventlistings.com");
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new System.Net.NetworkCredential("admin@proeventlistings.com", "Sp3ct3r399");

            smtp.EnableSsl = false;
            smtp.Send(m);
        }
    }
}