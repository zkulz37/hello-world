<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
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
	string p_dt_from ="";
	string p_dt_to ="";

	string p_open_bal_dr_xls = "0";
	string p_open_bal_cr_xls = "0";
	string p_close_bal_dr_xls = "0";
	string p_close_bal_cr_xls = "0";
	string p_debit_xls ="0";
	string p_credit_xls ="0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
    string p_acc_num = "";
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

     SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][3].ToString();
    }

    SQL = " SELECT AC_CD,AC_NM,UPPER(a.DRCR_TYPE),  to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += " to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date ,DECODE(UPPER(a.DRCR_TYPE),'D','1','-1') ";
	SQL += " FROM TAC_ABACCTCODE a WHERE a.pk = '" + l_account_pk + "' ";

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
    SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS openingbalance, ";
    SQL += "               TO_CHAR (NVL (debitbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS debitbookamount, ";
    SQL += "               TO_CHAR (NVL (creditbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS creditbookamount, ";
    SQL += "               TO_CHAR (NVL (closingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS closingbalance, ";
    SQL += "               NVL (openingbalance, 0) AS OB ,TO_CHAR(NVL(DEBIT_FAMT,0),ac_SF_GET_FORMAT ('ACBG0040')), TO_CHAR(NVL(CREDIT_FAMT,0),ac_SF_GET_FORMAT ('ACBG0040')),TO_CHAR(NVL(OPEN_TRANS,0),ac_SF_GET_FORMAT ('ACBG0040')),TO_CHAR(NVL(CLOSE_TRANS,0),ac_SF_GET_FORMAT ('ACBG0040')), NVL (OPEN_TRANS, 0) AS O_TRANS ";
    SQL += "          FROM ( ";
    SQL += "    SELECT TAC_ABACCTCODE_PK, SUM(openingbalance) openingbalance, SUM(OPEN_TRANS) OPEN_TRANS, " +
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
        "    AND upper(a.tco_company_pk) like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" + 
        "    AND A.tac_abacctcode_pk = '" + l_account_pk + "'  " +
        "    AND a.tr_status = '" + l_status + "' " +
        "    AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "' " +
        "    GROUP BY tac_abacctcode_pk " +
        "    UNION ALL " +
        "    SELECT TAC_ABACCTCODE_PK," +
        "      (SUM(NVL(THIS_DRBAL,0)) - SUM (NVL(this_crbal,0)))*TO_NUMBER('" + p_acc_num + "')  openingbalance,   " +
        "      (SUM(NVL(THIS_DRFBAL,0)) - SUM (NVL(THIS_CRFBAL,0)))*TO_NUMBER('" + p_acc_num + "')  OPEN_TRANS, " +
        "        0 debitbookamount, 0 creditbookamount,0 DEBIT_FAMT, 0 CREDIT_FAMT " +
        "    FROM TAC_HGMMBAL B " +
        "    WHERE B.DEL_IF =0  " +
        "    AND upper(tco_company_pk) like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" + 
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
        "    AND upper(tco_company_pk) like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" + 
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
		}
		else
		{
			p_open_bal_cr_xls = dt2.Rows[0][0].ToString();
			p_close_bal_cr_xls = dt2.Rows[0][3].ToString();
		}
		p_debit_xls = dt2.Rows[0][1].ToString();
		p_credit_xls = dt2.Rows[0][2].ToString();
	    p_open_bal = dt2.Rows[0][4].ToString();
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
    SQL += " pk, tr_date, sf_get_buspartner_id(tco_buspartner_pk) partner_id, sf_get_buspartner_nm(tco_buspartner_pk) partner_name, pl_cd, pl_nm  ";
    SQL += " FROM (  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno , r1.remark2 REMARK2, ";
    SQL += "       r1.remark REMARK, sf_a_get_accd (tac_abacctcode_pk_cr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       r1.tr_bookamt debit_amt, 0 credit_amt, h.pk, h.tr_date, r1.pk r_pk, DECODE ('D', 'D', 2) order_cond,(select d.tco_buspartner_pk "; 
    SQL += "                 from tac_hgtrd d ";
    SQL += "                where     d.del_if = 0";
    SQL += "                      and d.tac_hgtrh_pk = h.pk";
    SQL += "                      and d.pk = r1.tac_hgtrd_pk) tco_buspartner_pk , AC_SF_GET_PL_FROM_PLCD(r1.TAC_ABPLCENTER_PK)pl_cd,ac_get_PL_FROM_PLCENTER(r1.TAC_ABPLCENTER_PK)pl_nm  ";
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND r1.del_if = 0 ";
    SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
    SQL += "   AND r1.drcr_type = 'D' ";
    SQL += "   AND r1.tac_abacctcode_pk_dr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND upper(h.tco_company_pk) like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
    SQL += " UNION ALL ";
    SQL += "  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno, R2.remark2 REMARK2, ";
    SQL += "       R2.remark REMARK , sf_a_get_accd (tac_abacctcode_pk_Dr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       0 debit_amt, R2.tr_bookamt credit_amt, h.pk, h.tr_date,r2.pk r_pk,DECODE('" + p_acc_type + "','D',2)  order_cond,(select d.tco_buspartner_pk "; 
    SQL += "                 from tac_hgtrd d ";
    SQL += "                where     d.del_if = 0";
    SQL += "                      and d.tac_hgtrh_pk = h.pk";
    SQL += "                      and d.pk = r2.tac_hgtrd_pk) tco_buspartner_pk, AC_SF_GET_PL_FROM_PLCD(r2.TAC_ABPLCENTER_PK)pl_cd,ac_get_PL_FROM_PLCENTER(r2.TAC_ABPLCENTER_PK)pl_nm   ";
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND R2.del_if = 0 ";
    SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
    SQL += "   AND R2.drcr_type = 'D' ";
    SQL += "   AND R2.tac_abacctcode_pk_cr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND upper(h.tco_company_pk) like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
    SQL += " UNION ALL  SELECT TO_CHAR(h.tr_date, 'DD/MM/YYYY') tr_date_fmt, h.voucherno " +
        "     , r2.remark2 remark2, r2.remark remark " +
        "     , sf_a_get_accd(tac_abacctcode_pk, '" + l_company_pk + "') acc_code, decode(DRCR_TYPE,'D',r2.tr_bookamt,0)  debit_amt " +
        "     , decode(DRCR_TYPE,'C',r2.tr_bookamt,0) credit_amt, h.pk, h.tr_date, r2.pk r_pk " +
        "     , DECODE('" + p_acc_type + "', 'D', 2) order_cond, r2.tco_buspartner_pk tco_buspartner_pk, AC_SF_GET_PL_FROM_PLCD(r2.TAC_ABPLCENTER_PK)pl_cd,ac_get_PL_FROM_PLCENTER(r2.TAC_ABPLCENTER_PK)pl_nm " +
        "  FROM tac_hgtrh h, tac_hgtrd r2 " +
        " WHERE h.del_if = 0 AND r2.del_if = 0 AND h.pk = r2.tac_hgtrh_pk " +
        "       AND io_yn = 'Y' " +
        "   AND R2.tac_abacctcode_pk IN (" + p_acc_pk_arr + ") " +
        "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) " +
        "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') " +
        "     AND upper(h.tco_company_pk) like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "'))" + 
        "     ORDER BY tr_date,order_cond,voucherno, PK,r_pk";
  
}
else if (l_rpt_Option == "FIFO")
{

    SQL = "  SELECT  TR_DATE_FMT,voucherno,REMARK2,REMARK,ACC_CODE,debit_amt,credit_amt,";
    SQL += " pk, tr_date  ";
    SQL += " FROM (  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno , r1.remark2 REMARK2, ";
    SQL += "       r1.remark REMARK, sf_a_get_accd (tac_abacctcode_pk_cr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       r1.tr_bookamt debit_amt, 0 credit_amt, h.pk, h.tr_date, r1.pk r_pk  ";
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND r1.del_if = 0 ";
    SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
    SQL += "   AND r1.drcr_type = 'D' ";
    SQL += "   AND r1.tac_abacctcode_pk_dr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND upper(h.tco_company_pk) like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
    SQL += " UNION ALL ";
    SQL += "  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
    SQL += "       h.voucherno, R2.remark2 REMARK2, ";
    SQL += "       R2.remark REMARK , sf_a_get_accd (tac_abacctcode_pk_Dr," + l_company_pk + ") ACC_CODE, ";
    SQL += "       0 debit_amt, R2.tr_bookamt credit_amt, h.pk, h.tr_date, r2.pk r_pk  ";
    SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
    SQL += " WHERE h.del_if = 0 ";
    SQL += "   AND R2.del_if = 0 ";
    SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
    SQL += "   AND R2.drcr_type = 'D' ";
    SQL += "   AND R2.tac_abacctcode_pk_cr IN (" + p_acc_pk_arr + ") ";
    SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
    SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "     AND upper(h.tco_company_pk) like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
    SQL += " UNION ALL  SELECT TO_CHAR(h.tr_date, 'DD/MM/YYYY') tr_date_fmt, h.voucherno " +
       "     , r2.remark2 remark2, r2.remark remark " +
       "     , sf_a_get_accd(tac_abacctcode_pk, '" + l_company_pk + "') acc_code, decode(DRCR_TYPE,'D',r2.tr_bookamt,0)  debit_amt " +
       "     , decode(DRCR_TYPE,'C',r2.tr_bookamt,0) credit_amt, h.pk, h.tr_date, r2.pk r_pk " +
       "  FROM tac_hgtrh h, tac_hgtrd r2 " +
       " WHERE h.del_if = 0 AND r2.del_if = 0 AND h.pk = r2.tac_hgtrh_pk " +
       "       AND io_yn = 'Y' " +
       "   AND R2.tac_abacctcode_pk IN (" + p_acc_pk_arr + ") " +
       "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) " +
       "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') " +
       "     AND upper(h.tco_company_pk) like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "'))" + 
       "        ORDER BY tr_date,voucherno, PK,r_pk";
  
}
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_SocaiNKC_S03b-DN_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00020_SocaiNKC_S03b-DN_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00020_SocaiNKC_S03b-DN_files/oledata.mso">
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
  <o:LastPrinted>2008-05-05T07:32:53Z</o:LastPrinted>
  <o:Created>2006-06-28T09:24:54Z</o:Created>
  <o:LastSaved>2008-06-10T08:19:11Z</o:LastSaved>
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
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl36
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
.xl37
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
	border-left:none;
	white-space:normal;}
