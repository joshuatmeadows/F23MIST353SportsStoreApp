<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ProductsByCategory.aspx.cs" Inherits="SportsStore.ProductsByCategory" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <div>
            <asp:Repeater ID="Products" runat="server">
                <ItemTemplate>
                    <a href="Product.aspx?ID=<%# Eval("ProductID") %>">
                        <%# Eval("Name") %>
                    </a>
                    <br />
                </ItemTemplate>
            </asp:Repeater>
        </div>
</asp:Content>
