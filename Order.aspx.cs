// Import necessary namespaces for ASP.NET Identity, data access, configuration, and web controls
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

// Namespace declaration for the SportsStore application
namespace SportsStore
{
    // Partial class for the Order page, inheriting from System.Web.UI.Page
    public partial class Order : System.Web.UI.Page
    {
        // Event handler for the page load event
        protected void Page_Load(object sender, EventArgs e)
        {
            // Call to show the payment options when the page is loaded
            showPayment();
        }

        // Method to display the payment panel if certain conditions are met
        protected void showPayment()
        {
            // Check if the user is authenticated and has a cart
            if (User.Identity.IsAuthenticated)
            {
                if (Session["CartID"] != null)
                {
                    string cartID = Session["CartID"].ToString();
                    string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();

                    // Establish a connection to the database
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        conn.Open();

                        // SQL command to get items from the shopping cart
                        using (SqlCommand cmd = new SqlCommand("spShoppingCartGetItems", conn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@CartID", cartID);

                            // Use SqlDataAdapter to fill DataTable
                            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);

                                // Show the ShipPayPanel if the cart is not empty
                                if (dt.Rows.Count > 0)
                                {
                                    ShipPayPanel.Visible = true;
                                }
                                else
                                {
                                    // Show a message if no items are present
                                    NoItems.Visible = true;
                                }
                            }
                        }
                    }
                }
                else
                {
                    // Show a message if no cart is present
                    NoItems.Visible = true;
                }
            }
            else
            {
                // Show a message if the user is not authenticated
                NoItems.Visible = true;
            }
        }

        // Method to process the order
        private void ProcessOrder()
        {
            // Retrieve the user ID and cart ID
            string userId = HttpContext.Current.User.Identity.GetUserId();
            string cartID = Session["CartID"].ToString();

            // Check if cartID and userId exist
            if (cartID != null & userId != null)
            {
                string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();

                // Establish a connection to the database
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    // SQL command to create a customer order
                    using (SqlCommand cmd = new SqlCommand("spCreateCustomerOrder", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@CartID", cartID);
                        cmd.Parameters.AddWithValue("@CustomerID", userId);
                        cmd.Parameters.Add("@OrderID", SqlDbType.Int);
                        cmd.Parameters["@OrderID"].Direction = ParameterDirection.Output;

                        // Execute the command
                        cmd.ExecuteNonQuery();

                        // Display success message and order number if the order is created successfully
                        if (cmd.Parameters["@OrderID"].Value != DBNull.Value)
                        {
                            PaySuccess.Visible = true;
                            OrderNumber.Text = cmd.Parameters["@OrderID"].Value.ToString();
                        }
                    }
                }
            }
        }

        // Event handler for the payment button click
        public void Pay_Click(object sender, EventArgs e)
        {
            // Check if the page is valid (all required validators are satisfied)
            if (Page.IsValid)
            {
                // Call to process the order
                ProcessOrder();

                // Clear the cart from the session
                Session["CartID"] = null;

                // Hide the payment panel
                ShipPayPanel.Visible = false;
            }
        }
    }
}
