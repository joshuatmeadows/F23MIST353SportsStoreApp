<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductsByCategory.aspx.cs" Inherits="SportsStore.ProductsByCategory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
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
    </form>
</body>
</html>
