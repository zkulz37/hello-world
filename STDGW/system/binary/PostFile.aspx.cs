using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Xml;
using System.IO;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OracleClient;
namespace ESys
{
    public partial class PostFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["User_ID"].ToString() == "")
            {
                Response.Redirect(Application["rooturl"] + "/system/Login.aspx");
            }
        }
        private void SaveToDB()
        {
            //
        }
    }
}
