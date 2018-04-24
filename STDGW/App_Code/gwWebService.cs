using System;
using System.IO;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Configuration;
using System.Data.OracleClient;

/// <summary>
/// Summary description for gwWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class gwWebService : System.Web.Services.WebService {

    private string _conString = "Data Source={0};User Id={1};Password={2};Unicode=true";

    public gwWebService()
    {
    }

    [WebMethod(EnableSession = true, MessageName = "Arg")]
    public DataTable GetDataTableArg(string Procedure, string para, string dbName, string dbUser, string dbPwd)
    {
        _conString = string.Format(_conString, dbName, dbUser, dbPwd);
        OracleConnection connection;
        DataTable dt;

        try
        {
            object[] ParaIn = para.Split('|');

            string exeStatement, temp = "";
            dt = new DataTable(Procedure);
            connection = new OracleConnection(_conString);
            connection.Open();
            OracleCommand command = new OracleCommand(Procedure, connection);
            command.CommandType = CommandType.Text;

            for (int i = 0; i < ParaIn.Length; i++)
            {
                temp += "'" + ParaIn[i].ToString().Trim() + "',";
            }
            if (temp.Length >= 3 && ParaIn.Length > 0)
            {
                temp = temp.Substring(0, temp.Length - 1);
                exeStatement = "Call " + Procedure + "(" + temp + ",:p_rtn_value)";
                command.Parameters.Add(":p_rtn_value", OracleType.Cursor).Direction = ParameterDirection.Output;
            }
            else
            {
                //select data for grid without any condition
                exeStatement = "Call " + Procedure + "(:p_rtn_value)";
                command.Parameters.Add(":p_rtn_value", OracleType.Cursor).Direction = ParameterDirection.Output;
            }
            command.CommandText = exeStatement;
            OracleDataReader reader = command.ExecuteReader();
            dt.Load(reader);
            connection.Close();
            connection.Dispose();

            return dt;
        }
        catch (Exception ex)
        {
            dt = new DataTable(Procedure);
            dt.Columns.Add("ERROR");
            dt.Rows.Add(ex.Message);

            return dt;
        }
    }

    [WebMethod(EnableSession = true, MessageName = "NoArg")]
    public DataTable GetDataTableNoArg(string Procedure, string dbName, string dbUser, string dbPwd)
    {
        _conString = string.Format(_conString, dbName, dbUser, dbPwd);
        OracleConnection connection;
        DataTable dt;

        try
        {
            string exeStatement;
            dt = new DataTable(Procedure);
            connection = new OracleConnection(_conString);
            connection.Open();
            OracleCommand command = new OracleCommand(Procedure, connection);
            command.CommandType = CommandType.Text;


            //select data for grid without any condition
            exeStatement = "Call " + Procedure + "(:p_rtn_value)";
            command.Parameters.Add(":p_rtn_value", OracleType.Cursor).Direction = ParameterDirection.Output;

            command.CommandText = exeStatement;
            OracleDataReader reader = command.ExecuteReader();
            dt.Load(reader);
            connection.Close();
            connection.Dispose();

            return dt;
        }
        catch (Exception ex)
        {
            dt = new DataTable();
            dt.Columns.Add("ERROR");
            dt.Rows.Add(ex.Message);

            return dt;
        }
    }

    [WebMethod(EnableSession = true, MessageName = "InsertTable")]
    public string InsertTableArg(string Procedure, string para, string dbName, string dbUser, string dbPwd)
    {
        _conString = string.Format(_conString, dbName, dbUser, dbPwd);
        OracleConnection connection;

        try
        {
            string[] stringSeparators = new string[] { "|!" };
            object[] ParaIn = para.Split(stringSeparators, StringSplitOptions.None);

            string exeStatement = "", temp = "";

            connection = new OracleConnection(_conString);
            connection.Open();
            OracleCommand command = new OracleCommand(Procedure, connection);
            command.CommandType = CommandType.Text;

            for (int i = 0; i < ParaIn.Length; i++)
            {
                temp += "'" + ParaIn[i].ToString().Trim() + "',";
            }

            if (temp.Length >= 3 && ParaIn.Length > 0)
            {
                temp = temp.Substring(0, temp.Length - 1);
                exeStatement = "Call " + Procedure + "(" + temp + ")";
            }

            command.CommandText = exeStatement;
            command.ExecuteNonQuery();
            connection.Close();
            connection.Dispose();
            return "OK";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }
	
	[WebMethod(EnableSession = true, MessageName = "ExecuteProcedureOutPara")]
    public string ExecuteProcedureOutPara(string Procedure, string para, string dbName, string dbUser, string dbPwd)
    {
        _conString = string.Format(_conString, dbName, dbUser, dbPwd);
        OracleConnection connection;

        try
        {
            string[] stringSeparators = new string[] { "|!" };
            object[] ParaIn = para.Split(stringSeparators, StringSplitOptions.None);

            string exeStatement = "", temp = "";

            connection = new OracleConnection(_conString);
            connection.Open();
            OracleCommand command = new OracleCommand(Procedure, connection);
            command.CommandType = CommandType.Text;

            for (int i = 0; i < ParaIn.Length; i++)
            {
                temp += "'" + ParaIn[i].ToString().Trim() + "',";
            }

            if (temp.Length >= 3 && ParaIn.Length > 0)
            {
                temp = temp.Substring(0, temp.Length - 1);
                exeStatement = "Call " + Procedure + "(" + temp + ",:p_rtn_value)";
            }
			command.Parameters.Add(":p_rtn_value", OracleType.VarChar, 1000);
            command.Parameters[":p_rtn_value"].Direction = ParameterDirection.Output;
							
            command.CommandText = exeStatement;
            command.ExecuteNonQuery();
			string s = command.Parameters[":p_rtn_value"].Value.ToString();
            connection.Close();
            connection.Dispose();
            return s;
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }

    [WebMethod(EnableSession = true, MessageName = "UploadFile")]
    public string UploadFile(byte[] f, string fileName)
    {
        // the byte array argument contains the content of the file
        // the string argument contains the name and extension
        // of the file passed in the byte array
        try
        {
            // instance a memory stream and pass the
            // byte array to its constructor
            MemoryStream ms = new MemoryStream(f);

            // instance a filestream pointing to the 
            // storage folder, use the original file name
            // to name the resulting file
            FileStream fs = new FileStream
                (System.Web.Hosting.HostingEnvironment.MapPath("~/TransientStorage/") +
                fileName, FileMode.Create);

            // write the memory stream containing the original
            // file as a byte array to the filestream
            ms.WriteTo(fs);

            // clean up
            ms.Close();
            fs.Close();
            fs.Dispose();

            // return OK if we made it this far
            return "OK";
        }
        catch (Exception ex)
        {
            // return the error message if the operation fails
            return ex.Message.ToString();
        }
    }
}

