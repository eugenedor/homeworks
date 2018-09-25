using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;

namespace ToolsStore.WebUI.Controllers
{
    public class AdminController : Controller
    {
        private IRuleRepository repository;

        public AdminController(IRuleRepository repo)
        {
            repository = repo;
        }

        // GET: Admin
        public ViewResult Index()
        {
            return View(repository.LoadRules);
        }
    }
}