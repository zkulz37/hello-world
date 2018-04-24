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

public partial class reports_rpt_fpma00361 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fpma00361.xls";
        string TempFile = "../../../system/temp/rpt_fpma00361_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string p_month          = Request.QueryString["p_month"];
        string p_asset_type_pk  = Request.QueryString["p_asset_type_pk"];
		string p_asset_group_pk = Request.QueryString["p_asset_group_pk"];        
		string p_asset          = Request.QueryString["p_asset"];
		string p_all_yn         = Request.QueryString["p_all_yn"];
         
        string para = "'" + p_month + "'";		
        DataTable dtHeader = ESysLib.TableReadOpenCursor("lg_rpt_fpma00361"   , para);
		
        para = "'" + p_month + "','" + p_asset_type_pk + "','" + p_asset_group_pk + "','" + p_asset + "','" + p_all_yn + "'";
		
		DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_fpma00361_1" , para);		
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_fpma00361_2" , para);
		DataTable dtTotal  = ESysLib.TableReadOpenCursor("lg_rpt_fpma00361_3" , para);
		
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
        // END MASTER
		
		// INSERT ROWS
		for (int l_addrow = 0; l_addrow < dtMaster.Rows.Count; l_addrow++)
        {
            exSheet.Range["A12"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A12"].Rows.EntireRow.Insert();//insert row new of sheet
        }
						
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
            exSheet.Cells[pos + t, 3 ].Value = dtMaster.Rows[i]["asset_type_code"];
			exSheet.Cells[pos + t, 4 ].Value = dtMaster.Rows[i]["asset_type_name"];
			exSheet.Cells[pos + t, 5 ].Value = dtMaster.Rows[i]["ma_qty"];
			exSheet.Cells[pos + t, 6 ].Value = dtMaster.Rows[i]["in_amount"];
			exSheet.Cells[pos + t, 10].Value = dtMaster.Rows[i]["depr_monthly_amount"];
			exSheet.Cells[pos + t, 12].Value = dtMaster.Rows[i]["out_amount"];
			exSheet.Cells[pos + t, 13].Value = dtMaster.Rows[i]["depr_this_month"];
			exSheet.Cells[pos + t, 14].Value = dtMaster.Rows[i]["bal_amount"];
			
			exSheet.Cells[pos + t, 1, pos + t, 14].Interior.Color = color2;//Color.Blue;
			//-------------
			total_ma_qty 				= total_ma_qty 				+ Convert.ToDecimal(dtMaster.Rows[i]["ma_qty"]) ;
			total_in_amount 			= total_in_amount 			+ Convert.ToDecimal(dtMaster.Rows[i]["in_amount"]) ;
			total_depr_monthly_amount 	= total_depr_monthly_amount + Convert.ToDecimal(dtMaster.Rows[i]["depr_monthly_amount"]) ;
			total_out_amount 			= total_out_amount 			+ Convert.ToDecimal(dtMaster.Rows[i]["out_amount"]) ;
			total_depr_this_month 		= total_depr_this_month 	+ Convert.ToDecimal(dtMaster.Rows[i]["depr_this_month"]) ;
			total_bal_amount 			= total_bal_amount 			+ Convert.ToDecimal(dtMaster.Rows[i]["bal_amount"]) ;
			
			//-------------
			t++;
			
			for (j = 0; j < dtDetail.Rows.Count; j++)
			{
				if ( dtMaster.Rows[i]["tlg_ma_asset_type_pk"].ToString() == dtDetail.Rows[j]["tlg_ma_asset_type_pk"].ToString() )
				{
					exSheet.Cells[pos + t, 1 ].Value = dtDetail.Rows[j]["asset_code"];
					exSheet.Cells[pos + t, 2 ].Value = dtDetail.Rows[j]["asset_acc_code"];
					exSheet.Cells[pos + t, 3 ].Value = dtDetail.Rows[j]["asset_name"];
					exSheet.Cells[pos + t, 4 ].Value = dtDetail.Rows[j]["f_name_01"];
					exSheet.Cells[pos + t, 5 ].Value = dtDetail.Rows[j]["ma_qty"];
					exSheet.Cells[pos + t, 6 ].Value = dtDetail.Rows[j]["in_amount"];
					exSheet.Cells[pos + t, 7 ].Value = dtDetail.Rows[j]["doc_no"];
					exSheet.Cells[pos + t, 8 ].Value = dtDetail.Rows[j]["start_date"];
					exSheet.Cells[pos + t, 9 ].Value = dtDetail.Rows[j]["plan_month_count"];
					exSheet.Cells[pos + t, 10].Value = dtDetail.Rows[j]["depr_monthly_amount"];
					exSheet.Cells[pos + t, 11].Value = dtDetail.Rows[j]["depr_month_count"];
					exSheet.Cells[pos + t, 12].Value = dtDetail.Rows[j]["out_amount"];
					exSheet.Cells[pos + t, 13].Value = dtDetail.Rows[j]["depr_this_month"];
					exSheet.Cells[pos + t, 14].Value = dtDetail.Rows[j]["bal_amount"];
					
					t++;
				}
			}
        }
		
		//---------
		exSheet.Cells[pos + t, 5 ].Value = total_ma_qty;
		exSheet.Cells[pos + t, 6 ].Value = total_in_amount;
		exSheet.Cells[pos + t, 10].Value = total_depr_monthly_amount;
		exSheet.Cells[pos + t, 12].Value = total_out_amount;
		exSheet.Cells[pos + t, 13].Value = total_depr_this_month;
		exSheet.Cells[pos + t, 14].Value = total_bal_amount;
		
		exSheet.Cells[pos + t, 1, pos + t, 14].Interior.Color = color1;//Color.Blue;
		//---------   
		
		t = t + 2;
		//--------- 
		for (int l_addrow = 0; l_addrow < dtTotal.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A"+(pos+t+1)].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//---------   
		
		exSheet.Cells[pos + t, 13].Value = total_in_amount;
		exSheet.Cells[pos + t, 12, pos + t, 13].Interior.Color = color2;//Color.Blue;
		
		t++;
		
		for (j = 0; j < dtTotal.Rows.Count; j++)
		{
			exSheet.Cells[pos + t, 12].Value = dtTotal.Rows[j]["asset_acc_code"];
			exSheet.Cells[pos + t, 13].Value = dtTotal.Rows[j]["in_amount"];
			
			t++;
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