// Importing necessary namespaces for data access, configuration, and web controls
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
    // Partial class for the ProductsByCategory page, inheriting from System.Web.UI.Page
    public partial class ProductsByCategory : System.Web.UI.Page
    {
        // Method to retrieve data from the database
        public DataTable GetDataFromDatabase()
        {
            // Create a new DataTable to store the retrieved data
            DataTable dt = new DataTable();

            // Retrieve the database connection string from the Web.config file
            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();
            // Get the category ID from the query string
            string idValue = Request.QueryString["ID"];

            // Proceed only if the category ID is not null or empty
            if (!string.IsNullOrEmpty(idValue))
            {
                // Establish a connection to the database
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    // Use a parameterized query to prevent SQL injection
                    string query = "EXEC spGetProductsinCategory @IDValue";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add the category ID as a parameter
                        cmd.Parameters.AddWithValue("@IDValue", idValue);

                        // Execute the query
                        cmd.ExecuteNonQuery();

                        // Use SqlDataAdapter to fill the DataTable with the result set
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }

            // Return the filled DataTable
            return dt;
        }

        // Event handler for the page load event
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the request is the first-time page load, not a postback
            if (!IsPostBack)
            {
                // Retrieve the category ID from the query string
                string IDValue = Request.QueryString["ID"];
                // Redirect to the default page if the category ID is not provided
                if (string.IsNullOrEmpty(IDValue))
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    // Bind the data from the database to the Products control
                    Products.DataSource = GetDataFromDatabase();
                    Products.DataBind();
                }
            }
        }
    }
}
