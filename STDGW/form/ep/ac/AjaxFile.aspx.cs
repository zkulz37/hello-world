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

public partial class form_ep_ac_AjaxFile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string type;
        type= Request.QueryString["type"];
       
        switch (type)
        {
            case "" :
                GetNation();
            break ;
            case "1":
                GetCurrBooking();
            break;
        }
    }

    private void GetNation()
    {

        string pk;
        pk = Request["com_pk"];
       
        string conString = ConfigurationManager.AppSettings["strConn"];
        conString += "User Id=comm;Password=comm2";

        string strcmd = "SELECT v.nation, s.code_nm " ;
        strcmd = strcmd + " FROM tco_company v " ;
        strcmd = strcmd + " ,(SELECT a.code, a.code_nm" ;
        strcmd = strcmd + "   FROM tco_abcode a, tco_abcodegrp b ";
        strcmd = strcmd + "  WHERE tco_abcodegrp_pk = b.pk " ;
        strcmd = strcmd + "    AND b.ID = 'COAB0080' ";
        strcmd = strcmd + "    AND a.del_if = 0 ";
        strcmd = strcmd + "    AND b.del_if = 0) s ";
        strcmd = strcmd + " WHERE v.del_if = 0 AND v.nation = s.code and v.pk ='" + pk + "'" ;

        OracleConnection connection = new OracleConnection(conString);
        OracleCommand command = new OracleCommand();

      try
        {
            connection.Open();
            command.CommandText = strcmd;
            command.Connection = connection;
            OracleDataReader reader = command.ExecuteReader();

            while (reader.Read())
            {
                Response.Write(reader.GetOracleValue(0) + "&" + reader.GetOracleValue(1));
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            command.Dispose();
            connection.Close();
        }
    }

    private void GetCurrBooking()
    {
        string pk;
        
        string conString = ConfigurationManager.AppSettings["strConn"];
        conString += "User Id=comm;Password=comm2";

        string  strcmd = "SELECT a.code, a.code_nm";
        strcmd = strcmd + "   FROM tco_abcode a, tco_abcodegrp b ";
        strcmd = strcmd + "  WHERE tco_abcodegrp_pk = b.pk ";
        strcmd = strcmd + "    AND b.ID = 'ACAB0110' ";
        strcmd = strcmd + "    AND a.del_if = 0 ";
        strcmd = strcmd + "    AND b.del_if = 0";
        strcmd = strcmd + "    and a.DEF_YN='Y'";

        OracleConnection connection = new OracleConnection(conString);
        OracleCommand command = new OracleCommand();

        try
        {
            connection.Open();
            command.CommandText = strcmd;
            command.Connection = connection;
            OracleDataReader reader = command.ExecuteReader();
            string strCurr = "";

            while (reader.Read())
            {
                 strCurr=(string) reader.GetOracleValue(0).ToString();
            }
            Response.Write(strCurr);
        }
        catch (Exception ex)
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
