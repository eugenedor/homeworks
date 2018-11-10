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
            return View(repository.Vats.OrderByDescending(x => x.VatId));
        }

        public ViewResult VatEdit(long vatId)
        {
            CT_VAT vat = repository.Vats.Where(p => p.VatId == vatId).FirstOrDefault();
            return View(vat);
        }

        [HttpPost]
        public ActionResult VatEdit(CT_VAT vat)
        {
            if (ModelState.IsValid)
            {
                repository.SaveVat(vat);
                TempData["message"] = string.Format("{0} сохранено", vat.Code.ToString());
                return RedirectToAction("Vats");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(vat);
            }
        }

        public ViewResult VatCreate()
        {
            var vat = new CT_VAT() { IsActive = true };
            return View("VatEdit", vat);
        }

        [HttpPost]
        public ActionResult VatDelete(long vatId)
        {
            CT_VAT deletedVat = repository.DeleteVat(vatId);
            if (deletedVat != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedVat.Code.ToString());
            }
            return RedirectToAction("Vats");
        }
    }
}