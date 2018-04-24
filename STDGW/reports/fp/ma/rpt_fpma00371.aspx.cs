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

public partial class reports_rpt_fpma00371 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fpma00371.xls";
        string TempFile = "../../../system/temp/rpt_fpma00371_" + Session["User_ID"].ToString() + ".xls";
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
		DataTable dtHeader = ESysLib.TableReadOpenCursor("lg_rpt_fpma00371_1" , para);	
		
		para = "'" + p_begin_date + "','" + p_end_date + "','" + p_asset_type_pk + "','" + p_asset_name + "','" + p_account + "'";
		DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fpma00371" , para);		  
		
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
		        
		exSheet.Cells["C1"].Value = dtHeader.Rows[0]["partner_name"];
		exSheet.Cells["C2"].Value = dtHeader.Rows[0]["addr1"];		
        exSheet.Cells["C3"].Value = "Tax Code: " + dtHeader.Rows[0]["tax_code"];
		
		exSheet.Cells["M1"].Value = "Tel: "      + dtHeader.Rows[0]["phone_no"];
		exSheet.Cells["M2"].Value = "Fax No: "   + dtHeader.Rows[0]["fax_no"]; 
		exSheet.Cells["M3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");
		
		exSheet.Cells["D7"].Value = dtHeader.Rows[0]["t_period"];
		
        // END MASTER
		
		// INSERT ROWS
		 
		for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A12"].Rows.EntireRow.Insert();//insert row new of sheet
        }
						
		// SET DATA
		int pos = 11 ;
		int i   = 0  ;
		   		
		Color color1 = ColorTranslator.FromHtml("0xCCFFFF");
		Color color2 = ColorTranslator.FromHtml("0xFFFFCC");
					
		for (i = 0; i < dtDetail.Rows.Count; i++)
        {								
            exSheet.Cells[pos + i, 1 ].Value = i + 1 ;
			exSheet.Cells[pos + i, 2 ].Value = dtDetail.Rows[i]["asset_code"];
			exSheet.Cells[pos + i, 3 ].Value = dtDetail.Rows[i]["asset_acc_code"];
			exSheet.Cells[pos + i, 4 ].Value = dtDetail.Rows[i]["asset_name"];
			exSheet.Cells[pos + i, 5 ].Value = dtDetail.Rows[i]["f_name_01"];
			exSheet.Cells[pos + i, 6 ].Value = dtDetail.Rows[i]["ma_qty"];
			exSheet.Cells[pos + i, 7 ].Value = dtDetail.Rows[i]["start_date"];
			exSheet.Cells[pos + i, 8 ].Value = dtDetail.Rows[i]["begin_amount"]; 
			exSheet.Cells[pos + i, 9 ].Value = dtDetail.Rows[i]["increase_amount"]; 
			exSheet.Cells[pos + i, 10].Value = dtDetail.Rows[i]["decrease_amount"]; 
			exSheet.Cells[pos + i, 11].Value = dtDetail.Rows[i]["end_amount"]; 
			exSheet.Cells[pos + i, 12].Value = dtDetail.Rows[i]["this_depr_amount"]; 
			exSheet.Cells[pos + i, 13].Value = dtDetail.Rows[i]["accum_depr_amount"]; 
			exSheet.Cells[pos + i, 14].Value = dtDetail.Rows[i]["remain_amount"];  			 		
        }
		
		//---------
		exSheet.Cells[pos + i, 6 ].Value = "=sum(F11:F"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 8 ].Value = "=sum(H11:H"+(pos+i-1)+")";	
		exSheet.Cells[pos + i, 9 ].Value = "=sum(I11:I"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 10].Value = "=sum(J11:J"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 11].Value = "=sum(K11:K"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 12].Value = "=sum(L11:L"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 13].Value = "=sum(M11:M"+(pos+i-1)+")";
		exSheet.Cells[pos + i, 14].Value = "=sum(N11:N"+(pos+i-1)+")";		
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