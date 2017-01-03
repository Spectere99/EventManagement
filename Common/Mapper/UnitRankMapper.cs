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
    class UnitRankMapper : MapperBase<UnitRank>
    {
        private int _ordUnitRankId;
        private int _ordUnitRank;
        private int _ordUnitTypeId;

        protected override UnitRank Map(IDataRecord record)
        {
            try
            {
                UnitTypeReader unitTypeReader = new UnitTypeReader();

                UnitRank e = new UnitRank();
                e.UnitRankId = (DBNull.Value == record[_ordUnitRankId]) ? CommonBase.IntNullValue : (int)record[_ordUnitRankId];
                e.Rank = (DBNull.Value == record[_ordUnitRank]) ? CommonBase.StringNullValue : (string)record[_ordUnitRank];

                var unitTypeId = (DBNull.Value == record[_ordUnitTypeId]) ? CommonBase.IntNullValue : (int)record[_ordUnitTypeId];

                var unitType = unitTypeReader.GetById(unitTypeId);

                e.UnitType = unitType.FirstOrDefault();
                
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
            _ordUnitRankId = reader.GetOrdinal("UnitRankID");
            _ordUnitRank = reader.GetOrdinal("UnitRank");
            _ordUnitTypeId = reader.GetOrdinal("unittypes_UnitTypeID");
        }
    }
}
