<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
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
	string p_dt_from ="";
	string p_dt_to ="";

	string p_open_bal_dr_xls = "0";
	string p_open_bal_cr_xls = "0";
	string p_open_bal_drtran_xls = "0";
	string p_open_bal_crtran_xls = "0";
	string p_close_bal_dr_xls = "0";
	string p_close_bal_cr_xls = "0";
	string p_close_bal_drtran_xls = "0";
	string p_close_bal_crtran_xls = "0";
	
	string p_debit_xls ="0";
	string p_credit_xls ="0";
	string p_credit_trans_xls = "";
	string p_debit_trans_xls = "";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
    string p_acc_num = "";
	int i =0;
	
	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

    string SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][3].ToString();
    }

    SQL = " SELECT AC_CD,AC_LNM,UPPER(a.DRCR_TYPE),  to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += " to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date ,DECODE(UPPER(a.DRCR_TYPE),'D','1','-1') ";
	SQL += " FROM TAC_localCODE a WHERE a.pk = '" + l_account_pk + "' ";

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
SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), sf_get_format ('ACBG0040')) AS openingbalance, ";
SQL += "               TO_CHAR (NVL (debitbookamount, 0), sf_get_format ('ACBG0040')) AS debitbookamount, ";
SQL += "               TO_CHAR (NVL (creditbookamount, 0), sf_get_format ('ACBG0040')) AS creditbookamount, ";
SQL += "               TO_CHAR (NVL (closingbalance, 0), sf_get_format ('ACBG0040')) AS closingbalance, ";
SQL += "               NVL (openingbalance, 0) AS OB ";
//SQL += "               ,ccy ";
SQL += "          FROM (SELECT   tac_abacctcode_pk,";
SQL += "                         SUM (NVL (ymd_drbooks, 0)) debitbookamount, ";
SQL += "                         SUM (NVL (ymd_crbooks, 0)) creditbookamount ";
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
SQL += "                  FROM (SELECT NVL((SUM (NVL(this_drbal,0)) - SUM (NVL(this_crbal,0))),0) mr_amt ";
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
SQL += "                          FROM tac_hgddbal ";
SQL += "                         WHERE del_if = 0 ";
SQL += "                           AND tco_company_pk = '" + l_company_pk +"' ";
SQL += "                           AND tac_abacctcode_pk = '" + l_account_pk +"' ";
SQL += "                           AND tr_status = '" + l_status +"' ";
SQL += "                           AND (std_ymd BETWEEN '" + l_date_from +"' AND '" + l_date_to +"')) d) b ";
SQL += "         WHERE a.tac_abacctcode_pk(+) = b.tac_abacctcode_pk ";
*/
    SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), sf_get_format ('ACBG0040')) AS openingbalance, ";
    SQL += "               TO_CHAR (NVL (debitbookamount, 0), sf_get_format ('ACBG0040')) AS debitbookamount, ";
    SQL += "               TO_CHAR (NVL (creditbookamount, 0), sf_get_format ('ACBG0040')) AS creditbookamount, ";
    SQL += "               TO_CHAR (NVL (closingbalance, 0), sf_get_format ('ACBG0040')) AS closingbalance, ";
    SQL += "               NVL (openingbalance, 0) AS OB ,TO_CHAR(NVL(DEBIT_FAMT,0),sf_get_format ('ACBG0040')), TO_CHAR(NVL(CREDIT_FAMT,0),sf_get_format ('ACBG0040')),TO_CHAR(NVL(OPEN_TRANS,0),sf_get_format ('ACBG0040')),TO_CHAR(NVL(CLOSE_TRANS,0),sf_get_format ('ACBG0040')), NVL (OPEN_TRANS, 0) AS O_TRANS ";
    SQL += "          FROM ( ";
    SQL += "    SELECT TAC_localCODE_PK, SUM(openingbalance) openingbalance, SUM(OPEN_TRANS) OPEN_TRANS, " +
        "    SUM(debitbookamount) debitbookamount, SUM(creditbookamount) creditbookamount, SUM(DEBIT_FAMT) DEBIT_FAMT, " +
        "    SUM(CREDIT_FAMT) CREDIT_FAMT, (SUM(openingbalance)+ (SUM(debitbookamount) - SUM(creditbookamount))*TO_NUMBER('" + p_acc_num + "'))  closingbalance, " +
        "    (SUM(OPEN_TRANS) + (SUM(DEBIT_FAMT)-SUM(CREDIT_FAMT))*TO_NUMBER('" + p_acc_num + "')) CLOSE_TRANS " +
        "     " +
        "    FROM " +
        "    ( " +
        "    SELECT TAC_localCODE_PK,0 openingbalance,0 OPEN_TRANS ,SUM (NVL (ymd_drbooks, 0)) debitbookamount, " +
        "    SUM (NVL (ymd_crbooks, 0)) creditbookamount,SUM(NVL(YMD_DRTRANS,0)) DEBIT_FAMT, SUM(NVL(YMD_CRTRANS,0)) CREDIT_FAMT " +
        "    FROM TAC_HGDDBAL_local A " +
        "    WHERE A.DEL_IF =0  " +
        "    AND A.tco_company_pk = '" + l_company_pk + "' " +
        "    AND A.tac_localcode_pk = '" + l_account_pk + "'  " +
        "    AND a.tr_status = '" + l_status + "' " +
        "    AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "' " +
        "    GROUP BY tac_localcode_pk " +
        "    UNION ALL " +
        "    SELECT TAC_localCODE_PK," +
        "      (SUM(NVL(THIS_DRBAL,0)) - SUM (NVL(this_crbal,0)))*TO_NUMBER('" + p_acc_num + "')  openingbalance,   " +
        "      (SUM(NVL(THIS_DRFBAL,0)) - SUM (NVL(THIS_CRFBAL,0)))*TO_NUMBER('" + p_acc_num + "')  OPEN_TRANS, " +
        "        0 debitbookamount, 0 creditbookamount,0 DEBIT_FAMT, 0 CREDIT_FAMT " +
        "    FROM TAC_HGMMBAL_local B " +
        "    WHERE B.DEL_IF =0  " +
        "    AND tco_company_pk = '" + l_company_pk + "' " +
        "    AND tac_localcode_pk = '" + l_account_pk + "' " +
        "    AND tr_status = '" + l_status + "' " +
        "    AND std_ym = SUBSTR (sf_get_lastclosemm ('" + l_date_from + "','" + l_company_pk + "'),1,6) " +
        "    GROUP BY TAC_localCODE_PK " +
        "    UNION ALL " +
        "    SELECT TAC_localCODE_PK, " +
        "        (SUM(NVL(YMD_DRBOOKS,0)) - SUM (NVL(YMD_CRBOOKS,0)))*TO_NUMBER('" + p_acc_num + "')  openingbalance,   " +
        "      (SUM(NVL(YMD_DRTRANS,0)) - SUM (NVL(YMD_CRTRANS,0)))*TO_NUMBER('" + p_acc_num + "')  OPEN_TRANS, " +
        "        0 debitbookamount, 0 creditbookamount,0 DEBIT_FAMT, 0 CREDIT_FAMT " +
        "    FROM TAC_HGDDBAL_local " +
        "    WHERE del_if = 0 " +
        "    AND tco_company_pk = '" + l_company_pk + "'  " +
        "    AND tac_localcode_pk = '" + l_account_pk + "' " +
        "    AND tr_status = '" + l_status + "'  " +
        "    AND std_ymd  BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (sf_get_lastclosemm('" + l_date_from + "', '" + l_company_pk + "' ),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "        AND TO_CHAR (TO_DATE ('" + l_date_from + "','YYYYMMDD')- 1,'YYYYMMDD') " +
        "    GROUP BY TAC_localCODE_PK " +
        "    ) " +
        "    GROUP BY TAC_localCODE_PK ) ";
 
