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

public partial class gfbr00040_Woori_PhieuGuiTien_pdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        

        string TemplateFile = "gfbr00040_Woori_PhieuGuiTien_pdf.xls";
        string TempFile = "../../../system/temp/gfbr00040_Woori_PhieuGuiTien_pdf_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

        string p_Seq = Request["Seq"];
    string p_Date = "";
    string p_Month = "";
    string p_Year = "";
    string p_D_Acc_No = "";
    string p_D_Acc_Nm = "";
    string p_D_Add = "";
    string p_D_Bank = "";
    string p_C_Acc_No = "";
    string p_C_Acc_Nm = "";
    string p_C_Add = "";
    string p_C_Bank = "";
    string p_Remark = "";
    string p_So = "";
    
    DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_Date = dt.Rows[0][15].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();
        p_D_Acc_No = dt.Rows[0][24].ToString();
        //p_D_Acc_No = dt.Rows[0][8].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        //p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();
        p_So = dt.Rows[0][11].ToString();
    }

    
    // Response.Write("aa");
        // Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string _str_Amt = "";
    string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][14].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][15].ToString();

        
        
        Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
        }
        //Response.Write(p_Amt);
        //Response.End();
        // p_Ccy = "EUR";
        // p_Amt = "1600.34";
        //p_D_Acc_No = "3456789012";
    }
        //Response.Write(SQL);
        //Response.End();
        //-----header---   

        //---end--header---
        //--set-----DataBind--in---Master---
        
		p_D_Acc_No = p_D_Acc_No.Replace("-","");
		p_D_Acc_No = p_D_Acc_No.Replace(".","");
        p_D_Acc_No = p_D_Acc_No.Replace(" ", "");
		if(p_D_Acc_No.Length >=12)
		{
			
			exSheet.Cells[5, 3].Value = p_D_Acc_No[p_D_Acc_No.Length - 12];
		}
		
		if(p_D_Acc_No.Length >=11)
		{
			exSheet.Cells[5, 4].Value = p_D_Acc_No[p_D_Acc_No.Length - 11];
		}
		if(p_D_Acc_No.Length >=10)
		{
			exSheet.Cells[5, 5].Value = p_D_Acc_No[p_D_Acc_No.Length - 10];
		}
		if(p_D_Acc_No.Length >=9)
		{
			exSheet.Cells[5, 6].Value = p_D_Acc_No[p_D_Acc_No.Length - 9];
		}
		if(p_D_Acc_No.Length >=8)
		{
			exSheet.Cells[5, 7].Value = p_D_Acc_No[p_D_Acc_No.Length - 8];
		}
		if(p_D_Acc_No.Length >=7)
		{
			exSheet.Cells[5, 8].Value = p_D_Acc_No[p_D_Acc_No.Length - 7];
		}
		if(p_D_Acc_No.Length >=6)
		{
			exSheet.Cells[5, 9].Value = p_D_Acc_No[p_D_Acc_No.Length - 6];
		}
		if(p_D_Acc_No.Length >=5)
		{
			exSheet.Cells[5, 10].Value = p_D_Acc_No[p_D_Acc_No.Length - 5];
		}
		if(p_D_Acc_No.Length >=4)
		{
			exSheet.Cells[5, 11].Value = p_D_Acc_No[p_D_Acc_No.Length - 4];
		}
		if(p_D_Acc_No.Length >=3)
		{
			exSheet.Cells[5, 12].Value = p_D_Acc_No[p_D_Acc_No.Length - 3];
		}
		if(p_D_Acc_No.Length >=2)
		{
			exSheet.Cells[5, 13].Value = p_D_Acc_No[p_D_Acc_No.Length - 2];
		}
		if(p_D_Acc_No.Length >=1)
		{
			exSheet.Cells[5, 14].Value = p_D_Acc_No[p_D_Acc_No.Length - 1];
		}
		
		if(p_Ccy=="VND")
		{
			exSheet.Cells[15, 3].Value = p_Amt1;
			
		}
		else 
		{
			exSheet.Cells[15, 3].Value = p_Amt1;
			if(p_Amt.Length >=1)
			{
				exSheet.Cells[15, 17].Value = p_Amt[p_Amt.Length - 1];
			}
			if(p_Amt.Length >=2)
			{
				exSheet.Cells[15, 16].Value = p_Amt[p_Amt.Length - 2];
			}
		}
		
		if(p_Ccy=="VND")
		{
			exSheet.Cells[11, 5].Value = "þ";
			exSheet.Cells[11, 3].Value = "¨";
			exSheet.Cells[11, 7].Value = "¨";
		}
		else if(p_Ccy=="USD")
		{
			exSheet.Cells[11, 5].Value = "¨";
			exSheet.Cells[11, 3].Value = "þ";
			exSheet.Cells[11, 7].Value = "¨";
		}
		else
		{
			exSheet.Cells[11, 5].Value = "¨";
			exSheet.Cells[11, 3].Value = "¨";
			exSheet.Cells[11, 7].Value = "þ";
		}
        exSheet.Cells[9, 3].Value = p_C_Acc_Nm;
        exSheet.Cells[17, 20].Value = p_Date+"/"+p_Month+"/"+p_Year;
        // exSheet.Cells[2, 7].Value = "Voucher No/Số: "+p_voucher_no;
        // exSheet.Cells[3, 7].Value = "Seq: "+l_seq;
        // exSheet.Cells[7, 1].Value = "Date/Ngày : " + p_ngay+"/"+p_thang+"/"+p_nam;

        // exSheet.Cells[9, 5].Value = p_person;
        // exSheet.Cells[10, 4].Value = p_addr;
        // exSheet.Cells[11, 4].Value = p_buspartner_lnm;
        // exSheet.Cells[12, 4].Value = p_remark;
        // exSheet.Cells[13, 4].Value = p_remark2;
        // exSheet.Cells[14, 4].Value = p_fmt_amount;
        // exSheet.Cells[14, 10].Value = p_rate;
        // exSheet.Cells[15, 4].Value = p_amt_vn;
        // exSheet.Cells[16, 4].Value = p_amt_en;
        // exSheet.Cells[17, 4].Value = p_enclose;

        
        //----------------------
        ////end-set-----DataBind--in---Master---

        // for (int l_addrow = 1; l_addrow < dt3.Rows.Count; l_addrow++)
        // {
            // exSheet.Range["H4"].Rows.EntireRow.Insert();//insert row new of sheet

        // }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent
        // decimal l_amtdrcr = 0;
        // for (i = 0; i < dt3.Rows.Count; i++)
        // {
            // tmp1 = dt3.Rows[i][0].ToString();
		    // if(p_book_ccy == "VND")		
			    // tmp2 = dt3.Rows[i][1].ToString();
		    // else
		    // {
			    // l_amtdrcr = decimal.Parse(dt3.Rows[i][2].ToString());
			    // if(l_amtdrcr < 1)
				    // tmp2 = dt3.Rows[i][3].ToString() + l_amtdrcr.ToString();
			    // else
				    // tmp2 = dt3.Rows[i][1].ToString();
		    // }	
		    // if (tmp1=="D")
		    // {
			    // tmp3 = "N&#7907;";
		    // }
		    // else
		    // {
			    // tmp3 = "C&oacute;";
		    // }
            // //if (i == 0)
            // //{
                // exSheet.Cells[4, 7].Value = tmp3 + ":";
                // exSheet.Cells[4, 8].Value = tmp2;
            // //}
            // //else
            // //{
            // //    exSheet.Cells[4 + i, 7].Value = tmp3 + ":";
            // //    exSheet.Cells[4 + i, 8].Value = tmp2;
            // //}
            // //Response.Write(i);
            // //Response.End();
        // }/**/
        //merge cell(column)-- Due time

        // end loop detail not percent

        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
       // range.Rows.Hidden = true;

        // font bold header

        exBook.SaveAs(TempFile);
		ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
        //write out to client broswer
		//System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        //Response.ContentType = "application/pdf";
		Response.ContentType = "application/ms-exSheet";
        //Send file string to client 
		//Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }
}
