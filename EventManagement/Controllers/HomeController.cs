using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace EventManagement.Controllers
{
    public class HomeController : ApplicationBaseController
    {
        [AllowAnonymous]
        public ActionResult Index()
        {
            return View();
        }
    }
}
