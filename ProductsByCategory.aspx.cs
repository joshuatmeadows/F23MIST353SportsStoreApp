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
    public partial class ProductsByCategory : System.Web.UI.Page
    {
        public DataTable GetDataFromDatabase()
        {
            DataTable dt = new DataTable();

            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
            string idValue = Request.QueryString["ID"];

            if (!string.IsNullOrEmpty(idValue))
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    // Use a parameterized query to prevent SQL injection
                    string query = "EXEC spGetProductsinCategory @IDValue";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@IDValue", idValue);
                        cmd.ExecuteNonQuery();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }    

            return dt;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string IDValue = Request.QueryString["ID"];
                if (string.IsNullOrEmpty(IDValue))
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    Products.DataSource = GetDataFromDatabase();
                    Products.DataBind();
                }
            }
        }
    }
}