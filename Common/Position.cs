using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class Position : DTOBase
    {
        public int PositionId { get; set; }

        public string PositionName { get; set; }

        public Position()
        {
            PositionId = IntNullValue;
            PositionName = StringNullValue;
            IsNew = true;
        }
    }
}
