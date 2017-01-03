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
    class EventVolunteerMapper : MapperBase<EventVolunteer>
    {
        private int _ordEventVolunteerId;
        private int _ordLastUpdated;
        private int _ordEventId;
        private int _ordPersonId;

        protected override EventVolunteer Map(IDataRecord record)
        {
            try
            {
                EventReader eventReader = new EventReader();
                PersonReader personReader = new PersonReader();


                EventVolunteer e = new EventVolunteer();
                
                e.EventVolunteerId = (DBNull.Value == record[_ordEventVolunteerId]) ? CommonBase.IntNullValue : (int)record[_ordEventVolunteerId];
                e.LastUpdated = (DBNull.Value == record[_ordLastUpdated]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordLastUpdated];
                
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
            _ordEventVolunteerId = reader.GetOrdinal("EventVolunteerID");
            _ordLastUpdated = reader.GetOrdinal("LastUpdated");
            _ordEventId = reader.GetOrdinal("events_EventID");
            _ordPersonId = reader.GetOrdinal("person_PersonID");

        }
    }
}