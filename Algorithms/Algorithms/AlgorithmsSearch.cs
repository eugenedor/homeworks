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
        public static int LinearSearch(int[] arr, int key)
        {
            for (var i = 0; i < arr.Length; i++)
            {
                if (arr[i] == key)
                {
                    return i;
                }
            }
            return -1;
        }

        /// <summary>
        /// Бинарный поиск (рекурсия)
        /// </summary>
        public static int BinarySearch(int[] arr, int key, int p, int r)
        {
            //p = Math.Max(0, p);
            //r = Math.Min(arr.Length - 1, r);

            if (p > r)
                return -1; //item not found (recursion bottom)

            var q = (p + r) / 2;
            var val = arr[q];

            if (val == key)
                return q; //recursion bottom

            if (val > key)
                return BinarySearch(arr, key, p, q);     //left array
            else
                return BinarySearch(arr, key, q + 1, r); //right array
        }
    }
}
