using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using EventManagement.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;

namespace EventManagement.Controllers
{
    public class RoleController : Controller
    {
        private ApplicationDbContext _context;
        private ApplicationUserManager _userManager;
        public ApplicationUserManager UserManager
        {
            get { return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>(); }
            private set { _userManager = value; }
        }

        public RoleController()
        {
            _context = new ApplicationDbContext();
        }

        // GET: Role
        public ActionResult Index()
        {
            var roles = _context.Roles.ToList();
            return View(roles);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(FormCollection formCollection)
        {
            try
            {
                _context.Roles.Add(new IdentityRole()
                {
                    Name = formCollection["RoleName"]
                });
                _context.SaveChanges();
                ViewBag.ResultMessage = "Role created successfully!";
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                return View();
            }
        }

        public ActionResult Delete(string RoleName)
        {
            var thisRole = _context.Roles.FirstOrDefault(r => r.Name.Equals(RoleName, StringComparison.CurrentCulture));
            _context.Roles.Remove(thisRole);
            _context.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult Edit(string roleName)
        {
            var thisRole = _context.Roles.FirstOrDefault(r => r.Name.Equals(roleName, StringComparison.CurrentCulture));
            return View(thisRole);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(IdentityRole role)
        {
            try
            {
                _context.Entry(role).State = EntityState.Modified;
                _context.SaveChanges();

                return RedirectToAction("Index");

            }
            catch (Exception)
            {
                return View();
            }
        }

        public ActionResult ManageUserRoles()
        {
            var list = _context.Roles.OrderBy(r => r.Name).ToList().Select(rr =>
                    new SelectListItem {Value = rr.Name.ToString(), Text = rr.Name}).ToList();
            ViewBag.Roles = list;
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult RoleAddToUser(string userName, string roleName)
        {
            ApplicationUser user = _context.Users.FirstOrDefault(u=>u.UserName.Equals(userName, StringComparison.CurrentCulture));
           
            UserManager.AddToRole(user.Id, roleName);

            ViewBag.ResultMessage = "Role created successfully!";

            var list = _context.Roles.OrderBy(r => r.Name).ToList().Select(rr =>
                    new SelectListItem { Value = rr.Name.ToString(), Text = rr.Name }).ToList();
            ViewBag.Roles = list;

            return View("ManageUserRoles");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult GetRoles(string userName)
        {
            if (!string.IsNullOrWhiteSpace(userName))
            {
                ApplicationUser user =
                    _context.Users.FirstOrDefault(u => u.UserName.Equals(userName, StringComparison.CurrentCulture));
                
                ViewBag.RolesForThisUser = UserManager.GetRoles(user.Id);

                var list = _context.Roles.OrderBy(r => r.Name).ToList().Select(rr =>
                    new SelectListItem { Value = rr.Name.ToString(), Text = rr.Name }).ToList();
                ViewBag.Roles = list;

                
            }
            return View("ManageUserRoles");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteRoleForUser(string userName, string roleName)
        {
            ApplicationUser user =
                   _context.Users.FirstOrDefault(u => u.UserName.Equals(userName, StringComparison.CurrentCulture));
            
            if (UserManager.IsInRole(user.Id, roleName))
            {
                UserManager.RemoveFromRole(user.Id, roleName);
                ViewBag.ResultMessage = "Role removed fromt his user!";
            }
            else
            {
                ViewBag.ResultMessage = "This user doesn't belong to selected role.";
            }
            var list = _context.Roles.OrderBy(r => r.Name).ToList().Select(rr =>
                    new SelectListItem { Value = rr.Name.ToString(), Text = rr.Name }).ToList();
            ViewBag.Roles = list;

            return View("ManageUserRoles");
        }
    }
}