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

public partial class reports_rpt_epex00030_DURING02 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		
        string p_master_pk 		= Request["p_master_pk"];
			
		/****************************************************************/
        string TemplateFile = "rpt_epex00030_DURING02.xls";
        string TempFile = "../../../system/temp/rpt_epex00030_DURING02_" + Session["User_ID"].ToString() + ".xls";
		
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);		
		/****************************************************************/

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets["Sheet1"];				
		
        IRange range;

        //bind data to excel file
		DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_epex00030_during02_1", "'" + p_master_pk + "'");
		
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_epex00030_during02_2", "'" + p_master_pk + "'");
		         
        //--set-----DataBind--in---Master---
         
		exSheet.Cells["I5"].Value = dtMaster.Rows[0]["CO_INVOICE_NO"].ToString();
		exSheet.Cells["I6"].Value = dtMaster.Rows[0]["CO_INVOICE_DATE"].ToString();
		
        exSheet.Cells["D9"].Value = dtMaster.Rows[0]["CONTRACT_NO"].ToString();
		
		int pos   = 19;
		int l_row = 0;		
		
        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A20"].Rows.EntireRow.Insert();//insert row new of sheet
        }

        for (l_row=0; l_row < dtDetail.Rows.Count; l_row++)
        {
            exSheet.Cells[l_row+pos,1].Value = dtDetail.Rows[l_row]["seq"];
			exSheet.Cells[l_row+pos,2].Value = dtDetail.Rows[l_row]["item_name"];
			exSheet.Cells[l_row+pos,3].Value = dtDetail.Rows[l_row]["item_code"];
			exSheet.Cells[l_row+pos,4].Value = dtDetail.Rows[l_row]["hs_code"];
			exSheet.Cells[l_row+pos,5].Value = dtDetail.Rows[l_row]["virtual_code"];
			exSheet.Cells[l_row+pos,6].Value = dtDetail.Rows[l_row]["inv_qty"];
			
			exSheet.Cells[l_row+pos,7].Value = dtDetail.Rows[l_row]["pack_qty"];
			exSheet.Cells[l_row+pos,8].Value = dtDetail.Rows[l_row]["box_qty"];
			exSheet.Cells[l_row+pos,9].Value = dtDetail.Rows[l_row]["net_weight"];
			                                   
			exSheet.Cells[l_row+pos,10].Value = "I"+(l_row+pos)+"+(G"+(l_row+pos)+"*0.02)+(H"+(l_row+pos)+"*M"+(l_row+pos)+")+(K"+(l_row+pos)+"*N"+(l_row+pos)+")";
			
			exSheet.Cells[l_row+pos,12].Value = dtDetail.Rows[l_row]["item_net_weight"];
			exSheet.Cells[l_row+pos,13].Value = dtDetail.Rows[l_row]["tray_weight"];
			exSheet.Cells[l_row+pos,14].Value = dtDetail.Rows[l_row]["pallet_weight"];
			exSheet.Cells[l_row+pos,15].Value = dtDetail.Rows[l_row]["quantity_of_pack"];
			exSheet.Cells[l_row+pos,16].Value = dtDetail.Rows[l_row]["pack_qty_in_pallet"];
			exSheet.Cells[l_row+pos,17].Value = dtDetail.Rows[l_row]["qty_in_a_tray"];
        }
        
        exSheet.Cells[l_row+pos,6].Value  = "=SUM(F19:F" + (l_row+pos-1) + ")";
        exSheet.Cells[l_row+pos,7].Value  = "=SUM(G19:G" + (l_row+pos-1) + ")"; 
		exSheet.Cells[l_row+pos,8].Value  = "=SUM(H19:H" + (l_row+pos-1) + ")"; 		
		exSheet.Cells[l_row+pos,9].Value  = "=SUM(I19:I" + (l_row+pos-1) + ")"; 
		exSheet.Cells[l_row+pos,10].Value = "=SUM(J19:J" + (l_row+pos-1) + ")"; 
		exSheet.Cells[l_row+pos,11].Value = "=SUM(K19:K" + (l_row+pos-1) + ")"; 
		/************************************************************************/
		/************************************************************************/
		/************************************************************************/
		/************************************************************************/
		/************************************************************************/
		
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        //range = exSheet.Range["A1"];
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