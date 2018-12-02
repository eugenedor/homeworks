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
    class Conditions
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
    }
}
