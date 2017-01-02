using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class Unit : DTOBase
    {
        public int UnitId { get; set; }
        public int UnitNumber { get; set; }
        public UnitType UnitType { get; set; }

        public Unit()
        {
            UnitId = IntNullValue;
            UnitNumber = IntNullValue;
            UnitType = new UnitType();
            IsNew = true;
        }

        public Unit(int unitId, int unitNumber, UnitType unitType)
        {
            UnitId = unitId;
            UnitNumber = unitNumber;
            UnitType = unitType;
            IsNew = UnitId.Equals(IntNullValue);
        }
    }
}
