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

public partial class wcoeo00003_2 : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        int iCompanyId = 0;
        if (Request["companyId"] != null)
        {
            int.TryParse(Request["companyId"], out iCompanyId);
        }

        if (iCompanyId > 0)
        {
            GetLocation(iCompanyId);
        }

    }
    private void GetLocation(int companyId)
    {

        string conString = ConfigurationManager.AppSettings["strConn"];
        conString += "User Id=comm;Password=comm2";
        OracleConnection connection = new OracleConnection(conString);
        OracleCommand command = new OracleCommand();
        try
        {
            connection.Open();
            command.CommandText = "SELECT PK, LOC_NM  FROM comm.TCO_EOBIZPLACE where TCO_EOCOMPANY_PK = '" + companyId + "' ";
            command.Connection = connection;

            OracleDataReader reader = command.ExecuteReader();

            string temp = "";
            //row

            while (reader.Read())
            {

                for (int i = 0; i < reader.FieldCount; i++)
                {
                    if (reader.IsDBNull(i))
                    {
                        temp += "|!";
                    }
                    else
                    {
                        temp += reader.GetOracleValue(i) + "|!";
                    }
                }
                temp = temp.Substring(0, temp.Length - 2);
            }

            reader.Close();
            Response.Clear();
            Response.ContentType = "text/xml";

            Response.Write(temp.ToString());

        }
        catch (Exception ex)
        {


        }
        finally
        {
            command.Dispose();
            connection.Close();
        }
    }
}
