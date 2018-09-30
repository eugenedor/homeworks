using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Controllers
{
    public class CategorController : Controller
    {
        private IProductRepository repository;

        public CategorController(IProductRepository repo)
        {
            repository = repo;
        }

        public ViewResult Index()
        {
            return View(repository.Categories);
        }

        public ViewResult Edit(long categoryId)
        {
            CT_CATEGORY category = repository.Categories.Where(p => p.CategoryId == categoryId).FirstOrDefault();
            return View(category);
        }

        [HttpPost]
        public ActionResult Edit(CT_CATEGORY category)
        {
            if (ModelState.IsValid)
            {
                repository.SaveCategory(category);
                TempData["message"] = string.Format("{0} сохранено", category.Code);
                return RedirectToAction("Index");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(category);
            }
        }

        public ViewResult Create()
        {
            return View("Edit", new CT_CATEGORY());
        }

        [HttpPost]
        public ActionResult Delete(long categoryId)
        {
            CT_CATEGORY deletedCategory = repository.DeleteCategory(categoryId);
            if (deletedCategory != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedCategory.Code);
            }
            return RedirectToAction("Index");
        }
    }
}