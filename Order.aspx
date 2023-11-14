<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="SportsStore.Order" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="ShipPayPanel" runat="server" Visible="false">
        <h2>Ship To</h2>
        Address: <asp:TextBox ID="Address" runat="server"></asp:TextBox><br />
        City: <asp:TextBox ID="City" runat="server"></asp:TextBox><br />
        State: <asp:TextBox ID="State" runat="server"></asp:TextBox><br />
        Zip: <asp:TextBox ID="Zip" runat="server"></asp:TextBox><br />
        <h2>Payment Information</h2>
        Card Number: <asp:TextBox ID="CCNum" runat="server"></asp:TextBox><br />
Expiration Date: <asp:TextBox ID="ExpDate" runat="server"></asp:TextBox><br />
        <asp:Button ID="Pay" runat="server" Text="Pay For Order" OnClick="Pay_Click" />
    </asp:Panel>
    <asp:Panel ID="PaySuccess" runat="server" Visible="false">
        <h2>Order Confirmation</h2>
        <p>
            Thank you for your order. Your order number is <asp:Label ID="OrderNumber" runat="server" />
        </p>
    </asp:Panel>
    <asp:Panel ID="NoItems" runat="server" Visible="false">
        There is nothing in your cart.
    </asp:Panel>
</asp:Content>
