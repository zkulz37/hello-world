﻿using System;
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

public partial class rpt_epbp00110_during : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		
        string l_master_pk = Request["p_po_pk"];
       
        string TemplateFile = "rpt_epbp00110_during.xls";
        string TempFile = "../../../system/temp/rpt_epbp00110_during" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        DataTable dtInfo = ESysLib.TableReadOpenCursor("lg_rpt_epbp00110_during");

        //--set-----DataBind--in---Info---
         
		//-----------------------------------
		if ( dtInfo.Rows.Count > 0 )
		{
			exSheet.Cells[1, 3].Value = dtInfo.Rows[0]["partner_name"].ToString();       
			exSheet.Cells[2, 3].Value = "Addr: " + dtInfo.Rows[0]["addr1"].ToString();
			exSheet.Cells[3, 3].Value = "MST: " + dtInfo.Rows[0]["tax_code"].ToString();
		
			exSheet.Cells[1, 8].Value = "Tel: " + dtInfo.Rows[0]["phone_no"].ToString();
			exSheet.Cells[2, 8].Value = "Fax: " + dtInfo.Rows[0]["fax_no"].ToString();
			exSheet.Cells[3, 8].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy");
		}	
        //-----------------------------------

        DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00110_1_during", "'" + l_master_pk + "'");
        DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00110_2_during", "'" + l_master_pk + "'");
       
		// ---
		
		if ( dt1.Rows.Count > 0 )
		{
			exSheet.Cells[5, 3].Value = dt1.Rows[0]["po_no"].ToString();
			exSheet.Cells[6, 3].Value = dt1.Rows[0]["po_date"].ToString();
			exSheet.Cells[7, 3].Value = dt1.Rows[0]["supplier"].ToString();
			exSheet.Cells[8, 3].Value = dt1.Rows[0]["dept_name"].ToString();
			exSheet.Cells[9, 3].Value = dt1.Rows[0]["description"].ToString();
		}
        // end title
        int pos = 13;
		
		Double total_item_amount 	= 0;
		Double total_vat_amount	    = 0;
		Double total_discount	= 0;
		Double total_amount			= 0;
		
		int l_row = 0 ;
		
		for ( l_row = 0; l_row < dt2.Rows.Count-1; l_row++ )
		{
			exSheet.Range[ l_row+pos+1, 1, l_row+pos+1, 8].Rows.EntireRow.Insert();
		}			
		
        for (l_row = 0; l_row < dt2.Rows.Count; l_row++)
        {					 								
            exSheet.Cells[l_row+pos, 1].Value = dt2.Rows[l_row]["seq"];	
			exSheet.Cells[l_row+pos, 2].Value = dt2.Rows[l_row]["ref_no"];	
			exSheet.Cells[l_row+pos, 3].Value = dt2.Rows[l_row]["item_name"];
			
			exSheet.Cells[l_row+pos, 4].Value = dt2.Rows[l_row]["po_uom"];	
			exSheet.Cells[l_row+pos, 5].Value = dt2.Rows[l_row]["po_qty"];	
			exSheet.Cells[l_row+pos, 6].Value = dt2.Rows[l_row]["unit_price"];
			exSheet.Cells[l_row+pos, 7].Value = dt2.Rows[l_row]["vat_amount"];
			exSheet.Cells[l_row+pos, 8].Value = dt2.Rows[l_row]["total_amt"];
			
			exSheet.Cells[l_row+pos, 9].Value = dt2.Rows[l_row]["etd_from"];

			total_item_amount  		+= Convert.ToDouble(dt2.Rows[l_row]["po_amt"]);
			total_vat_amount   		+= Convert.ToDouble(dt2.Rows[l_row]["vat_amount"]); 		
			total_discount   	    += Convert.ToDouble(dt2.Rows[l_row]["discount_amt"]); 
			total_amount		   	+= Convert.ToDouble(dt2.Rows[l_row]["total_amt"]);
        }
                                 
        exSheet.Cells[l_row+pos,   6].Value = total_item_amount;   
		exSheet.Cells[l_row+pos+1, 6].Value = total_discount;		
        exSheet.Cells[l_row+pos+2, 6].Value = total_vat_amount;                    
		exSheet.Cells[l_row+pos+3, 6].Value = total_amount;
		
		exSheet.Cells[l_row+pos,   9].Value = dt1.Rows[0]["po_ccy"].ToString();
		exSheet.Cells[l_row+pos+1, 9].Value = dt1.Rows[0]["po_ccy"].ToString();
		exSheet.Cells[l_row+pos+2, 9].Value = dt1.Rows[0]["po_ccy"].ToString();
		exSheet.Cells[l_row+pos+3, 9].Value = dt1.Rows[0]["po_ccy"].ToString();
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
