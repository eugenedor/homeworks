using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ToolsStore.Domain.Entities;
using System.Linq;
using Moq;
using ToolsStore.Domain.Abstract;
using ToolsStore.WebUI.Controllers;
using System.Web.Mvc;
using ToolsStore.WebUI.Models;

namespace ToolsStore.UnitTests
{
    /// <summary>
    /// Summary description for CartTests
    /// </summary>
    [TestClass]
    public class CartTests
    {
        [TestMethod]
        public void Can_Add_New_Lines()
        {
            // Arrange - create some test products
            PRODUCT p1 = new PRODUCT { ProductId = 1, Name = "P1" };
            PRODUCT p2 = new PRODUCT { ProductId = 2, Name = "P2" };
            // Arrange - create a new cart
            CART target = new CART();
            // Act
            target.AddItem(p1, 1);
            target.AddItem(p2, 1);
            CART_LINE[] results = target.Lines.ToArray();
            // Assert
            Assert.AreEqual(results.Length, 2);
            Assert.AreEqual(results[0].Product, p1);
            Assert.AreEqual(results[1].Product, p2);
        }

        [TestMethod]
        public void Can_Add_Quantity_For_Existing_Lines()
        {
            // Arrange - create some test products
            PRODUCT p1 = new PRODUCT { ProductId = 1, Name = "P1" };
            PRODUCT p2 = new PRODUCT { ProductId = 2, Name = "P2" };
            // Arrange - create a new cart
            CART target = new CART();
            // Act
            target.AddItem(p1, 1);
            target.AddItem(p2, 1);
            target.AddItem(p1, 10);
            CART_LINE[] results = target.Lines.OrderBy(c => c.Product.ProductId).ToArray();
            // Assert
            Assert.AreEqual(results.Length, 2);
            Assert.AreEqual(results[0].Quantity, 11);
            Assert.AreEqual(results[1].Quantity, 1);
        }

        [TestMethod]
        public void Can_Remove_Line()
        {
            // Arrange - create some test products
            PRODUCT p1 = new PRODUCT { ProductId = 1, Name = "P1" };
            PRODUCT p2 = new PRODUCT { ProductId = 2, Name = "P2" };
            PRODUCT p3 = new PRODUCT { ProductId = 3, Name = "P3" };
            // Arrange - create a new cart
            CART target = new CART();
            // Arrange - add some products to the cart
            target.AddItem(p1, 1);
            target.AddItem(p2, 3);
            target.AddItem(p3, 5);
            target.AddItem(p2, 1);
            // Act
            target.RemoveLine(p2);
            // Assert
            Assert.AreEqual(target.Lines.Where(c => c.Product == p1).Count(), 1);
            Assert.AreEqual(target.Lines.Where(c => c.Product == p2).Count(), 0);
            Assert.AreEqual(target.Lines.Where(c => c.Product == p3).Count(), 1);
            Assert.AreEqual(target.Lines.Count(), 2);
        }

        [TestMethod]
        public void Calculate_Cart_Total()
        {
            // Arrange - create some test products
            PRODUCT p1 = new PRODUCT { ProductId = 1, Name = "P1", PriceWithVat = 100M };
            PRODUCT p2 = new PRODUCT { ProductId = 2, Name = "P2", PriceWithVat = 50M };
            // Arrange - create a new cart
            CART target = new CART();
            // Act
            target.AddItem(p1, 1);
            target.AddItem(p2, 1);
            target.AddItem(p1, 3);
            decimal result = target.ComputeTotalValue();
            // Assert
            Assert.AreEqual(result, 450M);
        }

        [TestMethod]
        public void Can_Clear_Contents()
        {
            // Arrange - create some test products
            PRODUCT p1 = new PRODUCT { ProductId = 1, Name = "P1", PriceWithVat = 100M };
            PRODUCT p2 = new PRODUCT { ProductId = 2, Name = "P2", PriceWithVat = 50M };
            // Arrange - create a new cart
            CART target = new CART();
            // Arrange - add some items
            target.AddItem(p1, 1);
            target.AddItem(p2, 1);
            // Act - reset the cart
            target.Clear();
            // Assert
            Assert.AreEqual(target.Lines.Count(), 0);
        }

        [TestMethod]
        public void Can_Add_To_Cart()
        {
            // Arrange - create the mock repository
            Mock<IProductRepository> mock = new Mock<IProductRepository>();
            mock.Setup(m => m.Products).Returns(new PRODUCT[] {
                                                new PRODUCT {ProductId = 1, Name = "P1", CategoryName = "Apples"},
            }.AsQueryable());
            // Arrange - create a Cart
            CART cart = new CART();
            // Arrange - create the controller
            CartController target = new CartController(mock.Object, null);
            // Act - add a product to the cart
            target.AddToCart(cart, 1, null);
            // Assert
            Assert.AreEqual(cart.Lines.Count(), 1);
            Assert.AreEqual(cart.Lines.ToArray()[0].Product.ProductId, 1);
        }

