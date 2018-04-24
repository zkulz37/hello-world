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

public partial class rpt_fmgf00220_Sum_Out_Inv : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		
		ESysLib.SetUser("acnt");
		string para="";
		string l_com_pk = "", l_from_dt = "", l_to_dt = "", l_item_cd = "", l_acc_pk = "", l_item_nm = "", l_tac_abplcenter_pk = "", l_wh_pk = "";
		l_com_pk = Request["p_com_pk"];
		l_from_dt = Request["p_from_dt"];
		l_to_dt = Request["p_to_dt"];	
		l_item_cd =  Request["p_item_cd"];	
		l_acc_pk = Request["p_acc_pk"];
		l_item_nm = Request["p_item_nm"];
		l_tac_abplcenter_pk = Request["p_tac_abplcenter_pk"];
		l_wh_pk = Request["p_wh_pk"];
		para = "'" + l_com_pk + "', '" + l_from_dt + "', '" + l_to_dt + "', '" + l_item_cd + "', '" + l_acc_pk + "','" + l_item_nm + "','" + l_tac_abplcenter_pk + "','" + l_wh_pk + "'";
        string TemplateFile = "rpt_fmgf00220_Sum_Out_Inv.xls";
        string TempFile = "../../../system/temp/rpt_fmgf00220_Sum_Out_Inv_"+ Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file

       
        DataTable dtDetail = ESysLib.TableReadOpenCursor("acnt.sp_rpt_fmgf00220_sum_out_inv", para);

        //-----header---

        //---end--header---
        //--set-----DataBind--in---Master--- Prepared, as at 
		 exSheet.Cells[5, 1].Value = "Period from "+dtDetail.Rows[0]["date_para"].ToString();
		 exSheet.Cells[15, 18].Value = "Prepared, as at  "+ dtDetail.Rows[0]["date_para"].ToString();
        ////end-set-----DataBind--in---Master---

       for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A11"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent
		int l_cnt = dtDetail.Rows.Count;
		double l_total_begin_qty=0,l_total_begin_amt=0,l_total_ac_cd=0,l_total_end_qty=0,l_total_end_amt=0,l_total_dr_out_qty=0,l_total_ot_in_amt=0,l_total_ot_out_qty=0,l_total_dr_in_amt=0,l_total_dr_in_qty=0,l_total_dr_out_amt=0,l_total_ot_in_qty=0;						
		double l_total_ot_out_amt = 0, l_total_qty_ot_out = 0 ;
        for (int l_row = 0; l_row < dtDetail.Rows.Count; l_row++)
        {  
			exSheet.Cells[10 + l_row, 1].Value = dtDetail.Rows[l_row ]["item_code"];
			exSheet.Cells[10 + l_row, 2].Value = dtDetail.Rows[l_row ]["item_name"];
			exSheet.Cells[10 + l_row, 3].Value = dtDetail.Rows[l_row ]["wh_name"];
			exSheet.Cells[10 + l_row, 4].Value = dtDetail.Rows[l_row ]["qty1"];
			exSheet.Cells[10 + l_row, 5].Value = dtDetail.Rows[l_row ]["amt1"];
			exSheet.Cells[10 + l_row, 6].Value = dtDetail.Rows[l_row ]["qty2"];
			exSheet.Cells[10 + l_row, 7].Value = dtDetail.Rows[l_row ]["amt2"];
			exSheet.Cells[10 + l_row, 8].Value = dtDetail.Rows[l_row ]["qty3"];
			exSheet.Cells[10 + l_row, 9].Value = dtDetail.Rows[l_row ]["amt3"];
			exSheet.Cells[10 + l_row, 10].Value = dtDetail.Rows[l_row ]["qty4"];
			exSheet.Cells[10 + l_row, 11].Value = dtDetail.Rows[l_row ]["amt4"];
			exSheet.Cells[10 + l_row, 12].Value = dtDetail.Rows[l_row ]["qty5"];
			exSheet.Cells[10 + l_row, 13].Value = dtDetail.Rows[l_row ]["amt5"];
			exSheet.Cells[10 + l_row, 14].Value = dtDetail.Rows[l_row ]["qty6"];
			exSheet.Cells[10 + l_row, 15].Value = dtDetail.Rows[l_row ]["amt6"];
			exSheet.Cells[10 + l_row, 16].Value = dtDetail.Rows[l_row ]["qty7"];
			exSheet.Cells[10 + l_row, 17].Value = dtDetail.Rows[l_row ]["amt7"];
			exSheet.Cells[10 + l_row, 18].Value = dtDetail.Rows[l_row ]["qty8"];
			exSheet.Cells[10 + l_row, 19].Value = dtDetail.Rows[l_row ]["amt8"];
			exSheet.Cells[10 + l_row, 20].Value = dtDetail.Rows[l_row ]["qty9"];
			exSheet.Cells[10 + l_row, 21].Value = dtDetail.Rows[l_row ]["amt9"];
			exSheet.Cells[10 + l_row, 22].Value = dtDetail.Rows[l_row ]["qty10"];
			exSheet.Cells[10 + l_row, 23].Value = dtDetail.Rows[l_row ]["amt10"];
			exSheet.Cells[10 + l_row, 24].Value = dtDetail.Rows[l_row ]["qty11"];
			exSheet.Cells[10 + l_row, 25].Value = dtDetail.Rows[l_row ]["amt11"];
			exSheet.Cells[10 + l_row, 26].Value = dtDetail.Rows[l_row ]["qty12"];
			exSheet.Cells[10 + l_row, 27].Value = dtDetail.Rows[l_row ]["amt12"];
			exSheet.Cells[10 + l_row, 28].Value = double.Parse(dtDetail.Rows[l_row ]["qty1"].ToString())+double.Parse(dtDetail.Rows[l_row]["qty2"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["qty3"].ToString())+double.Parse(dtDetail.Rows[l_row]["qty4"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["qty5"].ToString())+double.Parse(dtDetail.Rows[l_row]["qty6"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["qty7"].ToString())+double.Parse(dtDetail.Rows[l_row]["qty8"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["qty9"].ToString())+double.Parse(dtDetail.Rows[l_row]["qty10"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["qty11"].ToString())+double.Parse(dtDetail.Rows[l_row]["qty12"].ToString());
			exSheet.Cells[10 + l_row, 29].Value = double.Parse(dtDetail.Rows[l_row ]["amt1"].ToString())+double.Parse(dtDetail.Rows[l_row]["amt2"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["amt3"].ToString())+double.Parse(dtDetail.Rows[l_row]["amt4"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["amt5"].ToString())+double.Parse(dtDetail.Rows[l_row]["amt6"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["amt7"].ToString())+double.Parse(dtDetail.Rows[l_row]["amt8"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["amt9"].ToString())+double.Parse(dtDetail.Rows[l_row]["amt10"].ToString())
													+double.Parse(dtDetail.Rows[l_row]["amt11"].ToString())+double.Parse(dtDetail.Rows[l_row]["amt12"].ToString());
			exSheet.Cells[10 + l_row, 30].Value = dtDetail.Rows[l_row ]["ac_cd"];
        }
		//exSheet.Cells[11 + l_cnt, 4].Value=l_total_begin_qty;
		//exSheet.Cells[11 + l_cnt, 5].Value=l_total_begin_amt;
		//exSheet.Cells[11 + l_cnt, 6].Value=l_total_dr_in_qty;
		//exSheet.Cells[11 + l_cnt, 7].Value=l_total_dr_in_amt;
		//exSheet.Cells[11 + l_cnt, 8].Value=l_total_ot_in_qty;
		//exSheet.Cells[11 + l_cnt, 9].Value=l_total_ot_in_amt;
		//exSheet.Cells[11 + l_cnt, 10].Value=l_total_ot_out_qty;
		//exSheet.Cells[11 + l_cnt, 11].Value=l_total_dr_out_amt;
		//exSheet.Cells[11 + l_cnt, 12].Value=l_total_qty_ot_out ;
		//exSheet.Cells[11 + l_cnt, 13].Value=l_total_ot_out_amt ;
		//exSheet.Cells[11 + l_cnt, 14].Value=l_total_end_qty;
		//exSheet.Cells[11 + l_cnt, 15].Value=l_total_end_amt;
		

        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        // hide row firts
        range = exSheet.Range["A1"];
        // hide row A6
        range.Rows.Hidden = true;
        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/
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