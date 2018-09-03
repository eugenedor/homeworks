using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;
using ToolsStore.WebUI.Controllers;
using ToolsStore.WebUI.Models;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using ToolsStore.WebUI.HtmlHelpers;


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
            ProductsListViewModel result = (ProductsListViewModel)controller.List(-1, 2).Model; //IEnumerable<RS_PRODUCT> result = (IEnumerable<RS_PRODUCT>)controller.List(2).Model;
            // Assert
            RS_PRODUCT[] prodArray = result.Products.ToArray();
            Assert.IsTrue(prodArray.Length == 2);
            Assert.AreEqual(prodArray[0].Name, "P4");
            Assert.AreEqual(prodArray[1].Name, "P5");
        }

        [TestMethod]
        public void Can_Generate_Page_Links()
        {
            // Arrange - define an HTML helper - we need to do this
            // in order to apply the extension method
            HtmlHelper myHelper = null;
            // Arrange - create PagingInfo data
            PagingInfo pagingInfo = new PagingInfo
            {
                CurrentPage = 2,
                TotalItems = 28,
                ItemsPerPage = 10
            };
            // Arrange - set up the delegate using a lambda expression
            Func<int, string> pageUrlDelegate = i => "Page" + i;
            // Act
            MvcHtmlString result = myHelper.PageLinks(pagingInfo, pageUrlDelegate);
            // Assert
            Assert.AreEqual(result.ToString(), @"<a href=""Page1"">1</a>"
            + @"<a class=""selected"" href=""Page2"">2</a>"
            + @"<a href=""Page3"">3</a>");
        }

        [TestMethod]
        public void Can_Send_Pagination_View_Model()
        {
            // Arrange
            Mock<IProductRepository> mock = new Mock<IProductRepository>();
            mock.Setup(m => m.Products).Returns(new RS_PRODUCT[] {
                                                new RS_PRODUCT {ProductId = 1, Name = "P1"},
                                                new RS_PRODUCT {ProductId = 2, Name = "P2"},
                                                new RS_PRODUCT {ProductId = 3, Name = "P3"},
                                                new RS_PRODUCT {ProductId = 4, Name = "P4"},
                                                new RS_PRODUCT {ProductId = 5, Name = "P5"}
            }.AsQueryable());
            // Arrange
            ProductController controller = new ProductController(mock.Object);
            controller.PageSize = 3;
            // Act
            ProductsListViewModel result = (ProductsListViewModel)controller.List(-1, 2).Model;
            // Assert
            PagingInfo pageInfo = result.PagingInfo;
            Assert.AreEqual(pageInfo.CurrentPage, 2);
            Assert.AreEqual(pageInfo.ItemsPerPage, 3);
            Assert.AreEqual(pageInfo.TotalItems, 5);
            Assert.AreEqual(pageInfo.TotalPages, 2);
        }

        [TestMethod]
        public void Can_Filter_Products()
        {
            // Arrange
            // - create the mock repository
            Mock<IProductRepository> mock = new Mock<IProductRepository>();
            mock.Setup(m => m.Products).Returns(new RS_PRODUCT[] {
                                                new RS_PRODUCT {ProductId = 1, Name = "P1", EquipmentId = 1},
                                                new RS_PRODUCT {ProductId = 2, Name = "P2", EquipmentId = 2},
                                                new RS_PRODUCT {ProductId = 3, Name = "P3", EquipmentId = 1},
                                                new RS_PRODUCT {ProductId = 4, Name = "P4", EquipmentId = 2},
                                                new RS_PRODUCT {ProductId = 5, Name = "P5", EquipmentId = 3}
            }.AsQueryable());
            // Arrange - create a controller and make the page size 3 items
            ProductController controller = new ProductController(mock.Object);
            controller.PageSize = 3;
            // Action
            RS_PRODUCT[] result = ((ProductsListViewModel)controller.List(2, 1).Model).Products.ToArray();
            // Assert
            Assert.AreEqual(result.Length, 2);
            Assert.IsTrue(result[0].Name == "P2" && result[0].EquipmentId == 2);
            Assert.IsTrue(result[1].Name == "P4" && result[1].EquipmentId == 2);
        }

        [TestMethod]
        public void Can_Create_Equipments()
        {
            // Arrange
            // - create the mock repository
            Mock<IProductRepository> mock = new Mock<IProductRepository>();
            mock.Setup(m => m.Equipments).Returns(new SK_EQUIPMENT[] {
                                                  new SK_EQUIPMENT {EquipmentId = 1, Name = "P1"},
                                                  new SK_EQUIPMENT {EquipmentId = 2, Name = "P2"},
                                                  new SK_EQUIPMENT {EquipmentId = 3, Name = "P3"}
            }.AsQueryable());

            // Arrange - create the controller
            NavController target = new NavController(mock.Object);
            // Act = get the set of categories
            SK_EQUIPMENT[] results = ((IEnumerable<SK_EQUIPMENT>)target.Menu().Model).ToArray();
            // Assert
            Assert.AreEqual(results.Length, 3);
            Assert.AreEqual(results[0].Name, "P1");
            Assert.AreEqual(results[1].Name, "P2");
            Assert.AreEqual(results[2].Name, "P3");
        }

        [TestMethod]
        public void Indicates_Selected_Equipment()
        {
            // Arrange
            // - create the mock repository
            Mock<IProductRepository> mock = new Mock<IProductRepository>();
            mock.Setup(m => m.Equipments).Returns(new SK_EQUIPMENT[] {
                                                  new SK_EQUIPMENT {EquipmentId = 1, Name = "P1"},
                                                  new SK_EQUIPMENT {EquipmentId = 2, Name = "P2"},
            }.AsQueryable());
            // Arrange - create the controller
            NavController target = new NavController(mock.Object);
            // Arrange - define the category to selected
            long equipmentToSelect = 1;
            // Action
            long result = target.Menu(equipmentToSelect).ViewBag.SelectedEquipments;
            // Assert
            Assert.AreEqual(equipmentToSelect, result);
        }
    }
}
