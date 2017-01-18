using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;
using Common.Base;
using Common.Reader;

namespace Common.Mapper
{
    class UnitMapper : MapperBase<UnitDTO>
    {
        private int _ordUnitId;
        private int _ordUnitNumber;
        private int _ordUnitTypeId;

        protected override UnitDTO Map(IDataRecord record)
        {
            try
            {
                UnitTypeReader reader = new UnitTypeReader();

                UnitDTO e = new UnitDTO();
                e.UnitId = (DBNull.Value == record[_ordUnitId]) ? CommonBase.IntNullValue : (int)record[_ordUnitId];
                e.UnitNumber = (DBNull.Value == record[_ordUnitNumber]) ? CommonBase.IntNullValue : (int) record[_ordUnitNumber];
                
                var unitTypeId = (DBNull.Value == record[_ordUnitTypeId])
                    ? CommonBase.IntNullValue
                    : (int) record[_ordUnitTypeId];

                var unitType = reader.GetById(unitTypeId);

                e.UnitType = unitType.Single();
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
            _ordUnitId = reader.GetOrdinal("UnitID");
            _ordUnitNumber = reader.GetOrdinal("UnitNumber");
            _ordUnitTypeId = reader.GetOrdinal("unittypes_UnitTypeID");

        }
    }
}