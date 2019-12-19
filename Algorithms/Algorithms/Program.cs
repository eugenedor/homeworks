using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace Algorithms
{
    class Program
    {
        static void Main(string[] args)
        {
            var items = 8;
            Sort(items);
            Search(items);
            Console.ReadKey();
        }

        public static void Sort(int cntItem)
        {
            var arr0 = SetArr(cntItem);
            PrintArr(arr0, "BubbleSort");
            AlgorithmsSort.BubbleSort(arr0); 
            PrintArr(arr0);            

            var arr1 = SetArr(cntItem);
            PrintArr(arr1, "SelectionSort");
            AlgorithmsSort.SelectionSort(arr1);
            PrintArr(arr1); 

            var arr2 = SetArr(cntItem);
            PrintArr(arr2, "InsertionSort");
            AlgorithmsSort.InsertionSort(arr2);
            PrintArr(arr2);        

            var arr3 = SetArr(cntItem);
            PrintArr(arr3, "MergeSort");
            AlgorithmsSort.MergeSort(arr3, 0, cntItem-1);
            PrintArr(arr3);
        }

        public static void Search(int cntItem)
        {
            var arr4 = new int[] { 1, 2, 3, 5, 7, 12, 25, 37};
            PrintArr(arr4, "LinearSearch");
            var inx = AlgorithmsSearch.LinearSearch(arr4, 7);
            Console.WriteLine("After:");
            Console.WriteLine($"index = {inx}");
        }

        /// <summary>
        /// Рандомный массив из n элементов
        /// </summary>
        public static int[] SetArr(int n)
        {
            var arr = new int[n];
            Random ran = new Random();
            for (int i = 0; i < arr.Length; i++)
            {
                arr[i] = ran.Next(0, 99);
            }

            Thread.Sleep(100);
            return arr;
        }

        public static void PrintArr(int[] arr, string nameAlgo = "")
        {
            if (!string.IsNullOrEmpty(nameAlgo))
                PrintBefore(nameAlgo);
            else
                PrintAfter();

            for (int i = 0; i < arr.Length; i++)
            {
                Console.Write("{0} ", arr[i]);
            }

            Console.WriteLine();
            if (string.IsNullOrEmpty(nameAlgo))
                Console.WriteLine();     
        }

        public static void PrintBefore(string nameAlgorithm)
        {
            Console.WriteLine($"{nameAlgorithm}");
            Console.WriteLine("Before:");
        }

        public static void PrintAfter()
        {
            Console.WriteLine("After:");
        }
    }
}
