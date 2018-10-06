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

        public ViewResult EquipmentEdit(long equipmentId)
        {
            SK_EQUIPMENT equipment = repository.Equipments.Where(p => p.EquipmentId == equipmentId).FirstOrDefault();
            return View(equipment);
        }

        [HttpPost]
        public ActionResult EquipmentEdit(SK_EQUIPMENT equipment)
        {
            if (ModelState.IsValid)
            {
                repository.SaveEquipment(equipment);
                TempData["message"] = string.Format("{0} сохранено", equipment.Code);
                return RedirectToAction("Equipments");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(equipment);
            }
        }
    }
}