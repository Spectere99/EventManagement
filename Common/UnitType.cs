using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class UnitType : DTOBase
    {
        public int UnitTypeId { get; set; }
        public string Type { get; set; }

        public UnitType()
        {
            UnitTypeId = IntNullValue;
            Type = StringNullValue;
            IsNew = true;
        }
    }
}
