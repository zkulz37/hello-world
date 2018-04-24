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

public partial class rpt_fe0400110 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fe0400110.xls";
        string TempFile = "../../../system/temp/rpt_fe0400110_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

    
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
        string      lstWHType = Request.QueryString["lstWHType"];
        string      lstWarehouse = Request.QueryString["lstWarehouse"];
        string      dtFrom = Request.QueryString["dtFrom"];
         
        string para = "'" + lstWHType + "','" + lstWarehouse + "','" + dtFrom + "'";		
				
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_sel_fe0400110" , para);		  
	
		 
		for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A5"].Rows.EntireRow.Insert();//insert row new of sheet
        }
						
		// SET DATA
		int pos = 4 ;
		int i   = 0  ;		  			
		
		
					
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
          
			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["wh_name"]; 			
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["mtd_qty"]; 			
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["yesterday_qty"]; 			
			exSheet.Cells[pos + i, 5].Value = dtDetail.Rows[i]["today_qty"]; 			
			exSheet.Cells[pos + i, 6].Value = dtDetail.Rows[i]["gap_qty"]; 			
			exSheet.Cells[pos + i, 7].Value = dtDetail.Rows[i]["rate_qty"]; 	
			
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["mtd_amt"]; 			
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["yesterday_amt"]; 			
			exSheet.Cells[pos + i, 10].Value = dtDetail.Rows[i]["today_amt"]; 			
			exSheet.Cells[pos + i, 11].Value = dtDetail.Rows[i]["gap_amt"]; 			
			exSheet.Cells[pos + i, 12].Value = dtDetail.Rows[i]["rate_amt"]; 
			
			exSheet.Cells[pos + i, 13 ].Value = dtDetail.Rows[i]["mtd_mat_amt"]; 			
			exSheet.Cells[pos + i, 14 ].Value = dtDetail.Rows[i]["yesterday_mat_amt"]; 			
			exSheet.Cells[pos + i, 15].Value = dtDetail.Rows[i]["today_mat_amt"]; 			
			exSheet.Cells[pos + i, 16].Value = dtDetail.Rows[i]["gap_mat_amt"]; 			
			exSheet.Cells[pos + i, 17].Value = dtDetail.Rows[i]["rate_mat_amt"]; 
			
			exSheet.Cells[pos + i, 18].Value = dtDetail.Rows[i]["mtd_mat_rev_rate"];
			exSheet.Cells[pos + i, 19].Value = dtDetail.Rows[i]["yesterday_mat_rev_rate"]; 
			exSheet.Cells[pos + i, 20].Value = dtDetail.Rows[i]["today_mat_rev_rate"]; 
			exSheet.Cells[pos + i, 21].Value = dtDetail.Rows[i]["gap_mat_rev"]; 
			exSheet.Cells[pos + i, 22].Value = dtDetail.Rows[i]["rate_mat_rev"]; 
			 
        }
		//---------
		exSheet.Cells[pos + i, 3 ].Value = "=sum(c4:c"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 4 ].Value = "=sum(d4:d"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 5 ].Value = "=sum(e4:e"+(pos+i-1)+")";
		
		exSheet.Cells[pos + i, 8].Value = "=sum(h4:h"+(pos+i-1)+")";			 					
		exSheet.Cells[pos + i, 9].Value = "=sum(i4:i"+(pos+i-1)+")";			 					
		exSheet.Cells[pos + i, 10].Value = "=sum(j4:j"+(pos+i-1)+")";
		
		exSheet.Cells[pos + i, 13].Value = "=sum(m4:m"+(pos+i-1)+")";			 					
	    exSheet.Cells[pos + i, 14].Value = "=sum(n4:n"+(pos+i-1)+")";			 					
		exSheet.Cells[pos + i, 15].Value = "=sum(o4:o"+(pos+i-1)+")";			 					
		
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

    public Bitmap ResizeImage(Bitmap d, int w, int h)
    {
        Bitmap q = new Bitmap(w, h);
        float f, g;
        f = (float)w / (float)d.Width;
        g = (float)h / (float)d.Height;
        for (int i = 0; i < w; i++)
        {
            for (int j = 0; j < h; j++)
            {
                Color c;
                c = d.GetPixel((int)(i / f), (int)(j / g));
                q.SetPixel(i, j, c);
            }
        }
        return q;
    }
}