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
    
    public partial class eventvolunteer
    {
        public int EventVolunteerID { get; set; }
        public System.DateTime LastUpdated { get; set; }
        public int events_EventID { get; set; }
        public int person_PersonID { get; set; }
        public int volunteerDays { get; set; }
        public string MondayVol { get; set; }
        public string TuesdayVol { get; set; }
        public string WednesdayVol { get; set; }
        public string ThursdayVol { get; set; }
        public string FridayVol { get; set; }
        public string SaturdayVol { get; set; }
        public string SundayVol { get; set; }
    }
}
