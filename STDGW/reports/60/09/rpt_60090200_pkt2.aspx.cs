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

public partial class rpt_60090200_pkt2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        string l_com_pk = Request["p_company_pk"];
        string l_partner_pk = Request["partner_pk"];
        string l_from_dt = Request["from_date"];
        string l_to_dt = Request["to_date"]; 

		string l_taxcode = "";
		string l_compa = "";
		string l_address = "";
		string Sophieu = "";
		string stt = "";
		string ngay="";
		string thang="";
		string nam="";
		string kt = "";
		string title = "";
		string nguoilap = "";
	
        string TemplateFile = "rpt_60090200_pkt2.xls";
        string TempFile = "../../../system/temp/rpt_60090200_pkt2_" + Session["User_ID"].ToString() + ".xls";
     
	   TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
       	IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;

        //bind data to excel file
        string SQL = " SELECT PARTNER_LNAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_com_pk + "' ";
		DataTable dt_f = ESysLib.TableReadOpen(SQL);

		if (dt_f.Rows.Count > 0)
		{
			l_compa = dt_f.Rows[0][0].ToString();
			l_address = dt_f.Rows[0][1].ToString();
			l_taxcode = dt_f.Rows[0][3].ToString();
		}
		
        exSheet.Cells["A1"].Value  = l_compa;
		exSheet.Cells["A2"].Value  = l_address;
		
		string p_xls_ccy_format ="";
		string p_bookccy = "";
		SQL = "SELECT AC_GET_BOOKCCY_ACNT('ACBG0040') FROM DUAL " ;
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

        SQL = "SELECT h.pk, " +
         "         h.VOUCHERNO||'('||h.pk||')' VOUCHERNO, " +
         "         TO_CHAR (h.tr_date, 'DD') ngay, " +
         "         TO_CHAR (h.tr_date, 'MM') thang, " +
         "         TO_CHAR (h.tr_date, 'YYYY') nam, " +
         "         d.org_nm, " +
         "         a.tr_type, " +
         "         a.tr_tpnm, " +
         "         v1.full_name pro_by, " +
         "         h.sign_date, " +
         "         c.partner_name, " +
         "         h.tr_enclose, " +
         "         b.CODE_NM " +
         "    FROM tac_hgtrh h, " +
         "         tco_company c, " +
         "         tco_org d, " +
         "         tac_abtrtype a, " +
         "         vco_bsuser v1, " +
         "         vco_bsuser v2, " +
         "         (SELECT UPPER (N.CODE_NM) CODE_NM, k.pk pk " +
         "            FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL N, tac_hgtrh k " +
         "           WHERE     N.CODE = k.VOUCHER_TYPE " +
         "                 AND N.DEL_IF = 0 " +
         "                 AND N.TAC_COMMCODE_MASTER_PK = M.PK " +
         "                 AND M.del_if = 0 " +
         "                 AND m.id = 'ACBG0130') b " +
         "   WHERE     h.del_if = 0 " +
         "         AND c.del_if = 0 " +
         "         and h.TR_TABLENM ='TAC_CRDA' " +
         "             and h.TR_TABLE_PK in  " +
         "             (  " +
         "               select crda.pk " +
         "                from TAC_CRDA crda " +
         "               where crda.del_if =0 " +
         "               and CRDA.TCO_BUSPARTNER_PK = " + l_partner_pk +
         "               and CRDA.TR_DATE between '" + l_from_dt + "' and '" + l_to_dt + "' " +
         "               and crda.tr_status in (0,2) " +
         "            ) " +
         "         AND h.tco_org_pk = d.pk(+) " +
         "         AND h.tac_abtrtype_pk = a.pk(+) " +
         "         AND h.tco_company_pk = c.pk " +
         "         AND h.tco_bsuser_pk = v1.pk(+) " +
         "         AND h.sign_memb = v2.user_id(+) " +
         "         AND H.pk = b.pk ";
         
         DataTable dt_m = ESysLib.TableReadOpen(SQL);
         if (dt_m.Rows.Count > 0)
         {
            // Sophieu = dt_m.Rows[0][1].ToString();
             stt = dt_m.Rows[0][0].ToString();
             ngay = dt_m.Rows[0][2].ToString();
             thang = dt_m.Rows[0][3].ToString();
             nam = dt_m.Rows[0][4].ToString();
             kt = dt_m.Rows[0][11].ToString();
             title = dt_m.Rows[0][12].ToString();
             nguoilap = dt_m.Rows[0][8].ToString();
         }
		 
		exSheet.Cells["C6"].Value  = "                            Ngày "+ngay+" tháng "+thang+" năm "+nam;
		exSheet.Cells["G6"].Value  = Sophieu;
	// Response.Write("teas");
	// Response.End();
	string Inword = "";
    SQL = "SELECT SUM (NVL (d.TR_BOOKAMT, 0)) amt_cr FROM tac_hgtrd d, tac_hgtrh h  " +
            "   where d.del_if = 0 and h.del_if =0 " + 
            "   and d.drcr_type = 'C' and d.tac_hgtrh_pk = h.pk " +
             "         and h.TR_TABLENM ='TAC_CRDA' " +
             "             and h.TR_TABLE_PK in  " +
             "             (  " +
             "               select crda.pk " +
             "                from TAC_CRDA crda " +
             "               where crda.del_if =0 " +
             "               and CRDA.TCO_BUSPARTNER_PK = " + l_partner_pk +
             "               and CRDA.TR_DATE between '" + l_from_dt + "' and '" + l_to_dt + "' " +
             "               and crda.tr_status in (0,2) " +
             "            ) "  ;
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




        DataTable dt_detail = ESysLib.TableReadOpenCursor("ac_rpt_60090200_pkt2_dtl", l_partner_pk + ',' + l_from_dt + ',' + l_to_dt);
		
        for (int l_addrow =1; l_addrow < dt_detail.Rows.Count ; l_addrow++)
        {
            exSheet.Range["A11"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------------------------
		
		exSheet.Cells["A7"].Value  = "Đối tượng: " + dt_detail.Rows[0]["partner_id"].ToString();
		int l_row = 10;
		for (int i = 0; i < dt_detail.Rows.Count;i++)
		{
			exSheet.Cells[l_row + i, 1].Value  =  dt_detail.Rows[i]["TR_DATE"].ToString();
			exSheet.Cells[l_row + i, 2].Value  =  dt_detail.Rows[i]["VOUCHERNO"].ToString();
			exSheet.Cells[l_row + i, 3].Value  =  dt_detail.Rows[i]["remark"].ToString();
			exSheet.Cells[l_row + i, 4].Value  =  dt_detail.Rows[i]["acc_dr"].ToString();
			exSheet.Cells[l_row + i, 5].Value  =  dt_detail.Rows[i]["acc_cr"].ToString();
			exSheet.Cells[l_row + i, 6].Value  =  decimal.Parse(dt_detail.Rows[i]["amt"].ToString());
			exSheet.Cells[l_row + i, 6].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[l_row + i, 7].Value  =  dt_detail.Rows[i]["PL"].ToString();
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