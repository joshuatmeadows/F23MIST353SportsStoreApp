# SportsStore Ecommerce Web App

## Understanding the Project

### Navigating Through Commits

For a comprehensive understanding of this project's development and progression, it's crucial to sift through the commit history. Every commit encapsulates the content covered in each class session, providing detailed explanations and context. If you're joining in midway or find certain aspects confusing, consider revisiting previous commits to gain a clearer perspective on the project's journey.

---

## Current Commit Changes

### 1. Connection String Addition

In this phase of the project, we've added a connection string for "SportsStoreDB" in the [`Web.config`](Web.config) file. This connection string is pivotal for establishing a link between our ASP.NET application and the database.

**Note**: Depending on your setup and configurations, your connection string might slightly differ from what's provided in the repo. Ensure that it corresponds to your SQL Server setup.

### 2. "Hello World!" Replacement

We've transitioned from a simple text-based output to displaying dynamic data. The text "Hello World!" on [`Default.aspx`](Default.aspx) has been replaced with an ASP.NET GridView control:

```xml
<asp:GridView ID="Categories" runat="server"></asp:GridView>
```

This control is designed to display data in a tabular format.

### 3. Backend Logic

In the code-behind for `Default.aspx` (i.e., [`Default.aspx.cs`](Default.aspx.cs)), significant changes have been introduced:

- **GetDataFromDatabase Method**: This method establishes a connection to our "SportsStoreDB" using the connection string from the `Web.config`. It then invokes a stored procedure (`spGetAllCategories`) to fetch all category data, populating a DataTable.

- **Page_Load Method**: This method, which is triggered when the page loads, is now responsible for setting the data source of our GridView (`Categories`) to the data fetched from the database. It then binds this data, ensuring that it gets displayed on the page.

**Concepts Explored**:

- **Database Connectivity**: The process of setting up a connection string and establishing a link between the web application and a database.
  
- **Data Retrieval**: Using ADO.NET to fetch data from a SQL Server database.
  
- **Data Binding**: The act of tying data to UI components, in this case, binding the fetched categories to a GridView.

- **Stored Procedure Execution**: Leveraging stored procedures, which are pre-written SQL statements stored in the database, for data retrieval. In this commit, we've utilized the `spGetAllCategories` stored procedure that was created earlier in the course.

### Result

Upon visiting the home page, users will now see a table displaying all the Categories from the "SportsStoreDB" database.

---

## Moving Forward

The project is evolving, and with each commit, we are diving deeper into the intricacies of ASP.NET and database interactions. As always, if you feel lost or need more context on the changes, reviewing previous commits can be highly beneficial.

Stay curious and happy coding!