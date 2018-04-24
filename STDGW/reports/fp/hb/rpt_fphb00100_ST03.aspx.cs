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

public partial class rpt_fphb00100_ST03 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());        

        string TemplateFile = "rpt_fphb00100_ST03.xls";
        string TempFile = "../../../system/temp/rpt_fphb00100_ST03_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

		string p_itemgrp_pk = Request.QueryString["p_itemgrp_pk"];
		string p_parent_pk = Request.QueryString["p_parent_pk"];
		 
        string para = "'" + p_itemgrp_pk + "','" + p_parent_pk + "'";		       

        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fphb00100_ST03", para);	
				 
        ////end-set-----DataBind--in---Master---

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet
        }
        //set data to detail.
        // loop detail not percent
		int l_pos = 6;
		int i = 0 ;
        for (i = 1; i <= dtDetail.Rows.Count; i++)
        {
            exSheet.Cells[l_pos+i-1,1].Value = dtDetail.Rows[i-1]["prod_name"].ToString(); 
			exSheet.Cells[l_pos+i-1,2].Value = dtDetail.Rows[i-1]["child_name"].ToString(); 
			exSheet.Cells[l_pos+i-1,3].Value = dtDetail.Rows[i-1]["child_uom"].ToString();
			if(dtDetail.Rows[i-1]["cons_qty"].ToString()!="")
			{			
				exSheet.Cells[l_pos+i-1,4].Value = double.Parse(dtDetail.Rows[i-1]["cons_qty"].ToString());
			}
			if(dtDetail.Rows[i-1]["pur_price"].ToString()!="")
			{			
				exSheet.Cells[l_pos+i-1,5].Value = double.Parse(dtDetail.Rows[i-1]["pur_price"].ToString());
			}
			if(dtDetail.Rows[i-1]["item_amount"].ToString()!="")
			{			
				exSheet.Cells[l_pos+i-1,6].Value = double.Parse(dtDetail.Rows[i-1]["item_amount"].ToString()); 
			}
			if(dtDetail.Rows[i-1]["coefficient_rate"].ToString()!="")
			{			
				exSheet.Cells[l_pos+i-1,7].Value = double.Parse(dtDetail.Rows[i-1]["coefficient_rate"].ToString()); 
			}
			if(dtDetail.Rows[i-1]["total_amount"].ToString()!="")
			{			
				exSheet.Cells[l_pos+i-1,8].Value = double.Parse(dtDetail.Rows[i-1]["total_amount"].ToString()); 
			}
			if(dtDetail.Rows[i-1]["vat_amount"].ToString()!="")
			{			
				exSheet.Cells[l_pos+i-1,9].Value = double.Parse(dtDetail.Rows[i-1]["vat_amount"].ToString()); 
			}
			if(dtDetail.Rows[i-1]["service_charge_amount"].ToString()!="")
			{			
				exSheet.Cells[l_pos+i-1,10].Value = double.Parse(dtDetail.Rows[i-1]["service_charge_amount"].ToString()); 
			}
			if(dtDetail.Rows[i-1]["selling_amount"].ToString()!="")
			{			
				exSheet.Cells[l_pos+i-1,11].Value = double.Parse(dtDetail.Rows[i-1]["selling_amount"].ToString()); 
			}	
			if(dtDetail.Rows[i-1]["child_name"].ToString()=="Sub Total :")
			{
				string l_Color="0XFF66CC";//0XC0C0C0
				Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
				exSheet.Cells[i+l_pos-1, 2,i+l_pos-1, 11].Interior.Color = colorValueFrmHex;//set color grand total
			}
			if(dtDetail.Rows[i-1]["child_name"].ToString()=="Total :")
			{
				string l_Color="0XFFCC00";//0XC0C0C0
				Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
				exSheet.Cells[i+l_pos-1, 1,i+l_pos-1, 11].Interior.Color = colorValueFrmHex;//set color grand total
			}
			if (i < dtDetail.Rows.Count)
			{				
				if(dtDetail.Rows[i-1]["prod_name"].ToString() == dtDetail.Rows[i]["prod_name"].ToString())
				{
					exSheet.Range[i+l_pos-1, 1,i+l_pos, 1].Merge();
				}
			}
        }
        
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