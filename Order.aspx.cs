using Microsoft.AspNet.Identity;
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
    public partial class Order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            showPayment();
        }
        private void ProcessOrder()
        {
            string cartID = Session["CartID"].ToString();
            string userId = HttpContext.Current.User.Identity.GetUserId();

            if(cartID != null && userId != null)
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
                        
                        if (cmd.Parameters["@OrderID"].Value != DBNull.Value)
                        {
                            PaySuccess.Visible = true;
                            OrderNumber.Text = cmd.Parameters["@OrderID"].Value.ToString();
                        }
                    }
                }
            }
        }
        public void Pay_Click(object sender, EventArgs e)
        {
            string ccNumber = CCNum.Text;
            // check if the credit card number is valid
            if(ccNumber.Length == 16)
            {
                ProcessOrder();

                Session["CartID"] = null;

                ShipPayPanel.Visible = false;
            }
        }
        protected void showPayment()
        {
            if (User.Identity.IsAuthenticated)
            {
                if (Session["CartID"] != null)
                {
                    string cartID = Session["CartID"].ToString();
                    string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
                    using(SqlConnection conn = new SqlConnection(connString))
                    {
                        conn.Open();
                        using(SqlCommand cmd= new SqlCommand("exec spShoppingCartGetItems @CartID", conn))
                        {

                            cmd.Parameters.AddWithValue("@CartID", cartID);
                            using(SqlDataAdapter da = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);
                                if (dt.Rows.Count > 0)
                                {
                                    ShipPayPanel.Visible = true;
                                }
                                else {
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
    }
}