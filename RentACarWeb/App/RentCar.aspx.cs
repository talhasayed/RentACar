using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.AccessControl;
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

        protected void lnkSelect_OnCommand(object sender, CommandEventArgs e)
        {
            var currentCarId = Guid.Parse(e.CommandArgument.ToString());

            if (Session["CurrentOrder"] == null)
            {
                Session["CurrentOrder"] = new List<Guid>();
            }

            var currentOrder = (List<Guid>)Session["CurrentOrder"];

            if (!currentOrder.Contains(currentCarId))
            {
                currentOrder.Add(currentCarId);

                lblMessage.Text = string.Format("Car with Id:{0} was added to the order", currentCarId);
            }
            else
            {
                currentOrder.Remove(currentCarId);

                lblMessage.Text = string.Format("Car with Id:{0} was removed from the order", currentCarId);
            }

        }
    }
}