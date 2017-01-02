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
    class EventMapper : MapperBase<Event>
    {
        private int _ordEventId;
        private int _ordVenueId;
        private int _ordName;
        private int _ordEventStart;
        private int _ordEventEnd;
        private int _ordEventDescription;
        private int _ordLastUpdate;
        private int _ordEventTypeId;
        private int _ordStaffPaymentReq;
        private int _ordRegistrationDeadline;
        private int _ordRequiredStaff;
        private int _ordRequiredVolunteers;

        protected override Event Map(IDataRecord record)
        {
            try
            {
                EventTypeReader reader = new EventTypeReader();
                VenueReader venueReader = new VenueReader();

                Event e = new Event();
                e.EventId = (DBNull.Value == record[_ordEventId]) ? CommonBase.IntNullValue : (int) record[_ordEventId];
                e.Name = (DBNull.Value == record[_ordName]) ? CommonBase.StringNullValue : (string) record[_ordName];
                e.Start = (DBNull.Value == record[_ordEventStart]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordEventStart];
                e.End = (DBNull.Value == record[_ordEventEnd]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordEventEnd];
                e.Description = (DBNull.Value == record[_ordEventDescription]) ? CommonBase.StringNullValue : (string)record[_ordEventDescription];
                e.LastUpdated = (DBNull.Value == record[_ordLastUpdate]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordLastUpdate];
                e.StaffPaymentRequired = (DBNull.Value == record[_ordStaffPaymentReq]) && record[_ordStaffPaymentReq].Equals(1);
                e.RegistrationDeadline = (DBNull.Value == record[_ordRegistrationDeadline]) ? CommonBase.DateTimeNullValue : (DateTime)record[_ordRegistrationDeadline];
                e.RequiredStaffCount = (DBNull.Value == record[_ordRequiredStaff]) ? CommonBase.IntNullValue : (int)record[_ordRequiredStaff];
                e.RequiredVolunteersCount = (DBNull.Value == record[_ordRequiredVolunteers]) ? CommonBase.IntNullValue : (int)record[_ordRequiredVolunteers];

                var eventTypeId = (DBNull.Value == record[_ordEventTypeId])? CommonBase.IntNullValue : (int) record[_ordEventTypeId];
                var eventType = reader.GetById(eventTypeId);
                e.EventType = eventType.Single();

                var venueId = (DBNull.Value == record[_ordVenueId]) ? CommonBase.IntNullValue : (int) record[_ordVenueId];
                var venue = venueReader.GetById(venueId);
                e.Venue = venue.Single();

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
            _ordEventId = reader.GetOrdinal("EventID");
            _ordVenueId = reader.GetOrdinal("VenueID");
            _ordName = reader.GetOrdinal("EventName");
            _ordEventStart = reader.GetOrdinal("EventStart");
            _ordEventEnd = reader.GetOrdinal("EventEnd");
            _ordEventDescription = reader.GetOrdinal("EventDescription");
            _ordLastUpdate = reader.GetOrdinal("LastUpdate");
            _ordEventTypeId = reader.GetOrdinal("EventTypes_EventTypeID");
            _ordStaffPaymentReq = reader.GetOrdinal("StaffPaymentRequired");
            _ordRegistrationDeadline = reader.GetOrdinal("RegistrationDeadline");
            _ordRequiredStaff = reader.GetOrdinal("RequiredStaff");
            _ordRequiredVolunteers = reader.GetOrdinal("RequiredVolunteers");

        }
    }
}