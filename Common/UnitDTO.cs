using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class UnitDTO : DTOBase
    {
        public int UnitId { get; set; }
        public int UnitNumber { get; set; }
        public UnitTypeDTO UnitType { get; set; }

        public UnitDTO()
        {
            UnitId = IntNullValue;
            UnitNumber = IntNullValue;
            UnitType = new UnitTypeDTO();
            IsNew = true;
        }

        public UnitDTO(int unitId, int unitNumber, UnitTypeDTO unitType)
        {
            UnitId = unitId;
            UnitNumber = unitNumber;
            UnitType = unitType;
            IsNew = UnitId.Equals(IntNullValue);
        }
    }
}
