using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DayCampData;
using EventManagement.Models;

namespace EventManagement.Controllers
{
    public class RegistrationDashController : ApiController
    {
        // GET api/<controller>
        public IEnumerable<RegistrationDashboardViewModel> Get()
        {
            DayCampData.eventsEntities dbContext = new eventsEntities();

            var registrants = dbContext.dbvregistrationdetails.ToList();
            List<RegistrationDashboardViewModel> registrantsList = new List<RegistrationDashboardViewModel>();
            foreach (dbvregistrationdetail item in registrants)
            {
                registrantsList.Add(new RegistrationDashboardViewModel()
                {

                    EventId = item.Events_EventID,
                    Id = item.RegistrationID,
                    RegistrationDate = DateTime.Parse(item.RegistrationDate.ToString()),
                    Confirmation = item.Confirmation,
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
            return registrantsList;
        }

    }
}
