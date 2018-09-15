using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Controllers
{
    public class NavController : Controller
    {
        private IProductRepository repository;

        public NavController(IProductRepository repo)
        {
            repository = repo;
        }

        public PartialViewResult MenuEquipment(long category = -1, long equipment = -1)
        {            
            if (category == -1 && equipment >= 0)
                category = repository.Equipments.Where(x => x.EquipmentId == equipment).First().CategoryId ?? -1;

            ViewBag.SelectedEquipments = equipment;
            IEnumerable<SK_EQUIPMENT> equipments = repository.Equipments.Where(x => x.CategoryId == category);
            return PartialView(equipments);
        }

        public PartialViewResult MenuCategory(long category = -1, long equipment = -1)
        {
            if (category == -1 && equipment >= 0)
                category = repository.Equipments.Where(x => x.EquipmentId == equipment).First().CategoryId ?? -1;

            ViewBag.SelectedCategories = category;
            IEnumerable<CT_CATEGORY> categories = repository.Categories;
            return PartialView(categories);
        }
    }
}