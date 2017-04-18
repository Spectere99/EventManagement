using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventManagement.Models
{
        public class EventDashboardCounts
        {
            public int EventId { get; set; }
            public string EventName { get; set; }
            public int UnitId { get; set; }
            public int VolunteerCount { get; set; }
            public int ReservationCount { get; set; }
            public int RegistrationCount { get; set; }
        }
        public class EventDashboardCountsPivotModel
        {
            public int EventId { get; set; }
            public string EventName { get; set; }
            public string RegType { get; set; }
            public int Val { get; set; }
        }
        public class VolunteersDashboardViewModel
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public DateTime DOB { get; set; }
            public string Unit { get; set; }
            public string Email { get; set; }
            public string HomePhone { get; set; }
            public string CellPhone { get; set; }
            public string Address { get; set; }
            public string City { get; set; }
            public string State { get; set; }
            public string Zip { get; set; }
            public int VolunteerDays { get; set; }
            public bool MondayVol { get; set; }
            public bool TuesdayVol { get; set; }
            public bool WednesdayVol { get; set; }
            public bool ThursdayVol { get; set; }
            public bool FridayVol { get; set; }
            public bool SaturdayVol { get; set; }
            public bool SundayVol { get; set; }
            public string VolunteerDayDisplay { get; set; }
        }

        public class RegistrationDashboardViewModel
        {
            public int Id { get; set; }
            public DateTime RegistrationDate { get; set; }
            public string Confirmation { get; set; }
            public int EventId { get; set; }
            public string Name { get; set; }
            public DateTime DOB { get; set; }
            public string Rank { get; set; }
            public string Unit { get; set; }
            public string Notes { get; set; }
            public string ParentName { get; set; }
            public string Email { get; set; }
            public string HomePhone { get; set; }
            public string CellPhone { get; set; }
            public string Address { get; set; }
            public string City { get; set; }
            public string State { get; set; }
            public string Zip { get; set; }
        }

        public class ReservationDashboardViewModel
        {
            public int Id { get; set; }
            public DateTime ReservationDate { get; set; }
            public string RegistrationCode { get; set; }
            public int EventId { get; set; }
            public string Name { get; set; }
            public DateTime DOB { get; set; }
            public string Rank { get; set; }
            public string Unit { get; set; }
            public string Notes { get; set; }
            public string ParentName { get; set; }
            public string Email { get; set; }
            public string HomePhone { get; set; }
            public string CellPhone { get; set; }
            public string Address { get; set; }
            public string City { get; set; }
            public string State { get; set; }
            public string Zip { get; set; }
        }
}