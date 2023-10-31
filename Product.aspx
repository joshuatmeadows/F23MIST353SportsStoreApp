<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Product.aspx.cs" Inherits="SportsStore.Product" %>



<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div>
            <table>
                <tr>
                    <td><asp:Image ID="imgImage" runat="server" AlternateText="Product Image" CssClass="productImage"/></td>
                    <td>
                        <h2><asp:Label ID="lblName" runat="server"></asp:Label></h2>
                        <p><asp:Label ID="lblDescription" runat="server"></asp:Label></p>
                        <p><em><asp:Label ID="lblPrice" runat="server"></asp:Label></em></p>
                        <p><strong><asp:Label ID="lblQuantity" runat="server"></asp:Label></strong></p>
                        <div>
                            <p>
                                Quantity:
                                <asp:DropDownList ID="ddlQuantity" runat="server">
                                    <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                    <asp:ListItem Value="2">2</asp:ListItem>
                                    <asp:ListItem Value="3">3</asp:ListItem>
                                </asp:DropDownList>
                            </p>
                            <p>
                                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" OnClick="btnAddToCart_Click" CssClass="btn" />
                            </p>
                        </div>
                     </td>
                </tr>
            </table>
        </div>
</asp:Content>

