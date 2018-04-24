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
	string l_company_pk = ""+Request["company_pk"];
	string l_account_pk = ""+Request["account_pk"];
	string l_date_from	= "" + Request["dtbFrom"];
	string l_date_to = "" +Request["dtbTo"];
	string l_ccy = ""+ Request["ccy"];
	string l_status = ""+Request["status"];
	string l_book_ccy = ""+Request["bookccy"];
	
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_acc_type = "";
	string p_dt_from ="";
	string p_dt_to ="";
    string p_acc_num = "";

	string p_open_bal_dr_xls = "0";
	string p_open_bal_cr_xls = "0";
	string p_close_bal_dr_xls = "0";
	string p_close_bal_cr_xls = "0";
	string p_debit_xls ="0";
	string p_credit_xls ="0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
	string p_open_bal_xls ="";
	string p_close_bal_xls = "";
	
	
	
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
	
	SQL = " SELECT AC_CD,AC_LNM, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date,DECODE(UPPER(a.DRCR_TYPE),'D','1','-1')  ";
	SQL += "FROM TAC_localCODE a WHERE a.pk = '" + l_account_pk + "' ";

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
    SQL += "    SELECT TAC_localCODE_PK, SUM(openingbalance) openingbalance, SUM(debitbookamount) debitbookamount, SUM(creditbookamount) creditbookamount,  " +
        "        (SUM(openingbalance)+ (SUM(debitbookamount) - SUM(creditbookamount)) *TO_NUMBER('" + p_acc_num + "') ) closingbalance     FROM " +
        "    (SELECT TAC_localCODE_PK, 0 openingbalance, " +
        "          SUM (NVL (ymd_drbooks, 0)) debitbookamount,  " +
        "          SUM (NVL (ymd_crbooks, 0)) creditbookamount  " +
        "        FROM tac_hgddbal_local a  " +
        "       WHERE a.del_if = 0  " +
        "         AND a.tco_company_pk = " + l_company_pk +
        "         AND a.tac_localcode_pk = " + l_account_pk +
        "         AND a.tr_status = " + l_status +
        "         AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'  " +
        "    GROUP BY tac_localcode_pk " +
        "    UNION ALL " +
        "    SELECT TAC_localCODE_PK, (SUM(NVL(THIS_DRAMT,0))- SUM(NVL(THIS_CRAMT,0)))*TO_NUMBER('" + p_acc_num + "') openingbalance,  " +
        "    0 debitbookamount, 0 creditbookamount  " +
        "     FROM tac_hgmmbal_local  " +
        "     WHERE del_if = 0  " +
        "       AND tco_company_pk = " + l_company_pk + " " +
        "       AND tac_localcode_pk = " + l_account_pk + "  " +
        "       AND tr_status = " + l_status + "  " +
        "       AND std_ym = SUBSTR (sf_get_lastclosemm('" + l_date_from + "',' " + l_company_pk + "'),1,6)  " +
        "    group by TAC_localCODE_PK " +
        "    UNION ALL " +
        "    SELECT TAC_localCODE_PK,(SUM(NVL(YMD_DRBOOKS,0))- SUM(NVL(YMD_CRBOOKS,0)))*TO_NUMBER('" + p_acc_num + "') openingbalance, " +
        "     0 debitbookamount, 0 creditbookamount " +
        "        FROM tac_hgddbal_local  " +
        "      WHERE del_if = 0  " +
        "          AND tco_company_pk = '" + l_company_pk + "'  " +
        "          AND tac_localcode_pk = '" + l_account_pk + "'  " +
        "          AND tr_status = '" + l_status + "'  " +
        "          AND std_ymd  " +
        "               BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (sf_get_lastclosemm('" + l_date_from + "', '" + l_company_pk + "' ),'YYYYMMDD'),+1),'YYYYMMDD')  " +
        "               AND TO_CHAR (  TO_DATE ('" + l_date_from + "','YYYYMMDD')- 1,'YYYYMMDD') " +
        "     GROUP BY TAC_localCODE_PK " +
        "     ) " +
        "     GROUP BY TAC_localCODE_PK ) ";
    //Response.Write(SQL);
    //Response.End();
	DataTable dt2 = ESysLib.TableReadOpen(SQL);
	if(dt2.Rows.Count>0)
	{
		p_open_bal_xls =  dt2.Rows[0][0].ToString();
		p_debit_xls =  dt2.Rows[0][1].ToString();
		p_credit_xls =  dt2.Rows[0][2].ToString();
	    p_close_bal_xls = dt2.Rows[0][3].ToString();
	    p_open_bal = dt2.Rows[0][4].ToString();	
	}
	
	SQL = " SELECT pk FROM tac_localcode  WHERE del_if = 0 AND upper(leaf_yn) = 'Y'  CONNECT BY pac_pk = PRIOR pk START WITH pk = " + l_account_pk;

	DataTable dt3 = ESysLib.TableReadOpen(SQL);

	string p_temp ="";
	for (i=0;i<dt3.Rows.Count;i++)
	{
		p_acc_pk_arr = p_acc_pk_arr + p_temp + dt3.Rows[i][0].ToString();
		p_temp = ",";
	}

