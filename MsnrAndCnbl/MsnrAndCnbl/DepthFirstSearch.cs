using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    class DepthFirstSearch
    {
        public static bool DFS(Situation situation, List<Situation> listInSituation, out List<Situation> listOutSituation)
        {
            listInSituation.Add(situation);                           // Список пройденных ситуаций.
            listOutSituation = new List<Situation>(listInSituation);  // Возврат списка пройденных ситуаций. 
            var term = false;                                         // Признак того, что достигнуто конечное состояние.
            if (situation.isEnd)
            {
                term = true;
            }
            else
            {
                if (!situation.IsDeadLock)
                {
                    List<Action> listaction = Action.GenerationAction(situation);   // Генерация действий для ситуации (узла в дереве).
                    var situations = new List<Situation>();                         // Список дочерних ситуаций.
                    foreach (var act in listaction)
                    {
                        var newSituation = situation * act;
                        int numb = (from s in listInSituation
                                    where s.Msnr == newSituation.Msnr 
                                          && s.Cnbl == newSituation.Cnbl 
                                          && s.RvrBnk == newSituation.RvrBnk
                                    select s).Count<Situation>(); // Кол-во предыдущих ситуаций совпадающих с текущей дочерней.

                        if (numb > 0)           // Если кол-во больше 0, значит такая ситуация уже была, текущая дочерняя является тупиковой.
                            newSituation.IsDeadLock = true;

                        situations.Add(newSituation);
                    }

                    // Рекурсивный спуск будет продолжаться до обнаружения целевой вершины, 
                    // либо будет происходить перебор всех вершин, до последнего тупика.
                    foreach (var st in situations)
                    {
                        term = DFS(st, listInSituation, out listOutSituation); // Спуск
                        if (term)
                            break;
                    }
                }
            }
            return term;
        }

        public static void FindSolution(Situation situation)
        {
            var listInSituation = new List<Situation>();
            var listOutSituation = new List<Situation>();
            var conditions = new Conditions();
            conditions.StartTimeCounter();
            Console.WriteLine("Начальная ситуация: \n - кол-во миссионеров; \n - кол-во каннибалов; \n - признак лодки на левом берегу; \n - тупиковость ситуации; \n - признак конечной ситуации; \n - глубина залегания вершины.");
            situation.DisplayStats();
            Console.WriteLine("");
            Console.WriteLine("Пройденный путь в дереве ситуаций");
            DFS(situation, listInSituation, out listOutSituation);
            foreach (var sit in listOutSituation)
            {
                sit.DisplayStats();
            }
            Console.WriteLine("");
            conditions.StopTimeCounter();

            conditions.SearchDepth = (from s in listOutSituation where s.isEnd || s.IsDeadLock select s.Depth).Min();   // Глубина поиска.
            conditions.PathLength = (from s in listOutSituation where s.isEnd || s.IsDeadLock select s.Depth).Max();    // Длина пути решения.
            conditions.TotalCountApex = (from s in listOutSituation select s).Count<Situation>();                       // Общее число порожденных вершин.
            Console.WriteLine("глубина поиска D = {0}; \nдлина пути решения L = {1}; \nобщее число порожденных вершин N = {2}; \nразветвленность поиска R = {3}; \nнаправленность поиска W = {4};", conditions.SearchDepth, conditions.PathLength, conditions.TotalCountApex, conditions.SearchBranching, conditions.SearchDirecivity);
            Console.WriteLine("эффективность просмотра вершин tc = " + conditions.ShowEffectivenes.ToString() + ";");
            Console.WriteLine("эффективная глубина поиска D/T = {0}; \nэффективная длина пути решения L/T = {1}.", conditions.EffectiveSearchDepth, conditions.EffectivePathLength);
        }
    }
}
