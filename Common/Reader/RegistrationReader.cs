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
    public class RegistrationReader : MySqlObjectReaderBase<Registration>
    {
        protected override MapperBase<Registration> GetMapper()
        {
            MapperBase<Registration> mapper = new RegistrationMapper();
            return mapper;
        }

        public override List<Registration> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetRegistrations))
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

        public override List<Registration> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetRegistrationById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pRegistrationID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<Registration> Save(List<Registration> objList)
        {
            foreach (Registration item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsRegistration))
                    {
                        command.Parameters.Add(CreateParameter("pRegistrationDate", item.RegistrationDate));
                        command.Parameters.Add(CreateParameter("pConfirmation", item.ConfirmationNumber, 15));
                        command.Parameters.Add(CreateParameter("pEventID", item.Event.EventId));
                        command.Parameters.Add(CreateParameter("pPersonID", item.Person.PersonId));
                        command.Parameters.Add(CreateOutputParameter("pRegistrationID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.RegistrationId = (int)command.Parameters["pRegistrationID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdRegistration))
                    {
                        command.Parameters.Add(CreateParameter("pRegistrationID", item.RegistrationId));
                        command.Parameters.Add(CreateParameter("pRegistrationDate", item.RegistrationDate));
                        command.Parameters.Add(CreateParameter("pConfirmation", item.ConfirmationNumber, 15));
                        command.Parameters.Add(CreateParameter("pEventID", item.Event.EventId));
                        command.Parameters.Add(CreateParameter("pPersonID", item.Person.PersonId));
                        
                        
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<Registration> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelRegistration))
            {
                try
                {
                    foreach (Registration item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pRegistrationID", item.RegistrationId));
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
