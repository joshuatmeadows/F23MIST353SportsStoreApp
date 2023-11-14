// Importing necessary namespaces for data access, configuration, web controls, and more
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

// Namespace declaration for the SportsStore application
namespace SportsStore
{
    // Partial class for the default page, inheriting from System.Web.UI.Page
    public partial class _Default : Page
    {
        // Method to retrieve data from the database
        public DataTable GetDataFromDatabase()
        {
            // Creating a DataTable to store the data
            DataTable dt = new DataTable();

            // Retrieving the connection string from the configuration (Web.config file)
            string connString = ConfigurationManager.ConnectionStrings["SportsStoreDB"].ToString();

            // Establishing a connection to the SQL database
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Executing a stored procedure 'spGetAllCategories'
                using (SqlCommand cmd = new SqlCommand("EXEC spGetAllCategories", conn))
                {
                    // Using SqlDataAdapter to fill the DataTable with data returned by the command
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            // Returning the filled DataTable
            return dt;
        }

        // Event handler for the page load event
        protected void Page_Load(object sender, EventArgs e)
        {
            // If the page is being loaded, bind the data from the database to the Categories control
            Categories.DataSource = GetDataFromDatabase();
            Categories.DataBind();
        }
    }
}
