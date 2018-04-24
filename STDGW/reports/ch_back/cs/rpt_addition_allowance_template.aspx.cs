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

public partial class rpt_addition_allowance_template : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string TemplateFile = "rpt_addition_allowance_template.xls";
        string TempFile = "../../../system/temp/rpt_addition_allowance_template_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);


        //Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;
        MemoryStream stream;
        Bitmap b;

        string p_month;
        p_month = Request["p_month"].ToString();


        string SQL
            = " SELECT (A.ALLOW_A1_LB) AS code_fnm1 " +
                "              ,(A.ALLOW_A2_LB) AS code_fnm2       " +
                "              ,(A.ALLOW_A3_LB) AS code_fnm3 " +
                "              ,(A.ALLOW_A4_LB) AS code_fnm4 " +
                "              ,(A.ALLOW_A5_LB) AS code_fnm5 " +
                "              ,(A.ALLOW_A6_LB) AS code_fnm6 " +
                "              ,(A.ALLOW_A7_LB) AS code_fnm7 " +
                "              ,(A.ALLOW_A8_LB) AS code_fnm8 " +
                "              ,(A.ALLOW_A9_LB) AS code_fnm9 " +
                "              ,(A.ALLOW_A10_LB) AS code_fnm10 " +
                "              ,(A.ALLOW_A1_LB_K) AS code_knm1 " +
                "              ,(A.ALLOW_A2_LB_K) AS code_knm2 " +
                "              ,(A.ALLOW_A3_LB_K) AS code_knm3 " +
                "              ,(A.ALLOW_A4_LB_K) AS code_knm4 " +
                "              ,(A.ALLOW_A5_LB_K) AS code_knm5 " +
                "              ,(A.ALLOW_A6_LB_K) AS code_knm6 " +
                "              ,(A.ALLOW_A7_LB_K) AS code_knm7 " +
                "              ,(A.ALLOW_A8_LB_K) AS code_knm8 " +
                "              ,(A.ALLOW_A9_LB_K) AS code_knm9 " +
                "              ,(A.ALLOW_A10_LB_K) AS code_knm10 " +
                "              ,(A.ALLOW_A1_USE) as code_u1 " +
                "              ,(A.ALLOW_A2_USE) as code_u2 " +
                "              ,(A.ALLOW_A3_USE) as code_u3 " +
                "              ,(A.ALLOW_A4_USE) as code_u4 " +
                "              ,(A.ALLOW_A5_USE) as code_u5 " +
                "              ,(A.ALLOW_A6_USE) as code_u6 " +
                "              ,(A.ALLOW_A7_USE) as code_u7 " +
                "              ,(A.ALLOW_A8_USE) as code_u8 " +
                "              ,(A.ALLOW_A9_USE) as code_u9 " +
                "              ,(A.ALLOW_A10_USE) as code_u10               " +
                "        FROM thr_addition_allowance_nm a  " +
                "        WHERE a.del_if=0 " +
                "            and A.WORK_MON='" + p_month + "'";

        DataTable dt_allow = ESysLib.TableReadOpen(SQL);

        int irow = dt_allow.Rows.Count;
        int icol = dt_allow.Columns.Count;
        int i;

        if (irow!=0)
        {
            for (i = 0; i < 10; i++)
            {
                exSheet.Cells[3, i + 4].Value = dt_allow.Rows[0][i].ToString();
            }               
        }

        for (i = 20; i < icol; i++)
        {
            if (int.Parse(dt_allow.Rows[0][i].ToString()) == 0)
            {
                exSheet.Cells[3, i - 16].Interior.Color = System.Drawing.Color.SlateGray;                
            }
        }

        exSheet.Cells[9, 4].Value = icol;

		exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
