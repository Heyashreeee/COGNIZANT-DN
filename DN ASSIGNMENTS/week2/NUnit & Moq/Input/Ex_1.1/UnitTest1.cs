using Exercise_1;
using NUnit.Framework;

namespace CalculatorTests
{
    [TestFixture] 
    public class CalculatorTests
    {
        private Calculator_Og _calculator;

        [SetUp] 
        public void SetUp()
        {
            _calculator = new Calculator_Og(); 
        }

        [TearDown] 
        public void TearDown()
        {
            _calculator = null; 
        }

        [Test] 
        [TestCase(2, 3, 5)] 
        [TestCase(-1, 1, 0)] 
        [TestCase(0, 0, 0)] 
        public void TestAddition(int a, int b, int expectedResult)
        {
            int actualResult = _calculator.Add(a, b); 
            Assert.That(actualResult, Is.EqualTo(expectedResult),
                $"Expected {expectedResult} but got {actualResult}");
        }
    }
}
