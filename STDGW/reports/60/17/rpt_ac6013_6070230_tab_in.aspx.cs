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

public partial class rpt_ac6013_6070230_tab_in : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		
       // ESysLib.SetUser("BAGUETTE");  
		//ESysLib.SetUser(Session["APP_DBUSER"].ToString());  
		// Session["APP_DBUSER"]
        string TemplateFile = "rpt_ac6013_6070230_tab_in.xls";
        string TempFile = "../../../system/temp/rpt_ac6013_6070230_tab_in" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string l_compk = Request["p_compk"]; 
		string l_from_dt = Request["p_from_dt"];  
	    string l_to_dt = Request["p_to_dt"];
		string l_grp_item_pk = Request["p_grp_item_pk"];
		string l_item_cd = Request["p_item_cd"]; 
		string l_item_nm = Request["p_item_nm"];
	    string l_acc_pk = Request["p_acc_pk"];	
		string l_wh_pk = Request["p_wh_pk"];
		string l_tac_abplcenter_pk = Request["p_tac_abplcenter_pk"];
	    string l_asset_yn = Request["p_asset_yn"];	
		string l_form = Request["p_form"];		
		
		string l_date_from_text = Request["p_from_text"];  
		string l_date_to_text = Request["p_to_text"];
		
		string l_purion_text = Request["p_purion_text"];
		string l_form_text = Request["p_form_text"];
		
		string para = "'"+l_compk+"','"+l_from_dt+"','"+l_to_dt+"','"+l_grp_item_pk+"','"+l_item_cd+"','"+l_item_nm+"','"+l_acc_pk+"','"+l_wh_pk+"','"+l_tac_abplcenter_pk+"','"+l_asset_yn+"','"+l_form+"'";
		
		//Response.Write(para);
		//Response.End();
		DataTable dt = ESysLib.TableReadOpenCursor("sp_rpt_fmgf00220_mst",para);
		DataTable dtl = ESysLib.TableReadOpenCursor("sp_sel_fmgf00220_3",para);
		
		exSheet.Cells[2, 8].Value = "From : "+l_date_to_text+"  to: "+l_date_to_text;
		
		if (dt.Rows.Count == 0)
		{
            exSheet.Cells[3, 3].Value = "There is not data!";
		}
		if (dt.Rows.Count > 0)   
        {
			exSheet.Cells[1, 1].Value  =dt.Rows[0]["PARTNER_NAME"].ToString();
			exSheet.Cells[2, 1].Value  ="Address : "+dt.Rows[0]["ADDR1"].ToString();
			exSheet.Cells[3, 1].Value  ="Mã Số Thuế: "+dt.Rows[0]["TAX_CODE"].ToString();
			exSheet.Cells[4, 1].Value  =dt.Rows[0]["AC_CD"].ToString()+"    "+dt.Rows[0]["AC_NM"].ToString();
			
			//exSheet.Cells[3, 6].Value  =" PROJECT  :  "+dt5.Rows[0]["PROJECTCODE"].ToString()+" - "+dt5.Rows[0]["PROJECTNAME"].ToString();
			//exSheet.Cells[4, 2].Value  =":  "+dt5.Rows[0]["PARTNER_ID"].ToString()+"  -   "+dt5.Rows[0]["PARTNER_NM2"].ToString();
        }
		
		for (int l_addrow =1; l_addrow < dtl.Rows.Count ; l_addrow++)
        {
            exSheet.Range["A9"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------------------------
		int l_dtl_cnt = dtl.Rows.Count;
		int k=0;
		double tt_ap_qty = 0, tt_ap_uprice = 0, tt_ap_trfamt = 0, tt_ap_tramt = 0,
		tt_apvat_famt = 0,tt_apvat_amt= 0, tt_tax_famt= 0, tt_tax_amt= 0;		
		for (int i = 0; i < dtl.Rows.Count;i++)
        {
			exSheet.Cells[8 + i, 1].Value =dtl.Rows[i]["AP_Other"].ToString();
			exSheet.Cells[8 + i, 2].Value = dtl.Rows[i]["voucherno"].ToString();
			exSheet.Cells[8 + i, 2].HorizontalAlignment = XlHAlign.xlHAlignLeft;
			
			exSheet.Cells[8 + i, 3].Value = dtl.Rows[i]["tr_dateto"].ToString();
			exSheet.Cells[8 + i, 3].HorizontalAlignment = XlHAlign.xlHAlignRight;
			exSheet.Cells[8 + i, 4].Value = dtl.Rows[i]["item_code"].ToString();
			exSheet.Cells[8 + i, 4].HorizontalAlignment = XlHAlign.xlHAlignRight;
			exSheet.Cells[8 + i, 5].Value = dtl.Rows[i]["item_name"].ToString();
		
			exSheet.Cells[8 + i, 6].Value = dtl.Rows[i]["uom"].ToString();
			if(dtl.Rows[i]["ap_qty"].ToString() !="")
				{
					exSheet.Cells[8 + i, 7].Value  =double.Parse( dtl.Rows[i]["ap_qty"].ToString());
					exSheet.Cells[8 + i, 7].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[8 + i, 7].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_ap_qty = tt_ap_qty +double.Parse( dtl.Rows[i]["ap_qty"].ToString());
				}
			if(dtl.Rows[i]["ap_uprice"].ToString() !="")
				{
					exSheet.Cells[8 + i, 8].Value  =double.Parse( dtl.Rows[i]["ap_uprice"].ToString());
					exSheet.Cells[8 + i, 8].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[8 + i, 8].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_ap_uprice = tt_ap_uprice +double.Parse( dtl.Rows[i]["ap_uprice"].ToString());
				} 
			if(dtl.Rows[i]["ap_trfamt"].ToString() !="")
				{
					exSheet.Cells[8 + i, 9].Value  =double.Parse( dtl.Rows[i]["ap_trfamt"].ToString());
					exSheet.Cells[8 + i, 9].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[8 + i, 9].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_ap_trfamt = tt_ap_trfamt +double.Parse( dtl.Rows[i]["ap_trfamt"].ToString());
				} 
			if(dtl.Rows[i]["ap_tramt"].ToString() !="")
				{
					exSheet.Cells[8 + i, 10].Value  =double.Parse( dtl.Rows[i]["ap_tramt"].ToString());
					exSheet.Cells[8 + i, 10].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[8 + i, 10].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_ap_tramt = tt_ap_tramt +double.Parse( dtl.Rows[i]["ap_tramt"].ToString());
				} 
			if(dtl.Rows[i]["apvat_famt"].ToString() !="")
				{
					exSheet.Cells[8 + i, 11].Value  =double.Parse( dtl.Rows[i]["apvat_famt"].ToString());
					exSheet.Cells[8 + i, 11].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[8 + i, 11].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_apvat_famt = tt_apvat_famt +double.Parse( dtl.Rows[i]["apvat_famt"].ToString());
				} 
			if(dtl.Rows[i]["apvat_amt"].ToString() !="")
				{
					exSheet.Cells[8 + i, 12].Value  =double.Parse( dtl.Rows[i]["apvat_amt"].ToString());
					exSheet.Cells[8 + i, 12].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[8 + i, 12].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_apvat_amt = tt_apvat_amt +double.Parse( dtl.Rows[i]["apvat_amt"].ToString());
				}
			if(dtl.Rows[i]["import_tax_famt"].ToString() !="")
				{
					exSheet.Cells[8 + i, 13].Value  =double.Parse( dtl.Rows[i]["import_tax_famt"].ToString());
					exSheet.Cells[8 + i, 13].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[8 + i, 13].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_tax_famt = tt_tax_famt +double.Parse( dtl.Rows[i]["import_tax_famt"].ToString());
				}
			if(dtl.Rows[i]["import_tax_amt"].ToString() !="")
				{
					exSheet.Cells[8 + i, 14].Value  =double.Parse( dtl.Rows[i]["import_tax_amt"].ToString());
					exSheet.Cells[8 + i, 14].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
					exSheet.Cells[8 + i, 14].HorizontalAlignment = XlHAlign.xlHAlignRight;
					tt_tax_amt = tt_tax_amt +double.Parse( dtl.Rows[i]["import_tax_amt"].ToString());
				}
			
			
			exSheet.Cells[8 + i, 15].Value = dtl.Rows[i]["pl_cd"].ToString();
			exSheet.Cells[8 + i, 16].Value = dtl.Rows[i]["pl_nm"].ToString();
			
			exSheet.Cells[8 + i, 17].Value = dtl.Rows[i]["partner_id"].ToString();
			exSheet.Cells[8 + i, 18].Value = dtl.Rows[i]["partner_name"].ToString();
			exSheet.Cells[8 + i, 19].Value = dtl.Rows[i]["invoice_no"].ToString();
			exSheet.Cells[8 + i, 19].HorizontalAlignment = XlHAlign.xlHAlignRight;
			exSheet.Cells[8 + i, 20].Value = dtl.Rows[i]["invoice_date_"].ToString();
			exSheet.Cells[8 + i, 20].HorizontalAlignment = XlHAlign.xlHAlignRight;
			exSheet.Cells[8 + i, 21].Value = dtl.Rows[i]["remark2"].ToString();
			exSheet.Cells[8 + i, 21].HorizontalAlignment = XlHAlign.xlHAlignLeft;
		}
		//tt_ap_qty tt_ap_uprice tt_ap_trfamt tt_ap_tramt tt_apvat_famt,tt_apvat_amt tt_tax_famt tt_tax_amt
		
		exSheet.Cells[8 + l_dtl_cnt, 7].Value  =tt_ap_qty;
		exSheet.Cells[8 + l_dtl_cnt, 7].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[8 + l_dtl_cnt, 7].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[8 + l_dtl_cnt, 8].Value  =tt_ap_uprice;
		exSheet.Cells[8 + l_dtl_cnt, 8].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[8 + l_dtl_cnt, 8].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[8 + l_dtl_cnt, 9].Value  =tt_ap_trfamt;
		exSheet.Cells[8 + l_dtl_cnt, 9].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[8 + l_dtl_cnt, 9].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[8 + l_dtl_cnt, 10].Value  =tt_ap_tramt;
		exSheet.Cells[8 + l_dtl_cnt, 10].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[8 + l_dtl_cnt, 10].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[8 + l_dtl_cnt, 11].Value  =tt_apvat_famt;
		exSheet.Cells[8 + l_dtl_cnt, 11].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[8 + l_dtl_cnt, 11].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[8 + l_dtl_cnt, 12].Value  =tt_apvat_amt;
		exSheet.Cells[8 + l_dtl_cnt, 12].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[8 + l_dtl_cnt, 12].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[8 + l_dtl_cnt, 13].Value  =tt_tax_famt;
		exSheet.Cells[8 + l_dtl_cnt, 13].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[8 + l_dtl_cnt, 13].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.Cells[8 + l_dtl_cnt, 14].Value  =tt_tax_amt;
		exSheet.Cells[8 + l_dtl_cnt, 14].NumberFormat = "#,##0.00;[Red] (#,##0.00)";
		exSheet.Cells[8 + l_dtl_cnt, 14].HorizontalAlignment = XlHAlign.xlHAlignRight;
		
		exSheet.UsedRange.Rows.Autofit();
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
