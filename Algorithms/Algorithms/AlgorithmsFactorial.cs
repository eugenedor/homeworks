using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public static class AlgorithmsFactorial
    {
        //5! = 1 * 2 * 3 * 4 * 5 = 120

        /// <summary>
        /// Пример неправильного решения: вычисление факториала с помощью рекурсии
        /// </summary>
        public static int FactorialRecursion(int n)
        {
            if (n <= 1)
                return 1; //recursion bottom

            return n * FactorialRecursion(n - 1);
        }

        /// <summary>
        /// Пример правильного решения: использование итераций для вычисления факториала
        /// </summary>
        public static int FactorialCycle(int n)
        {
            var res = 1;
            for (var i = 2; i <= n; i++)
                res *= i;

            return res;
        }
    }
}
