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
    public class MdlController : Controller
    {
        private IProductRepository repository;

        public MdlController(IProductRepository repo)
        {
            repository = repo;
        }

        public ViewResult Mdls(long? searchBrand = null, bool orderMdls = false)
        {
            ViewBag.SearchBrand = new SelectList(repository.Brands, "BrandId", "Name");

            IQueryable<SK_MODEL> mdl = repository.Models;     
            if (searchBrand != null)
                mdl = mdl.Where(x => x.BrandId == (long)searchBrand);

            mdl = (orderMdls) ? mdl.OrderBy(x => x.ModelId) : mdl.OrderByDescending(x => x.ModelId);

            return View(((DbQuery<SK_MODEL>)mdl).Include("CT_BRAND"));
        }

        public ViewResult MdlEdit(long modelId)
        {
            SK_MODEL mdl = repository.Models.Where(x => x.ModelId == modelId).FirstOrDefault();
            IEnumerable<CT_BRAND> brands = repository.Brands;

            var mdlVM = new MdlViewModel
            {
                Mdl = mdl,
                Brands = brands
            };

            return View(mdlVM);
        }

        [HttpPost]
        public ActionResult MdlEdit(MdlViewModel mdlVM)
        {
            if (ModelState.IsValid)
            {
                repository.SaveModel(mdlVM.Mdl);
                TempData["message"] = string.Format("{0} сохранено", mdlVM.Mdl.Code);
                return RedirectToAction("Mdls");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(mdlVM);
            }
        }

        public ViewResult MdlCreate()
        {
            IEnumerable<CT_BRAND> brands = repository.Brands;

            var mdlVM = new MdlViewModel
            {
                Mdl = new SK_MODEL(),
                Brands = brands
            };

            return View("MdlEdit", mdlVM);
        }

        [HttpPost]
        public ActionResult MdlDelete(long modelId)
        {
            SK_MODEL deletedModel = repository.DeleteModel(modelId);
            if (deletedModel != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedModel.Code);
            }
            return RedirectToAction("Mdls");
        }
    }
}