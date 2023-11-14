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

namespace SportsStore
{
    public partial class Order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            showPayment();
        }
        // if the user is logged in and has a cart, show the payment panel
        protected void showPayment()
        {
            // check if user is logged in and has cart
            if(User.Identity.IsAuthenticated)
            {
                // check if cartID exists in the session
                if (Session["CartID"] != null)
                {
                    // get cartID
                    string cartID = Session["CartID"].ToString();
                    string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        conn.Open();

                        using (SqlCommand cmd = new SqlCommand("spShoppingCartGetItems", conn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@CartID", cartID);

                            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);
                                //if not empty, show the checkout button
                                if (dt.Rows.Count > 0)
                                {
                                    // set ShipPayPanel to visible
                                    ShipPayPanel.Visible = true;
                                }
                                else
                                {
                                    NoItems.Visible = true;
                                }
                            }
                        }
                    }
                }
                else
                {
                    NoItems.Visible = true;
                }
            }
            else
            {
                NoItems.Visible = true;
            }   
        }
        private void ProcessOrder()
        {
            // get user Id
            string userId = HttpContext.Current.User.Identity.GetUserId();
            // get cartID
            string cartID = Session["CartID"].ToString();
            // check if cartID exists in the session
            if (cartID != null & userId != null)
            {
                    string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();

                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        conn.Open();
                        using (SqlCommand cmd = new SqlCommand("spCreateCustomerOrder", conn))
                        {
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@CartID", cartID);
                            cmd.Parameters.AddWithValue("@CustomerID", userId);
                            cmd.Parameters.Add("@OrderID", SqlDbType.Int);
                            cmd.Parameters["@OrderID"].Direction = ParameterDirection.Output;
                            cmd.ExecuteNonQuery();
                            // Check if the query result is not null before setting CartTotal.Text
                            if (cmd.Parameters["@OrderID"].Value != DBNull.Value)
                            {
                                PaySuccess.Visible = true;
                                OrderNumber.Text = cmd.Parameters["@OrderID"].Value.ToString();
                            }
                        }
                    }
            }
        }
        // simulate payment processing with form that goes nowhere
        public void Pay_Click(object sender, EventArgs e)
        {
            // verify information is in the correct format
            if (Page.IsValid)
            {
                // process payment
                ProcessOrder();
                // clear the cart
                Session["CartID"] = null;
                // hide the payment panel
                ShipPayPanel.Visible = false;
            }
        }
    }
}