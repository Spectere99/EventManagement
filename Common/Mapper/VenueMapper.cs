using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Abstract;
using Common.Base;
using Common.Reader;

namespace Common.Mapper
{
    class VenueMapper : MapperBase<VenueDTO>
    {
        private int _ordVenueId;
        private int _ordName;
        private int _ordContact;
        private int _ordContactInfoId;

        protected override VenueDTO Map(IDataRecord record)
        {
            try
            {
                ContactInfoReader reader = new ContactInfoReader();

                VenueDTO e = new VenueDTO();
                e.VenueId = (DBNull.Value == record[_ordVenueId]) ? CommonBase.IntNullValue : (int) record[_ordVenueId];
                e.Name = (DBNull.Value == record[_ordName]) ? CommonBase.StringNullValue : (string) record[_ordName];
                e.Contact = (DBNull.Value == record[_ordContact])
                    ? CommonBase.StringNullValue
                    : (string) record[_ordContact];
                var contactInfoId = (DBNull.Value == record[_ordContactInfoId])
                    ? CommonBase.IntNullValue
                    : (int) record[_ordContactInfoId];

                var contactInfo = reader.GetById(contactInfoId);

                e.ContactInfo = contactInfo.Single();
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
            _ordVenueId = reader.GetOrdinal("VenueID");
            _ordName = reader.GetOrdinal("Name");
            _ordContact = reader.GetOrdinal("Contact");
            _ordContactInfoId = reader.GetOrdinal("contactinfo_ContactInfoId");

        }
    }
}