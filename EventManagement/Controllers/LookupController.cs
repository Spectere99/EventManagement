using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Common.Reader;

namespace EventManagement.Controllers
{
    public class LookupController : Controller
    {
        [HttpGet]
        public ActionResult GetVenueDetails(int eventId)
        {
            EventReader eventReader = new EventReader();

            var theEvent = eventReader.GetById(eventId).SingleOrDefault();
            if (theEvent != null)
            {
                //Store in Session object for use during the other registration areas
                Session["RegistrationEvent"] = theEvent;
                return Json(theEvent.Venue, JsonRequestBehavior.AllowGet);
            }
            return null;

        }
        [HttpGet]
        public ActionResult GetEventDate(int eventId)
        {
            EventReader eventReader = new EventReader();

            var theEvent = eventReader.GetById(eventId).SingleOrDefault();
            if (theEvent != null)
            {
                var dates = theEvent.Start + " thru " + theEvent.End;
                return Json(dates, JsonRequestBehavior.AllowGet);
            }
            return null;

        }
        [HttpGet]
        public ActionResult GetUnits(int typeId)
        {
            UnitReader unitReader = new UnitReader();
            var units = unitReader.GetList();
            //List<SelectListItem> unitList = new List<SelectListItem>();

            SelectList unitList = new SelectList(units.Where(p => p.UnitType.UnitTypeId.Equals(typeId)).ToList(), "UnitId", "UnitNumber");
            return Json(unitList, JsonRequestBehavior.AllowGet);
        }
        [HttpGet]
        public ActionResult GetRanks(int typeId)
        {
            UnitRankReader unitRankReader = new UnitRankReader();
            var unitRanks = unitRankReader.GetList();
            SelectList rankList = new SelectList(unitRanks.Where(p => p.UnitType.UnitTypeId.Equals(typeId)).ToList(), "UnitRankId", "Rank");

            return Json(rankList, JsonRequestBehavior.AllowGet);
        }
    }
}