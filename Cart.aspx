<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Cart.aspx.cs" Inherits="SportsStore.Cart" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   <table style="width:100%">
        <asp:Repeater ID="gvCartItems" runat="server" >
            <ItemTemplate>
                <tr>
                    <td style="width:50%">
                        <a href="Product?ID=<%# Eval("ProductID") %>">
                            <%# Eval("Name") %>
                        </a>
                    </td>
                    <td style="width:10%">
                        <%# Eval("Quantity") %>
                    </td>
                    <td style="width:25%">
                        <p><%# Eval("Subtotal") %></p>
                        <p> ( <%# Eval("Price") %> each)</p>
                    </td>
                </tr>
            </ItemTemplate>


        </asp:Repeater>
    </table>
    <asp:Label ID="CartTotal" runat="server"></asp:Label>

        <asp:Panel runat="server" ID="ShowCheckOut" visible="False">
            <asp:LoginView runat="server" ID="LoginView1">
                <LoggedInTemplate>
                    <a class="btn" runat="server" href="~/Order">Check out</a>
                </LoggedInTemplate>
                <AnonymousTemplate>
                    <a class="btn" runat="server" href="~/Login">Login to order</a>
                </AnonymousTemplate>
            </asp:LoginView>
        </asp:Panel>

        <asp:Panel runat="server" ID="NoItems" visible="False">
            <p>Your cart is empty</p>
        </asp:Panel>

</asp:Content>
