using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;
using Common.Base;

namespace Common.Mapper
{
    class PersonTypeMapper : MapperBase<PersonType>
    {
        private int _ordPersonTypeId;
        private int _ordPersonType;

        protected override PersonType Map(IDataRecord record)
        {
            try
            {
                PersonType e = new PersonType();
                e.PersonTypeId = (DBNull.Value == record[_ordPersonTypeId]) ? CommonBase.IntNullValue : (int)record[_ordPersonTypeId];
                e.Type = (DBNull.Value == record[_ordPersonType]) ? CommonBase.StringNullValue : (string)record[_ordPersonType];

                return e;
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        protected override void BindOrdinals(IDataReader reader)
        {
            _ordPersonTypeId = reader.GetOrdinal("PersonTypeID");
            _ordPersonType = reader.GetOrdinal("PersonType");
        }
    }
}
