using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventManagement.Models;
using Microsoft.AspNet.Identity.EntityFramework;

namespace EventManagement.Controllers
{
    public class RoleController : Controller
    {
        private ApplicationDbContext _context;

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
            var role = new IdentityRole();
            return View(role);
        }

        [HttpPost]
        public ActionResult Create(IdentityRole role)
        {
            _context.Roles.Add(role);
            _context.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}