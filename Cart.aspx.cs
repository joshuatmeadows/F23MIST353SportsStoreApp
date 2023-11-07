using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
            if(!IsPostBack)
            {
                EnsureCartID();
                ProcessCart();
                DisplayCartItems();
            }
        }
        private void EnsureCartID()
        {
            if (Session["CartID"] == null)
            {
                string newCartId = Guid.NewGuid().ToString();
                Session["CartID"] = newCartId;
            }
        }
        private void ProcessCart()
        {
            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
            string cartID = Session["CartID"].ToString();
            string productID = Session["ProductID"] as string;
            if (productID != null)
            {
                int requestQuantity = (int)Session["Quantity"];
                int prevQuantity = 0;

                using(SqlConnection conn = new SqlConnection(connString)) 
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("spShoppingCartGetItems", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
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
                    if(prevQuantity == 0)
                    {
                        using(SqlCommand cmd = new SqlCommand("spShoppingCartAddItem", conn))
                        {
                            cmd.CommandType=System.Data.CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@CartID", cartID);
                            cmd.Parameters.AddWithValue("ProductID",productID);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    using(SqlCommand cmd= new SqlCommand("spShoppingCartUpdateItem", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@CartID", cartID);
                        cmd.Parameters.AddWithValue("@ProductID", productID);
                        cmd.Parameters.AddWithValue("@Quantity", prevQuantity + requestQuantity);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            Session.Remove("ProductID");
            Session.Remove("Quantity");
        }
        private void DisplayCartItems()
        {
            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
            string cartID = Session["CartID"].ToString();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using(SqlCommand cmd = new SqlCommand("spShoppingCartGetItems", conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CartID", cartID);

                    using(SqlDataAdapter da =new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvCartItems.DataSource = dt;
                        gvCartItems.DataBind();
                    }
                }
            }
        }
    }
}