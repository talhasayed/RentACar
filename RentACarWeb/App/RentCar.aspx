<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RentCar.aspx.cs" Inherits="RentACarWeb.App.RentCar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">





    <ul>
        <asp:ListView ID="lstCars" runat="server" ItemType="RentACarWeb.EF.Car">
            <ItemTemplate>

                <li >
                    Color: <%# Eval("Color") %>
                    Brand: <%# Eval("CarModel.CompanyName") %>
                    Model: <%# Eval("CarModel.ModelName") %>
                </li>

            </ItemTemplate>
        </asp:ListView>


    </ul>

</asp:Content>
