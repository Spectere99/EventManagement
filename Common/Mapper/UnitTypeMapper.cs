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
    class UnitTypeMapper : MapperBase<UnitTypeDTO>
    {
        private int _ordUnitTypeId;
        private int _ordUnitType;

        protected override UnitTypeDTO Map(IDataRecord record)
        {
            try
            {
                UnitTypeDTO e = new UnitTypeDTO();
                e.UnitTypeId = (DBNull.Value == record[_ordUnitTypeId]) ? CommonBase.IntNullValue : (int)record[_ordUnitTypeId];
                e.Type = (DBNull.Value == record[_ordUnitType]) ? CommonBase.StringNullValue : (string)record[_ordUnitType];
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
            _ordUnitTypeId = reader.GetOrdinal("UnitTypeID");
            _ordUnitType = reader.GetOrdinal("UnitType");
        }
    }
}