//'SQL = SQL & "         --  AND upper(ccy) LIKE DECODE('& l_ccy &','ALL','%%','& l_ccy &') "

	DataTable dt2 = ESysLib.TableReadOpen(SQL);

    if (dt2.Rows.Count >0)
    {
		if (p_acc_type =="D")
		{
			p_open_bal_dr_xls = dt2.Rows[0][0].ToString();
			p_close_bal_dr_xls = dt2.Rows[0][3].ToString();
			p_open_bal_drtran_xls = 	dt2.Rows[0][7].ToString();
			p_close_bal_drtran_xls = dt2.Rows[0][8].ToString();
		}
		else
		{
			p_open_bal_cr_xls = dt2.Rows[0][0].ToString();
			p_close_bal_cr_xls = dt2.Rows[0][3].ToString();
			p_open_bal_crtran_xls = 	dt2.Rows[0][7].ToString();
			p_close_bal_crtran_xls = dt2.Rows[0][8].ToString();			
		}
		p_debit_xls = dt2.Rows[0][1].ToString();
		p_credit_xls = dt2.Rows[0][2].ToString();
		p_debit_trans_xls = dt2.Rows[0][5].ToString();
		p_credit_trans_xls = dt2.Rows[0][6].ToString();
		
	    p_open_bal = dt2.Rows[0][4].ToString();
    }
	
