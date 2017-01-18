using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class EventTypeDTO : DTOBase
    {
        public int EventTypeId { get; set; }
        public string Type { get; set; }

        public EventTypeDTO()
        {
            EventTypeId = IntNullValue;
            Type = StringNullValue;
            IsNew = true;

        }
    }
}
