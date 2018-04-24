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
	
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_dt_from ="";
	string p_dt_to ="";

	string p_open_bal_xls = "0";
	string p_close_bal_xls = "0";
	string p_debit_xls = "0";
	string p_credit_xls = "0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
	string p_temp ="";
	string strDate = "";
	string strDate_Dsp = "";
	string p_acc_type ="";
	string p_open_bal_dr_xls ="";
	string p_close_bal_dr_xls = "";
	string p_open_bal_cr_xls = "";
	string p_close_bal_cr_xls = "";
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
	
	string SQL = " SELECT partner_lname, addr1, tax_code  FROM tco_company WHERE pk = '" + l_company_pk + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
    }

    SQL = " SELECT AC_CD,AC_NM,DRCR_TYPE, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date ,DECODE(UPPER(a.DRCR_TYPE),'D','1','-1')  ";
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
//'SQL += "                	  AND a.ccy ='"+ l_book_ccy +"' "
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
    SQL += "               NVL (openingbalance, 0) AS OB FROM (";
    SQL += "    SELECT TAC_ABACCTCODE_PK, SUM(openingbalance) openingbalance, SUM(debitbookamount) debitbookamount, SUM(creditbookamount) creditbookamount,  " +
        "        (SUM(openingbalance)+ (SUM(debitbookamount) - SUM(creditbookamount)) *TO_NUMBER('" + p_acc_num + "') ) closingbalance     FROM " +
        "    (SELECT TAC_ABACCTCODE_PK, 0 openingbalance, " +
        "          SUM (NVL (ymd_drbooks, 0)) debitbookamount,  " +
        "          SUM (NVL (ymd_crbooks, 0)) creditbookamount  " +
        "        FROM tac_hgddbal a  " +
        "       WHERE a.del_if = 0  " +
        "         AND a.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
        "         AND a.tac_abacctcode_pk = " + l_account_pk +
        "         AND a.tr_status = " + l_status +
        "         AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'  " +
        "    GROUP BY tac_abacctcode_pk " +
        "    UNION ALL " +
        "    SELECT TAC_ABACCTCODE_PK, (SUM(NVL(THIS_DRAMT,0))- SUM(NVL(THIS_CRAMT,0)))*TO_NUMBER('" + p_acc_num + "') openingbalance,  " +
        "    0 debitbookamount, 0 creditbookamount  " +
        "     FROM tac_hgmmbal  " +
        "     WHERE del_if = 0  " +
        "       AND tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
        "       AND tac_abacctcode_pk = " + l_account_pk + "  " +
        "       AND tr_status = " + l_status + "  " +
        "       AND std_ym = SUBSTR (sf_get_lastclosemm('" + l_date_from + "',' " + l_company_pk + "'),1,6)  " +
        "    group by TAC_ABACCTCODE_PK " +
        "    UNION ALL " +
        "    SELECT TAC_ABACCTCODE_PK,(SUM(NVL(YMD_DRBOOKS,0))- SUM(NVL(YMD_CRBOOKS,0)))*TO_NUMBER('" + p_acc_num + "') openingbalance, " +
        "     0 debitbookamount, 0 creditbookamount " +
        "        FROM tac_hgddbal  " +
        "      WHERE del_if = 0  " +
        "          AND tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
        "          AND tac_abacctcode_pk = '" + l_account_pk + "'  " +
        "          AND tr_status = '" + l_status + "'  " +
        "          AND std_ymd  " +
        "               BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (sf_get_lastclosemm('" + l_date_from + "', '" + l_company_pk + "' ),'YYYYMMDD'),+1),'YYYYMMDD')  " +
        "               AND TO_CHAR (  TO_DATE ('" + l_date_from + "','YYYYMMDD')- 1,'YYYYMMDD') " +
        "     GROUP BY TAC_ABACCTCODE_PK " +
        "     ) " +
        "     GROUP BY TAC_ABACCTCODE_PK ) ";
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
	
SQL = " SELECT pk FROM tac_abacctcode  WHERE del_if = 0 AND upper(leaf_yn) = 'Y'  CONNECT BY pac_pk = PRIOR pk START WITH pk = " + l_account_pk;

DataTable dt3 = ESysLib.TableReadOpen(SQL);

for (i=0;i<dt3.Rows.Count;i++)
{
	p_acc_pk_arr = p_acc_pk_arr + p_temp + dt3.Rows[i][0].ToString();
	p_temp = ",";
}

