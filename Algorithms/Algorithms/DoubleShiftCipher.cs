using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Algorithms
{
    public class DoubleShiftCipher
    {
        private static void cipher(string input,
                                   string keyRw,
                                   string keyClmn,
                                   out char[,] arr,
                                   out char[,] buf,
                                   out int[] arrKeyRw,
                                   out int[] arrKeyClmn)
        {
            arr = null;
            buf = null;
            arrKeyRw = null;
            arrKeyClmn = null;

            int rw, clmn;
            //var input = "карлукларыукралкораллы";

            //var keyRw = "3|2|0|1";
            string[] aKeyRw;
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
            rw = arrKeyRw.Length;

            //var keyClmn = "4|0|3|2|5|1";
            string[] aKeyClmn;
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
            clmn = arrKeyClmn.Length;
            Console.WriteLine($"длина keyRw={rw} keyClmn={clmn}");
            Console.WriteLine();

            var len = rw * clmn;
            if (len < input.Length)
            {
                Console.WriteLine($"Рассчитанная длина массива {len} меньше входящей строки {input.Length}");
                return;
            }

            var clmnCalc = Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(input.Length) / arrKeyRw.Length));
            if (clmn != clmnCalc)
            {
                Console.WriteLine($"Длина keyClmn={clmn} неравна clmnCalc={clmnCalc} ");
                return;
            }

            arr = new char[rw, clmn]; //char[,]
            buf = new char[rw, clmn]; //char[,]

            Console.WriteLine($"Преобразуем строку в массив размером {rw}*{clmn}");
            arr = getArr(input, rw, clmn);
            printArr(arr, rw, clmn);
        }

        public static string Encipher(string input, string keyRw, string keyClmn)
        {
            int rw, clmn;
            char[,] arr, buf;
            int[] arrKeyRw, arrKeyClmn;

            cipher(input, keyRw, keyClmn, out arr, out buf, out arrKeyRw, out arrKeyClmn);

            if (arr == null)
                return String.Empty;

            rw = arrKeyRw.Length;
            clmn = arrKeyClmn.Length;

            //
            //encoder (шифратор)
            //
            Console.WriteLine("Шифратор");
            //перестановка строк матрицы по ключу keyRw
            for (var i = 0; i < rw; i++)
            {
                for (var j = 0; j < clmn; j++)
                {
                    var k = arrKeyRw[i];
                    buf[k, j] = arr[i, j];
                }
            }
            Console.WriteLine($"Матрица с перестановленными строками по ключу keyRw \"{keyRw}\":");
            printArr(buf, rw, clmn);

            //перестановка столбцов матрицы по ключу keyClmn 
            for (var j = 0; j < clmn; j++)
            {
                for (var i = 0; i < rw; i++)
                {
                    var k = arrKeyClmn[j];
                    arr[i, k] = buf[i, j];
                }
            }
            Console.WriteLine($"Матрица с перестановленными столбцами по ключу keyClmn \"{keyClmn}\":");
            printArr(arr, rw, clmn);

            //зашифрованная строка
            return getStr(arr, rw, clmn);
        }

        public static string Decipher(string input, string keyRw, string keyClmn)
        {
            int rw, clmn;
            char[,] arr, buf;
            int[] arrKeyRw, arrKeyClmn;

            cipher(input, keyRw, keyClmn, out arr, out buf, out arrKeyRw, out arrKeyClmn);

            if (arr == null)
                return String.Empty;

            rw = arrKeyRw.Length;
            clmn = arrKeyClmn.Length;

            //
            //dencoder (дешифратор)
            //
            Console.WriteLine("Дешифратор");
            //обратная перестановка столбцов матрицы
            for (var j = 0; j < clmn; j++)
            {
                for (var i = 0; i < rw; i++)
                {
                    var k = arrKeyClmn[j];
                    buf[i, j] = arr[i, k];
                }
            }
            Console.WriteLine($"Матрица с перестановленными столбцами по ключу keyClmn \"{keyClmn}\":");
            printArr(buf, rw, clmn);

            //обратная перестановка строк матрицы
            for (var i = 0; i < rw; i++)
            {
                for (var j = 0; j < clmn; j++)
                {
                    var k = arrKeyRw[i];
                    arr[i, j] = buf[k, j];
                }
            }
            Console.WriteLine($"Матрица с перестановленными строками по ключу keyRw \"{keyRw}\":");
            printArr(arr, rw, clmn);

            //расшифрованная строка
            return getStr(arr, rw, clmn).TrimEnd();
        }

        private static char[,] getArr(string str, int rw, int clmn)
        {
            var k = 0;
            var mas = new char[rw, clmn]; //char[,]
            for (var i = 0; i < rw; i++)
            {
                for (var j = 0; j < clmn; j++)
                {
                    if (k < str.Length)
                    {
                        mas[i, j] = str[k];
                        k++;
                    }
                    else
                    {
                        mas[i, j] = Convert.ToChar(" ");
                    }
                }
            }

            return mas;
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

        private static string getStr(char[,] mas, int rw, int clmn)
        {
            var str = "";
            for (var i = 0; i < rw; i++)
            {
                for (var j = 0; j < clmn; j++)
                {
                    str += Convert.ToString(mas[i, j]);
                }
            }
            return str;
        }
    }
}
