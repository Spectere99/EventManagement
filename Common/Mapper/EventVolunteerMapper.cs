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
    class EventVolunteerMapper : MapperBase<EventVolunteerDTO>
    {
        private int _ordEventVolunteerId;
        private int _ordLastUpdated;
        private int _ordEventId;
        private int _ordPersonId;
        private int _ordVolunteerDays;
        private int _ordMonday ;
        private int _ordTuesday ;
        private int _ordWednesday ;
        private int _ordThursday ;
        private int _ordFriday ;
        private int _ordSaturday ;
        private int _ordSunday ;

        protected override EventVolunteerDTO Map(IDataRecord record)
        {
            try
            {
                EventReader eventReader = new EventReader();
                PersonReader personReader = new PersonReader();


                EventVolunteerDTO e = new EventVolunteerDTO();
                
                e.EventVolunteerId = (DBNull.Value == record[_ordEventVolunteerId]) ? CommonBase.IntNullValue : (int)record[_ordEventVolunteerId];
                e.LastUpdated = (DBNull.Value == record[_ordLastUpdated]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordLastUpdated];
                
                var eventId = (DBNull.Value == record[_ordEventId]) ? CommonBase.IntNullValue : (int)record[_ordEventId];
                e.Event = eventReader.GetById(eventId).FirstOrDefault();

                var personId = (DBNull.Value == record[_ordPersonId]) ? CommonBase.IntNullValue : (int)record[_ordPersonId];
                e.Person = personReader.GetById(personId).FirstOrDefault();

                e.VolunteerDays = (DBNull.Value == record[_ordVolunteerDays]) ? 0 : (int) record[_ordVolunteerDays];

                e.Monday  = (DBNull.Value != record[_ordMonday]) && (record[_ordMonday].ToString() == "Y");
                e.Tuesday  = (DBNull.Value != record[_ordTuesday]) && (record[_ordTuesday].ToString() == "Y");
                e.Wednesday  = (DBNull.Value != record[_ordWednesday]) && (record[_ordWednesday].ToString() == "Y");
                e.Thursday = (DBNull.Value != record[_ordThursday]) && (record[_ordThursday].ToString() == "Y");
                e.Friday = (DBNull.Value != record[_ordFriday]) && (record[_ordFriday].ToString() == "Y");
                e.Saturday = (DBNull.Value != record[_ordSaturday]) && (record[_ordSaturday].ToString() == "Y");
                e.Sunday = (DBNull.Value != record[_ordSunday]) && (record[_ordSunday].ToString() == "Y");

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
            _ordVolunteerDays = reader.GetOrdinal("volunteerDays");
            _ordMonday = reader.GetOrdinal("MondayVol");
            _ordTuesday = reader.GetOrdinal("TuesdayVol");
            _ordWednesday = reader.GetOrdinal("WednesdayVol");
            _ordThursday = reader.GetOrdinal("ThursdayVol");
            _ordFriday = reader.GetOrdinal("FridayVol");
            _ordSaturday = reader.GetOrdinal("SaturdayVol");
            _ordSunday = reader.GetOrdinal("SundayVol");
        }
    }
}