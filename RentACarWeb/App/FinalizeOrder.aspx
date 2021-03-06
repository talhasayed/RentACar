﻿<%@ Page Title="Finalize Order" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FinalizeOrder.aspx.cs" Inherits="RentACarWeb.App.FinalizeOrder" %>

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

        .valItem {
            color: red;
            font-weight: bold;
            display: block;
            float: left;
        }

        .valSummary {
            color: red;

        }

    </style>


    <h2>Finalize Order</h2>


    <span style="font-weight: bold">Please fill the following form to finalize the order:</span>

    <br />
    <br />
    <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>

    <br />
    <br />

    <%--<asp:ValidationSummary CssClass="valSummary" ID="ValidationSummary1" runat="server" />--%>

    <table class="tbl-finalize">
        <tr>
            <td>Transaction Date
            </td>
            <td>
                <asp:TextBox ID="txtTransactionDate" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                
                <script>
                    $(function() {
                        $("#txtTransactionDate").datepicker({ dateFormat: 'dd/mm/yy' });
                    });
                </script>

            </td>
            <td>
                <asp:RequiredFieldValidator CssClass="valItem" ID="rfv5" runat="server" ErrorMessage="Please enter the transaction date"  ControlToValidate="txtTransactionDate"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Full Name
            </td>
            <td>
                <asp:TextBox ID="txtCustomerName" CssClass="form-control" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator CssClass="valItem" ID="rfv1" runat="server" ErrorMessage="Please enter the customer name" ControlToValidate="txtCustomerName"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Nationality
            </td>
            <td>
                <asp:DropDownList ID="ddlCountries" ClientIDMode="Static" runat="server" Width="280px" AppendDataBoundItems="True">
                    <asp:ListItem Text="Select Country" Value="-1"></asp:ListItem>
                </asp:DropDownList>
                
                <script>
                    $(function() {
                        $("#ddlCountries").selectmenu();

                    });
                </script>
                <style>
                    #ddlCountries-menu {
                        height: 200px;
                    }
                </style>

            </td>
            <td>
                <asp:RequiredFieldValidator CssClass="valItem" ID="rfv4" runat="server" ErrorMessage="Please select the nationality"  InitialValue="-1" ControlToValidate="ddlCountries"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Driving License No.
            </td>
            <td>
                <asp:TextBox ID="txtDrivingLicenseNo" CssClass="form-control" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator CssClass="valItem" ID="rfv2" runat="server" ErrorMessage="Please enter the driving license number" ControlToValidate="txtDrivingLicenseNo"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Preferred Currency
            </td>
            <td>
                <asp:DropDownList ID="ddlCurrencies" ClientIDMode="Static" runat="server"></asp:DropDownList>
                
                <script>
                    $(function() {
                        $("#ddlCurrencies").selectmenu({
                            width: "280px"
                    });
                    });
                </script>
                <style>
                    #ddlCurrencies-menu {
                        max-height: 200px;
                    }
                </style>
            </td>
        </tr>
        <tr>
            <td>Advance Payment (in chosen currency)
            </td>
            <td>
                <asp:TextBox ID="txtAdvancePayment" CssClass="form-control" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator CssClass="valItem" ID="rfv3" runat="server" ErrorMessage="Please enter the advance payment value" ControlToValidate="txtAdvancePayment"></asp:RequiredFieldValidator>
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

        <asp:ListView ID="lstCars" runat="server" OnItemEditing="lstCars_OnItemEditing" OnItemUpdating="lstCars_OnItemUpdating" OnItemDeleting="lstCars_OnItemDeleting" OnItemCanceling="lstCars_OnItemCanceling" DataKeyNames="CarId">
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

                    <asp:LinkButton ID="EditButton" CssClass="btn btn-success btn-sm" runat="server" CommandName="Edit" Text="Edit" CommandArgument='<%# Eval("CarId") %>' CausesValidation="False" />
                    <asp:LinkButton ID="DeleteButton" CssClass="btn btn-danger btn-sm" runat="server" CommandName="Delete" Text="Delete" CommandArgument='<%# Eval("CarId") %>' CausesValidation="False"/>

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
                                <asp:TextBox ID="daterange" ClientIDMode="Static" CssClass="form-control" runat="server" Text='<%# Eval("RentDurationFrom", "{0: MM/dd/yyyy h:mm tt}") + " - " + Eval("RentDurationTo", "{0: MM/dd/yyyy h:mm tt}") %>'></asp:TextBox>
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

                <asp:LinkButton ID="UpdateButton" ValidationGroup="vg_details" CssClass="btn btn-success btn-sm" runat="server" CommandName="Update" Text="Update" CommandArgument='<%# Eval("CarId") %>' />
                <asp:LinkButton ID="CancelButton" CssClass="btn btn-danger btn-sm" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="False" />

            </EditItemTemplate>
            <ItemSeparatorTemplate>
                <hr style="margin: 5px;" />
            </ItemSeparatorTemplate>
            <EmptyDataTemplate>
                <span class="isa_warning" style="font-size: 16px; font-weight: bold;">No cars seleted. Please select atleast one car from the search page</span>
            </EmptyDataTemplate>
        </asp:ListView>

    </div>


    <asp:Button ID="btnConfirmOrder" CssClass="btn btn-primary" runat="server" Text="Submit Order" OnClick="btnConfirmOrder_OnClick" />
</asp:Content>
