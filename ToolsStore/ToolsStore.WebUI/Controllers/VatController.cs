using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Controllers
{
    public class VatController : Controller
    {
        private IProductRepository repository;

        public VatController(IProductRepository repo)
        {
            repository = repo;
        }

        public ViewResult Vats()
        {
            return View(repository.Vats);
        }
    }
}