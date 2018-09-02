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

        public PartialViewResult Menu()
        {
            IEnumerable<SK_EQUIPMENT> equipments = (from eqp in repository.Equipments
                                                    join cat1 in repository.Categories on eqp.CategoryId equals cat1.CategoryId into cat2
                                                    from cat in cat2.DefaultIfEmpty()
                                                    orderby eqp.CategoryId != null ? cat.Ord : 0 ascending, eqp.Ord ascending
                                                    select eqp).Distinct();

            return PartialView(equipments);
        }
    }
}