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
        private IProductRepository repo;
        public int PageSize = 10;
        public ProductController(IProductRepository productRepository)
        {
            this.repo = productRepository;
        }

        public int GetTotalItems(long category, long equipment)
        {
            if (category == -1 && equipment == -1)
                return repo.Products.Count();

            if (category == -1 && equipment >= 0)
                return repo.Products.Where(x => x.EquipmentId == equipment).Count();

            if (category >= 0 && equipment == -1)
                return (from pr in repo.Products
                        join eq in repo.Equipments on pr.EquipmentId equals eq.EquipmentId
                        where eq.CategoryId == category
                        select pr.ProductId).Count();

            return (from pr in repo.Products
                    join eq in repo.Equipments on pr.EquipmentId equals eq.EquipmentId
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

            IEnumerable<Product> prd = (from pr in repo.Products
                                        join eq in repo.Equipments on pr.EquipmentId equals eq.EquipmentId

                                        join ct1 in repo.Categories on eq.CategoryId equals ct1.CategoryId into ct2
                                        from ct in ct2.DefaultIfEmpty()

                                        join br in repo.Brands on pr.BrandId equals br.BrandId
                                        join md in repo.Models on pr.ModelId equals md.ModelId

                                        join im1 in repo.Images on pr.ImageId equals im1.ImageId into im2
                                        from im in im2.DefaultIfEmpty()

                                        join prc1 in (from price in repo.Prices
                                                      where price.DateBegin <= curDate && curDate <= price.DateEnd
                                                      select price) on pr.ProductId equals prc1.ProductId into prc2
                                        from prc in prc2.DefaultIfEmpty()

                                        join v1 in (from vat in repo.Vats
                                                    where !vat.Rem
                                                    select vat) on prc.VatId equals v1.VatId into v2
                                        from v in v2.DefaultIfEmpty()
                                        where (equipment == -1 || pr.EquipmentId == equipment)
                                              && (category == -1 || eq.CategoryId == category)
                                        orderby pr.ProductId
                                        select new Product
                                        {
                                            ProductId = pr.ProductId,
                                            EquipmentId = pr.EquipmentId,
                                            CategoryId = eq.CategoryId,
                                            BrandId = pr.BrandId,
                                            ModelId = pr.ModelId,
                                            ImageId = pr.ImageId,
                                            Name = pr.Name,
                                            Descr = pr.Descr,
                                            Mass = pr.Mass,
                                            Length = pr.Length,
                                            Width = pr.Width,
                                            Height = pr.Height,
                                            Color = pr.Color,
                                            Power = pr.Power,
                                            Kit = pr.Kit,
                                            EquipmentName = eq.Name,
                                            EquipmentNameExtra = eq.NameExtra,
                                            EquipmentOrd = eq.Ord,
                                            CategoryName = ct.Name,
                                            CategoryOrd = ct.Ord,
                                            BrandName = br.Name,
                                            ModelName = md.Name,
                                            Data = im.Data,
                                            MimeType = im.MimeType,
                                            ImageName = im.Name,
                                            PriceWithVat = prc.PriceWithVat,
                                            PriceWithoutVat = prc.PriceWithoutVat,
                                            DateBegin = prc.DateBegin,
                                            DateEnd = prc.DateEnd,
                                            Vat = v.Vat,
                                            VatName = v.Name,
                                            VatRem = v.Rem
                                        }).Skip((page - 1) * PageSize).Take(PageSize);

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
    }
}