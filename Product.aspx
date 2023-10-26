<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="SportsStore.Product" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td><asp:Image ID="imgImage" runat="server" AlternateText="Product Image" CssClass="productImage"/></td>
                    <td>
                        <h2><asp:Label ID="lblName" runat="server"></asp:Label></h2>
                        <p><asp:Label ID="lblDescription" runat="server"></asp:Label></p>
                        <p><em><asp:Label ID="lblPrice" runat="server"></asp:Label></em></p>
                        <p><strong><asp:Label ID="lblQuantity" runat="server"></asp:Label></strong></p>
                     </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
