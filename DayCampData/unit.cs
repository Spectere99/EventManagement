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
    
    public partial class unit
    {
        public int UnitID { get; set; }
        public int UnitNumber { get; set; }
        public int unittypes_UnitTypeID { get; set; }
    
        public virtual unittype unittype { get; set; }
    }
}
