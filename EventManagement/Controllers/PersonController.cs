using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common;
using Common.Reader;
using EventManagement.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace EventManagement.Controllers
{
    public class PersonController : ApplicationBaseController
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
            else
            {
                HandleErrorInfo handleErrorInfo = new HandleErrorInfo(new Exception(string.Format("Person record was not found for login account <{0}>", User.Identity.Name)),"Person", "Index");
                return View("Error", handleErrorInfo);
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
        public ActionResult EditSelf(int id)
        {
            PersonReader personReader = new PersonReader();
            PersonTypeReader personTypeReader = new PersonTypeReader();
            UnitReader unitReader = new UnitReader();
            UnitRankReader unitRankReader = new UnitRankReader();

            var person = personReader.GetById(id).FirstOrDefault();
            if (person != null)
            {
                PersonViewModel personViewModel = TranslatePersonDTO(person);

                personViewModel.NotUnitAffiliated = person.Unit.UnitType.UnitTypeId.Equals(-1);
                UnitTypeReader unitTypeReader = new UnitTypeReader();

                var personTypes = personTypeReader.GetList().Where(p => p.PersonTypeId > 0).ToList();
                var unitTypes = unitTypeReader.GetList().Where(p => p.UnitTypeId > 0).ToList();

                List<UnitDTO> units = null;
                List<UnitRankDTO> unitRanks = null;
                if (personViewModel.UnitType != null)
                {
                    units = unitReader.GetList().Where(p => p.UnitType.Type == personViewModel.UnitType).ToList();
                    unitRanks = unitRankReader.GetList().Where(p => p.UnitType.Type == personViewModel.UnitType).ToList();
                }
                else
                {
                    units = unitReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
                    unitRanks = unitRankReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
                }
                personViewModel.NotUnitAffiliated = false;
                personViewModel.PersonTypeList = personTypes;
                personViewModel.PersonType = person.PersonType.PersonTypeId.ToString();
                personViewModel.UnitTypeList = unitTypes;
                personViewModel.UnitType = person.Unit.UnitType.UnitTypeId.ToString();
                personViewModel.UnitList = units;
                personViewModel.Unit = person.Unit.UnitId.ToString();
                personViewModel.UnitRankList = unitRanks;
                personViewModel.Rank = person.Rank.UnitRankId.ToString();
                return View(personViewModel);
            }

            return View();
        }

        [HttpGet]
        [Authorize]
        public ActionResult Edit(int id)
        {
            PersonReader personReader = new PersonReader();
            PersonTypeReader personTypeReader = new PersonTypeReader();
            UnitReader unitReader = new UnitReader();
            UnitRankReader unitRankReader = new UnitRankReader();

            var person = personReader.GetById(id).FirstOrDefault();
            if (person != null)
            {
                PersonViewModel personViewModel = TranslatePersonDTO(person);

                personViewModel.NotUnitAffiliated = person.Unit.UnitType.UnitTypeId.Equals(-1);
                UnitTypeReader unitTypeReader = new UnitTypeReader();

                var personTypes = personTypeReader.GetList().Where(p => p.PersonTypeId > 0).ToList();
                var unitTypes = unitTypeReader.GetList().Where(p => p.UnitTypeId > 0).ToList();

                List<UnitDTO> units = null;
                List<UnitRankDTO> unitRanks = null;
                if (personViewModel.UnitType != null)
                {
                    units = unitReader.GetList().Where(p => p.UnitType.Type == personViewModel.UnitType).ToList();
                    unitRanks = unitRankReader.GetList().Where(p => p.UnitType.Type == personViewModel.UnitType).ToList();
                }
                else
                {
                    units = unitReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
                    unitRanks = unitRankReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
                }
                personViewModel.NotUnitAffiliated = false;
                personViewModel.PersonTypeList = personTypes;
                personViewModel.PersonType = person.PersonType.PersonTypeId.ToString();
                personViewModel.UnitTypeList = unitTypes;
                personViewModel.UnitType = person.Unit.UnitType.UnitTypeId.ToString();
                personViewModel.UnitList = units;
                personViewModel.Unit = person.Unit.UnitId.ToString();
                personViewModel.UnitRankList = unitRanks;
                personViewModel.Rank = person.Rank.UnitRankId.ToString();
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
                    UnitTypeList = unitTypes,
                    BirthDay = DateTime.Now.AddYears(-5)
                    
                };

                return View(personChildViewModel);
            }

            TempData["RedirectMsg"] = "Parent Not found in database.";
            return RedirectToAction("Index");
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
                        Notes = model.Notes,
                        BirthDate = model.BirthDay,
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
                    TempData["RedirectMsg"] = "Child Added Successfully!";
                    return RedirectToAction("Index");    
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
        public ActionResult EditSelf(int id, PersonViewModel model)
        {
            PersonReader personReader = new PersonReader();
            PersonTypeReader personTypeReader = new PersonTypeReader();
            ContactInfoReader contactInfoReader = new ContactInfoReader();
            UnitRankReader unitRankReader = new UnitRankReader();

            var oldPerson = personReader.GetById(id).SingleOrDefault();

            if (ModelState.IsValid)
            {
                PersonDTO person = TranslatePersonViewModel(model);
                person.PersonId = id;
                person.UserId = (oldPerson != null) ? oldPerson.UserId : "";
                person.ContactInfo = oldPerson.ContactInfo;
                person.IsNew = false;

                List<PersonDTO> personList = new List<PersonDTO>();

                personList.Add(person);

                var userManager = HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
                if (userManager != null)
                {
                    userManager.RemoveFromRole(person.UserId, "Leader");
                    userManager.AddToRole(person.UserId, model.PersonType == "2" ? "Leader" : "User");
                }

                personReader.Save(personList);

                TempData["RedirectMsg"] = "Record Updated Successfully!";

                model.ContactInfo = new ContactInfoViewModel();
                //Need to build the Contact Object again before the return trip.
                
                if (person.ContactInfo != null)
                {
                    model.ContactInfo = new ContactInfoViewModel
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
                    };
                }
                return RedirectToAction("Index");
            }

            //Invalid Entries
            UnitTypeReader unitTypeReader = new UnitTypeReader();
            UnitReader unitReader = new UnitReader();

            var personTypes = personTypeReader.GetList().Where(p => p.PersonTypeId > 0).ToList();
            var unitTypes = unitTypeReader.GetList().Where(p => p.UnitTypeId > 0).ToList();

            List<UnitDTO> units = null;
            List<UnitRankDTO> unitRanks = null;
            if (model.UnitType != null)
            {
                units = unitReader.GetList().Where(p => p.UnitType.Type == model.UnitType).ToList();
                unitRanks = unitRankReader.GetList().Where(p => p.UnitType.Type == model.UnitType).ToList();
            }
            else
            {
                units = unitReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
                unitRanks = unitRankReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
            }
            var personType = personTypeReader.GetById(int.Parse(model.PersonType));
            var unit = unitReader.GetById(int.Parse(model.Unit));
            var unitType = unitTypeReader.GetById(int.Parse(model.UnitType));
            //var unitRank = unitRankReader.GetById(int.Parse(model.Rank));
            model.NotUnitAffiliated = false;
            model.PersonTypeList = personTypes;
            model.PersonType = model.PersonType;
            model.UnitTypeList = unitTypes;
            model.UnitList = units;
            model.UnitRankList = unitRanks;

            return View(model);
        }
        [HttpPost]
        [Authorize]
        public ActionResult Edit(int id, PersonViewModel model)
        {
            PersonReader personReader = new PersonReader();
            PersonTypeReader personTypeReader = new PersonTypeReader();
            ContactInfoReader contactInfoReader = new ContactInfoReader();
            UnitRankReader unitRankReader = new UnitRankReader();

            var oldPerson = personReader.GetById(id).SingleOrDefault();
            
            if (ModelState.IsValid)
            {
                PersonDTO person = TranslatePersonViewModel(model);
                person.PersonId = id;
                person.UserId = (oldPerson != null)? oldPerson.UserId : "";
                person.IsNew = false;

                List<PersonDTO> personList = new List<PersonDTO>();

                personList.Add(person);

                var userManager = HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
                if (userManager != null)
                {
                    userManager.AddToRole(person.UserId, model.PersonType == "2" ? "Leader" : "User");
                }
                
                personReader.Save(personList);

                TempData["RedirectMsg"] = "Record Updated Successfully!";

                model.ContactInfo = new ContactInfoViewModel();
                //Need to build the Contact Object again before the return trip.
                ContactInfoDTO contact = contactInfoReader.GetById(model.ContactInfoId).SingleOrDefault();
                if (contact != null)
                {
                    model.ContactInfo = new ContactInfoViewModel
                    {
                        ContactName = contact.Name,
                        Email = contact.Email,
                        Address1 = contact.Address1,
                        Address2 = contact.Address2,
                        CellPhone = contact.CellPhone,
                        HomePhone = contact.HomePhone,
                        City = contact.City,
                        State = contact.State,
                        Zip = contact.Zip
                    };
                }
                return RedirectToAction("Index");
            }

            //Invalid Entries
            UnitTypeReader unitTypeReader = new UnitTypeReader();
            UnitReader unitReader = new UnitReader();

            var personTypes = personTypeReader.GetList().Where(p => p.PersonTypeId > 0).ToList();
            var unitTypes = unitTypeReader.GetList().Where(p => p.UnitTypeId > 0).ToList();

            List<UnitDTO> units = null;
            List<UnitRankDTO> unitRanks = null;
            if (model.UnitType != null)
            {
                units = unitReader.GetList().Where(p => p.UnitType.Type == model.UnitType).ToList();
                unitRanks = unitRankReader.GetList().Where(p => p.UnitType.Type == model.UnitType).ToList();
            }
            else
            {
                units = unitReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
                unitRanks = unitRankReader.GetList().Where(p => p.UnitType.UnitTypeId == unitTypes[0].UnitTypeId).ToList();
            }
            var personType = personTypeReader.GetById(int.Parse(model.PersonType));
            var unit = unitReader.GetById(int.Parse(model.Unit));
            var unitType = unitTypeReader.GetById(int.Parse(model.UnitType));
            var unitRank = unitRankReader.GetById(int.Parse(model.Rank));
            model.NotUnitAffiliated = false;
            model.PersonTypeList = personTypes;
            model.PersonType = model.PersonType;
            model.UnitTypeList = unitTypes;
            model.UnitList = units;
            model.UnitRankList = unitRanks;

            return View(model);
        }

        private PersonViewModel TranslatePersonDTO(PersonDTO person)
        {
           PersonViewModel personViewModel = new PersonViewModel
            {
                PersonId = person.PersonId,
                FirstName = person.FirstName,
                MiddleName = person.MiddleName,
                LastName = person.LastName,
                Notes = person.Notes,
                BirthDay = person.BirthDate,
                PersonType = person.PersonType.Type,
                UnitType = person.Unit.UnitType.Type,
                Unit = person.Unit.UnitNumber.ToString(),
                Rank = person.Rank.Rank,
                ParentPersonId = (person.ParentPerson != null) ? person.ParentPerson.PersonId : 0,
                ContactInfoId = person.ContactInfo.ContactInfoId,
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

        private PersonDTO TranslatePersonViewModel(PersonViewModel personView)
        {
            UnitTypeReader unitTypeReader = new UnitTypeReader();
            UnitReader unitReader = new UnitReader();
            UnitRankReader unitRankReader = new UnitRankReader();
            PersonTypeReader personTypeReader = new PersonTypeReader();
            PersonReader personReader = new PersonReader();
            

            UnitTypeDTO unitType = unitTypeReader.GetById(int.Parse(personView.UnitType)).SingleOrDefault();

            UnitRankDTO unitRank = personView.Rank != null ? unitRankReader.GetById(int.Parse(personView.Rank)).SingleOrDefault() : null;
            UnitDTO unit = unitReader.GetById(int.Parse(personView.Unit)).SingleOrDefault();
            PersonTypeDTO personType = personTypeReader.GetById(int.Parse(personView.PersonType)).SingleOrDefault();
            PersonDTO parent = personReader.GetById(personView.ParentPersonId).SingleOrDefault();

            

            PersonDTO personDTO = new PersonDTO();
            {
                personDTO.PersonId = personView.PersonId;
                personDTO.FirstName = personView.FirstName;
                personDTO.MiddleName = personView.MiddleName;
                personDTO.LastName = personView.LastName;
                personDTO.Notes = personView.Notes;
                personDTO.BirthDate = personView.BirthDay;
                personDTO.LastUpdated = DateTime.Now;
                personDTO.Unit = unit;
                personDTO.Rank = unitRank;
                personDTO.PersonType = personType;
                personDTO.ParentPerson = parent;
            }

            if (parent != null)
            {
                personDTO.ContactInfo = parent.ContactInfo;
            }
            else
            {
                ContactInfoReader contactInfoReader = new ContactInfoReader();

                personDTO.ContactInfo = contactInfoReader.GetById(personView.ContactInfoId).SingleOrDefault();
            }

            return personDTO;
            
        }
    }
}