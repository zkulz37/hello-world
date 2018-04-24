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

public partial class rpt_epbp00270_DURING : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		
        string p_from_date = Request["p_from_date"];
       
        string TemplateFile = "rpt_epbp00270_DURING.xls";
        string TempFile = "../../../system/temp/rpt_epbp00270_DURING" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
  
		DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00270_during", "'" + p_from_date + "'");
         		
        // end title
        int pos = 3;
				 
		int l_row = 0 ;
		
		Double total_req_qty 	   = 0 ;
		Double total_pr_stock_qty  = 0 ;
		
		for ( l_row = 0; l_row < dt2.Rows.Count-1; l_row++ )
		{
			exSheet.Range[ l_row+pos+1, 1, l_row+pos+1, 8].Rows.EntireRow.Insert();
		}			
		
        for (l_row = 0; l_row < dt2.Rows.Count; l_row++)
        {					 								
            exSheet.Cells[l_row+pos, 1].Value = l_row + 1 ;	
			exSheet.Cells[l_row+pos, 2].Value = dt2.Rows[l_row]["item_code"];
			exSheet.Cells[l_row+pos, 3].Value = dt2.Rows[l_row]["item_name"];			
			exSheet.Cells[l_row+pos, 4].Value = dt2.Rows[l_row]["uom"];	
			exSheet.Cells[l_row+pos, 5].Value = dt2.Rows[l_row]["jan_req_qty"];	
			exSheet.Cells[l_row+pos, 6].Value = dt2.Rows[l_row]["feb_req_qty"];
			exSheet.Cells[l_row+pos, 7].Value = dt2.Rows[l_row]["mar_req_qty"];
			exSheet.Cells[l_row+pos, 8].Value = dt2.Rows[l_row]["apr_req_qty"];
			exSheet.Cells[l_row+pos, 9].Value = dt2.Rows[l_row]["may_req_qty"];
			exSheet.Cells[l_row+pos,10].Value = dt2.Rows[l_row]["jun_req_qty"];
			exSheet.Cells[l_row+pos,11].Value = dt2.Rows[l_row]["jul_req_qty"];
			exSheet.Cells[l_row+pos,12].Value = dt2.Rows[l_row]["agu_req_qty"];
			exSheet.Cells[l_row+pos,13].Value = dt2.Rows[l_row]["sep_req_qty"];
			exSheet.Cells[l_row+pos,14].Value = dt2.Rows[l_row]["oct_req_qty"];
			exSheet.Cells[l_row+pos,15].Value = dt2.Rows[l_row]["nov_req_qty"];
			exSheet.Cells[l_row+pos,16].Value = dt2.Rows[l_row]["dec_req_qty"];
			exSheet.Cells[l_row+pos,17].Value = dt2.Rows[l_row]["all_req_qty"];
			exSheet.Cells[l_row+pos,18].Value = dt2.Rows[l_row]["avg_qty"];	
			exSheet.Cells[l_row+pos,19].Value = dt2.Rows[l_row]["this_month_req_qty"];	
			exSheet.Cells[l_row+pos,20].Value = dt2.Rows[l_row]["stock_qty"];
			exSheet.Cells[l_row+pos,21].Value = dt2.Rows[l_row]["bal_qty"];			
			exSheet.Cells[l_row+pos,22].Value = dt2.Rows[l_row]["po_qty"];	
			
			exSheet.Cells[2,20].Value = dt2.Rows[0]["sys_date"];
        }   

       	exSheet.Cells[l_row+pos, 5].Value = "=SUM(E3:E" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos, 6].Value = "=SUM(F3:F" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos, 7].Value = "=SUM(G3:G" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos, 8].Value = "=SUM(H3:H" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos, 9].Value = "=SUM(I3:I" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,10].Value = "=SUM(J3:J" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,11].Value = "=SUM(K3:K" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,12].Value = "=SUM(L3:L" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,13].Value = "=SUM(M3:M" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,14].Value = "=SUM(N3:N" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,15].Value = "=SUM(O3:O" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,16].Value = "=SUM(P3:P" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,17].Value = "=SUM(Q3:Q" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,19].Value = "=SUM(S3:S" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,20].Value = "=SUM(T3:T" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,21].Value = "=SUM(U3:U" + (l_row+pos-1) + ")";
		exSheet.Cells[l_row+pos,22].Value = "=SUM(V3:V" + (l_row+pos-1) + ")";
				
        // loop detail not percent

        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

        // hide row firts 
        range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;
        range.Value = string.Empty;
        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

        exBook.SaveAs(TempFile);
        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Send file string to client 
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
