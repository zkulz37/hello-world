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

public partial class gfgf00040_getAccountInfo : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
    {
        LoadComBoData();
    }
    private void LoadComBoData()
    {
        string scode;
        scode = Request["id"];
        string sCmp_pk = Request["Company_pk"];
        string sCmdCode = Request["group_code"];
        string sreturn = "DATA|ALL|Select All";
        string conString = ConfigurationManager.AppSettings["strConn"];
        conString += "User Id=ACNT;Password=ACNT2";

        string strcmd = "SELECT a.pk, a.ac_cd||'--'|| a.ac_nm " +
             " FROM tac_abacctcode a, tco_abcode b, tco_abcodegrp c " +
             " WHERE a.del_if = 0 " +
              " AND b.del_if = 0" +
              " AND c.del_if = 0 " +
              " AND a.use_yn = 'Y' " +
              " AND a.leaf_yn = 'Y' " +
              " AND b.code = a.ac_cd " +
              " AND b.tco_abcodegrp_pk = c.pk" +
             "  AND c.ID = '" + scode + "' " +
             "  AND a.tco_company_pk = " + sCmp_pk +
             "  AND nvl(b.grp_code,'ALL') like DECODE('" + sCmdCode + "','ALL','%','" + sCmdCode + "','" + sCmdCode + "')" +
            " ORDER BY a.ac_cd ";

        OracleConnection connection = new OracleConnection(conString);
        OracleCommand command = new OracleCommand();
        //Response.Write(strcmd);
        //OracleDataReader reader = new OracleDataReader();

        try
        {
            connection.Open();
            command.CommandText = strcmd;
            command.Connection = connection;
            OracleDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                sreturn +="|" +reader.GetOracleValue(0) + "|" + reader.GetOracleValue(1)  ;
            }
            //sreturn += " |";
            Response.Write(sreturn);
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
