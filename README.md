# SportsStore Ecommerce Web App

## Understanding the Project

### Navigating Through Commits

To grasp the complete narrative and evolution of this project, it's essential to delve into the commit history. Each commit crystallizes the discussions and demonstrations of each class, with in-depth explanations and annotations. If you're hopping in at this stage or find certain modifications puzzling, it's beneficial to refer back to previous commits to trace the project's trajectory.

---

## Current Commit Changes

### 1. Introduction of the [`Product.aspx`](Product.aspx) Page

We've added a new dedicated page named [`Product.aspx`](Product.aspx) to showcase individual product details. The page contains several ASP.NET Label controls that dynamically populate and render product-specific data:

```xml
<form id="form1" runat="server">
    <h2><asp:Label ID="lblName" runat="server" Text="Product Name"></asp:Label></h2>
    <p><asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label></p>
    <p>Price: <asp:Label ID="lblPrice" runat="server" Text="0"></asp:Label></p>
    <p><asp:Label ID="lblQuantity" runat="server" Text="0"></asp:Label></p>
</form>
```

### 2. Backend Logic for [`Product.aspx.cs`](Product.aspx)

The [`Product.aspx.cs`](Product.aspx) code-behind facilitates the fetching and rendering of product details:

- **LoadProductDetails Method**: Connects to the "SportsStoreDB" and queries the individual product based on its ID. The method then assigns the product details to the respective Label controls on the page.

- **Page_Load Method**: Responsible for checking the presence of a product ID in the query string and then invoking the `LoadProductDetails` method to fetch and display the relevant product's details.

### 3. Refinements in [`ProductsByCategory.aspx`](ProductsByCategory.aspx) & `.cs`

The [`ProductsByCategory.aspx`](ProductsByCategory.aspx) page has been further modified to provide links to individual products, guiding users to the [`Product.aspx`](Product.aspx) page with a specific product ID in the query string.

Additionally, in [`ProductsByCategory.aspx.cs`](ProductsByCategory.aspx.cs), logic has been introduced to ensure there's a category ID in the query string. If absent, users are redirected back to the [`Default.aspx`](Default.aspx) page.

---

## Concepts Explored

- **Individual Product Display**: The introduction of the [`Product.aspx`](Product.aspx) page marks our venture into displaying detailed information about individual products.
  
- **Query String Parameter Checking**: The check for the presence of query string parameters in both [`Product.aspx.cs`](Product.aspx) and `ProductsByCategory.aspx.cs` exemplifies best practices for ensuring expected behavior and preventing potential errors.
  
- **DataReader Usage**: The use of `SqlDataReader` in [`Product.aspx.cs`](Product.aspx) showcases another method of reading data from a database, offering a fast and efficient way to read and forward-only data.

- **Dynamic Content Rendering**: The dynamism introduced in this commit — be it redirecting users based on missing parameters, or dynamically rendering product details based on provided IDs — highlights the flexible capabilities of ASP.NET in web app development.

---

## Moving Forward

With each commit, our project continues to expand and diversify, integrating more advanced ASP.NET features. As we build upon this foundation, it's essential to occasionally reference previous commits if you need clarity or context.

Stay engaged, and let's continue this coding journey!