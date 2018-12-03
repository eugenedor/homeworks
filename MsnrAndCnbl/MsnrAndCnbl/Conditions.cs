using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    /// <summary>
    /// Характеристики поиска.
    /// </summary>
    public class Conditions
    {
        public Conditions()
        {
            this.searchDepth = 0;
            this.pathLength = 0;
            this.TotalCountApex = 0;
        }

        private int searchDepth;
        /// <summary>
        /// Глубина поиска D - максимальное число вершин до целевой или тупиковой.
        /// </summary>
        public int SearchDepth
        {
            get { return searchDepth; }
            set
            {
                if (searchDepth < value || searchDepth == 0)
                    searchDepth = value;
            }
        }

        private int pathLength;
        /// <summary>
        /// Длина пути решения L - минимальноне число вершин до целевой.
        /// </summary>
        public int PathLength
        {
            get { return pathLength; }
            set
            {
                if (pathLength > value || pathLength == 0)
                {
                    pathLength = value;
                }
            }
        }

        /// <summary>
        /// Общее число порожденных вершин N.
        /// </summary>
        public int TotalCountApex
        { get; set; }

        /// <summary>
        /// Разветвленность поиска R= N/L.
        /// </summary>
        public double SearchBranching
        {
            get
            {
                return (PathLength != 0) ? Math.Round((double)TotalCountApex / PathLength, 2) : -1;
            }
        }

        /// <summary>
        /// Направленность поиска W = N^(1/L).
        /// </summary>
        public double SearchDirecivity
        {
            get
            {
                return (PathLength != 0) ? Math.Round((double)Math.Pow(TotalCountApex, 1.0 / PathLength), 2) : -1;
            }
        }

        private DateTime startTime;
        private DateTime stopTime;
        private bool timeCounterStarted = false;

        public void StartTimeCounter()
        {
            this.startTime = DateTime.Now;
            this.timeCounterStarted = true;
        }

        public void StopTimeCounter()
        {
            this.stopTime = DateTime.Now;
            this.timeCounterStarted = false;
        }

        /// <summary>
        /// Время, для определения значений характеристик.
        /// </summary>
        private DateTime CalcTime
        {
            get
            {
                return (timeCounterStarted) ? DateTime.Now : stopTime; // Счетчик запущен - текущее время, иначе время останова счетчика.
            }
        }

        /// <summary>
        /// Эффективность просмотра вершин tc = T/N; T -время работы программы.
        /// </summary>
        public TimeSpan ShowEffectivenes
        {
            get
            {
                return (TotalCountApex != 0) ? new TimeSpan(0, 0, 0, 0, (int)((CalcTime - startTime).TotalMilliseconds / TotalCountApex)) : new TimeSpan(0, 0, 0, 0, 0);
            }
        }

        /// <summary>
        /// Эффективная глубина поиска D/T.
        /// </summary>
        public double EffectiveSearchDepth
        {
            get
            {
                var time = (CalcTime - startTime).TotalSeconds;
                return (time != 0) ? SearchDepth / time : -1;
            }
        }

        /// <summary>
        /// Эффективная длина пути решения  L/T.
        /// </summary>
        public double EffectivePathLength
        {
            get
            {
                var time = (CalcTime - startTime).TotalSeconds;
                return (time != 0) ? PathLength / time : -1;
            }
        }
    }
}
