using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.CSharp.RuntimeBinder;

namespace Algorithms
{
    public class DoubleShift
    {
        public static void M()
        {
            int n, m, i, j, k;
            var strBegin = "карлукларыукралкораллы";
            var key1 = "514362";
            m = Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(strBegin.Length) / key1.Length));
            n = Convert.ToInt32(key1.Length);
            Console.WriteLine(strBegin);
            Console.WriteLine($"key1: {key1}");
            Console.WriteLine($"Длина key1={n}, длина key2 должна составлять={m} ");

            var key2 = "4312";
            m = Convert.ToInt32(key2.Length);
            Console.WriteLine($"key2: {key2}");
            Console.WriteLine($"Длина key2={m}");

            //ШИФРАТОР
            Console.WriteLine("\nШИФРАТОР");
            var arrA = new char[m, n]; //char[,]
            var arrB = new char[m, n]; //char[,]
            arrA = writeArr(strBegin, m, n);
            Console.WriteLine($"Преобразуем строку в массив размером {m}*{n}");
            printArr(arrA, m, n);

            //Перестановка столбцов матрицы по ключу №1 
            var vectr1 = new char[n];
            vectr1 = key1.ToCharArray();
            for (j = 0; j < n; j++)
            {
                for (k = 0; k < n; k++)
                {
                    if (j != int.Parse(Convert.ToString(vectr1[k]))-1)
                        continue; //Условие для определения правильного порядка столбцов

                    for (i = 0; i < m; i++)
                    {
                        arrB[i, j] = arrA[i, k];
                    }

                }
            }
            Console.WriteLine($"Матрица с перестановленными столбцами по ключу №1 {key1}:");
            printArr(arrB, m, n);

            //Перестановка строк матрицы по ключу №2
            var vectr2 = new char[m];
            vectr2 = key2.ToCharArray();
            for (i = 0; i < m; i++)
            {
                for (k = 0; k < m; k++)
                {
                    if (i != int.Parse(Convert.ToString(vectr2[k]))-1)
                        continue; //Условие для определения правильного порядка строк
                    
                    for (j = 0; j < n; j++)
                    {
                        arrA[i, j] = arrB[k, j];
                    }
                }
            }
            Console.WriteLine($"Матрица с перестановленными строками по ключу №2 {key2}:");
            printArr(arrA, m, n);

            //Зашифрованная строка
            var strCipher = "";
            for (i = 0; i < m; i++)
            {
                for (j = 0; j < n; j++)
                {
                    strCipher += Convert.ToString(arrA[i, j]);
                }
            }
            Console.WriteLine($"Зашифрованная строка исходящего сообщения: {strCipher}");

            ////---------- ДЕШИФРАТОР ----------------------------------------------------------
            //Console.WriteLine("\nДЕШИФРАТОР");

            ////----------Запись входящей строки в массив --------------------------------------
            //k = 0;
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        if (k < strcipher.Length)
            //        {
            //            arrA[i, j] = strcipher[k];
            //            k++;
            //        }
            //        else
            //        {
            //            arrA[i, j] = Convert.ToChar("-");
            //        }
            //    }
            //}
            ////---------- Вывод матрицы на экран ----------------------------------------------
            //Console.WriteLine("Преобразуем строку в массив размером {0}*{1}", m, n);
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        Console.Write(arrA[i, j]);
            //    }
            //    Console.WriteLine();
            //}
            //Console.WriteLine();

            ////---------- Обратная перестановка строк матрицы --------------------------------- 
            //vectr = key2.ToCharArray();
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        l = int.Parse(Convert.ToString(vectr[i])) - 1;
            //        arrB[i, j] = arrA[l, j];
            //    }
            //}

            ////---------- Вывод матрицы на с перестановленными строками по ключу №2 -----------
            //Console.WriteLine("Матрица с перестановленными строками по ключу №2 {0}:", key2);
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        Console.Write(arrB[i, j]);
            //    }
            //    Console.WriteLine();
            //}
            //Console.WriteLine();

            ////---------- Обратная перестановка столбцов матрицы ------------------------------
            //vectr = key1.ToCharArray();
            //for (j = 0; j < n; j++)
            //{
            //    for (i = 0; i < m; i++)
            //    {
            //        l = int.Parse(Convert.ToString(vectr[j])) - 1;
            //        arrA[i, j] = arrB[i, l];
            //    }
            //}

            ////---------- Вывод матрицы с перестановленными столбцами по ключу №1 -------------
            //Console.WriteLine("Матрица с перестановленными столбцами по ключу №1 {0}:", key1);
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        Console.Write(arrA[i, j]);
            //    }
            //    Console.WriteLine();
            //}
            //Console.WriteLine();

            ////---------- Расшифрованная строка------------------------------------------------
            //var strEnd = "";
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        strEnd = strEnd + Convert.ToString(arrA[i, j]);
            //    }
            //}
            //Console.WriteLine("Расшифрованная строка полученного сообщения: {0}", strEnd);
            Console.ReadLine();
        }

        private static char[,] writeArr(string str, int m, int n)
        {
            var k = 0;
            var mas = new char[m, n]; //char[,]
            for (var i = 0; i < m; i++)
            {
                for (var j = 0; j < n; j++)
                {
                    if (k < str.Length)
                    {
                        mas[i, j] = str[k];
                        k++;
                    }
                    else
                    {
                        mas[i, j] = Convert.ToChar("-");
                    }
                }
            }

            return mas;
        }

        private static void printArr(char[,] mas, int m, int n)
        {
            for (var i = 0; i < m; i++)
            {
                for (var j = 0; j < n; j++)
                {
                    Console.Write(mas[i, j]);
                }
                Console.WriteLine();
            }
            Console.WriteLine();
        }
    }
}
