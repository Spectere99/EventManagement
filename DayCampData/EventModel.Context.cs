﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class eventsEntities : DbContext
    {
        public eventsEntities()
            : base("name=eventsEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<contactinfo> contactinfoes { get; set; }
        public virtual DbSet<@event> events { get; set; }
        public virtual DbSet<eventstaff> eventstaffs { get; set; }
        public virtual DbSet<eventtype> eventtypes { get; set; }
        public virtual DbSet<eventvolunteer> eventvolunteers { get; set; }
        public virtual DbSet<person> people { get; set; }
        public virtual DbSet<persontype> persontypes { get; set; }
        public virtual DbSet<position> positions { get; set; }
        public virtual DbSet<registration> registrations { get; set; }
        public virtual DbSet<reservation> reservations { get; set; }
        public virtual DbSet<unitrank> unitranks { get; set; }
        public virtual DbSet<unit> units { get; set; }
        public virtual DbSet<unittype> unittypes { get; set; }
        public virtual DbSet<venue> venues { get; set; }
        public virtual DbSet<dbveventvolunteerdetail> dbveventvolunteerdetails { get; set; }
        public virtual DbSet<dbveventcount> dbveventcounts { get; set; }
        public virtual DbSet<dbveventvolunteertrend> dbveventvolunteertrends { get; set; }
        public virtual DbSet<dbvregistrationdetail> dbvregistrationdetails { get; set; }
        public virtual DbSet<dbvregistrationtrend> dbvregistrationtrends { get; set; }
        public virtual DbSet<dbvreservationdetail> dbvreservationdetails { get; set; }
        public virtual DbSet<dbvreservationtrend> dbvreservationtrends { get; set; }
    }
}