using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;


namespace ToolsStore.Domain.Concrete
{
    public class EFSettingRepository : ISettingRepository
    {
        private EFDbContext context = new EFDbContext();

        public IQueryable<MT_SETTING> Settings
        {
            get { return context.MT_SETTING; }
        }

        public void SaveSetting(MT_SETTING setting)
        {
            if (setting.SettingId == 0)
            {
                context.MT_SETTING.Add(setting);
            }
            else
            {
                MT_SETTING dbEntry = context.MT_SETTING.Where(x => x.SettingId == setting.SettingId).Single();
                if (dbEntry != null)
                {
                    dbEntry.Code = setting.Code;
                    dbEntry.Value = setting.Value;
                    dbEntry.Descr = setting.Descr;
                    dbEntry.IsActive = setting.IsActive;
                }
            }
            context.SaveChanges();
        }

        public MT_SETTING DeleteSetting(long settingId)
        {
            MT_SETTING dbEntry = context.MT_SETTING.Where(x => x.SettingId == settingId).Single();
            if (dbEntry != null)
            {
                context.MT_SETTING.Remove(dbEntry);
                context.SaveChanges();
            }
            return dbEntry;
        }

        public string NameApp()
        {
            string nameApp;
            nameApp = context.MT_SETTING.Where(x => x.Code.ToLower() == "nameapp").FirstOrDefault().Value.ToString() ?? "Магазин инструментов";
            return nameApp;
        }
    }
}
