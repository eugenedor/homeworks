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
        public ProductController(IProductRepository productRepository)
        {
            this.repository = productRepository;
        }

        public ViewResult List(long equipment, int page = 1)
        {
            //return View(repository.Products
            //                      .OrderBy(p => p.ProductId)
            //                      .Skip((page - 1) * PageSize)
            //                      .Take(PageSize));

            ProductsListViewModel model = new ProductsListViewModel
            {
                Products = repository.Products
                                .Where(p => equipment == -1 || p.EquipmentId == equipment)
                                     .OrderBy(p => p.ProductId)
                                     .Skip((page - 1) * PageSize)
                                     .Take(PageSize),

                PagingInfo = new PagingInfo
                {
                    CurrentPage = page,
                    ItemsPerPage = PageSize,
                    TotalItems = equipment == -1  ?
                        repository.Products.Count() :
                        repository.Products.Where(x => x.EquipmentId == equipment).Count()
                },
                CurrentEquipment = equipment
            };

            return View(model);
        }
    }
}