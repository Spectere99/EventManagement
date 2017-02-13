using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common;
using Common.Reader;
using EventManagement.Models;
using Microsoft.AspNet.Identity;

namespace EventManagement.Controllers
{
    public class OrganizationController : Controller
    {
        // GET: Organization
        public ActionResult Index()
        {
            OrganizationViewModel orgViewModel = new OrganizationViewModel();
            PersonReader personReader = new PersonReader();
            var userId = User.Identity.GetUserId();
            //Get person based on their user id
            var person = personReader.GetByUserId(userId).FirstOrDefault();

            if (person != null)
            {
                orgViewModel = TranslatePersonDTO(person);
                //Need to load the children now.
                var unitMembers = personReader.GetList().Where(p => p.Unit.UnitId == person.Unit.UnitId);
                var members = unitMembers.Where(p=>p.PersonType.Type == "Cub Scout");
                orgViewModel.Members = new List<PersonViewModel>();

                foreach (var member in members)
                {
                    var childViewModel = translatePersonDTOToPersonViewModel(member);
                    orgViewModel.Members.Add(childViewModel);
                }
                orgViewModel.NotUnitAffiliated = person.Unit.UnitType.UnitTypeId.Equals(-1);
            }
            return View(orgViewModel);
        }

        private OrganizationViewModel TranslatePersonDTO(PersonDTO person)
        {
            OrganizationViewModel orgViewModel = new OrganizationViewModel
            {
                PersonId = person.PersonId,
                FirstName = person.FirstName,
                MiddleName = person.MiddleName,
                LastName = person.LastName,
                PersonType = person.PersonType.Type,
                UnitType = person.Unit.UnitType.Type,
                Unit = person.Unit.UnitNumber.ToString(),
                UnitRank = person.Rank.Rank,
                ContactInfo = new ContactInfoViewModel
                {
                    ContactName = person.ContactInfo.Name,
                    Email = person.ContactInfo.Email,
                    Address1 = person.ContactInfo.Address1,
                    Address2 = person.ContactInfo.Address2,
                    CellPhone = person.ContactInfo.CellPhone,
                    HomePhone = person.ContactInfo.HomePhone,
                    City = person.ContactInfo.City,
                    State = person.ContactInfo.State,
                    Zip = person.ContactInfo.Zip
                }
            };

            return orgViewModel;
        }

        private PersonViewModel translatePersonDTOToPersonViewModel(PersonDTO person)
        {
            PersonViewModel personViewModel = new PersonViewModel
            {
                PersonId = person.PersonId,
                FirstName = person.FirstName,
                MiddleName = person.MiddleName,
                LastName = person.LastName,
                PersonType = person.PersonType.Type,
                UnitType = person.Unit.UnitType.Type,
                Unit = person.Unit.UnitNumber.ToString(),
                UnitRank = person.Rank.Rank,
                ContactInfo = new ContactInfoViewModel
                {
                    ContactName = person.ContactInfo.Name,
                    Email = person.ContactInfo.Email,
                    Address1 = person.ContactInfo.Address1,
                    Address2 = person.ContactInfo.Address2,
                    CellPhone = person.ContactInfo.CellPhone,
                    HomePhone = person.ContactInfo.HomePhone,
                    City = person.ContactInfo.City,
                    State = person.ContactInfo.State,
                    Zip = person.ContactInfo.Zip
                }
            };

            return personViewModel;
        }
    }
}