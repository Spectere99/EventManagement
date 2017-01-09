using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Web.Mvc;
using EventManagement.Models;

namespace EventManagement.Controllers
{
    public class AdminController : Controller
    {
        private ApplicationDbContext _context;
        private ApplicationUserManager _userManager;

        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ??
                       HttpContext.GetOwinContext()
                           .GetUserManager<ApplicationUserManager>();
            }
            private set { _userManager = value; }
        }

        public AdminController()
        {
             _context = new ApplicationDbContext();
        }
        // GET: Admin
        public ActionResult Index(string searchStringUserNameOrEmail)
        {
            if (searchStringUserNameOrEmail == null)
            {
                searchStringUserNameOrEmail = string.Empty;
            }

            ViewBag.CurrentFilter = searchStringUserNameOrEmail;

            List<ApplicationUser> result = UserManager.Users
                .Where(x => x.UserName.Contains(searchStringUserNameOrEmail))
                .OrderBy(x => x.UserName)
                .ToList();
            return View(result);
        }

        public ActionResult ViewAllRoles()
        {
            List<IdentityRole> list = _context.Roles.OrderBy(r => r.Name).ToList();

            return View(list);
        }

        public ActionResult AddRole()
        {
            IdentityRole objIdentityRole = new IdentityRole();
            return View(objIdentityRole);
        }

        [HttpPost]
        public ActionResult AddRole(IdentityRole identyRole)
        {
            try
            {
                if (identyRole == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                var roleName = identyRole.Name.Trim();
                if (roleName == string.Empty)
                {
                    return View();
                }
                //Create
                if (_context.Roles.Count(r => r.Name.Equals(roleName)) == 0)
                {
                    _context.Roles.Add(new IdentityRole()
                    {
                        Name = roleName
                    });
                    _context.SaveChanges();
                    return RedirectToAction("ViewAllRoles");
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, "Error: " + ex);
                return View("AddRole");
            }
            return View("AddRole");
        }

        public ActionResult Delete(string RoleName)
        {
            var thisRole = _context.Roles.FirstOrDefault(r => r.Name.Equals(RoleName, StringComparison.CurrentCulture));
            _context.Roles.Remove(thisRole);
            _context.SaveChanges();
            return RedirectToAction("ViewAllRoles");
        }
    }
}