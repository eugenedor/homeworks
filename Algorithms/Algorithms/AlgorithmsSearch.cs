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
        public static int LinearSearch(int[] arr, int inxL, int inxR, int key)
        {
            inxL = Math.Max(0, inxL);
            inxR = Math.Min(arr.Length - 1, inxR);

            if (inxL > inxR)
                return -1;

            for (int i = inxL; i <= inxR; i++)
            {
                if (arr[i] == key)
                {
                    return i;
                }
            }
            return -1;
        }
    }
}
