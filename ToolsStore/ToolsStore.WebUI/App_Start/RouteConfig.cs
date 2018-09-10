using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ToolsStore.WebUI
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(null,
            "",
            new
            {
                controller = "Product",
                action = "List",
                category = (long)-1,
                equipment = (long)-1,
                page = 1
            }
            );

            routes.MapRoute(null,
            "Page{page}",
            new
            {
                controller = "Product",
                action = "List",
                category = (long)-1,
                equipment = (long)-1
            },
            new { page = @"\d+" }
            );

            routes.MapRoute(null,
            "Equipment{equipment}",
            new
            {
                controller = "Product",
                action = "List",
                category = (long)-1,
                page = 1
            }
            );

            routes.MapRoute(null,
            "Category{category}",
            new
            {
                controller = "Product",
                action = "List",
                equipment = (long)-1,
                page = 1
            }
            );

            routes.MapRoute(null,
            "Equipment{equipment}/Page{page}",
            new
            {
                controller = "Product",
                action = "List",
                category = (long)-1
            },
            new { page = @"\d+" }
            );

            routes.MapRoute(null,
            "Category{category}/Page{page}",
            new
            {
                controller = "Product",
                action = "List",
                equipment = (long)-1
            },
            new { page = @"\d+" }
            );

            routes.MapRoute(null,
            "Category{category}/Equipment{equipment}",
            new
            {
                controller = "Product",
                action = "List",
                page = 1
            }
            );

            routes.MapRoute(null,
            "Category{category}/Equipment{equipment}/Page{page}",
            new
            {
                controller = "Product",
                action = "List"
            },
            new { page = @"\d+" }
            );

            //routes.MapRoute(
            //    name: null,
            //    url: "Page{page}",
            //    defaults: new { controller = "Product", action = "List" }
            //);

            //routes.MapRoute(
            //    name: "Default",
            //    url: "{controller}/{action}/{id}",
            //    defaults: new { controller = "Product", action = "List", id = UrlParameter.Optional }
            //);

            routes.MapRoute(null, "{controller}/{action}");
        }
    }
}
