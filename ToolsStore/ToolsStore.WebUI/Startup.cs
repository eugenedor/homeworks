using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ToolsStore.WebUI.Startup))]
namespace ToolsStore.WebUI
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            //ConfigureAuth(app);
        }
    }
}
