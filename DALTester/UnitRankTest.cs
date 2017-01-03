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
    public class UnitRankTest
    {
        private int _testRecordId;
        private int _startTableCount;
        
        [TestMethod]
        public void TestSelect()
        {
            var reader = new UnitRankReader();

            var results = reader.GetList();

            _startTableCount = results.Count;

            Assert.IsTrue(results != null && _startTableCount > 0);
        }

        [TestMethod]
        public void TestInsert()
        {
            UnitRankReader ciReader = new UnitRankReader();

            List<UnitRank> toSave = new List<UnitRank> {CreateTestRecord()};

            List<UnitRank> results = ciReader.GetList();

            _startTableCount = results.Count;

            toSave = ciReader.Save(toSave);

            _testRecordId = toSave[0].UnitRankId;

            results = ciReader.GetList();

            Assert.AreEqual(_startTableCount + 1, results.Count);

        }

        [TestMethod]
        public void TestSelectById()
        {
            var reader = new UnitRankReader();

            var results = reader.GetById(1);

            Assert.AreEqual(1, results.Count);
        }

        [TestMethod]
        public void TestUpdate()
        {
            var ciReader = new UnitRankReader();

            //Create the base object to modify.
            List<UnitRank> toSave = new List<UnitRank> { CreateTestRecord() };

            toSave = ciReader.Save(toSave);

            var results = ciReader.GetById(toSave[0].UnitRankId);

            var toModify = results[0];
            toModify.Rank = "TEST-MOD";
            
            var modifyItems = new List<UnitRank> {toModify};

            //Should be doing an update and not an insert
            modifyItems = ciReader.Save(modifyItems);

            results = ciReader.GetById(modifyItems[0].UnitRankId);

            ciReader.Remove(modifyItems);

            Assert.AreEqual("TEST-MOD", results[0].Rank);

        }

        [TestMethod]
        public void TestRemove()
        {
            var reader = new UnitRankReader();

            //Create the base object to modify.
            List<UnitRank> toSave = new List<UnitRank> { CreateTestRecord() };

            toSave = reader.Save(toSave);

            var results = reader.GetById(toSave[0].UnitRankId);

            reader.Remove(results);

            results = reader.GetById(toSave[0].UnitRankId);

            Assert.AreEqual(0, results.Count);

        }

        private UnitRank CreateTestRecord()
        {
            var reader = new UnitTypeReader();

            var unitType = reader.GetById(1);

            UnitRank newRecord = new UnitRank
            {
                Rank = "TEST",
                UnitType = unitType.FirstOrDefault()
            };

            return newRecord;

        }
    }
}
