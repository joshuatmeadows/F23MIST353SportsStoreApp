<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProductsByCategory.aspx.cs" Inherits="SportsStore.ProductsByCategory" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Main content section of the page -->
    <main>
        <!-- ASP.NET Repeater control used to display a collection of items, in this case, products -->
        <asp:Repeater ID="Products" runat="server">
            <ItemTemplate>
                <!-- Hyperlink to the product details page, dynamically created for each product using the Eval method to insert the ProductID into the query string -->
                <a href="Product.aspx?ID=<%# Eval("ProductID") %>">
                    <%# Eval("Name") %><!-- Displaying the product name -->
                </a>
                <br /><!-- Line break for visual separation between product links -->
            </ItemTemplate>
        </asp:Repeater>
    </main>
</asp:Content>
