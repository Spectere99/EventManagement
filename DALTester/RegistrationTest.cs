using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using Common;
using Common.Reader;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace DALTester
{
    [TestClass]
    public class RegistrationTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new RegistrationReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            var ciReader = new RegistrationReader();

            var toSave = new List<RegistrationDTO> {CreateTestRecord()};

            var results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].RegistrationId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new RegistrationReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new RegistrationReader();

            //Create the base object to modify.
            var toSave = new List<RegistrationDTO> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].RegistrationId);

            var toModify = results[0];
            toModify.ConfirmationNumber = "ABCD-1234";
            
            var modifyItems = new List<RegistrationDTO> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].RegistrationId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("ABCD-1234", results[0].ConfirmationNumber);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new RegistrationReader();

            //Create the base object to modify.
            var toSave = new List<RegistrationDTO> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].RegistrationId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].RegistrationId);

            Assert.AreEqual(0, results.Count);

        }

        private RegistrationDTO CreateTestRecord()
        {
            var eventReader = new EventReader();
            var personReader = new PersonReader();

            var eventObj = eventReader.GetById(1);
            var person = personReader.GetById(1);
            
            var newRecord = new RegistrationDTO
            {
                RegistrationDate = DateTime.Now,
                ConfirmationNumber = "ABCD",
                LastUpdated = DateTime.Now,
                Event = eventObj.FirstOrDefault(),
                Person = person.FirstOrDefault()
            };

            return newRecord;

        }
    }
}
