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
    class EventStaffMapper : MapperBase<EventStaff>
    {
        private int _ordEventStaffId;
        private int _ordLastUpdated;
        private int _ordPositionId;
        private int _ordEventId;
        private int _ordPersonId;

        protected override EventStaff Map(IDataRecord record)
        {
            try
            {
                PositionReader positionReader = new PositionReader();
                EventReader eventReader = new EventReader();
                PersonReader personReader = new PersonReader();


                EventStaff e = new EventStaff();
                
                e.EventStaffId = (DBNull.Value == record[_ordEventStaffId]) ? CommonBase.IntNullValue : (int)record[_ordEventStaffId];
                e.LastUpdated = (DBNull.Value == record[_ordLastUpdated]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordLastUpdated];
                
                var positionId = (DBNull.Value == record[_ordPositionId])? CommonBase.IntNullValue : (int)record[_ordPositionId];
                e.Position = positionReader.GetById(positionId).FirstOrDefault();

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
            _ordEventStaffId = reader.GetOrdinal("EventStaffID");
            _ordLastUpdated = reader.GetOrdinal("LastUpdated");
            _ordPositionId = reader.GetOrdinal("positions_PositionID");
            _ordEventId = reader.GetOrdinal("events_EventID");
            _ordPersonId = reader.GetOrdinal("person_PersonID");

        }
    }
}