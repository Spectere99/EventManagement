using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class PersonDTO:DTOBase
    {
        public int PersonId { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public DateTime LastUpdated { get; set; }
        public ContactInfoDTO ContactInfo { get; set; }
        public PersonDTO ParentPerson { get; set; }
        public PersonTypeDTO PersonType { get; set; }
        public UnitRankDTO Rank { get; set; }
        public UnitDTO Unit { get; set; }

        public PersonDTO()
        {
            PersonId = IntNullValue;
            FirstName = StringNullValue;
            MiddleName = StringNullValue;
            LastName = StringNullValue;
            LastUpdated = DateTimeNullValue;
            ContactInfo = new ContactInfoDTO();
            ParentPerson = null;
            PersonType = new PersonTypeDTO();
            Rank = new UnitRankDTO();
            Unit = new UnitDTO();
            IsNew = true;
        }

        public PersonDTO(int personId, string firstName, string middleName, string lastName, DateTime lastUpdated,
            ContactInfoDTO contactInfo, PersonDTO parentPerson, PersonTypeDTO personType, UnitRankDTO rank, UnitDTO unit)
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
