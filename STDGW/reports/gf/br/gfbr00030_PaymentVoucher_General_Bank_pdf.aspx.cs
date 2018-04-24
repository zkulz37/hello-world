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

public partial class gfbr00030_PaymentVoucher_General_Bank_pdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        

        string TemplateFile = "gfbr00030_PaymentVoucher_General_Bank_pdf.xls";
        string TempFile = "../../../system/temp/gfbr00030_PaymentVoucher_General_Bank_pdf_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
        string l_seq = "" + Request["seq"];
        string p_table_pk = "" + Request["pv_pk"];
        string p_company_pk = "";
        string p_cmp_name = "";  
        string p_cmp_add = "";
		string p_Debit = "";		  
		string p_Credit = "";
        string p_cmp_taxcode = "";
        string p_voucher_no = "";
        string p_ngay = "";
        string p_thang = "";
        string p_nam = "";
        string p_person = "";
        string p_addr = "";
        string p_remark = "";
        string p_remark2 = "";
        string p_reason = "";
        string p_buspartner_lnm = "";
        string p_enclose = "";
        string SQL = "";
        string p_ccy = "";
        string p_amount = "";
        string p_fmt_amount = "";
        string p_rate = "";
        string p_amt_vn = "";
        string p_amt_en = "";
        string p_book_ccy = "";
        string tmp1 = "";
        string tmp2 = "";
        string tmp3 = "";
        string p_voucher_type = "";
        string p_voucher_name = "PHIẾU CHI";
        int i = 0;
		DataTable dt = ESysLib.TableReadOpenCursor("ac_rpt_gfbr00040_payment_vc", l_seq);
		DataTable dt_footer = ESysLib.TableReadOpenCursor("ac_rpt_gfbr00040_footer_news", l_seq);        
        if (dt.Rows.Count > 0)
        {
            p_book_ccy = dt.Rows[0]["book_ccy"].ToString();       
            p_person = dt.Rows[0]["tr_person"].ToString();
            p_enclose = dt.Rows[0]["tr_enclose"].ToString();
            //p_reason  = dt.Rows[0][3].ToString(); 
            p_addr = dt.Rows[0][6].ToString();
            p_buspartner_lnm = dt.Rows[0][7].ToString();
            //p_voucher_code = dt.Rows[0][3].ToString();        
            p_company_pk = dt.Rows[0]["company_pk"].ToString();
            p_voucher_no = dt.Rows[0]["voucher_no"].ToString();
            p_ngay = dt.Rows[0]["ngay"].ToString();
            p_thang = dt.Rows[0]["thang"].ToString();
            p_nam = dt.Rows[0]["nam"].ToString();
            p_remark = dt.Rows[0]["remark"].ToString();
            p_remark2 = dt.Rows[0]["remark2"].ToString();
            p_voucher_type = dt.Rows[0]["voucher_type"].ToString();       
            p_voucher_name = dt.Rows[0][0].ToString();        
            p_ccy = dt.Rows[0]["ccy"].ToString();
            p_amount = dt.Rows[0]["amount"].ToString();
            p_fmt_amount = dt.Rows[0]["fmt_amount"].ToString();
            p_rate = dt.Rows[0]["rate"].ToString();
			p_amt_vn = CommondLib.Num2VNText(p_amount, p_ccy);
			p_amt_en = CommondLib.Num2EngText(p_amount, p_ccy);
            p_cmp_name = dt.Rows[0]["cmp_name"].ToString();
            p_cmp_add = dt.Rows[0]["cmp_add"].ToString();
            p_cmp_taxcode = dt.Rows[0]["cmp_taxcode"].ToString();        
			p_Debit = dt.Rows[0]["Debit"].ToString();
		
			p_Credit = dt.Rows[0]["Credit"].ToString();
		}        
        exSheet.Cells[1, 1].Value = p_cmp_name;
        exSheet.Cells[2, 1].Value = p_cmp_add;
        exSheet.Cells[3, 3].Value = p_cmp_taxcode;
        exSheet.Cells[2, 7].Value = "Voucher No/Số: "+p_voucher_no;
        exSheet.Cells[3, 7].Value = "Seq: "+l_seq;
        exSheet.Cells[7, 1].Value = "Date/Ngày : " + p_ngay+"/"+p_thang+"/"+p_nam;
        exSheet.Cells[9, 5].Value = p_person;
        exSheet.Cells[10, 4].Value = p_cmp_name;
        exSheet.Cells[11, 4].Value = p_buspartner_lnm;
        exSheet.Cells[12, 4].Value = p_remark;
        exSheet.Cells[13, 4].Value = p_remark2;
        exSheet.Cells[14, 4].Value = p_fmt_amount;
        exSheet.Cells[14, 10].Value = p_rate;
        exSheet.Cells[15, 4].Value = p_amt_vn;
        exSheet.Cells[16, 4].Value = p_amt_en;
        exSheet.Cells[17, 4].Value = p_enclose;        
        String e1 = "";
        String e2 = "";
        String e3 = "";
        String e4 = "";
        String e5 = "";
        String e6 = "";
        String v1 = "";
        String v2 = "";
        String v3 = "";
        String v4 = "";
        String v5 = "";
        String v6 = "";
        String g1 = "";
        String g2 = "";
        String g3 = "";
        String g4 = "";
        String g5 = "";
        String g6 = "";
        String n1 = "";
        String n2 = "";
        String n3 = "";
        String n4 = "";
        String n5 = "";
        String n6 = "";

        for (int k = 0; k < dt_footer.Rows.Count; k++)
        {

            string strTmp = dt_footer.Rows[k][0].ToString();
            if (strTmp == "ENG")
            {
                e1 = "" + dt_footer.Rows[k][1].ToString();
                e2 = "" + dt_footer.Rows[k][2].ToString();
                e3 = "" + dt_footer.Rows[k][3].ToString();
                e4 = "" + dt_footer.Rows[k][4].ToString();
                e5 = "" + dt_footer.Rows[k][5].ToString();
                e6 = "" + dt_footer.Rows[k][7].ToString();
            }

            if (strTmp == "VIE")
            {
                v1 = dt_footer.Rows[k][1].ToString();
                v2 = dt_footer.Rows[k][2].ToString();
                v3 = dt_footer.Rows[k][3].ToString();
                v4 = dt_footer.Rows[k][4].ToString();
                v5 = dt_footer.Rows[k][5].ToString();
                v6 = dt_footer.Rows[k][7].ToString();
            }
            if (strTmp == "SIG")
            {
                g1 = dt_footer.Rows[k][1].ToString();
                g2 = dt_footer.Rows[k][2].ToString();
                g3 = dt_footer.Rows[k][3].ToString();
                g4 = dt_footer.Rows[k][4].ToString();
                g5 = dt_footer.Rows[k][5].ToString();
                g6 = dt_footer.Rows[k][7].ToString();
            }

            if (strTmp == "NAM")
            {
                n1 = dt_footer.Rows[k][1].ToString();
                n2 = dt_footer.Rows[k][2].ToString();
                n3 = dt_footer.Rows[k][3].ToString();
                n4 = dt_footer.Rows[k][4].ToString();
                n5 = dt_footer.Rows[k][5].ToString();
                n6 = dt_footer.Rows[k][7].ToString();
            }
        }
        exSheet.Cells[19, 1].Value = e1;
        exSheet.Cells[19, 3].Value = e2;
        exSheet.Cells[19, 5].Value = e3;
        exSheet.Cells[19, 6].Value = e4;
        exSheet.Cells[19, 7].Value = e5;
        exSheet.Cells[19, 9].Value = e6;

        exSheet.Cells[20, 1].Value = v1;
        exSheet.Cells[20, 3].Value = v2;
        exSheet.Cells[20, 5].Value = v3;
        exSheet.Cells[20, 6].Value = v4;
        exSheet.Cells[20, 7].Value = v5;
        exSheet.Cells[20, 9].Value = v6;
		
		exSheet.Cells[21, 1].Value = g1;
        exSheet.Cells[21, 3].Value = g2;
        exSheet.Cells[21, 5].Value = g3;
        exSheet.Cells[21, 6].Value = g4;
        exSheet.Cells[21, 7].Value = g5;
        exSheet.Cells[21, 9].Value = g6;

        exSheet.Cells[25, 1].Value = n1;
        exSheet.Cells[25, 3].Value = n2;
        exSheet.Cells[25, 5].Value = n3;
        exSheet.Cells[25, 6].Value = n4;
        exSheet.Cells[25, 7].Value = n5;
        exSheet.Cells[25, 9].Value = n6;
        SQL = " SELECT   f_gfbr00030_amt('" + l_seq + "','D','" + p_book_ccy + "') from dual";
		   // Response.Write(SQL);
           // Response.End();
		DataTable dt5 =ESysLib.TableReadOpen(SQL);
        string p_Amt_Dr = "";
		if (dt5.Rows.Count > 0)
		{
			p_Amt_Dr = dt5.Rows[0][0].ToString();
		}
		
		SQL = " SELECT   f_gfbr00030_amt('" + l_seq + "','C','" + p_book_ccy + "') from dual";
		   // Response.Write(SQL);
           // Response.End();
		DataTable dt6 =ESysLib.TableReadOpen(SQL);
        string p_Amt_Cr = "";
		if (dt6.Rows.Count > 0)
		{
			p_Amt_Cr = dt6.Rows[0][0].ToString();
		}
       exSheet.Cells[4, 7].Value = p_Debit;//+" VND";
        exSheet.Cells[5, 7].Value = p_Credit;//+" VND";
		exSheet.Cells[4, 10].Value = p_Amt_Dr ;//+" VND";
        exSheet.Cells[5, 10].Value = p_Amt_Cr ;//+" VND";
        decimal l_amtdrcr = 0;
        string l_acc = "";
        
             //   exSheet.Cells[4, 7].Value = "Nợ:";
              //  exSheet.Cells[5, 7].Value = "Có:";
				//exSheet.Cells[4, 8].Value = p_Debit;
              //  exSheet.Cells[5, 8].Value = p_Credit;
            
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        exBook.SaveAs(TempFile);
        ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
