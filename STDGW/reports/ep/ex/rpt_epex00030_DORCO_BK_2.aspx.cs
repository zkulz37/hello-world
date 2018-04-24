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

public partial class reports_rpt_epex00030_DORCO_BK : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("SALE");
		
        string p_master_pk 		= Request["p_master_pk"];

        string TemplateFile = "rpt_epex00030_DORCO_BK.xls";
        string TempFile = "../../../system/temp/rpt_epex00030_DORCO_BK_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

        DataTable dtInfo = ESysLib.TableReadOpenCursor("rpt_epex00030_DORCO_CI_1", "'" + p_master_pk + "'");
		
        DataTable dtDetail = ESysLib.TableReadOpenCursor("rpt_epex00030_DORCO_CI_2", "'" + p_master_pk + "'");
		
		//DataTable dtDT2 = ESysLib.TableReadOpenCursor("rpt_epex00030_DORCO_SALE_3", "'" + p_master_pk + "'");

        if (dtInfo.Rows.Count == 0) goto xxx;
        //--set-----DataBind--in---Master---
         
		exSheet.Cells["G2"].Value = dtInfo.Rows[0]["CO_INVOICE_NO"].ToString();
		exSheet.Cells["J2"].Value = "DATE: " + dtInfo.Rows[0]["CO_INVOICE_Date"].ToString();
		
		exSheet.Cells["G3"].Value = dtInfo.Rows[0]["contract_no"].ToString();
		
        exSheet.Cells["B12"].Value = dtInfo.Rows[0]["cust_name"].ToString();
        exSheet.Cells["B13"].Value = dtInfo.Rows[0]["cust_addr1"].ToString();
        exSheet.Cells["B15"].Value = dtInfo.Rows[0]["contact_info"].ToString();

        exSheet.Cells["D17"].Value = dtInfo.Rows[0]["price_type"].ToString();	

		exSheet.Cells["B19"].Value = dtInfo.Rows[0]["packing_marks"].ToString();	

		exSheet.Cells["J5"].Value = dtInfo.Rows[0]["payment_term"].ToString();
		exSheet.Cells["J6"].Value = dtInfo.Rows[0]["dm_port"].ToString();
		exSheet.Cells["J7"].Value = dtInfo.Rows[0]["os_port"].ToString();
		exSheet.Cells["J8"].Value = dtInfo.Rows[0]["deli_method"].ToString();
		exSheet.Cells["J9"].Value = dtInfo.Rows[0]["etd_from"].ToString();
		
		exSheet.Cells["H12"].Value = dtInfo.Rows[0]["PARTNER_CARRIER_DESC"].ToString();	
		exSheet.Cells["H18"].Value = dtInfo.Rows[0]["PARTNER_NOTIFY_DESC"].ToString();

		exSheet.Cells["B26"].Value = dtInfo.Rows[0]["GOODS_MARKS"].ToString();			
        
    ////end-set-----DataBind--in---Master---
    xxx:
        if (dtDetail.Rows.Count == 0)
        {
            return;
        }
		
		int pos   = 28;
		int l_row = 0;
				
        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A29"].Rows.EntireRow.Insert();//insert row new of sheet				
        }

        for (l_row=0; l_row < dtDetail.Rows.Count; l_row++)
        {
            exSheet.Cells[l_row+pos,1].Value = dtDetail.Rows[l_row]["seq"].ToString();
			exSheet.Cells[l_row+pos,2].Value = dtDetail.Rows[l_row]["item_desc"].ToString();
			
			exSheet.Cells[pos + l_row, 2, pos + l_row, 5].Merge();
			
			exSheet.Cells[l_row+pos,7].Value = dtDetail.Rows[l_row]["inv_qty"];
			exSheet.Cells[l_row+pos,8].Value = dtDetail.Rows[l_row]["uom"].ToString();
			exSheet.Cells[l_row+pos,10].Value = dtDetail.Rows[l_row]["inv_unit_price"];
			exSheet.Cells[l_row+pos,12].Value = dtDetail.Rows[l_row]["inv_item_amount"];
        }
        
        exSheet.Cells["G" + (l_row+pos)].Value = "=SUM(G28:G" + (l_row+pos-1) + ")";
        exSheet.Cells["L" + (l_row+pos)].Value = "=SUM(L28:L" + (l_row+pos-1) + ")"; 
		 			
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