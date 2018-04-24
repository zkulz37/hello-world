using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class rpt_02_KK_TNCN : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_02_KK_TNCN.xls";
        string TempFile = "../../../system/temp/rpt_02_KK_TNCN_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        string p_month_from;

        p_month_from = Request["p_month_from"].ToString();
        
        int loop_row = 41;
        int r_emp = 0;

        string tax_code = string.Empty;
        string SQL_COM = "select c.partner_name c01 , c.tax_code c02 , c.addr2 c03 , c.phone_no c04 from tco_company c where c.del_if = 0";
        DataTable myDTCOM = ESysLib.TableReadOpen(SQL_COM);

        string SQL
    = "select sum(c21) c21 , sum(c22)  c22, sum(c23)  c23, sum(c24) c24, sum(c25)  c25 " +
        "        , sum(c26) c26, sum(c27)  c27, sum(c28) c28, sum(c29)  c29, sum(c30) c30 " +
        "        , sum(c31)  c31, sum(c32) c32, sum(c33) c33 , sum(c34) c34, sum(c35)  c35 " +
        "from " +
        "(select count(*) c21 " +
        "        , count(*) c22  " +
        "        , 0 c23 " +
        "        , sum(nvl(A.TNCT1 ,0)+nvl(A.TNCT3 ,0)) c24 " +
        "        , sum(nvl(A.TNCT1,0)) c25 " +
        "        , sum(nvl(A.TNCT3,0)) c26 " +
        "        , 0 c27 " +
        "        , sum( nvl(A.TNCT2,0)+nvl(A.TNCT4,0)) c28 " +
        "        , sum(nvl(A.TNCT2,0)) c29 " +
        "        , sum(nvl(A.TNCT4,0)) c30 " +
        "        , 0 c31 " +
        "        , sum(nvl(A.PIT1,0)+nvl(A.PIT2,0)) c32 " +
        "        , sum(nvl(A.PIT1,0)) c33 " +
        "        , sum(nvl(A.PIT2,0)) c34 " +
        "        , 0 c35 " +
        "from THR_FOR_SAL_POSCO_SS a " +
        "where A.DEL_IF=0 " +
        "and A.WORK_MON='" + p_month_from + "' " +
        //"and nvl(A.TOTAL_PIT,0) > 0 " +
        "union all " +
        "select count(*) c21 " +
        "        , count(*) c22 " +
        "        , 0 c23 " +
        "        , sum(nvl(S.INCOME_AMT_2,0)) c24 " +
        "        , sum(decode(nvl(S.SALARY_TAX_KIND,'01'),'01', nvl(S.INCOME_AMT_2,0),0)) c25 " +
        "        , sum(decode(nvl(S.SALARY_TAX_KIND,'01'),'01',0, nvl(S.INCOME_AMT_2,0))) c26 " +
        "        , 0 c27 " +
        "        , sum( case when nvl(S.INCOME_TAX,0) > 0 then nvl(S.INCOME_AMT_2,0) else 0 end ) c28 " +
        "        , sum( case when nvl(S.INCOME_TAX,0) > 0 then decode(nvl(S.SALARY_TAX_KIND,'01'),'01', nvl(S.INCOME_AMT_2,0),0) else 0 end ) c29 " +
        "        , sum( case when nvl(S.INCOME_TAX,0) > 0 then decode(nvl(S.SALARY_TAX_KIND,'01'),'01',0, nvl(S.INCOME_AMT_2,0)) else 0 end ) c30 " +
        "        , 0 c31 " +
        "        , sum(nvl(S.INCOME_TAX,0)) c32 " +
        "        , sum(decode(nvl(S.SALARY_TAX_KIND,'01'),'01', nvl(S.INCOME_TAX,0),0)) c33 " +
        "        , sum(decode(nvl(S.SALARY_TAX_KIND,'01'),'01',0, nvl(S.INCOME_TAX,0))) c34 " +
        "        , 0 c35 " +
        "from thr_month_salary s " +
        "where S.DEL_IF=0 " +
        "and S.WORK_MON='" + p_month_from + "' " +
        //"and nvl(S.INCOME_TAX,0) > 0 " +
        ") sub ";


        //Response.Write(SQL);
        //Response.End();
        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("THere is no data");
            Response.End();
        }
        int _i = 40;

        exSheet.Range["K3"].Value = " Kỳ tính thuế: Tháng " + p_month_from.Substring(4, 2) + " năm " + p_month_from.Substring(0,4);
        exSheet.Range["I5"].Value = myDTCOM.Rows[0]["c02"].ToString();
        exSheet.Range["I6"].Value = myDTCOM.Rows[0]["c01"].ToString();
        
        
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c21"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c22"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c23"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c24"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c25"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c26"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c27"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c28"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c29"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c30"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c31"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c32"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c33"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c34"].ToString());
        exSheet.Range["U" + (_i++)].Value = double.Parse(dt_emp.Rows[0]["c35"].ToString());

        

        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;

        exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        //string pdfFilePath = TempFile.Replace(".xls", ".pdf");

        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        //System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Response.ContentType = "application/pdf";
        //Send file string to client 
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();
    }
}