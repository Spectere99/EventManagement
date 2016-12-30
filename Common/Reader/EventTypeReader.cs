using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;
using Common.Mapper;
using MySql.Data.MySqlClient;

namespace Common.Reader
{
    public class EventTypeReader : MySqlObjectReaderBase<EventType>
    {
        protected override MapperBase<EventType> GetMapper()
        {
            MapperBase<EventType> mapper = new EventTypeMapper();
            return mapper;
        }

        public override List<EventType> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetEventType))
            {
                try
                {
                    var resultList = Execute(command);
                    return resultList;
                }
                catch (Exception)
                {

                    throw;
                }
            }
        }

        public override List<EventType> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetEventTypeById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pEventTypeID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<EventType> Save(List<EventType> objList)
        {
            foreach (EventType item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsEventType))
                    {
                        command.Parameters.Add(CreateParameter("pEventType", item.Type, 45));
                        command.Parameters.Add(CreateOutputParameter("oEventTypeID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.EventTypeId = (int)command.Parameters["oEventTypeID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdEventType))
                    {
                        command.Parameters.Add(CreateParameter("pEventTypeID", item.EventTypeId));
                        command.Parameters.Add(CreateParameter("pEventType", item.Type, 45));
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<EventType> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelEventType))
            {
                try
                {
                    foreach (EventType item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pEventTypeID", item.EventTypeId));
                        ExecuteNoReader(command);
                        command.Parameters.Clear();
                    }
                }
                catch (Exception)
                {
                    
                    throw;
                }
                
            }
        }
    }
}
