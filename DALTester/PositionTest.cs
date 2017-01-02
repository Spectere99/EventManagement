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
    public class PositionTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new PositionReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            PositionReader ciReader = new PositionReader();

            List<Position> toSave = new List<Position> {CreateTestRecord()};

            List<Position> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].PositionId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new PositionReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new PositionReader();

            //Create the base object to modify.
            List<Position> toSave = new List<Position> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].PositionId);

            var toModify = results[0];
            toModify.PositionName = "TEST-MOD";
            
            var modifyItems = new List<Position> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].PositionId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("TEST-MOD", results[0].PositionName);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new PositionReader();

            //Create the base object to modify.
            List<Position> toSave = new List<Position> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].PositionId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].PositionId);

            Assert.AreEqual(0, results.Count);

        }

        private Position CreateTestRecord()
        {
            Position newRecord = new Position
            {
                PositionName = "TEST"
            };

            return newRecord;

        }
    }
}
