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

public partial class rpt_dsmr00010 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		
        string p_date_from   = Request["p_date_from"];
        string p_date_to     = Request["p_date_to"];  
		string p_line_group  = Request["p_line_group"];  
		string po_no         = Request["po_no"];  
	
        string TemplateFile = "rpt_dsmr00010.xls";
        string TempFile = "../../../system/temp/rpt_dsmr00010_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

        string para = "'" + p_date_from + "','" + p_date_to + "','" + p_line_group + "','" + po_no + "'";
		
        //DataTable dtInfo = ESysLib.TableReadOpenCursor("LG_RPT_bisa00021_1", "'" + Session["User_ID"].ToString() + "'");
		
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_sel_dsmr00010", para);

        //if (dtInfo.Rows.Count == 0) goto xxx;
        //--set-----DataBind--in---Master---
        /*if (!string.IsNullOrEmpty(dtInfo.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells["A1"].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dtInfo.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 131, 71));
        }
        
        exSheet.Cells["C1"].Value = dtInfo.Rows[0]["partner_name"].ToString();
        exSheet.Cells["C2"].Value = dtInfo.Rows[0]["addr1"].ToString();
		exSheet.Cells["C3"].Value = "Tax code: " + dtInfo.Rows[0]["tax_code"].ToString();
		
        exSheet.Cells["I1"].Value = "Tel: " + dtInfo.Rows[0]["phone_no"].ToString();
        exSheet.Cells["I2"].Value = "Fax: " + dtInfo.Rows[0]["fax_no"].ToString();
		exSheet.Cells["I3"].Value = "Print date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");
        */
    ////end-set-----DataBind--in---Master---
        if (dtDetail.Rows.Count == 0)
        {
            return;
        }

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------	 
		int l_pos = 5 ;
		int l_row = 0 ;
		
        for (l_row = 1; l_row < dtDetail.Rows.Count; l_row++)
        {
			//exSheet.Cells[3, 21].Value = dtDetail.Rows[0]["print_time"].ToString();
			exSheet.Cells[l_pos + l_row, 1].Value = dtDetail.Rows[l_row]["dest_nation"] ;
			exSheet.Cells[l_pos + l_row, 2].Value = dtDetail.Rows[l_row]["line_grp"].ToString();
            exSheet.Cells[l_pos + l_row, 3].Value = dtDetail.Rows[l_row]["ex_fac"].ToString(); 
			exSheet.Cells[l_pos + l_row, 4].Value = dtDetail.Rows[l_row]["buyer"].ToString();
			exSheet.Cells[l_pos + l_row, 5].Value = dtDetail.Rows[l_row]["pattern"].ToString();			
			exSheet.Cells[l_pos + l_row, 6].Value = dtDetail.Rows[l_row]["po_no"] ;	
			exSheet.Cells[l_pos + l_row, 7].Value = dtDetail.Rows[l_row]["ref_no"] ;			
			exSheet.Cells[l_pos + l_row, 8].Value = dtDetail.Rows[l_row]["amount"] ;
			exSheet.Cells[l_pos + l_row, 9].Value = dtDetail.Rows[l_row]["delivery_dt"] ;
			exSheet.Cells[l_pos + l_row, 10].Value = dtDetail.Rows[l_row]["aisi"] ;
			exSheet.Cells[l_pos + l_row, 11].Value = dtDetail.Rows[l_row]["qty_total"] ;
			exSheet.Cells[l_pos + l_row,12].Value = dtDetail.Rows[l_row]["s_f_total"] ;
			exSheet.Cells[l_pos + l_row,13].Value = dtDetail.Rows[l_row]["qty_1h_h"] ;
			exSheet.Cells[l_pos + l_row,14].Value = dtDetail.Rows[l_row]["qty_2h_h"] ;
			exSheet.Cells[l_pos + l_row,15].Value = dtDetail.Rows[l_row]["qty_knife"] ;
			exSheet.Cells[l_pos + l_row,16].Value = dtDetail.Rows[l_row]["bal_total"] ;
			exSheet.Cells[l_pos + l_row,17].Value = dtDetail.Rows[l_row]["bal_s_f"] ;
			exSheet.Cells[l_pos + l_row,18].Value = dtDetail.Rows[l_row]["bal_knife"] ;
			exSheet.Cells[l_pos + l_row,19].Value = dtDetail.Rows[l_row]["description"] ;
			exSheet.Cells[l_pos + l_row,20].Value = dtDetail.Rows[l_row]["pay_term"] ;
			exSheet.Cells[l_pos + l_row,21].Value = dtDetail.Rows[l_row]["req_no"] ;
			exSheet.Cells[l_pos + l_row,22].Value = dtDetail.Rows[l_row]["item_code"] ;		
        }
		
        
		exSheet.Cells["H" + (l_pos + l_row)].Value = "=SUM(H6:H" + (l_pos + l_row -1) + ")";
        exSheet.Cells["K" + (l_pos + l_row)].Value = "=SUM(K6:K" + (l_pos + l_row -1) + ")";
        

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