<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="SportsStore.Product" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h2><asp:Label ID="lblName" runat="server" Text="Product Name"></asp:Label></h2>
        <p><asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label></p>
        <p>Price: <asp:Label ID="lblPrice" runat="server" Text="0"></asp:Label></p>
        <p><asp:Label ID="lblQuantity" runat="server" Text="0"></asp:Label></p>
    </form>
</body>
</html>
