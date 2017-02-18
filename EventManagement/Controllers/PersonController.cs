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
                personViewModel.Children = new List<PersonViewModel>();

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
                personViewModel.Children = new List<PersonViewModel>();

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

        [Authorize]
        public ActionResult Delete(int personId)
        {
            PersonReader personReader = new PersonReader();

            var person = personReader.GetById(personId).FirstOrDefault();
            if (person != null)
            {
                List<PersonDTO> personList = new List<PersonDTO> {person};
                personReader.Remove(personList);
            }

            return RedirectToAction("PersonDetails");
        }

        [HttpGet]
        [Authorize]
        public ActionResult AddPerson(int id)
        {
            PersonReader personReader = new PersonReader();
            
            var parentPerson = personReader.GetById(id).FirstOrDefault();
            
           if (parentPerson != null)
            {
                PersonTypeReader personTypeReader = new PersonTypeReader();
                UnitTypeReader unitTypeReader = new UnitTypeReader();

               //Since we are only allowing to add a child for a parent account here, we leave out person types that are Parent(1) and Leader(2)
                var personTypes = personTypeReader.GetList().Where(p => p.PersonTypeId > 2).ToList();
                var unitTypes = unitTypeReader.GetList().Where(p => p.UnitTypeId > 0).ToList();

                PersonChildViewModel personChildViewModel = new PersonChildViewModel
                {
                    ParentPersonId = id,
                    ContactInfoId = parentPerson.ContactInfo.ContactInfoId,
                    PersonTypeList = personTypes,
                    UnitTypeList = unitTypes
                };

                return View(personChildViewModel);
            }

            TempData["RedirectMsg"] = "Parent Not found in database.";
            return RedirectToAction("PersonDetails");
        }

        [HttpPost]
        [Authorize]
        public ActionResult AddPerson(PersonChildViewModel model)
        {
            PersonTypeReader personTypeReader = new PersonTypeReader();
            UnitTypeReader unitTypeReader = new UnitTypeReader();
            UnitReader unitReader = new UnitReader();
            ContactInfoReader contactInfoReader = new ContactInfoReader();

            if (ModelState.IsValid)
            {
                PersonReader personReader = new PersonReader();
                UnitRankReader unitRankReader = new UnitRankReader();
                List<PersonDTO> personList = new List<PersonDTO>();
                
                var parentPerson = personReader.GetById(model.ParentPersonId);
                var personType = personTypeReader.GetById(int.Parse(model.PersonType));
                var unit = unitReader.GetById(int.Parse(model.Unit));
                var rank = unitRankReader.GetById(int.Parse(model.Rank));
                var parent = parentPerson.FirstOrDefault();
                if (parent != null)
                {
                    var contactInfo = contactInfoReader.GetById(parent.ContactInfo.ContactInfoId);

                    PersonDTO person = new PersonDTO()
                    {
                        FirstName = model.FirstName,
                        MiddleName = model.MiddleName,
                        LastName = model.LastName,
                        LastUpdated = DateTime.Now,
                        ContactInfo = contactInfo.FirstOrDefault(),
                        ParentPerson = parent,
                        PersonType = personType.FirstOrDefault(),
                        Rank = rank.FirstOrDefault(),
                        Unit = unit.FirstOrDefault(),
                        UserId = String.Empty
                    };
                    personList.Add(person);

                    personReader.Save(personList);
                    TempData["RedirectMsg"] = "Child Addes Successfully!";
                    return RedirectToAction("PersonDetails");    
                }
                TempData["RedirectMsg"] = "ERROR - Parent Not Found";
            }

            //Invalid Entries
            

            var personTypes = personTypeReader.GetList().Where(p => p.PersonTypeId > 2).ToList();
            var unitTypes = unitTypeReader.GetList().Where(p => p.UnitTypeId > 0).ToList();
            
            model.PersonTypeList = personTypes;
            model.UnitTypeList = unitTypes;

            return View(model);
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