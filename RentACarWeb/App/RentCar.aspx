<%@ Page Title="Search and Rent" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RentCar.aspx.cs" Inherits="RentACarWeb.App.RentCar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <h1>Searh and Rent Cars</h1>

    <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>
    <ul>
        <asp:ListView ID="lstCars" runat="server" ItemType="RentACarWeb.EF.Car">
            <ItemTemplate>

                <li >
                    Color: <%# Eval("Color") %>
                    Brand: <%# Eval("BrandName") %>
                    Model: <%# Eval("ModelName") %>
                    Car Type: <%# Eval("CarType") %>
                </li>
                <asp:LinkButton ID="lnkSelect" runat="server" CommandName="SelectCar" CommandArgument='<%# Eval("Id") %>' OnCommand="lnkSelect_OnCommand">Select</asp:LinkButton>

            </ItemTemplate>
        </asp:ListView>


    </ul>
    
    
    <asp:HyperLink ID="lnkFinalizeOrder" runat="server">Finalize Order</asp:HyperLink>
    

</asp:Content>
