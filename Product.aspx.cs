using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SportsStore
{
    public partial class Product : System.Web.UI.Page
    {
        private void LoadProductDetails(string productID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Product WHERE ProductID = @ProductID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductID", productID);

                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblName.Text = reader["Name"].ToString();
                    imgImage.ImageUrl = $"Content/images/{reader["Image"].ToString()}";
                    lblDescription.Text = reader["Description"].ToString();
                    lblPrice.Text = reader["Price"].ToString();
                    if (reader["Quantity"] == DBNull.Value || Convert.ToInt32(reader["Quantity"]) == 0)
                    {
                        lblQuantity.Text = "Sold out!";
                    }
                    else
                    {
                        lblQuantity.Text = $"Hurry, only {reader["Quantity"].ToString()} left available!";
                    }
                }
                reader.Close();
            }
        }
            protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string productID = Request.QueryString["ID"];
                if (string.IsNullOrEmpty(productID))
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    LoadProductDetails(productID);
                }
            }
        }
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            string productId = Request.QueryString["ID"]; // Assuming the product ID is passed in the query string
            int quantity = int.Parse(ddlQuantity.SelectedValue);

            Session["ProductID"] = productId;
            Session["Quantity"] = quantity;

            Response.Redirect("Cart.aspx");
        }
    }
}