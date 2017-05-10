using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Diagnostics.Eventing.Reader;
using System.IO;
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
    public class RegistrationController : ApplicationBaseController
    {
        private string _SmtpServer;
        private string _SmtpAuthAccount;
        private string _SmtpAuthPassword = "";
        private string _outputEmail;
        private string[] _ccEmails;

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
            else
            {
                HandleErrorInfo handleErrorInfo = new HandleErrorInfo(new Exception(string.Format("Person record was not found for login account <{0}>", User.Identity.Name)), "Registration", "AttendeeSelection");
                return View("Error", handleErrorInfo);
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
            EventReader eventReader = new EventReader();
            
            if (reservationListActions.ValidateReservationByCode(code))
            {
                ReservationDTO reservation = reservationReader.GetByRegistrationCode(code);
                var eventVal = eventReader.GetById(reservation.Event.EventId);
                //Build a registrationViewModel to send to RegistrantConfirm page

                RegistrationViewModel registrationViewModel = new RegistrationViewModel();
                registrationViewModel.Person = reservation.Person;
                registrationViewModel.EventView = TranslateEventDTO(reservation.Event);
                registrationViewModel.Event = registrationViewModel.EventView.EventId.ToString();
                registrationViewModel.ConfirmationNumber = code;
                TempData["EventRegistant"] = registrationViewModel;
                //Need to change this to something other than Session Value
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
            //model.Event = Session["RegistrationEvent"] as EventDTO;    
            if (model.Event == null && registrationEntry != null)
            {
                model.Event = registrationEntry.Event;
            }
            if (model.Event != null)
            {
                
                if (registrationEntry != null)
                {
                    registrationEntry.Event = model.Event;
                    PersonReader personReader = new PersonReader();
                    EventReader eventReader = new EventReader();
                    var person = personReader.GetById(registrationEntry.Person.PersonId).FirstOrDefault();
                    var eventDto = eventReader.GetById(int.Parse(model.Event));
                    
                    model.EventView = TranslateEventDTO(eventDto.SingleOrDefault());
                    if (model.EventView.RegistrationDeadline < DateTime.Now)
                    {


                        registrationEntry.EventView = TranslateEventDTO(eventDto.SingleOrDefault());

                        if (person != null)
                        {

                            RegistrationValidator regValidator = new RegistrationValidator();
                            //Check to see if a registration exists for this person already.
                            bool existingRegistration = regValidator.CheckForExistingRegistration(person,
                                registrationEntry.EventView.EventId);

                            if (existingRegistration)
                            {
                                ReservationViewModel tempReservationModel = new ReservationViewModel
                                {
                                    Person = person,
                                    Event = TranslateEventDTO(eventDto.SingleOrDefault()),
                                    ReservationDate = DateTime.Now
                                };

                                TempData["ReservationViewModel"] = tempReservationModel;
                                return RedirectToAction("ExistingRegistration");
                            }
                            //Check for Registration slots being open (ie. Enough volunteers from that person's unit).
                            bool validRegistration = regValidator.DayCampRegistrationValid(person,
                                registrationEntry.EventView.EventId);

                            //Register the person  or Redirect to waiting list.
                            if (validRegistration)
                            {
                                //Generate Confirmation Code
                                var confirmationCode = Utilities.GenerateConfirmationCode();
                                RegistrationDTO registration = new RegistrationDTO()
                                {
                                    ConfirmationNumber = confirmationCode,
                                    Event = eventDto.SingleOrDefault(),
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
                            bool existingReservation = regValidator.CheckForExistingReservation(person,
                                registrationEntry.EventView.EventId);
                            if (existingReservation)
                            {
                                ReservationViewModel tempReservationModel = new ReservationViewModel
                                {
                                    Person = person,
                                    Event = TranslateEventDTO(eventDto.SingleOrDefault()),
                                    ReservationDate = DateTime.Now
                                };

                                TempData["ReservationViewModel"] = tempReservationModel;
                                return RedirectToAction("ExistingRegistration");
                            }
                            ReservationDTO reservation = new ReservationDTO()
                            {
                                Event = eventDto.SingleOrDefault(),
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
                                Event = model.EventView,
                                ReservationDate = reservation.ReservationDate
                            };

                            TempData["ReservationViewModel"] = reservationViewModel;
                            SendWaitingListConfirmEmail(reservationViewModel);
                            return RedirectToAction("WaitingListConfirm");
                        }
                    }
                    else
                    {
                        TempData["ErrorMsg"] = "Registration has Closed.";
                        TempData["PersonId"] = registrationEntry.Person.PersonId;
                        return View();
                    }
                }
            }
            TempData["ErrorMsg"] = "Please select a Valid number of Days.";
            TempData["PersonId"] = registrationEntry.Person.PersonId;
            return View();
        }
        public ActionResult VolunteerConfirm(VolunteerRegistrationViewModel model)
        {
            VolunteerRegistrationViewModel volunteerEntry = TempData["VolunteerRegistant"] as VolunteerRegistrationViewModel;
            //model.Event = Session["RegistrationEvent"] as EventDTO;

            model.VolunteerDays = CountVolunteerDays(model);

            if (model.VolunteerDays > 0 && model.VolunteerDays <= 5)
            {
                if (model.Event != null) //if (ModelState.IsValid)
                {
                    Session["RegistrationEvent"] = null;
                    if (volunteerEntry != null)
                    {
                        PersonReader personReader = new PersonReader();
                        EventReader eventReader = new EventReader();
                        EventVolunteerReader eventVolunteerReader = new EventVolunteerReader();

                        var eventDTO = eventReader.GetById(int.Parse(model.Event));
                        var person = personReader.GetById(volunteerEntry.Person.PersonId).FirstOrDefault();

                        if (person != null)
                        {
                            //Need to check for existing registration.
                            List<EventVolunteerDTO> volunteerList = new List<EventVolunteerDTO>();

                            EventVolunteerDTO newVolunteer = new EventVolunteerDTO();
                            newVolunteer.Event = eventDTO.SingleOrDefault();
                            newVolunteer.Person = person;
                            newVolunteer.Monday = model.MondayVolunteer;
                            newVolunteer.Tuesday = model.TuesdayVolunteer;
                            newVolunteer.Wednesday = model.WednesdayVolunteer;
                            newVolunteer.Thursday = model.ThursdayVolunteer;
                            newVolunteer.Friday = model.FridayVolunteer;
                            newVolunteer.Saturday = model.SaturdayVolunteer;
                            newVolunteer.Sunday = model.SundayVolunteer;
                            newVolunteer.VolunteerDays = model.VolunteerDays;

                            volunteerList.Add(newVolunteer);

                            volunteerEntry.Person = person;
                            volunteerEntry.Event = model.Event;
                            volunteerEntry.EventView = TranslateEventDTO(newVolunteer.Event);
                            volunteerEntry.VolunteerDays = model.VolunteerDays;
                            
                            RegistrationValidator regValidator = new RegistrationValidator();
                            //Check to see if a registration exists for this person already.
                            bool existingRegistration = regValidator.CheckForExistingVolunteer(person,
                                int.Parse(volunteerEntry.Event));

                            if (existingRegistration)
                            {
                                ReservationViewModel tempReservationModel = new ReservationViewModel
                                {
                                    Person = person,
                                    Event = volunteerEntry.EventView,
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
                                person, int.Parse(model.Event));

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

        private EventDTO TranslateEventViewModel(EventViewModel eventViewModel)
        {
            EventDTO eventDTO = new EventDTO
            {
                Name = eventViewModel.EventName,
                Description = eventViewModel.Description,
                End = eventViewModel.EventEnd,
                Start = eventViewModel.EventStart,
                EventId = eventViewModel.EventId,
                EventType = new EventTypeDTO
                {
                    EventTypeId = eventViewModel.EventType.EventTypeId,
                    IsNew = false,
                    Type = eventViewModel.EventType.EventType
                },
                LastUpdated = eventViewModel.LastUpdated,
                RegistrationDeadline = eventViewModel.RegistrationDeadline,
                RequiredStaffCount = eventViewModel.RequiredStaff,
                RequiredVolunteersCount = eventViewModel.RequiredVolunteers,
                StaffPaymentRequired = eventViewModel.StaffPaymentRequired,
                Venue = new VenueDTO
                {
                    Contact = eventViewModel.Venue.Contact,
                    ContactInfo = null,
                    Name = eventViewModel.Venue.Name,
                    VenueId = eventViewModel.Venue.VenueId
                }
            };

            return eventDTO;
        }

        private EventViewModel TranslateEventDTO(EventDTO eventDTO)
        {
            EventViewModel eventViewModel = new EventViewModel
            {
                Description = eventDTO.Description,
                EventEnd = eventDTO.End,
                EventId = eventDTO.EventId,
                EventName = eventDTO.Name,
                EventStart = eventDTO.Start,
                EventType = new EventTypeModel
                {
                    EventType = eventDTO.EventType.Type,
                    EventTypeId = eventDTO.EventType.EventTypeId
                },
                LastUpdated = eventDTO.LastUpdated,
                RegistrationDeadline = eventDTO.RegistrationDeadline,
                RequiredStaff = eventDTO.RequiredStaffCount,
                RequiredVolunteers = eventDTO.RequiredVolunteersCount,
                StaffPaymentRequired = eventDTO.StaffPaymentRequired,
                Venue = new VenueModel
                {
                    Contact = eventDTO.Venue.Contact,
                    Name = eventDTO.Venue.Name,
                    VenueId = eventDTO.Venue.VenueId
                }
            };
            
            return eventViewModel;
            
        }
        private int CountVolunteerDays(VolunteerRegistrationViewModel volunteer)
        {
            int dayCount = 0;

            dayCount = dayCount + ((volunteer.MondayVolunteer) ? 1 : 0);
            dayCount = dayCount + ((volunteer.TuesdayVolunteer) ? 1 : 0);
            dayCount = dayCount + ((volunteer.WednesdayVolunteer) ? 1 : 0);
            dayCount = dayCount + ((volunteer.ThursdayVolunteer) ? 1 : 0); 
            dayCount = dayCount + ((volunteer.FridayVolunteer) ? 1 : 0);
            dayCount = dayCount + ((volunteer.SaturdayVolunteer) ? 1 : 0); 
            dayCount = dayCount + ((volunteer.SundayVolunteer) ? 1 : 0);

            return dayCount;
        }
        private void SendReservationOpeningEmail(ReservationDTO user)
        {
            try
            {
                SetEmailSettings();
                var callbackUrl = Url.Action("ConvertReservation", "Registration",
                    new {userId = user.Person.PersonId, code = user.RegistrationCode}, protocol: Request.Url.Scheme);

                System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
                    new System.Net.Mail.MailAddress(_outputEmail, "York Day Camp"),
                    new System.Net.Mail.MailAddress(user.Person.ParentPerson.ContactInfo.Email));
                m.Subject = "Registration Opening - Notification";
                m.Body =
                    string.Format(
                        "Dear {0} <BR/>A spot for your unit has become available to register for {1}. Click on the following link to complete your scout's registration: <a href=\"{2}\"title=\"Register\">REGISTER</a><BR/><BR/>" +
                        "This link expires in 48 hours.  After that time your scout's spot will be given to another person and your scout will be moved to the bottom of the waiting list. <BR/><BR/>" +
                        "Thank you for your understanding in this matter while we strive to make Day Camp a safe and memorable experience for all scouts.<BR/><BR/>" +
                        " -York District Day Scout Day Camp Team"
                        , user.Person.ParentPerson.FirstName, user.Event.Name, callbackUrl);
                m.IsBodyHtml = true;
                System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(_SmtpServer);
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new System.Net.NetworkCredential(_SmtpAuthAccount, _SmtpAuthPassword);

                smtp.EnableSsl = false;
                smtp.Send(m);
            }
            catch (Exception ex)
            {
                var st = new StackTrace(ex, true);
                StackFrame frame = st.GetFrame(0);

                //Get the file name
                string fileName = frame.GetFileName();

                //Get the method name
                string methodName = frame.GetMethod().Name;

                //Get the line number from the stack frame
                int line = frame.GetFileLineNumber();

                //Get the column number
                int col = frame.GetFileColumnNumber();

                TextWriter tr = new StreamWriter(System.Web.HttpContext.Current.Server.MapPath("../logs/errors.log"), true);
                tr.WriteLine("Date Time: {0}", DateTime.Now);
                tr.WriteLine("File: {0}", fileName);
                tr.WriteLine("Method: {0}", methodName);
                tr.WriteLine("Line Number: {0} - Col: {1}", line, col);
                tr.WriteLine(ex.Message);
                tr.Flush();
                tr.Close();
                //HandleErrorInfo handleErrorInfo = new HandleErrorInfo(new Exception(string.Format("Error when loading Organization: Line {0} : {1}", line, ex.Message)), "Organization", "Index");

                //return View("Error", handleErrorInfo);
            }
        }

        private void SendWaitingListConfirmEmail(ReservationViewModel user)
        {
            try
            {
                //var callbackUrl = Url.Action("ConvertReservation", "Registration", new { userId = user.Person.PersonId, code = user.RegistrationCode }, protocol: Request.Url.Scheme);
                SetEmailSettings();
                System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
                new System.Net.Mail.MailAddress(_outputEmail, "York Day Camp"),
                new System.Net.Mail.MailAddress(user.Person.ParentPerson.ContactInfo.Email));
                foreach (string email in _ccEmails)
                {
                    m.To.Add(email);
                }
                //m.To.Add("yorkdaycamp@gmail.com");
                ////m.To.Add("taylor.thomas@scouting.org");
                //m.To.Add("morgan.hawkins@scouting.org");
                m.Subject = "Waiting List Confirmation";
                m.Body = string.Format("Dear {0} <BR/>Your scout is currently on the waiting list for {1}.  <BR/>" +
                                       "As soon as enough volunteers from your Unit register, more slots will open up and you will be notified." +
                                       "At that time, you will be able to register in one click. <BR/>" +
                                       "Please note that waiting list slots are notifed based on the order that they signed up for the event.<BR/><BR/>" +
                                       "Thank you for your understanding in this matter while we strive to make Day Camp a safe and memorable experience for all scouts.<BR/><BR/>" +
                                       " -York District Day Scout Day Camp Team" +
                                        "<HR/> DETAILS: <BR/>" +
                                       "   <strong>Scout Name:</strong> {2} {3} {4}<BR/>" +
                                       "   <strong>Unit:</strong> {5} {6} <BR/>" +
                                       "   <strong>Rank:</strong> {7} <BR/>" +
                                       "   <strong>Address:</strong> {8}<BR/>" +
                                       "            {9}, {10} {11}<BR/>" +
                                       "   <strong>Home Phone:</strong> {12} <BR/>" +
                                       "   <strong>Cell Phone:</strong> {13} "
                                       , user.Person.ParentPerson.FirstName + " " + user.Person.ParentPerson.LastName, user.Event.EventName
                                       , user.Person.FirstName, user.Person.MiddleName, user.Person.LastName
                                       , user.Person.Unit.UnitType.Type, user.Person.Unit.UnitNumber
                                       , user.Person.Rank.Rank
                                       , user.Person.ParentPerson.ContactInfo.Address1
                                       , user.Person.ParentPerson.ContactInfo.City, user.Person.ParentPerson.ContactInfo.State, user.Person.ParentPerson.ContactInfo.Zip
                                       , user.Person.ParentPerson.ContactInfo.HomePhone
                                       , user.Person.ParentPerson.ContactInfo.CellPhone);
                m.IsBodyHtml = true;
                System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(_SmtpServer);
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new System.Net.NetworkCredential(_SmtpAuthAccount, _SmtpAuthPassword);

                smtp.EnableSsl = false;
                smtp.Send(m);
            }
            catch (Exception ex)
            {
                var st = new StackTrace(ex, true);
                StackFrame frame = st.GetFrame(0);

                //Get the file name
                string fileName = frame.GetFileName();

                //Get the method name
                string methodName = frame.GetMethod().Name;

                //Get the line number from the stack frame
                int line = frame.GetFileLineNumber();

                //Get the column number
                int col = frame.GetFileColumnNumber();

                TextWriter tr = new StreamWriter(System.Web.HttpContext.Current.Server.MapPath("../logs/errors.log"), true);
                tr.WriteLine("Date Time: {0}", DateTime.Now);
                tr.WriteLine("File: {0}", fileName);
                tr.WriteLine("Method: {0}", methodName);
                tr.WriteLine("Line Number: {0} - Col: {1}", line, col);
                tr.WriteLine(ex.Message);
                tr.Flush();
                tr.Close();
                //HandleErrorInfo handleErrorInfo = new HandleErrorInfo(new Exception(string.Format("Error when loading Organization: Line {0} : {1}", line, ex.Message)), "Organization", "Index");

                //return View("Error", handleErrorInfo);
            }
        }
        private void SendRegistrationConfirmEmail(RegistrationViewModel user)
        {
            try
            {

                //var callbackUrl = Url.Action("ConvertReservation", "Registration", new { userId = user.Person.PersonId, code = user.RegistrationCode }, protocol: Request.Url.Scheme);
                SetEmailSettings();
                System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
                    new System.Net.Mail.MailAddress(_outputEmail, "York Day Camp"),
                    new System.Net.Mail.MailAddress(user.Person.ParentPerson.ContactInfo.Email));
                foreach (string email in _ccEmails)
                {
                    m.To.Add(email);
                }
                //m.To.Add("yorkdaycamp@gmail.com");
                ////m.To.Add("taylor.thomas@scouting.org");
                //m.To.Add("morgan.hawkins@scouting.org");
                m.Subject = "Registration Confirmed";
                m.Body =
                    string.Format(
                        "Dear {0}, <BR/>Congratulations!  Your scout's registration to {1} has been confirmed.  <BR/>" +
                        "Your confirmation number is: {2}. <BR/> Please make sure you have paid through the council web site using the following link:<BR/>" +
                        "  <a href=\"{3}\"title=\"User Email Confirm\">PAY HERE</a><BR/><BR/>" +
                        " Your registration will not final until you have paid your camp fees. <BR/><BR/>" +
                        " On June 11th we will be conducting swim tests and check in (Time TBD). At check in you will need to turn in your scout’s BSA <a href=\"{4}\"title=\"BSA Health Form\">Health forms</a>, pick up t-shirts, meet the Den Leaders and take the BSA swim test. <BR/><BR/>" +
                        " We look forward to having a fun filled week with your scout, <BR/><BR/>" +
                        " -York District Day Scout Day Camp Team <BR/><BR/>" +
                        "<HR/> DETAILS: <BR/>" +
                        "   <strong>Scout Name:</strong> {5} {6} {7}<BR/>" +
                        "   <strong>Unit:</strong> {8} {9} <BR/>" +
                        "   <strong>Rank:</strong> {10} <BR/>" +
                        "   <strong>Confirmation Number:</strong> {2}<BR/>" +
                        "   <strong>Address:</strong> {11}<BR/>" +
                        "            {12}, {13} {14}<BR/>" +
                        "   <strong>Home Phone:</strong> {15} <BR/>" +
                        "   <strong>Cell Phone:</strong> {16} "
                        , user.Person.ParentPerson.FirstName, user.EventView.EventName, user.ConfirmationNumber,
                        "http://palmettocouncil.org/special-events/2015-cub-day-camp"
                        , "http://www.scouting.org/filestore/healthsafety/pdf/680-001_ab.pdf"
                        , user.Person.FirstName, user.Person.MiddleName, user.Person.LastName
                        , user.Person.Unit.UnitType.Type, user.Person.Unit.UnitNumber
                        , user.Person.Rank.Rank
                        , user.Person.ParentPerson.ContactInfo.Address1
                        , user.Person.ParentPerson.ContactInfo.City, user.Person.ParentPerson.ContactInfo.State,
                        user.Person.ParentPerson.ContactInfo.Zip
                        , user.Person.ParentPerson.ContactInfo.HomePhone
                        , user.Person.ParentPerson.ContactInfo.CellPhone);
                m.IsBodyHtml = true;
                System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(_SmtpServer);
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new System.Net.NetworkCredential(_SmtpAuthAccount, _SmtpAuthPassword);

                smtp.EnableSsl = false;
                smtp.Send(m);
            }
            catch (Exception ex)
            {
                var st = new StackTrace(ex, true);
                StackFrame frame = st.GetFrame(0);

                //Get the file name
                string fileName = frame.GetFileName();

                //Get the method name
                string methodName = frame.GetMethod().Name;

                //Get the line number from the stack frame
                int line = frame.GetFileLineNumber();

                //Get the column number
                int col = frame.GetFileColumnNumber();

                TextWriter tr = new StreamWriter(System.Web.HttpContext.Current.Server.MapPath("../logs/errors.log"), true);
                tr.WriteLine("Date Time: {0}", DateTime.Now);
                tr.WriteLine("File: {0}", fileName);
                tr.WriteLine("Method: {0}", methodName);
                tr.WriteLine("Line Number: {0} - Col: {1}", line, col);
                tr.WriteLine(ex.Message);
                tr.Flush();
                tr.Close();
                //HandleErrorInfo handleErrorInfo = new HandleErrorInfo(new Exception(string.Format("Error when loading Organization: Line {0} : {1}", line, ex.Message)), "Organization", "Index");

                //return View("Error", handleErrorInfo);
            }
        }

        private void SendVolunteerConfirmEmail(VolunteerRegistrationViewModel user)
        {
            try
            {

                //var callbackUrl = Url.Action("ConvertReservation", "Registration", new { userId = user.Person.PersonId, code = user.RegistrationCode }, protocol: Request.Url.Scheme);
                SetEmailSettings();
                System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(
                    new System.Net.Mail.MailAddress(_outputEmail, "York Day Camp"),
                    new System.Net.Mail.MailAddress(user.Person.ContactInfo.Email));
                foreach (string email in _ccEmails)
                {
                    m.To.Add(email);
                }
                //m.To.Add("yorkdaycamp@gmail.com");
                ////m.To.Add("taylor.thomas@scouting.org");
                //m.To.Add("morgan.hawkins@scouting.org");
                m.Subject = "Registration Confirmed";
                m.Body = string.Format("Dear {0} <BR/>Thank you for volunteering at {1} this year.<BR/>" +
                                       "You have volunteered for {2} days! <BR/> " +
                                       "You will be contacted by the Camp coordinator with details on special training, and other instructions. <BR/>" +
                                       " Please use the following link to select your t-shirt sizes and quantities: <a href=\"{3}\"title=\"Select T-Shirt Sizes\">CLICK HERE</a><BR/><BR/>" +
                                       "To prepare for camp there will be a mandatory training on May 20th 2017 from 8:00 am – 12:00 pm for all volunteers. Location TBD. <BR/<BR/>" +
                                       "In addition to the training on the May 20th, you will need to log into <a href=\"{4}\"title=\"MyScouting.org\">my.scouting.org</a> and complete the following trainings online:<BR/>" +
                                       "Online Mandatory Training: <BR/>" +
                                       "Youth Protection <BR/>" +
                                       "Weather Hazards <BR/>" +
                                       "Safe Swim Defense <BR/><BR/>" +
                                       "To locate these trainings, go to Menu (upper left screen), My Dashboard, Training Center, and Other. Youth Protection training is under the YPT link instead of Training Center.<BR/><BR/>" +
                                       "Once you have completed the online training, print out the certificate of completion and bring them to the May 20th training. Be aware we will not be doing any of the online training on May 20th. <BR/><BR/>" +
                                       "As a volunteer, you will also need to have an updated Health form. <a href=\"{5}\"title=\"MyScouting.org\">Click Here</a><BR/><BR/>" +
                                       "Be prepared to enrich the lives of young cub scouts!<BR/>" +
                                       "Once again, Thank you for your support! <BR/><BR/>" +
                                       "-York District Day Scout Day Camp Team<BR/><BR/>" +
                                       "<HR/> DETAILS: <BR/>" +
                                       "   <strong>Volunteer Name:</strong> {6} {7} {8}<BR/>" +
                                       "   <strong>Unit:</strong> {9} {10} <BR/>" +
                                       "   <strong>Address:</strong> {11}<BR/>" +
                                       "           {12}, {13} {14}<BR/>" +
                                       "   <strong>Home Phone:</strong> {15} <BR/>" +
                                       "   <strong>Cell Phone:</strong> {16} "
                    , user.Person.FirstName, user.EventView.EventName, user.VolunteerDays
                    , "http://palmettocouncil.org/special-events/2017-day-camp-shirts"
                    , "https://my.scouting.org/"
                    , "http://www.scouting.org/filestore/healthsafety/pdf/680-001_ab.pdf"
                    , user.Person.FirstName, user.Person.MiddleName, user.Person.LastName
                    , user.Person.Unit.UnitType.Type, user.Person.Unit.UnitNumber
                    , user.Person.ContactInfo.Address1
                    , user.Person.ContactInfo.City, user.Person.ContactInfo.State, user.Person.ContactInfo.Zip
                    , user.Person.ContactInfo.HomePhone
                    , user.Person.ContactInfo.CellPhone);
                m.IsBodyHtml = true;
                System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient(_SmtpServer);
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new System.Net.NetworkCredential(_SmtpAuthAccount, _SmtpAuthPassword);

                smtp.EnableSsl = false;
                smtp.Send(m);
            }
            catch (Exception ex)
            {
                var st = new StackTrace(ex, true);
                StackFrame frame = st.GetFrame(0);

                //Get the file name
                string fileName = frame.GetFileName();

                //Get the method name
                string methodName = frame.GetMethod().Name;

                //Get the line number from the stack frame
                int line = frame.GetFileLineNumber();

                //Get the column number
                int col = frame.GetFileColumnNumber();

                TextWriter tr = new StreamWriter(System.Web.HttpContext.Current.Server.MapPath("../logs/errors.log"), true);
                tr.WriteLine("Date Time: {0}", DateTime.Now);
                tr.WriteLine("File: {0}", fileName);
                tr.WriteLine("Method: {0}", methodName);
                tr.WriteLine("Line Number: {0} - Col: {1}", line, col);
                tr.WriteLine(ex.Message);
                tr.Flush();
                tr.Close();
                //HandleErrorInfo handleErrorInfo = new HandleErrorInfo(new Exception(string.Format("Error when loading Organization: Line {0} : {1}", line, ex.Message)), "Organization", "Index");

                //return View("Error", handleErrorInfo);
            }
        }
        
        private void SetEmailSettings()
        {
            _SmtpServer = ConfigurationManager.AppSettings["SmtpServer"];
            _SmtpAuthAccount = ConfigurationManager.AppSettings["SmtpAuthAccount"];
            _SmtpAuthPassword = "clKi088@";
            _outputEmail = ConfigurationManager.AppSettings["OutboundEmail"];
            _ccEmails = ConfigurationManager.AppSettings["CCEmails"].Split(';');
        }
    }

    
}