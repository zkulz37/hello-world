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

public partial class rpt_imp_month_sal_sample : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string TemplateFile = "rpt_imp_month_sal_sample.xls";
        string TempFile = "../../../system/temp/rpt_imp_month_sal_sample_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;

        DataTable myDT = new DataTable();

#region query

        string SQL
    = "SELECT MAX (code1), MAX (code2), MAX (code3), MAX (code4), MAX (code5), " +
        "             MAX (code6), MAX (code7), MAX (code8), MAX (c1), MAX (c2), " +
        "             MAX (c3), MAX (c4), MAX (c5), MAX (c6), MAX (c7), MAX (c8) " +
        "        FROM (SELECT DECODE (code, 'A1', a.code_nm, '') AS code1, " +
        "                     DECODE (code, 'A2', a.code_nm, '') AS code2, " +
        "                     DECODE (code, 'A3', a.code_nm, '') AS code3, " +
        "                     DECODE (code, 'A4', a.code_nm, '') AS code4, " +
        "                     DECODE (code, 'A5', a.code_nm, '') AS code5, " +
        "                     DECODE (code, 'A6', a.code_nm, '') AS code6, " +
        "                     DECODE (code, 'A7', a.code_nm, '') AS code7, " +
        "                     DECODE (code, 'A8', a.code_nm, '') AS code8, " +
        "                     DECODE (code, 'A1', a.num_2, '') AS c1, " +
        "                     DECODE (code, 'A2', a.num_2, '') AS c2, " +
        "                     DECODE (code, 'A3', a.num_2, '') AS c3, " +
        "                     DECODE (code, 'A4', a.num_2, '') AS c4, " +
        "                     DECODE (code, 'A5', a.num_2, '') AS c5, " +
        "                     DECODE (code, 'A6', a.num_2, '') AS c6, " +
        "                     DECODE (code, 'A7', a.num_2, '') AS c7, " +
        "                     DECODE (code, 'A8', a.num_2, '') AS c8 " +
        "                FROM vhr_hr_code a " +
        "               WHERE a.ID = 'HR0019') allow_amt ";

        myDT = ESysLib.TableReadOpen(SQL);

 # endregion

        int t = 0;

        for (int i = 8; i < myDT.Columns.Count; i++)
        {
            if (myDT.Rows[0][i].ToString() == "1") //co dung
            {
                exSheet.Cells[2, 6+i-8].Value = myDT.Rows[0][i-8].ToString() + "-L1";
                exSheet.Cells[2, 6 + i - 8].Rows.Font.Bold = true;
                exSheet.Cells[2, 6 + i - 8].Borders.LineStyle = XlLineStyle.xlContinuous;
                exSheet.Cells[2, 6 + i - 8].ColumnWidth = 15;
               
                t += 1;
            }
        }
        for (int i = 8; i < myDT.Columns.Count; i++)
        {
            if (myDT.Rows[0][i].ToString() == "1") //co dung
            {
                exSheet.Cells[2, 6 + i - 8+t].Value = myDT.Rows[0][i - 8].ToString() + "-L2";
                exSheet.Cells[2, 6 + i - 8 + t].Rows.Font.Bold = true;
                exSheet.Cells[2, 6 + i - 8 + t].Borders.LineStyle = XlLineStyle.xlContinuous;
                exSheet.Cells[2, 6 + i - 8 + t].ColumnWidth = 15;
                
            }
        }
        exSheet.Cells[2, 6 +t*2].Value = "Salary Note";
        exSheet.Cells[2, 6 + t * 2].Borders.LineStyle = XlLineStyle.xlContinuous;
        exSheet.Cells[2, 6 + t * 2].Rows.Font.Bold = true;
        exSheet.Cells[2, 6 + t * 2].ColumnWidth = 20;

  /*      int t = 0;
        for (int i = 8; i < myDT.Columns.Count; i++)
        {
            if (myDT.Rows[0][i].ToString() != "1")//ko dung
            {
                
                exSheet.UsedRange.Columns[i +6 - t].Delete();
                t += 1;
                //exSheet.Cells[2, i + 6].Value = i - 2 - t;
                //exSheet.Cells[2, i + 14].Value = i + 6 - t;
                
            }
            
        }

        t = 0;
        for (int i = 8; i < myDT.Columns.Count; i++)
        {
            if (myDT.Rows[0][i].ToString() != "1")//ko dung
            {
                exSheet.UsedRange.Columns[i - 2 - t].Delete();
                t += 1;
                //exSheet.Cells[2, i + 6].Value = i - 2 - t;
                //exSheet.Cells[2, i + 14].Value = i + 6 - t;

            }

        }*/

	
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
