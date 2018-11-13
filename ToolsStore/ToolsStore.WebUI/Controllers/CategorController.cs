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

        public ViewResult Categories(bool orderCategories = false)
        {
            if (orderCategories)
                return View(repository.Categories.OrderBy(x => x.CategoryId));
            else
                return View(repository.Categories.OrderByDescending(x => x.CategoryId));
        }

        public ViewResult CategoryEdit(long categoryId)
        {
            CT_CATEGORY category = repository.Categories.Where(p => p.CategoryId == categoryId).FirstOrDefault();
            return View(category);
        }

        [HttpPost]
        public ActionResult CategoryEdit(CT_CATEGORY category)
        {
            if (ModelState.IsValid)
            {
                repository.SaveCategory(category);
                TempData["message"] = string.Format("{0} сохранено", category.Code);
                return RedirectToAction("Categories");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(category);
            }
        }

        public ViewResult CategoryCreate()
        {
            return View("CategoryEdit", new CT_CATEGORY());
        }

        [HttpPost]
        public ActionResult CategoryDelete(long categoryId)
        {
            CT_CATEGORY deletedCategory = repository.DeleteCategory(categoryId);
            if (deletedCategory != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedCategory.Code);
            }
            return RedirectToAction("Categories");
        }
    }
}