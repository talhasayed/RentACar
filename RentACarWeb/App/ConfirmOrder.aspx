<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ConfirmOrder.aspx.cs" Inherits="RentACarWeb.App.ConfirmOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    
     <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>

    <br />
    <br />

    <table>
        <tr>
            <td>Full Name
            </td>
            <td>
                <asp:TextBox ID="txtCustomerName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Driving License No.
            </td>
            <td>
                <asp:TextBox ID="txtDrivingLicenseNo" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Advance Payment (in chosen currency)
            </td>
            <td>
                <asp:TextBox ID="txtAdvancePayment" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>

    <asp:ListView ID="lstCars" runat="server">
        <ItemTemplate>

            <table>
                <tr>
                    <td>
                        <%# Eval("Car.ModelName") %>
                    </td>
                </tr>
                <tr>
                    <td> Advance Payment </td>
                    <td>
                        <%# Eval("AdvancePayment") %>
                    </td>
                </tr>
            </table>

        </ItemTemplate>
        <ItemSeparatorTemplate>
            <hr />
        </ItemSeparatorTemplate>
    </asp:ListView>



    <asp:Button ID="btnSubmitOrder" runat="server" Text="Submit Order" OnClick="btnSubmitOrder_OnClick" />

</asp:Content>
