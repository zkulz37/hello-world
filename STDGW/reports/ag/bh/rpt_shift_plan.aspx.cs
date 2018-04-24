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

public partial class rpt_shift_plan : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser("HR");
        string p_user, p_tco_org_pk, p_wg, p_work_shift, p_search_by, p_search_temp;
        string p_company;


        p_company = Request["p_company"].ToString();

        string SQL
            = "select a.shift " +
                ",a.start_time " +
                ",a.end_time " +
                ",a.wt " +
                ",a.ot " +
                ",a.nt " +
                ",A.MEAL1_INTERVAL " +
                ",A.MEAL2_INTERVAL " +
                ",A.START_OT " +
                ",A.START_NT " +
                ",A.NOTE " +
                "from thr_work_shift a " +
                "where a.del_if=0 and decode('" + p_company + "','All','All',a.tco_company_pk)='" + p_company + "' order by shift ";



        //Response.Write(SQL);
        //Response.End();
        DataTable dt_total = ESysLib.TableReadOpen(SQL);
        int irow, icol;
        irow = dt_total.Rows.Count;
        icol = dt_total.Columns.Count;
        if (irow == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }



        string TemplateFile = "rpt_shift_plan.xls";
        string TempFile = "../../../system/temp/rpt_shift_plan_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        //IRange range;
        int spos = 5;
        int scol = 1;
        //insert new row
        for (int i = 1; i < irow; i++)
        {
            exSheet.Range[spos + i, 1].Rows.EntireRow.Insert();
        }
         for (int i = 0; i < irow; i++)
        {
            for (int j = 0; j < icol; j++)
            {
                if (j >= 3 && j <= 7)
                {
                    exSheet.Cells[spos + i, j + scol].Value = Double.Parse(dt_total.Rows[i][j].ToString());
                }
                else
                {
                    exSheet.Cells[spos + i, j + scol].Value = dt_total.Rows[i][j].ToString();
                }
            }
        }
		
		
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