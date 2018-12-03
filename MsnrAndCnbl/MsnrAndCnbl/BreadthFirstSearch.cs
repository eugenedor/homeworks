using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    class BreadthFirstSearch
    {
        public static void BFS(Situation situation, out List<Situation> listOutSituation)
        {
            //var needcontinue = true;
            List<Situation> listSituation = new List<Situation>();  // Рабочий список - список с добавлением в конец дочерних вершин узла.
            listOutSituation = new List<Situation>();               // Список пройденных ситуаций.
            listSituation.Add(situation);

            for (var index = 0; index < listSituation.Count; index++)
            {
                listOutSituation.Add(listSituation[index]);

                if (listSituation[index].isEnd)
                    break;

                if (listSituation[index].IsDeadLock)
                    continue;

                List<Action> listaction = Action.GenerationAction(listSituation[index]); // Генерация действий.
                foreach (var act in listaction)
                {
                    var newSituation = listSituation[index] * act;
                    int numb = (from s in listSituation
                                where s.Msnr == newSituation.Msnr 
                                        && s.Cnbl == newSituation.Cnbl 
                                        && s.RvrBnk == newSituation.RvrBnk
                                select s).Count<Situation>(); // Кол-во предыдущих ситуаций совпадающих с текущей дочерней.

                    if (numb > 0)           // Если кол-во больше 0, значит такая ситуация уже была, текущая дочерняя является тупиковой.
                        newSituation.IsDeadLock = true;

                    listSituation.Add(newSituation);
                }                                
            }
        }

        public static void FindSolution(Situation situation)
        {
            var listOutSituation = new List<Situation>();
            var conditions = new Conditions();
            conditions.StartTimeCounter();
            Console.WriteLine("Начальная ситуация: \n - кол-во миссионеров; \n - кол-во каннибалов; \n - признак лодки на левом берегу; \n - тупиковость ситуации; \n - признак конечной ситуации; \n - глубина залегания вершины.");
            situation.DisplayStats();
            Console.WriteLine("");
            Console.WriteLine("Пройденный путь в дереве ситуаций");
            BFS(situation, out listOutSituation);
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
