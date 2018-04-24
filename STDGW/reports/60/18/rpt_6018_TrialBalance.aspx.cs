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

public partial class rpt_6018_TrialBalance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("GENUWIN");
		string l_com_pk = Request["p_com_pk"];
		string l_lang = Request["p_lang"];
		string l_date_fr = Request["p_date_fr"];  
	    string l_date_to = Request["p_date_to"];
		string l_status = Request["p_status"];
		string l_current = Request["p_current"];  
	    string l_rate = Request["p_rate"];
		string l_level = Request["p_level"];
		string l_possum = Request["p_possum"];  
	    string l_accd = Request["p_accd"];
		string l_check = Request["p_check"];
		string l_pacctype = Request["p_pacctype"];  
							
        string TemplateFile = "rpt_6018_TrialBalance.xls";
        string TempFile = "../../../system/temp/rpt_6018_TrialBalance_" + Session["User_ID"].ToString() + ".xls";
     
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
		para = "'" + l_com_pk +"','" +l_lang+ "','"+l_date_fr+ "','"+l_date_to+"','"+l_status+"','"+l_current+"','"+l_rate+"','"+l_level+"','"+l_possum+"','"+l_accd+"','"+l_check+"','"+l_pacctype+"'"; 
		para1 = "'" +l_com_pk +"'";
	    dt = ESysLib.TableReadOpenCursor("GENUWIN.ac_rpt_60180120_trial_bl", para);
		//dt_mst = ESysLib.TableReadOpenCursor("GENUWIN.ac_rpt_60090080_ap_balance_mst", para); 
		 
        //-----header--- 
		/* p_com_pk             number,
                                p_lang              varchar2,
                                p_date_fr           varchar2,
                                p_date_to           varchar2,
                                p_status            varchar2,
                                p_current           varchar2,
                                p_rate              varchar2,
                                p_level             varchar2,
                                p_possum            varchar2,
                                p_accd              varchar2,
                                p_check             varchar2,
                                p_pacctype             varchar2,*/  

        //---end--header---
        //--set-----DataBind--in---Master---
		/*
		if (dt_mst.Rows.Count == 0)
        {
            exSheet.Cells[3, 3].Value = "There is not data!";

        }
        if (dt_mst.Rows.Count > 0)   
        {
			exSheet.Cells[1, 1].Value  = " Company : " + dt_mst.Rows[0]["PARTNER_NAME"].ToString();
			exSheet.Cells[2, 1].Value  = " Address : " + dt_mst.Rows[0]["addr1"].ToString();
			exSheet.Cells[3, 3].Value = dt_mst.Rows[0]["p_type"].ToString();
			exSheet.Cells[3, 6].Value = "Voucher No: "+dt_mst.Rows[0]["p_voucher"].ToString();
			exSheet.Cells[3, 10].Value = dt_mst.Rows[0]["p_seq"].ToString();
			exSheet.Cells[3, 12].Value = dt_mst.Rows[0]["p_invoice_no"].ToString();
			exSheet.Cells[2, 8].Value  = ": " + dt_mst.Rows[0]["p_date_fr"].ToString()+" ~ "+dt_mst.Rows[0]["p_date_to"].ToString();
			
        }
		*/
		//------------------
		
        for (int l_addrow =1; l_addrow < dt.Rows.Count ; l_addrow++)
        {
            exSheet.Range["A10"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------------------------
		int l_dt_cnt = dt.Rows.Count;
		int j=0;
		double tt_tr_famt = 0,tt_tr_amt = 0, tt_pay_famt = 0,
               tt_pay_amt = 0,tt_balance_famt = 0,tt_balance_amt = 0;
		for (int i = 0; i < dt.Rows.Count;i++)
		{
		
                 
             //     , '' ac_cd, '' ac_nm1, '' AC_KNM, '' AC_LNM, ''PRN_LEVEL
			exSheet.Cells[8 + i, 1].Value =dt.Rows[i]["ac_cd"].ToString();
			exSheet.Cells[8 + i, 2].Value  =  dt.Rows[i]["AC_LNM"].ToString();
			exSheet.Cells[8 + i, 3].Value  =  dt.Rows[i]["ac_nm1"].ToString();
			exSheet.Cells[8 + i, 4].Value  =  dt.Rows[i]["AC_KNM"].ToString();
			exSheet.Cells[8 + i, 5].Value  = "Level "+dt.Rows[i]["PRN_LEVEL"].ToString();
			
			
		
			if (dt.Rows[i]["dr_bl"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 6].Value  =double.Parse( dt.Rows[i]["dr_bl"].ToString());
					exSheet.Cells[8 + i, 6].NumberFormat = "#,##0";
					exSheet.Cells[8 + i, 6].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_tr_famt +=double.Parse( dt.Rows[i]["dr_bl"].ToString());
				}
			if (dt.Rows[i]["dr_acc"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 7].Value  =double.Parse( dt.Rows[i]["dr_acc"].ToString());
					exSheet.Cells[8 + i, 7].NumberFormat = "#,##0";
					exSheet.Cells[8 + i, 7].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_tr_famt +=double.Parse( dt.Rows[i]["dr_bl"].ToString());
				}
			if (dt.Rows[i]["dr_bl"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 8].Value  =double.Parse( dt.Rows[i]["dr_bl"].ToString());
					exSheet.Cells[8 + i, 8].NumberFormat = "#,##0";
					exSheet.Cells[8 + i, 8].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_tr_famt +=double.Parse( dt.Rows[i]["dr_bl"].ToString());
				}
			if (dt.Rows[i]["cr_acc"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 9].Value  =double.Parse( dt.Rows[i]["cr_acc"].ToString());
					exSheet.Cells[8 + i, 9].NumberFormat = "#,##0";
					exSheet.Cells[8 + i, 9].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_tr_famt +=double.Parse( dt.Rows[i]["dr_bl"].ToString());
				}
			if (dt.Rows[i]["dr_acc1"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 10].Value  =double.Parse( dt.Rows[i]["dr_acc1"].ToString());
					exSheet.Cells[8 + i, 10].NumberFormat = "#,##0";
					exSheet.Cells[8 + i, 10].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_tr_famt +=double.Parse( dt.Rows[i]["dr_bl"].ToString());
				}
			if (dt.Rows[i]["cr_acc1"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 11].Value  =double.Parse( dt.Rows[i]["cr_acc1"].ToString());
					exSheet.Cells[8 + i, 11].NumberFormat = "#,##0";
					exSheet.Cells[8 + i, 11].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_tr_famt +=double.Parse( dt.Rows[i]["dr_bl"].ToString());
				}
			if (dt.Rows[i]["dr_bl1"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 12].Value  =double.Parse( dt.Rows[i]["dr_bl1"].ToString());
					exSheet.Cells[8 + i, 12].NumberFormat = "#,##0";
					exSheet.Cells[8 + i, 12].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_tr_famt +=double.Parse( dt.Rows[i]["dr_bl"].ToString());
				}
			if (dt.Rows[i]["cr_bl1"].ToString() !="")
				{
					
					exSheet.Cells[8 + i, 13].Value  =double.Parse( dt.Rows[i]["cr_bl1"].ToString());
					exSheet.Cells[8 + i, 13].NumberFormat = "#,##0";
					exSheet.Cells[8 + i, 13].HorizontalAlignment = XlHAlign.xlHAlignRight;
					//tt_tr_famt +=double.Parse( dt.Rows[i]["cr_bl1"].ToString());
				}
				
			
		}
		
					
		

		
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