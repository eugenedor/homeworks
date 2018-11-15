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
    public class PriceController : Controller
    {
        private IProductRepository repository;

        public PriceController(IProductRepository repo)
        {
            repository = repo;
        }

        public ViewResult Prices(string searchProduct = null, bool orderPrices = false)
        {
            DbQuery<RS_PRICE> prices;
            if (!string.IsNullOrEmpty(searchProduct))
                prices = (DbQuery<RS_PRICE>)repository.Prices.Where(x => x.RS_PRODUCT.Name.Contains(searchProduct));
            else
                prices = (DbQuery<RS_PRICE>)repository.Prices;

            if (orderPrices)
                return View(prices.Include("RS_PRODUCT").Include("CT_VAT").OrderBy(x => x.PriceId));

            return View(prices.Include("RS_PRODUCT").Include("CT_VAT").OrderByDescending(x => x.PriceId));
        }

        public ViewResult PriceEdit(long priceId)
        {
            RS_PRICE price = repository.Prices.Where(x => x.PriceId == priceId).FirstOrDefault();
            IEnumerable<RS_PRODUCT> products = repository.Productts;
            IEnumerable<CT_VAT> vats = repository.Vats;

            var priceVM = new PriceViewModel
            {
                Price = price,
                Products = products,
                Vats = vats
            };

            return View(priceVM);
        }

        [HttpPost]
        public ActionResult PriceEdit(PriceViewModel priceVM)
        {
            if (ModelState.IsValid)
            {
                repository.SavePrice(priceVM.Price);
                TempData["message"] = string.Format("{0} сохранено", priceVM.Price.PriceId.ToString());
                return RedirectToAction("Prices");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(priceVM);
            }
        }

        public ViewResult PriceCreate()
        {
            IEnumerable<RS_PRODUCT> products = repository.Productts;
            IEnumerable<CT_VAT> vats = repository.Vats;

            var priceVM = new PriceViewModel
            {
                Price = new RS_PRICE(),
                Products = products,
                Vats = vats
            };

            return View("PriceEdit", priceVM);
        }

        [HttpPost]
        public ActionResult PriceDelete(long priceId)
        {
            RS_PRICE deletedPrice = repository.DeletePrice(priceId);
            if (deletedPrice != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedPrice.PriceId.ToString());
            }
            return RedirectToAction("Prices");
        }
    }
}