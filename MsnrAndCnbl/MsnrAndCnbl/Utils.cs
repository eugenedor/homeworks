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
            string msg;
            msg = "Начальная ситуация: \nкол-во миссионеров; \nкол-во каннибалов; \nпризнак лодки на левом берегу; \nтупиковость ситуации; \nпризнак конечной ситуации; \nглубина залегания вершины.";
            Console.WriteLine(msg);
            Log.WriteLog(msg);
            situation.DisplayStats(0);
            Console.WriteLine("");
            msg = "Пройденный путь в дереве ситуаций";
            Console.WriteLine(msg);
            Log.WriteLog(msg);
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

            string msg;
            msg = string.Format("глубина поиска D = {0}; \nдлина пути решения L = {1}; \nобщее число порожденных вершин N = {2}; \nразветвленность поиска R = {3}; \nнаправленность поиска W = {4};",
                                conditions.SearchDepth,
                                conditions.PathLength,
                                conditions.TotalCountApex,
                                conditions.SearchBranching,
                                conditions.SearchDirecivity);
            Console.WriteLine(msg);
            Log.WriteLog(msg);

            msg = string.Format("эффективность просмотра вершин tc = " + conditions.ShowEffectivenes.ToString() + ";");
            Console.WriteLine(msg);
            Log.WriteLog(msg);

            msg = string.Format("эффективная глубина поиска D/T = {0}; \nэффективная длина пути решения L/T = {1}.",
                                conditions.EffectiveSearchDepth,
                                conditions.EffectivePathLength);
            Console.WriteLine(msg);
            Log.WriteLog(msg);
        }
    }
}
