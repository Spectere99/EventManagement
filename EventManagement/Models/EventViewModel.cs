using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Common;

namespace EventManagement.Models
{
    public class VenueModel
    {
        [Key]
        public int VenueId { get; set; }
        
        [Required, Display(Name = "Venue Name")]
        public string Name { get; set; }
        
        [Required, Display(Name = "Contact Name")]
        public string Contact { get; set; }
        
       // public ContactInfoModel ContactInfo { get; set; }

    }

    public class EventTypeModel
    {
        [Key]
        public int EventTypeId { get; set; }
        
        [Required, Display(Name="Event Type")]
        public string EventType { get; set; }
    }

    public class EventViewModel
    {
        [Key]
        public int EventId { get; set; }

        public VenueModel Venue { get; set; }

        [Required, Display(Name="Event Name")]
        public string EventName { get; set; }

        [Required, Display(Name = "Start Date/Time")]
        public DateTime EventStart { get; set; }
        
        [Required, Display(Name = "End Date/Time")]
        public DateTime EventEnd { get; set; }
        
        [Required, Display(Name = "Description")]
        public string Description { get; set; }
        
        [Required, Display(Name = "Last Updated")]
        public DateTime LastUpdated { get; set; }
        
        public EventTypeModel EventType { get; set; }
        
        [Required, Display(Name = "Staff Payment Req.")]
        public bool StaffPaymentRequired { get; set; }
        
        [Required, Display(Name = "Registration Deadline")]
        public DateTime RegistrationDeadline { get; set; }
        
        [Required, Display(Name = "Required Staff")]
        public int RequiredStaff { get; set; }
        
        [Required, Display(Name = "Required Volunteers")]
        public int RequiredVolunteers { get; set; }

    }

}