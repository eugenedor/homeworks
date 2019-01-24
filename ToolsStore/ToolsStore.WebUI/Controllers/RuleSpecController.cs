using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Controllers
{
    public class RuleSpecController : Controller
    {
        private IRuleRepository repository;

        public RuleSpecController(IRuleRepository repo)
        {
            repository = repo;
        }

        public ViewResult RulesSpec()
        {
            return View(repository.LoadRulesSpec);
        }
    }
}