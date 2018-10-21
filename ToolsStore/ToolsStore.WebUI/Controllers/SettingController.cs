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
    }
}