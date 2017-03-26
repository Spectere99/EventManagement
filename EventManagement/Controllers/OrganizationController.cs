using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common;
using Common.Reader;
using EventManagement.Models;
using Microsoft.AspNet.Identity;

namespace EventManagement.Controllers
{
    public class OrganizationController : ApplicationBaseController
    {
        // GET: Organization
        public ActionResult Index()
        {
            OrganizationViewModel orgViewModel = new OrganizationViewModel();
            PersonReader personReader = new PersonReader();
            
            try
            {
                var userId = User.Identity.GetUserId();
                
                //Get person based on their user id
                var person = personReader.GetByUserId(userId).FirstOrDefault();
                if (person != null)
                {
                   
                    orgViewModel = TranslatePersonDTO(person);
                    //Need to load the children now.
                    var unitMembers = personReader.GetList().Where(p => p.Unit.UnitId == person.Unit.UnitId);
                    //var members = unitMembers.Where(p=>p.PersonType.Type == "Cub Scout");
                    orgViewModel.Members = new List<PersonViewModel>();
                    
                    foreach (var member in unitMembers)
                    {
                        var childViewModel = TranslatePersonDTOToPersonViewModel(member);
                        orgViewModel.Members.Add(childViewModel);
                    }
                    orgViewModel.NotUnitAffiliated = person.Unit.UnitType.UnitTypeId.Equals(-1);
                }
                return View(orgViewModel);
            }
            catch (Exception ex)
            {
                var st = new StackTrace(ex, true);
                StackFrame frame = st.GetFrame(0);

                //Get the file name
                string fileName = frame.GetFileName();

                //Get the method name
                string methodName = frame.GetMethod().Name;

                //Get the line number from the stack frame
                int line = frame.GetFileLineNumber();

                //Get the column number
                int col = frame.GetFileColumnNumber();

                TextWriter tr = new StreamWriter(System.Web.HttpContext.Current.Server.MapPath("../logs/errors.log"), true);
                tr.WriteLine("File: {0}", fileName);
                tr.WriteLine("Method: {0}", methodName);
                tr.WriteLine("Line Number: {0} - Col: {1}", line, col);
                tr.WriteLine(ex.Message);
                tr.Flush();
                tr.Close();
                HandleErrorInfo handleErrorInfo = new HandleErrorInfo(new Exception(string.Format("Error when loading Organization: Line {0} : {1}", line, ex.Message)), "Organization", "Index");

                return View("Error", handleErrorInfo);
            }
            
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

        private PersonViewModel TranslatePersonDTOToPersonViewModel(PersonDTO person)
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
                Rank = person.Rank.Rank,
                ContactInfoId = person.ContactInfo != null ? person.ContactInfo.ContactInfoId : 0,
                
                //ContactInfo = new ContactInfoViewModel
                //{
                //    ContactName = person.ContactInfo.Name,
                //    Email = person.ContactInfo.Email,
                //    Address1 = person.ContactInfo.Address1,
                //    Address2 = person.ContactInfo.Address2,
                //    CellPhone = person.ContactInfo.CellPhone,
                //    HomePhone = person.ContactInfo.HomePhone,
                //    City = person.ContactInfo.City,
                //    State = person.ContactInfo.State,
                //    Zip = person.ContactInfo.Zip
                //}
            };

            return personViewModel;
        }
    }
}