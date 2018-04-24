﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company_pk = ""+Request["company_pk"];
	string l_account_pk = ""+Request["account_pk"];
	string l_date_from	= "" + Request["dtbFrom"];
	string l_date_to = "" +Request["dtbTo"];
	string l_ccy = ""+ Request["ccy"];
	string l_status = ""+Request["status"];
	string l_book_ccy = ""+Request["bookccy"];
    string l_rpt_Option = Request["rptOption"];
	if (l_status=="")//Default status is confirm
	{
		l_status="2";
	}
	
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_acc_type = "";
    string p_acc_num = "";
	string p_dt_from ="";
	string p_dt_to ="";

	string p_open_bal_dr_xls = "0";
	string p_open_bal_cr_xls = "0";
	string p_close_bal_dr_xls = "0";
	string p_close_bal_cr_xls = "0";
	string p_debit_xls ="0";
	string p_credit_xls ="0";
	
	string p_open_trans_dr_xls = "0";
	string p_open_trans_cr_xls = "0";
	string p_close_trans_dr_xls = "0";
	string p_close_trans_cr_xls = "0";
	string p_total_trans_debit_xls ="0";
	string p_total_trans_credit_xls ="0";
	
	
	
	string p_open_bal = "0";
	string p_open_trans_bal = "0";
	string p_acc_pk_arr ="";
	
	string p_ccy ="";
	
	int i =0;
	
	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    string p_bookccy = "";
   string SQL = "SELECT AC_GET_BOOKCCY_ACNT('ACBG0040') FROM DUAL " ;
  DataTable dt_bookccy = ESysLib.TableReadOpen(SQL);

	if (dt_bookccy.Rows.Count >0)
	{	
		p_bookccy = dt_bookccy.Rows[0][0].ToString();
	}
    if (p_bookccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
		
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
		
    }
	
	 SQL = " SELECT partner_lname, addr2, tax_code  FROM tco_company WHERE pk = '" + l_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
    }

    SQL = " SELECT AC_CD,AC_LNM,UPPER(a.DRCR_TYPE) ,  to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date,DECODE(UPPER(a.DRCR_TYPE),'D','1','-1') ";
	SQL += "FROM TAC_ABACCTCODE a WHERE a.pk = '" + l_account_pk + "' ";

	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if(dt1.Rows.Count>0)
	{
		p_acc_code = dt1.Rows[0][0].ToString();
	    p_acc_name = dt1.Rows[0][1].ToString();
		p_acc_type = dt1.Rows[0][2].ToString();
	    p_dt_from = dt1.Rows[0][3].ToString();
		p_dt_to = dt1.Rows[0][4].ToString();
        p_acc_num = dt1.Rows[0][5].ToString();
	}
	
	
	/*  
SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS openingbalance, ";
SQL += "               TO_CHAR (NVL (debitbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS debitbookamount, ";
SQL += "               TO_CHAR (NVL (creditbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS creditbookamount, ";
SQL += "               TO_CHAR (NVL (closingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS closingbalance, ";
SQL += "               NVL (openingbalance, 0) AS OB ,TO_CHAR(NVL(DEBIT_FAMT,0),DECODE(CCY,'VND','9,999,999,999,990','9,999,999,999,990.99')), TO_CHAR(NVL(CREDIT_FAMT,0),DECODE(CCY,'VND','9,999,999,999,990','9,999,999,999,990.99')),TO_CHAR(NVL(OPEN_TRANS,0),DECODE(CCY,'VND','9,999,999,999,990','9,999,999,999,990.99')),TO_CHAR(NVL(CLOSE_TRANS,0),DECODE(CCY,'VND','9,999,999,999,990','9,999,999,999,990.99')), NVL (OPEN_TRANS, 0) AS O_TRANS";
SQL += "               ,ccy ";
SQL += "          FROM (SELECT   tac_abacctcode_pk,";
SQL += "                         SUM (NVL (ymd_drbooks, 0)) debitbookamount, ";
SQL += "                         SUM (NVL (ymd_crbooks, 0)) creditbookamount ";
SQL += "         ,SUM(NVL(YMD_DRTRANS,0)) DEBIT_FAMT, SUM(NVL(YMD_CRTRANS,0)) CREDIT_FAMT,max(CCY) CCY   ";
SQL += "                    FROM tac_hgddbal a ";
SQL += "                   WHERE a.del_if = 0 ";
SQL += "                     AND a.tco_company_pk = '" + l_company_pk +"' ";
SQL += "                     AND a.tac_abacctcode_pk = '" + l_account_pk +"' ";
SQL += "                     AND a.tr_status = '" + l_status +"' ";
SQL += "                     AND a.std_ymd BETWEEN '" + l_date_from +"' AND '" + l_date_to +"' ";
//'SQL += "                	  AND a.ccy ='"+ l_book_ccy +"' ";
SQL += "                GROUP BY tac_abacctcode_pk) a, ";
SQL += "               (SELECT DECODE(b.pk,'', DECODE (c.tac_abacctcode_pk,'', d.tac_abacctcode_pk),b.pk) tac_abacctcode_pk, ";
SQL += "                       (a.mr_amt * b.dc + c.dd_amt * b.dc) openingbalance, ";
SQL += "                       (a.mr_amt * b.dc + c.dd_amt * b.dc + d.t_amt * b.dc) AS closingbalance ";
SQL += "       , (A.MR_FAMT * B.DC + C.DD_FAMT * B.DC) OPEN_TRANS, (A.MR_FAMT * B.DC + C.DD_FAMT * B.DC + D.T_FAMT * B.DC) AS CLOSE_TRANS ";
SQL += "                  FROM (SELECT NVL((SUM (NVL(this_drbal,0)) - SUM (NVL(this_crbal,0))),0) mr_amt ,NVL ((SUM (NVL(THIS_DRFBAL,0)) - SUM (NVL(THIS_CRFBAL,0))), 0) MR_FAMT";
SQL += "                          FROM tac_hgmmbal ";
SQL += "                         WHERE del_if = 0 ";
SQL += "                           AND tco_company_pk = '" + l_company_pk +"' ";
SQL += "                           AND tac_abacctcode_pk = '" + l_account_pk +"' ";
SQL += "                           AND tr_status = '" + l_status +"' ";
SQL += "                           AND std_ym = SUBSTR (sf_get_lastclosemm ('" + l_date_from +"','" + l_company_pk +"'),1,6)) a, ";
SQL += "                       (SELECT pk, DECODE (drcr_type, 'D', 1, -1) dc ";
SQL += "                          FROM tac_abacctcode ";
SQL += "                         WHERE del_if = 0 ";
SQL += "                           AND pk = '" + l_account_pk +"' ";
SQL += "                           AND tco_company_pk = '" + l_company_pk +"') b, ";
SQL += "                       (SELECT MAX (tac_abacctcode_pk) AS tac_abacctcode_pk, ";
SQL += "                               NVL((SUM (ymd_drbooks) - SUM (ymd_crbooks)),0) dd_amt ";
SQL += "        ,NVL ((SUM (YMD_DRTRANS) - SUM (YMD_CRTRANS)),0) DD_FAMT   ";
SQL += "                          FROM tac_hgddbal ";
SQL += "                         WHERE del_if = 0 ";
SQL += "                           AND tco_company_pk = '" + l_company_pk +"' ";
SQL += "                           AND tac_abacctcode_pk = '" + l_account_pk +"' ";
SQL += "                           AND tr_status = '" + l_status +"' ";
SQL += "                           AND std_ymd ";
SQL += "                                  BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (sf_get_lastclosemm('" + l_date_from +"', '" + l_company_pk +"' ),'YYYYMMDD'),+1),'YYYYMMDD') ";
SQL += "                                      AND TO_CHAR (  TO_DATE ('" + l_date_from +"','YYYYMMDD')- 1,'YYYYMMDD')) c, ";
SQL += "                       (SELECT (SUM (ymd_drbooks) - SUM (ymd_crbooks)) t_amt, ";
SQL += "                               MAX (tac_abacctcode_pk) tac_abacctcode_pk ";
SQL += "       ,(SUM (YMD_DRTRANS) - SUM (YMD_CRTRANS)) T_FAMT      ";
SQL += "                          FROM tac_hgddbal ";
SQL += "                         WHERE del_if = 0 ";
SQL += "                           AND tco_company_pk = '" + l_company_pk +"' ";
SQL += "                           AND tac_abacctcode_pk = '" + l_account_pk +"' ";
SQL += "                           AND tr_status = '" + l_status +"' ";
SQL += "                           AND (std_ymd BETWEEN '" + l_date_from +"' AND '" + l_date_to +"')) d) b ";
SQL += "         WHERE a.tac_abacctcode_pk(+) = b.tac_abacctcode_pk "; */
    SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS openingbalance, ";
    SQL += "               TO_CHAR (NVL (debitbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS debitbookamount, ";
    SQL += "               TO_CHAR (NVL (creditbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS creditbookamount, ";
    SQL += "               TO_CHAR (NVL (closingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS closingbalance, ";
    SQL += "               NVL (openingbalance, 0) AS OB ,TO_CHAR(NVL(DEBIT_FAMT,0),'9,999,999,999,990.99'), TO_CHAR(NVL(CREDIT_FAMT,0),'9,999,999,999,990.99'),TO_CHAR(NVL(OPEN_TRANS,0),'9,999,999,999,990.99'),TO_CHAR(NVL(CLOSE_TRANS,0),'9,999,999,999,990.99'), NVL (OPEN_TRANS, 0) AS O_TRANS ";
    SQL += "          FROM ( ";
    SQL += "    SELECT TAC_ABACCTCODE_PK,SUM(openingbalance) openingbalance, SUM(OPEN_TRANS) OPEN_TRANS, " +
        "    SUM(debitbookamount) debitbookamount, SUM(creditbookamount) creditbookamount, SUM(DEBIT_FAMT) DEBIT_FAMT, " +
        "    SUM(CREDIT_FAMT) CREDIT_FAMT, (SUM(openingbalance)+ (SUM(debitbookamount) - SUM(creditbookamount))*TO_NUMBER('" + p_acc_num + "'))  closingbalance, " +
        "    (SUM(OPEN_TRANS) + (SUM(DEBIT_FAMT)-SUM(CREDIT_FAMT))*TO_NUMBER('" + p_acc_num + "')) CLOSE_TRANS " +
        "     " +
        "    FROM " +
        "    ( " +
        "    SELECT TAC_ABACCTCODE_PK,0 openingbalance,0 OPEN_TRANS ,SUM (NVL (ymd_drbooks, 0)) debitbookamount, " +
        "    SUM (NVL (ymd_crbooks, 0)) creditbookamount,SUM(NVL(YMD_DRTRANS,0)) DEBIT_FAMT, SUM(NVL(YMD_CRTRANS,0)) CREDIT_FAMT " +
        "    FROM TAC_HGDDBAL A " +
        "    WHERE A.DEL_IF =0  " +
        "    AND A.tco_company_pk = '" + l_company_pk + "' " +
        "    AND A.tac_abacctcode_pk = '" + l_account_pk + "'  " +
        "    AND a.tr_status = '" + l_status + "' " +
        "    AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "' " +
        "    GROUP BY tac_abacctcode_pk " +
        "    UNION ALL " +
        "    SELECT TAC_ABACCTCODE_PK, " +
        "      (SUM(NVL(THIS_DRBAL,0)) - SUM (NVL(this_crbal,0)))*TO_NUMBER('" + p_acc_num + "')  openingbalance,   " +
        "      (SUM(NVL(THIS_DRFBAL,0)) - SUM (NVL(THIS_CRFBAL,0)))*TO_NUMBER('" + p_acc_num + "')  OPEN_TRANS, " +
        "        0 debitbookamount, 0 creditbookamount,0 DEBIT_FAMT, 0 CREDIT_FAMT " +
        "    FROM TAC_HGMMBAL B " +
        "    WHERE B.DEL_IF =0  " +
        "    AND tco_company_pk = '" + l_company_pk + "' " +
        "    AND tac_abacctcode_pk = '" + l_account_pk + "' " +
        "    AND tr_status = '" + l_status + "' " +
        "    AND std_ym = SUBSTR (sf_get_lastclosemm ('" + l_date_from + "','" + l_company_pk + "'),1,6) " +
        "    GROUP BY TAC_ABACCTCODE_PK " +
        "    UNION ALL " +
        "    SELECT TAC_ABACCTCODE_PK, " +
        "        (SUM(NVL(YMD_DRBOOKS,0)) - SUM (NVL(YMD_CRBOOKS,0)))*TO_NUMBER('" + p_acc_num + "')  openingbalance,   " +
        "      (SUM(NVL(YMD_DRTRANS,0)) - SUM (NVL(YMD_CRTRANS,0)))*TO_NUMBER('" + p_acc_num + "')  OPEN_TRANS, " +
        "        0 debitbookamount, 0 creditbookamount,0 DEBIT_FAMT, 0 CREDIT_FAMT " +
        "    FROM TAC_HGDDBAL " +
        "    WHERE del_if = 0 " +
        "    AND tco_company_pk = '" + l_company_pk + "'  " +
        "    AND tac_abacctcode_pk = '" + l_account_pk + "' " +
        "    AND tr_status = '" + l_status + "'  " +
        "    AND std_ymd  BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (sf_get_lastclosemm('" + l_date_from + "', '" + l_company_pk + "' ),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "        AND TO_CHAR (TO_DATE ('" + l_date_from + "','YYYYMMDD')- 1,'YYYYMMDD') " +
        "    GROUP BY TAC_ABACCTCODE_PK " +
        "    ) " +
        "    GROUP BY TAC_ABACCTCODE_PK ) ";

