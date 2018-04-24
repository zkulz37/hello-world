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

public partial class rpt_60300010_house_use : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

       ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string l_dt_from = Request["p_dtfrm"];   
        string l_dt_to = Request["p_dtto"];
        string TemplateFile = "rpt_60300010_house_use.xls";
        string TempFile = "../../../system/temp/rpt_60300010_house_use_" + Session["User_ID"].ToString() + ".xls";
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

        para = "'" + l_dt_from + "','" + l_dt_to + "'";
        dt = ESysLib.TableReadOpenCursor("rpt_60300010_house_use", para);
        //-----header---   

        //---end--header---
        //--set-----DataBind--in---Master---
        if (dt.Rows.Count == 0)
        {
            exSheet.Cells[6, 1].Value = "There is not data!";

        }
        if (dt.Rows.Count > 0)
        {
			exSheet.Cells[3, 1].Value = dt.Rows[0]["date_para"].ToString();
            exSheet.Cells[3, 6].Value = dt.Rows[0]["print_time"].ToString();
			//exSheet.Cells[4, 11].Value = dt.Rows[0]["date_header"].ToString(); 
        }

        //----------------------
        ////end-set-----DataBind--in---Master---
		
        for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent
        int l_cnt = dt.Rows.Count;
		int l_first=5;
		if (dt.Rows.Count > 0)
		{
			for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
			{
				for (int col = 0; col <= 5; col++)
				{
					exSheet.Cells[l_first + l_row, 1].Value = dt.Rows[l_row]["last_name"].ToString();
					exSheet.Cells[l_first + l_row, 2].Value = dt.Rows[l_row]["total_guest"].ToString();
					exSheet.Cells[l_first + l_row, 3].Value = dt.Rows[l_row]["room_type"].ToString();
					if(dt.Rows[l_row]["room_no"].ToString()!="")
					{
						exSheet.Cells[l_first + l_row, 4].Value = double.Parse(dt.Rows[l_row]["room_no"].ToString());
					}
					exSheet.Cells[l_first + l_row, 5].Value = dt.Rows[l_row]["checkin_date"].ToString();
					exSheet.Cells[l_first + l_row, 6].Value = dt.Rows[l_row]["departure_date"].ToString();
					exSheet.Cells[l_first + l_row, 7].Value = dt.Rows[l_row]["company_name"].ToString();
				}
			}
		}
        // end loop detail percent
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