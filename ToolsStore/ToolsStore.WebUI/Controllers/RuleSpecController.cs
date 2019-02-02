using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity.Infrastructure;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;
using ToolsStore.WebUI.Models;

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
            return View(((DbQuery<MT_LOAD_RULE_SPEC>)repository.LoadRulesSpec).Include("MT_LOAD_RULE"));
        }

        [HttpGet]
        public ViewResult RuleSpecEdit(long loadRuleSpecId)
        {
            MT_LOAD_RULE_SPEC loadRuleSpec = repository.LoadRulesSpec.Where(x => x.LoadRuleSpecId == loadRuleSpecId).FirstOrDefault();
            IEnumerable<MT_LOAD_RULE> loadRules = repository.LoadRules;

            var ruleSpecVM = new RuleSpecViewModel
            {
                LoadRuleSpec = loadRuleSpec,
                LoadRules = loadRules
            };

            return View(ruleSpecVM);
        }

        [HttpPost]
        public ActionResult RuleSpecEdit(RuleSpecViewModel ruleSpecVM, HttpPostedFileBase file = null)
        {
            if (ModelState.IsValid)
            {
                if (file != null)
                {

                    ruleSpecVM.LoadRuleSpec.MimeType = file.ContentType;
                    ruleSpecVM.LoadRuleSpec.Data = new byte[file.ContentLength];
                    ruleSpecVM.LoadRuleSpec.Name = file.FileName;
                    file.InputStream.Read(ruleSpecVM.LoadRuleSpec.Data, 0, file.ContentLength);
                }

                repository.SaveLoadRuleSpec(ruleSpecVM.LoadRuleSpec);
                TempData["message"] = string.Format("{0} сохранено", ruleSpecVM.LoadRuleSpec.LoadRuleSpecId.ToString());
                return RedirectToAction("RulesSpec");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(ruleSpecVM);
            }
        }

        public ViewResult RuleSpecCreate()
        {
            IEnumerable<MT_LOAD_RULE> loadRules = repository.LoadRules;

            var ruleSpecVM = new RuleSpecViewModel
            {
                LoadRuleSpec = new MT_LOAD_RULE_SPEC(),
                LoadRules = loadRules
            };

            return View("RuleSpecEdit", ruleSpecVM);
        }
    }
}