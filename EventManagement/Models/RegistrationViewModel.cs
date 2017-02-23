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
        public EventDTO Event { get; set; }
        public PersonDTO Person { get; set; }
        public string ConfirmationNumber { get; set; }

    }

    public class ReservationViewModel
    {
        public DateTime ReservationDate { get; set; }
        public EventDTO Event { get; set; }
        public PersonDTO Person { get; set; }
        //public SelectList PersonType { get; set; }
        //[Required, Display(Name = "Unit Type")]
        //public SelectList UnitTypeList { get; set; }
        //[Required, Display(Name = "Unit")]
        //public SelectList UnitList { get; set; }
        //[Required, Display(Name = "Rank")]
        //public SelectList UnitRankList { get; set; }
    }

    public class VolunteerRegistrationViewModel
    {
        public IEnumerable<EventViewModel> EventList { get; set; }
        public EventDTO Event { get; set; }

        [Display(Name="Mon.")]
        public bool MondayVolunteer { get; set; }
        [Display(Name = "Tues.")]
        public bool TuesdayVolunteer { get; set; }
        [Display(Name = "Wed.")]
        public bool WednesdayVolunteer { get; set; }
        [Display(Name = "Thurs.")]
        public bool ThursdayVolunteer { get; set; }
        [Display(Name = "Fri.")]
        public bool FridayVolunteer { get; set; }
        [Display(Name = "Sat.")]
        public bool SaturdayVolunteer { get; set; }
        [Display(Name = "Sun.")]
        public bool SundayVolunteer { get; set; }

        [Display(Name="Days Volunteering")]
        [Range(typeof(int), "1", "5", ErrorMessage = "Please enter a number between 1 and 5 days.")]
        public int VolunteerDays { get; set; }
        public PersonDTO Person { get; set; }
    }

    public class AttendeeViewList
    {
        public int ParentId { get; set; }

        public List<AttendeeViewModel> AttendeeList;

    }

    public class AttendeeViewModel
    {
        public int PersonId { get; set; }
        [Required, Display(Name = "First Name")]
        public string FirstName { get; set; }
        [Display(Name = "Middle Name")]
        public string MiddleName { get; set; }
        [Required, Display(Name = "Last Name")]
        public string LastName { get; set; }
        [Required, Display(Name = "Person Type")]
        public string PersonType { get; set; }
        [Display(Name = "Not Associated with a Unit")]
        public bool NotUnitAffiliated { get; set; }
        [Display(Name = "Unit Type")]
        public string UnitType { get; set; }
        [Display(Name = "Unit")]
        public string Unit { get; set; }
        [Display(Name = "Rank")]
        public string UnitRank { get; set; }
        public ContactInfoViewModel ContactInfo { get; set; }
    }
}