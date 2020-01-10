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
        public static int LinearSearch(int[] arr, int key, int p, int q)
        {
            var low = Math.Max(0, p);
            var high = Math.Min(arr.Length - 1, q);

            if (low > high)
                return -1;

            for (var i = low; i <= high; i++)
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
            var low = Math.Max(0, p);
            var high = Math.Min(arr.Length - 1, r);

            if (low > high)
                return -1; //item not found (recursion bottom)

            var middle = (low + high) / 2;
            var val = arr[middle];

            if (val == key)
                return middle; //recursion bottom

            if (val > key)
                return BinarySearch(arr, key, low, middle);  //left array
            else
                return BinarySearch(arr, key, middle + 1, high); //right array
        }
    }
}
