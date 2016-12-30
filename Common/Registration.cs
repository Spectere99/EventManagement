using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;

namespace Common
{
    public class Registration:DTOBase
    {
        public int RegistrationId { get; set; }
        public DateTime RegistrationDate { get; set; }
        public string ConfirmationNumber { get; set; }
        public DateTime LastUpdated { get; set; }
        public Event Event { get; set; }
        public Person Person { get; set; }

    }
}
