<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SportsStore._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Main HTML element typically used for the primary content of the page -->
    <main>
        <!-- ASP.NET Repeater control used to display a list of items -->
        <asp:Repeater ID="Categories" runat="server">
            <ItemTemplate>
                <!-- Dynamic link for each category, using Eval to bind data from a data source -->
                <a href="ProductsByCategory.aspx?ID=<%# Eval("CategoryID") %>">
                    <%# Eval("Name") %> <!-- Displaying the name of the category -->
                </a>
                <br /> <!-- Line break for visual separation between categories -->
            </ItemTemplate>
        </asp:Repeater>
    </main>

</asp:Content>

