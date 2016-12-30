using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class Unit:DTOBase
    {
        public int UnitId { get; set; }
        public string UnitNumber { get; set; }
        public UnitType UnitType { get; set; }
    }
}
