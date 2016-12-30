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
    class ContactInfoMapper : MapperBase<ContactInfo>
    {
        private int _ordContactInfoId;
        private int _ordContactName;
        private int _ordHomePhone;
        private int _ordBusinessPhone;
        private int _ordCellPhone;
        private int _ordEmail;
        private int _ordAddress1;
        private int _ordAddress2;
        private int _ordCity;
        private int _ordState;
        private int _ordZip;

        protected override ContactInfo Map(IDataRecord record)
        {
            try
            {
                ContactInfo c = new ContactInfo();
                c.ContactInfoId = (DBNull.Value == record[_ordContactInfoId]) ? CommonBase.IntNullValue : (int) record[_ordContactInfoId];
                c.Name = (DBNull.Value == record[_ordContactName]) ? CommonBase.StringNullValue : (string)record[_ordContactName];
                c.HomePhone = (DBNull.Value == record[_ordHomePhone]) ? CommonBase.StringNullValue : (string)record[_ordHomePhone];
                c.BusinessPhone = (DBNull.Value == record[_ordBusinessPhone]) ? CommonBase.StringNullValue : (string)record[_ordBusinessPhone];
                c.CellPhone = (DBNull.Value == record[_ordCellPhone]) ? CommonBase.StringNullValue : (string)record[_ordCellPhone];
                c.Email = (DBNull.Value == record[_ordEmail]) ? CommonBase.StringNullValue : (string)record[_ordEmail];
                c.Address1 = (DBNull.Value == record[_ordAddress1]) ? CommonBase.StringNullValue : (string)record[_ordAddress1];
                c.Address2 = (DBNull.Value == record[_ordAddress2]) ? CommonBase.StringNullValue : (string)record[_ordAddress2];
                c.City = (DBNull.Value == record[_ordCity]) ? CommonBase.StringNullValue : (string)record[_ordCity];
                c.State = (DBNull.Value == record[_ordState]) ? CommonBase.StringNullValue : (string)record[_ordState];
                c.Zip = (DBNull.Value == record[_ordZip]) ? CommonBase.StringNullValue : (string)record[_ordZip];
                c.IsNew = false;
                return c;
            }
            catch (Exception)
            {
                
                throw;
            }
        }

        protected override void BindOrdinals(IDataReader reader)
        {
            _ordContactInfoId = reader.GetOrdinal("ContactInfoID");
            _ordContactName = reader.GetOrdinal("ContactName");
            _ordHomePhone = reader.GetOrdinal("HomePhone");
            _ordBusinessPhone = reader.GetOrdinal("BusinessPhone");
            _ordCellPhone = reader.GetOrdinal("CellPhone");
            _ordEmail = reader.GetOrdinal("Email");
            _ordAddress1 = reader.GetOrdinal("Address1");
            _ordAddress2 = reader.GetOrdinal("Address2");
            _ordCity = reader.GetOrdinal("City");
            _ordState = reader.GetOrdinal("State");
            _ordZip = reader.GetOrdinal("Zip");
        }
    }
}
