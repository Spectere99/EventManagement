using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using EventManagement.Models;
using DayCampData;


namespace EventManagement.Controllers
{
    public class UnitEventCountsDataController : ApiController
    {
        public IEnumerable<UnitEventCountsModel> Get()
        {
            DayCampData.eventsEntities dbContext = new eventsEntities();
            var unitCounts = dbContext.dbveventcountsbyunits.AsNoTracking().Where(p => p.EventId == 1);

            List<UnitEventCountsModel> unitEventCounts = new List<UnitEventCountsModel>();

            foreach (dbveventcountsbyunit unitCount in unitCounts)
            {
                UnitEventCountsModel unitCountItem = new UnitEventCountsModel()
                {
                    EventId = unitCount.EventId,
                    Unit = unitCount.UnitType + " " + unitCount.UnitNumber,
                    VolunteerCount = int.Parse(unitCount.VolCount.ToString()),
                    RegistrationCount = int.Parse(unitCount.RegCount.ToString()),
                    ReservationCount = int.Parse(unitCount.ResCount.ToString())
                };
                unitEventCounts.Add(unitCountItem);
            }

            return unitEventCounts;
        }
    }
}
