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

        public ViewResult RulesSpec(bool isHidden = false, long? loadRuleId = null, string returnUrl = null)
        {
            ViewBag.Hidden = isHidden;
            ViewBag.ReturnUrl = returnUrl ?? Url.Action("Index", "Admin");
            IQueryable<MT_LOAD_RULE_SPEC> loadRulesSpec = repository.LoadRulesSpec;
            if (loadRuleId != null)
                loadRulesSpec = loadRulesSpec.Where(x => x.LoadRuleId == loadRuleId);

            return View(((DbQuery<MT_LOAD_RULE_SPEC>)loadRulesSpec).Include("MT_LOAD_RULE"));
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
            string err = string.Empty;
            if (ModelState.IsValid)
            {
                ruleSpecVM.LoadRules = repository.LoadRules;
                if (file != null)
                {

                    ruleSpecVM.LoadRuleSpec.Data = new byte[file.ContentLength];
                    ruleSpecVM.LoadRuleSpec.MimeType = file.ContentType;                    
                    ruleSpecVM.LoadRuleSpec.FileName = file.FileName;
                    ruleSpecVM.LoadRuleSpec.Size = file.ContentLength;
                    file.InputStream.Read(ruleSpecVM.LoadRuleSpec.Data, 0, file.ContentLength);
                }                  

                repository.SaveLoadRuleSpec(ruleSpecVM.LoadRuleSpec, out err);

                if (!string.IsNullOrEmpty(err))
                {
                    TempData["message"] = string.Format("Ошибка: {0}", err);
                    return View(ruleSpecVM);
                }

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
        
        [HttpPost]
        public ActionResult RuleSpecDelete(long loadRuleSpecId)
        {
            MT_LOAD_RULE_SPEC deletedRuleSpec = repository.DeleteLoadRuleSpec(loadRuleSpecId);
            if (deletedRuleSpec != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedRuleSpec.LoadRuleSpecId);
            }
            return RedirectToAction("RulesSpec");
        }

        [HttpGet]
        public ActionResult DownLoadFile(long loadRuleSpecId)
        {
            MT_LOAD_RULE_SPEC loadRuleSpec = repository.LoadRulesSpec.Where(x => x.LoadRuleSpecId == loadRuleSpecId).FirstOrDefault();
            IEnumerable<MT_LOAD_RULE> loadRules = repository.LoadRules;

            var ruleSpecVM = new RuleSpecViewModel
            {
                LoadRuleSpec = loadRuleSpec,
                LoadRules = loadRules
            };

            if (ruleSpecVM != null
                && ruleSpecVM.LoadRuleSpec != null
                && ruleSpecVM.LoadRuleSpec.Data != null
                && ruleSpecVM.LoadRuleSpec.MimeType != null)
            {
                return File(ruleSpecVM.LoadRuleSpec.Data, ruleSpecVM.LoadRuleSpec.MimeType, ruleSpecVM.LoadRuleSpec.FileName);
            }

            return View("RuleSpecEdit", ruleSpecVM);
        }
    }
}