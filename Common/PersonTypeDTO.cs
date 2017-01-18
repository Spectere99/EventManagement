using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class PersonTypeDTO:DTOBase
    {
        public int PersonTypeId { get; set; }
        public string Type { set; get; }

        public PersonTypeDTO()
        {
            PersonTypeId = IntNullValue;
            Type = StringNullValue;
            IsNew = true;
        }
    }
}
