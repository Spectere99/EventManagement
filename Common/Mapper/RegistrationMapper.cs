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
    class RegistrationMapper : MapperBase<Registration>
    {
        private int _ordRegistrationId;
        private int _ordRegistrationDate;
        private int _ordConfirmation;
        private int _ordLastUpdate;
        private int _ordEventId;
        private int _ordPersonId;
        
        protected override Registration Map(IDataRecord record)
        {
            try
            {
                EventReader eventReader = new EventReader();
                PersonReader personReader = new PersonReader();


                Registration e = new Registration();
                e.RegistrationId = (DBNull.Value == record[_ordRegistrationId]) ? CommonBase.IntNullValue : (int) record[_ordRegistrationId];
                e.RegistrationDate = (DBNull.Value == record[_ordRegistrationDate]) ? CommonBase.DateTimeNullValue : (DateTime) record[_ordRegistrationDate];
                e.LastUpdated = (DBNull.Value == record[_ordLastUpdate]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordLastUpdate];
                e.ConfirmationNumber = (DBNull.Value == record[_ordConfirmation]) ? CommonBase.StringNullValue : (string)record[_ordConfirmation];
                var eventId = (DBNull.Value == record[_ordEventId]) ? CommonBase.IntNullValue : (int)record[_ordEventId];
                e.Event = eventReader.GetById(eventId).FirstOrDefault();

                var personId = (DBNull.Value == record[_ordPersonId]) ? CommonBase.IntNullValue : (int)record[_ordPersonId];
                e.Person = personReader.GetById(personId).FirstOrDefault();
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
            _ordRegistrationId = reader.GetOrdinal("RegistrationID");
            _ordRegistrationDate = reader.GetOrdinal("RegistrationDate");
            _ordConfirmation = reader.GetOrdinal("Confirmation");
            _ordLastUpdate = reader.GetOrdinal("LastUpdated");
            _ordEventId = reader.GetOrdinal("Events_EventID");
            _ordPersonId = reader.GetOrdinal("Person_PersonID");
            
           

        }
    }
}