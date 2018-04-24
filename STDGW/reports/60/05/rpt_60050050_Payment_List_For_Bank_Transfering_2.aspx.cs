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

public partial class rpt_60050050_Payment_List_For_Bank_Transfering_2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string l_company_pk= ""+ Request["company_pk"];
		string l_seq= ""+ Request["seq"];
		string l_voucher_type= ""+ Request["voucher_type"];
		string l_cust_cd = ""+ Request["cust_cd"];
		string l_status= ""+ Request["status"];
		string l_voucher_no= ""+ Request["voucher_no"];
		string l_Trs_fr= ""+ Request["Trs_fr"];
		string l_Trs_to= ""+ Request["Trs_to"];
		string l_RPPerson=""+ Request["RPPerson"];
		string l_Desc1=""+ Request["Desc1"];
		string l_Desc2=""+ Request["Desc2"];
		string l_DepositNo=""+ Request["DepositNo"];
		
		string l_parameter = "'" + l_company_pk + "', ";
		l_parameter += "'" + l_Trs_fr + "', ";
		l_parameter += "'" + l_Trs_to + "', ";
		l_parameter += "'" + l_cust_cd + "', ";
		l_parameter += "'" + l_status + "', ";
		l_parameter += "'" + l_voucher_no + "', ";
		l_parameter += "'" + l_voucher_type + "', ";
		l_parameter += "'" + l_seq + "', ";
		l_parameter += "'" + l_RPPerson + "', ";
		l_parameter += "'" + l_Desc1 + "', ";
		l_parameter += "'" + l_Desc2 + "', ";
		l_parameter += "'"+l_DepositNo+"' ";
	
        string TemplateFile = "rpt_60050050_Payment_List_For_Bank_Transfering_2.xls";
        string TempFile = "../../../system/temp/rpt_60050050_Payment_List_For_Bank_Transfering_2_" + Session["User_ID"].ToString() + ".xls";
     
	   TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
       	IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;

        //bind data to excel file
        
		
		string p_xls_ccy_format ="";
		string p_bookccy = "";
		string SQL = "SELECT AC_GET_BOOKCCY_ACNT('ACBG0040') FROM DUAL " ;
		DataTable dt_bookccy = ESysLib.TableReadOpen(SQL);

		if (dt_bookccy.Rows.Count >0)
		{	
			p_bookccy = dt_bookccy.Rows[0][0].ToString();
		}
		if (p_bookccy == "VND")
		{
			p_xls_ccy_format = "#,##0";
		}
		else
		{
			p_xls_ccy_format = "#,##0.00";
		}
		
		DataTable dt_detail = ESysLib.TableReadOpenCursor("ac_SEL_60050050_PayList_rpt",l_parameter);
		
        for (int l_addrow =0; l_addrow < dt_detail.Rows.Count-1 ; l_addrow++)
        {
            exSheet.Range[3+l_addrow+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------------------------
		
		
		int l_row = 3;
		for (int i = 0; i < dt_detail.Rows.Count;i++)
		{
			exSheet.Cells[l_row + i, 2].Value  =  dt_detail.Rows[i]["rown"].ToString();
			exSheet.Cells[l_row + i, 3].Value  =  dt_detail.Rows[i]["bank_acc"].ToString();
			exSheet.Cells[l_row + i, 4].Value  =  dt_detail.Rows[i]["Bank_nm"].ToString();
			exSheet.Cells[l_row + i, 5].Value  =  dt_detail.Rows[i]["BEDEFI_NM"].ToString();
			exSheet.Cells[l_row + i, 6].Value  =  decimal.Parse(dt_detail.Rows[i]["BOOKS_AMT"].ToString());
			exSheet.Cells[l_row + i, 7].Value  =  dt_detail.Rows[i]["REMARK2"].ToString();
		}
		/*string Inword = "";
		SQL = "SELECT SUM (NVL (TR_BOOKAMT, 0)) amt_cr FROM tac_hgtrd where del_if = 0 and drcr_type = 'C' and tac_hgtrh_pk = '"+l_seq+"' " ;
		DataTable dt_total = ESysLib.TableReadOpen(SQL);
		if (dt_total.Rows.Count > 0)
        {
			exSheet.Cells["F11"].Value  = decimal.Parse(dt_total.Rows[0]["amt_cr"].ToString());
			exSheet.Cells["F11"].NumberFormat = p_xls_ccy_format;
			
			Inword = CommondLib.Num2VNText(dt_total.Rows[0]["amt_cr"].ToString(), "VND");
			 string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
			 DataTable dt_t = ESysLib.TableReadOpen(SQL3);
			 if (dt_t.Rows.Count > 0)
			 {
				 Inword = dt_t.Rows[0][0].ToString();

			 }
		}
		
		exSheet.Cells["A12"].Value  = "Cộng thành tiền (bằng chữ): "+ Inword;

       
         
		*/
		
		
		
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