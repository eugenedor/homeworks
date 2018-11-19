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

        public OrderController(IOrderRepository repo)
        {
            repository = repo;
        }

        public ViewResult Orders()
        {
            return View(repository.Orders.OrderByDescending(x => x.OrderId));
        }

        public ViewResult OrderContent(long orderId)
        {
            IEnumerable<OrderContent> orderContents = repository.OrderContents.Where(x => x.OrderId == orderId);
            return View(orderContents);
        }
    }
}