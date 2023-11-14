// Standard using directives for ASP.NET and ADO.NET
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
    // Cart page class inheriting from System.Web.UI.Page
    public partial class Cart : System.Web.UI.Page
    {
        // Event handler for the page load event
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the request is not a postback (i.e., the page is being loaded for the first time)
            if (!IsPostBack)
            {
                // Initialize and process cart-related functionalities
                EnsureCartID();
                ProcessCart();
                DisplayCartItems();
                getCartTotal();
            }
        }

        // Ensures a unique cart ID is associated with the user's session
        private void EnsureCartID()
        {
            // Check if CartID exists in the session
            if (Session["CartID"] == null)
            {
                // Generate a new CartID using GUID and store it in the session
                string newCartID = Guid.NewGuid().ToString();
                Session["CartID"] = newCartID;
            }
        }

        // Processes the items in the cart
        private void ProcessCart()
        {
            // Retrieve the connection string from web.config
            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
            // Retrieve CartID and ProductID from the session
            string cartID = Session["CartID"].ToString();
            string productID = Session["ProductID"] as string;

            // Proceed only if productID is not empty
            if (!string.IsNullOrEmpty(productID))
            {
                // Retrieve quantity from the session and initialize previous quantity
                int requestQuantity = (int)Session["Quantity"];
                int prevQuantity = 0;

                // Establish a new SQL connection
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    // Check if the item already exists in the cart
                    using (SqlCommand cmd = new SqlCommand("spShoppingCartGetItems", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@CartID", cartID);

                        // Execute the command and process the results
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                if (reader["ProductID"].ToString() == productID)
                                {
                                    prevQuantity = int.Parse(reader["Quantity"].ToString());
                                    break;
                                }
                            }
                        }
                    }

                    // Add the item to the cart if it's not already there
                    if (prevQuantity == 0)
                    {
                        using (SqlCommand cmd = new SqlCommand("spShoppingCartAddItem", conn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@CartID", cartID);
                            cmd.Parameters.AddWithValue("@ProductID", productID);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Update the item quantity in the cart
                    using (SqlCommand cmd = new SqlCommand("spShoppingCartUpdateItem", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@CartID", cartID);
                        cmd.Parameters.AddWithValue("@ProductID", productID);
                        cmd.Parameters.AddWithValue("@Quantity", prevQuantity + requestQuantity);
                        cmd.ExecuteNonQuery();
                    }
                }

                // Clear ProductID and Quantity from the session
                Session.Remove("ProductID");
                Session.Remove("Quantity");
            }
        }

        // Displays cart items in a grid view
        private void DisplayCartItems()
        {
            // Same procedure as ProcessCart for establishing connection
            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
            string cartID = Session["CartID"].ToString();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand("spShoppingCartGetItems", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CartID", cartID);

                    // Use SqlDataAdapter to fill DataTable and bind it to GridView
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvCartItems.DataSource = dt;
                        gvCartItems.DataBind();

                        // Show checkout button if there are items in the cart
                        if (dt.Rows.Count > 0)
                        {
                            ShowCheckOut.Visible = true;
                        }
                        else
                        {
                            NoItems.Visible = true;
                        }
                    }
                }
            }
        }

        // Retrieves and displays the total amount of the cart
        public void getCartTotal()
        {
            // Same procedure for establishing connection
            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
            string cartID = Session["CartID"].ToString();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand("spShoppingCartGetTotalAmount", conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CartID", cartID);
                    cmd.Parameters.Add("@TotalAmount", SqlDbType.Money, 16);
                    cmd.Parameters["@TotalAmount"].Direction = ParameterDirection.Output;

                    // Execute command and retrieve the total amount
                    cmd.ExecuteNonQuery();
                    // Check if the query result is not null before displaying the total
                    if (cmd.Parameters["@TotalAmount"].Value != DBNull.Value)
                    {
                        CartTotal.Text = "Total: " + cmd.Parameters["@TotalAmount"].Value.ToString();
                    }
                }
            }
        }
    }
}
