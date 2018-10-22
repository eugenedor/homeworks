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
    }
}