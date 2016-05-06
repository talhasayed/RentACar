using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RentACarWeb.EF;

namespace RentACarWeb.App
{
    public partial class FinalizeOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
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

                lstCars.DataSource = currentOrder;
                lstCars.DataBind();
            }
        }

        protected void btnConfirmOrder_OnClick(object sender, EventArgs e)
        {
            using (var ctx = new RentalDBContext())
            {
                var currentOrder = (List<RentOrderDetail>)Session["CurrentOrder"];
                var order = new RentOrder()
                {
                    Id = Guid.NewGuid(),
                    CustomerName = "",
                    CustomerNationality = "",
                    PreferredCurrency = 0,
                    CustomerDrivingLicenseNo = "",
                    AdvancePayment = "",
                    TransactionDate = DateTime.Now,
                };


                foreach (var item in currentOrder)
                {
                    order.RentOrderDetails.Add(new RentOrderDetail()
                    {
                        Id = Guid.NewGuid(),
                        CarId = item.CarId,
                        Quantity = item.Quantity,
                        RentDurationFrom = item.RentDurationFrom,
                        RentDurationTo = item.RentDurationTo,
                    });
                }



                ctx.RentOrders.Add(order);










                ctx.SaveChanges();
                lblMessage.Text = "Order successfully saved";




            }
        }

        protected void lstCars_OnItemEditing(object sender, ListViewEditEventArgs e)
        {
            var currentOrder = (List<RentOrderDetail>)Session["CurrentOrder"];

            lstCars.EditIndex = e.NewEditIndex;
            lstCars.DataSource = currentOrder;
            lstCars.DataBind();
        }

        protected void lstCars_OnItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            var currentOrder = (List<RentOrderDetail>)Session["CurrentOrder"];

            var carGuid = Guid.Parse(e.Keys["CarId"].ToString());
            var item = currentOrder.Single(x => x.CarId == carGuid);


            var Quantity = e.NewValues["Quantity"].ToString();


            item.Quantity = int.Parse(Quantity);

            lstCars.EditIndex = -1;
            lstCars.DataSource = currentOrder;
            lstCars.DataBind();
            //lstCars.DataSource = currentOrder;
            //lstCars.DataBind();
        }

    }
}