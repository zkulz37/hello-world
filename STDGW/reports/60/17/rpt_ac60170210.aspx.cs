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

public partial class rpt_ac60170210 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		
       // ESysLib.SetUser("BAGUETTE");  
		//ESysLib.SetUser(Session["APP_DBUSER"].ToString());  
		// Session["APP_DBUSER"]
        string TemplateFile = "rpt_ac60170210.xls";
        string TempFile = "../../../system/temp/rpt_ac60170210_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string l_tco_company_pk = Request["p_tco_company_pk"]; 
		string l_std_ym = Request["p_std_ym"];
		string l_ac_cd = Request["p_ac_cd"];
		string l_item_pk = Request["p_item_pk"]; 
		string l_pl_pk = Request["p_pl_pk"];
	    string l_tin_warehouse_pk = Request["p_tin_warehouse_pk"];	
		
		string para = "'"+l_tco_company_pk+"','"+l_std_ym+"','"+l_ac_cd+"','"+l_item_pk+"','"+l_pl_pk+"','"+l_tin_warehouse_pk+"'";
		
		//Response.Write(para);
		//Response.End();
		DataTable dt = ESysLib.TableReadOpenCursor("sp_rpt_ac6017210_mst",para);
		DataTable dtl = ESysLib.TableReadOpenCursor("ac_rpt_60170210_1",para);//stor loi
		//DataTable dtl = ESysLib.TableReadOpenCursor("ac_sel_6017210_inq1",para);//tren f sai dc
		
		
	
		if (dt.Rows.Count == 0)
		{
            exSheet.Cells[3, 3].Value = "There is not data!";
		}
		if (dt.Rows.Count > 0)   
        {
			exSheet.Cells[1, 1].Value  =dt.Rows[0]["PARTNER_NAME"].ToString();
			exSheet.Cells[1, 18].Value  =dt.Rows[0]["PHONE_NO1"].ToString();
			exSheet.Cells[2, 1].Value  =dt.Rows[0]["ADDR1"].ToString();
			exSheet.Cells[2, 18].Value  =dt.Rows[0]["FAX_NO1"].ToString();
			exSheet.Cells[3, 1].Value  ="Tax code: "+dt.Rows[0]["TAX_CODE"].ToString();
			exSheet.Cells[3, 14].Value  ="Print report : "+dt.Rows[0]["date_1"].ToString();
        }
		
		for (int l_addrow =1; l_addrow < dtl.Rows.Count ; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------------------------
		
		int l_dtl_cnt = dtl.Rows.Count;
		int k=0;
		double tt_begin_qty =0,  tt_lost_no =0, tt_begin_amt =0,tt_in_qty =0,
		tt_in_amt =0,tt_out_qty=0, tt_out_amt=0,tt_end_qty =0,tt_end_amt=0;
		for (int i = 0; i < dtl.Rows.Count;i++)
        {
			
			/* dung stor ac_rpt_6017210_1 nay loi nen dong lai
			*/
			exSheet.Cells[7 + i, 1].Value =dtl.Rows[i]["wh_name"].ToString();
			exSheet.Cells[7 + i, 2].Value = dtl.Rows[i]["voucher_dt"].ToString();
			//exSheet.Cells[7 + i, 3].Value = dtl.Rows[i]["ac_cd"].ToString();
			exSheet.Cells[7 + i, 4].Value = dtl.Rows[i]["item_code"].ToString();
			exSheet.Cells[7 + i, 5].Value = dtl.Rows[i]["item_name"].ToString();
			
			exSheet.Cells[7 + i, 6].Value =dtl.Rows[i]["uom"].ToString();
			
			
			
		
			if(dtl.Rows[i]["begin_qty"].ToString() !="")
				{
					exSheet.Cells[7 + i, 8].Value  =double.Parse( dtl.Rows[i]["begin_qty"].ToString());
					exSheet.Cells[7 + i, 8].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 8].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_begin_qty = tt_begin_qty +double.Parse( dtl.Rows[i]["begin_qty"].ToString());
				}
			
			if(dtl.Rows[i]["begin_price"].ToString() !="")
				{
					exSheet.Cells[7 + i, 9].Value  =double.Parse( dtl.Rows[i]["begin_price"].ToString());
					exSheet.Cells[7 + i, 9].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 9].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_begin_price = tt_begin_price +double.Parse( dtl.Rows[i]["begin_price"].ToString());
				}
			
			
			if(dtl.Rows[i]["begin_amt"].ToString() !="")
				{
					exSheet.Cells[7 + i, 10].Value  =double.Parse( dtl.Rows[i]["begin_amt"].ToString());
					exSheet.Cells[7 + i, 10].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 10].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_begin_amt = tt_begin_amt +double.Parse( dtl.Rows[i]["begin_amt"].ToString());
				}
			if(dtl.Rows[i]["in_qty"].ToString() !="")
				{
					exSheet.Cells[7 + i, 11].Value  =double.Parse( dtl.Rows[i]["in_qty"].ToString());
					exSheet.Cells[7 + i, 11].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 11].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_in_qty = tt_in_qty +double.Parse( dtl.Rows[i]["in_qty"].ToString());
				}
				
			if(dtl.Rows[i]["in_price"].ToString() !="")
				{
					exSheet.Cells[7 + i, 12].Value  =double.Parse( dtl.Rows[i]["in_price"].ToString());
					exSheet.Cells[7 + i, 12].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 12].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_in_price = tt_in_price +double.Parse( dtl.Rows[i]["in_price"].ToString());
				}	
			if(dtl.Rows[i]["in_amt"].ToString() !="")
				{
					exSheet.Cells[7 + i, 13].Value  =double.Parse( dtl.Rows[i]["in_amt"].ToString());
					exSheet.Cells[7 + i, 13].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 13].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_in_amt = tt_in_amt +double.Parse( dtl.Rows[i]["in_amt"].ToString());
				}
			if(dtl.Rows[i]["out_qty"].ToString() !="")
				{
					exSheet.Cells[7 + i, 14].Value  =double.Parse( dtl.Rows[i]["out_qty"].ToString());
					exSheet.Cells[7 + i, 14].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 14].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_out_qty = tt_out_qty +double.Parse( dtl.Rows[i]["out_qty"].ToString());
				}
			if(dtl.Rows[i]["out_price"].ToString() !="")
				{
					exSheet.Cells[7 + i, 15].Value  =double.Parse( dtl.Rows[i]["out_price"].ToString());
					exSheet.Cells[7 + i, 15].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 15].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_out_price = tt_out_price +double.Parse( dtl.Rows[i]["out_price"].ToString());
				}
			if(dtl.Rows[i]["out_amt"].ToString() !="")
				{
					exSheet.Cells[7 + i, 16].Value  =double.Parse( dtl.Rows[i]["out_amt"].ToString());
					exSheet.Cells[7 + i, 16].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 16].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_out_amt = tt_out_amt +double.Parse( dtl.Rows[i]["out_amt"].ToString());
				}
			if(dtl.Rows[i]["end_qty"].ToString() !="")
				{
					exSheet.Cells[7 + i, 17].Value  =double.Parse( dtl.Rows[i]["end_qty"].ToString());
					exSheet.Cells[7 + i, 17].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 17].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_end_qty = tt_end_qty +double.Parse( dtl.Rows[i]["end_qty"].ToString());
				}
			if(dtl.Rows[i]["out_price"].ToString() !="")
				{
					exSheet.Cells[7 + i, 18].Value  = double.Parse( dtl.Rows[i]["out_price"].ToString()) ; // / double.Parse( dtl.Rows[i]["end_qty"].ToString());
					exSheet.Cells[7 + i, 18].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 18].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_end_price = tt_end_price+double.Parse( dtl.Rows[i]["end_price"].ToString());
				}
			if(dtl.Rows[i]["end_amt"].ToString() !="")
				{
					exSheet.Cells[7 + i, 19].Value  =double.Parse( dtl.Rows[i]["end_amt"].ToString());
					exSheet.Cells[7 + i, 19].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[7 + i, 19].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_end_amt = tt_end_amt +double.Parse( dtl.Rows[i]["end_amt"].ToString());
				}
			
}
		
		exSheet.Cells[7 + l_dtl_cnt, 10].Value  =tt_begin_amt;
		exSheet.Cells[7 + l_dtl_cnt, 10].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[7 + l_dtl_cnt, 10].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[7 + l_dtl_cnt, 13].Value  =tt_in_amt;
		exSheet.Cells[7 + l_dtl_cnt, 13].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[7 + l_dtl_cnt, 13].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[7 + l_dtl_cnt, 16].Value  =tt_out_amt;
		exSheet.Cells[7 + l_dtl_cnt, 16].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[7 + l_dtl_cnt, 16].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[7 + l_dtl_cnt, 19].Value  =tt_end_amt;
		exSheet.Cells[7 + l_dtl_cnt, 19].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[7 + l_dtl_cnt, 19].HorizontalAlignment = XlHAlign.xlHAlignRight;
		/*tt_begin_qty  tt_lost_no tt_begin_amt tt_in_qty tt_in_amt tt_out_qty tt_out_amt
				tt_end_qty tt_end_price tt_end_amt*/
		
		//exSheet.UsedRange.Rows.Autofit();
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        exBook.SaveAs(TempFile);
      // ESysLib.ExcelToPdf(TempFile);
       // string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();

    }
}
