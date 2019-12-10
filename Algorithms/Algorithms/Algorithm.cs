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

        /// <summary>
        /// Сортировка выбором
        /// </summary>
        /// <param name="arr"></param>
        public static void SelectionSort(int[] arr)
        {
            for (int i = 0; i < arr.Length - 1; i++)
            {
                int min = i;
                for (int j = i + 1; j < arr.Length; j++)
                {
                    if (arr[j] < arr[min])
                    {
                        min = j;
                    }
                }
                int buf = arr[i];
                arr[i] = arr[min];
                arr[min] = buf;
            }
        }

        /// <summary>
        /// Сортировка вставкой
        /// </summary>
        /// <param name="arr"></param>
        public static void InsertionSort(int[] arr)
        {
            for (int i = 1; i < arr.Length - 1; i++)
            {
                int value = arr[i];
                int j = i - 1;
                while (j >= 0 && arr[j] > value)
                {
                    arr[j + 1] = arr[j];
                    j = j - 1;
                }
                arr[j + 1] = value;
            }
        }
    }
}
