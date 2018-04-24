﻿using System;
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

public partial class rpt_60120120_rpt_VAT_In_new_156 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string p_com = "" + Request["compk"];
		string p_month = "" + Request["month"];
		string p_status = "" + Request["status"];
		string p_vat_rate = "" + Request["vat_rate"]; 
		string p_ccy = "" + Request["ccy"];
		string p_cust_pk = "" + Request["cust_pk"]; 
		string p_acc_pk = "" + Request["acc_pk"];
		string p_invoiceno = "" + Request["invoiceno"];
		string p_ac_cd = "" + Request["ac_cd"];
		string p_tac_hgtrh_pk = "" + Request["txtSeq"];
		string p_voucherno  = "" + Request["voucherno"];
		string p_BalType  = "" + Request["BalType"];
		string p_dtfr  = "" + Request["p_dtfr"];
		string p_dtto  = "" + Request["p_dtto"];
		string p_voucher_type  = "" + Request["voucher_type"];
		string p_Biz_Place = "" + Request["Biz_Place"];
		string l_month = p_month.Substring(4,2);
		string l_year = p_month.Substring(0,4);
		string l_lname ="";
		string l_name ="";
		string l_tax_code ="";
		string l_address ="";
		
		
        string TemplateFile = "rpt_60120120_rpt_VAT_In_new_156.xls";
        string TempFile = "../../../system/temp/rpt_60120120_rpt_VAT_In_new_156_" + Session["User_ID"].ToString() + ".xls";
		
	   TemplateFile = Server.MapPath(TemplateFile);
       TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
        //Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;
		
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
		
		SQL = " SELECT pk, partner_name, partner_lname, addr1 ||addr2||addr3 address, tax_code ";
		SQL += "  FROM tco_company ";
		SQL += " WHERE del_if = 0 AND pk = '" + p_com + "'";
		DataTable dtCom = ESysLib.TableReadOpen(SQL);
		if (dtCom.Rows.Count >0)
		{
			l_name  = dtCom.Rows[0][1].ToString();
			l_lname = dtCom.Rows[0][2].ToString();
			l_address = dtCom.Rows[0][3].ToString();
			l_tax_code = dtCom.Rows[0][4].ToString();
		}
		
		exSheet.Cells["A7"].Value  = "[01] Kỳ tính thuế: tháng "+l_month+" năm "+l_year;
		exSheet.Cells["E8"].Value  = l_lname;
		exSheet.Cells["E9"].Value  = l_tax_code;
        //bind data to excel file
		// Muc (1)
		
		
        string l_parameter = "'" + p_com + "','" + p_month + "','1','ALL','"+p_ccy+"','" + p_status + "','"+p_cust_pk+"','"+p_invoiceno+"','"+p_ac_cd+"','"+p_tac_hgtrh_pk+"','"+p_voucherno+"','"+p_BalType+"','"+p_dtfr+"','"+p_dtto+"','"+p_voucher_type+"','"+p_Biz_Place+"'";
		// Response.Write(l_parameter);
		// Response.End();
		DataTable dt_2 = ESysLib.TableReadOpenCursor("ac_rpt_60120120_in_2", l_parameter);
		
		for (int l_addrow2 = 1; l_addrow2 < dt_2.Rows.Count; l_addrow2++)
        {
            exSheet.Range["A21"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		int _row2 = 20;
		int stt2 = 0;
		decimal NetAmt_Total_2 = 0;
		decimal TaxAmt_Total_2 = 0;
		for (int i = 0; i < dt_2.Rows.Count;i++)
		{
			stt2 += 1;
			exSheet.Cells[_row2 + i, 1].Value = stt2;
			exSheet.Cells[_row2 + i, 2].Value = dt_2.Rows[i]["FORM_NUMBER"].ToString();
			exSheet.Cells[_row2 + i, 3].Value = dt_2.Rows[i]["seri_no"].ToString();
			exSheet.Cells[_row2 + i, 4].Value = dt_2.Rows[i]["invoice_no"].ToString();
			exSheet.Cells[_row2 + i, 5].Value = dt_2.Rows[i]["invoice_date"].ToString();
			exSheet.Cells[_row2 + i, 6].Value = dt_2.Rows[i]["partner_name"].ToString();
			exSheet.Cells[_row2 + i, 7].Value = dt_2.Rows[i]["tax_code"].ToString();
			exSheet.Cells[_row2 + i, 8].Value = dt_2.Rows[i]["tco_ciitem_nm"].ToString();
			if(dt_2.Rows[i]["net_amt"].ToString()!="")
			{
				exSheet.Cells[_row2 + i, 9].Value = decimal.Parse(dt_2.Rows[i]["net_amt"].ToString());
			}
			else
			{
				exSheet.Cells[_row2 + i, 9].Value = "";
			}
			exSheet.Cells[_row2 + i, 10].Value = dt_2.Rows[i]["tax_rate"].ToString();
			if(dt_2.Rows[i]["tax_amt"].ToString()!="")
			{
				exSheet.Cells[_row2 + i, 11].Value = decimal.Parse(dt_2.Rows[i]["tax_amt"].ToString());
			}
			else
			{
				exSheet.Cells[_row2 + i, 11].Value = "";
			}
			exSheet.Cells[_row2 + i, 12].Value = dt_2.Rows[i]["voucherno"].ToString()+" ("+dt_2.Rows[i]["seq"].ToString()+")("+dt_2.Rows[i]["vat_note"].ToString()+")";
			
			if(dt_2.Rows[i]["net_amt"].ToString().Trim()!="")
			{
				NetAmt_Total_2 += decimal.Parse(dt_2.Rows[i]["net_amt"].ToString());
			}
			else
			{
				NetAmt_Total_2 = 0;
			}
			if(dt_2.Rows[i]["tax_amt"].ToString().Trim()!="")
			{
				TaxAmt_Total_2 += decimal.Parse(dt_2.Rows[i]["tax_amt"].ToString());
			}
			else
			{
				TaxAmt_Total_2 = 0;
			}
			exSheet.Cells[21 + i, 9].Value = NetAmt_Total_2;
			exSheet.Cells[21 + i, 11].Value = TaxAmt_Total_2;
		} 
		
//===============================================================================================================================================================		
        DataTable dt = ESysLib.TableReadOpenCursor("ac_rpt_60120120_in", l_parameter);
		
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A18"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		int _row = 17;
		int stt = 0;
		decimal NetAmt_Total_1 = 0;
		decimal TaxAmt_Total_1 = 0;
		for (int i = 0; i < dt.Rows.Count;i++)
		{
			stt += 1;
			exSheet.Cells[_row + i, 1].Value = stt;
			exSheet.Cells[_row + i, 2].Value = dt.Rows[i]["FORM_NUMBER"].ToString();
			exSheet.Cells[_row + i, 3].Value = dt.Rows[i]["seri_no"].ToString();
			exSheet.Cells[_row + i, 4].Value = dt.Rows[i]["invoice_no"].ToString();
			exSheet.Cells[_row + i, 5].Value = dt.Rows[i]["invoice_date"].ToString();
			exSheet.Cells[_row + i, 6].Value = dt.Rows[i]["partner_name"].ToString();
			exSheet.Cells[_row + i, 7].Value = dt.Rows[i]["tax_code"].ToString();
			exSheet.Cells[_row + i, 8].Value = dt.Rows[i]["tco_ciitem_nm"].ToString();
			if(dt.Rows[i]["net_amt"].ToString()!="")
			{
				exSheet.Cells[_row + i, 9].Value = decimal.Parse(dt.Rows[i]["net_amt"].ToString());
			}
			else
			{
				exSheet.Cells[_row + i, 9].Value = "";
			}
			exSheet.Cells[_row + i, 10].Value = dt.Rows[i]["tax_rate"].ToString();
			if(dt.Rows[i]["tax_amt"].ToString()!="")
			{
				exSheet.Cells[_row + i, 11].Value = decimal.Parse(dt.Rows[i]["tax_amt"].ToString());
			}
			else
			{
				exSheet.Cells[_row + i, 11].Value = "";
			}
			exSheet.Cells[_row + i, 12].Value = dt.Rows[i]["voucherno"].ToString()+" ("+dt.Rows[i]["seq"].ToString()+")("+dt.Rows[i]["vat_note"].ToString()+")";
			
			if(dt.Rows[i]["net_amt"].ToString().Trim()!="")
			{
				NetAmt_Total_1 += decimal.Parse(dt.Rows[i]["net_amt"].ToString());
			}
			else
			{
				NetAmt_Total_1 = 0;
			}
			if(dt.Rows[i]["tax_amt"].ToString().Trim()!="")
			{
				TaxAmt_Total_1 += decimal.Parse(dt.Rows[i]["tax_amt"].ToString());
			}
			else
			{
				TaxAmt_Total_1 = 0;
			}
			exSheet.Cells[18 + i, 9].Value = NetAmt_Total_1;
			exSheet.Cells[18 + i, 11].Value = TaxAmt_Total_1;
		} 	
		
		int Mot = 0, Hai = 0;
		Mot = dt.Rows.Count;
		Hai = dt_2.Rows.Count;
		// Response.Write(Mot+"|"+Hai);
		// Response.End();
		if(Mot>1)
		{
			Mot = Mot-1;
		}
		if(Hai>1)
		{
			Hai = Hai-1;
		}
		if(Mot>1||Hai>1)
		{
			exSheet.Cells[32 + Mot + Hai, 9].Value = NetAmt_Total_1 + NetAmt_Total_2;
			exSheet.Cells[33 + Mot + Hai, 9].Value = TaxAmt_Total_1 + TaxAmt_Total_2;
		}
		else
		{
			exSheet.Cells[32, 9].Value = NetAmt_Total_1 + NetAmt_Total_2;
			exSheet.Cells[33, 9].Value = TaxAmt_Total_1 + TaxAmt_Total_2;
		}
		/**/
		//exSheet.UsedRange.Rows.Autofit();
	
		
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