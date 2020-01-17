using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public static class AlgorithmsFibonacci
    {
        //0 (0-й член), 1 (1-й член), 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ....

        public static int FibonacciRecursion(int n)
        {
            if (n == 0 || n == 1)
                return n;

            return FibonacciRecursion(n - 1) + FibonacciRecursion(n - 2);
            
        }

        public static int FibonacciCycle(int n)
        {
            var a = 0;
            var b = 1;
            for (var i = 0; i < n; i++)
            {
                b = a + b;
                a = b - a;

                //1
                //var tmp = b;
                //b += a;
                //a = tmp;

                //2
                //var tmp = a;
                //a = b;
                //b += tmp;
            }

            return a;
        }
    }
}
