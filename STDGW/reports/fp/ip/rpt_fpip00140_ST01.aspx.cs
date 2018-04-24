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

public partial class rpt_fpip00140_ST01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());		

        string TemplateFile = "rpt_fpip00140_ST01.xls";
        string TempFile = "../../../system/temp/rpt_fpip00140_ST01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		
		string p_prod_date 		 = Request.QueryString["p_prod_date"];
		string p_work_process_pk = Request.QueryString["p_work_process_pk"];
		 
        string para ;				
		
		para = "'" + p_prod_date + "','" + p_work_process_pk + "'";	
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fpip00140_ST01_1" , para);	
	  	        
		//-------------------------------	
		
		// INSERT ROWS
		 
		/*for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A9"].Rows.EntireRow.Insert();//insert row new of sheet
        }*/
						
		// SET DATA
		int pos = 5 ;
		int i   = 0  ;	

		string l_item_code = "";	
		string l_seq     = "";
		
		double l_total_qty_out = 0;
		double l_total_qty_in  = 0;
		double l_total_qty     = 0;
		
		double l_total_amt = 0;		
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {													
			exSheet.Range[ pos+1, 1 ].Rows.EntireRow.Insert();
			exSheet.Range[ pos+1, 1 ].Rows.EntireRow.Insert();
			exSheet.Range[ pos+1, 1 ].Rows.EntireRow.Insert();
			exSheet.Range[ pos+1, 1 ].Rows.EntireRow.Insert();
				
			exSheet.Cells[pos, 1, pos + 3, 1].Merge();
			exSheet.Cells[pos, 2, pos + 3, 2].Merge();
							
			exSheet.Cells[ pos, 1].Value = dtDetail.Rows[i]["item_code"];
			exSheet.Cells[ pos, 2].Value = dtDetail.Rows[i]["item_name"];								 			 
			
			pos = pos + 4 ;			
        }
		//---------
        		 
		/*exSheet.Cells[pos + i,  4].Value = "=sum(D8:D"+t+")";		
		exSheet.Cells[pos + i,  9].Value = "=sum(I8:I"+t+")";	
		exSheet.Cells[pos + i, 10].Value = "=sum(J8:J"+t+")";*/
		
		//---------
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