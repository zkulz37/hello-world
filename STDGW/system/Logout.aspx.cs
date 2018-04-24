using System;
using System.Web;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Configuration;
using System.Data.OracleClient;
namespace ESys
{

    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            try
            {
                string connString = ConfigurationManager.AppSettings["strConn"];
                connString += "User Id=gasp;Password=";
                OracleConnection connection = new OracleConnection(connString);
                connection.Open();
                OracleCommand command = connection.CreateCommand();
                string login_user = Session["User_ID"].ToString();
                command.CommandText = "call gasp.sp_upd_user_logout('" + login_user + "')";
                command.ExecuteNonQuery();
                command.Dispose();
                connection.Close();
            }
            catch(Exception ex) 
            {
                ESysLib.WriteLogError(ex.Message);
            }
             */
            Session.Clear();
            Session.Abandon();
            Response.Redirect("../Login.aspx");
        }
    }
}