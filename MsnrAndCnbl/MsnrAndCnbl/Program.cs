using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    class Program
    {
        static void Main(string[] args)
        {
            int msnr, cnbl;    //missionaries - миссионеры, cannibals - каннибалы
            string rb, rbTxt;  //river bank   - берег реки

            Console.WriteLine("Миссионеры и каннибалы");
            Console.WriteLine("Введите количество миссионеров, каннибалов, берег {L, R}");
            try
            {
                msnr = Convert.ToInt32(Console.ReadLine());
                cnbl = Convert.ToInt32(Console.ReadLine());
                rb = Console.ReadLine();

                if (msnr < 0 || msnr > 3 || 
                    cnbl < 0 || cnbl > 3 || 
                    rb.ToUpper() != "L" && rb.ToUpper() != "R")
                {
                    rbTxt = (rb.ToUpper() != "L" && rb.ToUpper() != "R") ? "неопределен" : rb.ToUpper() == "L" ? "левый" : "правый";

                    Console.WriteLine("Ошибка ввода данных! Миссионеров {0}, каннибалов {1}, берег реки {2}", msnr.ToString(), cnbl.ToString(), rbTxt);
                    Console.ReadLine();
                    return;
                }
            }
            catch (System.Exception ex)
            {
                Console.WriteLine(ex.ToString());
                Console.ReadLine();
                return;
            }

            RiverBank riverBank;
            if (rb.ToUpper() == "L")
            {
                riverBank = RiverBank.Left;
            }
            else
            {
                riverBank = RiverBank.Right;
            }
            Console.WriteLine("");

            Situation situation1 = new Situation(msnr, cnbl, riverBank);
            Console.WriteLine("Поиск в глубину (Depth-first search, DFS)");
            Console.WriteLine("");
            DepthFirstSearch.FindSolution(situation1);
            Console.WriteLine("");
            Console.WriteLine("");

            Situation situation2 = new Situation(msnr, cnbl, riverBank);
            Console.WriteLine("Поиск в ширину (Breadth-first search, BFS)");
            Console.WriteLine("");
            BreadthFirstSearch.FindSolution(situation2);
            Console.WriteLine("");
            Console.ReadLine();
        }
    }
}
