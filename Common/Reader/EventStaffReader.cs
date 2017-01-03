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
    public class EventStaffReader : MySqlObjectReaderBase<EventStaff>
    {
        protected override MapperBase<EventStaff> GetMapper()
        {
            MapperBase<EventStaff> mapper = new EventStaffMapper();
            return mapper;
        }

        public override List<EventStaff> GetList()
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

        public override List<EventStaff> GetById(int id)
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

        public override List<EventStaff> Save(List<EventStaff> objList)
        {
            foreach (EventStaff item in objList)
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

        public override void Remove(List<EventStaff> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelEventStaff))
            {
                try
                {
                    foreach (EventStaff item in objList)
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