//'SQL = SQL & "         --  AND upper(ccy) LIKE DECODE('& l_ccy &','ALL','%%','& l_ccy &') "

	DataTable dt2 = ESysLib.TableReadOpen(SQL);

    if (dt2.Rows.Count >0)
    {
		if (p_acc_type =="D")
		{
			p_open_bal_dr_xls = dt2.Rows[0][0].ToString();
			p_close_bal_dr_xls = dt2.Rows[0][3].ToString();
			p_open_trans_dr_xls = dt2.Rows[0][7].ToString();
			p_close_trans_dr_xls = dt2.Rows[0][8].ToString();
		}
		else
		{
			p_open_bal_cr_xls = dt2.Rows[0][0].ToString();
			p_close_bal_cr_xls = dt2.Rows[0][3].ToString();
			p_open_trans_cr_xls = dt2.Rows[0][7].ToString();
			p_close_trans_cr_xls = dt2.Rows[0][8].ToString();
		}
		p_debit_xls = dt2.Rows[0][1].ToString();
		p_credit_xls = dt2.Rows[0][2].ToString();
		
		p_total_trans_debit_xls  = dt2.Rows[0][5].ToString();
		p_total_trans_credit_xls = dt2.Rows[0][6].ToString();
		
	    p_open_bal = dt2.Rows[0][4].ToString();
		p_open_trans_bal = dt2.Rows[0][9].ToString();
		p_ccy = dt2.Rows[0][10].ToString();
    }
	
	if (p_ccy == "VND")
    {
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";		
    }
    else
    {
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
SQL = " SELECT pk FROM tac_abacctcode  WHERE del_if = 0 AND leaf_yn = 'Y'  CONNECT BY pac_pk = PRIOR pk START WITH pk = " + l_account_pk;

DataTable dt3 = ESysLib.TableReadOpen(SQL);

string p_temp ="";
for (i=0;i<dt3.Rows.Count;i++)
{
	p_acc_pk_arr = p_acc_pk_arr + p_temp + dt3.Rows[i][0].ToString();
	p_temp = ",";
}
if (l_rpt_Option == "DRCR")
    {
SQL = "  SELECT  TR_DATE_FMT,voucherno,REMARK2,REMARK,ACC_CODE,debit_amt,credit_amt,";
SQL += " pk, tr_date,debit_famt, credit_famt " ;
SQL += " FROM (  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
SQL += "       h.voucherno , r1.remark2 REMARK2, ";
SQL += "       r1.remark REMARK, sf_a_get_accd (tac_abacctcode_pk_cr,"+l_company_pk+") ACC_CODE, ";
SQL += "       r1.tr_bookamt debit_amt, 0 credit_amt, h.pk, h.tr_date,r1.TR_AMT debit_famt, 0 credit_famt, r1.pk r_pk,DECODE('" + p_acc_type + "','D',1) order_cond ";
SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
SQL += " WHERE h.del_if = 0 ";
SQL += "   AND r1.del_if = 0 ";
SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
SQL += "   AND r1.drcr_type = 'D' ";
SQL += "   AND r1.tac_abacctcode_pk_dr IN ("+ p_acc_pk_arr +") ";
SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from +"', 'YYYYMMDD') AND TO_DATE ('" + l_date_to +"', 'YYYYMMDD') ";
SQL += "     AND h.tco_company_pk = '" + l_company_pk +"' ";
SQL += " UNION ALL ";
SQL += "  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
SQL += "       h.voucherno, R2.remark2 REMARK2, ";
SQL += "       R2.remark REMARK , sf_a_get_accd (tac_abacctcode_pk_Dr,"+l_company_pk+") ACC_CODE, ";
SQL += "       0 debit_amt, R2.tr_bookamt credit_amt, h.pk, h.tr_date,0 debit_famt, r2.TR_AMT credit_famt,r2.pk r_pk,DECODE('" + p_acc_type + "','D',2)  order_cond";
SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
SQL += " WHERE h.del_if = 0 ";
SQL += "   AND R2.del_if = 0 ";
SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
SQL += "   AND R2.drcr_type = 'D' ";
SQL += "   AND R2.tac_abacctcode_pk_cr IN ("+ p_acc_pk_arr +") ";
SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from +"', 'YYYYMMDD') AND TO_DATE ('" + l_date_to +"', 'YYYYMMDD') ";
SQL += "     AND h.tco_company_pk = '" + l_company_pk +"' )";
SQL += "     ORDER BY tr_date,order_cond, voucherno,PK,r_pk";
}
else if (l_rpt_Option == "FIFO")
{
    SQL = "  SELECT  TR_DATE_FMT,voucherno,REMARK2,REMARK,ACC_CODE,debit_amt,credit_amt,";
    SQL += " pk, tr_date,debit_famt, credit_famt ";
    SQL += " FROM (  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno , r1.remark2 REMARK2, ";
    SQL += "       r1.remark REMARK, sf_a_get_accd (tac_abacctcode_pk_cr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       r1.tr_bookamt debit_amt, 0 credit_amt, h.pk, h.tr_date,r1.TR_AMT debit_famt, 0 credit_famt, r1.pk r_pk ";
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND r1.del_if = 0 ";
    SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
    SQL += "   AND r1.drcr_type = 'D' ";
    SQL += "   AND r1.tac_abacctcode_pk_dr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
    SQL += " UNION ALL ";
    SQL += "  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno, R2.remark2 REMARK2, ";
    SQL += "       R2.remark REMARK , sf_a_get_accd (tac_abacctcode_pk_Dr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       0 debit_amt, R2.tr_bookamt credit_amt, h.pk, h.tr_date,0 debit_famt, r2.TR_AMT credit_famt, r2.pk r_pk  ";
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND R2.del_if = 0 ";
    SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
    SQL += "   AND R2.drcr_type = 'D' ";
    SQL += "   AND R2.tac_abacctcode_pk_cr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' )";
    SQL += "     ORDER BY tr_date, PK,r_pk";
}  

//Response.Write(SQL);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_SocaiNKC_S03b-DN-2_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00020_SocaiNKC_S03b-DN-2_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00020_SocaiNKC_S03b-DN-2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tam</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-08-12T06:56:04Z</o:LastPrinted>
  <o:Created>2006-06-28T09:24:54Z</o:Created>
  <o:LastSaved>2008-08-12T07:04:16Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl62
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>So cai NKC (Mau so S03b-DN)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>68</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:LeftColumnVisible>1</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>10</x:SplitHorizontal>
     <x:TopRowBottomPane>10</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8490</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2325</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='So cai NKC (Mau so S03b-DN)'!$A$9:$K$9</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='So cai NKC (Mau so S03b-DN)'!$8:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1439 style='border-collapse:
 collapse;table-layout:fixed;width:1081pt'>
 <col class=xl25 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl25 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl25 width=292 span=2 style='mso-width-source:userset;mso-width-alt:
 10678;width:219pt'>
 <col class=xl25 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl25 width=117 span=4 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl80 width=552 style='height:14.25pt;
  width:415pt'><%= p_cmp_name %></td>
  <td class=xl24 width=292 style='width:219pt'></td>
  <td colspan=6 class=xl34 width=595 style='width:447pt'><span
  style='mso-spacerun:yes'> </span>M&#7851;u s&#7889; S03b-DN</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl81 width=552 style='height:14.25pt;
  width:415pt'><%= p_cmp_add %></td>
  <td class=xl26></td>
  <td colspan=6 class=xl72
  x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
  hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl80 style='height:15.75pt'>Mã s&#7889;
  thu&#7871;:<%= p_cmp_taxcode %></td>
  <td class=xl24></td>
  <td colspan=6 class=xl72>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897;
  tr&#432;&#7901;ng B&#7897; Tài chính)</td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=11 height=30 class=xl79 style='height:22.5pt' x:str="S&#7892; CÁI ">S&#7892;
  CÁI<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=11 height=26 class=xl72 style='height:19.5pt'>T&#7915; ngày <%= p_dt_from %>
  &#272;&#7871;n ngày <%= p_dt_to %></td>
 </tr>
 <tr class=xl32 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl33 colspan=2 style='height:19.5pt;mso-ignore:colspan'>S&#7889;
  hi&#7879;u tài kho&#7843;n:</td>
  <td class=xl34 x:num><%= p_acc_code %></td>
  <td colspan=7 class=xl33><%= p_acc_name %></td>
  <td class=xl32></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl35>&#272;&#417;n v&#7883; tính:</td>
  <td class=xl36><%= l_book_ccy %></td>
  <td class=xl32></td>
 </tr>
 <tr class=xl34 height=21 style='height:15.75pt'>
  <td rowspan=2 height=42 class=xl76 width=74 style='border-bottom:.5pt solid black;
  height:31.5pt;width:56pt'>Ngày tháng ghi s&#7893;</td>
  <td colspan=2 class=xl73 style='border-right:.5pt solid black;border-left:
  none'>Voucher</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Di&#7877;n
  gi&#7843;i</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Description</td>
  <td rowspan=2 class=xl76 width=63 style='border-bottom:.5pt solid black;
  width:47pt'>S&#7889; hi&#7879;u TK &#273;&#7889;i &#7913;ng</td>
  <td colspan=2 class=xl73 style='border-left:none'>S&#7889; ti&#7873;n
  (Ngo&#7841;i t&#7879;)</td>
  <td colspan=2 class=xl73>S&#7889; ti&#7873;n (ghi s&#7893;)</td>
  <td class=xl37>Ghi chú</td>
 </tr>
 <tr class=xl34 height=21 style='height:15.75pt'>
  <td height=21 class=xl38 id="_x0000_s1026" x:autofilter="all"
  style='height:15.75pt'>S&#7889;</td>
  <td class=xl39 id="_x0000_s1027" x:autofilter="all" width=86
  style='width:65pt'>Ngày tháng</td>
  <td class=xl38 id="_x0000_s1034" x:autofilter="all">N&#7907;</td>
  <td class=xl59 id="_x0000_s1035" x:autofilter="all">Có</td>
  <td class=xl38 id="_x0000_s1031" x:autofilter="all">N&#7907;</td>
  <td class=xl59 id="_x0000_s1032" x:autofilter="all">Có</td>
  <td class=xl70 id="_x0000_s1033" x:autofilter="all">Seq</td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl43 width=292 style='width:219pt'>S&#7888; D&#431; &#272;&#7846;U
  K&#7922;</td>
  <td class=xl43 width=292 style='width:219pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl44  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_open_trans_dr_xls%></td>
  <td class=xl71 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format%>';mso-text-control:shrinktofit;" x:num><%= p_open_trans_cr_xls%></td>
  <td class=xl44 style="mso-number-format:'<%= p_xls_ccy_format%>';mso-text-control:shrinktofit;" x:num><%= p_open_bal_dr_xls%></td>
  <td class=xl60 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_open_bal_cr_xls%></td>
  <td class=xl63 style='border-top:none'>&nbsp;</td>
 </tr>
 
 <%
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	string strDate = "";
	string strDate_Dsp = "";
	
	if (dt_detail.Rows.Count >0)
	{
		for(i=0;i<dt_detail.Rows.Count;i++)
		{
			if (strDate!= dt_detail.Rows[i][0].ToString())
			{
				strDate_Dsp = dt_detail.Rows[i][0].ToString();
				strDate = dt_detail.Rows[i][0].ToString();
			}
			else
			{
				strDate_Dsp = "";
			}
			
			if (i < dt_detail.Rows.Count)
			{
			//height=42 style='height:31.5pt'
 %>
 <tr class=xl32 height=42 style='height:31.5pt'>
  <td height=42 class=xl28 style='height:31.5pt' ><%= strDate_Dsp %></td>
  <td class=xl29 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl28 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;' ><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl57 width=292 style='border-left:none;width:219pt'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl57 width=292 style='border-left:none;width:219pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl45 x:num><%=dt_detail.Rows[i][4].ToString()%></td>
  
  <td class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num> <%=dt_detail.Rows[i][9].ToString()%></td>
  <td class=xl64 style='border-top:none;border-left:none'  style="mso-number-format:'<%= p_xls_ccy_format%>';;mso-text-control:shrinktofit;" x:num> <%=dt_detail.Rows[i][10].ToString()%></td>
  
  <td class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';;mso-text-control:shrinktofit;" x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl64 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';;mso-text-control:shrinktofit;" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl65 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><%= dt_detail.Rows[i][7].ToString() %></td>
 </tr>
 
 <% }
 else
{ %>
 
 <tr class=xl32 height=42 style='height:31.5pt'>
  <td height=42 class=xl31 style='height:31.5pt;border-top:none'><%= strDate_Dsp %></td>
  <td class=xl29 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;' ><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl58 width=292 style='width:219pt'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl58 width=292 style='width:219pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl45 x:num><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl46 style="mso-number-format:'<%= p_xls_ccy_format%>';;mso-text-control:shrinktofit;" x:num> <%=dt_detail.Rows[i][9].ToString()%></td>
  <td class=xl68 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format%>';;mso-text-control:shrinktofit;" x:num> <%=dt_detail.Rows[i][10].ToString()%></td>
  <td class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';;mso-text-control:shrinktofit;" x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl68 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';;mso-text-control:shrinktofit;" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%= dt_detail.Rows[i][7].ToString() %></td>
 </tr>
  <%
			}
		}
	}
 %>

 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl47 style='height:15.75pt'>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50 x:str="T&#7893;ng c&#7897;ng s&#7889; phát sinh"><span
  style='mso-spacerun:yes'> </span>T&#7893;ng c&#7897;ng s&#7889; phát
  sinh<span style='mso-spacerun:yes'> </span></td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_total_trans_debit_xls%></td>
  <td class=xl61 style='border-right:.5pt solid windowtext;'  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_total_trans_credit_xls%></td>
  <td class=xl50  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_debit_xls%></td>
  <td class=xl61 style='border-top:.5pt solid windowtext;'  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_credit_xls %></td>
  <td class=xl63 style=''>&nbsp;</td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl51 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54 width=292 style='width:219pt'>S&#7888; D&#431; CU&#7888;I
  K&#7922;</td>
  <td class=xl54 width=292 style='width:219pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl55  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_close_trans_dr_xls %></td>
  <td class=xl62 style="border-right:.5pt solid windowtext;mso-text-control:shrinktofit;" style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_close_trans_cr_xls %></td>
  <td class=xl55 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_close_bal_dr_xls %></td>
  <td class=xl62 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_close_bal_cr_xls %></td>
  <td class=xl63 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=11 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 colspan=10 class=xl27 style='height:24.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl72>Ngày ........ tháng ........ n&#259;m ...........</td>
  <td class=xl32></td>
 </tr>
<%
    SQL = "SELECT   " +
            "    D.CODE, " +
            "    D.CHAR_1,  " +
            "    D.CHAR_2,  " +
            "    D.CHAR_3,  " +
            "    D.CHAR_4,  " +
            "    D.CHAR_5,  " +
            "    D.REMARK " +
            " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
            " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
            " AND M.ID='EACAB012' " +
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
 %>  
 <tr class=xl32 height=23 style='height:17.25pt'>
  <td height=23 class=xl32 style='height:17.25pt'></td>
  <td class=xl34><%= v1 %></td>
  <td class=xl32></td>
  <td class=xl34><%= v2%></td>
  <td class=xl34></td>
  <td colspan=5 class=xl34><%= v3 %></td>
  <td class=xl32></td>
 </tr>
 <tr class=xl32 height=23 style='height:17.25pt'>
  <td height=23 class=xl32 style='height:17.25pt'></td>
  <td class=xl56><span style='mso-spacerun:yes'> </span><%= g1 %></td>
  <td class=xl32></td>
  <td class=xl56><%= g2 %></td>
  <td class=xl56></td>
  <td colspan=5 class=xl56><%= g3 %></td>
  <td class=xl32></td>
 </tr>
 <tr class=xl32 height=23 style='height:17.25pt'>
  <td height=23 colspan=11 class=xl32 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=23 style='height:17.25pt'>
  <td height=23 colspan=11 class=xl32 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
<tr class=xl32 height=23 style='height:17.25pt'>
  <td height=23 colspan=11 class=xl32 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=23 style='height:17.25pt'>
  <td height=23 colspan=11 class=xl32 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr> 
<tr class=xl32 height=23 style='height:17.25pt'>
  <td height=23 colspan=11 class=xl32 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
   <tr class=xl32 height=23 style='height:17.25pt'>
  <td height=23 class=xl32 style='height:17.25pt'></td>
  <td class=xl34><%= n1 %></td>
  <td class=xl32></td>
  <td class=xl34><%= n2%></td>
  <td class=xl34></td>
  <td colspan=5 class=xl34><%= n3 %></td>
  <td class=xl32></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
