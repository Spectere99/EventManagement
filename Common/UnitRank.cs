using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class UnitRank : DTOBase
    {
        public int UnitRankId { get; set; }
        public string Rank { get; set; }
        public UnitType UnitType { get; set; }

        public UnitRank()
        {
            UnitRankId = IntNullValue;
            Rank = StringNullValue;
            UnitType = new UnitType();
            IsNew = true;
        }

        public UnitRank(int unitRankId, string rank, UnitType unitType)
        {
            UnitRankId = unitRankId;
            Rank = rank;
            UnitType = unitType;
            IsNew = UnitRankId.Equals(IntNullValue);
        }
    }
}
