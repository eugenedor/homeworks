using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public static class AlgorithmsReverse
    {
        /// <summary>
        /// Реверс массива
        /// </summary>
        public static void Reverse(int[] arr)
        {
            var n = arr.Length / 2;
            var j = arr.Length - 1;
            for (var i = 0; i < n; i++)
            {
                var buf = arr[i];
                arr[i] = arr[j - i];
                arr[j - i] = buf;
            }
        }
    }
}
