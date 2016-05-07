<%@ Page Title="Finalize Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FinalizeOrder.aspx.cs" Inherits="RentACarWeb.App.FinalizeOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <style>
        .searh-container {
            /*background-color: antiquewhite;*/
            width: 600px;
            margin: 50px;
        }

        .search-item {
            padding: 10px;
        }


            .search-item table tr td:nth-child(2n + 1) {
                font-weight: bold;
            }





        .tbl-finalize td {
            padding: 5px;
        }

        .search-item table td:first-child {
            width: 200px;
        }
        .search-item table td:nth-child(2),.search-item .form-control  {
            max-width: 350px;
            width: 350px;
        }

    </style>


    <h2>Finalize Order</h2>


    <span style="font-weight: bold">Please fill the following form to finalize the order:</span>

    <br />
    <br />
    <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>

    <br />
    <br />

    <table class="tbl-finalize">
        <tr>
            <td>Full Name
            </td>
            <td>
                <asp:TextBox ID="txtCustomerName" CssClass="form-control" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Driving License No.
            </td>
            <td>
                <asp:TextBox ID="txtDrivingLicenseNo" CssClass="form-control" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Advance Payment (in chosen currency)
            </td>
            <td>
                <asp:TextBox ID="txtAdvancePayment" CssClass="form-control" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="//cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/bootstrap.daterangepicker/2/daterangepicker.css" />
    <script>


        $(function() {
            $('input[id="daterange"]').daterangepicker({
                timePicker: true,
                timePickerIncrement: 30,
                locale: {
                    format: 'MM/DD/YYYY h:mm A'
                }
            });
        });


    </script>


    <div class="searh-container">

        <asp:ListView ID="lstCars" runat="server" OnItemEditing="lstCars_OnItemEditing" OnItemUpdating="lstCars_OnItemUpdating" OnItemCanceling="lstCars_OnItemCanceling" DataKeyNames="CarId">
            <ItemTemplate>

                <div id="itemdiv" runat="server" class="search-item">

                    <table>
                        <tr>
                            <td colspan="2">
                                <h4><%# Eval("Car.BrandName") %> <%# Eval("Car.ModelName") %> <%# Eval("Car.ModelYear") %></h4>

                            </td>
                        </tr>


                        <tr>
                            <td>
                                <span style="font-weight: bold">Quantity:</span>



                            </td>
                            <td>
                                <%# Eval("Quantity") %>
                            </td>

                        </tr>

                        <tr>
                            <td>
                                <span style="font-weight: bold">Duration From:</span>
                            </td>
                            <td>
                                <%# Eval("RentDurationFrom") %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="font-weight: bold">Duration To:</span>
                            </td>
                            <td>
                                <%# Eval("RentDurationTo") %>
                            </td>
                        </tr>

                        <tr>

                            <td>Color:
                            </td>
                            <td>
                                <%# Eval("Car.Color") %>
                            </td>

                        </tr>
                        <tr>
                            <td>Car Type:
                            </td>
                            <td>
                                <%# Eval("Car.CarType") %>

                            </td>
                        </tr>
                    </table>

                    <asp:LinkButton ID="EditButton" CssClass="btn btn-success btn-sm" runat="server" CommandName="Edit" Text="Edit" CommandArgument='<%# Eval("CarId") %>' />

                </div>
            </ItemTemplate>
            <EditItemTemplate>
                <div id="itemdiv" runat="server" class="search-item">

                    <table>
                        <tr>
                            <td colspan="2">
                                <h4><%# Eval("Car.BrandName") %> <%# Eval("Car.ModelName") %> <%# Eval("Car.ModelYear") %></h4>

                            </td>
                        </tr>


                        <tr>
                            <td>
                                <span style="font-weight: bold">Quantity:</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtQuantity" CssClass="form-control" Text='<%# Bind("Quantity") %>' runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span style="font-weight: bold">Duration:</span>
                            </td>
                            <td>
                                <asp:TextBox ID="daterange" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                            </td>
                        </tr>


                        <tr>

                            <td>Color:
                            </td>
                            <td>
                                <%# Eval("Car.Color") %>
                            </td>

                        </tr>
                        <tr>
                            <td>Car Type:
                            </td>
                            <td>
                                <%# Eval("Car.CarType") %>

                            </td>
                        </tr>
                    </table>


                </div>

                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CommandArgument='<%# Eval("CarId") %>' />
                <asp:LinkButton ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="False" />

            </EditItemTemplate>
            <ItemSeparatorTemplate>
                <hr style="margin: 5px;" />
            </ItemSeparatorTemplate>
        </asp:ListView>

    </div>


    <asp:Button ID="btnConfirmOrder" CssClass="btn btn-primary" runat="server" Text="Submit Order" OnClick="btnConfirmOrder_OnClick" />
</asp:Content>
