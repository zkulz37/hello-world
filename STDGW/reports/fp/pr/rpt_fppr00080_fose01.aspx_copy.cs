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

public partial class rpt_fppr00080_fose01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fppr00080_fose01.xls";
        string TempFile = "../../../system/temp/rpt_fppr00080_fose01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 string     p_wh = Request["p_wh"];
        string     p_month = Request["p_month"];
		
         
        string para = "'" + p_wh + "','" + p_month + "'";		
			
		DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080", para);	
		exSheet.Cells["i6"].Value =	p_wh;	
		exSheet.Cells["j6"].Value =	p_month;	
	
		if( dt.Rows.Count >0)
		{
			 exSheet.Cells["g6"].Value = dt.Rows.Count;
		} else 
			exSheet.Cells["g6"].Value = "Null value";
		//if( dt.Rows.Count >0)
		//{
			// exSheet.Cells["h6"].Value =dt.Rows[0]["slip_no"];
			// //exSheet.Cells["h7"].Value = "No/dr ";//+dt.Rows[0]["req_date"];
			// //exSheet.Cells["h8"].Value = "Co/cr";//;+dt.Rows[0]["dept_name"];
			// exSheet.Cells["e8"].Value =dt.Rows[0]["dd"];
			// exSheet.Cells["f8"].Value =dt.Rows[0]["mm"];
			// exSheet.Cells["h8"].Value =dt.Rows[0]["yy"];
			// exSheet.Cells["e9"].Value =dt.Rows[0]["partner_name"];
			// exSheet.Cells["e10"].Value =dt.Rows[0]["ref_no"];
			// exSheet.Cells["d11"].Value =dt.Rows[0]["in_date"];
			// exSheet.Cells["e12"].Value =dt.Rows[0]["wh_nm"];
			
			
		//}
		
		// INSERT ROWS
		 
		for (int l_addrow = 0; l_addrow < dt.Rows.Count-1; l_addrow++)
		{
         exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet
		}
						
		// SET DATA
		int pos = 6;
		int i   = 0  ;		  			
		
		
					
		for (i = 0; i < dt.Rows.Count; i++)
        {									
			//exSheet.Range[pos + i, 4,pos + i, 5].Merge();
			//exSheet.Cells[pos + i, 2 ].Value = i+1;
			exSheet.Cells[pos + i, 1 ].Value = dt.Rows[i]["prod_date"];
			//exSheet.Cells[pos + i, 2 ].Value = dt.Rows[i]["hq_sang"];
			/*exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""];	
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""];			
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; 
			exSheet.Cells[pos + i,  ].Value = dtDetail.Rows[i][""]; */
			
        }
		
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