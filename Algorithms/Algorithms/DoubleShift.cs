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
        public static void Cipher(string input, string keyRw, string keyClmn)
        {
            int rw, clmn, i, j, k;

            Console.WriteLine("\nН.у.");
            //var input = "карлукларыукралкораллы";
            Console.WriteLine($"Строка исходящего сообщения: {input}");

            //var keyRw = "3|2|0|1";
            string[] aKeyRw;
            int[] arrKeyRw;
            try
            {
                aKeyRw = keyRw.Split(new Char[] { '|' });
                arrKeyRw = aKeyRw.Select(x => Int32.Parse(x)).ToArray();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return;
            }
            rw = Convert.ToInt32(arrKeyRw.Length);
            Console.WriteLine($"keyRw: {keyRw}");
            Console.WriteLine($"Длина keyRw={rw}");

            //var keyClmn = "4|0|3|2|5|1";
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

            clmn = Convert.ToInt32(arrKeyClmn.Length);            
            Console.WriteLine($"keyClmn: {keyClmn}");
            Console.WriteLine($"Длина keyClmn={clmn}");

            var clmnCalc = Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(input.Length) / arrKeyRw.Length));
            if (clmn != clmnCalc)
            {
                Console.WriteLine($"Длина keyClmn должна составлять={clmnCalc} ");
                return;
            }

            //
            //encoder (шифратор)
            //
            Console.WriteLine("\nШифратор");
            var arr = new char[rw, clmn]; //char[,]
            var buf = new char[rw, clmn]; //char[,]

            Console.WriteLine($"Преобразуем строку в массив размером {rw}*{clmn}");
            arr = writeArr(input, rw, clmn);
            printArr(arr, rw, clmn);

            //перестановка строк матрицы по ключу keyRw
            for (i = 0; i < rw; i++)
            {
                for (j = 0; j < clmn; j++)
                {
                    k = arrKeyRw[i];
                    buf[k, j] = arr[i, j];
                }
            }
            Console.WriteLine($"Матрица с перестановленными строками по ключу keyRw \"{keyRw}\":");
            printArr(buf, rw, clmn);

            //перестановка столбцов матрицы по ключу keyClmn 
            for (j = 0; j < clmn; j++)
            {
                for (i = 0; i < rw; i++)
                {
                    k = arrKeyClmn[j];
                    arr[i, k] = buf[i, j];
                }
            }
            Console.WriteLine($"Матрица с перестановленными столбцами по ключу keyClmn \"{keyClmn}\":");
            printArr(arr, rw, clmn);

            //зашифрованная строка
            var strCipher = "";
            for (i = 0; i < rw; i++)
            {
                for (j = 0; j < clmn; j++)
                {
                    strCipher += Convert.ToString(arr[i, j]);
                }
            }
            Console.WriteLine($"Зашифрованная строка исходящего сообщения: {strCipher}");

            //
            //dencoder (дешифратор)
            //
            Console.WriteLine("\nДешифратор");

            Console.WriteLine($"Преобразуем строку в массив размером {rw}*{clmn}");
            arr = writeArr(strCipher, rw, clmn);
            printArr(arr, rw, clmn);

            //обратная перестановка столбцов матрицы
            for (j = 0; j < clmn; j++)
            {
                for (i = 0; i < rw; i++)
                {
                    k = arrKeyClmn[j];
                    buf[i, j] = arr[i, k];
                }
            }
            Console.WriteLine($"Матрица с перестановленными столбцами по ключу keyClmn \"{keyClmn}\":");
            printArr(buf, rw, clmn);

            //обратная перестановка строк матрицы
            for (i = 0; i < rw; i++)
            {
                for (j = 0; j < clmn; j++)
                {
                    k = arrKeyRw[i];
                    arr[i, j] = buf[k, j];
                }
            }
            Console.WriteLine($"Матрица с перестановленными строками по ключу keyRw \"{keyRw}\":");
            printArr(arr, rw, clmn);

            //расшифрованная строка
            var strEnd = "";
            for (i = 0; i < rw; i++)
            {
                for (j = 0; j < clmn; j++)
                {
                    strEnd += Convert.ToString(arr[i, j]);
                }
            }
            Console.WriteLine($"Расшифрованная строка полученного сообщения: {strEnd}");
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
                        array[i, j] = Convert.ToChar(" ");
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
