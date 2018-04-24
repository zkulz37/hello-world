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
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class rpt_60300010_cancel_noshow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string l_dtfrom = Request["p_dtfrm"];  
		string l_dtto = Request["p_dtto"];
       
        string TemplateFile = "rpt_60300010_cancel_noshow.xls";
        string TempFile = "../../../system/temp/rpt_60300010_cancel_noshow_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string para = "";
        DataTable dt, dtSum;

        para = "'" + l_dtfrom + "','" + l_dtto + "'";
        dt = ESysLib.TableReadOpenCursor("rpt_60300010_cancel_noshow", para);
        //-----header---   

        //---end--header---
        //--set-----DataBind--in---Master---
        if (dt.Rows.Count == 0)
        {
            exSheet.Cells[6, 3].Value = "There is not data!";

        }
        if (dt.Rows.Count > 0)
        {
            exSheet.Cells[3, 1].Value = dt.Rows[0]["date_para"].ToString();
			exSheet.Cells[3,9].Value = dt.Rows[0]["print_time"].ToString();  
			
        }
			
        //----------------------
        ////end-set-----DataBind--in---Master---

        for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A6"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent
		int l_total_room=0,l_total_guest=0;
		int l_first=5;
		if(dt.Rows.Count > 0)
		{
			int l_cnt = dt.Rows.Count;
			for (int l_row = 0; l_row <dt.Rows.Count; l_row++)
			{				
					exSheet.Cells[l_first + l_row, 1].Value = dt.Rows[l_row]["SLIP_NO"].ToString();
				 exSheet.Cells[l_first + l_row, 2].Value = dt.Rows[l_row]["LAST_NAME"].ToString();
					exSheet.Cells[l_first + l_row, 3].Value = dt.Rows[l_row]["company"].ToString();
					exSheet.Cells[l_first + l_row, 4].Value = dt.Rows[l_row]["arrive_date"].ToString();
					exSheet.Cells[l_first + l_row, 5].Value = dt.Rows[l_row]["departure"].ToString();
					//exSheet.Cells[l_first + l_row, 6].Value = dt.Rows[l_row]["departure"].ToString(); total guest
					exSheet.Cells[l_first + l_row, 7].Value = dt.Rows[l_row]["room_type"].ToString();
					exSheet.Cells[l_first + l_row, 8].Value = dt.Rows[l_row]["room_no"].ToString();
					exSheet.Cells[l_first + l_row, 9].Value = dt.Rows[l_row]["status"].ToString();
					exSheet.Cells[l_first + l_row, 10].Value = dt.Rows[l_row]["description"].ToString();
				
			}
		}
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        range = exSheet.Range["A1"];
        // hide row A5 
        range.Rows.Hidden = true;

        // font bold header

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