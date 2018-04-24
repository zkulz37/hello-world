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

public partial class reports_rpt_fpma00311 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fpma00311.xls";
        string TempFile = "../../../system/temp/rpt_fpma00311_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        
        string p_asset_type_pk  = Request.QueryString["p_asset_type_pk"];
		string p_asset_name     = Request.QueryString["p_asset_name"];        
		string p_account        = Request.QueryString["p_account"];
		string p_begin_date     = Request.QueryString["p_begin_date"];
		string p_end_date       = Request.QueryString["p_end_date"];
         
        string para = "'" + p_begin_date + "','" + p_end_date + "'";		
		DataTable dtHeader = ESysLib.TableReadOpenCursor("lg_rpt_fpma00311_1" , para);	
		
		para = "'" + p_asset_type_pk + "','" + p_asset_name + "','" + p_account + "','" + p_begin_date + "','" + p_end_date + "'";
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fpma00311" , para);		  
		
        // MASTER   

		//--set-----DataBind--in---Master---
        if (!string.IsNullOrEmpty(dtHeader.Rows[0]["pic"].ToString()))
        {
            exSheet.Cells[1, 1].Select();
            byte[] MyData = new byte[0];
            MyData = (byte[])dtHeader.Rows[0]["pic"];
            MemoryStream stream = new MemoryStream(MyData);

            Bitmap b = new Bitmap(stream);
            exSheet.Shapes.AddPicture(ResizeImage(b, 90, 59));
        }
		
        exSheet.Cells["I7"].Value = dtHeader.Rows[0]["t_year"];
        exSheet.Cells["F7"].Value = dtHeader.Rows[0]["t_month"];
		
		exSheet.Cells["C1"].Value = dtHeader.Rows[0]["partner_name"];
		exSheet.Cells["C2"].Value = dtHeader.Rows[0]["addr1"];
		exSheet.Cells["L1"].Value = "Tel: "      + dtHeader.Rows[0]["phone_no"];
		exSheet.Cells["L2"].Value = "Fax No: "   + dtHeader.Rows[0]["fax_no"]; 
        exSheet.Cells["C3"].Value = "Tax Code: " + dtHeader.Rows[0]["tax_code"];
		
		exSheet.Cells["L3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");
		
		exSheet.Cells["D7"].Value = dtHeader.Rows[0]["t_period"];
        // END MASTER
		
		// INSERT ROWS
		 
		/*for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A12"].Rows.EntireRow.Insert();//insert row new of sheet
        }*/
						
		// SET DATA
		int pos = 11 ;
		int i   = 0  ;
		int j   = 0  ;
		int t   = 0  ;
 		
		decimal total_ma_qty 				= 0 ;
		decimal total_in_amount 			= 0 ;
		decimal total_depr_monthly_amount 	= 0 ;
		decimal total_out_amount 			= 0 ;
		decimal total_depr_this_month 		= 0 ;
		decimal total_bal_amount 			= 0 ;
		
		Color color1 = ColorTranslator.FromHtml("0xCCFFFF");
		Color color2 = ColorTranslator.FromHtml("0xFFFFCC");
					
		for (i = 0; i < dtMaster.Rows.Count; i++)
        {
			exSheet.Range["A12"].Rows.EntireRow.Insert();
			
            exSheet.Cells[pos + t, 1 ].Value = i + 1 ;
			exSheet.Cells[pos + t, 2 ].Value = dtDetail.Rows[i]["asset_code"];
			exSheet.Cells[pos + t, 3 ].Value = dtDetail.Rows[i]["asset_acc_code"];
			/*exSheet.Cells[pos + t, 4 ].Value = dtMaster.Rows[i]["in_amount"];
			exSheet.Cells[pos + t, 5 ].Value = dtMaster.Rows[i]["depr_monthly_amount"];
			exSheet.Cells[pos + t, 6 ].Value = dtMaster.Rows[i]["out_amount"];
			exSheet.Cells[pos + t, 7 ].Value = dtMaster.Rows[i]["depr_this_month"];
			exSheet.Cells[pos + t, 8 ].Value = dtMaster.Rows[i]["bal_amount"];*/
			
			 
						
        }
				 			
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