        [TestMethod]
        public void Adding_Product_To_Cart_Goes_To_Cart_Screen()
        {
            // Arrange - create the mock repository
            Mock<IProductRepository> mock = new Mock<IProductRepository>();
            mock.Setup(m => m.Products).Returns(new PRODUCT[] {
                                                new PRODUCT {ProductId = 1, Name = "P1", CategoryName = "Apples"},
            }.AsQueryable());
            // Arrange - create a Cart
            CART cart = new CART();
            // Arrange - create the controller
            CartController target = new CartController(mock.Object, null);
            // Act - add a product to the cart
            RedirectToRouteResult result = target.AddToCart(cart, 2, "myUrl");
            // Assert
            Assert.AreEqual(result.RouteValues["action"], "Index");
            Assert.AreEqual(result.RouteValues["returnUrl"], "myUrl");
        }

        [TestMethod]
        public void Can_View_Cart_Contents()
        {
            // Arrange - create a Cart
            CART cart = new CART();
            // Arrange - create the controller
            CartController target = new CartController(null, null);
            // Act - call the Index action method
            CartIndexViewModel result = (CartIndexViewModel)target.Index(cart, "myUrl").ViewData.Model;
            // Assert
            Assert.AreSame(result.Cart, cart);
            Assert.AreEqual(result.ReturnUrl, "myUrl");
        }

        [TestMethod]
        public void Cannot_Checkout_Empty_Cart()
        {
            // Arrange - create a mock order processor
            Mock<IOrderProcessor> mock = new Mock<IOrderProcessor>();
            // Arrange - create an empty cart
            CART cart = new CART();
            // Arrange - create shipping details
            SHIPPING_DETAILS shippingDetails = new SHIPPING_DETAILS();
            // Arrange - create an instance of the controller
            CartController target = new CartController(null, mock.Object);
            // Act
            ViewResult result = target.Checkout(cart, shippingDetails);
            // Assert - check that the order hasn't been passed on to the processor
            mock.Verify(m => m.ProcessOrder(It.IsAny<CART>(), It.IsAny<SHIPPING_DETAILS>()), Times.Never());
            // Assert - check that the method is returning the default view
            Assert.AreEqual("", result.ViewName);
            // Assert - check that we are passing an invalid model to the view
            Assert.AreEqual(false, result.ViewData.ModelState.IsValid);
        }

        [TestMethod]
        public void Cannot_Checkout_Invalid_Shipping_Details()
        {
            // Arrange - create a mock order processor
            Mock<IOrderProcessor> mock = new Mock<IOrderProcessor>();
            // Arrange - create a cart with an item
            CART cart = new CART();
            cart.AddItem(new PRODUCT(), 1);
            // Arrange - create an instance of the controller
            CartController target = new CartController(null, mock.Object);
            // Arrange - add an error to the model
            target.ModelState.AddModelError("error", "error");
            // Act - try to checkout
            ViewResult result = target.Checkout(cart, new SHIPPING_DETAILS());
            // Assert - check that the order hasn't been passed on to the processor
            mock.Verify(m => m.ProcessOrder(It.IsAny<CART>(), It.IsAny<SHIPPING_DETAILS>()), Times.Never());
            // Assert - check that the method is returning the default view
            Assert.AreEqual("", result.ViewName);
            // Assert - check that we are passing an invalid model to the view
            Assert.AreEqual(false, result.ViewData.ModelState.IsValid);
        }

        [TestMethod]
        public void Can_Checkout_And_Submit_Order()
        {
            // Arrange - create a mock order processor
            Mock<IOrderProcessor> mock = new Mock<IOrderProcessor>();
            // Arrange - create a cart with an item
            CART cart = new CART();
            cart.AddItem(new PRODUCT(), 1);
            // Arrange - create an instance of the controller
            CartController target = new CartController(null, mock.Object);
            // Act - try to checkout
            ViewResult result = target.Checkout(cart, new SHIPPING_DETAILS());
            // Assert - check that the order has been passed on to the processor
            mock.Verify(m => m.ProcessOrder(It.IsAny<CART>(), It.IsAny<SHIPPING_DETAILS>()), Times.Once());
            // Assert - check that the method is returning the Completed view
            Assert.AreEqual("Completed", result.ViewName);
            // Assert - check that we are passing a valid model to the view
            Assert.AreEqual(true, result.ViewData.ModelState.IsValid);
        }
    }
}
