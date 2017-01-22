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
    public class ContactInfoReader : MySqlObjectReaderBase<ContactInfoDTO>
    {
        protected override MapperBase<ContactInfoDTO> GetMapper()
        {
            MapperBase<ContactInfoDTO> mapper = new ContactInfoMapper();
            return mapper;
        }

        public override List<ContactInfoDTO> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetContactInfo))
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

        public override List<ContactInfoDTO> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetContactInfoById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pContactInfoID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<ContactInfoDTO> Save(List<ContactInfoDTO> objList)
        {
            foreach (ContactInfoDTO item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsContactInfo))
                    {
                        command.Parameters.Add(CreateParameter("pContactName", item.Name, 45));
                        command.Parameters.Add(CreateParameter("pHomePhone", item.HomePhone, 15));
                        command.Parameters.Add(CreateParameter("pCellPhone", item.CellPhone, 15));
                        command.Parameters.Add(CreateParameter("pEmail", item.Email, 45));
                        command.Parameters.Add(CreateParameter("pAddress1", item.Address1, 50));
                        command.Parameters.Add(CreateParameter("pAddress2", item.Address2, 50));
                        command.Parameters.Add(CreateParameter("pCity", item.City, 45));
                        command.Parameters.Add(CreateParameter("pState", item.State, 2));
                        command.Parameters.Add(CreateParameter("pZip", item.Zip, 10));
                        command.Parameters.Add(CreateOutputParameter("oContactInfoID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.ContactInfoId = (int)command.Parameters["oContactInfoID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdContactInfo))
                    {
                        command.Parameters.Add(CreateParameter("pContactInfoID", item.ContactInfoId));
                        command.Parameters.Add(CreateParameter("pContactName", item.Name, 45));
                        command.Parameters.Add(CreateParameter("pHomePhone", item.HomePhone, 15));
                        command.Parameters.Add(CreateParameter("pCellPhone", item.CellPhone, 15));
                        command.Parameters.Add(CreateParameter("pEmail", item.Email, 45));
                        command.Parameters.Add(CreateParameter("pAddress1", item.Address1, 50));
                        command.Parameters.Add(CreateParameter("pAddress2", item.Address2, 50));
                        command.Parameters.Add(CreateParameter("pCity", item.City, 45));
                        command.Parameters.Add(CreateParameter("pState", item.State, 2));
                        command.Parameters.Add(CreateParameter("pZip", item.Zip, 10));

                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<ContactInfoDTO> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelContactInfo))
            {
                try
                {
                    foreach (ContactInfoDTO item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pContactInfoID", item.ContactInfoId));
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
