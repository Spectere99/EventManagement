using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Common.Reader;
using DayCampData;
using EventManagement.Models;

namespace EventManagement.Controllers
{
    public class ReservationDashController : ApiController
    {
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
            var reservations = dbContext.dbvreservationdetails.Where(p => p.UnitType == unit.UnitType.Type && p.UnitNumber == unit.UnitNumber).ToList();
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
    }
}
