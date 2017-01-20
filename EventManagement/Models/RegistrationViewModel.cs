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
        public RegistrationDTO Registration { get; set; }
        
        
    }

    public class ReservationViewModel
    {
        public DateTime ReservationDate { get; set; }
        public EventDTO Event { get; set; }
        public PersonViewModel Person { get; set; }
        public SelectList PersonType { get; set; }
        [Required, Display(Name = "Unit Type")]
        public SelectList UnitTypeList { get; set; }
        [Required, Display(Name = "Unit")]
        public SelectList UnitList { get; set; }
        [Required, Display(Name = "Rank")]
        public SelectList UnitRankList { get; set; }
    }
}