using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;
using ToolsStore.WebUI.Controllers;
using System.Linq;
using System.Web.Mvc;

namespace ToolsStore.UnitTests
{
    [TestClass]
    public class AdminTests
    {
        [TestMethod]
        public void Index_Contains_All_LoadRules()
        {
            // Arrange - create the mock repository
            Mock<IRuleRepository> mock = new Mock<IRuleRepository>();
            mock.Setup(m => m.LoadRules).Returns(new MT_LOAD_RULE[] {
                new MT_LOAD_RULE {LoadRuleId = 1, FileName = "P1"},
                new MT_LOAD_RULE {LoadRuleId = 2, FileName = "P2"},
                new MT_LOAD_RULE {LoadRuleId = 3, FileName = "P3"},
            }.AsQueryable());
            // Arrange - create a controller
            AdminController target = new AdminController(mock.Object);
            // Action
            MT_LOAD_RULE[] result = ((IEnumerable<MT_LOAD_RULE>)target.Index().ViewData.Model).ToArray();
            // Assert
            Assert.AreEqual(result.Length, 3);
            Assert.AreEqual("P1", result[0].FileName);
            Assert.AreEqual("P2", result[1].FileName);
            Assert.AreEqual("P3", result[2].FileName);
        }
    }
}
