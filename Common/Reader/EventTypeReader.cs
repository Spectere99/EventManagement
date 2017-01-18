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
    public class EventTypeReader : MySqlObjectReaderBase<EventTypeDTO>
    {
        protected override MapperBase<EventTypeDTO> GetMapper()
        {
            MapperBase<EventTypeDTO> mapper = new EventTypeMapper();
            return mapper;
        }

        public override List<EventTypeDTO> GetList()
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

        public override List<EventTypeDTO> GetById(int id)
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

        public override List<EventTypeDTO> Save(List<EventTypeDTO> objList)
        {
            foreach (EventTypeDTO item in objList)
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

        public override void Remove(List<EventTypeDTO> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelEventType))
            {
                try
                {
                    foreach (EventTypeDTO item in objList)
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
