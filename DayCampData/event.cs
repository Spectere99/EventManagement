//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DayCampData
{
    using System;
    using System.Collections.Generic;
    
    public partial class @event
    {
        public int EventID { get; set; }
        public int VenueID { get; set; }
        public string EventName { get; set; }
        public System.DateTime EventStart { get; set; }
        public System.DateTime EventEnd { get; set; }
        public string EventDescription { get; set; }
        public Nullable<System.DateTime> LastUpdate { get; set; }
        public int EventTypes_EventTypeID { get; set; }
        public Nullable<bool> StaffPaymentRequired { get; set; }
        public System.DateTime RegistrationDeadline { get; set; }
        public int RequiredStaff { get; set; }
        public int RequiredVolunteers { get; set; }
    
        public virtual eventtype eventtype { get; set; }
    }
}
