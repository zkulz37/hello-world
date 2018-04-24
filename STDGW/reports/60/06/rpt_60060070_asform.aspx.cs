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

public partial class rpt_60060070_asform : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string l_company = ""+Request["Company"];
		string l_date_from = ""+Request["DateFrom"];
		string l_date_to = ""+Request["DateTo"];
		string l_voucher = ""+Request["Voucher"];
		string l_Seq = ""+Request["Seq"];
		string l_Status = ""+Request["Status"];
		string l_bookCcy = ""+Request["BookCcy"];
		string l_lang	= ""+Request["Lang"];
		string l_accountcode = "" + Request["Account"];
		string l_customer = "" + Request["customer"];
		string l_plunit = "" + Request["plunit"];
	    string l_Desc = "" + Request["Desc"];
		string l_Voucher_type = "" + Request["Voucher_type"];
	
        
        string TemplateFile = "rpt_60060070_asform.xls";
        string TempFile = "../../../system/temp/rpt_60060070_asform_" + Session["User_ID"].ToString() + ".xls";
		
	   TemplateFile = Server.MapPath(TemplateFile);
       TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
        //Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;
		string para="'" + l_company + "','" + l_date_from + "','" + l_date_to + "','" + l_accountcode + "','" + l_customer + "','" + l_plunit + "','" + l_Status + "','" + l_voucher + "','" + l_Seq + "','" + l_Desc + "','" + l_lang + "','" + l_Voucher_type + "'";
		DataTable dt_detail = ESysLib.TableReadOpenCursor("ac_sel_60080050_daily_inquiry",para);
		//Response.Write(para);
		//Response.End();
		for (int l_addrow = 2; l_addrow < dt_detail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A6"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        int _row = 4;
		string _tr_date="";
		decimal _trans_dr=0,_trans_cr=0,_book_dr=0,_book_cr=0;
        for (int i = 1; i < dt_detail.Rows.Count; i++)
        {
			if(dt_detail.Rows[i]["trdate"].ToString()!="")
			{
				_tr_date = dt_detail.Rows[i]["trdate"].ToString().Substring(6,2)+"/"+dt_detail.Rows[i]["trdate"].ToString().Substring(4,2)+"/"+dt_detail.Rows[i]["trdate"].ToString().Substring(0,4);
			}
			exSheet.Cells[_row+i, 1].Value = dt_detail.Rows[i]["pk"].ToString();
			exSheet.Cells[_row+i, 2].Value = _tr_date;
			exSheet.Cells[_row+i, 3].Value = dt_detail.Rows[i]["voucherno"].ToString();
			exSheet.Cells[_row+i, 4].Value = dt_detail.Rows[i]["ac_cd"].ToString();
			exSheet.Cells[_row+i, 5].Value = dt_detail.Rows[i]["ac_nm"].ToString();
			exSheet.Cells[_row+i, 6].Value = dt_detail.Rows[i]["tr_amtd"].ToString();
			exSheet.Cells[_row+i, 7].Value = dt_detail.Rows[i]["tr_amtc"].ToString();
			exSheet.Cells[_row+i, 8].Value = dt_detail.Rows[i]["tr_bookd"].ToString();
			exSheet.Cells[_row+i, 9].Value = dt_detail.Rows[i]["tr_bookc"].ToString();
			exSheet.Cells[_row+i, 10].Value = dt_detail.Rows[i]["remark"].ToString();
			exSheet.Cells[_row+i, 11].Value = dt_detail.Rows[i]["remark2"].ToString();
			exSheet.Cells[_row+i, 12].Value = dt_detail.Rows[i]["buspartner_id"].ToString();
			exSheet.Cells[_row+i, 13].Value = dt_detail.Rows[i]["buspartner_lnm"].ToString();
			exSheet.Cells[_row+i, 14].Value = dt_detail.Rows[i]["pl_cd"].ToString();
			exSheet.Cells[_row+i, 15].Value = dt_detail.Rows[i]["pl_nm"].ToString();
			if(dt_detail.Rows[i]["tr_amtd"].ToString().Trim()!="")
			{
				_trans_dr += decimal.Parse(dt_detail.Rows[i]["tr_amtd"].ToString());
			}
			if(dt_detail.Rows[i]["tr_amtc"].ToString().Trim()!="")
			{
				_trans_cr += decimal.Parse(dt_detail.Rows[i]["tr_amtc"].ToString());
			}
			if(dt_detail.Rows[i]["tr_bookd"].ToString().Trim()!="")
			{
				_book_dr += decimal.Parse(dt_detail.Rows[i]["tr_bookd"].ToString());
			}
			if(dt_detail.Rows[i]["tr_bookc"].ToString().Trim()!="")
			{
				_book_cr += decimal.Parse(dt_detail.Rows[i]["tr_bookc"].ToString());
			}
		}
		
		exSheet.Cells[_row + dt_detail.Rows.Count, 6].Value = _trans_dr;
		exSheet.Cells[_row + dt_detail.Rows.Count, 7].Value = _trans_cr;
		exSheet.Cells[_row + dt_detail.Rows.Count, 8].Value = _book_dr;
		exSheet.Cells[_row + dt_detail.Rows.Count, 9].Value = _book_cr;
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