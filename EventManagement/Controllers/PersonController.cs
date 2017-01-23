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
    public class PersonController : Controller
    {
        // GET: Person
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        [Authorize]
        public ActionResult PersonDetails()
        {
            PersonViewModel personViewModel = new PersonViewModel();
            PersonReader personReader = new PersonReader();
            var userId = User.Identity.GetUserId();
            //Get person based on their user id
            var person = personReader.GetByUserId(userId).FirstOrDefault();

            if (person != null)
            {
                personViewModel = TranslatePersonDTO(person);
                //Need to load the children now.
                var children = personReader.GetByParentId(person.PersonId);
                foreach (var child in children)
                {
                    var childViewModel = TranslatePersonDTO(child);

                    personViewModel.Children.Add(childViewModel);
                }
                personViewModel.NotUnitAffiliated = person.Unit.UnitType.UnitTypeId.Equals(-1);
            }

            return View(personViewModel);
        }

        [HttpGet]
        [Authorize]
        public ActionResult Edit(int id)
        {
            PersonReader personReader = new PersonReader();

            var person = personReader.GetById(id).FirstOrDefault();
            if (person != null)
            {
                PersonViewModel personViewModel = TranslatePersonDTO(person);

                personViewModel.NotUnitAffiliated = person.Unit.UnitType.UnitTypeId.Equals(-1);

                return View(personViewModel);
            }
            return View();
        }

        [HttpPost]
        [Authorize]
        public ActionResult Edit(int id, FormCollection formValues)
        {
            return RedirectToAction("PersonDetails");
        }

        private PersonViewModel TranslatePersonDTO(PersonDTO person)
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