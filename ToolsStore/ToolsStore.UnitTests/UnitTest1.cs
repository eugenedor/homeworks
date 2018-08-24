using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;
using ToolsStore.WebUI.Controllers;
//using ToolsStore.WebUI.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
//using ToolsStore.WebUI.HtmlHelpers;


namespace ToolsStore.UnitTests
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void Can_Paginate()
        {
            // Arrange
            // - create the mock repository
            Mock<IProductRepository> mock = new Mock<IProductRepository>();
            mock.Setup(m => m.Products).Returns(new RS_PRODUCT[] {
                                                new RS_PRODUCT {ProductId = 1, Name = "P1"},
                                                new RS_PRODUCT {ProductId = 2, Name = "P2"},
                                                new RS_PRODUCT {ProductId = 3, Name = "P3"},
                                                new RS_PRODUCT {ProductId = 4, Name = "P4"},
                                                new RS_PRODUCT {ProductId = 5, Name = "P5"}
            }.AsQueryable());
            // create a controller and make the page size 3 items
            ProductController controller = new ProductController(mock.Object);
            controller.PageSize = 3;
            // Action
            IEnumerable<RS_PRODUCT> result = (IEnumerable<RS_PRODUCT>)controller.List(2).Model;
            // Assert
            RS_PRODUCT[] prodArray = result.ToArray();
            Assert.IsTrue(prodArray.Length == 2);
            Assert.AreEqual(prodArray[0].Name, "P4");
            Assert.AreEqual(prodArray[1].Name, "P5");
        }
    }
}
