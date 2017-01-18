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
    public class UnitTypeTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new UnitTypeReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            UnitTypeReader ciReader = new UnitTypeReader();

            List<UnitTypeDTO> toSave = new List<UnitTypeDTO> {CreateTestRecord()};

            List<UnitTypeDTO> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].UnitTypeId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new UnitTypeReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new UnitTypeReader();

            //Create the base object to modify.
            List<UnitTypeDTO> toSave = new List<UnitTypeDTO> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].UnitTypeId);

            var toModify = results[0];
            toModify.Type = "TEST-MOD";
            
            var modifyItems = new List<UnitTypeDTO> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].UnitTypeId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("TEST-MOD", results[0].Type);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new UnitTypeReader();

            //Create the base object to modify.
            List<UnitTypeDTO> toSave = new List<UnitTypeDTO> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].UnitTypeId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].UnitTypeId);

            Assert.AreEqual(0, results.Count);

        }

        private UnitTypeDTO CreateTestRecord()
        {
            UnitTypeDTO newRecord = new UnitTypeDTO
            {
                Type = "TEST"
            };

            return newRecord;

        }
    }
}
