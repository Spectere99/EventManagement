using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;
using Common.Base;

namespace Common.Mapper
{
    class EventTypeMapper : MapperBase<EventType>
    {
        private int _ordEventTypeID;
        private int _ordEventType;

        protected override EventType Map(IDataRecord record)
        {
            try
            {
                EventType e = new EventType();
                e.EventTypeId = (DBNull.Value == record[_ordEventTypeID]) ? CommonBase.IntNullValue : (int)record[_ordEventTypeID];
                e.Type = (DBNull.Value == record[_ordEventType]) ? CommonBase.StringNullValue : (string)record[_ordEventType];

                return e;
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        protected override void BindOrdinals(IDataReader reader)
        {
            _ordEventTypeID = reader.GetOrdinal("EventTypeID");
            _ordEventType = reader.GetOrdinal("EventType");
        }
    }
}