.xl39
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
.xl40
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
.xl41
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
.xl42
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
.xl43
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
.xl44
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
.xl45
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
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
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
.xl48
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
.xl49
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
.xl50
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
.xl51
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
.xl52
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
.xl53
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
.xl54
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
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl56
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
.xl57
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
.xl58
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
.xl59
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
.xl60
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
.xl61
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
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl63
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
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl65
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
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
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
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl72
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
.xl73
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
	border-left:.5pt solid windowtext;}
.xl75
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
.xl76
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
.xl77
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
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
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
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$8:$D$9</x:RangeSelection>
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
  <x:Formula>='So cai NKC (Mau so S03b-DN)'!$A$9:$I$9</x:Formula>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1217 style='border-collapse: collapse;table-layout:fixed;width:913pt'>
 <col class=xl25 width=74 style='mso-width-source:userset;mso-width-alt:2706; width:56pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3657; width:75pt'>
 <col class=xl25 width=86 style='mso-width-source:userset;mso-width-alt:3145; width:65pt'>
 <col class=xl25 width=292 span=2 style='mso-width-source:userset;mso-width-alt: 10678;width:219pt'>
 <col class=xl25 width=63 style='mso-width-source:userset;mso-width-alt:2304; width:47pt'>
 <col class=xl25 width=123 span=2 style='mso-width-source:userset;mso-width-alt: 4498;width:92pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <col class=xl25 width=123  style='mso-width-source:userset;mso-width-alt: 4498;width:92pt'>
 <col class=xl25 width=292 style='mso-width-source:userset;mso-width-alt: 10678;width:219pt'>
 <col class=xl25 width=123  style='mso-width-source:userset;mso-width-alt: 2000;width:92pt'>
 <col class=xl25 width=292 style='mso-width-source:userset;mso-width-alt: 5000;width:219pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl68 width=552 style='height:14.25pt;
  width:415pt'><%= p_cmp_name %></td>
  <td class=xl24 width=292 style='width:219pt'></td>
  <td colspan=4 class=xl33 width=373 style='width:279pt'><span
  style='mso-spacerun:yes'> </span>Form number: S03b-DN</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl69 width=552 style='height:14.25pt;
  width:415pt'><%= p_cmp_add %></td>
  <td class=xl26></td>
  <td class=xl31 colspan=4 align=left style='mso-ignore:colspan'>(Issued with Decision No. 15/2006/QĐ-BTC  <span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl68 style='height:15.75pt'>Tax code: <%= p_cmp_taxcode %></td>
  <td class=xl24></td>
  <td class=xl31 colspan=4 align=left style='mso-ignore:colspan'>dated March 20, 2006 by Ministry of Finance)</td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=12 height=30 class=xl70 style='height:22.5pt' >GENERAL LEDGER<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=12 height=26 class=xl71 style='height:19.5pt'>To date <%= p_dt_from %>
  from date <%= p_dt_to %></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl31 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl32 colspan=2 style='height:19.5pt;mso-ignore:colspan'>Account code</td>
  <td class=xl33 ><%= p_acc_code %></td>
  <td colspan=5 class=xl32><%= p_acc_name %></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl34>Unit:</td>
  <td class=xl35><%= l_book_ccy %></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl33 height=21 style='height:15.75pt'>
  <td rowspan=2 height=42 class=xl72 width=74 style='border-bottom:.5pt solid black;
  height:31.5pt;width:56pt'>Date entered</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:
  none'>Voucher</td>
  <td rowspan=2 class=xl36 style='border-bottom:.5pt solid black'>Local Description</td>
  <td rowspan=2 class=xl36 style='border-bottom:.5pt solid black'>Description</td>
  <td rowspan=2 class=xl72 width=63 style='border-bottom:.5pt solid black;
  width:47pt'>Account code</td>
  <td colspan=2 class=xl74 style='border-left:none'>Amount</td>
  <td class=xl36>Notes</td>
  <td colspan='2' class=xl36 style='border-bottom:.5pt solid windowtext'>Customer</td>
  <td colspan='2' class=xl36 style='border-bottom:.5pt solid windowtext'>PL</td>
 </tr>
 <tr class=xl33 height=21 style='height:15.75pt'>
  <td height=21 class=xl37 id="_x0000_s1026" x:autofilter="all"
  style='height:15.75pt'>No.</td>
  <td class=xl38 id="_x0000_s1027" x:autofilter="all" width=86
  style='width:65pt'>Date</td>
  <td class=xl37 id="_x0000_s1031" x:autofilter="all">Debit</td>
  <td class=xl58 id="_x0000_s1032" x:autofilter="all" style='border-right:.5pt solid windowtext;'>Credit</td>
  <td class=xl67 id="_x0000_s1033" x:autofilter="all">Seq</td>
  <td class=xl67 id="_x0000_s1033" x:autofilter="all">Code</td>
  <td class=xl67 id="_x0000_s1033" x:autofilter="all">Name</td>
  <td class=xl67 id="_x0000_s1033" x:autofilter="all">Code</td>
  <td class=xl67 id="_x0000_s1033" x:autofilter="all">Name</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42 width=292 style='width:219pt'>Opening Balance</td>
  <td class=xl42 width=292 style='width:219pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl43 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_open_bal_dr_xls%></td>
  <td class=xl59 style="mso-number-format:'<%= p_xls_ccy_format %>';border-right:.5pt solid windowtext;mso-text-control:shrinktofit;" x:num><%= p_open_bal_cr_xls%></td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
 </tr>
  <%
      //Response.Write(SQL);
      //Response.End();  
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
 <tr class=xl31 style='mso-height-source:auto'>
  <td class=xl28 ><%= strDate_Dsp %></td>
  <td class=xl29 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl28 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;' ><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl56 align=left width=292 style='border-left:none;width:219pt'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl56 align=left width=292 style='border-left:none;width:219pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl44 ><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl45 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl63 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl64 style='border-top:none;border-left:none' x:num><%= dt_detail.Rows[i][7].ToString() %></td>
  <td class=xl64 style='border-top:none;border-left:none;white-space:normal' ><%= dt_detail.Rows[i][9].ToString() %></td>
  <td class=xl64 style='border-top:none;border-left:none;white-space:normal' ><%= dt_detail.Rows[i][10].ToString() %></td>
  <td class=xl64 style='border-top:none;border-left:none;white-space:normal' ><%= dt_detail.Rows[i]["pl_cd"].ToString() %></td>
  <td class=xl64 style='border-top:none;border-left:none;white-space:normal' ><%= dt_detail.Rows[i]["pl_nm"].ToString() %></td>
 </tr>
 <% }
 else
{ %>
 <tr class=xl31 style='mso-height-source:auto'>
  <td class=xl30 style='border-top:none'><%= strDate_Dsp %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl57 align=left width=292 style='width:219pt'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl57 align=left width=292 style='width:219pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl44 ><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl45  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl65 style='border-top:none;border-left:none'  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl66 style='border-top:none;border-left:none' x:num><%= dt_detail.Rows[i][7].ToString() %></td>
  <td class=xl66 style='border-top:none;border-left:none;white-space:normal' ><%= dt_detail.Rows[i][9].ToString() %></td>
  <td class=xl66 style='border-top:none;border-left:none;white-space:normal' ><%= dt_detail.Rows[i][10].ToString() %></td>
  <td class=xl66 style='border-top:none;border-left:none;white-space:normal' ><%= dt_detail.Rows[i]["pl_cd"].ToString() %></td>
  <td class=xl66 style='border-top:none;border-left:none;white-space:normal' ><%= dt_detail.Rows[i]["pl_nm"].ToString() %></td>
 </tr>
 <%
			}
		}
	}
 %>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt'>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl49 ><span
  style='mso-spacerun:yes'> </span>Total Amount Incurred<span style='mso-spacerun:yes'> </span></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_debit_xls%></td>
  <td class=xl60 style='border-top:.5pt solid windowtext;border-right:.5pt solid windowtext;mso-text-control:shrinktofit;' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_credit_xls %></td>
  <td class=xl62 >&nbsp;</td>
  <td class=xl62 >&nbsp;</td>
  <td class=xl62 >&nbsp;</td>
  <td class=xl62 >&nbsp;</td>
  <td class=xl62 >&nbsp;</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl50 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53 width=292 style='width:219pt'>Closing Balane</td>
  <td class=xl53 width=292 style='width:219pt'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl54  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_close_bal_dr_xls %></td>
  <td class=xl61  style="mso-number-format:'<%= p_xls_ccy_format %>';border-right:.5pt solid windowtext;mso-text-control:shrinktofit;" x:num><%= p_close_bal_cr_xls %></td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 colspan=8 class=xl27 style='height:24.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=8 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl71>Date <%= l_date_to.Substring(6, 2) %>/<%= l_date_to.Substring(4, 2) %>/<%= l_date_to.Substring(0, 4) %></td>
  <td class=xl31></td>
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
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'></td>
  <td class=xl33><%= v4 %></td>
  <td class=xl31></td>
  <td class=xl33><%= v5%></td>
  <td class=xl33></td>
  <td colspan=3 class=xl33><%= v6 %></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'></td>
  <td class=xl55><span style='mso-spacerun:yes'> </span><%= g4 %></td>
  <td class=xl31></td>
  <td class=xl55><%= g5 %></td>
  <td class=xl55></td>
  <td colspan=3 class=xl55><%= g6 %></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'></td>
  <td class=xl33><%= n4 %></td>
  <td class=xl31></td>
  <td class=xl33><%= n5%></td>
  <td class=xl33></td>
  <td colspan=3 class=xl33><%= n6 %></td>
  <td class=xl31></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>


