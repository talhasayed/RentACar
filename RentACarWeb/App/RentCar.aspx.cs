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
            using (var ctx = new RentalDBContext())
            {

                var currentCarId = Guid.Parse(e.CommandArgument.ToString());

                if (Session["CurrentOrder"] == null)
                {
                    Session["CurrentOrder"] = new List<RentOrderDetail>();
                }

                var currentOrder = (List<RentOrderDetail>) Session["CurrentOrder"];

                if (currentOrder.All(x => x.CarId != currentCarId))
                {
                    currentOrder.Add(new RentOrderDetail() {CarId = currentCarId, Car = ctx.Cars.Single(x=> x.Id == currentCarId)});

                    lblMessage.Text = string.Format("Car with Id:{0} was added to the order", currentCarId);
                }
                else
                {
                    var currentCarItem = currentOrder.Single(x => x.CarId == currentCarId);

                    currentOrder.Remove(currentCarItem);

                    lblMessage.Text = string.Format("Car with Id:{0} was removed from the order", currentCarId);
                }
            }
        }



    }
}