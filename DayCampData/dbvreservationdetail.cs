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
    
    public partial class dbvreservationdetail
    {
        public int ReservationID { get; set; }
        public System.DateTime ReservationDate { get; set; }
        public string RegistrationCode { get; set; }
        public int Events_EventID { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public Nullable<System.DateTime> BirthDate { get; set; }
        public string UnitRank { get; set; }
        public string UnitType { get; set; }
        public int UnitNumber { get; set; }
        public string Notes { get; set; }
        public string ParentName { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public string Email { get; set; }
        public string HomePhone { get; set; }
        public string CellPhone { get; set; }
    }
}
