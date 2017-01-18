﻿using System;
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
                        command.Parameters.Add(CreateParameter("pContactInfoID", item.ContactInfo.ContactInfoId));
                        if (item.ParentPerson != null)
                        {
                            command.Parameters.Add(CreateParameter("pParentPersonID", item.ParentPerson.PersonId));
                        }
                        else
                        {
                            command.Parameters.Add(CreateNullParamter("pParentPersonID", MySqlDbType.Int32));
                        }
                        command.Parameters.Add(CreateParameter("pPersonTypeID", item.PersonType.PersonTypeId));
                        command.Parameters.Add(CreateParameter("pUnitRankID", item.Rank.UnitRankId));
                        command.Parameters.Add(CreateParameter("pUnitID", item.Unit.UnitId));
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
                        command.Parameters.Add(CreateParameter("pContactInfoID", item.ContactInfo.ContactInfoId));
                        command.Parameters.Add(CreateParameter("pParentPersonID", item.ParentPerson.PersonId));
                        command.Parameters.Add(CreateParameter("pPersonTypeID", item.PersonType.PersonTypeId));
                        command.Parameters.Add(CreateParameter("pUnitRankID", item.Rank.UnitRankId));
                        command.Parameters.Add(CreateParameter("pUnitID", item.Unit.UnitId));
                        
                        
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
