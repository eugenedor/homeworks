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
                category = repository.NavEquipments.Where(x => x.EquipmentId == equipment).First().CategoryId;

            ViewBag.SelectedEquipments = equipment;
            IEnumerable<SK_EQUIPMENT> equipments = repository.NavEquipments.Where(x => x.CategoryId == category);
            return PartialView(equipments);
        }

        public PartialViewResult MenuCategory(long category = -1, long equipment = -1)
        {
            if (category == -1 && equipment >= 0)
                category = repository.NavEquipments.Where(x => x.EquipmentId == equipment).First().CategoryId;

            ViewBag.SelectedCategories = category;
            IEnumerable<CT_CATEGORY> categories = repository.NavCategories;
            return PartialView(categories);
        }
    }
}