SQL = "SELECT   b.ac_nm,b.ac_knm,b.ac_lnm,b.ac_cd, TO_CHAR(SUM (debit_amt),sf_get_format ('ACBG0040')) total_debit, TO_CHAR(SUM (credit_amt),sf_get_format ('ACBG0040')) total_credit,  ";
SQL += "         TO_CHAR(TO_NUMBER (" + p_open_bal +") + SUM ( sum (debit_amt) - sum(credit_amt) )OVER (ORDER BY b.ac_cd), sf_get_format ('ACBG0040')) AS closingbalance ";
SQL += " FROM (  SELECT  tac_abacctcode_pk_cr ACC_CODE, ";
SQL += "       SUM(r1.tr_bookamt) debit_amt, 0 credit_amt ";
SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r1 ";
SQL += " WHERE h.del_if = 0 ";
SQL += "   AND r1.del_if = 0 ";
SQL += "   AND h.pk = r1.tac_hgtrh_pk ";
SQL += "   AND r1.drcr_type = 'D' ";
SQL += "   AND r1.tac_abacctcode_pk_dr IN (  select pk from tac_abacctcode where del_if =0 and  USE_YN ='Y' and TAC_LOCALCODE_PK in     (SELECT hg.TAC_localCODE_PK  FROM TAC_HGDDBAL_local hg WHERE hg.DEL_IF =0 AND hg.tco_company_pk =  '"+ l_company_pk +"'  AND hg.tac_localcode_pk in ( SELECT pk ";
SQL += "                                       FROM tac_localcode ";
SQL += "                                      WHERE del_if = 0 AND leaf_yn = 'Y' ";
SQL += "                                 CONNECT BY pac_pk = PRIOR pk ";
SQL += "                                 START WITH pk = " + p_acc_pk_arr + "))) ";
SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from +"', 'YYYYMMDD') AND TO_DATE ('" + l_date_to +"', 'YYYYMMDD') ";
SQL += "     AND h.tco_company_pk = '" + l_company_pk +"' ";
SQL += "     GROUP BY  r1.tac_abacctcode_pk_cr";
SQL += " UNION ALL ";
SQL += "  SELECT  tac_abacctcode_pk_Dr ACC_CODE, ";
SQL += "       0 debit_amt, sum(R2.tr_bookamt) credit_amt ";
SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref R2 ";
SQL += " WHERE h.del_if = 0 ";
SQL += "   AND R2.del_if = 0 ";
SQL += "   AND h.pk = R2.tac_hgtrh_pk ";
SQL += "   AND R2.drcr_type = 'D' ";
SQL += "   AND R2.tac_abacctcode_pk_cr IN (  select pk from tac_abacctcode where del_if =0 and  USE_YN ='Y' and TAC_LOCALCODE_PK in     (SELECT hg.TAC_localCODE_PK  FROM TAC_HGDDBAL_local hg WHERE hg.DEL_IF =0 AND hg.tco_company_pk =  '"+ l_company_pk +"'  AND hg.tac_localcode_pk in ( SELECT pk ";
SQL += "                                       FROM tac_localcode ";
SQL += "                                      WHERE del_if = 0 AND leaf_yn = 'Y' ";
SQL += "                                 CONNECT BY pac_pk = PRIOR pk ";
SQL += "                                 START WITH pk = " + p_acc_pk_arr + "))) ";
SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from +"', 'YYYYMMDD') AND TO_DATE ('" + l_date_to +"', 'YYYYMMDD') ";
SQL += "     AND h.tco_company_pk = '" + l_company_pk +"' ";
SQL += "     GROUP BY  r2.tac_abacctcode_pk_dr )a, ";
SQL += "          tac_abacctcode b ";
SQL += " WHERE a.acc_code = b.pk ";
SQL += " GROUP BY b.ac_cd,b.ac_nm,b.ac_knm,b.ac_lnm ";
SQL += " ORDER BY b.ac_cd ";
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_T_SCTQT_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00020_T_SCTQT_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00020_T_SCTQT_files/oledata.mso">
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
  <o:LastPrinted>2008-05-14T08:44:03Z</o:LastPrinted>
  <o:Created>2006-06-29T05:06:28Z</o:Created>
  <o:LastSaved>2008-06-12T08:15:50Z</o:LastSaved>
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
	margin:.5in .25in .5in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
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
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style16;
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
.xl49
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
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
	border-left:none;}
