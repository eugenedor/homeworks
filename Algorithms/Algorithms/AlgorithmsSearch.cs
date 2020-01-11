using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public static class AlgorithmsSearch
    {
        /// <summary>
        /// Линейный поиск
        /// </summary>
        public static int LinearSearch(int[] arr, int val)
        {
            for (var i = 0; i < arr.Length; i++)
            {
                if (arr[i] == val)
                {
                    return i;
                }
            }
            return -1;
        }

        /// <summary>
        /// Бинарный поиск (рекурсия)
        /// </summary>
        public static int BinarySearchRecursion(int[] arr, int val, int p, int r)
        {
            //p = Math.Max(0, p);
            //r = Math.Min(arr.Length - 1, r);

            if (p > r)
                return -1; //item not found (recursion bottom)

            var q = (p + r) / 2;
            var mid = arr[q];

            if (val == mid)
                return q; //recursion bottom

            if (val < mid)
                return BinarySearchRecursion(arr, val, p, q);     //left array
            else
                return BinarySearchRecursion(arr, val, q + 1, r); //right array
        }

        /// <summary>
        /// Бинарный поиск (цикл)
        /// </summary>
        public static int BinarySearchCycle(int[] arr, int val, int p, int r)
        {
            if (p > r)
                return -1; //item not found

            while (p <= r)
            {
                var q = (p + r) / 2;
                var mid = arr[q];

                if (val == mid)
                    return q;

                if (val < mid)
                    r = q - 1; //narrowing on the right side
                else
                    p = q + 1; //narrowing on the left side
            }

            return -1;
        }
    }
}
