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

        public const int PAGESIZE = 4;

        public ProductController(IProductRepository productRepository)
        {
            this.repository = productRepository;
        }

        public int GetTotalItems(long category, long equipment)
        {
            if (category == -1 && equipment == -1)
                return repository.Products.Count();

            if (category == -1 && equipment >= 0)
                return repository.Products.Where(x => x.EquipmentId == equipment).Count();

            if (category >= 0 && equipment == -1)
                return (from pr in repository.Products
                        join eq in repository.Equipments on pr.EquipmentId equals eq.EquipmentId
                        where eq.CategoryId == category
                        select pr.ProductId).Count();

            return (from pr in repository.Products
                    join eq in repository.Equipments on pr.EquipmentId equals eq.EquipmentId
                    where pr.EquipmentId == equipment
                          && eq.CategoryId == category
                    select pr.ProductId).Count();
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
                                        select p).Skip((page - 1) * PAGESIZE).Take(PAGESIZE);

            int totalItems = GetTotalItems(category, equipment);

            ProductsListViewModel model = new ProductsListViewModel
            {
                Products = prd,

                PagingInfo = new PagingInfo
                {
                    CurrentPage = page,
                    ItemsPerPage = PAGESIZE,
                    TotalItems = totalItems
                },
                CurrentEquipment = equipment,
                CurrentCategory = category
            };

            return View(model);
        }
    }
}