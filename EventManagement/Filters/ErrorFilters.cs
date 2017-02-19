using System;
using System.Linq;
using System.Reflection;
using System.Web.Mvc;

public class ErrorFilter : HandleErrorAttribute
{
    public override void OnException(ExceptionContext filterContext)
    {
        var exception = filterContext.Exception;
        string controller = "";
        string action = "";


        controller = filterContext.RouteData.Values["controller"].ToString();
        action = filterContext.RouteData.Values["action"].ToString();

        if (filterContext.ExceptionHandled)
        {
            return;
        }
        else
        {
            //Determine the return type of the action
            string actionName = filterContext.RouteData.Values["action"].ToString();
            Type controllerType = filterContext.Controller.GetType();
            //Since we can have the same method names, but with different Actions (GET, POST), we need to look at which one we are interested in.
            MethodInfo method = null;
            MethodInfo[] matchedMethods = controllerType.GetMethods(BindingFlags.Instance | BindingFlags.Public)
                        .Where(m => m.Name == actionName).ToArray();

            if (matchedMethods.Length > 1)
            {
                string attributeTypeString = "HttpGet"; // Change this to "HttpPut" or the text of any custom attribute filter
                foreach (MethodInfo methodInfo in matchedMethods)
                {
                    
                    if (!methodInfo.CustomAttributes.Any()) { continue; }
                    // An alternative below is to explicitly check against a defined attribute type (e.g. `ca.AttributeType == ...`).
                    if (methodInfo.CustomAttributes.FirstOrDefault(ca => ca.ToString().IndexOf(attributeTypeString, StringComparison.Ordinal) == 0) != null)
                    {
                        method = methodInfo;
                        break; // Break out of the 'foreach' loop since a match was found
                    }
                    if (methodInfo.ReturnType == typeof(ActionResult))
                    {
                        method = methodInfo;
                    }
                }
                
            }
            else
            {
                method = controllerType.GetMethod(actionName, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
            }
            if (method != null)
            {
                var returnType = method.ReturnType;

                //If the action that generated the exception returns JSON
                if (returnType == typeof(JsonResult))
                {
                    filterContext.Result = new JsonResult()
                    {
                        Data = "DATA not returned"
                    };
                }

                //If the action that generated the exception returns a view
                if (returnType == typeof(ActionResult)
                    || (returnType).IsSubclassOf(typeof(ActionResult)))
                {
                    filterContext.Result = new ViewResult
                    {
                        ViewName = "Error"
                    };
                }
            }
        }

        //Make sure that we mark the exception as handled
        filterContext.ExceptionHandled = true;
    }
}