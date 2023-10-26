# SportsStore Ecommerce Web App

## Understanding the Project

### Navigating Through Commits

For a comprehensive understanding of the project's development, diving into the commit history is crucial. Each commit encapsulates the conversations and lessons of every class, providing detailed explanations and comments. If you're jumping into this phase or if a particular change seems obscure, revisiting prior commits can offer invaluable context and insight.

---

## Current Commit Changes

### 1. Introduction of [`Cart.aspx`](Cart.aspx)

The [`Cart.aspx`](Cart.aspx) page is the newest addition to our web application. This page allows users to view their cart items and facilitates the addition of products to the cart. Here are the core functionalities it offers:

- **EnsureCartID**: This method ensures a unique CartID is maintained for every user session, utilizing the Session state for persistence.
  
- **ProcessCart**: This method is responsible for processing cart functionalities, i.e., adding products to the cart, updating existing items' quantities, and so forth. This relies on stored procedures like `spShoppingCartGetItems`, `spShoppingCartAddItem`, and `spShoppingCartUpdateItem` for backend operations.
  
- **DisplayCartItems**: This method fetches the items currently in the cart and displays them using the `gvCartItems` GridView control.

### 2. Enhanced [`Product.aspx`](Product.aspx)

The [`Product.aspx`](Product.aspx) page has undergone several enhancements:

- **Quantity Dropdown**: Users can now select the desired quantity of a product before adding it to the cart, providing better user experience and control.
  
- **Add to Cart Button**: A button has been introduced allowing users to seamlessly add products to their cart. 
  
- **Cosmetic Changes**: Aesthetic improvements have been made to ensure the page is more user-friendly and appealing.

---

## Concepts Explored

- **Shopping Cart Mechanism**: This commit mainly revolves around the fundamental concept of maintaining a shopping cart in an e-commerce platform. This involves generating unique cart IDs for individual sessions, adding items to the cart, updating cart items, and displaying the cart.
  
- **ASP.NET Session State**: The utility of the session state in ASP.NET has been showcased, where it's used to persist data like CartID, ProductID, and Quantity across postbacks and different pages.
  
- **Stored Procedures**: The use of stored procedures for database operations emphasizes good security practices, abstraction of SQL logic, and improved performance.

---

## Moving Forward

The cart functionality is a pivotal component of any e-commerce platform, allowing users to accumulate their desired products and proceed to checkout. As we continue to enhance our SportsStore application, it's vital to test these functionalities thoroughly, ensuring a smooth user experience. Let's keep coding and refining our web application!