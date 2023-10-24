# SportsStore Ecommerce Web App

## Understanding the Project

### Navigating Through Commits

To comprehensively understand and follow the development of this project, it's pivotal to review the commit history. Each commit captures the content and topics discussed during each class session, providing detailed explanations and context. If you're starting mid-project or some changes seem ambiguous, revisiting prior commits can illuminate the path we've traversed.

---

## Current Commit Changes

### 1. Introduction of the [`ProductsByCategory.aspx`](ProductsByCategory.aspx) Page

We've expanded the project by introducing a new page named `ProductsByCategory.aspx`. This page is designed to display products under a specific category.

The central component on this page is the ASP.NET GridView control:

```xml
<asp:GridView ID="Products" runat="server"></asp:GridView>
```

The GridView is intended to display product data in a tabular format.

### 2. Backend Logic for [`ProductsByCategory.aspx.cs`](ProductsByCategory.aspx.cs)

The code-behind for this page (`ProductsByCategory.aspx.cs`) has the following essential elements:

- **GetDataFromDatabase Method**: This method does the heavy lifting:

    - Establishes a connection to "SportsStoreDB" via the connection string.
    - Retrieves the category ID from the query string.
    - Executes a stored procedure (`spGetProductsinCategory`) with a parameterized query to prevent SQL injection, and fetches the products related to the provided category ID.
    
- **Page_Load Method**: Similar to the earlier approach, this method binds the fetched data to the GridView (`Products`) so it's displayed when the page loads.

### 3. Refinement of [`Default.aspx`](Default.aspx) GridView

The GridView in `Default.aspx` has been replaced by an ASP.NET Repeater control. This control is more flexible and allows us to display categories as clickable links:

```xml
<asp:Repeater ID="Categories" runat="server">
    <ItemTemplate>
        <a href="ProductsByCategory.aspx?ID=<%# Eval("CategoryID") %>">
            <%# Eval("Name") %>
        </a>
        <br />
    </ItemTemplate>
</asp:Repeater>
```

Each category link, when clicked, redirects to the `ProductsByCategory.aspx` page with the respective category's ID passed in the query string. This action, in turn, populates the page with products corresponding to that category.

---

## Concepts Explored

- **Page Navigation & Parameters**: The introduction of the Repeater control and passing of category IDs through query strings demonstrate a fundamental way of navigating between pages and passing parameters in ASP.NET.
  
- **Parameterized Queries**: Emphasizing secure coding practices, the code uses parameterized SQL queries to prevent potential SQL injection attacks.
  

---

## Moving Forward

As the project evolves, we're gradually delving into more advanced features and concepts of ASP.NET, refining our application into a functional ecommerce platform. If certain changes or concepts seem unclear, always consider reverting to previous commits for a deeper understanding.

Stay engaged and happy coding!