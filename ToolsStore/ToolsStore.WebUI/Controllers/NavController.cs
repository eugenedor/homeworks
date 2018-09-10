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

        public PartialViewResult MenuEquipment(long equipment = -1)
        {
            ViewBag.SelectedEquipments = equipment;

            IEnumerable<SK_EQUIPMENT> equipments = (from eqp in repository.Equipments
                                                        //join cat1 in repository.Categories on eqp.CategoryId equals cat1.CategoryId into cat2
                                                        //from cat in cat2.DefaultIfEmpty()
                                                        //orderby eqp.CategoryId != null ? cat.Ord : 0 ascending, eqp.Ord ascending
                                                    select eqp).Distinct();

            return PartialView(equipments);
        }

        public PartialViewResult MenuCategory(long category = -1)
        {
            ViewBag.SelectedCategories = category;

            IEnumerable<CT_CATEGORY> categories = (from ct in repository.Categories
                                                   select ct).Distinct();

            return PartialView(categories);
        }
    }
}