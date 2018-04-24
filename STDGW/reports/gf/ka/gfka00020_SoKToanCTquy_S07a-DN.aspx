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
	string l_company_pk = "" + Request["company_pk"];
	string l_account_pk = "" + Request["account_pk"];
	string l_date_from	= ""+ Request["dtbFrom"];
	string l_date_to = "" + Request["dtbTo"];
	string l_ccy = ""+Request["ccy"];
	string l_status = "" +Request["status"];
	string l_book_ccy = ""+Request["bookccy"];
    string l_rpt_Option = Request["rptOption"];
	
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_dt_from ="";
	string p_dt_to ="";
    string p_acc_drcr = "";
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
	
	string SQL = " SELECT partner_lname, addr1, tax_code  FROM tco_company WHERE pk = '" + l_company_pk  +"' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
    }
	
	SQL = " SELECT AC_CD,AC_LNM, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += " to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date,UPPER(a.DRCR_TYPE) , DECODE(UPPER(a.DRCR_TYPE),'D','1','-1') ";
	SQL += " FROM TAC_ABACCTCODE a WHERE a.pk = '" + l_account_pk + "' ";

	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if(dt1.Rows.Count>0)
	{
		p_acc_code = dt1.Rows[0][0].ToString();
	    p_acc_name = dt1.Rows[0][1].ToString();
	    p_dt_from = dt1.Rows[0][2].ToString();
		p_dt_to = dt1.Rows[0][3].ToString();
        p_acc_drcr = dt1.Rows[0][4].ToString();
        p_acc_num = dt1.Rows[0][5].ToString();
	}
	/*
SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS openingbalance, ";
SQL += "               TO_CHAR (NVL (debitbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS debitbookamount, ";
SQL += "               TO_CHAR (NVL (creditbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS creditbookamount, ";
SQL += "               TO_CHAR (NVL (closingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS closingbalance, ";
SQL += "               NVL (openingbalance, 0) AS OB ";
//'SQL += "               ,ccy ";
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
//'SQL = SQL & "         --  AND upper(ccy) LIKE DECODE('& l_ccy &','ALL','%%','& l_ccy &') "
*/
    SQL = " SELECT   TO_CHAR (NVL (openingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS openingbalance, ";
SQL += "               TO_CHAR (NVL (debitbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS debitbookamount, ";
SQL += "               TO_CHAR (NVL (creditbookamount, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS creditbookamount, ";
SQL += "               TO_CHAR (NVL (closingbalance, 0), ac_SF_GET_FORMAT ('ACBG0040')) AS closingbalance, ";
SQL += "               NVL (openingbalance, 0) AS OB FROM (";
    SQL+= "    SELECT TAC_ABACCTCODE_PK, SUM(openingbalance) openingbalance, SUM(debitbookamount) debitbookamount, SUM(creditbookamount) creditbookamount,  " + 
        "        (SUM(openingbalance)+ (SUM(debitbookamount) - SUM(creditbookamount)) *TO_NUMBER('"+p_acc_num+"') ) closingbalance     FROM " +
        "    (SELECT TAC_ABACCTCODE_PK, 0 openingbalance, " +
        "          SUM (NVL (ymd_drbooks, 0)) debitbookamount,  " +
        "          SUM (NVL (ymd_crbooks, 0)) creditbookamount  " +
        "        FROM tac_hgddbal a  " +
        "       WHERE a.del_if = 0  " +
        "         AND a.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
        "         AND a.tac_abacctcode_pk = "+ l_account_pk +
        "         AND a.tr_status = " + l_status +
        "         AND a.std_ymd BETWEEN '" + l_date_from +"' AND '" + l_date_to +"'  " +
        "    GROUP BY tac_abacctcode_pk " +
        "    UNION ALL " +
        "    SELECT TAC_ABACCTCODE_PK, (SUM(NVL(THIS_DRAMT,0))- SUM(NVL(THIS_CRAMT,0)))*TO_NUMBER('"+p_acc_num+"') openingbalance,  " +
        "    0 debitbookamount, 0 creditbookamount  " +
        "     FROM tac_hgmmbal  " +
        "     WHERE del_if = 0  " +
        "       AND tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
        "       AND tac_abacctcode_pk = " + l_account_pk +"  " +
        "       AND tr_status = "+ l_status +"  " +
        "       AND std_ym = SUBSTR (sf_get_lastclosemm('" + l_date_from +"',' "+ l_company_pk +"'),1,6)  " +
        "    group by TAC_ABACCTCODE_PK " +
        "    UNION ALL " +
        "    SELECT TAC_ABACCTCODE_PK,(SUM(NVL(YMD_DRBOOKS,0))- SUM(NVL(YMD_CRBOOKS,0)))*TO_NUMBER('"+p_acc_num+"') openingbalance, " +
        "     0 debitbookamount, 0 creditbookamount " +
        "        FROM tac_hgddbal  " +
        "      WHERE del_if = 0  " +
        "          AND tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
        "          AND tac_abacctcode_pk = '" + l_account_pk +"'  " +
        "          AND tr_status = '" + l_status +"'  " +
        "          AND std_ymd  " +
        "               BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (sf_get_lastclosemm('" + l_date_from +"', '" + l_company_pk +"' ),'YYYYMMDD'),+1),'YYYYMMDD')  " +
        "               AND TO_CHAR (  TO_DATE ('" + l_date_from +"','YYYYMMDD')- 1,'YYYYMMDD') " +
        "     GROUP BY TAC_ABACCTCODE_PK " +
        "     ) " +
        "     GROUP BY TAC_ABACCTCODE_PK ) " ;

	DataTable dt2 = ESysLib.TableReadOpen(SQL);
	if(dt2.Rows.Count>0)
	{
		p_open_bal_xls = dt2.Rows[0][0].ToString();
	    p_debit_xls = dt2.Rows[0][1].ToString();
	    p_credit_xls = dt2.Rows[0][2].ToString();
		p_close_bal_xls = dt2.Rows[0][3].ToString();
		p_open_bal = dt2.Rows[0][4].ToString();
	}
	
