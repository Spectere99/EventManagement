using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace EventManagement.Models
{
    public class OrganizationViewModel
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
        [Display(Name = "Members")]
        public List<PersonViewModel> Members { get; set; }
    }
}