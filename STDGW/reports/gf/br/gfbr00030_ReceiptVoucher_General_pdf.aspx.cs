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

public partial class gfbr00030_ReceiptVoucher_General_pdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        

        string TemplateFile = "gfbr00030_ReceiptVoucher_General_pdf.xls";
        string TempFile = "../../../system/temp/gfbr00030_ReceiptVoucher_General_pdf_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		string _user_name = Session["USER_NAME"].ToString();
        string l_seq = "" + Request["seq"];
        string p_table_pk = "" + Request["pv_pk"];
        string p_company_pk = "";
        string p_cmp_name = "";
        string p_cmp_add = "";
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
        string p_voucher_code = "";
        String p_voucher_name = "PHI?U THU";
        string tmp1 = "";
        string tmp2 = "";
        string tmp3 = "";
        int i = 0;

        SQL = "SELECT CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y'";
        DataTable dt0 = ESysLib.TableReadOpen(SQL);
        if (dt0.Rows.Count > 0)
        {
            p_book_ccy = dt0.Rows[0][0].ToString();
        }

        string SQL9 = "SELECT a.tr_person, a.voucherno, a.tr_enclose, a.voucher_type, " +
            "       b.pk, a.tco_buspartner_pk, " +
            "       DECODE (a.tco_buspartner_pk, " +
            "               '', DECODE (a.tac_employee_adv_pk, " +
            "                           '', '', " +
            "                           (SELECT DECODE (adv.thr_employee_pk, " +
            "                                           '', description, " +
            "                                           (SELECT present_addr " +
            "                                              FROM thr_employee " +
            "                                             WHERE del_if = 0 " +
            "                                               AND pk = adv.thr_employee_pk) " +
            "                                          ) " +
            "                              FROM tac_employee_adv adv " +
            "                             WHERE del_if = 0 AND pk = a.tac_employee_adv_pk) " +
            "                          ), " +
            "               (SELECT addr1 " +
            "                  FROM tco_buspartner " +
            "                 WHERE a.tco_buspartner_pk = pk AND del_if = 0) " +
            "              ) addr1, " +
            "       DECODE (a.tco_buspartner_pk, " +
            "               '', DECODE (a.tac_employee_adv_pk, " +
            "                           '', '', " +
            "                           (SELECT org_nm " +
            "                              FROM tco_org o, tac_employee_adv e " +
            "                             WHERE o.del_if = 0 " +
            "                               AND o.pk = e.tco_org_pk " +
            "                               AND e.del_if = 0 " +
            "                               AND e.pk = a.tac_employee_adv_pk) " +
            "                          ), " +
            "               (SELECT partner_name " +
            "                  FROM tco_buspartner " +
            "                 WHERE a.tco_buspartner_pk = pk AND del_if = 0) " +
            "              ) department " +
            "  FROM tac_bprvpv a, tac_hgtrh b " +
            " WHERE a.del_if = 0 " +
            "   AND b.del_if = 0 " +
            "   AND b.tr_table_pk = a.pk " +
            "   AND b.tr_tablenm = 'TAC_BPRVPV' " +
            "   AND b.pk = " + l_seq;

        dt0 = ESysLib.TableReadOpen(SQL9);
        if (dt0.Rows.Count > 0)
        {
            p_person = dt0.Rows[0][0].ToString();
            p_enclose = dt0.Rows[0][2].ToString();
            //p_reason  = dt0.Rows[0][3].ToString(); 
            p_addr = dt0.Rows[0][6].ToString();
            p_buspartner_lnm = dt0.Rows[0][7].ToString();
            p_voucher_code = dt0.Rows[0][3].ToString();
        }
        SQL = "SELECT UPPER(D.CODE_LNM) FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.DEL_IF =0 AND D.DEL_IF =0 AND M.ID ='ACBG0130' AND D.CODE = '" + p_voucher_code + "' ";
        dt0 = ESysLib.TableReadOpen(SQL);

        if (dt0.Rows.Count > 0)
        {
            p_voucher_name = dt0.Rows[0][0].ToString();
        }
        SQL = " SELECT v.tco_company_pk, v.voucherno, TO_CHAR(v.tr_date,'DD') ngay, ";
        SQL += "       TO_CHAR(v.tr_date, 'MM') thang, TO_CHAR (v.tr_date,'YYYY') nam, ";
        SQL += "       v.remark, v.remark2 ";
        SQL += "    FROM TAC_HGTRH v WHERE PK =  " + l_seq;
        DataTable dt = ESysLib.TableReadOpen(SQL);

        if (dt.Rows.Count > 0)
        {
            p_company_pk = dt.Rows[0][0].ToString();
            p_voucher_no = dt.Rows[0][1].ToString();
            p_ngay = dt.Rows[0][2].ToString();
            p_thang = dt.Rows[0][3].ToString();
            p_nam = dt.Rows[0][4].ToString();
            p_remark = dt.Rows[0][5].ToString();
            p_remark2 = dt.Rows[0][6].ToString();
        }

        SQL = " SELECT   d.ccy, TO_CHAR(SUM (d.TR_AMT),'9,999,999,999,999.99'), TRIM(TO_CHAR(SUM(D.TR_AMT), DECODE(D.CCY,'VND','9,999,999,999,999','9,999,999,999,999.99')))||' '||d.ccy  FMT ";
        SQL += "    ,d.TR_RATE  ";
        SQL += "    FROM tac_hgtrd d ";
        SQL += "   WHERE d.del_if = 0 ";
        SQL += "     AND d.tac_hgtrh_pk = " + l_seq;
        SQL += "     AND d.drcr_type = 'D' ";
        SQL += "     AND d.tac_abacctcode_pk IN (SELECT pk FROM tac_abacctcode WHERE (ac_cd LIKE '111%'  or ac_cd LIKE '112%') ) ";
        SQL += "  GROUP BY ccy,TR_RATE ";
