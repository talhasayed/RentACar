<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RentACarWeb._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>RentACar</h1>
        <p class="lead">A demo application which lets you search for cars and rent them.</p>
    </div>

    <div class="row">
        <div class="col-md-6">
            <h2>Search Cars</h2>
            <p>
                Choose from various cars and rent one or more cars as per your need.
            </p>
            <p>
                <a class="btn btn-default" runat="server" href="~/App/RentCar">Search Cars</a>
            </p>
        </div>
        
    </div>

</asp:Content>
