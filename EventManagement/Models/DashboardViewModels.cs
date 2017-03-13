using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventManagement.Models
{
       
    public class DashboardChartModel
    {
        public List<RegistrationTrendingModel> RegistrationTrends { get; set; }
        public List<UnitEventCountsModel> UnitEventCounts { get; set; }
    }

    public class RegistrationTrendingModel
    {
        public int EventId { get; set; }
        public DateTime RegistrationDate { get; set; }
        public int VolunteerCount { get; set; }
        public int ReservationCount { get; set; }
        public int RegistrationCount { get; set; }
        public UnitEventCountsModel UnitCounts { get; set; }
    }

    public class UnitEventCountsModel
    {
        public int EventId { get; set; }
        public string Unit { get; set; }
        public long VolunteerCount { get; set; }
        public long ReservationCount { get; set; }
        public long RegistrationCount { get; set; }
    }
}