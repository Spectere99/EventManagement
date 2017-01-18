using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class UnitRankDTO : DTOBase
    {
        public int UnitRankId { get; set; }
        public string Rank { get; set; }
        public UnitTypeDTO UnitType { get; set; }

        public UnitRankDTO()
        {
            UnitRankId = IntNullValue;
            Rank = StringNullValue;
            UnitType = new UnitTypeDTO();
            IsNew = true;
        }

        public UnitRankDTO(int unitRankId, string rank, UnitTypeDTO unitType)
        {
            UnitRankId = unitRankId;
            Rank = rank;
            UnitType = unitType;
            IsNew = UnitRankId.Equals(IntNullValue);
        }
    }
}
