# SportsStore Ecommerce Web App

## Understanding the Project

### Navigating Through Commits

For a comprehensive understanding of the project's development, diving into the commit history is crucial. Each commit encapsulates the conversations and lessons of every class, providing detailed explanations and comments. If you're jumping into this phase or if a particular change seems obscure, revisiting prior commits can offer invaluable context and insight.

---

## Current Commit Changes

### 1. Image Enhancement on [`Product.aspx`](Product.aspx)

The [`Product.aspx`](Product.aspx) page now sports a dynamic image representation of the product. An ASP.NET Image control has been added:

```xml
<asp:Image ID="imgImage" runat="server" AlternateText="Image" CssClass="productImage" />
```

In the [`Product.aspx.cs`](Product.aspx) code-behind, this image control is dynamically populated based on the product data retrieved:

```csharp
imgImage.ImageUrl = $"Content/images/{reader["Image"].ToString()}";
```

### 2. Site.Master Refinements

Minor aesthetic and content adjustments have been made to the `Site.Master` file. This includes modifications like site name changes to better reflect the project's evolving nature.

### 3. Incorporation of Product Images

A collection of product images has been introduced and stored under the directory `Content/images/`. These images are fetched dynamically based on product data and rendered on the [`Product.aspx`](Product.aspx) page.

### 4. CSS Modifications

The `Site.css` has been enhanced to dictate the maximum dimensions for product images with the `.productImage` class, ensuring consistent presentation and avoiding oversized or stretched images.

### 5. Bootstrap Styles Update

New versions of `bootstrap.css` and `bootstrap-min.css` have been fetched from [Bootswatch](https://bootswatch.com/). Incorporating these files ensures the application remains aesthetically up-to-date and benefits from the latest style enhancements and fixes from Bootstrap.

### 6. Site.Master Integration with Pages

The `Site.Master` has been applied to both the [`Product.aspx`](Product.aspx) and [`ProductsByCategory.aspx`](ProductsByCategory.aspx) pages. This ensures a uniform and consistent layout and navigation experience across these pages.

---

## Concepts Explored

- **Dynamic Image Rendering**: This commit has delved deep into the mechanics of dynamically loading and displaying images based on product data, enhancing the visual appeal of the [`Product.aspx`](Product.aspx) page.
  
- **CSS Styling & Bootstrap**: The importance of maintaining updated stylesheets for an evolving web application, along with the significance of external libraries like Bootstrap, has been underscored with this commit.
  
- **Master Pages**: The concept of master pages in ASP.NET, which allows for a consistent layout across multiple pages, is demonstrated by applying `Site.Master` to various content pages.

---

## Moving Forward

As the project expands, each commit brings with it a set of new features and improvements. To gain a clear understanding, occasionally referencing previous commits will be invaluable. 

Keep up the enthusiasm, and let's advance this coding journey!