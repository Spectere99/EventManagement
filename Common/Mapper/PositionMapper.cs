using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;
using Common.Base;

namespace Common.Mapper
{
    class PositionMapper : MapperBase<PositionDTO>
    {
        private int _ordPositionId;
        private int _ordPosition;

        protected override PositionDTO Map(IDataRecord record)
        {
            try
            {
                PositionDTO e = new PositionDTO();
                e.PositionId = (DBNull.Value == record[_ordPositionId]) ? CommonBase.IntNullValue : (int)record[_ordPositionId];
                e.PositionName = (DBNull.Value == record[_ordPosition]) ? CommonBase.StringNullValue : (string)record[_ordPosition];
                e.IsNew = false;
                return e;
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        protected override void BindOrdinals(IDataReader reader)
        {
            _ordPositionId = reader.GetOrdinal("PositionID");
            _ordPosition = reader.GetOrdinal("Position");
        }
    }
}
