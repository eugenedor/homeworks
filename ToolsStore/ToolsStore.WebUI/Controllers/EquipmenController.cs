﻿using System;
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

        public ViewResult Equipments(long? searchCategory = null, bool orderCategory = false)
        {
            ViewBag.SearchCategory = new SelectList(repository.Categories, "CategoryId", "Name");

            IQueryable<SK_EQUIPMENT> equipments = repository.Equipments;
            if (searchCategory != null)
                equipments = equipments.Where(x => x.CategoryId == searchCategory);

            equipments = (orderCategory) ? equipments.OrderBy(x => x.EquipmentId) : equipments.OrderByDescending(x => x.EquipmentId);

            return View(((DbQuery<SK_EQUIPMENT>)equipments).Include("CT_CATEGORY"));
        }

        public ViewResult EquipmentEdit(long equipmentId)
        {
            SK_EQUIPMENT equipment = repository.Equipments.Where(p => p.EquipmentId == equipmentId).FirstOrDefault();
            IEnumerable<CT_CATEGORY> categories = repository.Categories;

            var equipmentVM = new EquipmentViewModel
            {
                Equipment = equipment,
                Categories = categories
            };

            return View(equipmentVM);
        }

        [HttpPost]
        public ActionResult EquipmentEdit(EquipmentViewModel equipmentVM)
        {
            if (ModelState.IsValid)
            {
                repository.SaveEquipment(equipmentVM.Equipment);
                TempData["message"] = string.Format("{0} сохранено", equipmentVM.Equipment.Code);
                return RedirectToAction("Equipments");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(equipmentVM);
            }
        }

        public ViewResult EquipmentCreate()
        {
            IEnumerable<CT_CATEGORY> categories = repository.Categories;

            var equipmentVM = new EquipmentViewModel
            {
                Equipment = new SK_EQUIPMENT(),
                Categories = categories
            };

            return View("EquipmentEdit", equipmentVM);
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

        public ActionResult EquipmentRefreshActive()
        {
            repository.RefreshEquipmentIsActive();
            return RedirectToAction("Equipments");
        }

        public ActionResult SetEquipmentIsActive(bool equipmentIsActive = false)
        {
            repository.SetEquipmentIsActive(equipmentIsActive);
            return RedirectToAction("Equipments");
        }
    }
}