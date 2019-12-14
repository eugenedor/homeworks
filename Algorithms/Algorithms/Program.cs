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
            var items = 10;
            Sort(items);
        }

        public static void Sort(int cntItem)
        {
            //BubbleSort
            var arr0 = SetArr(cntItem);
            Console.WriteLine("Сортировка пузырьком:");
            Console.WriteLine("До:");
            PrintArr(arr0);
            AlgorithmsSort.BubbleSort(arr0);
            Console.WriteLine("После:");
            PrintArr(arr0);
            Console.WriteLine();

            //SelectionSort
            var arr1 = SetArr(cntItem);
            Console.WriteLine("Сортировка выборкой:");
            Console.WriteLine("До:");
            PrintArr(arr1);
            AlgorithmsSort.SelectionSort(arr1);
            Console.WriteLine("После:");
            PrintArr(arr1);
            Console.WriteLine();

            //InsertionSort
            var arr2 = SetArr(cntItem);
            Console.WriteLine("Сортировка вставкой:");
            Console.WriteLine("До:");
            PrintArr(arr2);
            AlgorithmsSort.SelectionSort(arr2);
            Console.WriteLine("После:");
            PrintArr(arr2);
            Console.WriteLine();

            Console.ReadKey();
        }

        public static int[] SetArr(int c)
        {
            var arr = new int[c];
            Random ran = new Random();
            for (int i = 0; i < arr.Length; i++)
            {
                arr[i] = ran.Next(0, 99);
            }

            Thread.Sleep(100);
            return arr;
        }

        public static void PrintArr(int[] arr)
        {
            for (int i = 0; i < arr.Length; i++)
            {
                Console.Write("{0} ", arr[i]);
            }
            Console.WriteLine();
        }
    }
}
