using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class Person:DTOBase
    {
        public int PersonId { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public DateTime LastUpdated { get; set; }
        public ContactInfo ContactInfo { get; set; }
        public Person ParentPerson { get; set; }
        public PersonType PersonType { get; set; }
        public UnitRank Rank { get; set; }
        public Unit Unit { get; set; }


    }
}
