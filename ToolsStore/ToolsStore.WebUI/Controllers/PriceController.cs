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

        public ViewResult Prices()
        {
            return View(((DbQuery<RS_PRICE>)repository.Prices).Include("RS_PRODUCT").Include("CT_VAT").OrderByDescending(x => x.PriceId));
        }
    }
}