SQL = " SELECT pk FROM tac_localcode  WHERE del_if = 0 AND leaf_yn = 'Y'  CONNECT BY pac_pk = PRIOR pk START WITH pk = " + l_account_pk;

DataTable dt3 = ESysLib.TableReadOpen(SQL);

string p_temp ="";
for (i=0;i<dt3.Rows.Count;i++)
{
	p_acc_pk_arr = p_acc_pk_arr + p_temp + dt3.Rows[i][0].ToString();
	p_temp = ",";
}
if (l_rpt_Option == "DRCR")
{
    SQL = "  SELECT  TR_DATE_FMT,voucherno,REMARK2,REMARK,ACC_CODE, debit_amt,credit_amt,";
    SQL += " pk, tr_date, debit_tramt, credit_tramt, pl_cd ";
    SQL += " FROM (  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno , r1.remark2 REMARK2, ";
    SQL += "       r1.remark REMARK, sf_a_get_accd1 (tac_abacctcode_pk_cr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       r1.tr_bookamt debit_amt, 0 credit_amt, h.pk, h.tr_date, r1.pk r_pk,DECODE('" + p_acc_type + "','D',1) order_cond, ";
	SQL += " r1.tr_amt debit_tramt, 0 credit_tramt, null pl_cd " ;
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1, v_abplcenter v ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND r1.del_if = 0 ";
    SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
    SQL += "   AND r1.drcr_type = 'D' ";
    SQL += "   AND r1.tac_abacctcode_pk_dr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
	SQL += " AND r1.tac_abplcenter_pk = v.tac_abplcenter_pk(+) " ;
    SQL += " UNION ALL ";
    SQL += "  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno, R2.remark2 REMARK2, ";
    SQL += "       R2.remark REMARK , sf_a_get_accd1 (tac_abacctcode_pk_Dr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       0 debit_amt, R2.tr_bookamt credit_amt, h.pk, h.tr_date,r2.pk r_pk,DECODE('" + p_acc_type + "','D',2)  order_cond, ";
	SQL += " 0 debit_tramt, R2.tr_amt credit_tramt, null pl_cd " ;
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2, v_abplcenter v ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND R2.del_if = 0 ";
    SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
    SQL += "   AND R2.drcr_type = 'D' ";
    SQL += "   AND R2.tac_abacctcode_pk_cr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND h.tco_company_pk = '" + l_company_pk + "'";
	SQL += " AND R2.tac_abplcenter_pk = v.tac_abplcenter_pk(+) ";
    SQL += " UNION ALL  SELECT TO_CHAR(h.tr_date, 'DD/MM/YYYY') tr_date_fmt, h.voucherno " +
        "     , r2.remark2 remark2, r2.remark remark " +
        "     , sf_a_get_accd1(tac_abacctcode_pk, '" + l_company_pk + "') acc_code, decode(DRCR_TYPE,'D',r2.tr_bookamt,0) debit_amt " +
        "     , decode(DRCR_TYPE,'C',r2.tr_bookamt,0) credit_amt, h.pk, h.tr_date, r2.pk r_pk " +
        "     , DECODE('" + p_acc_type + "', 'D', 2) order_cond " +
		" , decode(DRCR_TYPE,'D',r2.tr_amt,0) debit_tramt, decode(DRCR_TYPE,'C', r2.tr_amt,0) credit_tramt " +
		", null pl_cd " +
        "  FROM tac_hgtrh h, tac_hgtrd r2, v_abplcenter v " +
        " WHERE h.del_if = 0 AND r2.del_if = 0 AND h.pk = r2.tac_hgtrh_pk " +
        "       AND io_yn = 'Y' " +
        "   AND R2.tac_abacctcode_pk IN (" + p_acc_pk_arr + ") " +
        "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) " +
        "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') " + 
        "     AND h.tco_company_pk = '" + l_company_pk + "' " +
		" and r2.tac_abplcenter_pk = v.tac_abplcenter_pk(+) " +
		" )" +
        "     ORDER BY tr_date,order_cond,voucherno, PK,r_pk";  
		
}
else if (l_rpt_Option == "FIFO")
{

    SQL = "  SELECT  TR_DATE_FMT,voucherno,REMARK2,REMARK,ACC_CODE,debit_amt,credit_amt,";
    SQL += " pk, tr_date, debit_tramt, credit_tramt, pl_cd ";
    SQL += " FROM (  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno , r1.remark2 REMARK2, ";
    SQL += "       r1.remark REMARK, sf_a_get_accd1(tac_abacctcode_pk_cr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       r1.tr_bookamt debit_amt, 0 credit_amt, h.pk, h.tr_date, r1.pk r_pk, ";
	SQL += " r1.tr_amt debit_tramt, 0 credit_tramt, null pl_cd ";
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1, v_abplcenter v ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND r1.del_if = 0 ";
    SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
    SQL += "   AND r1.drcr_type = 'D' ";
    SQL += "   AND r1.tac_abacctcode_pk_dr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
	SQL += " and r1.tac_abplcenter_pk = v.tac_abplcenter_pk(+) ";
    SQL += " UNION ALL ";
    SQL += "  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno, R2.remark2 REMARK2, ";
    SQL += "       R2.remark REMARK , sf_a_get_accd1 (tac_abacctcode_pk_Dr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       0 debit_amt, R2.tr_bookamt credit_amt, h.pk, h.tr_date, r2.pk r_pk  ";
	SQL += ", 0 debit_tramt, R2.tr_amt credit_tramt, null pl_cd " ;
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2, v_abplcenter v ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND R2.del_if = 0 ";
    SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
    SQL += "   AND R2.drcr_type = 'D' ";
    SQL += "   AND R2.tac_abacctcode_pk_cr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
	SQL += " and R2.tac_abplcenter_pk = v.tac_abplcenter_pk(+) ";
    SQL += " UNION ALL  SELECT TO_CHAR(h.tr_date, 'DD/MM/YYYY') tr_date_fmt, h.voucherno " +
       "     , r2.remark2 remark2, r2.remark remark " +
       "     , sf_a_get_accd1(tac_abacctcode_pk, '" + l_company_pk + "') acc_code, decode(DRCR_TYPE,'D',r2.tr_bookamt,0) debit_amt " +
       "     , decode(DRCR_TYPE,'C',r2.tr_bookamt,0) credit_amt, h.pk, h.tr_date, r2.pk r_pk, " +
	   " decode(DRCR_TYPE, 'D', r2.tr_amt,0) debit_tramt, decode(DRCR_TYPE, 'C', r2.tr_amt,0) credit_tramt, null pl_cd " +
       "  FROM tac_hgtrh h, tac_hgtrd r2, v_abplcenter v " +
       " WHERE h.del_if = 0 AND r2.del_if = 0 AND h.pk = r2.tac_hgtrh_pk " +
       "       AND io_yn = 'Y' " +
       "   AND R2.tac_abacctcode_pk IN (" + p_acc_pk_arr + ") " +
       "     AND h.tr_status IN (" + l_status + ", DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) " +
       "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') " +
       "     AND h.tco_company_pk = '" + l_company_pk + "'" +
	   " and r2.tac_abplcenter_pk = v.tac_abplcenter_pk(+) " +
	  " )" +
      " ORDER BY tr_date,voucherno, PK,r_pk";  
}
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="CostCenter_files/filelist.xml">
<style id="CostCenter_21394_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl2421394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2521394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2621394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2721394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2821394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2921394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3021394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3121394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3221394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3321394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3421394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3521394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
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
	mso-pattern:auto none;
	white-space:nowrap;}
