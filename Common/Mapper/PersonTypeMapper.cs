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
    class PersonTypeMapper : MapperBase<PersonTypeDTO>
    {
        private int _ordPersonTypeId;
        private int _ordPersonType;

        protected override PersonTypeDTO Map(IDataRecord record)
        {
            try
            {
                PersonTypeDTO e = new PersonTypeDTO();
                e.PersonTypeId = (DBNull.Value == record[_ordPersonTypeId]) ? CommonBase.IntNullValue : (int)record[_ordPersonTypeId];
                e.Type = (DBNull.Value == record[_ordPersonType]) ? CommonBase.StringNullValue : (string)record[_ordPersonType];
                e.IsNew = false;
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