// Response.Write(SQL);
        // Response.End();
        DataTable dt2 = ESysLib.TableReadOpen(SQL);
        if (dt2.Rows.Count > 0)
        {
            p_ccy = dt2.Rows[0][0].ToString();
            p_amount = dt2.Rows[0][1].ToString();
            p_fmt_amount = dt2.Rows[0][2].ToString();
            p_rate = dt2.Rows[0][3].ToString();
			
			p_amt_vn = CommondLib.Num2VNText(p_amount, p_ccy);
        p_amt_en = CommondLib.Num2EngText(p_amount, p_ccy);
        }
        

        SQL = " SELECT partner_lname, addr2, tax_code  FROM tco_company WHERE pk = '" + p_company_pk + "' ";
        DataTable dt1 = ESysLib.TableReadOpen(SQL);
        if (dt1.Rows.Count > 0)
        {
            p_cmp_name = dt1.Rows[0][0].ToString();
            p_cmp_add = dt1.Rows[0][1].ToString();
            p_cmp_taxcode = dt1.Rows[0][2].ToString();
        }

        SQL = " select f_gfbr00030_acc('" + l_seq + "','D','" + p_company_pk + "') from dual ";
        // SQL += "sf_a_get_accd(d.tac_abacctcode_pk," + p_company_pk + ") ";
        // SQL += ", SUM(d.TR_BOOKAMT) drcr_amt, sf_a_get_accd(d.tac_abacctcode_pk," + p_company_pk + ")|| ' : ' ";
        // SQL += "    FROM tac_hgtrd d ";
        // SQL += "   WHERE d.del_if = 0 AND d.tac_hgtrh_pk = " + l_seq;
        // SQL += " GROUP BY d.drcr_type, d.tac_abacctcode_pk,DRCR_ORD ";
        // SQL += " ORDER BY d.drcr_type DESC,DRCR_ORD ASC ";
        //SQL += " ORDER BY d.drcr_type DESC,d.tac_abacctcode_pk  ASC,DRCR_ORD ASC ";
        string p_Debit = "";
        string p_Credit = "";
        DataTable dt3 = ESysLib.TableReadOpen(SQL);
        if (dt3.Rows.Count > 0)
        {
            p_Debit = dt3.Rows[0][0].ToString();
        }


        SQL = " select f_gfbr00030_acc('" + l_seq + "','C','" + p_company_pk + "') from dual ";
        DataTable dt4 = ESysLib.TableReadOpen(SQL);
        if (dt4.Rows.Count > 0)
        {
            p_Credit = dt4.Rows[0][0].ToString();
        }
        //-----header---   

        //---end--header---
        //--set-----DataBind--in---Master---
        //Response.Write(p_voucher_no);
        //Response.End();

        exSheet.Cells[1, 1].Value = p_cmp_name;
        exSheet.Cells[2, 1].Value = p_cmp_add;
        exSheet.Cells[3, 3].Value = p_cmp_taxcode;
        exSheet.Cells[2, 7].Value = "Voucher No/Số: "+p_voucher_no;
        exSheet.Cells[3, 7].Value = "Seq: "+l_seq;
        exSheet.Cells[7, 1].Value = "Date/Ngày : " + p_ngay+"/"+p_thang+"/"+p_nam;

        exSheet.Cells[9, 5].Value = p_person;
        exSheet.Cells[10, 4].Value = p_addr;
        exSheet.Cells[11, 4].Value = p_buspartner_lnm;
        exSheet.Cells[12, 4].Value = p_remark;
        exSheet.Cells[13, 4].Value = p_remark2;
        exSheet.Cells[14, 4].Value = p_fmt_amount;
        exSheet.Cells[14, 10].Value = p_rate;
        exSheet.Cells[15, 4].Value = p_amt_vn;
        exSheet.Cells[16, 4].Value = p_amt_en;
        exSheet.Cells[17, 4].Value = p_enclose;

        SQL = "select   " +
        "    D.CODE, " +
        "    D.CHAR_1,  " +
        "    D.CHAR_2,  " +
        "    D.CHAR_3,  " +
        "    D.CHAR_4,  " +
        "    D.CHAR_5,  " +
        "    D.REMARK " +
        " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
        " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
        " AND M.ID='EACAB054' " +
        " order by D.ORD ";
        dt1 = ESysLib.TableReadOpen(SQL);
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

        for (int k = 0; k < dt1.Rows.Count; k++)
        {

            string strTmp = dt1.Rows[k][0].ToString();
            if (strTmp == "ENG")
            {
                e1 = "" + dt1.Rows[k][1].ToString();
                e2 = "" + dt1.Rows[k][2].ToString();
                e3 = "" + dt1.Rows[k][3].ToString();
                e4 = "" + dt1.Rows[k][4].ToString();
                e5 = "" + dt1.Rows[k][5].ToString();
                e6 = "" + dt1.Rows[k][6].ToString();
            }

            if (strTmp == "VIE")
            {
                v1 = dt1.Rows[k][1].ToString();
                v2 = dt1.Rows[k][2].ToString();
                v3 = dt1.Rows[k][3].ToString();
                v4 = dt1.Rows[k][4].ToString();
                v5 = dt1.Rows[k][5].ToString();
                v6 = dt1.Rows[k][6].ToString();
            }
            if (strTmp == "SIG")
            {
                g1 = dt1.Rows[k][1].ToString();
                g2 = dt1.Rows[k][2].ToString();
                g3 = dt1.Rows[k][3].ToString();
                g4 = dt1.Rows[k][4].ToString();
                g5 = dt1.Rows[k][5].ToString();
                g6 = dt1.Rows[k][6].ToString();
            }

            if (strTmp == "NAM")
            {
                n1 = dt1.Rows[k][1].ToString();
                n2 = dt1.Rows[k][2].ToString();
                n3 = dt1.Rows[k][3].ToString();
                n4 = dt1.Rows[k][4].ToString();
                n5 = dt1.Rows[k][5].ToString();
                n6 = dt1.Rows[k][6].ToString();
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

        exSheet.Cells[25, 1].Value = n1;
        exSheet.Cells[25, 3].Value = n2;
        exSheet.Cells[25, 5].Value = n3;
        exSheet.Cells[25, 6].Value = n4;
        exSheet.Cells[25, 7].Value = _user_name;
        exSheet.Cells[25, 9].Value = n6;
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
        //decimal l_amtdrcr = 0;
        //for (i = 0; i < dt3.Rows.Count; i++)
        //{
        //    tmp1 = dt3.Rows[i][0].ToString();
        //    if(p_book_ccy == "VND")		
        //        tmp2 = dt3.Rows[i][1].ToString();
        //    else
        //    {
        //        l_amtdrcr = decimal.Parse(dt3.Rows[i][2].ToString());
        //        if(l_amtdrcr < 1)
        //            tmp2 = dt3.Rows[i][3].ToString() + l_amtdrcr.ToString();
        //        else
        //            tmp2 = dt3.Rows[i][1].ToString();
        //    }	
        //    if (tmp1=="D")
        //    {
        //        tmp3 = "Nợ";
        //    }
        //    else
        //    {
        //        tmp3 = "Có";
        //    }
        //    if (i == 0)
        //    {
        //        exSheet.Cells[4, 7].Value = tmp3 + ":";
        //        exSheet.Cells[4, 8].Value = tmp2;
        //    }
        //    else
        //    {
        //       exSheet.Cells[4 + i, 7].Value = tmp3 + ":";
        //       exSheet.Cells[4 + i, 8].Value = tmp2;
        //    }
        //    //Response.Write(i);
        //    //Response.End();
        
        //}/**/
        exSheet.Cells[4, 7].Value = "Nợ:";
        exSheet.Cells[5, 7].Value = "Có:";
        exSheet.Cells[4, 8].Value = p_Debit;
        exSheet.Cells[5, 8].Value = p_Credit;
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
        //ESysLib.ExcelToPdf(TempFile);
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
