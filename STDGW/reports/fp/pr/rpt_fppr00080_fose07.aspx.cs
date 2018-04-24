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

public partial class rpt_fppr00080_fose07 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_fppr00080_fose07.xls";
        string TempFile = "../../../system/temp/rpt_fppr00080_fose07_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
        string 	p_from_dt = Request.QueryString["p_from_dt"];
      
       
         
        string para = "'" + p_from_dt + "'";	
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_fose07" , para);
		if(dtDetail.Rows.Count>0)
		{
		
		}
		
		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A5"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		  int pos =4 ;
		int i   = 0  ;	
		for (i = 0; i < dtDetail.Rows.Count; i++)
       {								
			exSheet.Cells[pos + i, 1 ].Value = i+1;

			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["item_name"];	
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["qty_last_month"];
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["amount_last_month"];	
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["avg_price_last_month"];	
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["qty_this_month"];	
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["amount_this_month"];	
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["avg_price_this_month"];	
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["qty_balance"];	
			exSheet.Cells[pos + i, 10 ].Value = dtDetail.Rows[i]["qty_balance_per"];	
			exSheet.Cells[pos + i, 11].Value = dtDetail.Rows[i]["amt_balance"];	
			exSheet.Cells[pos + i, 12].Value = dtDetail.Rows[i]["amt_balance_per"];	
			exSheet.Cells[pos + i, 13].Value = dtDetail.Rows[i]["avg_balance"];	
			exSheet.Cells[pos + i, 14].Value = dtDetail.Rows[i]["avg_per"];	
		
        }
		
		
		exSheet.Cells[pos+i, 3].Value = "=sum(c4:c"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 4].Value = "=sum(d4:c"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 5].Value = "=sum(e4:e"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 6].Value = "=sum(f4:f"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 7].Value = "=sum(g4:g"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 8].Value = "=sum(h4:h"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 9].Value = "=sum(i4:i"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 10].Value = "=sum(j4:j"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 11].Value = "=sum(k4:k"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 12].Value = "=sum(l4:l"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 13].Value = "=sum(m4:m"+(pos+i-1)+")";
		exSheet.Cells[pos+i, 14].Value = "=sum(n4:n"+(pos+i-1)+")";
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        // hide row firts 
        range = exSheet.Range["A1"];
        // hide row A5 
        // range.Rows.Hidden = true;
        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

        exBook.SaveAs(TempFile);
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
        //Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }

   
}