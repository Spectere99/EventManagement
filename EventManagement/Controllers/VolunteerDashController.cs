using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DayCampData;
using EventManagement.Models;
using System.Text;
using Common.Reader;

namespace EventManagement.Controllers
{
    public class VolunteerDashController : ApiController
    {
        // GET api/dashboarddata
        public IEnumerable<VolunteersDashboardViewModel> Get()
        {
            DayCampData.eventsEntities dbContext = new eventsEntities();

            var volunteerList = dbContext.dbveventvolunteerdetails.ToList();
            List<VolunteersDashboardViewModel> volunteers = new List<VolunteersDashboardViewModel>();
            foreach (dbveventvolunteerdetail item in volunteerList)
            {
                volunteers.Add(new VolunteersDashboardViewModel()
                {
                    Id = item.ID,
                    Name = string.Format("{0} {1}", item.FirstName, item.LastName),
                    PersonType = item.PersonType,
                    DOB = item.BirthDate == null ? DateTime.Parse("1/1/1900") : DateTime.Parse(item.BirthDate.ToString()),
                    Address = string.Format("{0}", item.Address1),
                    City = item.City,
                    State = item.State,
                    Zip = item.Zip,
                    Email = item.Email,
                    Unit = item.UnitType + " " + item.UnitNumber,
                    VolunteerDays = item.volunteerDays,
                    HomePhone = item.HomePhone,
                    CellPhone = item.CellPhone,
                    MondayVol = item.MondayVol == "Y" ? true : false,
                    TuesdayVol = item.TuesdayVol == "Y" ? true : false,
                    WednesdayVol = item.WednesdayVol == "Y" ? true : false,
                    ThursdayVol = item.ThursdayVol == "Y" ? true : false,
                    FridayVol = item.FridayVol == "Y" ? true : false,
                    SaturdayVol = item.SaturdayVol == "Y" ? true : false,
                    SundayVol = item.SundayVol == "Y" ? true : false,
                    VolunteerDayDisplay = GetVolunteerDaysString(item)
                });

            }
            return volunteers;
        }

        public IEnumerable<VolunteersDashboardViewModel> Get(int id)
        {
            eventsEntities dbContext = new eventsEntities();
            UnitReader unitReader = new UnitReader();

            //Get the unit
            var unit = unitReader.GetById(id).FirstOrDefault();
            var volunteerList = dbContext.dbveventvolunteerdetails.Where(p=>p.UnitType == unit.UnitType.Type && p.UnitNumber == unit.UnitNumber).ToList();
            List<VolunteersDashboardViewModel> volunteers = new List<VolunteersDashboardViewModel>();
            foreach (dbveventvolunteerdetail item in volunteerList)
            {
                volunteers.Add(new VolunteersDashboardViewModel()
                {
                    Id = item.ID,
                    Name = string.Format("{0} {1}", item.FirstName, item.LastName),
                    DOB = item.BirthDate == null ? DateTime.Parse("1/1/1900") : DateTime.Parse(item.BirthDate.ToString()),
                    Address = string.Format("{0}", item.Address1),
                    City = item.City,
                    State = item.State,
                    Zip = item.Zip,
                    Email = item.Email,
                    Unit = item.UnitType + " " + item.UnitNumber,
                    VolunteerDays = item.volunteerDays,
                    HomePhone = item.HomePhone,
                    CellPhone = item.CellPhone,
                    MondayVol = item.MondayVol == "Y" ? true : false,
                    TuesdayVol = item.TuesdayVol == "Y" ? true : false,
                    WednesdayVol = item.WednesdayVol == "Y" ? true : false,
                    ThursdayVol = item.ThursdayVol == "Y" ? true : false,
                    FridayVol = item.FridayVol == "Y" ? true : false,
                    SaturdayVol = item.SaturdayVol == "Y" ? true : false,
                    SundayVol = item.SundayVol == "Y" ? true : false,
                    VolunteerDayDisplay = GetVolunteerDaysString(item)
                });

            }
            return volunteers;
        }
        private string GetVolunteerDaysString(dbveventvolunteerdetail volunteer)
        {
            StringBuilder sb = new StringBuilder();

            if (volunteer.MondayVol == "Y") { sb.Append("Mon,"); }
            if (volunteer.TuesdayVol == "Y") { sb.Append("Tues,"); }
            if (volunteer.WednesdayVol == "Y") { sb.Append("Wed,"); }
            if (volunteer.ThursdayVol == "Y") { sb.Append("Thurs,"); }
            if (volunteer.FridayVol == "Y") { sb.Append("Fri,"); }
            if (volunteer.SaturdayVol == "Y") { sb.Append("Sat,"); }
            if (volunteer.SundayVol == "Y") { sb.Append("Sun,"); }

            return sb.ToString().TrimEnd(',');

        }
    }
}
