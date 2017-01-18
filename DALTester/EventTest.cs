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
    public class EventTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new EventReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            EventReader ciReader = new EventReader();

            List<EventDTO> toSave = new List<EventDTO> {CreateTestRecord()};

            List<EventDTO> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].EventId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new EventReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new EventReader();

            //Create the base object to modify.
            List<EventDTO> toSave = new List<EventDTO> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].EventId);

            var toModify = results[0];
            toModify.Name = "TEST-MOD";
            
            var modifyItems = new List<EventDTO> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].EventId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("TEST-MOD", results[0].Name);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new EventReader();

            //Create the base object to modify.
            List<EventDTO> toSave = new List<EventDTO> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].EventId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].EventId);

            Assert.AreEqual(0, results.Count);

        }

        private EventDTO CreateTestRecord()
        {
            var reader = new EventTypeReader();
            var vnuReader = new VenueReader();

            var eventType = reader.GetList();
            var venue = vnuReader.GetList();

            EventDTO newRecord = new EventDTO
            {
                Venue =  venue.FirstOrDefault(),
                Name = "TEST-EVENT",
                Start = DateTime.Now.AddDays(1),
                End = DateTime.Now.AddDays(3),
                Description = "Test Event",
                LastUpdated = DateTime.MinValue,
                StaffPaymentRequired = false,
                RegistrationDeadline = DateTime.Now,
                RequiredStaffCount = 5,
                RequiredVolunteersCount = 10,
                EventType = eventType.FirstOrDefault()
            };

            return newRecord;

        }
    }
}
