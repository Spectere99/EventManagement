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
    public class EventVolunteerReader : MySqlObjectReaderBase<EventVolunteerDTO>
    {
        protected override MapperBase<EventVolunteerDTO> GetMapper()
        {
            MapperBase<EventVolunteerDTO> mapper = new EventVolunteerMapper();
            return mapper;
        }

        public override List<EventVolunteerDTO> GetList()
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

        public override List<EventVolunteerDTO> GetById(int id)
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

        public override List<EventVolunteerDTO> Save(List<EventVolunteerDTO> objList)
        {
            foreach (EventVolunteerDTO item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsEventVolunteer))
                    {
                        command.Parameters.Add(CreateParameter("pEventID", item.Event.EventId));
                        command.Parameters.Add(CreateParameter("pPersonID", item.Person.PersonId));
                        command.Parameters.Add(CreateParameter("pvolunteerDays", item.VolunteerDays));
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
                        command.Parameters.Add(CreateParameter("pvolunteerDays", item.VolunteerDays));

                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<EventVolunteerDTO> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelEventVolunteer))
            {
                try
                {
                    foreach (EventVolunteerDTO item in objList)
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
