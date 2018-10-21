using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Controllers
{
    public class SettingController : Controller
    {
        private ISettingRepository repository;

        public SettingController(ISettingRepository repo)
        {
            repository = repo;
        }

        public ViewResult Settings()
        {
            return View(repository.Settings);
        }

        [HttpGet]
        public ViewResult SettingEdit(long settingId)
        {
            MT_SETTING setting = repository.Settings.Where(x => x.SettingId == settingId).FirstOrDefault(); //.FirstOrDefault(x => x.SettingId == settingId);
            return View(setting);
        }

        [HttpPost]
        public ActionResult SettingEdit(MT_SETTING setting)
        {
            if (ModelState.IsValid)
            {
                repository.SaveSetting(setting);
                TempData["message"] = string.Format("{0} сохранено", setting.Code);
                return RedirectToAction("Settings");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(setting);
            }
        }

        public ViewResult SettingCreate()
        {
            return View("SettingEdit", new MT_SETTING());
        }

        [HttpPost]
        public ActionResult SettingDelete(long settingId)
        {
            MT_SETTING deletedSetting = repository.DeleteSetting(settingId);
            if (deletedSetting != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedSetting.Code);
            }
            return RedirectToAction("Settings");
        }
    }
}