using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventManagement.Models
{
        public class RegistrationTrendingModel
        {
            public int EventId { get; set; }
            public DateTime RegistrationDate { get; set; }
            public int VolunteerCount { get; set; }
            public int ReservationCount { get; set; }
            public int RegistrationCount { get; set; }
        }
}