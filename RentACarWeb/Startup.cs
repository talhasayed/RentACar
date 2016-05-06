using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(RentACarWeb.Startup))]
namespace RentACarWeb
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
