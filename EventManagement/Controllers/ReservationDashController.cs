using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Common;
using Common.Reader;
using DayCampData;
using EventManagement.Models;

namespace EventManagement.Controllers
{
    public class ReservationDashController : ApiController
    {
        private string _SmtpServer;
        private string _SmtpAuthAccount;
        private string _SmtpAuthPassword = "";
        private string _outputEmail;
        private string[] _ccEmails;

        // GET api/<controller>
        public IEnumerable<ReservationDashboardViewModel> Get()
        {
            DayCampData.eventsEntities dbContext = new eventsEntities();

            var reservations = dbContext.dbvreservationdetails.ToList();
            List<ReservationDashboardViewModel> reseverationList = new List<ReservationDashboardViewModel>();
            foreach (dbvreservationdetail item in reservations)
            {
                reseverationList.Add(new ReservationDashboardViewModel()
                {

                    EventId = item.Events_EventID,
                    Id = item.ReservationID,
                    ReservationDate = DateTime.Parse(item.ReservationDate.ToString()),
                    RegistrationCode = item.RegistrationCode,
                    Name = string.Format("{0} {1}", item.FirstName, item.LastName),
                    DOB = DateTime.Parse(item.BirthDate.ToString()),
                    Address = string.Format("{0}", item.Address1),
                    City = item.City,
                    State = item.State,
                    Zip = item.Zip,
                    Email = item.Email,
                    HomePhone = item.HomePhone,
                    CellPhone = item.CellPhone,
                    Rank = item.UnitRank,
                    Unit = item.UnitType + " " + item.UnitNumber,
                    Notes = item.Notes,
                    ParentName = item.ParentName,
                });

            }
            return reseverationList;
        }

        public IEnumerable<ReservationDashboardViewModel> Get(int id)
        {
            eventsEntities dbContext = new eventsEntities();
            UnitReader unitReader = new UnitReader();

            //Get the unit
            var unit = unitReader.GetById(id).FirstOrDefault();
            var reservations =
                dbContext.dbvreservationdetails.Where(
                    p => p.UnitType == unit.UnitType.Type && p.UnitNumber == unit.UnitNumber).ToList();
            List<ReservationDashboardViewModel> reseverationList = new List<ReservationDashboardViewModel>();
            foreach (dbvreservationdetail item in reservations)
            {
                reseverationList.Add(new ReservationDashboardViewModel()
                {

                    EventId = item.Events_EventID,
                    Id = item.ReservationID,
                    ReservationDate = DateTime.Parse(item.ReservationDate.ToString()),
                    RegistrationCode = item.RegistrationCode,
                    Name = string.Format("{0} {1}", item.FirstName, item.LastName),
                    DOB = DateTime.Parse(item.BirthDate.ToString()),
                    Address = string.Format("{0}", item.Address1),
                    City = item.City,
                    State = item.State,
                    Zip = item.Zip,
                    Email = item.Email,
                    HomePhone = item.HomePhone,
                    CellPhone = item.CellPhone,
                    Rank = item.UnitRank,
                    Unit = item.UnitType + " " + item.UnitNumber,
                    Notes = item.Notes,
                    ParentName = item.ParentName,
                });

            }
            return reseverationList;
        }

        public HttpResponseMessage Put(int id)
        {
            string responseText = string.Empty;
            //Get the reservation and validate the code
            ReservationReader reservationReader = new ReservationReader();
            EventReader eventReader = new EventReader();

            ReservationDTO reservation = reservationReader.GetById(id).SingleOrDefault();
            if (reservation != null)
            {
                var eventVal = eventReader.GetById(reservation.Event.EventId);
                //Build a registrationViewModel to send to RegistrantConfirm page

                RegistrationViewModel registrationViewModel = new RegistrationViewModel();
                registrationViewModel.Person = reservation.Person;
                registrationViewModel.EventView = TranslateEventDTO(reservation.Event);
                registrationViewModel.Event = registrationViewModel.EventView.EventId.ToString();
                registrationViewModel.ConfirmationNumber = "ADMIN";

                reservationReader.Remove(new List<ReservationDTO>() {reservation});

                PersonReader personReader = new PersonReader();
                
                var person = personReader.GetById(reservation.Person.PersonId).FirstOrDefault();
                //var eventDto = eventReader.GetById(int.Parse(model.Event));
                //EventViewModel eventViewModel = TranslateEventDTO(eventDto.SingleOrDefault());

                if (person != null)
                {

                    RegistrationValidator regValidator = new RegistrationValidator();

                    //Check to see if a registration exists for this person already.
                    bool existingRegistration = regValidator.CheckForExistingRegistration(person,
                        registrationViewModel.EventView.EventId);

                    if (!existingRegistration)
                    {

                        //Check for Registration slots being open (ie. Enough volunteers from that person's unit).

                        //Generate Confirmation Code
                        var confirmationCode = Utilities.GenerateConfirmationCode();
                        RegistrationDTO registration = new RegistrationDTO()
                        {
                            ConfirmationNumber = confirmationCode,
                            Event = reservation.Event,
                            Person = person,
                            RegistrationDate = DateTime.Now
                        };
                        RegistrationReader registrationReader = new RegistrationReader();
                        List<RegistrationDTO> registrations = new List<RegistrationDTO>();
                        registrations.Add(registration);
                        registrationReader.Save(registrations);

                        RegistrationViewModel registrationEntry = new RegistrationViewModel
                        {
                            ConfirmationNumber = registration.ConfirmationNumber,
                            Event = registration.Event.Name,
                            EventList = null,
                            EventView = null,
                            Person = registration.Person
                        };
                        
                        registrationEntry.ConfirmationNumber = registration.ConfirmationNumber;

                        SendRegistrationConfirmEmail(registrationEntry);

                        HttpResponseMessage goodResponse = Request.CreateResponse(HttpStatusCode.OK,
                            "Reservation Converted to Registration");
                        return goodResponse;
                    }
                    else
                    {
                        responseText = "Registration Found.";
                    }
                }
            }

            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.BadRequest, responseText);
            return response;
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
                        " On May 11th we will be conducting swim tests and check in (Time TBD). At check in you will need to turn in your scout’s BSA <a href=\"{4}\"title=\"BSA Health Form\">Health forms</a>, pick up t-shirts, meet the Den Leaders and take the BSA swim test. <BR/><BR/>" +
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
