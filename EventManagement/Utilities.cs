using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EventManagement
{
    public class StateObject
    {
        public string Abbreviation { get; set; }
        public string Name { get; set; }
    }

    public class Utilities
    {
        public static List<StateObject> States = new List<StateObject>()
    {
        new StateObject() {Name="Alabama", Abbreviation="AL"},
        new StateObject() { Name="Alaska", Abbreviation="AK"},
        new StateObject() { Name="Arizona", Abbreviation="AZ"},
        new StateObject() { Name="Arkansas", Abbreviation="AR"},
        new StateObject() { Name="California", Abbreviation="CA"},
        new StateObject() { Name="Colorado", Abbreviation="CO"},
        new StateObject() { Name="Connecticut", Abbreviation="CT"},
        new StateObject() { Name="District of Columbia", Abbreviation="DC"},
        new StateObject() { Name="Delaware", Abbreviation="DE"},
        new StateObject() { Name="Florida", Abbreviation="FL"},
        new StateObject() { Name="Georgia", Abbreviation="GA"},
        new StateObject() { Name="Hawaii", Abbreviation="HI"},
        new StateObject() { Name="Idaho", Abbreviation="ID"},
        new StateObject() { Name="Illinois", Abbreviation="IL"},
        new StateObject() { Name="Indiana", Abbreviation="IN"},
        new StateObject() { Name="Iowa", Abbreviation="IA"},
        new StateObject() { Name="Kansas", Abbreviation="KS"},
        new StateObject() { Name="Kentucky", Abbreviation="KY"},
        new StateObject() { Name="Louisiana", Abbreviation="LA"},
        new StateObject() { Name="Maine", Abbreviation="ME"},
        new StateObject() { Name="Maryland", Abbreviation="MD"},
        new StateObject() { Name="Massachusetts", Abbreviation="MA"},
        new StateObject() { Name="Michigan", Abbreviation="MI"},
        new StateObject() { Name="Minnesota", Abbreviation="MN"},
        new StateObject() { Name="Mississippi", Abbreviation="MS"},
        new StateObject() { Name="Missouri", Abbreviation="MO"},
        new StateObject() { Name="Montana", Abbreviation="MT"},
        new StateObject() { Name="Nebraska", Abbreviation="NE"},
        new StateObject() { Name="Nevada", Abbreviation="NV"},
        new StateObject() { Name="New Hampshire", Abbreviation="NH"},
        new StateObject() { Name="New Jersey", Abbreviation="NJ"},
        new StateObject() { Name="New Mexico", Abbreviation="NM"},
        new StateObject() { Name="New York", Abbreviation="NY"},
        new StateObject() { Name="North Carolina", Abbreviation="NC"},
        new StateObject() { Name="North Dakota", Abbreviation="ND"},
        new StateObject() { Name="Ohio", Abbreviation="OH"},
        new StateObject() { Name="Oklahoma", Abbreviation="OK"},
        new StateObject() { Name="Oregon", Abbreviation="OR"},
        new StateObject() { Name="Pennsylvania", Abbreviation="PA"},
        new StateObject() { Name="Rhode Island", Abbreviation="RI"},
        new StateObject() { Name="South Carolina", Abbreviation="SC"},
        new StateObject() { Name="South Dakota", Abbreviation="SD"},
        new StateObject() { Name="Tennessee", Abbreviation="TN"},
        new StateObject() { Name="Texas", Abbreviation="TX"},
        new StateObject() { Name="Utah", Abbreviation="UT"},
        new StateObject() { Name="Vermont", Abbreviation="VT"},
        new StateObject() { Name="Virginia", Abbreviation="VA"},
        new StateObject() { Name="Washington", Abbreviation="WA"},
        new StateObject() { Name="West Virginia", Abbreviation="WV"},
        new StateObject() { Name="Wisconsin", Abbreviation="WI"},
        new StateObject() { Name="Wyoming", Abbreviation="WY"}
    };
    }
}