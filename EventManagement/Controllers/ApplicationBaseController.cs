using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EventManagement.Models;

namespace EventManagement.Controllers
{
    public class ApplicationBaseController : Controller
    {
        protected override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            if (User != null)
            {
                var context = new ApplicationDbContext();
                var userName = User.Identity.Name;

                if (!string.IsNullOrEmpty(userName))
                {
                    var user = context.Users.SingleOrDefault(u => u.UserName == userName);
                    string fullName = string.Concat(new string[] {user.FirstName, " ", user.LastName});

                    ViewData.Add("FullName", fullName);
                }
            }
            base.OnActionExecuted(filterContext);
        }
        public ApplicationBaseController()
        { }
    }
}