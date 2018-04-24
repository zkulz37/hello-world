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

public partial class rpt_ac0706_payable_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("GENUWIN");
		string l_company = Request["p_company"];
		string l_from = Request["p_from"]; 
		string l_to = Request["p_to"];  
	    string l_voucherno = Request["p_voucherno"];
		string l_vendor_pk = Request["p_vendor_pk"];
		string l_item_pk = Request["p_item_pk"];  
	    string l_project_pk = Request["p_project_pk"];
		string l_delivery = Request["p_delivery"];
		string l_ac_pk = Request["p_ac_pk"];  
	    string l_seq = Request["p_seq"];
        string TemplateFile = "rpt_ac0706_payable_list.xls";
        string TempFile = "../../../system/temp/rpt_ac0706_payable_list_" + Session["User_ID"].ToString() + ".xls";
     
	   TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
       	IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;

        //bind data to excel file
        string para = "";
		string para1 = "";
        DataTable dt,dt_mst;
		para = "'" + l_company +"','" +l_from+ "','"+l_to+ "','"+l_voucherno+"','"+l_vendor_pk+"','"+l_project_pk+"','"+l_delivery+"','"+l_ac_pk+"','"+l_seq+"'"; 
		para1 = "'" +l_com_pk +"'";
	    dt = ESysLib.TableReadOpenCursor("GENUWIN.ac_rpt_60090090_ap_dt", para);
		//dt_mst = ESysLib.TableReadOpenCursor("GENUWIN.ac_rpt_60090080_ap_balance_mst", para); 
		 
        //-----header---   

        //---end--header---
        //--set-----DataBind--in---Master---
		
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
		
		//------------------
		
        for (int l_addrow =0; l_addrow < dt.Rows.Count-1 ; l_addrow++)
        {
            exSheet.Range[6+l_addrow+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------------------------
		int l_dt_cnt = dt.Rows.Count;
		int j=0;
		double tt_tr_famt = 0,tt_tr_amt = 0, tt_pay_famt = 0,
               tt_pay_amt = 0,tt_balance_famt = 0,tt_balance_amt = 0;
		for (int i = 0; i < dt.Rows.Count;i++)
		{
			exSheet.Cells[6 + i, 1].Value =j+1;
			exSheet.Cells[6 + i, 1].HorizontalAlignment = XlHAlign.xlHAlignCenter;
			exSheet.Cells[6 + i, 2].Value  =  dt.Rows[i]["pk"].ToString();//Group
			exSheet.Cells[6 + i, 2].HorizontalAlignment = XlHAlign.xlHAlignCenter;
			exSheet.Cells[6 + i, 3].Value  =  dt.Rows[i]["ac_cd"].ToString();//Group
			exSheet.Cells[6 + i, 3].HorizontalAlignment = XlHAlign.xlHAlignRight;
			exSheet.Cells[6 + i, 4].Value  =  dt.Rows[i]["ac_nm"].ToString();//Group
			exSheet.Cells[6 + i, 4].HorizontalAlignment = XlHAlign.xlHAlignLeft;
			exSheet.Cells[6 + i, 5].Value  =  dt.Rows[i]["cust_no"].ToString();//Group
			exSheet.Cells[6 + i, 5].HorizontalAlignment = XlHAlign.xlHAlignRight;
			exSheet.Cells[6 + i, 6].Value  =  dt.Rows[i]["cust_nm"].ToString();//Group
			exSheet.Cells[6 + i, 6].HorizontalAlignment = XlHAlign.xlHAlignLeft;
			
			exSheet.Cells[6 + i, 7].Value  =  dt.Rows[i]["tr_date"].ToString();
			exSheet.Cells[6 + i, 8].Value  =  dt.Rows[i]["voucherno"].ToString();
			exSheet.Cells[6 + i, 9].Value  =  dt.Rows[i]["serial_no"].ToString();
			exSheet.Cells[6 + i, 10].Value  =  dt.Rows[i]["invoice_date"].ToString();
			exSheet.Cells[6 + i, 11].Value  =  dt.Rows[i]["invoice_no"].ToString();
			exSheet.Cells[6 + i, 12].Value  =  dt.Rows[i]["due_date"].ToString();
			exSheet.Cells[6 + i, 13].Value  =  dt.Rows[i]["tr_ccy"].ToString();
			
			if (dt.Rows[i]["tr_famt"].ToString() !="")
				{
					
					exSheet.Cells[6 + i, 14].Value  =double.Parse( dt.Rows[i]["tr_famt"].ToString());
					exSheet.Cells[6 + i, 14].NumberFormat = "#,##0";
					exSheet.Cells[6 + i, 14].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_tr_famt +=double.Parse( dt.Rows[i]["tr_famt"].ToString());
				}
				
			if (dt.Rows[i]["tr_amt"].ToString() !="")
				{
					
					exSheet.Cells[6 + i, 15].Value  =double.Parse( dt.Rows[i]["tr_amt"].ToString());
					exSheet.Cells[6 + i, 15].NumberFormat = "#,##0";
					exSheet.Cells[6 + i, 15].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_tr_amt += double.Parse( dt.Rows[i]["tr_amt"].ToString());
				}
				
			if (dt.Rows[i]["pay_famt"].ToString() !="")
				{
					
					exSheet.Cells[6 + i, 16].Value  =double.Parse( dt.Rows[i]["pay_famt"].ToString());
					exSheet.Cells[6 + i, 16].NumberFormat = "#,##0";
					exSheet.Cells[6 + i, 16].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_pay_famt += double.Parse( dt.Rows[i]["pay_famt"].ToString());
				}
				
			if (dt.Rows[i]["pay_amt"].ToString() !="")
				{
					
					exSheet.Cells[6 + i, 17].Value  =double.Parse( dt.Rows[i]["pay_amt"].ToString());
					exSheet.Cells[6 + i, 17].NumberFormat = "#,##0";
					exSheet.Cells[6 + i, 17].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_pay_amt += double.Parse( dt.Rows[i]["pay_amt"].ToString());
				}
			if (dt.Rows[i]["balance_famt"].ToString() !="")
				{
					
					exSheet.Cells[6 + i, 18].Value  =double.Parse( dt.Rows[i]["balance_famt"].ToString());
					exSheet.Cells[6 + i, 18].NumberFormat = "#,##0";
					exSheet.Cells[6 + i, 18].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_balance_famt +=double.Parse( dt.Rows[i]["balance_famt"].ToString());
				}
			if (dt.Rows[i]["balance_amt"].ToString() !="")
				{
					
					exSheet.Cells[6 + i, 19].Value  =double.Parse( dt.Rows[i]["balance_amt"].ToString());
					exSheet.Cells[6 + i, 19].NumberFormat = "#,##0";
					exSheet.Cells[6 + i, 19].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_balance_amt +=double.Parse( dt.Rows[i]["balance_amt"].ToString());
				}
			exSheet.Cells[6 + i, 20].Value  =  dt.Rows[i]["tr_remark"].ToString();
			exSheet.Cells[6 + i, 21].Value  =  dt.Rows[i]["tr_remark2"].ToString();
			
			
			j=j+1;
		}
		
					
		exSheet.Cells[6 + l_dt_cnt, 14].Value = tt_tr_famt;
		exSheet.Cells[6 + l_dt_cnt, 14].NumberFormat = "#,##0";
		exSheet.Cells[6 + l_dt_cnt, 14].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[6 + l_dt_cnt, 15].Value = tt_tr_amt;
		exSheet.Cells[6 + l_dt_cnt, 15].NumberFormat = "#,##0";
		exSheet.Cells[6 + l_dt_cnt, 15].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[6 + l_dt_cnt, 16].Value = tt_pay_famt;
		exSheet.Cells[6 + l_dt_cnt, 16].NumberFormat = "#,##0";
		exSheet.Cells[6 + l_dt_cnt, 16].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[6 + l_dt_cnt, 17].Value = tt_pay_amt;
		exSheet.Cells[6 + l_dt_cnt, 17].NumberFormat = "#,##0";
		exSheet.Cells[6 + l_dt_cnt, 17].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[6 + l_dt_cnt, 18].Value = tt_balance_famt;
		exSheet.Cells[6 + l_dt_cnt, 18].NumberFormat = "#,##0";
		exSheet.Cells[6 + l_dt_cnt, 18].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[6 + l_dt_cnt, 19].Value = tt_balance_amt;
		exSheet.Cells[6 + l_dt_cnt, 19].NumberFormat = "#,##0";
		exSheet.Cells[6 + l_dt_cnt, 19].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		
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