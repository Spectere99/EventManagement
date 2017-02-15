using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Linq;
using Common;
using Common.Reader;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace DALTester
{
    [TestClass]
    public class ContactInfoTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var ciReader = new ContactInfoReader();

            var results = ciReader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            ContactInfoReader ciReader = new ContactInfoReader();

            List<ContactInfoDTO> toSave = new List<ContactInfoDTO> {CreateTestContactRecord()};

            List<ContactInfoDTO> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].ContactInfoId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var ciReader = new ContactInfoReader();

            var results = ciReader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new ContactInfoReader();

            //Create the base object to modify.
            List<ContactInfoDTO> toSave = new List<ContactInfoDTO> { CreateTestContactRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].ContactInfoId);

            var toModify = results[0];
            toModify.HomePhone = "(999)999-9999";
            
            var modifyItems = new List<ContactInfoDTO> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].ContactInfoId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("(999)999-9999", results[0].HomePhone);

        }

        [TestMethod]
        public void TestRemove()
        {
            var ciReader = new ContactInfoReader();

            //Create the base object to modify.
            List<ContactInfoDTO> toSave = new List<ContactInfoDTO> { CreateTestContactRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].ContactInfoId);

            ciReader.Remove(results);

            results = ciReader.GetById(toSave[0].ContactInfoId);

            Assert.AreEqual(0, results.Count);

        }

        private ContactInfoDTO CreateTestContactRecord()
        {
            ContactInfoDTO newContactInfo = new ContactInfoDTO
            {
                Name = "John Doe",
                Address1 = "123 This St.",
                Address2 = "Suite 000",
                Email = "jdoe@email.com",
                City = "This Town",
                State = "SC",
                Zip = "12345",
                HomePhone = "(000)000-0000",
                CellPhone = "(000)000-0000"
            };

            return newContactInfo;

        }
    }
}
