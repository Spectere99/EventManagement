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
    public class ReservationTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new ReservationReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            var ciReader = new ReservationReader();

            var toSave = new List<Reservation> {CreateTestRecord()};

            var results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].ReservationId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new ReservationReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new ReservationReader();

            //Create the base object to modify.
            var toSave = new List<Reservation> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].ReservationId);

            var toModify = results[0];
            toModify.ReservationDate = DateTime.Today.Date;
            
            var modifyItems = new List<Reservation> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].ReservationId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual(DateTime.Today.Date, results[0].ReservationDate);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new ReservationReader();

            //Create the base object to modify.
            var toSave = new List<Reservation> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].ReservationId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].ReservationId);

            Assert.AreEqual(0, results.Count);

        }

        private Reservation CreateTestRecord()
        {
            var eventReader = new EventReader();
            var personReader = new PersonReader();

            var eventObj = eventReader.GetById(1);
            var person = personReader.GetById(1);
            
            var newRecord = new Reservation
            {
                ReservationDate = DateTime.Now,
                LastUpdated = DateTime.Now,
                Event = eventObj.FirstOrDefault(),
                Person = person.FirstOrDefault()
            };

            return newRecord;

        }
    }
}
