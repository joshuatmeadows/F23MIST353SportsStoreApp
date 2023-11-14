// Importing necessary namespaces
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

// Namespace declaration for the SportsStore application
namespace SportsStore
{
    // Partial class for the Product page, inheriting from System.Web.UI.Page
    public partial class Product : System.Web.UI.Page
    {
        // Method to load product details from the database
        private void LoadProductDetails(string productID)
        {
            // Retrieving the database connection string from Web.config
            string connStr = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();

            // Establishing a connection to the database
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // SQL query to select product details by product ID
                string query = "SELECT * FROM Product WHERE ProductID = @ProductID";
                SqlCommand cmd = new SqlCommand(query, conn);
                // Adding product ID as a parameter to prevent SQL injection
                cmd.Parameters.AddWithValue("@ProductID", productID);

                // Opening the database connection
                conn.Open();

                // Executing the query and reading the results
                SqlDataReader reader = cmd.ExecuteReader();

                // If a product is found, populate the page with its details
                if (reader.Read())
                {
                    lblName.Text = reader["Name"].ToString();
                    imgImage.ImageUrl = $"Content/images/{reader["Image"].ToString()}";
                    lblDescription.Text = reader["Description"].ToString();
                    lblPrice.Text = reader["Price"].ToString();

                    // Check for product availability
                    if (reader["Quantity"] == DBNull.Value || Convert.ToInt32(reader["Quantity"]) == 0)
                    {
                        lblQuantity.Text = "Sold out!";
                    }
                    else
                    {
                        lblQuantity.Text = $"Hurry, only {reader["Quantity"].ToString()} left available!";
                    }
                }
                // Closing the reader
                reader.Close();
            }
        }

        // Event handler for page load
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the request is the first-time page load, not a postback
            if (!IsPostBack)
            {
                // Retrieve product ID from the query string
                string productID = Request.QueryString["ID"];
                // Redirect to default page if product ID is not provided
                if (string.IsNullOrEmpty(productID))
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    // Load product details for the given ID
                    LoadProductDetails(productID);
                }
            }
        }

        // Event handler for the Add to Cart button click
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            // Retrieve product ID from the query string
            string productId = Request.QueryString["ID"];
            // Retrieve the selected quantity
            int quantity = int.Parse(ddlQuantity.SelectedValue);

            // Store product ID and quantity in the session
            Session["ProductID"] = productId;
            Session["Quantity"] = quantity;

            // Redirect to the Cart page
            Response.Redirect("Cart.aspx");
        }
    }
}
