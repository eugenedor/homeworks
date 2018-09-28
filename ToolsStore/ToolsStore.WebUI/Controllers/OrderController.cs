using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;


namespace ToolsStore.WebUI.Controllers
{
    public class OrderController : Controller
    {
        private IOrderRepository repository;
        // GET: Order
        public OrderController(IOrderRepository repo)
        {
            repository = repo;
        }

        public ViewResult Index()
        {
            return View(repository.Orders.OrderByDescending(x => x.OrderId));
        }

        public ViewResult Content(long orderId)
        {
            IEnumerable<CartX> carts = repository.Carts.Where(x => x.OrderId == orderId);
            return View(carts);
        }
    }
}