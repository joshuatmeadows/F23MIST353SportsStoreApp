<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Product.aspx.cs" Inherits="SportsStore.Product" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Main section of the product page -->
    <main>
        <!-- Table layout for displaying product details -->
        <table>
            <!-- Table row for product information -->
            <tr>
                <!-- Table cell for product image -->
                <td>
                    <!-- Image control to display the product image -->
                    <asp:Image ID="imgImage" runat="server" AlternateText="Image" CssClass="productImage" />
                </td>
                <!-- Table cell for product details like name, description, price, and quantity -->
                <td>
                    <!-- Product name displayed in a heading 2 format -->
                    <h2><asp:Label ID="lblName" runat="server" Text="Product Name"></asp:Label></h2>
                    <!-- Product description -->
                    <p><asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label></p>
                    <!-- Product price -->
                    <p>Price: <asp:Label ID="lblPrice" runat="server" Text="0"></asp:Label></p>
                    <!-- Available quantity -->
                    <p><asp:Label ID="lblQuantity" runat="server" Text="0"></asp:Label></p>
                    <!-- Section for selecting quantity and adding product to cart -->
                    <div>
                        <!-- Dropdown list for selecting quantity -->
                        <p>
                            Quantity:
                            <asp:DropDownList ID="ddlQuantity" runat="server">
                                <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                            </asp:DropDownList>
                        </p>

                        <!-- Button to add the product to the cart -->
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" OnClick="btnAddToCart_Click" CssClass="btn" />
                    </div>
                </td>
            </tr>
        </table>
    </main>
</asp:Content>
