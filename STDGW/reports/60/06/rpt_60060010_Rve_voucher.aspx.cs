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

public partial class rpt_60060010_Rve_voucher : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string _user_name = Session["USER_NAME"].ToString();
		//string TemplateFile = "rpt_60060010_Rve_voucher.xls";
		string TemplateFile = "rpt_60060010_Rve_voucher.xls";
		string TempFile = "../../../system/temp/rpt_60060010_Rve_voucher_" + Session["User_ID"].ToString() + ".xls";
		TemplateFile = Server.MapPath(TemplateFile);
		TempFile = Server.MapPath(TempFile);

		//Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

		//Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

		IRange range;

		//bind data to excel file

		string l_seq = Request["p_seq"];
		// Response.Write(l_seq);
		// Response.End();
		string p_company_pk = "", SQL = "", p_ccy = "", p_amount = "", p_book_ccy = "";
		SQL = "SELECT CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y'";
		DataTable dt0 = ESysLib.TableReadOpen(SQL);
		if (dt0.Rows.Count >0)
		{
			p_book_ccy = dt0.Rows[0][0].ToString();
		}

		SQL = " SELECT partner_lname, addr2, tax_code  FROM tco_company WHERE pk = '" + p_company_pk + "' ";
		DataTable dt1 = ESysLib.TableReadOpen(SQL);
		// MASTER 
		if (dt1.Rows.Count >0)
		{
			exSheet.Cells["J1"].Value = dt1.Rows[0][0].ToString();
			exSheet.Cells["AL1"].Value = dt1.Rows[0][1].ToString();
			exSheet.Cells["J2"].Value = dt1.Rows[0][2].ToString();
		}

		SQL = " SELECT   d.ccy, TO_CHAR(SUM (d.TR_AMT),'9,999,999,999,999.99'), TRIM(TO_CHAR(SUM(D.TR_AMT), DECODE(D.CCY,'VND','9,999,999,999,999','9,999,999,999,999.99')))||' '||d.ccy  FMT ";
		SQL += "    ,d.TR_RATE  ";
		SQL += "    FROM tac_hgtrd d ";
		SQL += "   WHERE d.del_if = 0 ";
		SQL += "     AND d.tac_hgtrh_pk = " + l_seq;
		SQL += "     AND d.drcr_type = 'D' ";
		SQL += "     AND d.tac_abacctcode_pk IN (SELECT pk FROM tac_abacctcode WHERE (ac_cd LIKE '111%'  or ac_cd LIKE '112%')) ";
		SQL += "  GROUP BY ccy,TR_RATE ";
		DataTable dt2 = ESysLib.TableReadOpen(SQL);
		if (dt2.Rows.Count > 0)
		{
			exSheet.Cells["Z5"].Value = dt2.Rows[0][3].ToString();

			p_ccy = dt2.Rows[0][0].ToString();
			p_amount = dt2.Rows[0][1].ToString();
			if(dt2.Rows[0]["ccy"].ToString() == "VND")
			{
				exSheet.Cells["W16"].Value = dt2.Rows[0][2].ToString();
			}
			else
			{
				exSheet.Cells["Q16"].Value = dt2.Rows[0][2].ToString();
			}

			exSheet.Cells["F18"].Value = CommondLib.Num2VNText(p_amount, p_ccy);
			exSheet.Cells["F17"].Value = CommondLib.Num2EngText(p_amount, p_ccy);
		}


		string SQL9	 = "SELECT (SELECT FULL_NAME " +
        "          FROM tac_employee_adv adv " +
        "         WHERE del_if = 0 AND pk = h.tac_employee_adv_pk) " +
        "          FULL_NAME, " +
        "       to_char(tr_date,'dd/mm/yyyy')tr_date, " +
        "       h.voucherno, " +
        "       (SELECT addr1 " +
        "          FROM tco_buspartner " +
        "         WHERE h.tco_buspartner_pk = pk AND del_if = 0) " +
        "          addr1 " +
        "  FROM tac_hgtrh h " +
        " WHERE h.del_if = 0 AND h.pk = '"+l_seq+"' ";

		dt0 = ESysLib.TableReadOpen(SQL9);
		if (dt0.Rows.Count > 0)
		{
			exSheet.Cells["H4"].Value = dt0.Rows[0]["FULL_NAME"].ToString();
			exSheet.Cells["Z4"].Value = dt0.Rows[0]["tr_date"].ToString();
			exSheet.Cells["H5"].Value = dt0.Rows[0]["addr1"].ToString();
			exSheet.Cells["AR4"].Value = dt0.Rows[0]["voucherno"].ToString()+"("+l_seq+")";
		}

		SQL	 = " SELECT   max(d.remark)remark, trim(TO_CHAR(SUM(d.TR_AMT),decode(d.ccy,'VND','9,999,999,999,999','9,999,999,999,999.99')))tr_amt,  " +
        "    '' pl, ccy " +
        "    FROM tac_hgtrd d  " +
        "   WHERE d.del_if = 0  " +
        "     AND d.tac_hgtrh_pk = '"+l_seq+"' " +
        "     AND d.drcr_type = 'D'  " +
        "     AND d.tac_abacctcode_pk IN (SELECT pk FROM tac_abacctcode WHERE (ac_cd LIKE '111%'  or ac_cd LIKE '112%') )  " +
        "  GROUP BY ccy,TR_RATE  ";

		DataTable dt3 = ESysLib.TableReadOpen(SQL);
		int _row = 9;
		for(int i = 0; i<dt3.Rows.Count; i++)
		{
			exSheet.Cells[_row+i, 2].Value = dt3.Rows[i]["remark"].ToString();
			if(dt3.Rows[i]["ccy"].ToString() == "VND")
			{
				exSheet.Cells[_row+i, 23].Value = dt3.Rows[i]["tr_amt"].ToString();
			}
			else
			{
				exSheet.Cells[_row+i, 17].Value = dt3.Rows[i]["tr_amt"].ToString();
			}

			exSheet.Cells[_row+i, 31].Value = dt3.Rows[i]["PL"].ToString();
		}

		
		SQL	 = "SELECT AC_GET_ACCD (tac_abacctcode_pk, '') ac_cd_dr, " +
        "         AC_GET_ACNM (tac_abacctcode_pk, '', 'ENG') ac_nm_dr " +
        "    FROM tac_hgtrd d " +
        "   WHERE d.del_if = 0 AND d.tac_hgtrh_pk = '"+l_seq+"' AND d.drcr_type = 'D' " +
        "GROUP BY d.drcr_type, d.tac_abacctcode_pk " +
        "ORDER BY drcr_type DESC ";

		DataTable dt4 = ESysLib.TableReadOpen(SQL);
		int _row1 = 9;
		for(int j = 0; j<dt4.Rows.Count; j++)
		{
			exSheet.Cells[_row1+j, 38].Value = dt4.Rows[j]["ac_cd_dr"].ToString();
			exSheet.Cells[_row1+j, 43].Value = dt4.Rows[j]["ac_nm_dr"].ToString();
		}

		SQL	 = "SELECT AC_GET_ACCD (tac_abacctcode_pk, '') ac_cd_cr, " +
        "         AC_GET_ACNM (tac_abacctcode_pk, '', 'ENG') ac_nm_cr " +
        "    FROM tac_hgtrd d " +
        "   WHERE d.del_if = 0 AND d.tac_hgtrh_pk = '"+l_seq+"' AND d.drcr_type = 'C' " +
        "GROUP BY d.drcr_type, d.tac_abacctcode_pk " +
        "ORDER BY drcr_type DESC ";
		DataTable dt5 = ESysLib.TableReadOpen(SQL);
		int _row2 = 9;
		for(int k = 0; k<dt5.Rows.Count; k++)
		{
			exSheet.Cells[_row2+k, 55].Value = dt5.Rows[k]["ac_cd_cr"].ToString();
			exSheet.Cells[_row2+k, 60].Value = dt5.Rows[k]["ac_nm_cr"].ToString();
		}

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

		/*exSheet.Cells["AK21"].Value = _user_name;
        exSheet.Cells["AP21"].Value = "";
        exSheet.Cells["AU21"].Value = n3;
        exSheet.Cells["AZ21"].Value = "";
        exSheet.Cells["BJ21"].Value = "";
        exSheet.Cells["BO21"].Value = n6;
		*/
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        // hide row firts 
        range = exSheet.Range["A1"];
        // hide row A5 
        // range.Rows.Hidden = true;
        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

        exBook.SaveAs(TempFile);
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
        //Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }

   
}