using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public static class AlgorithmsSort
    {
        /// <summary>
        /// Сортировка пузырьком
        /// </summary>
        /// <param name="arr">массив</param>
        public static void BubbleSort(int[] arr)
        {
            for (var i = 0; i < arr.Length - 1; i++)
            {
                for (var j = arr.Length - 1; j > i; j--)
                {
                    if (arr[j] >= arr[j - 1])
                        continue;

                    var buf = arr[j];
                    arr[j] = arr[j - 1];
                    arr[j - 1] = buf;
                }
            }
        }

        /// <summary>
        /// Сортировка выбором
        /// </summary>
        /// <param name="arr">массив</param>
        public static void SelectionSort(int[] arr)
        {
            for (var i = 0; i < arr.Length - 1; i++)
            {
                var min = i;
                for (var j = i + 1; j < arr.Length; j++)
                {
                    if (arr[j] < arr[min])
                    {
                        min = j;
                    }
                }
                var buf = arr[i];
                arr[i] = arr[min];
                arr[min] = buf;
            }
        }

        /// <summary>
        /// Сортировка вставкой
        /// </summary>
        /// <param name="arr">массив</param>
        public static void InsertionSort(int[] arr)
        {
            for (var i = 1; i < arr.Length; i++)
            {
                var key = arr[i];
                var j = i - 1;
                while (j >= 0 && arr[j] > key)
                {
                    arr[j + 1] = arr[j];
                    j -= 1; //j = j - 1;
                }
                arr[j + 1] = key;
            }
        }

        /// <summary>
        /// Сортировка слиянием
        /// </summary>
        /// <param name="arr">массив</param>
        /// <param name="p">индекс - начало массива</param>
        /// <param name="r">индекс - конец массива</param>
        public static void MergeSort(int[] arr, int p, int r)
        {
            if (p >= r)
                return;  //recursion bottom

            var q = (p + r) / 2;
            MergeSort(arr, p, q);
            MergeSort(arr, q + 1, r);
            Merge(arr, p, q, r);            
        }

        /// <summary>
        /// Слияние
        /// </summary>
        public static void Merge(int[] arr, int p, int q, int r)
        {
            int i, j;
            var n1 = q - p + 1;
            var n2 = r - q;
            int[] L = new int[n1];  //left array
            int[] R = new int[n2];  //right array
            for (i = 0; i < n1; i++)
            {
                L[i] = arr[p + i];
            }
            for (j = 0; j < n2; j++)
            {
                R[j] = arr[q + 1 + j];
            }
            i = 0;
            j = 0;
            int k = p;
            while (i < n1 && j < n2)
            {
                if (L[i] <= R[j])
                {
                    arr[k] = L[i];
                    i++;
                }
                else
                {
                    arr[k] = R[j];
                    j++;
                }
                k++;
            }
            while (i < n1)
            {
                arr[k] = L[i];
                i++;
                k++;
            }
            while (j < n2)
            {
                arr[k] = R[j];
                j++;
                k++;
            }
        }
    }
}
