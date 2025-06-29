using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Exercise_2
{
    public class Calc_2
    {
        private int _result;

        public int GetResult => _result;

        public int Add(int a, int b)
        {
            _result = a + b;
            return _result;
        }

        public int Subtract(int a, int b)
        {
            _result = a - b;
            return _result;
        }

        public int Multiply(int a, int b)
        {
            _result = a * b;
            return _result;
        }

        public int Divide(int a, int b)
        {
            if (b == 0)
                throw new DivideByZeroException("Division by zero is not allowed.");
            _result = a / b;
            return _result;
        }

        public void AllClear()
        {
            _result = 0;
        }
    }
}
