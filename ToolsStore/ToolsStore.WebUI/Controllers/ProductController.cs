using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
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
            return View(repository.Products);
        }

        public ViewResult ProductEdit(long productId)
        {
            RS_PRODUCT product = repository.Prdcts.Where(p => p.ProductId == productId).FirstOrDefault();
            IEnumerable<SK_EQUIPMENT> equipments = repository.Equipments;
            IEnumerable<CT_BRAND> brands = repository.Brands;
            IEnumerable<SK_MODEL> models = repository.Models;

            CT_IMAGE image = repository.Images.Where(i => i.ImageId == product.ImageId).FirstOrDefault();

            ProductViewModel productVM = new ProductViewModel
            {
                Product = product,
                Equipments = equipments,
                Brands = brands,
                Models = models,
                Image = image
            };

            return View(productVM);
        }

        [HttpPost]
        public ActionResult ProductEdit(ProductViewModel productVM)
        {
            if (ModelState.IsValid)
            {
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
    }
}