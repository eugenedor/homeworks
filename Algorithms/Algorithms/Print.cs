using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public static class Print
    {
        public static void PrintA(int[] arr)
        {
            foreach (var a in arr)
            {
                Console.Write("{0} ", a);
            }
            Console.WriteLine();
        }

        public static void PrintArr(int[] arr, string name = "")
        {
            if (!string.IsNullOrEmpty(name))
                PrintBefore(name);
            else
                PrintAfter();

            PrintA(arr);
            if (string.IsNullOrEmpty(name))
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
