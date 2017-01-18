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
    public class UnitTypeReader : MySqlObjectReaderBase<UnitTypeDTO>
    {
        protected override MapperBase<UnitTypeDTO> GetMapper()
        {
            MapperBase<UnitTypeDTO> mapper = new UnitTypeMapper();
            return mapper;
        }

        public override List<UnitTypeDTO> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetUnitType))
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

        public override List<UnitTypeDTO> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetUnitTypeById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pUnitTypeID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<UnitTypeDTO> Save(List<UnitTypeDTO> objList)
        {
            foreach (UnitTypeDTO item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsUnitType))
                    {
                        command.Parameters.Add(CreateParameter("pUnitType", item.Type, 45));
                        command.Parameters.Add(CreateOutputParameter("oUnitTypeID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.UnitTypeId = (int)command.Parameters["oUnitTypeID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdUnitType))
                    {
                        command.Parameters.Add(CreateParameter("pUnitTypeID", item.UnitTypeId));
                        command.Parameters.Add(CreateParameter("pUnitType", item.Type, 45));
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<UnitTypeDTO> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelUnitType))
            {
                try
                {
                    foreach (UnitTypeDTO item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pUnitTypeID", item.UnitTypeId));
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
