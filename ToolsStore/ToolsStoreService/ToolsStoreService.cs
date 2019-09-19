using System;
using System.ServiceProcess;
using ToolsStoreService.log;
using ToolsStoreService.file;
using System.Timers;

namespace ToolsStoreService
{
    public partial class ToolsStoreService : ServiceBase
    {
        private readonly Object _locker;
        private Timer _timer;
        public const int TIME_INTERVAL_DEFAULT = 86400; //интервал по умолчанию = суткам (в сек)

        public ToolsStoreService()
        {
            _locker = new object();
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            int timeInterval;
            lock (_locker)
            {
                Log.write("Сервис стартовал." + Environment.NewLine);                
                try
                {
                    FileManager.LoadFiles(); //запуск загрузки xml при старте
                }
                catch (Exception ex)
                {
                    Log.write(ex.Message);
                }

                Int32.TryParse(System.Configuration.ConfigurationManager.AppSettings["timeInterval"], out timeInterval);
                if (timeInterval == 0)
                    timeInterval = TIME_INTERVAL_DEFAULT;

                _timer = new System.Timers.Timer((double)timeInterval * 1000) { Enabled = true, AutoReset = false };
                _timer.Elapsed += TimerElapsed;  //запуск по таймеру спустя интервал времени
            }
        }

        protected override void OnStop()
        {
            lock (_locker)
            {
                try
                {
                    if (_timer != null)
                    {
                        _timer.Stop();
                        _timer.Dispose();
                    }
                    _timer = null;
                }
                catch (Exception ex)
                {
                    Log.write(ex.Message);
                }
                finally
                {
                    Log.write("Сервис остановлен." + Environment.NewLine);
                }
            }
        }

        private void TimerElapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            lock (_locker)
            {
                try
                {
                    _timer.Stop();
                    FileManager.LoadFiles();
                }
                catch (Exception ex)
                {
                    Log.write(ex.Message);
                }
                finally
                {
                    _timer.Start();
                }
            }
        }
    }
}
