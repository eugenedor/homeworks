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
    public class ProductController : Controller
    {
        private IProductRepository repository;

        public int PageSize = 4;

        public ProductController(IProductRepository repo)
        {
            this.repository = repo;
        }

        public int GetTotalItems(long category, long equipment)
        {
            if (category == -1 && equipment == -1)
                return repository.Products.Count();

            if (category == -1 && equipment >= 0)
                return repository.Products.Where(x => x.EquipmentId == equipment).Count();

            if (category >= 0 && equipment == -1)
                return repository.Products.Where(x => x.CategoryId == category).Count();

            return repository.Products.Where(x => x.EquipmentId == equipment && x.CategoryId == category).Count();
        }

        public ViewResult List(long category, long equipment, int page = 1)
        {
            //return View(repository.Products
            //                      .OrderBy(p => p.ProductId)
            //                      .Skip((page - 1) * PageSize)
            //                      .Take(PageSize));

            DateTime curDate = DateTime.Today;

            IEnumerable<Product> prd = (from p in repository.Products
                                        where (equipment == -1 || p.EquipmentId == equipment)
                                              && (category == -1 || p.CategoryId == category)
                                        orderby p.ProductId
                                        select p).Skip((page - 1) * PageSize).Take(PageSize);

            int totalItems = GetTotalItems(category, equipment);

            ProductsListViewModel model = new ProductsListViewModel
            {
                Products = prd,

                PagingInfo = new PagingInfo
                {
                    CurrentPage = page,
                    ItemsPerPage = PageSize,
                    TotalItems = totalItems
                },
                CurrentEquipment = equipment,
                CurrentCategory = category
            };

            return View(model);
        }

        public ViewResult Products()
        {
            return View(((DbQuery<RS_PRODUCT>)repository.Productts).Include("SK_EQUIPMENT").Include("SK_MODEL").OrderByDescending(x => x.ProductId));
        }

        public ViewResult ProductEdit(long productId)
        {
            RS_PRODUCT product = repository.Productts.Where(p => p.ProductId == productId).FirstOrDefault();
            IEnumerable<SK_EQUIPMENT> equipments = repository.Equipments;
            IEnumerable<SK_MODEL> models = repository.Models;
            CT_IMAGE image = repository.Images.Where(i => i.ImageId == product.ImageId).FirstOrDefault();

            ProductViewModel productVM = new ProductViewModel
            {
                Product = product,
                Equipments = equipments,
                Models = models
            };
            productVM.Product.CT_IMAGE = image;

            return View(productVM);
        }

        [HttpPost]
        public ActionResult ProductEdit(ProductViewModel productVM, HttpPostedFileBase image = null)
        {
            if (ModelState.IsValid)
            {
                if (productVM.Product.CT_IMAGE == null)
                    productVM.Product.CT_IMAGE = new CT_IMAGE();

                if (image != null)
                {
                    productVM.Product.CT_IMAGE.MimeType = image.ContentType;
                    productVM.Product.CT_IMAGE.Data = new byte[image.ContentLength];
                    productVM.Product.CT_IMAGE.Name = image.FileName;
                    image.InputStream.Read(productVM.Product.CT_IMAGE.Data, 0, image.ContentLength);
                }

                repository.SaveProduct(productVM.Product);
                TempData["message"] = string.Format("{0} сохранено", productVM.Product.Name);
                return RedirectToAction("Products");
            }
            else
            {
                // что-то не так с значениями данных (there is something wrong with the data values)
                return View(productVM);
            }
        }

        public ViewResult ProductCreate()
        {
            IEnumerable<SK_EQUIPMENT> equipments = repository.Equipments;
            IEnumerable<SK_MODEL> models = repository.Models;

            ProductViewModel productVM = new ProductViewModel
            {
                Product = new RS_PRODUCT(),
                Equipments = equipments,
                Models = models
            };
            productVM.Product.IsActive = true; //default

            return View("ProductEdit", productVM);
        }

        [HttpPost]
        public ActionResult ProductDelete(long productId)
        {
            RS_PRODUCT deletedProduct = repository.DeleteProduct(productId);
            if (deletedProduct != null)
            {
                TempData["message"] = string.Format("{0} был удален", deletedProduct.Name);
            }
            return RedirectToAction("Products");
        }

        public FileContentResult GetImage(long imageId)
        {
            CT_IMAGE image = repository.Images.FirstOrDefault(i => i.ImageId == imageId);  //repository.Images.Where(i => i.ImageId == imageId).FirstOrDefault()
            if (image != null)
            {
                return File(image.Data, image.MimeType);
            }
            else
            {
                return null;
            }
        }

        [HttpGet]
        public ActionResult DownLoadFile(long productId)
        {
            RS_PRODUCT product = repository.Productts.Where(p => p.ProductId == productId).FirstOrDefault();
            IEnumerable<SK_EQUIPMENT> equipments = repository.Equipments;
            IEnumerable<SK_MODEL> models = repository.Models;
            CT_IMAGE image = repository.Images.Where(i => i.ImageId == product.ImageId).FirstOrDefault();

            ProductViewModel productVM = new ProductViewModel
            {
                Product = product,
                Equipments = equipments,
                Models = models
            };
            productVM.Product.CT_IMAGE = image;
        
            if (image != null && image.Data != null && image.MimeType != null)
            {
                return File(image.Data, image.MimeType, image.Name);
            }
        
            return View("ProductEdit", productVM);
        }

        public ViewResult ProductInfo(long productId, string returnUrl)
        {
            Product product = repository.Products.Where(p => p.ProductId == productId).FirstOrDefault();
            ViewBag.ReturnUrl = returnUrl;
            return View(product);
        }

        public ActionResult ClearImage(long productId)
        {
            repository.ClearImage(productId);
            TempData["message"] = string.Format("Изображение очищено");
            return RedirectToAction("Products");
        }
    }
}