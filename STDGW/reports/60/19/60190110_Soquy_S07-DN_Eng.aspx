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
    string l_rpt_Option = Request["rptOption"];
	
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

    SQL = " SELECT AC_CD,AC_NM, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date, DECODE(UPPER(a.DRCR_TYPE),'D','1','-1')  ";
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
   
	DataTable dt2 = ESysLib.TableReadOpen(SQL);
	if(dt2.Rows.Count>0)
	{
		p_open_bal_xls = dt2.Rows[0][0].ToString();
	    p_debit_xls = dt2.Rows[0][1].ToString();
	    p_credit_xls = dt2.Rows[0][2].ToString();
		p_close_bal_xls = dt2.Rows[0][3].ToString();
		p_open_bal = dt2.Rows[0][4].ToString();
	}
	
     if (l_rpt_Option == "DRCR")
    {
SQL = "select TO_CHAR (tr_date, 'DD/MM/YYYY'), " + 
        " DECODE (drcr_type, 'D', voucherno, '') voucherno_debit, " +
        " DECODE (drcr_type, 'C', voucherno, '') voucherno_credit, " +
        " remark2, remark, " +
        " TO_CHAR ( book_amt_debit, sf_get_format ('ACBG0040')) book_amt_debit, " +
        " TO_CHAR (book_amt_credit, sf_get_format ('ACBG0040')) book_amt_credit, " +
        " TO_CHAR(TO_NUMBER (" + p_open_bal + ") + SUM(book_amt_debit*dc - book_amt_credit*dc) OVER (ORDER BY tr_date,order_cond, voucherno ,pk),sf_get_format ('ACBG0040')) AS closingbalance, " +
        "         pk, tr_date " +
        " FROM          " +
        " (     SELECT    " +
        "         d.drcr_type drcr_type, h.voucherno voucherno, " +
        "         max(d.remark2) remark2, max(d.remark) remark, " +
        "         DECODE (d.drcr_type,'D',SUM(d.tr_bookamt), 0) book_amt_debit, " +
        "         DECODE (d.drcr_type,'C', SUM (d.tr_bookamt),0) book_amt_credit, " +
        "         max(b.dc) dc, " +
        "         h.pk, h.tr_date, " +
        "         DECODE(DECODE(max(b.dc),1,'D','C') ,d.drcr_type,1,2)  order_cond" +
        "    FROM (SELECT DECODE (drcr_type, 'D', 1, -1) dc " +
        "            FROM tac_localcode " +
        "           WHERE pk = '" + l_account_pk +"') b, " +
        "         tac_hgtrh h, " +
        "         tac_hgtrd d " +
        "   WHERE h.del_if = 0 " +
        "     AND d.del_if = 0 " +
        "     AND h.pk = d.tac_hgtrh_pk " +
        "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) " +
        "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from +"', 'YYYYMMDD') AND TO_DATE ('" + l_date_to +"', 'YYYYMMDD') " +
        "     AND h.tco_company_pk = '" + l_company_pk +"' " +
        "     AND d.tac_abacctcode_pk IN (  select pk from tac_abacctcode where del_if =0 and  USE_YN ='Y' and TAC_LOCALCODE_PK in     (SELECT hg.TAC_localCODE_PK  FROM TAC_HGDDBAL_local hg WHERE hg.DEL_IF =0 AND hg.tco_company_pk =  '"+ l_company_pk +"'  AND hg.tac_localcode_pk in ( SELECT pk "+
 "                                       FROM tac_localcode "+
 "                                      WHERE del_if = 0 AND leaf_yn = 'Y' "+
 "                                 CONNECT BY pac_pk = PRIOR pk "+
 "                                 START WITH pk = " + l_account_pk + "))) "+
        " GROUP BY   h.pk, h.tr_date,h.voucherno,d.drcr_type " +
        " ) " +
        " ORDER BY tr_date,order_cond, voucherno ,pk ";
}
else if (l_rpt_Option == "FIFO")
{
    SQL = "select TO_CHAR (tr_date, 'DD/MM/YYYY'), " +
        " DECODE (drcr_type, 'D', voucherno, '') voucherno_debit, " +
        " DECODE (drcr_type, 'C', voucherno, '') voucherno_credit, " +
        " remark2, remark, " +
        " TO_CHAR ( book_amt_debit, sf_get_format ('ACBG0040')) book_amt_debit, " +
        " TO_CHAR (book_amt_credit, sf_get_format ('ACBG0040')) book_amt_credit, " +
        " TO_CHAR(TO_NUMBER (" + p_open_bal + ") + SUM(book_amt_debit*dc - book_amt_credit*dc) OVER (ORDER BY tr_date ,pk,voucherno),sf_get_format ('ACBG0040')) AS closingbalance, " +
        "         pk, tr_date " +
        " FROM          " +
        " (     SELECT    " +
        "         d.drcr_type drcr_type, h.voucherno voucherno, " +
        "         max(d.remark2) remark2, max(d.remark) remark, " +
        "         DECODE (d.drcr_type,'D',SUM(d.tr_bookamt), 0) book_amt_debit, " +
        "         DECODE (d.drcr_type,'C', SUM (d.tr_bookamt),0) book_amt_credit, " +
        "         max(b.dc) dc, " +
        "         h.pk, h.tr_date, " +
        "         DECODE(DECODE(max(b.dc),1,'D','C') ,d.drcr_type,1,2)  order_cond" +
        "    FROM (SELECT DECODE (drcr_type, 'D', 1, -1) dc " +
        "            FROM tac_localcode " +
        "           WHERE pk = '" + l_account_pk + "') b, " +
        "         tac_hgtrh h, " +
        "         tac_hgtrd d " +
        "   WHERE h.del_if = 0 " +
        "     AND d.del_if = 0 " +
        "     AND h.pk = d.tac_hgtrh_pk " +
        "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) " +
        "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') " +
        "     AND h.tco_company_pk = '" + l_company_pk + "' " +
        "     AND d.tac_abacctcode_pk IN(  select pk from tac_abacctcode where del_if =0 and  USE_YN ='Y' and TAC_LOCALCODE_PK in     (SELECT hg.TAC_localCODE_PK  FROM TAC_HGDDBAL_local hg WHERE hg.DEL_IF =0 AND hg.tco_company_pk =  '"+ l_company_pk +"'  AND hg.tac_localcode_pk in ( SELECT pk "+
 "                                       FROM tac_localcode "+
 "                                      WHERE del_if = 0 AND leaf_yn = 'Y' "+
 "                                 CONNECT BY pac_pk = PRIOR pk "+
 "                                 START WITH pk = " + l_account_pk + "))) "+
        " GROUP BY   h.pk, h.tr_date,h.voucherno,d.drcr_type " +
        " ) " +
        " ORDER BY tr_date ,pk,voucherno ";
}  
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_Soquy_S07-DN_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00020_Soquy_S07-DN_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00020_Soquy_S07-DN_files/oledata.mso">
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
  <o:LastPrinted>2008-05-05T07:37:24Z</o:LastPrinted>
  <o:Created>2006-06-29T05:06:28Z</o:Created>
  <o:LastSaved>2008-06-06T03:54:53Z</o:LastSaved>
  <o:Company>abc</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .75in .5in;
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
.xl25
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
.xl26
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
.xl27
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
.xl28
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
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl34
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	}
.xl39
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
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
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
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
.xl47
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
.xl48
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
.xl49
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
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
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl55
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
.xl56
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
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
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
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
.xl62
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
.xl63
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
.xl64
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
.xl65
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
.xl66
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
.xl67
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
.xl68
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
.xl69
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
.xl70
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
.xl71
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
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl78
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
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
.xl80
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
.xl81
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
.xl82
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
.xl83
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
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>S&#7893; qu&#7929; (Mau so S07-DN)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:LeftColumnVisible>3</x:LeftColumnVisible>
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
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
  <x:Formula>='S&#7893; qu&#7929; (Mau so S07-DN)'!$A$9:$J$14</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; qu&#7929; (Mau so S07-DN)'!$7:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl37>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1247 style='border-collapse:
 collapse;table-layout:fixed;width:937pt'>
 <col class=xl37 width=89 span=2 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl37 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl37 width=236 span=2 style='mso-width-source:userset;mso-width-alt:
 8630;width:177pt'>
 <col class=xl38 width=110 span=3 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl37 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl36 colspan=4 width=384 style='height:15.75pt;
  mso-ignore:colspan;width:288pt'><%= p_cmp_name%></td>
  <td class=xl37 width=236 style='width:177pt'></td>
  <td class=xl37 width=236 style='width:177pt'></td>
  <td class=xl38 width=110 style='width:83pt'></td>
  <td class=xl73 colspan=2 width=220 style='mso-ignore:colspan;width:166pt'>Form number: S07-DN</td>
  <td class=xl37 width=61 style='width:46pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 colspan=5 style='height:15.75pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=4 class=xl93
  ><span
  style='mso-spacerun:yes'>                 </span>(Issued with Decision No. 15/2006/QĐ-BTC<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Tax
  Code/MST:&nbsp;&nbsp;<%= p_cmp_taxcode %></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl93>&nbsp;&nbsp;&nbsp;<span style='mso-spacerun:yes'>           
  </span>dated March 20, 2006 by Ministry) <span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=9 height=30 class=xl76 style='height:22.5pt'>CASH BOOK</td>
  <td class=xl39></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=9 height=26 class=xl77 style='height:19.5pt'>From date <%= p_dt_from %> to date <%= p_dt_to%></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'>Account code:</td>
  <td class=xl41 x:num><%= p_acc_code%></td>
  <td class=xl55>Account name:</td>
  <td class=xl42><%= p_acc_name %></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td colspan=2 class=xl78>Unit:<%= l_book_ccy%></td>
  <td class=xl37></td>
 </tr>
 <tr class=xl45 height=21 style='height:15.75pt'>
  <td height=21 class=xl43 style='height:15.75pt' >Date<span style='mso-spacerun:yes'> </span></td>
  <td class=xl43 style='border-left:none' >Voucher<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl79 style='border-right:.5pt solid black;border-left:
  none'>Voucher</td>
  <td rowspan=2 class=xl81 width=236 style='border-bottom:.5pt solid black;
  width:177pt'>Local Description</td>
  <td class=xl72 width=236 style='border-left:none;width:177pt'>Description</td>
  <td colspan=3 class=xl83>Amount</td>
  <td rowspan=2 class=xl44>Note</td>
 </tr>
 <tr class=xl45 height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt'>entered</td>
  <td class=xl46 style='border-left:none'>Date </td>
  <td class=xl47>Received</td>
  <td class=xl48>Paid</td>
  <td class=xl27 width=236 style='width:177pt'>&nbsp;</td>
  <td class=xl49>Received</td>
  <td class=xl49>Paid</td>
  <td class=xl50 style='border-right:.5pt solid windowtext;' >Balance<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl45 height=21 style='height:15.75pt'>
  <td height=21 class=xl33 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$9:$J$14" width=89 style='height:15.75pt;border-top:
  none;width:67pt'>A</td>
  <td class=xl33 id="_x0000_s1026" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'>B</td>
  <td class=xl33 id="_x0000_s1027" x:autofilter="all" width=103
  style='border-top:none;border-left:none;width:77pt'>C</td>
  <td class=xl33 id="_x0000_s1028" x:autofilter="all" width=103
  style='border-top:none;border-left:none;width:77pt'>D</td>
  <td class=xl33 id="_x0000_s1029" x:autofilter="all" width=236
  style='border-left:none;width:177pt'>E</td>
  <td class=xl33 id="_x0000_s1034" x:autofilter="all" width=236
  style='border-left:none;width:177pt'>&nbsp;</td>
  <td class=xl51 id="_x0000_s1030" x:autofilter="all" style='border-left:none'
  x:num>1</td>
  <td class=xl51 id="_x0000_s1031" x:autofilter="all" style='border-left:none'
  x:num>2</td>
  <td class=xl51 id="_x0000_s1032" x:autofilter="all" style='border-left:none;border-right:.5pt solid windowtext;'
  x:num>3</td>
  <td class=xl44 id="_x0000_s1033" x:autofilter="all" style='border-top:none;
  border-left:none'>F</td>
 </tr>
 <tr class=xl40 height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl27 width=236 style='width:177pt'>Opening Balance</td>
  <td class=xl27 width=236 style='width:177pt'>&nbsp;</td>
  <td class=xl34 x:str>&nbsp;</td>
  <td class=xl35 x:str>&nbsp;</td>
  <td class=xl89 style='mso-spacerun:yes' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= p_open_bal_xls %></td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
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
 <tr class=xl40 >
  <td class=xl56 ><%= strDate_Dsp %></td>
  <td class=xl56 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl60 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl60 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl61 width=236 style='border-left:none;width:177pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl61 width=236 style='border-left:none;width:177pt'><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl62 style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][5].ToString()%></td>
  <td class=xl63 style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl90 style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl53 style='border-left:none' x:num><%=dt_detail.Rows[i][8].ToString()%></td>
 </tr>
 <%
	}
		else
		//'height=21 style='height:15.75pt'
	{
 %>
 <tr class=xl40 >
  <td class=xl56 style='border-top:none'><%= strDate_Dsp %></td>
  <td class=xl56 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl60 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl60 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl61 width=236 style='border-top:none;border-left:none;width:177pt'><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl61 width=236 style='border-top:none;border-left:none;width:177pt'><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl62 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][5].ToString()%></td>
  <td class=xl63 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl90 align=right style='border-top:none;border-left:none'
  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[i][8].ToString()%></td>
 </tr>
 <%
	}
	}
	}
 %>
 <tr class=xl40 height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl28 style='height:15.75pt;border-top:.5pt solid windowtext;border-right:none;'>&nbsp;</td>
  <td class=xl65 width=236 style='border-top:.5pt solid windowtext;border-left:none;width:177pt'>Total Amount Incurred</td>
  <td class=xl65 width=236 style='border-top:.5pt solid windowtext;border-left:none;width:177pt'>&nbsp;</td>
  <td class=xl66 x:num style="border-top:.5pt solid windowtext;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" ><%= p_debit_xls %></td>
  <td class=xl66 x:num style="border-top:.5pt solid windowtext;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>';" ><%= p_credit_xls %></td>
  <td class=xl91 style='border-top:.5pt solid windowtext;border-left:none'
  x:str></td>
  <td class=xl57 style='border-top:.5pt solid windowtext;border-left:none'>&nbsp;</td>
 </tr>
 
 <tr class=xl40 height=21 style='height:15.75pt'>
  <td height=21 class=xl67 colspan=4 style='height:15.75pt;border-top:.5pt solid windowtext;border-right:none;'>&nbsp;</td>
  <td class=xl69 width=236 style='border-top:.5pt solid windowtext;border-left:none;width:177pt'>Closing Balance</td>
  <td class=xl69 width=236 style='border-top:.5pt solid windowtext;border-left:none;width:177pt'>&nbsp;</td>
  <td class=xl70 style='border-top:.5pt solid windowtext;border-left:none' x:str></td>
  <td class=xl71 style='border-top:.5pt solid windowtext;border-left:none' x:str></td>
  <td class=xl92 align=right style='border-top:.5pt solid windowtext;border-left:none'
   style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= p_close_bal_xls %></td>
  <td class=xl58 style='border-top:.5pt solid windowtext;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl40 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl40 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>
 <tr class=xl40 height=21 style='height:15.75pt'>
  <td colspan=8 height=21 class=xl86 style='height:15.75pt'>The book are…. pages
  , number from<span style='mso-spacerun:yes'>  </span>page 01
  to<span style='mso-spacerun:yes'>  </span>page……</td>
  <td class=xl52></td>
  <td class=xl40></td>
 </tr>
 <tr class=xl40 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl29 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl87>Date <%= l_date_to.Substring(6, 2) %>/<%= l_date_to.Substring(4, 2) %>/<%= l_date_to.Substring(0, 4) %></td>
  <td class=xl30></td>
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
 <tr class=xl40 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl31 style='height:17.25pt'><%= v4 %></td>
  <td class=xl31><%= v5 %></td>
  <td class=xl31></td>
  <td colspan=3 class=xl88><%= v6 %></td>
  <td class=xl32></td>
 </tr>
 <tr class=xl40 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl54 style='height:17.25pt'><%=g4 %></td>
  <td class=xl54><%=g5 %></td>
  <td class=xl54></td>
  <td colspan=3 class=xl85><%=g6 %></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl40 height=23 style='height:17.25pt'>
  <td height=23 colspan=6 class=xl40 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>
 <tr class=xl40 height=23 style='height:17.25pt'>
  <td height=23 colspan=6 class=xl40 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>
 <tr class=xl40 height=23 style='height:17.25pt'>
  <td height=23 colspan=6 class=xl40 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>
 <tr class=xl40 height=23 style='height:17.25pt'>
  <td height=23 colspan=6 class=xl40 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>
 <tr class=xl40 height=23 style='height:17.25pt'>
  <td height=23 colspan=6 class=xl40 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>    
  <tr class=xl40 height=23 style='height:17.25pt'>
  <td colspan=4 height=23 class=xl31 style='height:17.25pt'><%= n4 %></td>
  <td class=xl31><%= n5 %></td>
  <td class=xl31></td>
  <td colspan=3 class=xl88><%= n6 %></td>
  <td class=xl32></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=236 style='width:177pt'></td>
  <td width=236 style='width:177pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=61 style='width:46pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
