<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Product.aspx.cs" Inherits="SportsStore.Product" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <table>
            <tr>
                <td>
                    <asp:Image ID="imgImage" runat="server" AlternateText="Image" CssClass="productImage" />
                </td>
                <td>
                    <h2><asp:Label ID="lblName" runat="server" Text="Product Name"></asp:Label></h2>
                    <p><asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label></p>
                    <p>Price: <asp:Label ID="lblPrice" runat="server" Text="0"></asp:Label></p>
                    <p><asp:Label ID="lblQuantity" runat="server" Text="0"></asp:Label></p>
                    <div>
                        <!-- Quantity Dropdown -->
                        <p>
                            Quantity:
                            <asp:DropDownList ID="ddlQuantity" runat="server">
                                <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                            </asp:DropDownList>
                        </p>

                        <!-- Add to Cart Button -->
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" OnClick="btnAddToCart_Click" CssClass="btn" />
                    </div>
                </td>
            </tr>
        </table>




    </main>
</asp:Content>