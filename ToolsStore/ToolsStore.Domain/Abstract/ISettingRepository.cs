using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface ISettingRepository
    {
        IQueryable<MT_SETTING> Settings { get; }

        void SaveSetting(MT_SETTING setting);

        MT_SETTING DeleteSetting(long settingId);
    }
}