.xl67
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
	white-space:normal;}
.xl68
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
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
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
       <x:ActiveRow>12</x:ActiveRow>
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
  <x:Formula>=Sheet1!$A$9:$G$14</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$9:$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1029 style='border-collapse:
 collapse;table-layout:fixed;width:773pt'>
 <col class=xl25 width=222 span=3 style='mso-width-source:userset;mso-width-alt:
 8118;width:167pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl25 width=103 span=3 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 width=222 style='height:15.0pt;width:167pt'><%= p_cmp_name %></td>
  <td class=xl25 width=222 style='width:167pt'></td>
  <td class=xl25 width=222 style='width:167pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl25 width=103 style='width:77pt'></td>
  <td class=xl25 width=103 style='width:77pt'></td>
  <td class=xl25 width=103 style='width:77pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=2 style='height:15.0pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Tax
  Code/MST:&nbsp;&nbsp;<%= p_cmp_taxcode %></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=7 height=30 class=xl60 style='height:22.5pt'>DAILY CASH DETAIL
  REPORT/S&#7892; K&#7870; TOÁN CHI TI&#7870;T QU&#7928; TI&#7872;N M&#7862;T</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=7 height=26 class=xl26 style='height:19.5pt'>T&#7915;
  ngày&nbsp;&nbsp;<%= p_dt_from %>&nbsp;&#273;&#7871;n&nbsp;<%= p_dt_to %></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=2 class=xl25 style='height:7.5pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
  <td class=xl26></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'>S&#7889; hi&#7879;u tài
  kho&#7843;n/ Account Code:</td>
  <td class=xl56 x:num><%= p_acc_code %></td>
  <td class=xl25><%= p_acc_name %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29>Unit:<%= l_book_ccy %></td>
 </tr>
 <tr class=xl43 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl64 style='border-right:.5pt solid black;
  height:14.25pt'>Tên TK/Di&#7877;n gi&#7843;i</td>
  <td rowspan=2 class=xl67 width=54 style='border-bottom:.5pt solid black;
  width:41pt'>S&#7889; hi&#7879;u TK &#273;&#7889;i &#7913;ng/Code</td>
  <td colspan=3 class=xl61 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ti&#7873;n/Amount</td>
 </tr>
 <tr class=xl43 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl57 id="_x0000_s1026" x:autofilter="all"
  x:autofilterrange="$A$9:$G$14" style='height:21.75pt'>ENGLISH</td>
  <td class=xl58 id="_x0000_s1027" x:autofilter="all">KOREA</td>
  <td class=xl59 id="_x0000_s1028" x:autofilter="all" width=222
  style='width:167pt'>LOCAL</td>
  <td class=xl30 id="_x0000_s1030" x:autofilter="all">THU/Receipt</td>
  <td class=xl30 id="_x0000_s1031" x:autofilter="all">CHI/Payment</td>
  <td class=xl30 id="_x0000_s1032" x:autofilter="all">T&#7890;N/Balance</td>
 </tr>
 <tr class=xl50 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46 width=222 style='width:167pt'><span
  style='mso-spacerun:yes'> </span>S&#7889; d&#432; &#273;&#7847;u/Opening
  Balance</td>
  <td class=xl47 style='border-left:none'>&nbsp;</td>
  <td class=xl48 x:str="    "><span style='mso-spacerun:yes'>      </span></td>
  <td class=xl49 x:str="             "><span
  style='mso-spacerun:yes'>               </span></td>
  <td class=xl49 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= p_open_bal_xls %></td>
 </tr>
 <%			
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	if (dt_detail.Rows.Count >0)
	{
		for(i=0;i<dt_detail.Rows.Count;i++)
		{
			if (i < dt_detail.Rows.Count)
			{
			//' height=17  style='height:12.75pt'
 %>
 <tr class=xl50 >
  <td class=xl33 width=222 style='border-top:none;width:167pt'><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl34 width=222 style='width:167pt'><%=dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl34 width=222 style='width:167pt'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl35 style='border-left:none' x:num><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl36 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][4].ToString() %></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
 </tr>
 <% }else {
//'height=34 style='height:25.5pt'
 %> 
 <tr class=xl50 >
  <td class=xl38 width=222 style='border-top:none;width:167pt'><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl39 width=222 style='border-top:none;width:167pt'><%=dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl39 width=222 style='border-top:none;width:167pt'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl40 style='border-left:none' x:num><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl41 style='border-top:none'  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][4].ToString() %></td>
  <td class=xl42 style='border-top:none'  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl42 style='border-top:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
 </tr>
 <%  }
	}
	}
