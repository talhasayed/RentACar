using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RentACarWeb.EF;

namespace RentACarWeb.App
{
    public partial class RentCar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadInformation();
        }

        protected void LoadInformation()
        {
            using (var ctx = new RentalDBContext())
            {
                var cars = ctx.Cars.ToList();
                lstCars.DataSource = cars;
                lstCars.DataBind();
            }
        }
    }
}