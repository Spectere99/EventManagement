using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;
using System.Web.Mvc;
using Common;

namespace EventManagement.Models
{
    public class PersonViewModel
    {
        public int PersonId { get; set; }
        [Required, Display(Name = "First Name")]
        public string FirstName { get; set; }
        [Display(Name = "Middle Name")]
        public string MiddleName { get; set; }
        [Required, Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Display(Name = "Date of Birth")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:d}")]
        public DateTime BirthDay { get; set; }

        //Person Type Value and Lookup List
        [Required, Display(Name = "Person Type")]
        public string PersonType { get; set; }
        [Display(Name = "Classification")]
        public List<PersonTypeDTO> PersonTypeList { get; set; }

        [Display(Name = "Not Associated with a Unit")]
        public bool NotUnitAffiliated { get; set; }
        //Unit Type Value and Lookup List
        [Display(Name="Unit Type")]
        public string UnitType { get; set; }
        [Display(Name = "Unit Type")]
        public List<UnitTypeDTO> UnitTypeList { get; set; }

        //Unit Value and Lookup List
        [Display(Name = "Unit")]
        public string Unit { get; set; }
        [Display(Name = "Unit")]
        public List<UnitDTO> UnitList { get; set; }

        //Rank Value and Lookup List
        [Display(Name = "Rank")]
        public string Rank { get; set; }
        [Display(Name = "Rank")]
        public List<UnitRankDTO> UnitRankList { get; set; }

        public int ContactInfoId { get; set; }
        public ContactInfoViewModel ContactInfo { get; set; }

        [Display(Name = "Children")]
        public List<PersonViewModel> Children { get; set; }
        [Display(Name="Notes (Allergies, etc.)")]
        public string Notes { get; set; }

        public int ParentPersonId { get; set; }
    }

    public class PersonChildViewModel
    {
        public int PersonId { get; set; }
        [Required, Display(Name = "First Name")]
        public string FirstName { get; set; }
        [Display(Name = "Middle Name")]
        public string MiddleName { get; set; }
        [Required, Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Required, Display(Name="Date of Birth")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:d}")]
        public DateTime BirthDay { get; set; }

        [Required, Display(Name="ParentId")]
        public int ParentPersonId { get; set; }

        [Display(Name="Contact Information Id")]
        public int  ContactInfoId { get; set; }

        [Required, Display(Name = "Classification")]
        public string PersonType { get; set; }
        [Display(Name = "Classification")]
        public List<PersonTypeDTO> PersonTypeList { get; set; }

        [Required, Display(Name = "Unit Type")]
        public string UnitType { get; set; }
        [Display(Name = "Unit Type")]
        public List<UnitTypeDTO> UnitTypeList { get; set; }

        [Required, Display(Name = "Unit")]
        public string Unit { get; set; }
        [Display(Name = "Unit")]
        public List<UnitDTO> UnitList { get; set; }

        [Required, Display(Name = "Rank")]
        public string Rank { get; set; }
        [Display(Name = "Rank")]
        public List<UnitRankDTO> UnitRankList { get; set; }

        [Display(Name="Notes (Allergies, etc.)")]
        public string Notes { get; set; }
        
    }

    public class ContactInfoViewModel
    {
        [Key]
        public int ContactInfoId { get; set; }
        [Required, Display(Name="Contact Name")]
        public string ContactName { get; set; }
        [Required, Display(Name = "Home Phone")]
        public string HomePhone { get; set; }
        [Display(Name = "Cell Phone")]
        public string CellPhone { get; set; }
        [Required, Display(Name = "Email")]
        public string Email { get; set; }
        [Required, Display(Name = "Address Line 1")]
        public string Address1 { get; set; }
        [Display(Name = "Address Line 2")]
        public string Address2 { get; set; }
        [Required, Display(Name = "City")]
        public string City { get; set; }
        [Required, Display(Name = "State")]
        public string State { get; set; }
        [Required, Display(Name = "Zip Code")]
        public string Zip { get; set; }


    }
    
}