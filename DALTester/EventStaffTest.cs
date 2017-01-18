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
    public class EventStaffTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new EventStaffReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            EventStaffReader ciReader = new EventStaffReader();

            List<EventStaffDTO> toSave = new List<EventStaffDTO> {CreateTestRecord()};

            List<EventStaffDTO> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].EventStaffId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new EventStaffReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new EventStaffReader();

            //Create the base object to modify.
            List<EventStaffDTO> toSave = new List<EventStaffDTO> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].EventStaffId);

            var toModify = results[0];
            toModify.Event.EventId = 2;
            
            var modifyItems = new List<EventStaffDTO> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].EventStaffId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual(2, results[0].Event.EventId);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new EventStaffReader();

            //Create the base object to modify.
            List<EventStaffDTO> toSave = new List<EventStaffDTO> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].EventStaffId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].EventStaffId);

            Assert.AreEqual(0, results.Count);

        }

        private EventStaffDTO CreateTestRecord()
        {
            var eventReader = new EventReader();
            var positionReader = new PositionReader();
            var personReader = new PersonReader();

            var eventObj = eventReader.GetById(1);
            var position = positionReader.GetById(1);
            var person = personReader.GetById(1);

            EventStaffDTO newRecord = new EventStaffDTO
            {
                Position = position.FirstOrDefault(),
                Event = eventObj.FirstOrDefault(),
                Person = person.FirstOrDefault()
            };

            return newRecord;

        }
    }
}