SQL = "SELECT   b.ac_nm,b.ac_knm,b.ac_lnm,b.ac_cd, SUM (debit_amt), SUM (credit_amt), PARTNER_ID, PARTNER_NAME ";
SQL += " FROM (  SELECT  tac_abacctcode_pk_cr ACC_CODE, ";
SQL += "       SUM(r1.tr_bookamt) debit_amt, 0 credit_amt, (select PARTNER_ID from tco_buspartner where del_if = 0 and pk = r1.tco_buspartner_pk) PARTNER_ID, (select PARTNER_NAME from tco_buspartner where del_if = 0 and pk = r1.tco_buspartner_pk) PARTNER_NAME ";
SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
SQL += " WHERE h.del_if = 0 ";
SQL += "   AND r1.del_if = 0 ";
SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
SQL += "   AND r1.drcr_type = 'D' ";
SQL += "   AND r1.tac_abacctcode_pk_dr IN ("+ p_acc_pk_arr +") ";
SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from +"', 'YYYYMMDD') AND TO_DATE ('" + l_date_to +"', 'YYYYMMDD') ";
SQL += "     AND h.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
SQL += "     GROUP BY  r1.tac_abacctcode_pk_cr, r1.tco_buspartner_pk";
SQL += " UNION ALL ";
SQL += "  SELECT  tac_abacctcode_pk_Dr ACC_CODE, ";
SQL += "       0 debit_amt, sum(R2.tr_bookamt) credit_amt, (select PARTNER_ID from tco_buspartner where del_if = 0 and pk = r2.tco_buspartner_pk) PARTNER_ID, (select PARTNER_NAME from tco_buspartner where del_if = 0 and pk = r2.tco_buspartner_pk) PARTNER_NAME ";
SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
SQL += " WHERE h.del_if = 0 ";
SQL += "   AND R2.del_if = 0 ";
SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
SQL += "   AND R2.drcr_type = 'D' ";
SQL += "   AND R2.tac_abacctcode_pk_cr IN ("+ p_acc_pk_arr +") ";
SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from +"', 'YYYYMMDD') AND TO_DATE ('" + l_date_to +"', 'YYYYMMDD') ";
SQL += "     AND h.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
SQL += "     GROUP BY  r2.tac_abacctcode_pk_dr, r2.tco_buspartner_pk )a, ";
SQL += "          tac_abacctcode b ";
SQL += " WHERE a.acc_code = b.pk ";
SQL += " GROUP BY b.ac_cd,b.ac_nm,b.ac_knm,b.ac_lnm, PARTNER_ID, PARTNER_NAME ";
SQL += " ORDER BY b.ac_cd ";
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="gfka00020_T_SOCAI_Eng_Partner%204%20_files/filelist.xml">
<link rel=Edit-Time-Data
href="gfka00020_T_SOCAI_Eng_Partner%204%20_files/editdata.mso">
<link rel=OLE-Object-Data
href="gfka00020_T_SOCAI_Eng_Partner%204%20_files/oledata.mso">
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
  <o:LastAuthor>Can</o:LastAuthor>
  <o:LastPrinted>2013-05-03T07:23:11Z</o:LastPrinted>
  <o:Created>2006-06-28T09:24:54Z</o:Created>
  <o:LastSaved>2013-05-03T07:31:43Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.25in .25in .25in .25in;
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
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
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style16;
	font-weight:700;
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
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style16;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
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
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style16;
	font-weight:700;
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
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>GL</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>73</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>1</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
       <x:RangeSelection>$G$23:$H$23</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9150</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=GL!$A$9:$H$9</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=GL!$8:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1041"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1456 style='border-collapse:
 collapse;table-layout:fixed;width:1092pt'>
 <col class=xl24 width=236 span=3 style='mso-width-source:userset;mso-width-alt:
 8630;width:177pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=124 span=3 style='mso-width-source:userset;mso-width-alt:
 4534;width:93pt'>
 <col class=xl24 width=236 style='mso-width-source:userset;mso-width-alt:8630;
 width:177pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl59 width=708 style='height:14.25pt;
  width:531pt'><%= p_cmp_name %></td>
  <td class=xl24 width=76 style='width:57pt'></td>
  <td class=xl24 width=124 style='width:93pt'></td>
  <td class=xl24 width=124 style='width:93pt'></td>
  <td colspan=2 class=xl26 width=360 style='width:270pt'>Form number: S03b-DN</td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl60 style='height:14.25pt'><%= p_cmp_add %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl61 x:str="(Issued with Decision No. 15/2006/Q&#272;-BTC ">(Issued
  with Decision No. 15/2006/Q&#272;-BTC<span style='mso-spacerun:yes'> </span></td>
  <td class=xl28></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=3 height=20 class=xl59 style='height:15.0pt'>Tax Code: <%= p_cmp_taxcode %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl61>dated March 20, 2006 by Ministry)</td>
  <td class=xl28></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=8 height=30 class=xl62 style='height:22.5pt'>T GENERAL LEDGER</td>
  <td class=xl24></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=8 height=28 class=xl29 style='height:21.0pt'>From date <%= p_dt_from %> to date <%= p_dt_to %></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'>Account code:</td>
  <td class=xl32><%= p_acc_code %> - <%= p_acc_name %></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl33>Unit:</td>
  <td class=xl33><%= l_book_ccy %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=4 class=xl24 style='height:6.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl63 width=708 style='border-right:.5pt solid black;
  height:15.0pt;width:531pt'>Account name</td>
  <td rowspan=2 class=xl66 width=76 style='border-bottom:.5pt solid black;
  width:57pt'>Account</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td colspan=2 class=xl68 style='border-right:.5pt solid black;border-left:
  none'>Customer</td>
  <td class=xl26></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl36 id="_x0000_s1031" x:autofilter="all"
  x:autofilterrange="$A$9:$H$9" style='height:15.0pt'>English</td>
  <td class=xl37 id="_x0000_s1032" x:autofilter="all">Korea</td>
  <td class=xl37 id="_x0000_s1033" x:autofilter="all">Local</td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t201"
   coordsize="21600,21600" o:spt="201" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path shadowok="f" o:extrusionok="f" strokeok="f" fillok="f"
    o:connecttype="rect"/>
   <o:lock v:ext="edit" shapetype="t"/>
  </v:shapetype><v:shape id="_x0000_s1030" type="#_x0000_t201" style='position:absolute;
   margin-left:0;margin-top:0;width:0;height:15pt;z-index:2;visibility:visible'
   o:insetmode="auto">
   <o:lock v:ext="edit" rotation="t" text="t"/>
   <![if excel]><x:ClientData ObjectType="Drop">
    <x:Anchor>
     4, 0, 8, 0, 4, 0, 9, 0</x:Anchor>
    <x:PrintObject>False</x:PrintObject>
    <x:UIObj/>
    <x:Val>0</x:Val>
    <x:Min>0</x:Min>
    <x:Max>0</x:Max>
    <x:Inc>1</x:Inc>
    <x:Page>1</x:Page>
    <x:Dx>16</x:Dx>
    <x:Sel>0</x:Sel>
    <x:SelType>Single</x:SelType>
    <x:LCT>Normal</x:LCT>
    <x:DropStyle>Simple</x:DropStyle>
    <x:DropLines>8</x:DropLines>
    <x:WidthMin>108</x:WidthMin>
   </x:ClientData>
   <![endif]></v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:0px;margin-top:0px;width:1px;
  height:21px'><![endif]><![if !excel]><img width=1 height=21
  src="gfka00020_T_SOCAI_Eng_Partner%204%20_files/image001.gif" v:shapes="_x0000_s1030"
  class=shape v:dpi="96"><![endif]><![if !vml]></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl37 id="_x0000_s1035" x:autofilter="all" width=124
    style='height:15.0pt;width:93pt'>DEBIT</td>
   </tr>
  </table>
  </span></td>
  <td class=xl37 id="_x0000_s1036" x:autofilter="all">CREDIT</td>
  <td class=xl37 id="_x0000_s1038" x:autofilter="all">Code</td>
  <td class=xl37 id="_x0000_s1039" x:autofilter="all">Name</td>
  <td class=xl26></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  300'>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40 width=236 style='width:177pt'>Opening Balance</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_open_bal_dr_xls%></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_open_bal_cr_xls%></td>
  <td class=xl43>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <%			
 //Response.Write(SQL);
 //Response.End();
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	if (dt_detail.Rows.Count >0)
	{
		for(i=0;i<dt_detail.Rows.Count;i++)
		{
			//if (i < dt_detail.Rows.Count)
			//{
			//'height=20 style='mso-height-source:userset;height:15.0pt'
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl45><%=dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl45><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl46 ><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][5].ToString()%></td>
  <td class=xl48 width=124 style='width:93pt' ><%=dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl49 width=236 style='width:177pt' ><%=dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <%
			//}
		}
	}
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl50 style='height:15.0pt'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl52 x:str="Total Amount Incurred">Total Amount Incurred</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_debit_xls%></td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_credit_xls %></td>
  <td class=xl52>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  300'>
  <td class=xl54>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl40 width=236 style='width:177pt'>Closing Balance</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_close_bal_dr_xls %></td>
  <td class=xl57 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_close_bal_cr_xls %></td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl69>Date <%= l_date_to.Substring(6, 2) %>/<%= l_date_to.Substring(4, 2) %>/<%= l_date_to.Substring(0, 4) %></td>
  <td class=xl70></td>
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
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'><%= v4 %></td>
  <td class=xl27></td>
  <td class=xl31><%= v5 %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31><%= v6 %></td>
  <td class=xl30></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'><%= g4 %></td>
  <td class=xl27></td>
  <td class=xl29><%= g5 %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29><%= g6 %></td>
  <td class=xl27></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td class=xl27></td>
  <td class=xl31></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl27></td>
  <td class=xl29></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td class=xl27></td>
  <td class=xl31></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl27></td>
  <td class=xl29></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td class=xl27></td>
  <td class=xl31></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'><%= n4 %></td>
  <td class=xl27></td>
  <td class=xl31><%= n4 %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31><%= n4 %></td>
  <td class=xl30></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=236 style='width:177pt'></td>
  <td width=236 style='width:177pt'></td>
  <td width=236 style='width:177pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=236 style='width:177pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
