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
    public class PersonTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new PersonReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            var ciReader = new PersonReader();

            var toSave = new List<PersonDTO> {CreateTestRecord()};

            var results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].PersonId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new PersonReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new PersonReader();

            //Create the base object to modify.
            var toSave = new List<PersonDTO> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].PersonId);

            var toModify = results[0];
            toModify.FirstName = "TEST-MOD";
            
            var modifyItems = new List<PersonDTO> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].PersonId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("TEST-MOD", results[0].FirstName);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new PersonReader();

            //Create the base object to modify.
            var toSave = new List<PersonDTO> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].PersonId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].PersonId);

            Assert.AreEqual(0, results.Count);

        }

        private PersonDTO CreateTestRecord()
        {
            var personTypeReader = new PersonTypeReader();
            var contactInfoReader = new ContactInfoReader();
            var personReader = new PersonReader();
            var unitRankReader = new UnitRankReader();
            var unitReader = new UnitReader();

            var personType = personTypeReader.GetList();
            var contactInfo = contactInfoReader.GetList();
            var parentPerson = personReader.GetList();
            var unitRank = unitRankReader.GetList();
            var unit = unitReader.GetList();

            var newRecord = new PersonDTO
            {
                FirstName = "TESTER",
                MiddleName = "J.",
                LastName = "TEST",
                ContactInfo = contactInfo.FirstOrDefault(),
                ParentPerson =  parentPerson.FirstOrDefault(),
                PersonType = personType.FirstOrDefault(),
                Rank = unitRank.FirstOrDefault(),
                Unit = unit.FirstOrDefault()
            };

            return newRecord;

        }
    }
}
