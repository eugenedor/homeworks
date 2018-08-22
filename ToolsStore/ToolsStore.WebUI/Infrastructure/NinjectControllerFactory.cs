using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Ninject;

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
            //// конфигурирование контейнера
            //ninjectKernel.Bind<IProductRepository>().To<EFProductRepository>();

            //EmailSettings emailSettings = new EmailSettings
            //{
            //    WriteAsFile = bool.Parse(ConfigurationManager.AppSettings["Email.WriteAsFile"] ?? "false")
            //};

            //ninjectKernel.Bind<IOrderProcessor>().To<EmailOrderProcessor>().WithConstructorArgument("settings", emailSettings);
            //ninjectKernel.Bind<IAuthProvider>().To<FormsAuthProvider>();

            ////Mock<IProductRepository> mock = new Mock<IProductRepository>();
            ////mock.Setup(m => m.Products).Returns(new List<Product>
            ////{
            ////    new Product { Name = "Football", Price = 25 },
            ////    new Product { Name = "Surf board", Price = 179 },
            ////    new Product { Name = "Running shoes", Price = 95 }
            ////}.AsQueryable());
            ////ninjectKernel.Bind<IProductRepository>().ToConstant(mock.Object);
        }
    }
}