using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using RentACarWeb.EF;

namespace RentACarWeb.App
{
    public partial class RentCar : System.Web.UI.Page
    {
        protected void Page_PreRender(object sender, EventArgs e)
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
                    currentOrder.Add(new RentOrderDetail()
                    {
                        CarId = currentCarId,
                        Car = ctx.Cars.Single(x => x.Id == currentCarId),
                        Quantity = 1,
                        RentDurationFrom = DateTime.Today.AddDays(3),
                        RentDurationTo = DateTime.Today.AddDays(10)
                    });

                    //lblMessage.Text = string.Format("Car with Id:{0} was added to the order", currentCarId);
                }
                else
                {
                    var currentCarItem = currentOrder.Single(x => x.CarId == currentCarId);

                    currentOrder.Remove(currentCarItem);

                    //lblMessage.Text = string.Format("Car with Id:{0} was removed from the order", currentCarId);
                }
            }
        }


        protected void lstCars_OnDataBinding(object sender, EventArgs e)
        {
        }

        protected void lstCars_OnItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (Session["CurrentOrder"] == null) return;

            var currentOrder = (List<RentOrderDetail>) Session["CurrentOrder"];

            if (currentOrder.Any(x => x.CarId == ((Car) e.Item.DataItem).Id))
            {
                var itemdiv = (HtmlGenericControl) e.Item.FindControl("itemdiv");
                itemdiv.Attributes["class"] += " selecteditem";

                var lnkSelect = (LinkButton) e.Item.FindControl("lnkSelect");

                lnkSelect.Text = "De-Select";
            }
        }

        protected void lnkFinalizeOrder_OnClick(object sender, EventArgs e)
        {
            bool errorNoCarSelected = Session["CurrentOrder"] == null;

            if (!errorNoCarSelected)
            {
                var currentOrder = (List<RentOrderDetail>) Session["CurrentOrder"];

                if (currentOrder.Count < 1)
                {
                    errorNoCarSelected = true;
                }
            }


            if (errorNoCarSelected)
            {
                lblMessage.Text = "No car selected. Please select atleast one car to finalize your order.";
                lblMessage.CssClass = "isa_error";
            }
            else
            {
                Response.Redirect("FinalizeOrder.aspx");
            }


        }
    }
}