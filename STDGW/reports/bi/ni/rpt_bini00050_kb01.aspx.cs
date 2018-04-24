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

public partial class rpt_bini00050_kb01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_bini00050_kb01.xls";
        string TempFile = "../../../system/temp/rpt_bini00050_kb01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
        string     master_pk = Request["master_pk"];
        string     lstOutType = Request["lstOutType"];
        string para = "'" + master_pk +"'";	 
       string para2 = "'" + master_pk + "','"+ lstOutType + "'";		
		DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_bini00050_kb01" , para);		
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_bini00050_kb01_1" , para2);		  
	//	DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_epbp00010_st01_2", "'" + Session["User_ID"].ToString() + "'");	
        // MASTER   

       
		if( dt.Rows.Count >0)
		{
			exSheet.Cells["j6"].Value ="No";//dt.Rows[0]["pr_no"];
			exSheet.Cells["j7"].Value = "No/dr ";//+dt.Rows[0]["req_date"];
			exSheet.Cells["j8"].Value = "Co/cr";//;+dt.Rows[0]["dept_name"];
			exSheet.Cells["e8"].Value =dt.Rows[0]["dd"];
			exSheet.Cells["f8"].Value =dt.Rows[0]["mm"];
			exSheet.Cells["h8"].Value =dt.Rows[0]["yy"];
			exSheet.Cells["e9"].Value =dt.Rows[0]["full_name"];
			exSheet.Cells["e10"].Value =dt.Rows[0]["slip_no"];
			exSheet.Cells["d11"].Value =dt.Rows[0]["out_date"];
			exSheet.Cells["e12"].Value =dt.Rows[0]["wh_nm"];
			
		}
		
		// INSERT ROWS
		 
		//for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count-1; l_addrow++)
		//{
         //  exSheet.Range["A17"].Rows.EntireRow.Insert();//insert row new of sheet
		//}
						
		// SET DATA
		int pos = 15;
		int i   = 0  ;		  			
		
		
					
		 for (i = 0; i < dtDetail.Rows.Count; i++)
         {									
			//exSheet.Range[pos + i, 4,pos + i, 5].Merge();
			exSheet.Cells[pos + i, 2 ].Value = i+1;
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["item_code1"];
			 exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["out_item_name"];
			 exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["out_uom"];
			
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["req_qty"];
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["out_qty"];
			 exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["unit_price"]; 			
			exSheet.Cells[pos + i, 10 ].Value = dtDetail.Rows[i]["item_amount"]; 			
         }
		// exSheet.Cells["i30"].Value =dtDetail.Rows[0]["item_amount"];
		// exSheet.Cells["i31"].Value =dtDetail.Rows[0]["vat_amount"];
		// exSheet.Cells["i32"].Value =dtDetail.Rows[0]["total_amount"];
		//---------
		//exSheet.Cells[pos + i, 7 ].Value = "=sum(g26:g"+(pos+i-1)+")";
		//exSheet.Cells[pos + i, 8 ].Value = "=sum(h26:h"+(pos+i-1)+")";
		//exSheet.Cells[pos + i, 10].Value = "=sum(j26:j"+(pos+i-1)+")";			 					
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