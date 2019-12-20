using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public static class Print
    {
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
