<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Product.aspx.cs" Inherits="SportsStore.Product" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <h2><asp:Label ID="lblName" runat="server" Text="Product Name"></asp:Label></h2>
        <asp:Image ID="imgImage" runat="server" AlternateText="Image" CssClass="productImage" />
        <p><asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label></p>
        <p>Price: <asp:Label ID="lblPrice" runat="server" Text="0"></asp:Label></p>
        <p><asp:Label ID="lblQuantity" runat="server" Text="0"></asp:Label></p>
    </main>
</asp:Content>