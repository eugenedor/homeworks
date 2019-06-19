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
    public class CartController : Controller
    {
        private IProductRepository repository;
        private IOrderProcessor orderProcessor;

        public CartController(IProductRepository repo, IOrderProcessor proc)
        {
            repository = repo;
            orderProcessor = proc;
        }

        // GET: Cart
        public ViewResult Index(CART cart, string returnUrl)
        {
            return View(new CartIndexViewModel {
                Cart = cart,                      //Теперь через специальный связыватель модели, а так: "Cart = GetCart(),"
                ReturnUrl = returnUrl
            });
        }

        [HttpPost]
        public ViewResult Checkout(CART cart, SHIPPING_DETAILS shippingDetails)
        {
            if (cart.Lines.Count() == 0)
            {
                ModelState.AddModelError("", "Извините, ваша корзина пуста!");
            }
            if (ModelState.IsValid)
            {
                orderProcessor.ProcessOrder(cart, shippingDetails);
                orderProcessor.SaveOrder(cart, shippingDetails);
                cart.Clear();
                return View("Completed");
            }
            else
            {
                return View(shippingDetails);
            }
        }

        public RedirectToRouteResult AddToCart(CART cart, int productId, string returnUrl)
        {
            PRODUCT product = repository.Products.FirstOrDefault(p => p.ProductId == productId);
            if (product != null)
            {
                cart.AddItem(product, 1);         //GetCart().AddItem(product, 1);
            }
            return RedirectToAction("Index", new { returnUrl });
        }

        public RedirectToRouteResult RemFromCart(CART cart, int productId, string returnUrl)
        {
            PRODUCT product = repository.Products.FirstOrDefault(p => p.ProductId == productId);
            if (product != null)
            {
                cart.RemoveItem(product);         //GetCart().RemoveItem(product);
            }
            return RedirectToAction("Index", new { returnUrl });
        }

        public RedirectToRouteResult RemLineFromCart(CART cart, int productId, string returnUrl)
        {
            PRODUCT product = repository.Products.FirstOrDefault(p => p.ProductId == productId);
            if (product != null)
            {
                cart.RemoveLine(product);         //GetCart().RemoveLine(product);
            }
            return RedirectToAction("Index", new { returnUrl });
        }

        private CART GetCart()
        {
            CART cart = (CART)Session["Cart"];
            if (cart == null)
            {
                cart = new CART();
                Session["Cart"] = cart;
            }
            return cart;
        }

        public PartialViewResult Summary(CART cart)
        {
            return PartialView(cart);
        }

        public ViewResult Checkout()
        {
            return View(new SHIPPING_DETAILS());
        }

        public RedirectToRouteResult ClearCart(CART cart, string returnUrl)
        {
            if (cart.Lines.Count() > 0)
            {
                cart.Clear();
            }
            return RedirectToAction("List", "Product");            
        }
    }
}