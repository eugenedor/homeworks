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
        public static int LinearSearch(int key, int[] arr, int p, int q)
        {
            int low = Math.Max(0, p);
            int high = Math.Min(arr.Length - 1, q);

            if (low > high)
                return -1;

            for (int i = low; i <= high; i++)
            {
                if (arr[i] == key)
                {
                    return i;
                }
            }
            return -1;
        }

        ///// <summary>
        ///// Бинарный поиск
        ///// </summary>
        //public static int BinarySearch(int key, int[] arr, int p, int q)
        //{

        //}
    }
}
