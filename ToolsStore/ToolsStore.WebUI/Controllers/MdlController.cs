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
    public class MdlController : Controller
    {
        private IProductRepository repository;

        public MdlController(IProductRepository repo)
        {
            repository = repo;
        }

        public ViewResult Models()
        {
            return View(((DbQuery<SK_MODEL>)repository.Models).Include("CT_BRAND"));
        }
    }
}