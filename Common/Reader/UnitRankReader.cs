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
    public class UnitRankReader : MySqlObjectReaderBase<UnitRank>
    {
        protected override MapperBase<UnitRank> GetMapper()
        {
            MapperBase<UnitRank> mapper = new UnitRankMapper();
            return mapper;
        }

        public override List<UnitRank> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetUnitRanks))
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

        public override List<UnitRank> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetUnitRankById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pUnitRankID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<UnitRank> Save(List<UnitRank> objList)
        {
            foreach (UnitRank item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsUnitRank))
                    {
                        command.Parameters.Add(CreateParameter("pUnitRank", item.Rank, 45));
                        command.Parameters.Add(CreateParameter("pUnitTypeID", item.UnitType.UnitTypeId));
                        command.Parameters.Add(CreateOutputParameter("oUnitRankID", MySqlDbType.Int32));
                        
                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.UnitRankId = (int)command.Parameters["oUnitRankID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdUnitRank))
                    {
                        command.Parameters.Add(CreateParameter("pUnitRankID", item.UnitRankId));
                        command.Parameters.Add(CreateParameter("pUnitRank", item.Rank, 45));
                        command.Parameters.Add(CreateParameter("pUnitTypeID", item.UnitType.UnitTypeId));
                        
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<UnitRank> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelUnitRank))
            {
                try
                {
                    foreach (UnitRank item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pUnitRankID", item.UnitRankId));
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
