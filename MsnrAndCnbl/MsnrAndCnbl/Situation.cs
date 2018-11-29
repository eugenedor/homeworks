using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsnrAndCnbl
{
    /// <summary>
    /// Берег реки
    /// </summary>
    enum RiverBank
    {
        Left = 0,
        Right = 1
    }

    /// <summary>
    /// Класс ситуаций. Ситуации относительно одного берега реки (левого).
    /// </summary>
    class Situation
    {
        public const int MSNRALL = 3;
        public const int CNBLALL = 3;

        // Зная ситуацию на одном из берегов реки, нетрудно определить ситуацию на противоположном.
        public Situation() { }

        public Situation(int msn, int cnb, RiverBank rb) : this(msn, cnb, rb, false, 1) { }

        public Situation(int msn, int cnb, RiverBank rb, bool isDLck, int dpth)
        {
            Msnr = msn;
            Cnbl = cnb;
            RvrBnk = rb;
            msnrOpposite = MSNRALL - msn;   // Количество миссионеров на противоположном берегу.
            cnblOpposite = CNBLALL - cnb;   // Количество каннибалов на противоположном берегу.
            //isDeadLock = isDLck;            // Признак тупика - по умолчанию = false, повторная ситуация  - тупиковая  = true.
            //Depth = dpth;                   // Глубина залегания вершины.
        }

        private int msnr, msnrOpposite;
        private int cnbl, cnblOpposite;
        private RiverBank rvrBnk;
        //private bool isDLck;

        //protected Action casualAction = new Action();

        /// <summary>
        /// Количество миссионеров.
        /// </summary>
        public int Msnr
        {
            get { return msnr; }
            set { msnr = value; }
        }

        /// <summary>
        /// Количество каннибалов.
        /// </summary>
        public int Cnbl
        {
            get { return cnbl; }
            set { cnbl = value; }
        }

        /// <summary>
        /// Признак лодки на левом берегу: true - левый берег, false - правый.
        /// </summary>
        public RiverBank RvrBnk
        {
            get { return rvrBnk; }
            set { rvrBnk = value; }
        }

        /// <summary>
        /// Признак конечного состояния.
        /// </summary>
        public bool isEnd
        {
            get
            {
                return (msnr == 0 && cnbl == 0 && (rvrBnk == RiverBank.Right));
            }
        }
    }
}
