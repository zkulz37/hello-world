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

public partial class rpt_bini00050_ST01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_bini00050_ST01.xls";
        string TempFile = "../../../system/temp/rpt_bini00050_ST01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
        string p_master_pk;
        
		p_master_pk = Request.QueryString["master_pk"];
         
        string para = "'" + p_master_pk + "'";	

		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_bini00050_ST01_1", "'" + Session["User_ID"].ToString() + "'");			
		DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_bini00050_ST01_2" , para);		
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_bini00050_ST01_3" , para);		
			
        // MASTER   

		//--set-----DataBind--in---Master---
        if (!string.IsNullOrEmpty(dtInfo.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells[1, 1].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dtInfo.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 90, 59));
        }
		
		if( dtMaster.Rows.Count >0)
		{
			exSheet.Cells["H4"].Value = dtMaster.Rows[0]["slip_no"];
			exSheet.Cells["H5"].Value = dtMaster.Rows[0]["out_date"];
			
			exSheet.Cells["C6"].Value = dtMaster.Rows[0]["dept_name"];
			exSheet.Cells["C7"].Value = dtMaster.Rows[0]["receiver"];
			
			exSheet.Cells["G6"].Value = dtMaster.Rows[0]["wh_name"];
			exSheet.Cells["G7"].Value = dtMaster.Rows[0]["ref_no"];
			
			exSheet.Cells["C8"].Value = dtMaster.Rows[0]["description"];	
		
		}
		 
        // END MASTER
		
		// INSERT ROWS
		 
		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A13"].Rows.EntireRow.Insert();//insert row new of sheet
        }
						
		// SET DATA
		int pos = 12 ;
		int i   = 0  ;		  
		double total_sub = 0, total_vat = 0, total_amt = 0;
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
			exSheet.Cells[pos + i, 1 ].Value = dtDetail.Rows[i]["seq"];

			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["item_code"];	
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["item_name"];
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["out_uom"];		
			
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["out_qty"];
			
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["unit_price"];
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["item_amount"];

			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["description"]; 
			
			total_sub += Convert.ToDouble(dtDetail.Rows[i]["item_amount"]);
			total_vat += Convert.ToDouble(dtDetail.Rows[i]["vat_amount"]);
			total_amt += Convert.ToDouble(dtDetail.Rows[i]["total_amount"]);
		
        }
        // total
        exSheet.Cells["G"+ (pos + i + 0)].Value = total_sub;
        exSheet.Cells["G"+ (pos + i + 1)].Value = total_vat;
        exSheet.Cells["G"+ (pos + i + 2)].Value = total_amt;
		
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