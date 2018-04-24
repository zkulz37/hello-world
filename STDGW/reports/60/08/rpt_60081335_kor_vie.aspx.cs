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

public partial class rpt_60081335_kor_vie : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string l_tco_company_pk = Request["p_tco_company_pk"];
		string l_from_month = Request["p_from_month"];  
	    string l_to_month = Request["p_to_month"];
		string l_status = Request["p_status"];
		string l_scale = Request["p_scale"];
		string l_date_from_text = Request["p_from_text"];  
		string l_date_to_text = Request["p_to_text"];
		string l_text_ccy = Request["p_ccy"];
		string l_lang 	 = Request["p_lang"]; 	
		string l_AmountType 	 = Request["p_AmountType"]; 
		
        string TemplateFile = "rpt_60081335_kor_vie.xls";
        string TempFile = "../../../system/temp/rpt_60081335_kor_vie_" + Session["User_ID"].ToString() + ".xls";
		
	   TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
        //Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;
		
        //bind data to excel file
        string para = "";
		string para1 = "";
        DataTable dt,dt_mst;
		para= "'" + l_tco_company_pk +"','"+l_from_month+"','"+l_to_month+"','"+l_status+"','"+l_scale+"'"; 
		para1= "'" + l_tco_company_pk+"'";
		dt_mst = ESysLib.TableReadOpenCursor("AC_RPT_60081335_bls", para1);
        dt = ESysLib.TableReadOpenCursor("ac_sel_60081335_1", para);
		
		
	
		exSheet.Cells[5, 1].Value = " From : " + l_date_from_text + "  ~  " + l_date_to_text;
		exSheet.Cells[6, 1].Value ="Unit :  " +l_text_ccy;
		
		//-- Ẩn hiện cột theo trên from   
		
		
		
		//----------------01----Book && USD---------------		
		if(l_AmountType=="01")
		{
			range = exSheet.Range["G1:H1"];
			range.Columns.Hidden = true;
		}
		if(l_AmountType=="01")
		{
			range = exSheet.Range["I1:J1"];
			range.Columns.Hidden = true;
		}
		//----------------02---Book && USD----------------		
		if(l_AmountType=="02")
		{
			range = exSheet.Range["I1:J1"];
			range.Columns.Hidden = true;
		}
		//----------------03---Book && Won----------------		
		if(l_AmountType=="03")
		{
			range = exSheet.Range["G1:H1"];
			range.Columns.Hidden = true;
		}
		//----------------04------------------------------
		if(l_AmountType=="04")
		{
			range = exSheet.Range["E1:F1"];
			range.Columns.Hidden = true;
		}
		if(l_AmountType=="04")
		{
			range = exSheet.Range["I1:J1"];
			range.Columns.Hidden = true;
		}
		//----------------05--------------------------------
		if(l_AmountType=="05")
		{
			range = exSheet.Range["E1:F1"];
			range.Columns.Hidden = true;
		}
		if(l_AmountType=="05")
		{
			range = exSheet.Range["G1:H1"];
			range.Columns.Hidden = true;
		}
		//----------------06--------------------------------
		if(l_AmountType=="06")
		{
			range = exSheet.Range["E1:F1"];
			range.Columns.Hidden = false;
		}
		if(l_AmountType=="06")
		{
			range = exSheet.Range["G1:H1"];
			range.Columns.Hidden = false;
		}
		if(l_AmountType=="06")
		{
			range = exSheet.Range["I1:J1"];
			range.Columns.Hidden = false;
		}
			
		//-------------End----------------
		
		if (dt_mst.Rows.Count == 0)
        {
            exSheet.Cells[3, 3].Value = "There is not data!";

        }
        if (dt_mst.Rows.Count > 0)   
        {
			exSheet.Cells[1, 1].Value   =  dt_mst.Rows[0]["PARTNER_NAME"].ToString();
			exSheet.Cells[2, 1].Value   =  dt_mst.Rows[0]["ADDR2"].ToString();
			exSheet.Cells[3, 1].Value   =  dt_mst.Rows[0]["TAX_CODE"].ToString();
		}
		 
		
       for (int l_addrow = 1; l_addrow < dt.Rows.Count ; l_addrow++)
        {
            exSheet.Range["A9"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------------------------
		int l_dt_cnt = dt.Rows.Count;
		int k=0;
		for (int i = 0; i < dt.Rows.Count;i++)
        {
			//exSheet.Cells[i+10, 1,i+10, 2].Merge();
			
			exSheet.Cells[8 + i, 1].Value = dt.Rows[i]["prn_acnm"].ToString();
		    exSheet.Cells[8 + i, 2].Value = dt.Rows[i]["prn_kacnm"].ToString();
			exSheet.Cells[8 + i, 3].Value = dt.Rows[i]["code"].ToString();
			exSheet.Cells[8 + i, 4].Value = dt.Rows[i]["header"].ToString();
			
			
			
			
			if (dt.Rows[i]["closing"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 5].Value  =double.Parse( dt.Rows[i]["closing"].ToString());
					exSheet.Cells[8 + i, 5].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 5].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["openning"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 6].Value  =double.Parse( dt.Rows[i]["openning"].ToString());
					exSheet.Cells[8 + i, 6].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 6].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			
			if (dt.Rows[i]["closing_usd"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 7].Value  =double.Parse( dt.Rows[i]["closing_usd"].ToString());
					exSheet.Cells[8 + i, 7].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 7].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["openning_usd"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 8].Value  =double.Parse( dt.Rows[i]["openning_usd"].ToString());
					exSheet.Cells[8 + i, 8].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 8].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["closing_won"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 9].Value  =double.Parse( dt.Rows[i]["closing_won"].ToString());
					exSheet.Cells[8 + i, 9].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 9].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["openning_won"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 10].Value  =double.Parse( dt.Rows[i]["openning_won"].ToString());
					exSheet.Cells[8 + i, 10].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 10].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["font_stype"].ToString() !="")
					{
						if (dt.Rows[i]["font_stype"].ToString() =="B")
						{
							exSheet.Cells[i + 8,1, i + 8,13].Font.Bold = true;
						}
						if (dt.Rows[i]["font_stype"].ToString() =="I")
						{
							exSheet.Cells[i + 8,1, i + 8,13].Font.Italic = true;
						}									
					}
			
		}
		exSheet.UsedRange.Rows.Autofit();
		//exSheet.UsedRange.Rows.Autofit();
		//---end------detail--quatation------
		
        //----------------------
        //end-set-----DataBind--in---Master---

        
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent
     

        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;

        // font bold header

        exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        //string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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