SQL = " SELECT pk FROM tac_abacctcode  WHERE del_if = 0 AND leaf_yn = 'Y'  CONNECT BY pac_pk = PRIOR pk START WITH pk = " + l_account_pk;

	DataTable dt3 = ESysLib.TableReadOpen(SQL);
	
	for (i=0;i<dt3.Rows.Count;i++)
	{
		p_acc_pk_arr = p_acc_pk_arr + p_temp + dt3.Rows[i][0].ToString();
		p_temp = ",";
	}
	 if (l_rpt_Option == "DRCR")
    {
        SQL = "  SELECT  TR_DATE_FMT,voucherno_debit,voucherno_credit,REMARK2,REMARK,ACC_CODE,debit_amt,credit_amt,";
        SQL += "TO_CHAR((TO_NUMBER ('" + p_open_bal_xls + "','9,999,999,999,999,999,990.99') + SUM ( NVL (debit_amt, 0) - NVL (credit_amt, 0)) OVER (ORDER BY tr_date,order_cond,voucherno_debit,voucherno_credit, pk,r_pk)),ac_SF_GET_FORMAT ('ACBG0040')) AS closingbalance, ";
        //SQL += " (0 + sum(nvl(debit_amt,0) - nvl(credit_amt,0)) OVER (ORDER BY tr_date, pk,r_pk)) AS closingbalance,";
        SQL += " pk, tr_date  ";
        SQL += " FROM (  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
        SQL += "       h.voucherno voucherno_debit, '' voucherno_credit, r1.remark2 REMARK2, ";
        SQL += "       r1.remark REMARK, sf_a_get_accd (tac_abacctcode_pk_cr," + l_company_pk + ") ACC_CODE, ";
        SQL += "       r1.tr_bookamt debit_amt, 0 credit_amt, h.pk, h.tr_date,r1.pk r_pk,DECODE('" + p_acc_drcr + "','D',1) order_cond ";
        SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
        SQL += " WHERE h.del_if = 0 ";
        SQL += "   AND r1.del_if = 0 ";
        SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
        SQL += "   AND r1.drcr_type = 'D' ";
        SQL += "   AND r1.tac_abacctcode_pk_dr IN (" + p_acc_pk_arr + ") ";
        SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
        SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
        SQL += "     AND h.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
        SQL += " UNION ALL ";
        SQL += "  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
        SQL += "       '' voucherno_debit, h.voucherno voucherno_credit, R2.remark2 REMARK2, ";
        SQL += "       R2.remark REMARK , sf_a_get_accd (tac_abacctcode_pk_Dr," + l_company_pk + ") ACC_CODE, ";
        SQL += "       0 debit_amt, R2.tr_bookamt credit_amt, h.pk, h.tr_date,r2.pk r_pk,DECODE('" + p_acc_drcr + "','D',2) order_cond ";
        SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
        SQL += " WHERE h.del_if = 0 ";
        SQL += "   AND R2.del_if = 0 ";
        SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
        SQL += "   AND R2.drcr_type = 'D' ";
        SQL += "   AND R2.tac_abacctcode_pk_cr IN (" + p_acc_pk_arr + ") ";
        SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
        SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
        SQL += "     AND h.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "'))";
        SQL += "     ORDER BY tr_date,order_cond,voucherno_debit,voucherno_credit, PK,r_pk";
 
         }
         else if (l_rpt_Option == "FIFO")
         {
             SQL = "  SELECT  TR_DATE_FMT,voucherno_debit,voucherno_credit,REMARK2,REMARK,ACC_CODE,debit_amt,credit_amt,";
             SQL += "TO_CHAR((TO_NUMBER ('" + p_open_bal_xls + "','9,999,999,999,999,999,990.99') + SUM ( NVL (debit_amt, 0) - NVL (credit_amt, 0)) OVER (ORDER BY tr_date, pk,r_pk)),ac_SF_GET_FORMAT ('ACBG0040')) AS closingbalance, ";
             //SQL += " (0 + sum(nvl(debit_amt,0) - nvl(credit_amt,0)) OVER (ORDER BY tr_date, pk,r_pk)) AS closingbalance,";
             SQL += " pk, tr_date  ";
             SQL += " FROM (  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
             SQL += "       h.voucherno voucherno_debit, '' voucherno_credit, r1.remark2 REMARK2, ";
             SQL += "       r1.remark REMARK, sf_a_get_accd (tac_abacctcode_pk_cr," + l_company_pk + ") ACC_CODE, ";
             SQL += "       r1.tr_bookamt debit_amt, 0 credit_amt, h.pk, h.tr_date,r1.pk r_pk,DECODE('" + p_acc_drcr + "','D',1) order_cond, h.voucherno ";
             SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
             SQL += " WHERE h.del_if = 0 ";
             SQL += "   AND r1.del_if = 0 ";
             SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
             SQL += "   AND r1.drcr_type = 'D' ";
             SQL += "   AND r1.tac_abacctcode_pk_dr IN (" + p_acc_pk_arr + ") ";
             SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
             SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
             SQL += "     AND h.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
             SQL += " UNION ALL ";
             SQL += "  SELECT TO_CHAR (h.tr_date, 'DD/MM/YYYY') TR_DATE_FMT, ";
             SQL += "       '' voucherno_debit, h.voucherno voucherno_credit, R2.remark2 REMARK2, ";
             SQL += "       R2.remark REMARK , sf_a_get_accd (tac_abacctcode_pk_Dr," + l_company_pk + ") ACC_CODE, ";
             SQL += "       0 debit_amt, R2.tr_bookamt credit_amt, h.pk, h.tr_date,r2.pk r_pk,DECODE('" + p_acc_drcr + "','D',2) order_cond,h.voucherno ";
             SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
             SQL += " WHERE h.del_if = 0 ";
             SQL += "   AND R2.del_if = 0 ";
             SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
             SQL += "   AND R2.drcr_type = 'D' ";
             SQL += "   AND R2.tac_abacctcode_pk_cr IN (" + p_acc_pk_arr + ") ";
             SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
             SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
             SQL += "     AND h.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "'))";
             SQL += "     ORDER BY tr_date, PK,r_pk";

         }
         
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_SoKToanCTquy_S07a-DN_files/filelist.xml">
<link rel=Edit-Time-Data
href="gfka00020_SoKToanCTquy_S07a-DN_files/editdata.mso">
<link rel=OLE-Object-Data
href="gfka00020_SoKToanCTquy_S07a-DN_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Cuong</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-05-07T08:06:06Z</o:LastPrinted>
  <o:Created>2006-06-29T05:06:28Z</o:Created>
  <o:LastSaved>2008-06-09T03:59:19Z</o:LastSaved>
  <o:Company>abc</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CTrang &P of &N ";
	margin:.5in 0in .75in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
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
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
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
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl49
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
.xl50
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
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl54
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
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
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
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
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
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>S&#7893; KT chi ti&#7871;t qu&#7929; ti&#7873;n m&#7863;t</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>11</x:SplitHorizontal>
     <x:TopRowBottomPane>11</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; KT chi ti&#7871;t qu&#7929; ti&#7873;n m&#7863;t'!$A$10:$K$10</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; KT chi ti&#7871;t qu&#7929; ti&#7873;n m&#7863;t'!$8:$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1290 style='border-collapse:
 collapse;table-layout:fixed;width:969pt'>
 <col class=xl24 width=89 span=4 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl24 width=250 span=2 style='mso-width-source:userset;mso-width-alt:
 9142;width:188pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=103 span=3 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=5 width=606 style='height:15.75pt;
  mso-ignore:colspan;width:456pt'><%= p_cmp_name%></td>
  <td class=xl24 width=250 style='width:188pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td colspan=4 class=xl78 width=373 style='width:279pt'><span
  style='mso-spacerun:yes'> </span>M&#7851;u s&#7889; S07a-DN</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=6 style='height:15.75pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td class=xl24></td>
  <td class=xl76 colspan=4 style='mso-ignore:colspan'
  x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
  hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Tax
  Code/MST:&nbsp;&nbsp;<%= p_cmp_taxcode %></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl76 colspan=4 style='mso-ignore:colspan'>20 tháng 03 n&#259;m 2006
  c&#7911;a B&#7897; tr&#432;&#7901;ng B&#7897; Tài chính)</td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=10 height=30 class=xl82 style='height:22.5pt'>S&#7892; K&#7870;
  TOÁN CHI TI&#7870;T QU&#7928; TI&#7872;N M&#7862;T</td>
  <td class=xl26></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=10 height=26 class=xl28 style='height:19.5pt'>T&#7915;
  ngày&nbsp;&nbsp;<%= p_dt_from %>&nbsp;&#273;&#7871;n&nbsp;<%= p_dt_to%></td>
  <td class=xl27></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=4 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl28></td>
  <td class=xl27></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'>Tài kho&#7843;n:</td>
  <td class=xl73 x:num><%= p_acc_code%></td>
  <td class=xl72>Tên TK:</td>
  <td class=xl32><%= p_acc_name %></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83>&#272;&#417;n v&#7883; tính:<%= l_book_ccy%></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt' x:str="Ngày tháng ">Ngày
  tháng<span style='mso-spacerun:yes'> </span></td>
  <td class=xl49 style='border-left:none' x:str="Ngày ">Ngày<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl84 style='border-right:.5pt solid black;border-left:
  none'>Ch&#7913;ng t&#7915;</td>
  <td rowspan=2 class=xl34 width=250 style='border-bottom:.5pt solid black;
  width:188pt'>Di&#7877;n gi&#7843;i</td>
  <td class=xl34 width=250 style='border-left:none;width:188pt'>Description</td>
  <td rowspan=2 class=xl34 width=61 style='border-bottom:.5pt solid black;
  width:46pt'>TK</td>
  <td colspan=3 class=xl84 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ti&#7873;n</td>
  <td class=xl74>Ghi Chú</td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'>ghi s&#7893;</td>
  <td class=xl50 style='border-left:none'>ch&#7913;ng t&#7915;</td>
  <td class=xl36>Thu</td>
  <td class=xl37>Chi</td>
  <td class=xl38 width=250 style='border-left:none;width:188pt'>&nbsp;</td>
  <td class=xl36>THU</td>
  <td class=xl36>CHI</td>
  <td class=xl36 x:str="T&#7890;N ">T&#7890;N<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl75>SEQ</td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl51 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$10:$K$10" width=89 style='height:15.75pt;border-top:
  none;width:67pt'>A</td>
  <td class=xl51 id="_x0000_s1026" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'>B</td>
  <td class=xl51 id="_x0000_s1027" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'>C</td>
  <td class=xl51 id="_x0000_s1028" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'>D</td>
  <td class=xl51 id="_x0000_s1029" x:autofilter="all" width=250
  style='border-left:none;width:188pt'>E</td>
  <td class=xl51 id="_x0000_s1035" x:autofilter="all" width=250
  style='border-left:none;width:188pt'>&nbsp;</td>
  <td class=xl51 id="_x0000_s1030" x:autofilter="all" width=61
  style='border-left:none;width:46pt'>F</td>
  <td class=xl71 id="_x0000_s1031" x:autofilter="all" style='border-top:none;
  border-left:none' x:num>1</td>
  <td class=xl71 id="_x0000_s1032" x:autofilter="all" style='border-top:none;
  border-left:none' x:num>2</td>
  <td class=xl71 id="_x0000_s1033" x:autofilter="all" style='border-top:none;
  border-left:none' x:num>3</td>
  <td class=xl52 id="_x0000_s1034" x:autofilter="all" style='border-top:none;
  border-left:none'>G</td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42 width=250 style='width:188pt'>S&#7888; D&#431; &#272;&#7846;U
  K&#7922;</td>
  <td class=xl42 width=250 style='width:188pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl43 x:str="    "><span style='mso-spacerun:yes'>      </span></td>
  <td class=xl44 x:str="             "><span
  style='mso-spacerun:yes'>               </span></td>
  <td class=xl44 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" ><%= p_open_bal_xls %></td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
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
			//'height=21 style='height:15.75pt'
 %>
 <tr class=xl27 >
  <td class=xl55 ><%= strDate_Dsp %></td>
  <td class=xl55 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl56 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl56 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl57 width=250 style='border-left:none;width:188pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl57 width=250 style='border-left:none;width:188pt'><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl56 style='border-left:none' x:num><%=dt_detail.Rows[i][5].ToString()%></td>
  <td class=xl58 style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl59 style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl59 style='border-left:none' style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][8].ToString()%></td>
  <td class=xl54 style='border-left:none' x:num><%=dt_detail.Rows[i][9].ToString()%></td>
 </tr>
  <%
		}
	}
 %>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl45 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl61 width=250 style='border-top:none;border-left:none;width:188pt'>T&#7893;ng
  c&#7897;ng s&#7889; phát sinh</td>
  <td class=xl61 width=250 style='border-top:none;border-left:none;width:188pt'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_debit_xls %></td>
  <td class=xl62 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_credit_xls %></td>
  <td class=xl62 style='border-top:none;border-left:none'
  x:str="                    "><span
  style='mso-spacerun:yes'>                      </span></td>
  <td class=xl63 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl64 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl66 width=250 style='border-top:none;border-left:none;width:188pt'>S&#7888;
  D&#431; CU&#7888;I K&#7922;</td>
  <td class=xl66 width=250 style='border-top:none;border-left:none;width:188pt'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none' x:str="           "><span
  style='mso-spacerun:yes'>             </span></td>
  <td class=xl69 style='border-top:none;border-left:none' x:str="           "><span
  style='mso-spacerun:yes'>             </span></td>
  <td class=xl69 align=right style='border-top:none;border-left:none'
  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_close_bal_xls %></td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl27 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td colspan=9 height=21 class=xl80 style='height:15.75pt'>S&#7893; có…. Trang
  , &#273;ánh s&#7889; t&#7915;<span style='mso-spacerun:yes'>  </span>trang 01
  &#273;&#7871;n<span style='mso-spacerun:yes'>  </span>trang……</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl46 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl46>Ngày <%= l_date_to.Substring(6, 2) %> Tháng <%= l_date_to.Substring(4, 2) %> Năm <%= l_date_to.Substring(0, 4) %></td>
  <td class=xl47></td>
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
 <tr class=xl27 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl81 style='height:17.25pt'><%= v1 %></td>
  <td colspan=3 class=xl81><%= v2 %></td>
  <td colspan=3 class=xl81><%= v3 %></td>
  <td class=xl48></td>
 </tr>
 <tr class=xl27 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl79 style='height:17.25pt'><%= g1 %></td>
  <td colspan=3 class=xl79><%= g2 %></td>
  <td colspan=3 class=xl79><%= g3 %></td>
  <td class=xl47></td>
 </tr>
 
 <tr class=xl27 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl81 style='height:17.25pt'></td>
  <td colspan=3 class=xl81></td>
  <td colspan=3 class=xl81></td>
  <td class=xl48></td>
 </tr>
 <tr class=xl27 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl81 style='height:17.25pt'></td>
  <td colspan=3 class=xl81></td>
  <td colspan=3 class=xl81></td>
  <td class=xl48></td>
 </tr>
 <tr class=xl27 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl81 style='height:17.25pt'></td>
  <td colspan=3 class=xl81></td>
  <td colspan=3 class=xl81></td>
  <td class=xl48></td>
 </tr>
 <tr class=xl27 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl81 style='height:17.25pt'></td>
  <td colspan=3 class=xl81></td>
  <td colspan=3 class=xl81></td>
  <td class=xl48></td>
 </tr>
 <tr class=xl27 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl81 style='height:17.25pt'></td>
  <td colspan=3 class=xl81></td>
  <td colspan=3 class=xl81></td>
  <td class=xl48></td>
 </tr>
  <tr class=xl27 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl81 style='height:17.25pt'><%= n1 %></td>
  <td colspan=3 class=xl81><%= n2 %></td>
  <td colspan=3 class=xl81><%= n3 %></td>
  <td class=xl48></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>