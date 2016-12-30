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
    public class EventTypeTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new EventTypeReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            EventTypeReader ciReader = new EventTypeReader();

            List<EventType> toSave = new List<EventType> {CreateTestRecord()};

            List<EventType> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].EventTypeId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new EventTypeReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new EventTypeReader();

            //Create the base object to modify.
            List<EventType> toSave = new List<EventType> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].EventTypeId);

            var toModify = results[0];
            toModify.Type = "TEST-MOD";
            
            var modifyItems = new List<EventType> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].EventTypeId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("TEST-MOD", results[0].Type);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new EventTypeReader();

            //Create the base object to modify.
            List<EventType> toSave = new List<EventType> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].EventTypeId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].EventTypeId);

            Assert.AreEqual(0, results.Count);

        }

        private EventType CreateTestRecord()
        {
            EventType newRecord = new EventType
            {
                Type = "TEST"
            };

            return newRecord;

        }
    }
}
