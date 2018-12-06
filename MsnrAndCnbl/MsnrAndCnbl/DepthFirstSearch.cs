using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    class DepthFirstSearch
    {
        /// <summary>
        /// Поиск в глубину (Depth-first search, DFS)
        /// </summary>
        public static bool DFS(Situation situation, List<Situation> listInSituation)
        {
            listInSituation.Add(situation);                                 // Список пройденных ситуаций.           

            if (situation.isEnd)
                return true;

            if (situation.IsDeadLock)
                return false;

            var term = false;                                               // Признак того, что достигнуто конечное состояние.
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
                term = DFS(st, listInSituation); // Спуск
                if (term)
                    break;
            }
            return term;
        }

        public static void FindSolution(Situation situation)
        {
            Utils.DisplayPreview(situation);

            var listInSituation = new List<Situation>();
            var conditions = new Conditions();
            conditions.StartTimeCounter();

            DFS(situation, listInSituation);

            foreach (var sit in listInSituation)
                sit.DisplayStats();

            conditions.StopTimeCounter();
            Console.WriteLine(string.Empty);            

            Utils.DisplayResults(conditions, listInSituation);
        }
    }
}
