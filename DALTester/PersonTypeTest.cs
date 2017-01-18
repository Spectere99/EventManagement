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
    public class PersonTypeTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new PersonTypeReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            PersonTypeReader ciReader = new PersonTypeReader();

            List<PersonTypeDTO> toSave = new List<PersonTypeDTO> {CreateTestRecord()};

            List<PersonTypeDTO> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].PersonTypeId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new PersonTypeReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new PersonTypeReader();

            //Create the base object to modify.
            List<PersonTypeDTO> toSave = new List<PersonTypeDTO> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].PersonTypeId);

            var toModify = results[0];
            toModify.Type = "TEST-MOD";
            
            var modifyItems = new List<PersonTypeDTO> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].PersonTypeId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("TEST-MOD", results[0].Type);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new PersonTypeReader();

            //Create the base object to modify.
            List<PersonTypeDTO> toSave = new List<PersonTypeDTO> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].PersonTypeId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].PersonTypeId);

            Assert.AreEqual(0, results.Count);

        }

        private PersonTypeDTO CreateTestRecord()
        {
            PersonTypeDTO newRecord = new PersonTypeDTO
            {
                Type = "TEST"
            };

            return newRecord;

        }
    }
}
