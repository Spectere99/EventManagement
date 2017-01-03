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

        public Person()
        {
            PersonId = IntNullValue;
            FirstName = StringNullValue;
            MiddleName = StringNullValue;
            LastName = StringNullValue;
            LastUpdated = DateTimeNullValue;
            ContactInfo = new ContactInfo();
            ParentPerson = null;
            PersonType = new PersonType();
            Rank = new UnitRank();
            Unit = new Unit();
            IsNew = true;
        }

        public Person(int personId, string firstName, string middleName, string lastName, DateTime lastUpdated,
            ContactInfo contactInfo, Person parentPerson, PersonType personType, UnitRank rank, Unit unit)
        {
            PersonId = personId;
            FirstName = firstName;
            MiddleName = middleName;
            LastName = lastName;
            LastUpdated = lastUpdated;
            ContactInfo = contactInfo;
            ParentPerson = parentPerson;
            PersonType = personType;
            Rank = rank;
            Unit = unit;
            IsNew = PersonId.Equals(IntNullValue);
        }
    }
}
