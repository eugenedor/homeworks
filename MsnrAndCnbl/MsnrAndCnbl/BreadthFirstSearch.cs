using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    class BreadthFirstSearch
    {
        /// <summary>
        /// Поиск в ширину (Breadth-first search, BFS)
        /// </summary>
        public static void BFS(Situation situation, List<Situation> listSituation)
        {
            List<Situation> situations = new List<Situation>();  // Рабочий список - список с добавлением в конец дочерних вершин узла.
            situations.Add(situation);

            for (var index = 0; index < situations.Count; index++)
            {
                listSituation.Add(situations[index]);

                if (situations[index].isEnd)
                    break;

                if (situations[index].IsDeadLock)
                    continue;

                List<Action> listaction = Action.GenerationAction(situations[index]); // Генерация действий.
                foreach (var act in listaction)
                {
                    var newSituation = situations[index] * act;
                    int numb = (from s in situations
                                where s.Msnr == newSituation.Msnr 
                                        && s.Cnbl == newSituation.Cnbl 
                                        && s.RvrBnk == newSituation.RvrBnk
                                select s).Count<Situation>(); // Кол-во предыдущих ситуаций совпадающих с текущей дочерней.

                    if (numb > 0)           // Если кол-во больше 0, значит такая ситуация уже была, текущая дочерняя является тупиковой.
                        newSituation.IsDeadLock = true;

                    situations.Add(newSituation);
                }                                
            }
        }

        public static void FindSolution(Situation situation)
        {
            Utils.DisplayPreview(situation);

            var listSituation = new List<Situation>();
            var conditions = new Conditions();
            conditions.StartTimeCounter();

            BFS(situation, listSituation);

            int i = 0;
            foreach (var sit in listSituation)
            {
                i++;
                sit.DisplayStats(i);
            }                

            conditions.StopTimeCounter();
            Console.WriteLine(string.Empty);

            Utils.DisplayResults(conditions, listSituation);
        }
    }
}
