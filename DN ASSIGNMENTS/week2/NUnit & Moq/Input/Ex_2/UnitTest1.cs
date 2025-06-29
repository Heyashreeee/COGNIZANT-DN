using Exercise_2;
using NUnit.Framework;
using System;

namespace Calc_2test
{
    [TestFixture]
    public class UnitTest1
    {
        private Calc_2 _calculator;

        [SetUp]
        public void SetUp()
        {
            _calculator = new Calc_2();
        }

        [TearDown]
        public void TearDown()
        {
            _calculator = null;
        }

        [Test]
        [TestCase(10, 5, 5)]
        [TestCase(0, 0, 0)]
        [TestCase(-5, -5, 0)]
        public void TestSubtraction(int a, int b, int expected)
        {
            var result = _calculator.Subtract(a, b);
            Assert.AreEqual(expected, result);
        }

        [Test]
        [TestCase(2, 3, 6)]
        [TestCase(0, 5, 0)]
        [TestCase(-2, -3, 6)]
        public void TestMultiplication(int a, int b, int expected)
        {
            var result = _calculator.Multiply(a, b);
            Assert.AreEqual(expected, result);
        }

        [Test]
        [TestCase(10, 2, 5)]
        [TestCase(-10, 2, -5)]
        [TestCase(0, 1, 0)]
        public void TestDivision(int a, int b, int expected)
        {
            var result = _calculator.Divide(a, b);
            Assert.AreEqual(expected, result);
        }

        [Test]
        public void TestDivisionByZero()
        {
            Assert.Throws<DivideByZeroException>(() => _calculator.Divide(10, 0));
        }

        [Test]
        public void TestAddAndClear()
        {
            _calculator.Add(10, 20);
            Assert.AreEqual(30, _calculator.GetResult);

            _calculator.AllClear();
            Assert.AreEqual(0, _calculator.GetResult);
        }
    }
}
