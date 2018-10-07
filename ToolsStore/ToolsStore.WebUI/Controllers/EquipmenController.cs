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
            IEnumerable<CT_CATEGORY> categories = repository.Categories;

            EquipmentViewModel model = new EquipmentViewModel
            {
                Equipment = equipment,
                Categories = categories
            };

            return View(model);
        }

        [HttpPost]
        public ActionResult EquipmentEdit(EquipmentViewModel model)
        {
            if (ModelState.IsValid)
            {
                repository.SaveEquipment(model.Equipment);
                TempData["message"] = string.Format("{0} сохранено", model.Equipment.Code);
                return RedirectToAction("Equipments");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(model);
            }
        }

        public ViewResult EquipmentCreate()
        {
            IEnumerable<CT_CATEGORY> categories = repository.Categories;
            EquipmentViewModel model = new EquipmentViewModel
            {
                Equipment = new SK_EQUIPMENT(),
                Categories = categories
            };

            return View("EquipmentEdit", model);
        }

        [HttpPost]
        public ActionResult EquipmentDelete(long equipmentId)
        {
            SK_EQUIPMENT deletedEquipment = repository.DeleteEquipment(equipmentId);
            if (deletedEquipment != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedEquipment.Code);
            }
            return RedirectToAction("Equipments");
        }
    }
}