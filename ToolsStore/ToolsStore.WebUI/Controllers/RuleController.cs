using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Controllers
{
    public class RuleController : Controller
    {
        private IRuleRepository repository;

        public RuleController(IRuleRepository repo)
        {
            repository = repo;
        }

        public ViewResult Index()
        {
            return View(repository.LoadRules);
        }

        public ViewResult Edit(int loadRuleId)
        {
            MT_LOAD_RULE loadRule = repository.LoadRules.Where(p => p.LoadRuleId == loadRuleId).FirstOrDefault(); //.FirstOrDefault(p => p.LoadRuleId == loadRuleId);
            return View(loadRule);
        }

        [HttpPost]
        public ActionResult Edit(MT_LOAD_RULE loadRule)
        {
            if (ModelState.IsValid)
            {
                repository.SaveLoadRule(loadRule);
                TempData["message"] = string.Format("{0} сохранено", loadRule.Code);
                return RedirectToAction("Index");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(loadRule);
            }
        }

        public ViewResult Create()
        {
            return View("Edit", new MT_LOAD_RULE());
        }

        [HttpPost]
        public ActionResult Delete(long loadRuleId)
        {
            MT_LOAD_RULE deletedLoadRule = repository.DeleteLoadRule(loadRuleId);
            if (deletedLoadRule != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedLoadRule.Code);
            }
            return RedirectToAction("Index");
        }
    }
}