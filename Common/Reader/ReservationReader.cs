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
    public class ReservationReader : MySqlObjectReaderBase<ReservationDTO>
    {
        protected override MapperBase<ReservationDTO> GetMapper()
        {
            MapperBase<ReservationDTO> mapper = new ReservationMapper();
            return mapper;
        }

        public override List<ReservationDTO> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetReservations))
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

        public override List<ReservationDTO> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetReservationById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pReservationID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<ReservationDTO> Save(List<ReservationDTO> objList)
        {
            foreach (ReservationDTO item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsReservation))
                    {
                        command.Parameters.Add(CreateParameter("pReservationDate", item.ReservationDate));
                        command.Parameters.Add(CreateParameter("pEventID", item.Event.EventId));
                        command.Parameters.Add(CreateParameter("pPersonID", item.Person.PersonId));
                        command.Parameters.Add(CreateOutputParameter("oReservationID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.ReservationId = (int)command.Parameters["oReservationID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdReservation))
                    {
                        command.Parameters.Add(CreateParameter("pReservationID", item.ReservationId));
                        command.Parameters.Add(CreateParameter("pReservationDate", item.ReservationDate));
                        command.Parameters.Add(CreateParameter("pEventID", item.Event.EventId));
                        command.Parameters.Add(CreateParameter("pPersonID", item.Person.PersonId));
                        command.Parameters.Add(CreateParameter("pRegistrationCode", item.RegistrationCode, 64));
                        command.Parameters.Add(CreateParameter("pCodeExpiration", item.CodeExpiration));
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<ReservationDTO> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelReservation))
            {
                try
                {
                    foreach (ReservationDTO item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pReservationID", item.ReservationId));
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

        public ReservationDTO GetByRegistrationCode(string registrationCode)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetReservationByRegCode))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pRegistrationCode", registrationCode, 64));
                    var resultList = Execute(command);
                    return resultList.FirstOrDefault();

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public List<ReservationDTO> GetByEventId(int eventId)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetReservationsByEventID))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pEventID", eventId));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }
    }
}
