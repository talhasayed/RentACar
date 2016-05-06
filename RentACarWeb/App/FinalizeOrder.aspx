<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FinalizeOrder.aspx.cs" Inherits="RentACarWeb.App.FinalizeOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">





    <asp:Label ID="lblMessage" runat="server" EnableViewState="False"></asp:Label>

    <br />
    <br />


    Please fill the following form to finalize the order:
    
    
    
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

    <asp:ListView ID="lstCars" runat="server" OnItemEditing="lstCars_OnItemEditing" OnItemUpdating="lstCars_OnItemUpdating" DataKeyNames="CarId">
        <ItemTemplate>

            <table>
                <tr>
                    <td>
                        <%# Eval("Car.ModelName") %>
                    </td>
                </tr>
                <tr>
                    <td> Quantity </td>
                    <td>
                        <%# Eval("Quantity") %>
                    </td>
                </tr>
                <tr>
                    <td>
            <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CommandArgument='<%# Eval("CarId") %>' />
                        
                    </td>
                </tr>

            </table>
        </ItemTemplate>
        <EditItemTemplate>
            <tr>
                    <td>
                        <%# Eval("Car.ModelName") %>
                    </td>
                </tr>
            
            <tr>
                    <td>
                        Quantity: 
                        
            <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Bind("Quantity") %>'></asp:TextBox>

                    </td>
                </tr>
            
            <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CommandArgument='<%# Eval("CarId") %>' />

        </EditItemTemplate>
        <ItemSeparatorTemplate>
            <hr />
        </ItemSeparatorTemplate>
    </asp:ListView>



    <asp:Button ID="btnConfirmOrder" runat="server" Text="Confirm Order" OnClick="btnConfirmOrder_OnClick" />
</asp:Content>
