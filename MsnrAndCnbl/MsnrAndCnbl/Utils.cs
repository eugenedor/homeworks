using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    public static class Utils
    {
        public static void DisplayPreview(Situation situation)
        {
            Console.WriteLine("Начальная ситуация: \n - кол-во миссионеров; \n - кол-во каннибалов; \n - признак лодки на левом берегу; \n - тупиковость ситуации; \n - признак конечной ситуации; \n - глубина залегания вершины.");
            situation.DisplayStats();
            Console.WriteLine("");
            Console.WriteLine("Пройденный путь в дереве ситуаций");
        }

        public static void DisplayResults(Conditions conditions, List<Situation> situations)
        {
            conditions.SearchDepth = (from s in situations
                                      where s.isEnd || s.IsDeadLock
                                      select s.Depth).Min();   // Глубина поиска

            conditions.PathLength = (from s in situations
                                     where s.isEnd || s.IsDeadLock
                                     select s.Depth).Max();    // Длина пути решения

            conditions.TotalCountApex = (from s in situations
                                         select s).Count<Situation>();                       // Общее число порожденных вершин

            Console.WriteLine("глубина поиска D = {0}; \nдлина пути решения L = {1}; \nобщее число порожденных вершин N = {2}; \nразветвленность поиска R = {3}; \nнаправленность поиска W = {4};", 
                              conditions.SearchDepth, 
                              conditions.PathLength, 
                              conditions.TotalCountApex, 
                              conditions.SearchBranching, 
                              conditions.SearchDirecivity);

            Console.WriteLine("эффективность просмотра вершин tc = " + conditions.ShowEffectivenes.ToString() + ";");

            Console.WriteLine("эффективная глубина поиска D/T = {0}; \nэффективная длина пути решения L/T = {1}.", 
                              conditions.EffectiveSearchDepth, 
                              conditions.EffectivePathLength);
        }
    }
}
