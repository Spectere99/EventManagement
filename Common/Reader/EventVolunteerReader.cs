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
    public class EventVolunteerReader : MySqlObjectReaderBase<EventVolunteer>
    {
        protected override MapperBase<EventVolunteer> GetMapper()
        {
            MapperBase<EventVolunteer> mapper = new EventVolunteerMapper();
            return mapper;
        }

        public override List<EventVolunteer> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetEventVolunteers))
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

        public override List<EventVolunteer> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetEventVolunteerById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pEventVolunteerID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<EventVolunteer> Save(List<EventVolunteer> objList)
        {
            foreach (EventVolunteer item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsEventVolunteer))
                    {
                        command.Parameters.Add(CreateParameter("pEventID", item.Event.EventId));
                        command.Parameters.Add(CreateParameter("pPersonID", item.Person.PersonId));
                        command.Parameters.Add(CreateOutputParameter("oEventVolunteerID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.EventVolunteerId = (int)command.Parameters["oEventVolunteerID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdEventVolunteer))
                    {
                        command.Parameters.Add(CreateParameter("pEventVolunteerID", item.EventVolunteerId));
                        command.Parameters.Add(CreateParameter("pEventID", item.Event.EventId));
                        command.Parameters.Add(CreateParameter("pPersonID", item.Person.PersonId));

                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<EventVolunteer> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelEventVolunteer))
            {
                try
                {
                    foreach (EventVolunteer item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pEventVolunteerID", item.EventVolunteerId));
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
