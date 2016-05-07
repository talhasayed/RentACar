using System;
using System.Collections.Generic;
using System.Globalization;
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
                LoadInformation();
            }
        }

        private void LoadInformation()
        {
            using (var ctx = new RentalDBContext())
            {
                //Load Country Drop Down List

                var countries = ctx.Countries.ToList();

                ddlCountries.DataSource = countries;
                ddlCountries.DataTextField = "CountryName";
                ddlCountries.DataValueField = "ISO2";
                ddlCountries.DataBind();

                //Load Currency List
                var currencies = ctx.Currencies.ToList();

                ddlCurrencies.DataSource = currencies;
                ddlCurrencies.DataTextField = "CurrencyName";
                ddlCurrencies.DataValueField = "Id";
                ddlCurrencies.DataBind();
            }


            if (!(Session["CurrentOrder"] is List<RentOrderDetail>))
            {
                lblMessage.Text = "No cars selected. Please select cars on the search page.";
                lblMessage.CssClass = "isa_error";

                // Binding to show the empty data template
                lstCars.DataSource = null;
                lstCars.DataBind();
                return;
            }

            var currentOrder = (List<RentOrderDetail>)Session["CurrentOrder"];

            if (currentOrder.Count == 0)
            {
                lblMessage.Text = "No cars selected. Please select cars on the search page.";
                lblMessage.CssClass = "isa_error";

                // Binding to show the empty data template
                lstCars.DataSource = null;
                lstCars.DataBind();
                return;
            }

            lstCars.DataSource = currentOrder;
            lstCars.DataBind();
        }

        protected void btnConfirmOrder_OnClick(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }


            using (var ctx = new RentalDBContext())
            {
                var currentOrder = (List<RentOrderDetail>)Session["CurrentOrder"];


                if (currentOrder == null || currentOrder.Count < 1)
                {
                    lblMessage.Text = "No cars selected. Please select cars on the search page.";
                    lblMessage.CssClass = "isa_error";
                    return;
                }

                var order = new RentOrder()
                {
                    Id = Guid.NewGuid(),
                    CustomerName = txtCustomerName.Text.Trim(),
                    CustomerNationality = ddlCountries.SelectedValue,
                    PreferredCurrency = ddlCurrencies.SelectedValue,
                    CustomerDrivingLicenseNo = txtDrivingLicenseNo.Text.Trim(),
                    AdvancePayment = decimal.Parse(txtAdvancePayment.Text.Trim()),
                    TransactionDate = DateTime.ParseExact(txtTransactionDate.Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture),
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
                lblMessage.CssClass = "isa_success";

                Session.Remove("CurrentOrder");
                ClearForm();

            }
        }

        private void ClearForm()
        {
            txtAdvancePayment.Text = "";
            txtCustomerName.Text = "";
            txtDrivingLicenseNo.Text = "";
            txtTransactionDate.Text = "";
            ddlCountries.SelectedIndex = 0;

            LoadInformation();
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

            var quantity = e.NewValues["Quantity"].ToString();

            item.Quantity = int.Parse(quantity);


            var txtdaterange = (TextBox)lstCars.EditItem.FindControl("daterange");

            string a = txtdaterange.Text;

            var dateFrom = DateTime.ParseExact(a.Split('-')[0].Trim(), "MM/dd/yyyy h:mm tt", null);
            var dateTo = DateTime.ParseExact(a.Split('-')[1].Trim(), "MM/dd/yyyy h:mm tt", null);


            item.RentDurationFrom = dateFrom;
            item.RentDurationTo = dateTo;


            lstCars.EditIndex = -1;
            lstCars.DataSource = currentOrder;
            lstCars.DataBind();
        }

        protected void lstCars_OnItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            var currentOrder = (List<RentOrderDetail>)Session["CurrentOrder"];
            lstCars.EditIndex = -1;
            lstCars.DataSource = currentOrder;
            lstCars.DataBind();
        }

        protected void lstCars_OnItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            var carId = Guid.Parse(e.Keys[0].ToString());

            var currentOrder = (List<RentOrderDetail>)Session["CurrentOrder"];


            var carItem = currentOrder.Single(x => x.CarId == carId);

            currentOrder.Remove(carItem);

            lstCars.DataSource = currentOrder;
            lstCars.DataBind();
        }


    }
}