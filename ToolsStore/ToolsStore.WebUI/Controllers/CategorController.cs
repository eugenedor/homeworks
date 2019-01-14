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
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.HSSF.Model;
using NPOI.SS.Util;
using System.Text;

namespace ToolsStore.WebUI.Controllers
{
    public class CategorController : Controller
    {
        private IProductRepository repository;

        private delegate ActionResult CategoryDownloadDelegate();

        public CategorController(IProductRepository repo)
        {
            repository = repo;
        }

        public ViewResult Categories(bool orderCategories = false)
        {
            List<string> formats = new List<string>{ "dbf", "xml", "xls", "csv" };
            ViewBag.CategoryFormat = new SelectList(formats);

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

        public ActionResult DownloadCategoryDbf()
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

                var ms = new MemoryStream();
                DbfFile.DataTableToDbf(dtCategory, ms);

                var stream = new StreamWithName()
                {
                    Stream = ms,
                    FileName = "Category.dbf"
                };

                return File(stream.Stream.ToArray(), System.Net.Mime.MediaTypeNames.Application.Soap, stream.FileName);
            }
            catch
            {
                return RedirectToAction("Categories");
            }
        }

        public ActionResult DownloadCategoryXml()
        {
            try
            {
                var obj = new Models.Category.packet();
                obj.hdr = new Models.Category.packetHdr();
                obj.hdr.type = "Category";
                obj.hdr.version = 1.1m;
                obj.hdr.date = DateTime.Now.Date.ToString("yyyy.MM.dd");

                obj.rec = new Models.Category.packetRec[repository.Categories.Count()];
                var rowIndex = 0;
                foreach (var item in repository.Categories.OrderBy(x => x.CategoryId))
                {
                    obj.rec[rowIndex] = new Models.Category.packetRec();
                    obj.rec[rowIndex].Code = item.Code;
                    obj.rec[rowIndex].Name = item.Name;
                    obj.rec[rowIndex].Ord = item.Ord ?? int.MaxValue;
                    rowIndex++;
                }

                var xs = new XmlSerializer(typeof(Models.Category.packet));
                var ms = new MemoryStream();
                var sw = new StreamWriter(ms, System.Text.Encoding.UTF8);
                var xn = new XmlSerializerNamespaces();
                xn.Add("", "");
                xs.Serialize(sw, obj, xn);
                sw.Close();

                var stream = new StreamWithName()
                {
                    Stream = ms,
                    FileName = "Category.xml"
                };

                return File(stream.Stream.ToArray(), System.Net.Mime.MediaTypeNames.Application.Soap, stream.FileName);
            }
            catch
            {
                return RedirectToAction("Categories");
            }
        }

        public ActionResult DownloadCategoryXls()
        {
            try
            {
                var workbook = new HSSFWorkbook();
                var sheetInfo = workbook.CreateSheet("Лист");

                // Заголовки
                var rowIndex = 0;
                var row = sheetInfo.CreateRow(rowIndex);
                row.CreateCell(0).SetCellValue("CODE");
                row.CreateCell(1).SetCellValue("NAME");
                row.CreateCell(2).SetCellValue("ORD");

                rowIndex++;
                var format = workbook.CreateDataFormat();

                // Данные
                foreach (var item in repository.Categories.OrderBy(x => x.CategoryId))
                {
                    row = sheetInfo.CreateRow(rowIndex);
                    row.CreateCell(0).SetCellValue(item.Code);
                    row.CreateCell(1).SetCellValue(item.Name);
                    row.CreateCell(2).SetCellValue((item.Ord ?? int.MaxValue).ToString());
                    rowIndex++;
                }

                var ms = new MemoryStream();
                workbook.Write(ms);

                var stream = new StreamWithName()
                {
                    Stream = ms,
                    FileName = "Category.xls"
                };

                return File(stream.Stream.ToArray(), System.Net.Mime.MediaTypeNames.Application.Soap, stream.FileName);
            }
            catch
            {
                return RedirectToAction("Categories");
            }
        }

        public ActionResult DownloadCategoryCsv()
        {
            try
            {
                StringWriter sw = new StringWriter();

                sw.WriteLine("\"Code\",\"Name\",\"Ord\"");

                Response.ClearContent();
                Encoding encoding = Encoding.UTF8;
                Response.AddHeader("content-disposition", string.Format("attachment;filename={0}.csv", "Category"));
                Response.Charset = encoding.EncodingName;
                Response.ContentType = "application/text";

                foreach (var item in repository.Categories.OrderBy(x => x.CategoryId))
                {
                    sw.WriteLine(string.Format("\"{0}\",\"{1}\",\"{2}\"",

                    item.Code,
                    item.Name,
                    item.Ord ?? int.MaxValue
                    ));
                }
                Response.Write(sw.ToString());
                Response.End();

                return File(Response.OutputStream, "application/csv");
            }
            catch
            {
                return RedirectToAction("Categories");
            }
        }

        public ActionResult CategoryDownload(string categoryFormat = "")
        {
            try
            {
                //словарь вариантов загрузок: ключ и значение (цель делегата)
                Dictionary<string, CategoryDownloadDelegate> dwnlCategory = new Dictionary<string, CategoryDownloadDelegate>
                {
                    { "dbf", DownloadCategoryDbf },
                    { "xml", DownloadCategoryXml },
                    { "xls", DownloadCategoryXls },
                    { "csv", DownloadCategoryCsv }               
                };

                if (!dwnlCategory.ContainsKey(categoryFormat))
                    throw new Exception();

                return dwnlCategory[categoryFormat]();
            }
            catch
            {
                return RedirectToAction("Categories");
            }
        }
    }
}