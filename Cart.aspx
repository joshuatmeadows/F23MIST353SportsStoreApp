<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Cart.aspx.cs" Inherits="SportsStore.Cart" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   
   <!-- Table for displaying cart items -->
   <table style="width:100%">
        <!-- Repeater control for iterating over cart items -->
        <asp:Repeater ID="gvCartItems" runat="server" >
            <ItemTemplate>
                <tr>
                    <!-- Product name linked to the product page -->
                    <td style="width:50%">
                        <a href="Product?ID=<%# Eval("ProductID") %>">
                            <%# Eval("Name") %>
                        </a>
                    </td>
                    <!-- Quantity of the product in the cart -->
                    <td style="width:10%">
                        <%# Eval("Quantity") %>
                    </td>
                    <!-- Subtotal for each product, showing unit price as well -->
                    <td style="width:25%">
                        <p><%# Eval("Subtotal") %></p>
                        <p> ( <%# Eval("Price") %> each)</p>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>

    <!-- Label for displaying the total cost of the cart -->
    <asp:Label ID="CartTotal" runat="server"></asp:Label>

    <!-- Panel shown to logged-in users for checkout -->
    <asp:Panel runat="server" ID="ShowCheckOut" visible="False">
        <!-- Login view control for different templates based on user authentication -->
        <asp:LoginView runat="server" ID="LoginView1">
            <LoggedInTemplate>
                <a class="btn" runat="server" href="~/Order">Check out</a>
            </LoggedInTemplate>
            <AnonymousTemplate>
                <a class="btn" runat="server" href="~/Login">Login to order</a>
            </AnonymousTemplate>
        </asp:LoginView>
    </asp:Panel>

    <!-- Panel displayed when the cart is empty -->
    <asp:Panel runat="server" ID="NoItems" visible="False">
        <p>Your cart is empty</p>
    </asp:Panel>

</asp:Content>
