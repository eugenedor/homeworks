using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace Algorithms
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            var items = 8;
            Sort(items);
            Search();
            Console.ReadKey();
        }

        public static void Sort(int cntItem)
        {
            var arr0 = SetArr(cntItem);
            Print.PrintArr(arr0, "BubbleSort");
            AlgorithmsSort.BubbleSort(arr0);
            Print.PrintArr(arr0);            

            var arr1 = SetArr(cntItem);
            Print.PrintArr(arr1, "SelectionSort");
            AlgorithmsSort.SelectionSort(arr1);
            Print.PrintArr(arr1); 

            var arr2 = SetArr(cntItem);
            Print.PrintArr(arr2, "InsertionSort");
            AlgorithmsSort.InsertionSort(arr2);
            Print.PrintArr(arr2);        

            var arr3 = SetArr(cntItem);
            Print.PrintArr(arr3, "MergeSort");
            AlgorithmsSort.MergeSort(arr3, 0, cntItem-1);
            Print.PrintArr(arr3);
        }

        public static void Search()
        {
            var arr4 = new int[] { 1, 2, 3, 5, 7, 12, 25, 37};
            int val4 = 7, inxL4 = 3, inxR4 = 6;
            Print.PrintArr(arr4, "LinearSearch");
            Print.PrintShort(arr4, inxL4, inxR4);
            var inx4 = AlgorithmsSearch.LinearSearch(arr4, val4, inxL4, inxR4);
            Console.WriteLine("After:");
            Console.WriteLine($"Value = {val4}; indexLeft = {inxL4}; indexRight = {inxR4}; indexSearch = {inx4}");
            Console.WriteLine();

            var arr5 = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
            int val5 = 6, inxL5 = 1, inxR5 = 7;
            Print.PrintArr(arr5, "BinarySearch");
            Print.PrintShort(arr5, inxL5, inxR5);
            var inx5 = AlgorithmsSearch.BinarySearch(arr5, val5, inxL5, inxR5);
            Console.WriteLine("After:");
            Console.WriteLine($"Value = {val5}; indexLeft = {inxL5}; indexRight = {inxR5}; indexSearch = {inx5}");
            Console.WriteLine();
        }

        /// <summary>
        /// Рандомный массив из n элементов
        /// </summary>
        public static int[] SetArr(int n)
        {
            var arr = new int[n];
            var ran = new Random();
            for (var i = 0; i < arr.Length; i++)
            {
                arr[i] = ran.Next(0, 99);
            }

            Thread.Sleep(100);
            return arr;
        }
    }
}
