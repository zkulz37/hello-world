<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company_pk = "" + Request["company_pk"];
	string l_account_pk = "" + Request["account_pk"];
	string l_date_from	= ""+ Request["dtbFrom"];
	string l_date_to = "" + Request["dtbTo"];
	string l_ccy = ""+Request["ccy"];
	string l_status = "" +Request["status"];
	string l_book_ccy = ""+Request["bookccy"];
	
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_dt_from ="";
	string p_dt_to ="";
    string p_acc_num = "";

	string p_open_bal_xls = "0";
	string p_close_bal_xls = "0";
	string p_debit_xls = "0";
	string p_credit_xls = "0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
	string p_temp ="";
	string strDate = "";
	string strDate_Dsp = "";

	
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
	
	string SQL = " SELECT partner_lname, addr2, tax_code  FROM tco_company WHERE pk = '" + l_company_pk + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
    }
	
	SQL = " SELECT AC_CD,AC_NM || ' - ' || AC_LNM ac_nm, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += " to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date, DECODE (UPPER(drcr_type), 'D', 1, -1)  ";
	SQL += " FROM TAC_ABACCTCODE a WHERE a.pk = '" + l_account_pk + "' ";

	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if(dt1.Rows.Count>0)
	{
		p_acc_code = dt1.Rows[0][0].ToString();
	    p_acc_name = dt1.Rows[0][1].ToString();
	    p_dt_from = dt1.Rows[0][2].ToString();
		p_dt_to = dt1.Rows[0][3].ToString();
        p_acc_num = dt1.Rows[0][4].ToString();
	}
	/*
SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), sf_get_format ('ACBG0040')) AS openingbalance, ";
SQL += "               TO_CHAR (NVL (debitbookamount, 0), sf_get_format ('ACBG0040')) AS debitbookamount, ";
SQL += "               TO_CHAR (NVL (creditbookamount, 0), sf_get_format ('ACBG0040')) AS creditbookamount, ";
SQL += "               TO_CHAR (NVL (closingbalance, 0), sf_get_format ('ACBG0040')) AS closingbalance, ";
SQL += "               NVL (openingbalance, 0) AS OB ";
//'SQL += "               ,ccy "
SQL += "          FROM (SELECT   tac_abacctcode_pk,";
SQL += "                         SUM (NVL (ymd_drbooks, 0)) debitbookamount, ";
SQL += "                         SUM (NVL (ymd_crbooks, 0)) creditbookamount ";
SQL += "                    FROM tac_hgddbal a ";
SQL += "                   WHERE a.del_if = 0 ";
SQL += "                     AND a.tco_company_pk = '" + l_company_pk +"' ";
SQL += "                     AND a.tac_abacctcode_pk = '" + l_account_pk +"' ";
SQL += "                     AND a.tr_status = '" + l_status +"' ";
SQL += "                     AND a.std_ymd BETWEEN '" + l_date_from +"' AND '" + l_date_to +"' ";
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

//'SQL += "         --  AND upper(ccy) LIKE DECODE('+ l_ccy +','ALL','%%','+ l_ccy +') "
*/
    SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), sf_get_format ('ACBG0040')) AS openingbalance, ";
    SQL += "               TO_CHAR (NVL (debitbookamount, 0), sf_get_format ('ACBG0040')) AS debitbookamount, ";
    SQL += "               TO_CHAR (NVL (creditbookamount, 0), sf_get_format ('ACBG0040')) AS creditbookamount, ";
    SQL += "               TO_CHAR (NVL (closingbalance, 0), sf_get_format ('ACBG0040')) AS closingbalance, ";
    SQL += "               NVL (openingbalance, 0) AS OB FROM (";
    SQL += "    SELECT TAC_ABACCTCODE_PK, SUM(openingbalance) openingbalance, SUM(debitbookamount) debitbookamount, SUM(creditbookamount) creditbookamount,  " +
        "        (SUM(openingbalance)+ (SUM(debitbookamount) - SUM(creditbookamount)) *TO_NUMBER('" + p_acc_num + "') ) closingbalance     FROM " +
        "    (SELECT TAC_ABACCTCODE_PK, 0 openingbalance, " +
        "          SUM (NVL (ymd_drbooks, 0)) debitbookamount,  " +
        "          SUM (NVL (ymd_crbooks, 0)) creditbookamount  " +
        "        FROM tac_hgddbal a  " +
        "       WHERE a.del_if = 0  " +
        "         AND a.tco_company_pk = " + l_company_pk +
        "         AND a.tac_abacctcode_pk = " + l_account_pk +
        "         AND a.tr_status = " + l_status +
        "         AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'  " +
        "    GROUP BY tac_abacctcode_pk " +
        "    UNION ALL " +
        "    SELECT TAC_ABACCTCODE_PK, (SUM(NVL(THIS_DRAMT,0))- SUM(NVL(THIS_CRAMT,0)))*TO_NUMBER('" + p_acc_num + "') openingbalance,  " +
        "    0 debitbookamount, 0 creditbookamount  " +
        "     FROM tac_hgmmbal  " +
        "     WHERE del_if = 0  " +
        "       AND tco_company_pk = " + l_company_pk + " " +
        "       AND tac_abacctcode_pk = " + l_account_pk + "  " +
        "       AND tr_status = " + l_status + "  " +
        "       AND std_ym = SUBSTR (sf_get_lastclosemm('" + l_date_from + "',' " + l_company_pk + "'),1,6)  " +
        "    group by TAC_ABACCTCODE_PK " +
        "    UNION ALL " +
        "    SELECT TAC_ABACCTCODE_PK,(SUM(NVL(YMD_DRBOOKS,0))- SUM(NVL(YMD_CRBOOKS,0)))*TO_NUMBER('" + p_acc_num + "') openingbalance, " +
        "     0 debitbookamount, 0 creditbookamount " +
        "        FROM tac_hgddbal  " +
        "      WHERE del_if = 0  " +
        "          AND tco_company_pk = '" + l_company_pk + "'  " +
        "          AND tac_abacctcode_pk = '" + l_account_pk + "'  " +
        "          AND tr_status = '" + l_status + "'  " +
        "          AND std_ymd  " +
        "               BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (sf_get_lastclosemm('" + l_date_from + "', '" + l_company_pk + "' ),'YYYYMMDD'),+1),'YYYYMMDD')  " +
        "               AND TO_CHAR (  TO_DATE ('" + l_date_from + "','YYYYMMDD')- 1,'YYYYMMDD') " +
        "     GROUP BY TAC_ABACCTCODE_PK " +
        "     ) " +
        "     GROUP BY TAC_ABACCTCODE_PK ) ";
	DataTable dt2 = ESysLib.TableReadOpen(SQL);
	if(dt2.Rows.Count>0)
	{
		p_open_bal_xls = dt2.Rows[0][0].ToString();
	    p_debit_xls = dt2.Rows[0][1].ToString();
	    p_credit_xls = dt2.Rows[0][2].ToString();
		p_close_bal_xls = dt2.Rows[0][3].ToString();
		p_open_bal = dt2.Rows[0][4].ToString();
	}
	/*
SQL = " SELECT   TO_CHAR (h.tr_date, 'DD/MM/YYYY'), ";
SQL += "         DECODE (d.drcr_type, 'D', h.voucherno, '') voucherno_debit, ";
SQL += "         DECODE (d.drcr_type, 'C', h.voucherno, '') voucherno_credit, ";
SQL += "         d.remark2, d.remark, ";
SQL += "         DECODE (d.drcr_type,'D', TO_CHAR (d.tr_bookamt, sf_get_format ('ACBG0040')), 0) book_amt_debit, ";
SQL += "         DECODE (d.drcr_type,'C', TO_CHAR (d.tr_bookamt, sf_get_format ('ACBG0040')), 0) book_amt_credit, ";
SQL += "         TO_CHAR(TO_NUMBER (" + p_open_bal +") + SUM (  NVL (d.tr_bookamt, 0) * DECODE (drcr_type, 'D', 1, -1) * b.dc) OVER (ORDER BY h.tr_date, d.pk), sf_get_format ('ACBG0040')) AS closingbalance, ";
SQL += "         h.pk, h.tr_date ";
SQL += "    FROM (SELECT DECODE (drcr_type, 'D', 1, -1) dc FROM tac_abacctcode WHERE pk = '" + l_account_pk +"') b, tac_hgtrh h, tac_hgtrd d ";
SQL += "   WHERE h.del_if = 0 ";
SQL += "     AND d.del_if = 0 ";
SQL += "     AND h.pk = d.tac_hgtrh_pk ";
SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from +"', 'YYYYMMDD') AND TO_DATE ('" + l_date_to +"', 'YYYYMMDD') ";
SQL += "     AND h.tco_company_pk = '" + l_company_pk +"' ";
SQL += "     AND d.tac_abacctcode_pk IN (SELECT     pk ";
SQL += "                                       FROM tac_abacctcode ";
SQL += "                                      WHERE del_if = 0 AND leaf_yn = 'Y' ";
SQL += "                                 CONNECT BY pac_pk = PRIOR pk ";
SQL += "                                 START WITH pk = " + l_account_pk +") ";
SQL += "ORDER BY h.tr_date, h.voucherno ";
*/
SQL = "select TO_CHAR (tr_date, 'DD/MM/YYYY'), " + 
        " DECODE (drcr_type, 'D', voucherno, '') voucherno_debit, " +
        " DECODE (drcr_type, 'C', voucherno, '') voucherno_credit, " +
        " remark2, remark, " +
        " TO_CHAR ( book_amt_debit, sf_get_format ('ACBG0040')) book_amt_debit, " +
        " TO_CHAR (book_amt_credit, sf_get_format ('ACBG0040')) book_amt_credit, " +
        " TO_CHAR(TO_NUMBER (" + p_open_bal + ") + SUM(book_amt_debit*dc - book_amt_credit*dc) OVER (ORDER BY  tr_date,order_cond, voucherno ,pk),sf_get_format ('ACBG0040')) AS closingbalance, " +
        "         pk, tr_date,order_cond, emp_name " +
        " FROM          " +
        " (     SELECT    " +
        "         d.drcr_type drcr_type, h.voucherno voucherno, " +
        "         max(d.remark2) remark2, max(d.remark) remark, " +
        "         DECODE (d.drcr_type,'D',SUM(d.tr_bookamt), 0) book_amt_debit, " +
        "         DECODE (d.drcr_type,'C', SUM (d.tr_bookamt),0) book_amt_credit, " +
        "         max(b.dc) dc, " +
        "         h.pk, h.tr_date, " +
        "         DECODE(DECODE(max(b.dc),1,'D','C') ,d.drcr_type,1,2)  order_cond, " +
         " max( decode( h.tr_tablenm, 'TAC_HGTRH', " +
                   " ( select i.item_nm from tac_hgtrditem i , tac_abacctitem a " +
                   "      where i.tac_hgtrd_pk = d.pk " +
                    "     and i.del_if = 0 " +
                        " and i.tac_abacctitem_pk = a.pk " +
                        " and a.del_if = 0 " +
                        " and a.tac_abitem_alias = 'EMPLOYEE NAME' " +
                       " and rownum = 1 ), " +
                    " (select a.tr_person from TAC_BPRVPV a where a.del_if = 0 and a.pk = h.tr_table_pk and h.tr_tablenm = 'TAC_BPRVPV') ) ) emp_name " +
        "    FROM (SELECT DECODE (drcr_type, 'D', 1, -1) dc " +
        "            FROM tac_abacctcode " +
        "           WHERE pk = '" + l_account_pk +"') b, " +
        "         tac_hgtrh h, " +
        "         tac_hgtrd d " +
        "   WHERE h.del_if = 0 " +
        "     AND d.del_if = 0 " +
        "     AND h.pk = d.tac_hgtrh_pk " +
        "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) " +
        "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from +"', 'YYYYMMDD') AND TO_DATE ('" + l_date_to +"', 'YYYYMMDD') " +
        "     AND h.tco_company_pk = '" + l_company_pk +"' " +
        "     AND d.tac_abacctcode_pk IN (SELECT     pk " +
        "                                       FROM tac_abacctcode " +
        "                                      WHERE del_if = 0 AND leaf_yn = 'Y' " +
        "                                 CONNECT BY pac_pk = PRIOR pk " +
        "                                 START WITH pk = " + l_account_pk +") " +
        " GROUP BY   h.pk, h.tr_date,h.voucherno,d.drcr_type " +
        " ) " +
        " ORDER BY tr_date,order_cond, voucherno ,pk ";

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Page_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="so quy tien mat_29544_Styles"><!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .75in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}	
.xl2429544
	{padding:0px;
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
.xl2529544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
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
.xl2629544
	{padding:0px;
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
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2729544
	{padding:0px;
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
.xl2829544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
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
.xl2929544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
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
.xl3029544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3129544
	{padding:0px;
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
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3229544
	{padding:0px;
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
.xl3329544
	{padding:0px;
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
.xl3429544
	{padding:0px;
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
.xl3529544
	{padding:0px;
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
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3629544
	{padding:0px;
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
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3729544
	{padding:0px;
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
.xl3829544
	{padding:0px;
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
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3929544
	{padding:0px;
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
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl4029544
	{padding:0px;
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
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4129544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl4229544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
.xl4329544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	white-space:normal;}
.xl4429544
	{padding:0px;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4529544
	{padding:0px;
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
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4629544
	{padding:0px;
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
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4729544
	{padding:0px;
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
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4829544
	{padding:0px;
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4929544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5029544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5129544
	{padding:0px;
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
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5229544
	{padding:0px;
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
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5329544
	{padding:0px;
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
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5429544
	{padding:0px;
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
.xl5529544
	{padding:0px;
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
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl5629544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
.xl5729544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5829544
	{padding:0px;
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
	white-space:nowrap;}
.xl5929544
	{padding:0px;
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
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6029544
	{padding:0px;
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
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6129544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6229544
	{padding:0px;
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
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6329544
	{padding:0px;
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
	white-space:normal;}
.xl6429544
	{padding:0px;
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6529544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6629544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6729544
	{padding:0px;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6829544
	{padding:0px;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl6929544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7029544
	{padding:0px;
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
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7129544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7229544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7329544
	{padding:0px;
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
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7429544
	{padding:0px;
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
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7529544
	{padding:0px;
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
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7629544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl7729544
	{padding:0px;
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
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7829544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7929544
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl8029544
	{padding:0px;
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
.xl8129544
	{padding:0px;
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
.xl8229544
	{padding:0px;
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
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl8329544
	{padding:0px;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl8429544
	{padding:0px;
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
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl8529544
	{padding:0px;
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
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8629544
	{padding:0px;
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
.xl8729544
	{padding:0px;
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
.xl8829544
	{padding:0px;
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
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8929544
	{padding:0px;
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
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9029544
	{padding:0px;
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
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl9129544
	{padding:0px;
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
	white-space:normal;}
--></style>
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

<div id="so quy tien mat_29544" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1334 class=xl2429544
 style='border-collapse:collapse;table-layout:fixed;width:1002pt'>
 <col class=xl2429544 width=79 style='mso-width-source:userset;mso-width-alt:
 2889;width:59pt'>
 <col class=xl2429544 width=81 style='mso-width-source:userset;mso-width-alt:
 2962;width:61pt'>
 <col class=xl2429544 width=103 span=2 style='mso-width-source:userset;
 mso-width-alt:3766;width:77pt'>
 <col class=xl2429544 width=168 style='mso-width-source:userset;mso-width-alt:
 6144;width:126pt'>
 <col class=xl2429544 width=207 style='mso-width-source:userset;mso-width-alt:
 7570;width:155pt'>
 <col class=xl2429544 width=202 style='mso-width-source:userset;mso-width-alt:
 7387;width:152pt'>
 <col class=xl2429544 width=110 span=3 style='mso-width-source:userset;
 mso-width-alt:4022;width:83pt'>
 <col class=xl2429544 width=61 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl2529544 colspan=3 width=263 style='height:15.75pt;
  width:197pt'><%= p_cmp_name%></td>
  <td class=xl2529544 width=103 style='width:77pt'></td>
  <td class=xl2529544 width=168 style='width:126pt'></td>
  <td class=xl2429544 width=207 style='width:155pt'></td>
  <td class=xl2429544 width=202 style='width:152pt'></td>
  <td class=xl2429544 width=110 style='width:83pt'></td>
  <td class=xl2629544 colspan=2 width=220 style='width:166pt'>Mẫu số S07-DN</td>
  <td class=xl2429544 width=61 style='width:46pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl2429544 style='height:15.75pt'><%= p_cmp_add %></td>
  <td class=xl2429544></td>
  <td class=xl2429544></td>
  <td class=xl2429544></td>
  <td class=xl2429544></td>
  <td class=xl2429544></td>
  <td colspan=4 class=xl8529544
  x:str="                 (Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày "><span
  style='mso-spacerun:yes'>                 </span>(Ban hành theo Quyết định số
  15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
  <td class=xl2429544></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl2429544 colspan=3 style='height:15.75pt'>Tax
  Code/MST:&nbsp;&nbsp;<%= p_cmp_taxcode %></td>
  <td class=xl2429544></td>
  <td class=xl2429544></td>
  <td class=xl2429544></td>
  <td colspan=4 class=xl8529544
  x:str="&nbsp;&nbsp;&nbsp;            20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)  ">&nbsp;&nbsp;&nbsp;<span
  style='mso-spacerun:yes'>            </span>20 tháng 03 năm 2006 của Bộ
  trường Bộ Tài chính)<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl2429544></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=10 height=30 class=xl8629544 style='height:22.5pt'>SỔ QUỸ TIỀN
  MẶT</td>
  <td class=xl2829544></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=10 height=26 class=xl8729544 style='height:19.5pt'>Từ
  ngày&nbsp;&nbsp;<%= p_dt_from %>&nbsp;đến&nbsp;<%= p_dt_to%></td>
  <td class=xl2729544></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2929544 style='height:15.0pt'>Tài khoản:</td>
  <td class=xl2929544 x:str><%= p_acc_code%></td>
  <td class=xl3029544>Tên TK:</td>
  <td class=xl3129544><%= p_acc_name %></td>
  <td class=xl2429544></td>
  <td class=xl2429544></td>
  <td class=xl2429544></td>
  <td class=xl2429544></td>
  <td colspan=2 class=xl7929544>Đơn vị tính: <%= l_book_ccy%></td>
  <td class=xl2429544></td>
 </tr>
 <tr class=xl3229544 height=21 style='height:15.75pt'>
  <td height=21 class=xl3329544 style='height:15.75pt'>Ngày</td>
  <td class=xl3429544 x:str="Ngày ">Ngày<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl8029544 style='border-left:none'>Chứng từ</td>
  <td class=xl9029544>Người nhận/nộp tiền</td>
  <td rowspan=2 class=xl8129544 width=207 style='border-bottom:.5pt solid black;
  width:155pt'>Diễn giải</td>
  <td class=xl3529544 width=202 style='width:152pt'>Description</td>
  <td colspan=3 class=xl8329544 style='border-right:.5pt solid black'>Số tiền</td>
  <td rowspan=2 class=xl3329544 style='border-bottom:.5pt solid black'>Ghi Chú</td>
 </tr>
 <tr class=xl3229544 height=21 style='height:15.75pt'>
  <td height=21 class=xl3629544 style='height:15.75pt'>ghi sổ</td>
  <td class=xl3729544>chứng từ</td>
  <td class=xl3729544>Thu</td>
  <td class=xl3829544>Chi</td>
  <td class=xl9029544 style='border-top:none'>Reciept/payment person</td>
  <td class=xl3929544 width=202 style='width:152pt'>&nbsp;</td>
  <td class=xl4029544>THU</td>
  <td class=xl4029544>CHI</td>
  <td class=xl4029544 x:str="TỒN ">TỒN<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl3229544 height=21 style='height:15.75pt'>
  <td height=21 class=xl4129544 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$9:$K$14" width=79 style='height:15.75pt;width:59pt'>A</td>
  <td class=xl4229544 id="_x0000_s1026" x:autofilter="all" width=81
  style='width:61pt'>B</td>
  <td class=xl4229544 id="_x0000_s1027" x:autofilter="all" width=103
  style='width:77pt'>C</td>
  <td class=xl4229544 id="_x0000_s1028" x:autofilter="all" width=103
  style='width:77pt'>D</td>
  <td class=xl4229544 id="_x0000_s1035" x:autofilter="all" width=168
  style='width:126pt'>&nbsp;</td>
  <td class=xl4329544 id="_x0000_s1029" x:autofilter="all" width=207
  style='border-top:none;width:155pt'>E</td>
  <td class=xl4329544 id="_x0000_s1034" x:autofilter="all" width=202
  style='width:152pt'>&nbsp;</td>
  <td class=xl4429544 id="_x0000_s1030" x:autofilter="all" x:num>1</td>
  <td class=xl4429544 id="_x0000_s1031" x:autofilter="all" x:num>2</td>
  <td class=xl4429544 id="_x0000_s1032" x:autofilter="all" x:num>3</td>
  <td class=xl3729544 id="_x0000_s1033" x:autofilter="all">F</td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td height=21 class=xl4529544 style='height:15.75pt'>&nbsp;</td>
  <td class=xl4629544>&nbsp;</td>
  <td class=xl4729544>&nbsp;</td>
  <td class=xl4629544>&nbsp;</td>
  <td class=xl4629544>&nbsp;</td>
  <td class=xl3929544 width=207 style='width:155pt'>SỐ DƯ ĐẦU KỲ</td>
  <td class=xl3929544 width=202 style='width:152pt'>&nbsp;</td>
  <td class=xl4829544 x:str="&nbsp;"><span
  style='mso-spacerun:yes'> </span>&nbsp;<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl4929544 x:str="&nbsp;"><span
  style='mso-spacerun:yes'> </span>&nbsp;<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl5029544 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= p_open_bal_xls %></td>
  <td class=xl5129544>&nbsp;</td>
 </tr>
  <%			
      
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	
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
			//'height=21 style='height:15.75pt'
 %>
 <tr class=xl2729544 height=42 style='height:31.5pt'>
  <td height=42 class=xl5229544 style='height:31.5pt'><%= strDate_Dsp %></td>
  <td class=xl5329544 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl5429544><%=dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl5429544><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl9129544 width=168 style='width:126pt'><%=dt_detail.Rows[i][11].ToString()%></td>
  <td class=xl5529544 width=207 style='width:155pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl5529544 width=202 style='width:152pt'><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl5629544 style="border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][5].ToString()%> </td>
  <td class=xl5729544 style="border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl5729544 style="border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][7].ToString()%> </td>
  <td class=xl5829544 align=right x:num><%=dt_detail.Rows[i][8].ToString()%></td>
 </tr>
  <%
	}
		else
		//'height=21 style='height:15.75pt'
	{
 %>
 <tr class=xl2729544 height=42 style='height:31.5pt'>
  <td height=42 class=xl5229544 style='height:31.5pt;border-top:none'><%= strDate_Dsp %></td>
  <td class=xl5329544 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl5429544 style="border-top:none;border-left:none;"><%=dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl5429544 style="border-top:none;border-left:none;"><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl9129544 width=168 style='width:126pt;border-left:none;'><%=dt_detail.Rows[i][11].ToString()%></td>
  <td class=xl5529544 width=207 style='width:155pt;border-top:none;border-left:none;'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl5529544 width=202 style='width:152pt;border-top:none;border-left:none;'><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl5629544 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][5].ToString()%> </td>
  <td class=xl5729544 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl5729544 style="border-top:none;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i][7].ToString()%> </td>
  <td class=xl5829544 align=right style="border-top:none;border-left:none;" x:num><%=dt_detail.Rows[i][8].ToString()%></td>
 <%
	}
	}
	}
 %>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl7729544 style='height:15.75pt'>&nbsp;</td>
  <td class=xl8829544>&nbsp;</td>
  <td class=xl6029544 width=207 style='width:155pt'>Tổng cộng số phát sinh</td>
  <td class=xl6029544 width=202 style='width:152pt'>&nbsp;</td>
  <td class=xl6129544 x:num style="border-top:.5pt solid windowtext;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" ><%= p_debit_xls %></td>
  <td class=xl6129544 x:num style="border-top:.5pt solid windowtext;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" ><%= p_credit_xls %></td>
  <td class=xl6129544 x:str=""><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl6229544>&nbsp;</td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl7729544 style='height:15.75pt'>&nbsp;</td>
  <td class=xl7329544>&nbsp;</td>
  <td class=xl6329544 width=207 style='width:155pt'>SỐ DƯ CUỐI KỲ</td>
  <td class=xl6329544 width=202 style='width:152pt'>&nbsp;</td>
  <td class=xl6429544 x:str=""><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl6529544 x:str=""><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl6629544 x:num style='border-top:.5pt solid windowtext;border-left:none'
   style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_close_bal_xls %></td>
  <td class=xl6729544>&nbsp;</td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td height=21 class=xl2729544 style='height:15.75pt'></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl2729544></td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td colspan=9 height=21 class=xl7829544 style='height:15.75pt'>Sổ có…. Trang
  , đánh số từ<span style='mso-spacerun:yes'>  </span>trang 01 đến<span
  style='mso-spacerun:yes'>  </span>trang……</td>
  <td class=xl6829544></td>
  <td class=xl2729544></td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td height=21 class=xl5929544 style='height:15.75pt'></td>
  <td class=xl5929544></td>
  <td class=xl5929544></td>
  <td class=xl5929544></td>
  <td class=xl5929544></td>
  <td class=xl5929544></td>
  <td class=xl5929544></td>
  <td colspan=3 class=xl7529544>Ngày …. Tháng .. Năm</td>
  <td class=xl6929544></td>
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

 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl7029544 style='height:15.75pt'><%= v1 %></td>
  <td class=xl7029544></td>
  <td class=xl7029544><%= v2 %></td>
  <td class=xl7029544></td>
  <td colspan=3 class=xl7429544><%= v3 %></td>
  <td class=xl7129544></td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl7229544 style='height:15.75pt'><%=g1 %></td>
  <td class=xl7229544></td>
  <td class=xl7229544><%=g2 %></td>
  <td class=xl7229544></td>
  <td colspan=3 class=xl7629544><%=g3 %></td>
  <td class=xl6929544></td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td height=21 class=xl2729544 style='height:15.75pt'></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl2729544></td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td height=21 class=xl2729544 style='height:15.75pt'></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl2729544></td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td height=21 class=xl2729544 style='height:15.75pt'></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl2729544></td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td height=21 class=xl2729544 style='height:15.75pt'></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl2729544></td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td height=21 class=xl2729544 style='height:15.75pt'></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl2729544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl6829544></td>
  <td class=xl2729544></td>
 </tr>
 <tr class=xl2729544 height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl7029544 style='height:15.75pt'><%= n1 %></td>
  <td class=xl7029544></td>
  <td class=xl7029544><%= n2 %></td>
  <td class=xl7029544></td>
  <td colspan=3 class=xl7429544><%= n3 %></td>
  <td class=xl7129544></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=79 style='width:59pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=168 style='width:126pt'></td>
  <td width=207 style='width:155pt'></td>
  <td width=202 style='width:152pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=61 style='width:46pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>

