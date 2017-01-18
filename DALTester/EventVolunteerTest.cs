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
    public class EventVolunteerTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new EventVolunteerReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            EventVolunteerReader ciReader = new EventVolunteerReader();

            List<EventVolunteerDTO> toSave = new List<EventVolunteerDTO> {CreateTestRecord()};

            List<EventVolunteerDTO> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].EventVolunteerId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new EventVolunteerReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new EventVolunteerReader();

            //Create the base object to modify.
            List<EventVolunteerDTO> toSave = new List<EventVolunteerDTO> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].EventVolunteerId);

            var toModify = results[0];
            toModify.Event.EventId = 2;
            
            var modifyItems = new List<EventVolunteerDTO> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].EventVolunteerId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual(2, results[0].Event.EventId);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new EventVolunteerReader();

            //Create the base object to modify.
            List<EventVolunteerDTO> toSave = new List<EventVolunteerDTO> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].EventVolunteerId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].EventVolunteerId);

            Assert.AreEqual(0, results.Count);

        }

        private EventVolunteerDTO CreateTestRecord()
        {
            var eventReader = new EventReader();
            var personReader = new PersonReader();

            var eventObj = eventReader.GetById(1);
            var person = personReader.GetById(1);

            EventVolunteerDTO newRecord = new EventVolunteerDTO
            {
                Event = eventObj.FirstOrDefault(),
                Person = person.FirstOrDefault()
            };

            return newRecord;

        }
    }
}
