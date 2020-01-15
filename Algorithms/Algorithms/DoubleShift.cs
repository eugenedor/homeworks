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
            int rw, clmn, i, j, k;
            var strBegin = "карлукларыукралкораллы";
            var keyClmn = "4|0|3|2|5|1";
            string[] aKeyClmn;
            int[] arrKeyClmn;
            try
            {
                aKeyClmn = keyClmn.Split(new Char[] { '|' });
                arrKeyClmn = aKeyClmn.Select(x => Int32.Parse(x)).ToArray();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return;
            }
            

            rw = Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(strBegin.Length) / arrKeyClmn.Length));
            clmn = Convert.ToInt32(arrKeyClmn.Length);
            Console.WriteLine(strBegin);
            Console.WriteLine($"keyClmn: {keyClmn}");
            Console.WriteLine($"Длина keyClmn={clmn}, длина keyRw должна составлять={rw} ");

            var keyRw = "3201";
            rw = Convert.ToInt32(keyRw.Length);
            Console.WriteLine($"keyRw: {keyRw}");
            Console.WriteLine($"Длина keyRw={rw}");

            //encoder (шифратор)
            Console.WriteLine("\nШИФРАТОР");
            var arr = new char[rw, clmn]; //char[,]
            var buf = new char[rw, clmn]; //char[,]
            arr = writeArr(strBegin, rw, clmn);
            Console.WriteLine($"Преобразуем строку в массив размером {rw}*{clmn}");
            printArr(arr, rw, clmn);

            //перестановка столбцов матрицы по ключу keyClmn 
            for (j = 0; j < clmn; j++)
            {
                for (k = 0; k < clmn; k++)
                {
                    if (j != arrKeyClmn[k]) //условие для определения правильного порядка столбцов
                        continue;

                    //по каждой строке
                    for (i = 0; i < rw; i++)
                    {
                        buf[i, j] = arr[i, k];
                    }

                }
            }
            Console.WriteLine($"Матрица с перестановленными столбцами по ключу keyClmn \"{keyClmn}\":");
            printArr(buf, rw, clmn);

            //перестановка строк матрицы по ключу keyRw
            var vectr2 = new char[rw];
            vectr2 = keyRw.ToCharArray();
            for (i = 0; i < rw; i++)
            {
                for (k = 0; k < rw; k++)
                {
                    if (i != int.Parse(Convert.ToString(vectr2[k]))) //условие для определения правильного порядка строк
                        continue;

                    //по каждому столбцу
                    for (j = 0; j < clmn; j++)
                    {
                        arr[i, j] = buf[k, j];
                    }
                }
            }
            Console.WriteLine($"Матрица с перестановленными строками по ключу keyRw \"{keyRw}\":");
            printArr(arr, rw, clmn);

            //Зашифрованная строка
            var strCipher = "";
            for (i = 0; i < rw; i++)
            {
                for (j = 0; j < clmn; j++)
                {
                    strCipher += Convert.ToString(arr[i, j]);
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
            //            arr[i, j] = strcipher[k];
            //            k++;
            //        }
            //        else
            //        {
            //            arr[i, j] = Convert.ToChar("-");
            //        }
            //    }
            //}
            ////---------- Вывод матрицы на экран ----------------------------------------------
            //Console.WriteLine("Преобразуем строку в массив размером {0}*{1}", m, n);
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        Console.Write(arr[i, j]);
            //    }
            //    Console.WriteLine();
            //}
            //Console.WriteLine();

            ////---------- Обратная перестановка строк матрицы --------------------------------- 
            //vectr = keyRw.ToCharArray();
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        l = int.Parse(Convert.ToString(vectr[i])) - 1;
            //        buf[i, j] = arr[l, j];
            //    }
            //}

            ////---------- Вывод матрицы на с перестановленными строками по ключу №2 -----------
            //Console.WriteLine("Матрица с перестановленными строками по ключу №2 {0}:", keyRw);
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        Console.Write(buf[i, j]);
            //    }
            //    Console.WriteLine();
            //}
            //Console.WriteLine();

            ////---------- Обратная перестановка столбцов матрицы ------------------------------
            //vectr = keyClmn.ToCharArray();
            //for (j = 0; j < n; j++)
            //{
            //    for (i = 0; i < m; i++)
            //    {
            //        l = int.Parse(Convert.ToString(vectr[j])) - 1;
            //        arr[i, j] = buf[i, l];
            //    }
            //}

            ////---------- Вывод матрицы с перестановленными столбцами по ключу №1 -------------
            //Console.WriteLine("Матрица с перестановленными столбцами по ключу №1 {0}:", keyClmn);
            //for (i = 0; i < m; i++)
            //{
            //    for (j = 0; j < n; j++)
            //    {
            //        Console.Write(arr[i, j]);
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
            //        strEnd = strEnd + Convert.ToString(arr[i, j]);
            //    }
            //}
            //Console.WriteLine("Расшифрованная строка полученного сообщения: {0}", strEnd);
        }

        private static char[,] writeArr(string str, int rw, int clmn)
        {
            var k = 0;
            var array = new char[rw, clmn]; //char[,]
            for (var i = 0; i < rw; i++)
            {
                for (var j = 0; j < clmn; j++)
                {
                    if (k < str.Length)
                    {
                        array[i, j] = str[k];
                        k++;
                    }
                    else
                    {
                        array[i, j] = Convert.ToChar("-");
                    }
                }
            }

            return array;
        }

        private static void printArr(char[,] mas, int rw, int clmn)
        {
            for (var i = 0; i < rw; i++)
            {
                for (var j = 0; j < clmn; j++)
                {
                    Console.Write(mas[i, j]);
                }
                Console.WriteLine();
            }
            Console.WriteLine();
        }
    }
}
