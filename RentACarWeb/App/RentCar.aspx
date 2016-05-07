<%@ Page Title="Search and Rent" Language="C#" MasterPageFile="~/Site.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="RentCar.aspx.cs" Inherits="RentACarWeb.App.RentCar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .searh-container {
            /*background-color: antiquewhite;*/
            width: 600px;
            margin: 50px;
        }

        .search-item { padding: 10px; }


        .search-item table tr td:nth-child(2n + 1) {
            font-weight: bold;
        }

        .search-item table td {
            width: 100px;
        }

        .search-item.selecteditem {
            background-color: antiquewhite;
        }
        

    </style>


    <h2>Search and Rent Cars</h2>

    <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>
    
    
    
    
    
    
    <div class="searh-container">
    <asp:LinkButton ID="lnkFinalizeOrdertop" CssClass="btn btn-primary" OnClick="lnkFinalizeOrder_OnClick" runat="server">Finalize Order</asp:LinkButton>
        
        <asp:ListView ID="lstCars" runat="server" ItemType="RentACarWeb.EF.Car" OnItemDataBound="lstCars_OnItemDataBound">
            <ItemTemplate>

                <div ID="itemdiv" runat="server" class="search-item">

                    <h3><%# Eval("BrandName") %> <%# Eval("ModelName") %> <%# Eval("ModelYear") %></h3>
                    <table class="table table-condensed">
                        <tr>
                            <td>
                                Brand:
                            </td>
                            <td>
                                <%# Eval("BrandName") %>

                            </td>
                            
                            <td style="border: none; width: 30px;"></td>
                            <td style="border: none; width: 30px;"></td>
                            <td>
                                Model:
                            </td>
                            <td>
                                <%# Eval("ModelName") %>

                            </td>
                        </tr>
                        <tr>
                            
                            <td>
                                Color:
                            </td>
                            <td>
                                <%# Eval("Color") %>
                            </td>
                            <td style="border: none; width: 30px;"></td>
                            <td style="border: none; width: 30px;"></td>

                            <td>
                                Car Type:
                            </td>
                            <td>
                                <%# Eval("CarType") %>

                            </td>
                        </tr>
                    </table>


                    <asp:LinkButton ID="lnkSelect" CssClass="btn btn-success" runat="server" CommandName="SelectCar" CommandArgument='<%# Eval("Id") %>' OnCommand="lnkSelect_OnCommand">Select</asp:LinkButton>

                </div>

            </ItemTemplate>
            <ItemSeparatorTemplate>
                <div style="border-bottom: 3px solid #333; margin: 10px 0; padding: 0px;">
                </div>
            </ItemSeparatorTemplate>
        </asp:ListView>


    </div>


    <asp:LinkButton ID="lnkFinalizeOrder" CssClass="btn btn-primary" OnClick="lnkFinalizeOrder_OnClick" runat="server">Finalize Order</asp:LinkButton>


</asp:Content>