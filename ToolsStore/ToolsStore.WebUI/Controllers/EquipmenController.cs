using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity.Infrastructure;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Controllers
{
    public class EquipmenController : Controller
    {
        private IProductRepository repository;

        public EquipmenController(IProductRepository repo)
        {
            repository = repo;
        }

        public ViewResult Equipments()
        {
            return View(((DbQuery<SK_EQUIPMENT>)repository.Equipments).Include("CT_CATEGORY"));
        }
    }
}