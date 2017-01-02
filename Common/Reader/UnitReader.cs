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
    public class UnitReader : MySqlObjectReaderBase<Unit>
    {
        protected override MapperBase<Unit> GetMapper()
        {
            MapperBase<Unit> mapper = new UnitMapper();
            return mapper;
        }

        public override List<Unit> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetUnits))
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

        public override List<Unit> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetUnitById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pUnitID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<Unit> Save(List<Unit> objList)
        {
            foreach (Unit item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsUnit))
                    {
                        command.Parameters.Add(CreateParameter("pUnitNumber", item.UnitNumber));
                        command.Parameters.Add(CreateParameter("pUnitTypeId", item.UnitType.UnitTypeId));
                        command.Parameters.Add(CreateOutputParameter("oUnitID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.UnitId = (int)command.Parameters["oUnitID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdUnit))
                    {
                        command.Parameters.Add(CreateParameter("pUnitID", item.UnitId));
                        command.Parameters.Add(CreateParameter("pUnitNumber", item.UnitNumber));
                        command.Parameters.Add(CreateParameter("pUnitTypeId", item.UnitType.UnitTypeId));
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<Unit> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelUnit))
            {
                try
                {
                    foreach (Unit item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pUnitID", item.UnitId));
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
