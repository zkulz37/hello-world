using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.OracleClient;

public partial class form_comm_eo_wcoeo00003_4 : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        CheckDeptId();
    }
    private void CheckDeptId()
    {
        string strDeptId;
        string iDeptPk;
        strDeptId = Request["DeptId"];
        iDeptPk = Request["DeptPk"];

       
        string conString = ConfigurationManager.AppSettings["strConn"];
        conString += "User Id=comm;Password=comm2";
        string strcmd = "SELECT count(*)  from tco_dept where del_if=0 and dept_id='";
        strcmd += strDeptId + "' and (pk<> '" + iDeptPk + "' or '" + iDeptPk + "' is null)";
        OracleConnection connection = new OracleConnection(conString);
        OracleCommand command = new OracleCommand();
        try
        {
            connection.Open();
            command.CommandText = strcmd;
            command.Connection = connection;
            object iCount;
            iCount = command.ExecuteScalar();
            Response.Clear();
            Response.Write(iCount.ToString());
            
        }
        catch(Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            command.Dispose();
            connection.Close();
        }
    }
}
