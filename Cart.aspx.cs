﻿using System;
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
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EnsureCartID();
                ProcessCart();
                DisplayCartItems();
                getCartTotal();
            }
        }

        private void EnsureCartID()
        {
            // Check if CartID exists in the session
            if (Session["CartID"] == null)
            {
                // Create a new CartID and store it in the session
                string newCartID = Guid.NewGuid().ToString();
                Session["CartID"] = newCartID;
            }
        }

        private void ProcessCart()
        {
            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
            string cartID = Session["CartID"].ToString();
            string productID = Session["ProductID"] as string;
            if (!string.IsNullOrEmpty(productID))
            {
                int requestQuantity = (int)Session["Quantity"];
                int prevQuantity = 0;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    // Check if the item already exists in the cart
                    using (SqlCommand cmd = new SqlCommand("spShoppingCartGetItems", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@CartID", cartID);

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

                    if (prevQuantity == 0) // Item doesn't exist in the cart
                    {
                        using (SqlCommand cmd = new SqlCommand("spShoppingCartAddItem", conn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@CartID", cartID);
                            cmd.Parameters.AddWithValue("@ProductID", productID);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Update the item quantity
                    using (SqlCommand cmd = new SqlCommand("spShoppingCartUpdateItem", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@CartID", cartID);
                        cmd.Parameters.AddWithValue("@ProductID", productID);
                        cmd.Parameters.AddWithValue("@Quantity", prevQuantity + requestQuantity);
                        cmd.ExecuteNonQuery();
                    }
                }
                Session.Remove("ProductID");
                Session.Remove("Quantity");
            }

        }
        private void DisplayCartItems()
        {
            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
            string cartID = Session["CartID"].ToString();

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
                        gvCartItems.DataSource = dt;
                        gvCartItems.DataBind();
                        //if not empty, show the checkout button
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
        public void getCartTotal()
        {
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
                    cmd.ExecuteNonQuery();
                    // Check if the query result is not null before setting CartTotal.Text
                    if (cmd.Parameters["@TotalAmount"].Value != DBNull.Value)
                    {
                        CartTotal.Text = "Total: " + cmd.Parameters["@TotalAmount"].Value.ToString();
                    }
                }
            }
        }
    }
}