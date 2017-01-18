using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using System.Web.Mvc;
using Common;

namespace EventManagement.Models
{
    
    public class RegistrationViewModel
    {
        public IEnumerable<EventViewModel> EventList { get; set; }
        public ReservationDTO Reservation { get; set; }
        public string EventVenue { get; set; }
        
    }
}