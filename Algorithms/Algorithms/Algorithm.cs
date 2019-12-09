using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public static class Algorithm
    {
        /// <summary>
        /// Сортировка пузырьком
        /// </summary>
        /// <param name="arr"></param>
        public static void BubbleSort(int[] arr)
        {
            for (int i = 0; i < arr.Length - 1; i++)
            {
                for (int j = arr.Length - 1; j > i; j--)
                {
                    if (arr[j] < arr[j - 1])
                    {
                        int buf = arr[j];
                        arr[j] = arr[j - 1];
                        arr[j - 1] = buf;
                    }
                }
            }
        }
    }
}
