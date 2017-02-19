using System.Web;
using System.Web.Mvc;

namespace EventManagement
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new ErrorFilter());
            filters.Add(new HandleErrorAttribute());
            //filters.Add(new SessionFilter());
        }
    }
}
