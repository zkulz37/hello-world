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

public partial class rpt_60080340_trial_bl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		
		string l_tco_company_pk = Request["p_tco_company_pk"]; 
		string l_lang = Request["p_lang"];  
		string l_date_fr = Request["p_date_fr"];
		string l_date_to = Request["p_date_to"];
		string l_status = Request["p_status"];  
		string l_level = Request["p_level"];
		string l_possum = Request["p_possum"];
		string l_accd 	 = Request["p_accd"]; 
		string l_pacctype = Request["p_pacctype"];  
		string l_pl_cd = Request["p_pl_cd"];
		string l_plc_cd 	 = Request["p_plc_cd"]; 
		
		
		string l_date_from_text = Request["p_from_text"];  
		string l_date_to_text = Request["p_to_text"];
		//string l_text_ccy = Request["p_ccy"];
		string l_lstAccType 	 = Request["p_lstAccType"]; 
	
		
        string TemplateFile = "rpt_60080340_trial_bl.xls";
        string TempFile = "../../../system/temp/rpt_60080340_trial_bl_" + Session["User_ID"].ToString() + ".xls";
		
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
        para="'" + l_tco_company_pk + "','" + l_lang  + "','" +l_date_fr + "','" + l_date_to + "','" + l_status + "','" + l_level + "','" + l_possum + "','" + l_accd + "','" + l_pacctype+ "','" + l_pl_cd+ "','" + l_plc_cd + "'";
		para1= "'" + l_tco_company_pk+"'";
		dt_mst = ESysLib.TableReadOpenCursor("AC_RPT_60081335_bls", para1);
        dt = ESysLib.TableReadOpenCursor("ac_sel_60080340_detail_pl", para);
		
		
	
		exSheet.Cells[5, 1].Value ="From Date :  " +  l_date_from_text + "  ~  " + l_date_to_text;
		//exSheet.Cells[6, 1].Value ="Unit :  " +l_text_ccy;
		
		//-----------01--------books---
		/*
		if(l_lstAccType=="01")
		{
			range = exSheet.Range["F1:G1"];
			range.Columns.Hidden = true;
		}
		if(l_lstAccType=="01")
		{
			range = exSheet.Range["H1:I1"];
			range.Columns.Hidden = true;
		}
		//---------------02-----books-usd----
		//an cot H1 Va L1 
		if(l_lstAccType=="02")
		{
			range = exSheet.Range["H1:I1"];
			range.Columns.Hidden = true;
		}
		//-------------03----book-won-----
		if(l_lstAccType=="03")
		{
			range = exSheet.Range["F1:G1"];
			range.Columns.Hidden = true;
		}
		//-------------04-----usd----------
		if(l_lstAccType=="04")//USD
		{
			range = exSheet.Range["D1:E1"];
			range.Columns.Hidden = true;
		}
		if(l_lstAccType=="04")//USD
		{
			range = exSheet.Range["H1:I1"];
			range.Columns.Hidden = true;
		}
		//-------------05-----won----------
		if(l_lstAccType=="05")//Book
		{
			range = exSheet.Range["D1:E1"];
			range.Columns.Hidden = true;
		}
		if(l_lstAccType=="05")//Book
		{
			range = exSheet.Range["F1:G1"];
			range.Columns.Hidden = true;
		}
		
		//-------------06---local-eng-vie-won----------
		if(l_lstAccType=="06")//Book
		{
			range = exSheet.Range["D1:E1"];
			range.Columns.Hidden = false;
		}
		if(l_lstAccType=="06")//Book
		{
			range = exSheet.Range["F1:G1"];
			range.Columns.Hidden = false;
		}
		if(l_lstAccType=="06")//Book
		{
			range = exSheet.Range["H1:I1"];
			range.Columns.Hidden = false;
		}
		
		*/
		//---------------------END------------------------
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
		
		
       for (int l_addrow = 1; l_addrow < dt.Rows.Count-1 ; l_addrow++)
        {
            exSheet.Range["A10"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------------------------
		int l_dt_cnt = dt.Rows.Count;
		int k=0;
		for (int i = 1; i < dt.Rows.Count;i++)
        {
			//exSheet.Cells[i+10, 1,i+10, 2].Merge();
			
			exSheet.Cells[8 + i, 1].Value = dt.Rows[i]["ac_cd"].ToString();
			exSheet.Cells[8 + i, 2].Value  =  dt.Rows[i]["ac_nm"].ToString();//Group
			exSheet.Cells[8+ i, 2].HorizontalAlignment = XlHAlign.xlHAlignLeft;
			exSheet.Cells[8 + i, 3].Value  =  dt.Rows[i]["local_nm"].ToString();//itemcode
			exSheet.Cells[8 + i, 3].HorizontalAlignment = XlHAlign.xlHAlignLeft;
			exSheet.Cells[8 + i, 4].Value  =  dt.Rows[i]["kor_nm"].ToString();//itemcode
			exSheet.Cells[8 + i, 4].HorizontalAlignment = XlHAlign.xlHAlignLeft;
			exSheet.Cells[8 + i, 5].Value  =  dt.Rows[i]["pl_cd"].ToString();
			exSheet.Cells[8 + i, 6].Value  =  dt.Rows[i]["pl_nm"].ToString();
			exSheet.Cells[8 + i, 7].Value  =  dt.Rows[i]["plc_cd"].ToString();
			exSheet.Cells[8 + i, 8].Value  =  dt.Rows[i]["plc_nm"].ToString();
			
			
			if (dt.Rows[i]["dr_op"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 9].Value  =double.Parse( dt.Rows[i]["dr_op"].ToString());
					exSheet.Cells[8 + i, 9].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 9].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["cr_op"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 10].Value  =double.Parse( dt.Rows[i]["cr_op"].ToString());
					exSheet.Cells[8 + i, 10].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 10].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			
			if (dt.Rows[i]["dr_ps"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 11].Value  =double.Parse( dt.Rows[i]["dr_ps"].ToString());
					exSheet.Cells[8 + i, 11].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 11].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["cr_ps"].ToString() !="")
				{					
					exSheet.Cells[8 + i, 12].Value  =double.Parse( dt.Rows[i]["cr_ps"].ToString());
					exSheet.Cells[8 + i, 12].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 12].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["dr_acc"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 13].Value  =double.Parse( dt.Rows[i]["dr_acc"].ToString());
					exSheet.Cells[8 + i, 13].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 13].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["cr_acc"].ToString() !="")
				{
					exSheet.Cells[8 + i, 14].Value  =double.Parse( dt.Rows[i]["cr_acc"].ToString());
					exSheet.Cells[8 + i, 14].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 14].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
		
			if (dt.Rows[i]["dr_bl"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 15].Value  =double.Parse( dt.Rows[i]["dr_bl"].ToString());
					exSheet.Cells[8 + i, 15].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 15].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["cr_bl"].ToString() !="")
				{
					exSheet.Cells[8 + i, 16].Value  =double.Parse( dt.Rows[i]["cr_bl"].ToString());
					exSheet.Cells[8 + i, 16].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 16].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			/*
			if (dt.Rows[i]["dr_acc"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 17].Value  =double.Parse( dt.Rows[i]["dr_acc"].ToString());
					exSheet.Cells[8 + i, 17].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 17].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["cr_acc"].ToString() !="")
				{
					exSheet.Cells[8 + i, 18].Value  =double.Parse( dt.Rows[i]["cr_acc"].ToString());
					exSheet.Cells[8 + i, 18].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 18].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}	
				
			if (dt.Rows[i]["dr_acc1"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 19].Value  =double.Parse( dt.Rows[i]["dr_acc1"].ToString());
					exSheet.Cells[8 + i, 19].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 19].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["cr_acc1"].ToString() !="")
				{
					exSheet.Cells[8 + i, 20].Value  =double.Parse( dt.Rows[i]["cr_acc1"].ToString());
					exSheet.Cells[8 + i, 20].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 20].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}	
			if (dt.Rows[i]["dr_bl"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 21].Value  =double.Parse( dt.Rows[i]["dr_bl"].ToString());
					exSheet.Cells[8 + i, 21].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 21].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["cr_bl"].ToString() !="")
				{
					exSheet.Cells[8 + i, 22].Value  =double.Parse( dt.Rows[i]["cr_bl"].ToString());
					exSheet.Cells[8 + i, 22].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 22].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}	
			if (dt.Rows[i]["dr_bl1"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 23].Value  =double.Parse( dt.Rows[i]["dr_bl1"].ToString());
					exSheet.Cells[8 + i, 23].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 23].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}
			if (dt.Rows[i]["cr_bl1"].ToString() !="")
				{
					exSheet.Cells[8 + i, 24].Value  =double.Parse( dt.Rows[i]["cr_bl1"].ToString());
					exSheet.Cells[8 + i, 24].NumberFormat = "#,##0.00";
					exSheet.Cells[8 + i, 24].HorizontalAlignment = XlHAlign.xlHAlignRight;
				}					
			*/
			
			   
              
			
			if (dt.Rows[i]["bold_yn"].ToString() !="")
			{
				if (dt.Rows[i]["bold_yn"].ToString() =="B")
				{
					exSheet.Cells[i + 9,1, i + 8,16].Font.Bold = true;
				}
				if (dt.Rows[i]["bold_yn"].ToString() =="I")
				{
					exSheet.Cells[i + 8,1, i + 8,16].Font.Italic = true;
				}	
						string l_Color = "";
						l_Color = "0X" + dt.Rows[i]["color"].ToString().Substring(6,2) + dt.Rows[i]["color"].ToString().Substring(4,2) + dt.Rows[i]["color"].ToString().Substring(2,2);
						Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
						exSheet.Cells[i + 8,1, i + 8,16].Interior.Color = colorValueFrmHex;
			}
		
		}
		
	
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