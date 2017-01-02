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
    public class EventReader : MySqlObjectReaderBase<Event>
    {
        protected override MapperBase<Event> GetMapper()
        {
            MapperBase<Event> mapper = new EventMapper();
            return mapper;
        }

        public override List<Event> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetEvents))
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

        public override List<Event> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetEventById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pEventID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<Event> Save(List<Event> objList)
        {
            foreach (Event item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsEvent))
                    {
                        command.Parameters.Add(CreateParameter("pVenueID", item.Venue.VenueId));
                        command.Parameters.Add(CreateParameter("pEventName", item.Name, 100));
                        command.Parameters.Add(CreateParameter("pEventStart", item.Start));
                        command.Parameters.Add(CreateParameter("pEventEnd", item.End));
                        command.Parameters.Add(CreateParameter("pEventDescription", item.Description, 2000));
                        command.Parameters.Add(CreateParameter("pEventTypeID", item.EventType.EventTypeId));
                        command.Parameters.Add(CreateParameter("pStaffPaymentRequired", item.StaffPaymentRequired));
                        command.Parameters.Add(CreateParameter("pRegistrationDeadline", item.RegistrationDeadline));
                        command.Parameters.Add(CreateParameter("pRequiredStaff", item.RequiredStaffCount));
                        command.Parameters.Add(CreateParameter("pRequiredVolunteers", item.RequiredVolunteersCount));
                        command.Parameters.Add(CreateOutputParameter("oEventID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.EventId = (int)command.Parameters["oEventID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdEvent))
                    {
                        command.Parameters.Add(CreateParameter("pEventID", item.EventId));
                        command.Parameters.Add(CreateParameter("pVenueID", item.Venue.VenueId));
                        command.Parameters.Add(CreateParameter("pEventName", item.Name, 100));
                        command.Parameters.Add(CreateParameter("pEventStart", item.Start));
                        command.Parameters.Add(CreateParameter("pEventEnd", item.End));
                        command.Parameters.Add(CreateParameter("pEventDescription", item.Description, 2000));
                        command.Parameters.Add(CreateParameter("pEventTypeID", item.EventType.EventTypeId));
                        command.Parameters.Add(CreateParameter("pStaffPaymentRequired", item.StaffPaymentRequired));
                        command.Parameters.Add(CreateParameter("pRegistrationDeadline", item.RegistrationDeadline));
                        command.Parameters.Add(CreateParameter("pRequiredStaff", item.RequiredStaffCount));
                        command.Parameters.Add(CreateParameter("pRequiredVolunteers", item.RequiredVolunteersCount));
                        
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<Event> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelEvent))
            {
                try
                {
                    foreach (Event item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pEventID", item.EventId));
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
