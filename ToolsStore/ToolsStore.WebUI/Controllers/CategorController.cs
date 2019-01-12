using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;
using System.Data;
using System.IO;
using ToolsStore.WebUI.Models;
using System.Xml.Serialization;

namespace ToolsStore.WebUI.Controllers
{
    public class CategorController : Controller
    {
        private IProductRepository repository;

        public CategorController(IProductRepository repo)
        {
            repository = repo;
        }

        public ViewResult Categories(bool orderCategories = false)
        {
            if (orderCategories)
                return View(repository.Categories.OrderBy(x => x.CategoryId));

            return View(repository.Categories.OrderByDescending(x => x.CategoryId));
        }

        public ViewResult CategoryEdit(long categoryId)
        {
            CT_CATEGORY category = repository.Categories.Where(p => p.CategoryId == categoryId).FirstOrDefault();
            return View(category);
        }

        [HttpPost]
        public ActionResult CategoryEdit(CT_CATEGORY category)
        {
            if (ModelState.IsValid)
            {
                repository.SaveCategory(category);
                TempData["message"] = string.Format("{0} сохранено", category.Code);
                return RedirectToAction("Categories");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(category);
            }
        }

        public ViewResult CategoryCreate()
        {
            return View("CategoryEdit", new CT_CATEGORY());
        }

        [HttpPost]
        public ActionResult CategoryDelete(long categoryId)
        {
            CT_CATEGORY deletedCategory = repository.DeleteCategory(categoryId);
            if (deletedCategory != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedCategory.Code);
            }
            return RedirectToAction("Categories");
        }

        public ActionResult DownloadCategoryDBF()
        {
            try
            {
                DataTable dtCategory = new DataTable("CT_CATEGORY");

                DataColumn dcCode = dtCategory.Columns.Add("CODE", typeof(string));
                dcCode.MaxLength = 100;
                DataColumn dcName = dtCategory.Columns.Add("NAME", typeof(string));
                dcName.MaxLength = 250;
                DataColumn dcOrd = dtCategory.Columns.Add("ORD", typeof(int));
                dcOrd.Caption = "[25]";

                var categories = (from ct in repository.Categories
                                  select new
                                  {
                                      Code = ct.Code,
                                      Name = ct.Name,
                                      Ord = ct.Ord ?? int.MaxValue
                                  }).ToList();

                foreach (var category in categories)
                {
                    DataRow row = dtCategory.NewRow();
                    row.SetField<string>("CODE", category.Code);
                    row.SetField<string>("NAME", category.Name);
                    row.SetField<int>("ORD", category.Ord);
                    dtCategory.Rows.Add(row);
                }

                MemoryStream ms = new MemoryStream();
                DbfFile.DataTableToDbf(dtCategory, ms);

                var stream = new StreamWithName()
                {
                    Stream = ms,
                    FileName = "CATEGORY.DBF"
                };

                return File(stream.Stream.ToArray(), System.Net.Mime.MediaTypeNames.Application.Soap, stream.FileName);
            }
            catch
            {
                return RedirectToAction("Categories");
            }
        }

        public ActionResult DownloadCategoryXML()
        {
            try
            {
                var obj = new Models.Category.packet();
                obj.hdr = new Models.Category.packetHdr();
                obj.hdr.type = "Category";
                obj.hdr.version = 1.1m;
                obj.hdr.date = DateTime.Now.Date.ToString("yyyy.MM.dd");

                obj.rec = new Models.Category.packetRec[repository.Categories.Count()];
                int i = 0;
                foreach (var item in repository.Categories.OrderBy(x => x.CategoryId))
                {
                    obj.rec[i] = new Models.Category.packetRec();
                    obj.rec[i].Code = item.Code;
                    obj.rec[i].Name = item.Name;
                    obj.rec[i].Ord = item.Ord ?? int.MaxValue;
                    i++;
                }

                XmlSerializer xs = new XmlSerializer(typeof(Models.Category.packet));
                MemoryStream ms = new MemoryStream();
                StreamWriter sw = new StreamWriter(ms, System.Text.Encoding.UTF8);
                XmlSerializerNamespaces xn = new XmlSerializerNamespaces();
                xn.Add("", "");
                xs.Serialize(sw, obj, xn);
                sw.Close();

                var stream = new StreamWithName()
                {
                    Stream = ms,
                    FileName = "CATEGORY.XML"
                };

                return File(stream.Stream.ToArray(), System.Net.Mime.MediaTypeNames.Application.Soap, stream.FileName);
            }
            catch
            {
                return RedirectToAction("Categories");
            }
        }
    }
}