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
    public class UnitTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new UnitReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            UnitReader ciReader = new UnitReader();

            List<Unit> toSave = new List<Unit> {CreateTestRecord()};

            List<Unit> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].UnitId;

            results = ciReader.GetList();

            CleanUp(toSave[0]);

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new UnitReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new UnitReader();

            //Create the base object to modify.
            List<Unit> toSave = new List<Unit> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].UnitId);

            var toModify = results[0];
            toModify.UnitNumber = 9999;
            
            var modifyItems = new List<Unit> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].UnitId);

            CleanUp(modifyItems[0]);

            Assert.AreEqual(9999, results[0].UnitNumber);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new UnitReader();

            //Create the base object to modify.
            List<Unit> toSave = new List<Unit> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].UnitId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].UnitId);

            Assert.AreEqual(0, results.Count);

        }

        private Unit CreateTestRecord()
        {
            var reader = new UnitTypeReader();

            var unitType = reader.GetById(1);

            Unit newRecord = new Unit
            {
                UnitNumber = 0,
                UnitType = unitType.Single()
            };

            return newRecord;

        }

        private void CleanUp(Unit testObj)
        {
            UnitReader reader = new UnitReader();

            reader.Remove(new List<Unit>() {testObj});
        }
    }
}
