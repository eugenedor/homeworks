using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Controllers
{
    public class BrandController : Controller
    {
        private IProductRepository repository;

        public BrandController(IProductRepository repo)
        {
            repository = repo;
        }

        public ViewResult Brands()
        {
            return View(repository.Brands);
        }

        public ViewResult BrandEdit(long brandId)
        {
            CT_BRAND brand = repository.Brands.Where(x => x.BrandId == brandId).FirstOrDefault();
            return View(brand);
        }

        [HttpPost]
        public ActionResult BrandEdit(CT_BRAND brand)
        {
            if (ModelState.IsValid)
            {
                repository.SaveBrand(brand);
                TempData["message"] = string.Format("{0} сохранено", brand.Code);
                return RedirectToAction("Brands");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(brand);
            }
        }

        public ViewResult BrandCreate()
        {
            return View("BrandEdit", new CT_BRAND());
        }

        [HttpPost]
        public ActionResult BrandDelete(long brandId)
        {
            CT_BRAND deletedBrand = repository.DeleteBrand(brandId);
            if (deletedBrand != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedBrand.Code);
            }
            return RedirectToAction("Brands");
        }
    }
}