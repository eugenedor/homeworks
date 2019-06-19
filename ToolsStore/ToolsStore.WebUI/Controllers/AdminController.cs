using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;

namespace ToolsStore.WebUI.Controllers
{
    //[Authorize]
    public class AdminController : Controller
    {
        private ISettingRepository repository;

        public int PageSize = 4;

        public AdminController(ISettingRepository repo)
        {
            this.repository = repo;
        }

        // GET: Admin
        public ActionResult Index()
        {
            ViewBag.NameApp = this.repository.NameApp();
            return View();
        }
    }
}