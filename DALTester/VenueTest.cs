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
    public class VenueTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new VenueReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            VenueReader ciReader = new VenueReader();

            List<VenueDTO> toSave = new List<VenueDTO> {CreateTestRecord()};

            List<VenueDTO> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].VenueId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new VenueReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new VenueReader();

            //Create the base object to modify.
            List<VenueDTO> toSave = new List<VenueDTO> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].VenueId);

            var toModify = results[0];
            toModify.Name = "TEST-MOD";
            
            var modifyItems = new List<VenueDTO> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].VenueId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("TEST-MOD", results[0].Name);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new VenueReader();

            //Create the base object to modify.
            List<VenueDTO> toSave = new List<VenueDTO> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].VenueId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].VenueId);

            Assert.AreEqual(0, results.Count);

        }

        private VenueDTO CreateTestRecord()
        {
            var reader = new ContactInfoReader();

            var contactInfo = reader.GetById(1);

            VenueDTO newRecord = new VenueDTO
            {
                Name = "TEST",
                Contact = "CONTACT_TEST",
                ContactInfo = contactInfo.Single()
            };

            return newRecord;

        }
    }
}
