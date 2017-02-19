using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;
using Common.Base;
using Common.Reader;

namespace Common.Mapper
{
    class PersonMapper : MapperBase<PersonDTO>
    {
        private int _ordPersonId;
        private int _ordFirstName;
        private int _ordMiddleName;
        private int _ordLastName;
        private int _ordLastUpdate;
        private int _ordContactInfoId;
        private int _ordParentPersonId;
        private int _ordPersonTypeId;
        private int _ordUnitRankId;
        private int _ordUnitId;
        private int _ordUserId;
        private int _ordNotes;
        
        protected override PersonDTO Map(IDataRecord record)
        {
            try
            {
                PersonTypeReader personTypeReader = new PersonTypeReader();
                ContactInfoReader contactInfoReader = new ContactInfoReader();
                PersonReader personReader = new PersonReader();
                UnitRankReader unitRankReader = new UnitRankReader();
                UnitReader unitReader = new UnitReader();


                PersonDTO e = new PersonDTO();
                e.PersonId = (DBNull.Value == record[_ordPersonId]) ? CommonBase.IntNullValue : (int) record[_ordPersonId];
                e.FirstName = (DBNull.Value == record[_ordFirstName]) ? CommonBase.StringNullValue : (string) record[_ordFirstName];
                e.MiddleName = (DBNull.Value == record[_ordMiddleName]) ? CommonBase.StringNullValue : (string)record[_ordMiddleName];
                e.LastName = (DBNull.Value == record[_ordLastName]) ? CommonBase.StringNullValue : (string)record[_ordLastName];
                e.LastUpdated = (DBNull.Value == record[_ordLastUpdate]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordLastUpdate];

                var contactInfoId = (DBNull.Value == record[_ordContactInfoId]) ? CommonBase.IntNullValue : (int)record[_ordContactInfoId];
                e.ContactInfo = contactInfoReader.GetById(contactInfoId).FirstOrDefault();

                var parentPersonId = (DBNull.Value == record[_ordParentPersonId]) ? CommonBase.IntNullValue : (int)record[_ordParentPersonId];
                e.ParentPerson = personReader.GetById(parentPersonId).FirstOrDefault();

                var personTypeId = (DBNull.Value == record[_ordPersonTypeId])? CommonBase.IntNullValue : (int) record[_ordPersonTypeId];
                e.PersonType = personTypeReader.GetById(personTypeId).FirstOrDefault();

                var unitRankId = (DBNull.Value == record[_ordUnitRankId]) ? CommonBase.IntNullValue : (int) record[_ordUnitRankId];
                e.Rank = unitRankReader.GetById(unitRankId).FirstOrDefault();

                var unitId = (DBNull.Value == record[_ordUnitId]) ? CommonBase.IntNullValue : (int) record[_ordUnitId];
                e.Unit = unitReader.GetById(unitId).FirstOrDefault();

                e.UserId = (DBNull.Value == record[_ordUserId]) ? CommonBase.StringNullValue : (string)record[_ordUserId];
                
                //New Additions
                e.Notes = (DBNull.Value == record[_ordNotes]) ? CommonBase.StringNullValue : (string) record[_ordNotes];
                e.IsNew = false;
                return e;
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected override void BindOrdinals(IDataReader reader)
        {
            _ordPersonId = reader.GetOrdinal("PersonID");
            _ordFirstName = reader.GetOrdinal("FirstName");
            _ordMiddleName = reader.GetOrdinal("MiddleName");
            _ordLastName = reader.GetOrdinal("LastName");
            _ordLastUpdate = reader.GetOrdinal("LastUpdate");
            _ordContactInfoId = reader.GetOrdinal("contactInfo_ContactInfoID");
            _ordParentPersonId = reader.GetOrdinal("ParentPersonID");
            _ordPersonTypeId = reader.GetOrdinal("persontype_PersonTypeID");
            _ordUnitRankId = reader.GetOrdinal("unitranks_UnitRankID");
            _ordUnitId = reader.GetOrdinal("units_UnitID");
            _ordUserId = reader.GetOrdinal("user_id");

            //New Additions
            _ordNotes = reader.GetOrdinal("Notes");

        }
    }
}