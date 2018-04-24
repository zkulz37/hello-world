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
using System.Text.RegularExpressions;

public partial class rpt_schedule_detail_sample : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser("HR");
        string p_from, p_to;
       
       
        p_from = Request["p_from"].ToString();
        p_to = Request["p_to"].ToString();
        DateTime dt_from = new DateTime(int.Parse(p_from.Substring(0, 4).ToString()), int.Parse(p_from.Substring(4, 2).ToString()), int.Parse(p_from.Substring(6, 2).ToString()));
        DateTime dt_to = new DateTime(int.Parse(p_to.Substring(0, 4).ToString()), int.Parse(p_to.Substring(4, 2).ToString()), int.Parse(p_to.Substring(6, 2).ToString()));
      

        string TemplateFile = "rpt_schedule_detail_sample.xls";
        string TempFile = "../../../system/temp/rpt_schedule_detail_sample_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        //IRange range;
        int scol = 3;
        DateTime dt_tmp =dt_from;
        int i = 0;
        exSheet.Cells[1, scol].Value = dt_tmp.Day;
        do
        {

            exSheet.Range[1, scol+i+1].Columns.EntireColumn.Insert();
            i++;
            dt_tmp = dt_tmp.AddDays(1);
            exSheet.Cells[1, scol + i].Value = dt_tmp.Day;
        }
        while (dt_tmp.Year + "" + dt_tmp.Month + "" + dt_tmp.Day != dt_to.Year + "" + dt_to.Month + "" + dt_to.Day);
        
		
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