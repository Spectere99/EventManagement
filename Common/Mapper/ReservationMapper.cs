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
    class ReservationMapper : MapperBase<ReservationDTO>
    {
        private int _ordReservationId;
        private int _ordReservationDate;
        private int _ordLastUpdate;
        private int _ordEventId;
        private int _ordPersonId;
        private int _ordRegistrationCode;
        
        protected override ReservationDTO Map(IDataRecord record)
        {
            try
            {
                EventReader eventReader = new EventReader();
                PersonReader personReader = new PersonReader();


                ReservationDTO e = new ReservationDTO();
                e.ReservationId = (DBNull.Value == record[_ordReservationId]) ? CommonBase.IntNullValue : (int) record[_ordReservationId];
                e.ReservationDate = (DBNull.Value == record[_ordReservationDate]) ? CommonBase.DateTimeNullValue : (DateTime) record[_ordReservationDate];
                e.LastUpdated = (DBNull.Value == record[_ordLastUpdate]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordLastUpdate];
                var eventId = (DBNull.Value == record[_ordEventId]) ? CommonBase.IntNullValue : (int)record[_ordEventId];
                e.Event = eventReader.GetById(eventId).FirstOrDefault();

                var personId = (DBNull.Value == record[_ordPersonId]) ? CommonBase.IntNullValue : (int)record[_ordPersonId];
                e.Person = personReader.GetById(personId).FirstOrDefault();
                e.RegistrationCode = (DBNull.Value == record[_ordRegistrationCode])
                    ? CommonBase.StringNullValue
                    : (string) record[_ordRegistrationCode];
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
            _ordReservationId = reader.GetOrdinal("ReservationID");
            _ordReservationDate = reader.GetOrdinal("ReservationDate");
            _ordLastUpdate = reader.GetOrdinal("LastUpdated");
            _ordEventId = reader.GetOrdinal("Events_EventID");
            _ordPersonId = reader.GetOrdinal("Person_PersonID");
            _ordRegistrationCode = reader.GetOrdinal("RegistrationCode");



        }
    }
}