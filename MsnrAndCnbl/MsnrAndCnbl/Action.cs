using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    public enum toRiverBank
    {
        toLeft,
        toRight
    }

    /// <summary>
    /// Класс действий.
    /// </summary>
    public class Action
    {
        // Действия производимые над ситуациями.
        public Action() { }
        public Action(int m, int c, toRiverBank toRB)
        {
            Msnr = m;
            Cnbl = c;
            toRvrBnk = toRB;
        }

        private const int BOATCAPACITY = 2; // Вместимость лодки.

        /// <summary>
        /// Количество миссионеров в действии.
        /// </summary>
        public int Msnr
        { get; set; }

        /// <summary>
        /// Количество каннибалов в действии.
        /// </summary>
        public int Cnbl
        { get; set; }

        /// <summary>
        /// Направление к берегу: toLeft -  курс на левый берег, toRight - курс на правый.
        /// </summary>
        public toRiverBank toRvrBnk
        { get; set; }

        /// <summary>
        /// Генерирование действий исходя из родительской вершины. 
        /// </summary>
        /// <param name="situation"></param>
        /// <returns></returns>
        public static List<Action> GenerationAction(Situation situation)
        {
            int mis;
            int can;
            toRiverBank toRB;
            var actions = new List<Action>();

            if (situation.RvrBnk == RiverBank.Left)          // Ситуация: лодка на левом берегу - количество миссионеров, каннибалов левого берега.
            {
                mis = situation.Msnr;
                can = situation.Cnbl;
                toRB = toRiverBank.toRight;
            }
            else                                           // Ситуация: лодка на правом берегу - количество миссионеров, каннибалов правого берега.     
            {
                mis = Situation.MSNRALL - situation.Msnr;
                can = Situation.CNBLALL - situation.Cnbl;
                toRB = toRiverBank.toLeft;
            }

            // Цикл по количеству миссионеров в лодке: изменяется от 0 до минимального значения (количество миссионеров, количество мест в лодке)
            // Цикл по количеству каннибалов в лодке:  изменяется от 0 до минимального значения (количество каннибалов, количество мест в лодке - количество миссионеров)
            for (int m = 0; m <= Math.Min(mis, BOATCAPACITY); m++)
            {
                for (int c = 0; c <= Math.Min(can, BOATCAPACITY - m); c++)
                {
                    if (m == 0 && c == 0)
                        continue;

                    var newaction = new Action(m, c, toRB);
                    actions.Add(newaction);
                }
            }
            return actions;
        }
    }
}
