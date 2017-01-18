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
    public class EventStaffReader : MySqlObjectReaderBase<EventStaffDTO>
    {
        protected override MapperBase<EventStaffDTO> GetMapper()
        {
            MapperBase<EventStaffDTO> mapper = new EventStaffMapper();
            return mapper;
        }

        public override List<EventStaffDTO> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetEventStaff))
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

        public override List<EventStaffDTO> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetEventStaffById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pEventStaffID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<EventStaffDTO> Save(List<EventStaffDTO> objList)
        {
            foreach (EventStaffDTO item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsEventStaff))
                    {
                        command.Parameters.Add(CreateParameter("pPositionID", item.Position.PositionId));
                        command.Parameters.Add(CreateParameter("pEventID", item.Event.EventId));
                        command.Parameters.Add(CreateParameter("pPersonID", item.Person.PersonId));
                        command.Parameters.Add(CreateOutputParameter("oEventStaffID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.EventStaffId = (int)command.Parameters["oEventStaffID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdEventStaff))
                    {
                        command.Parameters.Add(CreateParameter("pEventStaffID", item.EventStaffId));
                        command.Parameters.Add(CreateParameter("pPositionID", item.Position.PositionId));
                        command.Parameters.Add(CreateParameter("pEventID", item.Event.EventId));
                        command.Parameters.Add(CreateParameter("pPersonID", item.Person.PersonId));

                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<EventStaffDTO> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelEventStaff))
            {
                try
                {
                    foreach (EventStaffDTO item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pEventStaffID", item.EventStaffId));
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
