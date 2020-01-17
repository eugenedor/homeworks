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
            Sort(8);
            Search();
            Factorial(5);
            Fibonacci(5);
            Reverse(9);
            Caesar("Abc. Everyone has one's own path.", 3);
            DoubleShift("Everyone has one's own path.", "3|2|4|0|1", "4|0|3|2|5|1");
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
            AlgorithmsSort.MergeSort(arr3, 0, arr3.Length - 1);
            Print.PrintArr(arr3);
        }

        public static void Search()
        {
            var arr4 = new int[] { 1, 2, 3, 5, 7, 12, 25, 37};
            int val4 = 5;
            Print.PrintArr(arr4, "LinearSearch");
            var inx4 = AlgorithmsSearch.LinearSearch(arr4, val4);
            Console.WriteLine("After:");
            Console.WriteLine($"Value = {val4}; indexSearch = {inx4}");
            Console.WriteLine();

            var arr5 = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
            int val5 = 6;
            Print.PrintArr(arr5, "BinarySearchRecursion");
            var inx5 = AlgorithmsSearch.BinarySearchRecursion(arr5, val5, 0, arr5.Length - 1);
            Console.WriteLine("After:");
            Console.WriteLine($"Value = {val5}; indexSearch = {inx5}");
            Console.WriteLine();

            var arr6 = arr5;
            int val6 = 7;
            Print.PrintArr(arr6, "BinarySearchCycle");
            var inx6 = AlgorithmsSearch.BinarySearchCycle(arr6, val6, 0, arr6.Length - 1);
            Console.WriteLine("After:");
            Console.WriteLine($"Value = {val6}; indexSearch = {inx6}");
            Console.WriteLine();
        }

        public static void Factorial(int n)
        {
            for (var i = 0; i <= n; i++)
            {
                var res = AlgorithmsFactorial.FactorialRecursion(i);
                Console.WriteLine($"FactorialRecursion({i}) = {res}");
            }

            for (var i = 0; i <= n; i++)
            {
                var res = AlgorithmsFactorial.FactorialCycle(i);
                Console.WriteLine($"FactorialCycle({i}) = {res}");
            }

            Console.WriteLine();
        }

        public static void Fibonacci(int n)
        {            
            for (var i = 0; i <= n; i++)
            {
                var res= AlgorithmsFibonacci.FibonacciRecursion(i);
                Console.WriteLine($"FibonacciRecursion({i}) = {res}");
            }

            for (var i = 0; i <= n; i++)
            {
                var res = AlgorithmsFibonacci.FibonacciCycle(i);
                Console.WriteLine($"FibonacciCycle({i}) = {res}");
            }

            Console.WriteLine();
        }

        public static void Reverse(int cntItem)
        {
            var arr7 = SetArr(cntItem);
            Print.PrintArr(arr7, "Reverse");
            AlgorithmsReverse.Reverse(arr7);
            Print.PrintArr(arr7);
        }

        public static void Caesar(string text, int key)
        {
            Console.WriteLine("=====CaesarCipher=====");
            Console.WriteLine($"Text Data: \"{text}\"");
            Console.WriteLine($"key: {key}");

            Console.WriteLine("Encrypted Data:");
            var encryptText = CaesarCipher.Encipher(text, key);
            Console.WriteLine($"Encrypt Text: \"{encryptText}\"");

            Console.WriteLine("Decrypted Data:");
            var decryptText = CaesarCipher.Decipher(encryptText, key);
            Console.WriteLine($"Decrypt Text: \"{decryptText}\"");

            Console.WriteLine();
        }

        public static void DoubleShift(string text, string key0, string key1)
        {
            Console.WriteLine("=====DoubleShift=====");
            Console.WriteLine($"Text Data: \"{text}\"");
            Console.WriteLine($"keyRw: {key0}  keyClmn: {key1}");

            Console.WriteLine("\nEncrypted Data:");
            var encryptText = DoubleShiftCipher.Encipher(text, key0, key1);
            Console.WriteLine($"Encrypt Text: \"{encryptText}\"");

            Console.WriteLine("\nDecrypted Data:");
            var decryptText = DoubleShiftCipher.Decipher(encryptText, key0, key1);
            Console.WriteLine($"Decrypt Text: \"{decryptText}\"");

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
