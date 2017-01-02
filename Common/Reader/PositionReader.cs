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
    public class PositionReader : MySqlObjectReaderBase<Position>
    {
        protected override MapperBase<Position> GetMapper()
        {
            MapperBase<Position> mapper = new PositionMapper();
            return mapper;
        }

        public override List<Position> GetList()
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetPosition))
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

        public override List<Position> GetById(int id)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.GetPositionById))
            {
                try
                {
                    command.Parameters.Add(CreateParameter("pPositionID", id));
                    var resultList = Execute(command);
                    return resultList;

                }
                catch (Exception)
                {

                    throw;
                }


            }
        }

        public override List<Position> Save(List<Position> objList)
        {
            foreach (Position item in objList)
            {
                if (item.IsNew) //Insert
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.InsPosition))
                    {
                        command.Parameters.Add(CreateParameter("pPosition", item.PositionName, 45));
                        command.Parameters.Add(CreateOutputParameter("oPositionID", MySqlDbType.Int32));

                        ExecuteNoReader(command);

                        //Update the item in the list with the newly updated ID value
                        item.PositionId = (int)command.Parameters["oPositionID"].Value;
                        item.IsNew = false;

                    }                    
                }
                else  //Update
                {
                    using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.UpdPosition))
                    {
                        command.Parameters.Add(CreateParameter("pPositionID", item.PositionId));
                        command.Parameters.Add(CreateParameter("pPosition", item.PositionName, 45));
                        
                        ExecuteNoReader(command);
                    }
                }
            }
            return objList;

        }

        public override void Remove(List<Position> objList)
        {
            using (MySqlCommand command = GetDbStoredProcCommand(DBQueries.DelPosition))
            {
                try
                {
                    foreach (Position item in objList)
                    {
                        command.Parameters.Add(CreateParameter("pPositionID", item.PositionId));
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
