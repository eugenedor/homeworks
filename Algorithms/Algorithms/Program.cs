using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    class Program
    {
        static void Main(string[] args)
        {
            var cntItem = 10;

            //BubbleSort
            var array0 = SetArr(cntItem);
            Console.WriteLine("Сортировка пузырьком:");
            Console.WriteLine("До:");
            PrintArr(array0);
            Algorithm.BubbleSort(array0);
            Console.WriteLine("После:");
            PrintArr(array0);
            Console.WriteLine();

            Console.ReadKey();
        }

        public static int[] SetArr(int c)
        {
            var arr = new int[c];
            Random ran = new Random();
            for (int i = 0; i < arr.Length; i++)
            {
                arr[i] = ran.Next(1, 99);
            }
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
