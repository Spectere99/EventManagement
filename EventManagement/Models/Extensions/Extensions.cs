using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;

namespace EventManagement.Models.Extensions
{
    public static class ModelExtensions
    {
        public static IEnumerable<SelectListItem> ToSelectListItems(
            this IEnumerable<EventViewModel> events , int selectedId)
        {
            return
                events.OrderBy(e => e.EventStart)
                    .Select(e =>
                        new SelectListItem
                        {
                            Selected = (e.EventId == selectedId),
                            Text = e.EventName,
                            Value = e.EventId.ToString()
                        });
        }
    }
}