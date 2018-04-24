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

public partial class reports_rpt_epex00030_DORCO_SALE : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("SALE");
		
        string p_master_pk 		= Request["p_master_pk"];

        string TemplateFile = "rpt_epex00030_DORCO_SALE.xls";
        string TempFile = "../../../system/temp/rpt_epex00030_DORCO_SALE_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

        DataTable dtInfo = ESysLib.TableReadOpenCursor("rpt_epex00030_DORCO_SALE_1", "'" + p_master_pk + "'");
		
        DataTable dtDetail = ESysLib.TableReadOpenCursor("rpt_epex00030_DORCO_SALE_2", "'" + p_master_pk + "'");
				 
        if (dtInfo.Rows.Count == 0) goto xxx;
        //--set-----DataBind--in---Master---
         
		exSheet.Cells["D4"].Value = dtInfo.Rows[0]["CO_INVOICE_NO"].ToString();
		exSheet.Cells["G4"].Value = "DATE: " + dtInfo.Rows[0]["CO_INVOICE_Date"].ToString();
		
        exSheet.Cells["B13"].Value = dtInfo.Rows[0]["cust_name"].ToString();
        exSheet.Cells["B14"].Value = dtInfo.Rows[0]["cust_addr1"].ToString();
        exSheet.Cells["B15"].Value = dtInfo.Rows[0]["contact_info"].ToString();		
		
		exSheet.Cells["C18"].Value = dtInfo.Rows[0]["GOODS_MARKS"].ToString();
        
    ////end-set-----DataBind--in---Master---
    xxx:
        if (dtDetail.Rows.Count == 0)
        {
            return;
        }
		
		int pos   = 20;
		int l_row = 0;
		
		
        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A21"].Rows.EntireRow.Insert();//insert row new of sheet
        }

        for (l_row=0; l_row < dtDetail.Rows.Count; l_row++)
        {
            exSheet.Cells[l_row+pos,1].Value = dtDetail.Rows[l_row]["seq"].ToString();
			exSheet.Cells[l_row+pos,2].Value = dtDetail.Rows[l_row]["item_desc"].ToString();
			exSheet.Cells[l_row+pos,3].Value = dtDetail.Rows[l_row]["cust_item"].ToString();
			exSheet.Cells[l_row+pos,4].Value = dtDetail.Rows[l_row]["inv_qty"];
			exSheet.Cells[l_row+pos,5].Value = dtDetail.Rows[l_row]["uom"].ToString();
			exSheet.Cells[l_row+pos,6].Value = dtDetail.Rows[l_row]["inv_unit_price"];
			exSheet.Cells[l_row+pos,7].Value = dtDetail.Rows[l_row]["inv_item_amount"];
        }
        
        exSheet.Cells["D" + (l_row+pos)].Value = "=SUM(D20:D" + (l_row+pos-1) + ")";
        exSheet.Cells["G" + (l_row+pos)].Value = "=SUM(G20:G" + (l_row+pos-1) + ")"; 

		exSheet.Cells[l_row+22,1].Value = dtInfo.Rows[0]["price_type"].ToString();	
		
		exSheet.Cells[l_row+24,2].Value = dtInfo.Rows[0]["PARTNER_CARRIER_DESC"].ToString();	
		
		exSheet.Cells[l_row+28,3].Value = dtInfo.Rows[0]["payment_term"].ToString();
		
		exSheet.Cells[l_row+36,4].Value = dtInfo.Rows[0]["SHIP_DATE"].ToString();	
		
		exSheet.Cells[l_row+48,6].Value = dtInfo.Rows[0]["cust_name"].ToString();				
		
        // end loop detail not percent

        // end loop detail percent
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
        //ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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