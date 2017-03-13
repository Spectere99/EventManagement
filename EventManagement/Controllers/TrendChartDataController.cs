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
    public class TrendChartDataController : ApiController
    {
        public IEnumerable<RegistrationTrendingModel> Get()
        {

            List<RegistrationTrendingModel> returnList = new List<RegistrationTrendingModel>();
            DayCampData.eventsEntities dbContext = new eventsEntities();
            
            var trendCounts = dbContext.dbveventdashboardtrends.AsNoTracking();
            
            List<RegistrationTrendingModel> trends = new List<RegistrationTrendingModel>();
            foreach (dbveventdashboardtrend item in trendCounts)
            {
                RegistrationTrendingModel trendItem = new RegistrationTrendingModel()
                {
                    EventId = item.events_EventID,
                    RegistrationDate = DateTime.Parse(item.LastUpdated.ToString()),
                    VolunteerCount = int.Parse(item.VolCount.ToString()),
                    RegistrationCount = int.Parse(item.RegCount.ToString()),
                    ReservationCount = int.Parse(item.ResCount.ToString())
                };

                returnList.Add(trendItem);
            }

            return returnList;
        }

    }
}
