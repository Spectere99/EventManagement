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
    public class PersonReader : MySqlObjectReaderBase<PersonDTO>
    {
        protected override MapperBase<PersonDTO> GetMapper()
        {
            MapperBase<PersonDTO> mapper = new PersonMapper();
            return mapper;
        }

        public override List<PersonDTO> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetPersons))
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

        public override List<PersonDTO> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetPersonById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pPersonID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public List<PersonDTO> GetByUserId(string userId)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetPersonByUserId))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pUserID", userId, 45));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public List<PersonDTO> GetByParentId(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetPersonByParentId))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pParentID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<PersonDTO> Save(List<PersonDTO> objList)
        {
            foreach (PersonDTO item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsPerson))
                    {
                        command.Parameters.Add(CreateParameter("pFirstName", item.FirstName, 45));
                        command.Parameters.Add(CreateParameter("pMiddleName", item.MiddleName, 45));
                        command.Parameters.Add(CreateParameter("pLastName", item.LastName, 45));
                        command.Parameters.Add(item.ContactInfo != null
                            ? CreateParameter("pContactInfoID", item.ContactInfo.ContactInfoId)
                            : CreateNullParamter("pContactInfoID", MySqlDbType.Int32));
                        command.Parameters.Add(item.ParentPerson != null
                            ? CreateParameter("pParentPersonID", item.ParentPerson.PersonId)
                            : CreateNullParamter("pParentPersonID", MySqlDbType.Int32));
                        command.Parameters.Add(item.PersonType == null
                            ? CreateParameter("pPersonTypeID", -1)
                            : CreateParameter("pPersonTypeID", item.PersonType.PersonTypeId));
                        command.Parameters.Add(item.Rank == null
                            ? CreateParameter("pUnitRankID", -1)
                            : CreateParameter("pUnitRankID", item.Rank.UnitRankId));
                        command.Parameters.Add(item.Unit == null
                            ? CreateParameter("pUnitID", -1)
                            : CreateParameter("pUnitID", item.Unit.UnitId));
                        command.Parameters.Add(CreateParameter("pUserID", item.UserId, 45));
                        command.Parameters.Add(CreateParameter("pNotes", item.Notes, 4000));
                        command.Parameters.Add(CreateOutputParameter("oPersonID", MySqlDbType.Int32));
                        

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.PersonId = (int)command.Parameters["oPersonID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdPerson))
                    {
                        command.Parameters.Add(CreateParameter("pPersonID", item.PersonId));
                        command.Parameters.Add(CreateParameter("pFirstName", item.FirstName, 45));
                        command.Parameters.Add(CreateParameter("pMiddleName", item.MiddleName, 45));
                        command.Parameters.Add(CreateParameter("pLastName", item.LastName, 45));
                        command.Parameters.Add(item.ContactInfo != null
                            ? CreateParameter("pContactInfoID", item.ContactInfo.ContactInfoId)
                            : CreateNullParamter("pContactInfoID", MySqlDbType.Int32));
                        command.Parameters.Add(item.ParentPerson != null
                            ? CreateParameter("pParentPersonID", item.ParentPerson.PersonId)
                            : CreateNullParamter("pParentPersonID", MySqlDbType.Int32));
                        command.Parameters.Add(item.PersonType == null
                            ? CreateParameter("pPersonTypeID", -1)
                            : CreateParameter("pPersonTypeID", item.PersonType.PersonTypeId));
                        command.Parameters.Add(item.Rank == null
                            ? CreateParameter("pUnitRankID", -1)
                            : CreateParameter("pUnitRankID", item.Rank.UnitRankId));
                        command.Parameters.Add(item.Unit == null
                            ? CreateParameter("pUnitID", -1)
                            : CreateParameter("pUnitID", item.Unit.UnitId));
                        command.Parameters.Add(CreateParameter("pUserID", item.UserId, 45));
                        command.Parameters.Add(CreateParameter("pNotes", item.Notes, 4000));
                        
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<PersonDTO> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelPerson))
            {
                try
                {
                    foreach (PersonDTO item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pPersonID", item.PersonId));
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
