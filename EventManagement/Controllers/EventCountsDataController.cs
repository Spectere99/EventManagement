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
    public class EventCountsDataController : ApiController
    {
        public IEnumerable<EventDashboardCountsPivotModel> Get()
        {

            List<EventDashboardCountsPivotModel> returnList = new List<EventDashboardCountsPivotModel>();
            DayCampData.eventsEntities dbContext = new eventsEntities();

            var eventCount = dbContext.dbveventcounts.AsNoTracking().SingleOrDefault();

            if (eventCount != null)
            {
                returnList.Add(new EventDashboardCountsPivotModel(){ 
                        Val = int.Parse(eventCount.VolunteerCount.ToString()),
                        EventId = eventCount.EventId,
                        EventName = eventCount.EventName,
                        RegType = "Volunteer"
                        });
                returnList.Add(new EventDashboardCountsPivotModel(){ 
                        Val = int.Parse(eventCount.RegistrationCount.ToString()),
                        EventId = eventCount.EventId,
                        EventName = eventCount.EventName,
                        RegType = "Registration"
                        });
                returnList.Add(new EventDashboardCountsPivotModel(){ 
                        Val = int.Parse(eventCount.ReservationCount.ToString()),
                        EventId = eventCount.EventId,
                        EventName = eventCount.EventName,
                        RegType = "Reservation"
                        });
            }

            return returnList;
        }
    }
}