.xl3621394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl3721394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
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
	mso-pattern:auto none;
	white-space:nowrap;}
.xl3821394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl3921394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4021394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4121394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4221394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4321394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4421394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4521394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4621394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl4721394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4821394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4921394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5021394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5121394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5221394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5321394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5421394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5521394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5621394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5721394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5821394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5921394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6021394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6121394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
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
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6221394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl6321394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6421394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6521394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6621394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6721394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;}
.xl6821394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6921394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7021394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7121394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7221394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7321394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7421394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7521394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7621394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7721394
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="CostCenter_21394" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1294 class=xl2421394
 style='border-collapse:collapse;table-layout:fixed;width:970pt'>
 <col class=xl2421394 width=74 style='mso-width-source:userset;mso-width-alt:
 2706;width:56pt'>
 <col class=xl2421394 width=100 style='mso-width-source:userset;mso-width-alt:
 3657;width:75pt'>
 <col class=xl2421394 width=86 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col class=xl2421394 width=292 style='mso-width-source:userset;mso-width-alt:
 10678;width:219pt'>
 <col class=xl2421394 width=63 style='mso-width-source:userset;mso-width-alt:
 2304;width:47pt'>
 <col class=xl2421394 width=123 span=5 style='mso-width-source:userset;
 mso-width-alt:4498;width:92pt'>
 <col class=xl2421394 width=64 style='width:48pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl6821394 width=552 style='height:14.25pt;
  width:415pt'><%= p_cmp_name %></td>
  <td colspan=7 class=xl2621394 width=742 style='width:555pt'><span
  style='mso-spacerun:yes'> </span>Mẫu số S03b-DN</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl6921394 width=552 style='height:14.25pt;
  width:415pt'><%= p_cmp_add %></td>
  <td class=xl2521394 colspan=4 align=left
  x:str="(Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Ban hành theo
  Quyết định số 15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
  <td class=xl2521394></td>
  <td class=xl2521394></td>
  <td class=xl2521394></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl6821394 style='height:15.75pt'><%= p_cmp_taxcode %></td>
  <td class=xl2521394 colspan=4 align=left>20 tháng 03 năm 2006 của Bộ trường
  Bộ Tài chính)</td>
  <td class=xl2521394></td>
  <td class=xl2521394></td>
  <td class=xl2521394></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=7 height=30 class=xl2721394 style='height:22.5pt' x:str="SỔ CÁI ">SỔ
  CÁI<span style='mso-spacerun:yes'> </span></td>
  <td class=xl2721394></td>
  <td class=xl2721394></td>
  <td class=xl2721394></td>
  <td class=xl2421394></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=7 height=26 class=xl2821394 style='height:19.5pt'>Từ ngày
  <%= p_dt_from %> Đến ngày <%= p_dt_to %></td>
  <td class=xl2821394></td>
  <td class=xl2821394></td>
  <td class=xl2821394></td>
  <td class=xl2421394></td>
 </tr>
 <tr class=xl2521394 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl2921394 colspan=2 style='height:19.5pt'>Số hiệu tài
  khoản:</td>
  <td class=xl2621394><%= p_acc_code %></td>
  <td colspan=4 class=xl2921394><%= p_acc_name %></td>
  <td class=xl2921394></td>
  <td class=xl2921394></td>
  <td class=xl2921394></td>
  <td class=xl2521394></td>
 </tr>
 <tr class=xl2521394 height=21 style='height:15.75pt'>
  <td height=21 class=xl2521394 style='height:15.75pt'></td>
  <td class=xl2521394></td>
  <td class=xl2521394></td>
  <td class=xl2521394></td>
  <td class=xl2521394></td>
  <td class=xl3021394>Đơn vị tính:</td>
  <td class=xl3121394><%= l_book_ccy %></td>
  <td class=xl3021394></td>
  <td class=xl3121394></td>
  <td class=xl3121394></td>
  <td class=xl2521394></td>
 </tr>
 <tr class=xl2621394 height=21 style='height:15.75pt'>
  <td rowspan=2 height=42 class=xl7021394 width=74 style='border-bottom:.5pt solid black;
  height:31.5pt;width:56pt'>Ngày tháng ghi sổ</td>
  <td colspan=2 class=xl7221394 style='border-right:.5pt solid black;
  border-left:none'>Voucher</td>
  <td rowspan=2 class=xl7421394 style='border-bottom:.5pt solid black'>Diễn
  giải</td>
  <td rowspan=2 class=xl7021394 width=63 style='border-bottom:.5pt solid black;
  width:47pt'>Số hiệu TK đối ứng</td>
  <td colspan=2 class=xl7221394 style='border-right:.5pt solid black;
  border-left:none'>Số tiền(USD)</td>
  <td colspan=2 class=xl7721394 style='border-right:.5pt solid black;
  border-left:none'>Số tiền(VND)</td>
  <td rowspan=2 class=xl7421394 style='border-bottom:.5pt solid black'>Cost
  Center</td>
  <td class=xl3221394>Ghi chú</td>
 </tr>
 <tr class=xl2621394 height=21 style='height:15.75pt'>
  <td height=21 class=xl3321394 style='height:15.75pt'>Số</td>
  <td class=xl3421394 width=86 style='width:65pt'>Ngày tháng</td>
  <td class=xl3321394>Nợ</td>
  <td class=xl3321394>Có</td>
  <td class=xl3321394>Nợ</td>
  <td class=xl3321394>Có</td>
  <td class=xl3321394>Seq</td>
 </tr>
 <tr class=xl2521394 height=21 style='height:15.75pt'>
  <td height=21 class=xl3521394 style='height:15.75pt'>&nbsp;</td>
  <td class=xl3621394>&nbsp;</td>
  <td class=xl3721394>&nbsp;</td>
  <td class=xl3821394 width=292 style='width:219pt'>SỐ DƯ ĐẦU KỲ</td>
  <td class=xl3621394>&nbsp;</td>
  <td class=xl3921394 x:num><span
  style='mso-spacerun:yes'> </span><%= p_open_bal_dr_xls%> </td>
  <td class=xl3921394 x:num><span style='mso-spacerun:yes'> </span><%= p_open_bal_cr_xls%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl4021394 x:num><span
  style='mso-spacerun:yes'> </span><%= p_open_bal_drtran_xls%> </td>
  <td class=xl4021394 x:num><span style='mso-spacerun:yes'> </span><%= p_open_bal_crtran_xls%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl4121394>&nbsp;</td>
  <td class=xl4221394>&nbsp;</td>
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
 %>
 <tr class=xl2521394 height=21 style='height:15.75pt'>
  <td height=21 class=xl4321394 style='height:15.75pt'><%= strDate_Dsp %></td>
  <td class=xl4421394><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl4521394><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl4621394 align=left width=292 style='width:219pt'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl4721394><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl4821394 x:num><span
  style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i][5].ToString()%> </td>
  <td class=xl4821394 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl4821394 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><span
  style='mso-spacerun:yes'> </span><%= dt_detail.Rows[i][9].ToString() %> </td>
  <td class=xl4921394 x:num ><span style='mso-spacerun:yes'> </span><%= dt_detail.Rows[i][10].ToString() %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl4921394><%= dt_detail.Rows[i][11].ToString() %></td>
  <td class=xl5021394 align="right" x:num><%= dt_detail.Rows[i][7].ToString() %></td>
 </tr>
  <%
	}
	else
	{
 %>

 <tr class=xl2521394 height=21 style='height:15.75pt'>
  <td height=21 class=xl4321394 style='height:15.75pt;border-top:none'><%= strDate_Dsp %></td>
  <td class=xl4421394 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl4521394 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%= dt_detail.Rows[i][0].ToString() %></td>
  <td class=xl4621394 align=left width=292 style='border-top:none;width:219pt;border-left:none;width:219pt'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl4721394><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl4821394 x:num><span
  style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i][5].ToString()%>  </td>
  <td class=xl4821394 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num ><span style='mso-spacerun:yes'> </span><%= dt_detail.Rows[i][6].ToString() %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl4821394 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><span
  style='mso-spacerun:yes'> </span><%= dt_detail.Rows[i][9].ToString() %> </td>
  <td class=xl4921394 x:num><span style='mso-spacerun:yes'> </span><%= dt_detail.Rows[i][10].ToString() %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl4921394><%= dt_detail.Rows[i][11].ToString() %></td>
  <td class=xl5021394 align=right x:num><%= dt_detail.Rows[i][7].ToString() %></td>
 </tr>
	<%
		}
	}
}	
	%> 
 <tr class=xl2521394 height=21 style='height:15.75pt'>
  <td height=21 class=xl5121394 style='height:15.75pt'>&nbsp;</td>
  <td class=xl5221394>&nbsp;</td>
  <td class=xl5321394>&nbsp;</td>
  <td class=xl5421394 x:str><span
  style='mso-spacerun:yes'> </span>Tổng cộng số phát sinh<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl5421394>&nbsp;</td>
  <td class=xl5521394 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num ><span
  style='mso-spacerun:yes'> </span><%= p_debit_xls%> </td>
  <td class=xl5521394 style="border-top:.5pt solid windowtext;border-right:.5pt solid windowtext;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format %>';" x:num ><span
  style='mso-spacerun:yes'> </span><%= p_credit_xls %> </td>
  <td class=xl5621394 x:num ><span
  style='mso-spacerun:yes'> </span><%= p_debit_trans_xls%> </td>
  <td class=xl5721394 x:num><span
  style='mso-spacerun:yes'> </span><%= p_credit_trans_xls %> </td>
  <td class=xl5721394>&nbsp;</td>
  <td class=xl5821394>&nbsp;</td>
 </tr>
 <tr class=xl2521394 height=21 style='height:15.75pt'>
  <td height=21 class=xl5921394 style='height:15.75pt'>&nbsp;</td>
  <td class=xl6021394>&nbsp;</td>
  <td class=xl6121394>&nbsp;</td>
  <td class=xl6221394 width=292 style='width:219pt'>SỐ DƯ CUỐI KỲ</td>
  <td class=xl6021394>&nbsp;</td>
  <td class=xl6321394 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><span
  style='mso-spacerun:yes'> </span><%= p_close_bal_dr_xls %> </td>
  <td class=xl6321394 style="mso-number-format:'<%= p_xls_ccy_format %>';border-right:.5pt solid windowtext;mso-text-control:shrinktofit;" x:num><span style='mso-spacerun:yes'> </span><%= p_close_bal_cr_xls %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl6421394 x:num><span
  style='mso-spacerun:yes'> </span><%=p_close_bal_drtran_xls%> </td>
  <td class=xl6421394 x:num><span style='mso-spacerun:yes'> </span><%=p_close_bal_crtran_xls%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl4121394>&nbsp;</td>
  <td class=xl4221394>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2421394 style='height:15.0pt'></td>
  <td class=xl2421394></td>
  <td class=xl2421394></td>
  <td class=xl2421394></td>
  <td class=xl2421394></td>
  <td class=xl2421394></td>
  <td class=xl2421394></td>
  <td class=xl2421394></td>
  <td class=xl2421394></td>
  <td class=xl2421394></td>
  <td class=xl2421394></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl6521394 style='height:24.0pt'></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl2421394></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl6521394 style='height:15.0pt'></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl6521394></td>
  <td class=xl2421394></td>
 </tr>
 <tr class=xl2521394 height=21 style='height:15.75pt'>
  <td height=21 class=xl2521394 style='height:15.75pt'></td>
  <td class=xl2521394></td>
  <td class=xl2521394></td>
  <td class=xl2521394></td>
  <td colspan=3 class=xl2821394>Ngày 21 tháng 06 năm 2010</td>
  <td class=xl2821394></td>
  <td class=xl2821394></td>
  <td class=xl2821394></td>
  <td class=xl2521394></td>
 </tr>
 <tr class=xl2621394 height=42 style='height:31.5pt'>
  <td height=42 class=xl2621394 style='height:31.5pt'></td>
  <td class=xl6621394 width=100 style='width:75pt'>Người lập biểu</td>
  <td class=xl2621394></td>
  <td class=xl6621394 width=292 style='width:219pt'>Kế toán trưởng</td>
  <td class=xl6621394 width=63 style='width:47pt'></td>
  <td colspan=3 class=xl6621394 width=369 style='width:276pt'>Tổng Giám đốc</td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
 </tr>
 <tr class=xl2621394 height=21 style='height:15.75pt'>
  <td height=21 class=xl2621394 style='height:15.75pt'></td>
  <td class=xl6721394><span style='mso-spacerun:yes'> </span>( Ký, họ tên )</td>
  <td class=xl2621394></td>
  <td class=xl6721394>( Ký, họ tên )</td>
  <td class=xl6721394></td>
  <td colspan=3 class=xl6721394>( Ký, họ tên, đóng dấu )</td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
 </tr>
 <tr class=xl2621394 height=21 style='height:15.75pt'>
  <td height=21 class=xl2621394 style='height:15.75pt'></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
 </tr>
 <tr class=xl2621394 height=21 style='height:15.75pt'>
  <td height=21 class=xl2621394 style='height:15.75pt'></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
 </tr>
 <tr class=xl2621394 height=21 style='height:15.75pt'>
  <td height=21 class=xl2621394 style='height:15.75pt'></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
 </tr>
 <tr class=xl2621394 height=21 style='height:15.75pt'>
  <td height=21 class=xl2621394 style='height:15.75pt'></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
 </tr>
 <tr class=xl2621394 height=21 style='height:15.75pt'>
  <td height=21 class=xl2621394 style='height:15.75pt'></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
 </tr>
 <tr class=xl2621394 height=21 style='height:15.75pt'>
  <td height=21 class=xl2621394 style='height:15.75pt'></td>
  <td class=xl6621394 width=100 style='width:75pt'>ÔNG A</td>
  <td class=xl2621394></td>
  <td class=xl6621394 width=292 style='width:219pt'>ÔNG B</td>
  <td class=xl6621394 width=63 style='width:47pt'></td>
  <td colspan=3 class=xl6621394 width=369 style='width:276pt'>ÔNG C</td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
  <td class=xl2621394></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
