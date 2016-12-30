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
    public class PersonTypeReader : MySqlObjectReaderBase<PersonType>
    {
        protected override MapperBase<PersonType> GetMapper()
        {
            MapperBase<PersonType> mapper = new PersonTypeMapper();
            return mapper;
        }

        public override List<PersonType> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetPersonType))
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

        public override List<PersonType> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetPersonTypeById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pPersonTypeID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<PersonType> Save(List<PersonType> objList)
        {
            foreach (PersonType item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsPersonType))
                    {
                        command.Parameters.Add(CreateParameter("pPersonType", item.Type, 45));
                        command.Parameters.Add(CreateOutputParameter("oPersonTypeID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.PersonTypeId = (int)command.Parameters["oPersonTypeID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdPersonType))
                    {
                        command.Parameters.Add(CreateParameter("pPersonTypeID", item.PersonTypeId));
                        command.Parameters.Add(CreateParameter("pPersonType", item.Type, 45));
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<PersonType> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelPersonType))
            {
                try
                {
                    foreach (PersonType item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pPersonTypeID", item.PersonTypeId));
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
