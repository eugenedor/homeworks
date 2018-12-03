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
            Utils.DisplayPreview(situation);

            var listOutSituation = new List<Situation>();
            var conditions = new Conditions();
            conditions.StartTimeCounter();

            BFS(situation, out listOutSituation);

            foreach (var sit in listOutSituation)
                sit.DisplayStats();

            conditions.StopTimeCounter();
            Console.WriteLine("");

            Utils.DisplayResults(conditions, listOutSituation);
        }
    }
}
