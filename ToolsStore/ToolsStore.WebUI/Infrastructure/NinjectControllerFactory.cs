using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Ninject;
using ToolsStore.Domain.Entities;
using ToolsStore.Domain.Abstract;
using Moq;
using ToolsStore.Domain.Concrete;
using System.Configuration;
using ToolsStore.WebUI.Infrastructure.Abstract;
using ToolsStore.WebUI.Infrastructure.Concrete;

namespace ToolsStore.WebUI.Infrastructure
{
    public class NinjectControllerFactory : DefaultControllerFactory
    {
        // реализация пользовательской фабрики контроллеров,
        // наследуется от фабрики используемой по умолчанию
        private IKernel ninjectKernel;
        public NinjectControllerFactory()
        {
            // создание контейнера
            ninjectKernel = new StandardKernel();
            AddBindings();
        }

        protected override IController GetControllerInstance(RequestContext requestContext, Type controllerType)
        {
            // получение объекта контроллера из контейнера
            // используя его тип
            return controllerType == null
            ? null
            : (IController)ninjectKernel.Get(controllerType);
        }

        private void AddBindings()
        {
            // конфигурирование контейнера
            ninjectKernel.Bind<IProductRepository>().To<EFProductRepository>();
            ninjectKernel.Bind<IRuleRepository>().To<EFRuleRepository>();
            ninjectKernel.Bind<IOrderRepository>().To<EFOrderRepository>();
            ninjectKernel.Bind<ISettingRepository>().To<EFSettingRepository>();

            EmailSettings emailSettings = new EmailSettings
            {
                WriteAsFile = bool.Parse(ConfigurationManager.AppSettings["Email.WriteAsFile"] ?? "false")
            };

            ninjectKernel.Bind<IOrderProcessor>().To<EmailOrderProcessor>().WithConstructorArgument("settings", emailSettings);
            ninjectKernel.Bind<IAuthProvider>().To<FormsAuthProvider>();

            //EmailSettings emailSettings = new EmailSettings
            //{
            //    WriteAsFile = bool.Parse(ConfigurationManager.AppSettings["Email.WriteAsFile"] ?? "false")
            //};

            //ninjectKernel.Bind<IOrderProcessor>().To<EmailOrderProcessor>().WithConstructorArgument("settings", emailSettings);
            //ninjectKernel.Bind<IAuthProvider>().To<FormsAuthProvider>();

            //Mock<IProductRepository> mock = new Mock<IProductRepository>();
            //mock.Setup(m => m.Products).Returns(new List<RS_PRODUCT>
            //{
            //    new RS_PRODUCT { ProductId = 1, BrandId = 1, EquipmentId = 1, ModelId = 1, Name = "Makita BO3710" },
            //    new RS_PRODUCT { ProductId = 2, BrandId = 3, EquipmentId = 1, ModelId = 2, Name = "Интерскол ПШМ-104/220" },
            //    new RS_PRODUCT { ProductId = 3, BrandId = 14, EquipmentId = 1, ModelId = 3, Name = "Фиолент МПШ 4-28Э" }
            //}.AsQueryable());
            //ninjectKernel.Bind<IProductRepository>().ToConstant(mock.Object);
        }
    }
}