%> 
 <tr class=xl50 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl51 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-left:none'>&nbsp;</td>
  <td class=xl53 width=222 style='border-left:none;width:167pt'>S&#7889; phát
  sinh/ Arising Amount</td>
  <td class=xl52 style='border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= p_debit_xls %></td>
  <td class=xl54 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= p_credit_xls %></td>
  <td class=xl54 style='border-left:none' x:str="                    "><span
  style='mso-spacerun:yes'>                      </span></td>
 </tr>
 
 <tr class=xl50 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl51 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 width=222 style='border-top:none;border-left:none;width:167pt'>S&#7889;
  d&#432; cu&#7889;i/ Closing balance</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none' x:str="           "><span
  style='mso-spacerun:yes'>             </span></td>
  <td class=xl54 style='border-top:none;border-left:none' x:str="           "><span
  style='mso-spacerun:yes'>             </span></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= p_close_bal_xls %></td>
 </tr>
 <tr class=xl50 height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl50 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl50 height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl31>Ngày <%= l_date_to.Substring(6, 2) %> tháng <%= l_date_to.Substring(4, 2) %> năm <%= l_date_to.Substring(0, 4) %></td>
 </tr>
 <tr class=xl50 height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl50 style='height:12.75pt;mso-ignore:colspan'></td>
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
<tr height=23 style='height:17.25pt'>
  <td height=23 class=xl32 style='height:17.25pt'><%= v1 %></td>
  <td colspan=2 class=xl32><%= v2 %></td>
  <td class=xl32></td>
  <td colspan=3 class=xl32><%= v3 %></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'><%= g1 %></td>
  <td colspan=2 class=xl31><%= g2 %></td>
  <td class=xl31></td>
  <td colspan=3 class=xl31><%= g3 %></td>
 </tr>
<tr height=23 style='height:17.25pt'>
  <td height=23 class=xl32 style='height:17.25pt'></td>
  <td colspan=2 class=xl32></td>
  <td class=xl32></td>
  <td colspan=3 class=xl32></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'></td>
  <td colspan=2 class=xl31></td>
  <td class=xl31></td>
  <td colspan=3 class=xl31></td>
 </tr> 
<tr height=23 style='height:17.25pt'>
  <td height=23 class=xl32 style='height:17.25pt'></td>
  <td colspan=2 class=xl32></td>
  <td class=xl32></td>
  <td colspan=3 class=xl32></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'></td>
  <td colspan=2 class=xl31></td>
  <td class=xl31></td>
  <td colspan=3 class=xl31></td>
 </tr> 
<tr height=23 style='height:17.25pt'>
  <td height=23 class=xl32 style='height:17.25pt'></td>
  <td colspan=2 class=xl32></td>
  <td class=xl32></td>
  <td colspan=3 class=xl32></td>
 </tr>
   <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl32 style='height:17.25pt'><%= n1 %></td>
  <td colspan=2 class=xl32><%= n2 %></td>
  <td class=xl32></td>
  <td colspan=3 class=xl32><%= n3 %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=222 style='width:167pt'></td>
  <td width=222 style='width:167pt'></td>
  <td width=222 style='width:167pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
