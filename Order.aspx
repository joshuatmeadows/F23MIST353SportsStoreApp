<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Order.aspx.cs" Inherits="SportsStore.Order" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Panel for collecting shipping and payment information, initially set to be invisible -->
    <asp:Panel ID="ShipPayPanel" runat="server" Visible="false">
        <h2>Ship To</h2>
        <!-- Input fields for shipping information like name, address, city, state, zip, and country -->
        Name: <asp:TextBox ID="Name" runat="server"></asp:TextBox><br />
        Address Line 1: <asp:TextBox ID="Line1" runat="server"></asp:TextBox><br />
        Address Line 2: <asp:TextBox ID="Line2" runat="server"></asp:TextBox><br />
        Address Line 3: <asp:TextBox ID="Line3" runat="server"></asp:TextBox><br />
        City: <asp:TextBox ID="City" runat="server"></asp:TextBox><br />
        State: <asp:TextBox ID="State" runat="server"></asp:TextBox><br />
        Zip: <asp:TextBox ID="Zip" runat="server"></asp:TextBox><br />
        Country: <asp:TextBox ID="Country" runat="server"></asp:TextBox><br />

        <!-- Section for payment information -->
        <h2>Pay With</h2>
        Card Number: <asp:TextBox ID="CardNumber" runat="server"></asp:TextBox><br />
        Expiry Date: <asp:TextBox ID="ExpiryDate" runat="server"></asp:TextBox><br />

        <!-- Button to submit the payment -->
        <asp:Button ID="Pay" runat="server" Text="Pay For Order" OnClick="Pay_Click" />
    </asp:Panel>

    <!-- Panel to display order confirmation message, initially set to be invisible -->
    <asp:Panel ID="PaySuccess" runat="server" Visible="false">
        <h2>Order Confirmation</h2>
        <p>
            Thank you for your order. Your order number is
            <asp:Label ID="OrderNumber" runat="server"></asp:Label>
        </p>
    </asp:Panel>

    <!-- Panel to display a message when there are no items in the cart, initially set to be invisible -->
    <asp:Panel ID="NoItems" runat="server" Visible="false">
        There is nothing in your cart.
    </asp:Panel>

</asp:Content>
