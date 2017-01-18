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
    public class VenueReader : MySqlObjectReaderBase<VenueDTO>
    {
        protected override MapperBase<VenueDTO> GetMapper()
        {
            MapperBase<VenueDTO> mapper = new VenueMapper();
            return mapper;
        }

        public override List<VenueDTO> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetVenues))
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

        public override List<VenueDTO> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetVenueById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pVenueID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<VenueDTO> Save(List<VenueDTO> objList)
        {
            foreach (VenueDTO item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsVenue))
                    {
                        command.Parameters.Add(CreateParameter("pName", item.Name, 45));
                        command.Parameters.Add(CreateParameter("pContact", item.Contact, 45));
                        command.Parameters.Add(CreateParameter("pContactInfoId", item.ContactInfo.ContactInfoId));
                        command.Parameters.Add(CreateOutputParameter("oVenueID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.VenueId = (int)command.Parameters["oVenueID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdVenue))
                    {
                        command.Parameters.Add(CreateParameter("pVenueID", item.VenueId));
                        command.Parameters.Add(CreateParameter("pName", item.Name, 45));
                        command.Parameters.Add(CreateParameter("pContact", item.Contact, 45));
                        command.Parameters.Add(CreateParameter("pContactInfoId", item.ContactInfo.ContactInfoId));
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<VenueDTO> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelVenue))
            {
                try
                {
                    foreach (VenueDTO item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pVenueID", item.VenueId));
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
