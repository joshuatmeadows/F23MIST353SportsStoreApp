# SportsStore Ecommerce Web App

## Understanding the Project

### Navigating Through Commits

Reviewing the commit history is key to understanding the evolution of this project. Each commit documents a phase of development, providing context and explanations for the changes made. If you're catching up or need clarification on specific updates, revisiting previous commits can be very helpful.

---

## Current Commit Changes

### 1. Enhancements to [`Cart.aspx`](Cart.aspx) and [`Cart.aspx.cs`](Cart.aspx)

The `Cart.aspx` page and its code-behind have undergone significant improvements for a more dynamic and user-friendly experience.

- **asp:Panel and Visibility Switching**: Introduced asp:Panel control in `Cart.aspx` for better UI management. This allows for dynamic switching of visibility, enhancing the user experience by showing or hiding elements based on certain conditions (like if the cart is empty or has items).

- **Stored Procedure Modification**: The `spShoppingCartGetItems` stored procedure has been altered to include additional cart details such as product attributes, name, price, and subtotal calculation. This change enriches the information displayed in the user's cart, providing a clearer summary of their potential purchase.

    ```sql
    ALTER PROCEDURE [dbo].[spShoppingCartGetItems] @CartID CHAR(36)
    AS
    BEGIN
        SELECT sc.ProductID, Attributes, sc.Quantity, DateAdded, [Name], Price, Price*sc.Quantity Subtotal 
        FROM [dbo].[ShoppingCart] sc
	    Join Product
	    on Product.ProductID = sc.ProductID
        WHERE CartID = @CartID;
    END
    ```

### 2. Creation of [`Order.aspx`](Order.aspx) and [`Order.aspx.cs`](Order.aspx)

- **Order Processing**: A new page, `Order.aspx`, has been created to handle the final step in the shopping experience - placing an order. This page collects payment and shipping information from the user.

- **Backend Logic with Stored Procedure**: The code-behind, `Order.aspx.cs`, integrates the logic to process the order using the `spCreateCustomerOrder` stored procedure. This involves handling user input for payment and shipping details and then executing the procedure to finalize the order.

---

## Concepts Explored

- **User Interface Dynamics**: The use of asp:Panel for dynamic content visibility based on user actions or cart status exemplifies advanced user interface techniques in ASP.NET Web Forms.

- **Complex Stored Procedures**: The modification of the `spShoppingCartGetItems` stored procedure to retrieve more detailed information demonstrates how SQL can be used to enhance data retrieval processes for complex application functionalities.

- **Order Processing**: Introduction of the order placement functionality with `Order.aspx` highlights a critical component of e-commerce applications, encompassing user input handling, payment processing, and order finalization.

---

## Moving Forward

These enhancements bring substantial functionality to the SportsStore app, moving it closer to a fully operational e-commerce platform. Testing these new features for robustness and user experience is key in this phase. As always, keep exploring, coding, and enhancing!