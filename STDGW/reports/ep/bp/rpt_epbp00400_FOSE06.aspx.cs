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

public partial class rpt_epbp00400_FOSE06 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		

        string TemplateFile = "rpt_epbp00400_FOSE06.xls";
        string TempFile = "../../../system/temp/rpt_epbp00400_FOSE06_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		
		string p_from_date 	= Request.QueryString["p_from_dt"];
		string p_to_date 	= Request.QueryString["p_to_dt"];
		string p_wh_type 	= Request.QueryString["p_wh_type"];
		string p_wh_pk 		= Request.QueryString["p_wh_pk"];
		string p_group_pk   = Request.QueryString["p_group_pk"];
		string p_item 		= Request.QueryString["p_item"];
		string p_partner_pk = Request.QueryString["p_partner_pk"];
         
        string para ;
				
		DataTable dtInfo   = ESysLib.TableReadOpenCursor("lg_rpt_epbp00400_FOSE06_1" , "'" + Session["User_ID"].ToString() + "'");	
		
		para = "'" + p_from_date + "','" + p_to_date + "'";	
		DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_epbp00400_FOSE06_2" , para);	
		
		para = "'" + p_from_date + "','" + p_to_date + "'";	
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_epbp00400_FOSE06_3" , para);
				 
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
		
		//-------------------------------		
		exSheet.Cells["B1"].Value = dtInfo.Rows[0]["partner_name"];
		exSheet.Cells["B2"].Value = dtInfo.Rows[0]["addr1"];
		exSheet.Cells["B3"].Value = "Tax Code: " + dtInfo.Rows[0]["tax_code"];
		
		exSheet.Cells["G1"].Value = "Tel: "      + dtInfo.Rows[0]["phone_no"];
		exSheet.Cells["G2"].Value = "Fax No: "   + dtInfo.Rows[0]["fax_no"]; 
		exSheet.Cells["G3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");		        
		//-------------------------------	
		//tong tin master
		if( dtMaster.Rows.Count >0)
		{			 
			exSheet.Cells["A6"].Value = dtMaster.Rows[0]["req_date"];					
		}
		 
        // END MASTER
		
		// INSERT ROWS
		 
		for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A9"].Rows.EntireRow.Insert();//insert row new of sheet
        }
						
		// SET DATA
		int pos = 8 ;
		int i   = 0  ;		
		
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {
			exSheet.Cells[pos + i, 1 ].Value = i+1;
			
			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["dept_name"];		 	
			exSheet.Cells[pos + i, 2, pos + i, 7].Merge();
	
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["req_amount"]; 
			exSheet.Cells[pos + i, 8, pos + i, 10].Merge();	
        }
		//---------
        
		int t = pos+i-1 ;
		
		exSheet.Cells[pos + i,  8].Value = "=sum(H8:H"+t+")";		

		
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