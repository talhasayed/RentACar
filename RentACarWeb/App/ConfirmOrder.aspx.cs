using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RentACarWeb.EF;

namespace RentACarWeb.App
{
    public partial class ConfirmOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!(Session["CurrentOrder"] is List<RentOrderDetail>))
            {
                lblMessage.Text = "No cars selected. Please select cars on the search page.";
                return;
            }

            var currentOrder = (List<RentOrderDetail>)Session["CurrentOrder"];

            if (currentOrder.Count == 0)
            {
                lblMessage.Text = "No cars selected. Please select cars on the search page.";
                return;
            }

            using (var ctx = new RentalDBContext())
            {

                //var selectedCars = ctx.Cars.Where(x => currentOrder.Contains(x.Id)).ToList();

                lstCars.DataSource = currentOrder;
                lstCars.DataBind();


            }
        }

        protected void btnSubmitOrder_OnClick(object sender, EventArgs e)
        {
            //todo: add the order to the database
        }
    }
}