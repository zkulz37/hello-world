<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
	string l_seq = Request["seq"];
	string l_company_pk = Request["company_pk"];
	
	string p_company_nm = "";
	string p_voucher_no = "";
	string p_ngay = "";
	string p_thang = "";
	string p_nam = "";
	string p_remark = "";
	string p_remark2 = "";
	string p_customer = "";
	string p_customer_bank = "";
	string p_ccy = "";
	string p_amount = "";
	string p_fmt_amount = "";
	string p_rate = "";
	string p_book_ccy = "";
	string p_total_debit = "";
	string p_total_credit = "";
	string p_TaxAmount = "";
	
	string SQL = "SELECT CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y'";

	DataTable dt_book_ccy = ESysLib.TableReadOpen(SQL);
	if (dt_book_ccy.Rows.Count >0)
	{
		p_book_ccy = dt_book_ccy.Rows[0][0].ToString();
	}
	
        SQL = "SELECT sf_get_company_name (v.tco_company_pk), " + 
        "       v.voucherno, " +
        "       TO_CHAR (to_date(v.tr_date, 'YYMMDD'),'DD') ngay, " +
        "       TO_CHAR (to_date(v.tr_date, 'YYMMDD'),'MM') thang, " +
        "       TO_CHAR (to_date(v.tr_date, 'YYMMDD'),'YYYY') nam, " +
        "       (select partner_name from tco_buspartner where del_if = 0 and pk = v.tco_buspartner_pk) partner_nm, " +
        "       V.REMARK, " +
        "       V.REMARK2 " +
        "  FROM TAC_BPRVPV v " +
        " WHERE PK = (select TR_TABLE_PK from tac_hgtrh where pk = '"+l_seq+"') " ;

	DataTable dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
		p_company_nm = dt.Rows[0][0].ToString();
		p_voucher_no = dt.Rows[0][1].ToString();
		p_ngay = dt.Rows[0][2].ToString();
		p_thang = dt.Rows[0][3].ToString();
		p_nam = dt.Rows[0][4].ToString();	
		p_customer = dt.Rows[0][5].ToString();	
		p_remark = dt.Rows[0][6].ToString(); 
		p_remark2 = dt.Rows[0][7].ToString();
	}
	
	SQL = " SELECT   d.ccy, TO_CHAR(SUM (d.TR_AMT),'9,999,999,999,990.99'), TRIM(TO_CHAR(SUM(D.TR_AMT), DECODE(D.CCY,'VND','9,999,999,999,990','9,999,999,999,990.99')))FMT ";
	SQL += "    ,d.TR_RATE  ";
	SQL += "    FROM tac_hgtrd d ";
	SQL += "   WHERE d.del_if = 0 ";
	SQL += "     AND d.tac_hgtrh_pk = " + l_seq;
	SQL += "     AND d.drcr_type = 'D' ";
	SQL += "     AND d.tac_abacctcode_pk IN (SELECT pk FROM tac_abacctcode WHERE (ac_cd LIKE '111%'  or ac_cd LIKE '112%') ) ";
	SQL += "  GROUP BY ccy,TR_RATE ";
	
	DataTable dt2 = ESysLib.TableReadOpen(SQL);
	if (dt2.Rows.Count > 0)
	{
		p_ccy = dt2.Rows[0][0].ToString();
		p_fmt_amount = dt2.Rows[0][2].ToString();
		p_rate = dt2.Rows[0][3].ToString();
	}  	
	
	SQL = "SELECT CASE    WHEN ac_get_accdlocal_by_acpk (D.TAC_ABACCTCODE_PK, " + l_company_pk + ") <> " +
       "                                    ac_GET_ACCD (D.TAC_ABACCTCODE_PK, " + l_company_pk + ") " +
       "            THEN " +
       "             ac_get_accdlocal_by_acpk (D.TAC_ABACCTCODE_PK, " + l_company_pk + ") || '/' " +
       "             || ac_GET_ACCD (D.TAC_ABACCTCODE_PK, " + l_company_pk + ") " +
       "          ELSE " +
       "             ac_GET_ACCD (D.TAC_ABACCTCODE_PK, " + l_company_pk + ") " +
       "       END   ACCD, " +
        " ac_GET_ACNM(D.TAC_ABACCTCODE_PK," + l_company_pk + ", 'ENG'),max(REMARK), " + 
        " DECODE(DRCR_TYPE,'D',TO_CHAR(sum(TR_BOOKAMT),DECODE('" + p_book_ccy + "','VND','9,999,999,999,990','9,999,999,999,990.99')),'') DEBIT_AMT, " + "DECODE(DRCR_TYPE,'D','',TO_CHAR(sum(TR_BOOKAMT),DECODE('" + p_book_ccy + "','VND','9,999,999,999,990','9,999,999,999,990.99'))) CREDIT_AMT " +
        " FROM TAC_HGTRD D " +
        " WHERE D.DEL_IF = 0 " +
        " AND D.TAC_HGTRH_PK =  " + l_seq +
        " group by D.TAC_ABACCTCODE_PK, DRCR_TYPE ORDER BY DRCR_TYPE desc ";
	
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);	
	
	SQL = "SELECT " + 
        " TO_CHAR(SUM(DECODE(DRCR_TYPE,'D',TR_BOOKAMT,0)),DECODE('"+p_book_ccy+"','VND','9,999,999,999,990','9,999,999,999,990.99')) SUM_DEBIT, " +
        " TO_CHAR(SUM(DECODE(DRCR_TYPE,'C',TR_BOOKAMT,0)),DECODE('"+p_book_ccy+"','VND','9,999,999,999,990','9,999,999,999,990.99')) SUM_CREDIT " +
        " FROM TAC_HGTRD D " +
        " WHERE D.DEL_IF = 0 " +
        " AND D.TAC_HGTRH_PK = " + l_seq ;
	DataTable dt_total = ESysLib.TableReadOpen(SQL);
	if(dt_total.Rows.Count >0)
	{
		p_total_debit = dt_total.Rows[0][0].ToString();
		p_total_credit = dt_total.Rows[0][1].ToString();
	}
	
	SQL	= "SELECT TRIM (TO_CHAR (SUM (d.TR_AMT), '9,999,999,999,990.99')) " + 
        "  FROM tac_hgtrd d " +
        " WHERE     d.del_if = 0 " +
        "       AND d.tac_hgtrh_pk = '"+l_seq+"' " +
        " and drcr_type = 'D' AND d.tac_abacctcode_pk not IN " +
        "              (SELECT pk " +
        "                 FROM tac_abacctcode " +
        "                WHERE (ac_cd LIKE '133%' OR ac_cd LIKE '3331%')) " ;
	DataTable dt_Amt = ESysLib.TableReadOpen(SQL);
	if(dt_Amt.Rows.Count >0)
	{
		p_amount = dt_Amt.Rows[0][0].ToString();
	}
	
	SQL	= "SELECT TRIM (TO_CHAR (SUM (d.TR_AMT), '9,999,999,999,990.99')) " + 
        "  FROM tac_hgtrd d " +
        " WHERE     d.del_if = 0 " +
        "       AND d.tac_hgtrh_pk = '"+l_seq+"' " +
        "       AND d.tac_abacctcode_pk IN " +
        "              (SELECT pk " +
        "                 FROM tac_abacctcode " +
        "                WHERE (ac_cd LIKE '133%' OR ac_cd LIKE '3331%')) " ;
	DataTable dt_TaxAmt = ESysLib.TableReadOpen(SQL);
	if(dt_TaxAmt.Rows.Count >0)
	{
		p_TaxAmount = dt_TaxAmt.Rows[0][0].ToString();
	}
%>	
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="NOBLAND_Receipt%20Voucher_files/filelist.xml">
<link rel=Edit-Time-Data href="NOBLAND_Receipt%20Voucher_files/editdata.mso">
<link rel=OLE-Object-Data href="NOBLAND_Receipt%20Voucher_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>Kenzie</o:LastAuthor>
  <o:LastPrinted>2013-07-03T01:56:52Z</o:LastPrinted>
  <o:Created>2010-12-29T07:12:23Z</o:Created>
  <o:LastSaved>2013-07-03T01:57:11Z</o:LastSaved>
  <o:Company>COMPUTER</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .25in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-horizontal-page-align:center;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
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
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times, sans-serif;
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
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022VND\0022\#\,\#\#0\.00";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022VND\0022\#\,\#\#0\.00";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022VND\0022\#\,\#\#0\.00";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"yyyy\\-mm\\-dd\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl108
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl109
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl110
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
.xl111
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl112
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
.xl113
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl116
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022VND\0022\#\,\#\#0\.00";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl117
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022VND\0022\#\,\#\#0\.00";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl118
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl119
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl120
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl121
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl122
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl123
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl124
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl127
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl128
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl129
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl132
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl133
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl134
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
.xl135
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
.xl136
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl137
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl138
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl139
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl140
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl141
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl142
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl143
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl144
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl145
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl146
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl147
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl148
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl149
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl150
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl151
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl152
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl153
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl154
	{mso-style-parent:style43;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl155
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Payment Voucher</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>82</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>24</x:ActiveRow>
       <x:ActiveCol>18</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7500</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=898 style='border-collapse:
 collapse;table-layout:fixed;width:675pt'>
 <col class=xl66 width=5 style='mso-width-source:userset;mso-width-alt:182;
 width:4pt'>
 <col class=xl66 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl66 width=34 span=2 style='mso-width-source:userset;mso-width-alt:
 1243;width:26pt'>
 <col class=xl66 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl66 width=9 style='mso-width-source:userset;mso-width-alt:329;
 width:7pt'>
 <col class=xl66 width=84 span=5 style='mso-width-source:userset;mso-width-alt:
 3072;width:63pt'>
 <col class=xl66 width=9 style='mso-width-source:userset;mso-width-alt:329;
 width:7pt'>
 <col class=xl66 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl66 width=59 span=3 style='mso-width-source:userset;mso-width-alt:
 2157;width:44pt'>
 <col class=xl66 width=5 style='mso-width-source:userset;mso-width-alt:182;
 width:4pt'>
 <col class=xl66 width=64 style='width:48pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl66 width=5 style='height:28.5pt;width:4pt'></td>
  <td colspan=16 class=xl107 width=829 style='width:623pt'><%=p_company_nm%></td>
  <td class=xl66 width=64 style='width:48pt'></td>
 </tr>
 <tr height=37 style='height:27.75pt'>
  <td height=37 class=xl66 style='height:27.75pt'></td>
  <td colspan=16 class=xl108>Expenditure (Clear Cash Advance) - CASH</td>
  <td class=xl66></td>
 </tr>
 <tr height=3 style='mso-height-source:userset;height:2.25pt'>
  <td height=3 class=xl88 style='height:2.25pt'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td colspan=10 class=xl109>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl88>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl97 style='height:27.75pt;border-top:none'>&nbsp;</td>
  <td class=xl66 colspan=4 style='mso-ignore:colspan'>Payment No (Voucher No):</td>
  <td class=xl66></td>
  <td class=xl77 colspan=2 style='mso-ignore:colspan'><%=p_voucher_no%> (<%=l_seq%>)</td>
  <td colspan=6 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl89 style='border-top:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr class=xl76 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl94 style='height:28.5pt'>&nbsp;</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black'>Prepared by</td>
  <td colspan=3 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Verified by</td>
  <td class=xl75 style='border-left:none'>Manager</td>
  <td class=xl78 width=84 style='border-left:none;width:63pt'>Factory<br>
    Manager</td>
  <td class=xl78 width=84 style='border-left:none;width:63pt'>General<br>
    Manager</td>
  <td class=xl78 width=84 style='border-left:none;width:63pt'>General<br>
    Director</td>
  <td class=xl78 width=84 style='border-left:none;width:63pt'>CEO</td>
  <td colspan=2 class=xl113 width=41 style='border-left:none;width:31pt'>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl100 width=59 style='border-left:none;width:44pt'>&nbsp;</td>
  <td class=xl101 style='border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-left:none'>&nbsp;</td>
  <td class=xl76></td>
 </tr>
 <tr height=65 style='mso-height-source:userset;height:48.75pt'>
  <td height=65 class=xl95 style='height:48.75pt'>&nbsp;</td>
  <td colspan=2 class=xl121 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=3 class=xl121 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl124 width=41 style='border-left:none;width:31pt'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl95 style='height:16.5pt'>&nbsp;</td>
  <td colspan=2 class=xl126 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=3 class=xl126 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl129 width=41 style='border-left:none;width:31pt'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl92 style='border-left:none'>&nbsp;</td>
  <td class=xl81></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl96 style='height:21.0pt'>&nbsp;</td>
  <td colspan=2 class=xl104>Date:</td>
  <td colspan=3 class=xl105 ><%=p_nam%>-<%=p_thang%>-<%=p_ngay%></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl106 width=41 style='width:31pt'>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl93>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl68 style='height:24.75pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl115>Total amount:</td>
  <td colspan=13 class=xl116 style='border-right:.5pt solid black'  x:num><%=p_ccy%> <%=p_fmt_amount%></td>
  <td class=xl66></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl69 style='height:18.0pt'>&nbsp;</td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan'>Customer:</td>
  <td colspan=14 class=xl118 style='border-right:.5pt solid black'><%=p_customer%></td>
  <td class=xl66></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl69 style='height:18.0pt'>&nbsp;</td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan'>Customer bank:</td>
  <td colspan=14 class=xl119 style='border-right:.5pt solid black'><%=p_customer_bank%></td>
  <td class=xl66></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl69 style='height:18.0pt'>&nbsp;</td>
  <td class=xl66 colspan=2 style='mso-ignore:colspan'>Description:</td>
  <td colspan=14 class=xl118 style='border-right:.5pt solid black'><%=p_remark%></td>
  <td class=xl66></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl69 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 rowspan=4 class=xl72></td>
  <td colspan=14 class=xl118 style='border-right:.5pt solid black'><%=p_remark2%></td>
  <td class=xl66></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl69 style='height:18.0pt'>&nbsp;</td>
  <td colspan=14 class=xl118 style='border-right:.5pt solid black'></td>
  <td class=xl66></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl69 style='height:18.0pt'>&nbsp;</td>
  <td colspan=14 class=xl118 style='border-right:.5pt solid black'></td>
  <td class=xl66></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl69 style='height:18.0pt'>&nbsp;</td>
  <td colspan=3 class=xl131>Amount:</td>
  <td colspan=3 class=xl79 x:num><%=p_ccy%> <%=p_amount%></td>
  <td class=xl83>Tax:</td>
  <td colspan=5 class=xl79><%=p_TaxAmount%></td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl82 style='height:21.0pt'>&nbsp;</td>
  <td colspan=16 class=xl132 style='border-right:.5pt solid black'><span
  style='mso-spacerun:yes'>                         </span>Corporation bank:</td>
  <td class=xl66></td>
 </tr>
 <tr class=xl76 height=21 style='height:15.75pt'>
  <td height=21 class=xl87 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td colspan=16 class=xl134 style='border-right:.5pt solid black'>Acounting
  Dept</td>
  <td class=xl76></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl68 style='height:4.5pt;border-top:none'>&nbsp;</td>
  <td colspan=16 class=xl136 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr class=xl72 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl70 style='height:21.0pt'>&nbsp;</td>
  <td colspan=2 class=xl75>Checked by</td>
  <td colspan=3 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Chief Acc</td>
  <td class=xl75 style='border-left:none'>Acc Manager</td>
  <td colspan=5 rowspan=3 class=xl70 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Cashier</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Received By</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72></td>
 </tr>
 <tr height=65 style='mso-height-source:userset;height:48.75pt'>
  <td height=65 class=xl69 style='height:48.75pt'>&nbsp;</td>
  <td colspan=2 class=xl139>&nbsp;</td>
  <td colspan=3 class=xl121 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl139 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl121 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl69 style='height:16.5pt'>&nbsp;</td>
  <td colspan=2 class=xl139>&nbsp;</td>
  <td colspan=3 class=xl121 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl73 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl139 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl121 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl69 style='height:4.5pt'>&nbsp;</td>
  <td colspan=16 class=xl72 style='border-right:.5pt solid black'></td>
  <td class=xl66></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl110 style='border-right:.5pt solid black;
  height:18.0pt'>Acc code</td>
  <td colspan=3 class=xl75 style='border-left:none'>Item</td>
  <td colspan=4 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td colspan=2 class=xl75 style='border-left:none'>Debit</td>
  <td colspan=4 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Credit</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>NO</td>
  <td class=xl76></td>
 </tr>
 <%
	int _row = 0;
	for(int i=0;i<dt_detail.Rows.Count;i++)
	{	
		if(dt_detail.Rows.Count>=7)
		{
 %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl121 style='border-right:.5pt solid black;  height:24.95pt' x:num><%= dt_detail.Rows[i][0].ToString() %></td>
  <td colspan=3 class=xl143 width=121 style='border-left:none;width:92pt'><%= dt_detail.Rows[i][1].ToString() %></td>
  <td colspan=4 class=xl144 width=261 style='border-right:.5pt solid black;  border-left:none;width:196pt'><%= dt_detail.Rows[i][2].ToString() %></td>
  <td colspan=2 class=xl147 style='border-left:none' x:num><%= dt_detail.Rows[i][3].ToString() %></td>
  <td colspan=4 class=xl140 style='border-right:.5pt solid black;border-left:  none;text-align:right'><%= dt_detail.Rows[i][4].ToString() %></td>
  <td colspan=2 class=xl121 style='border-right:.5pt solid black;border-left:  none'></td>
  <td class=xl66></td>
 </tr>
<%}else{
	_row = 7-dt_detail.Rows.Count;
%>
<tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl121 style='border-right:.5pt solid black;  height:24.95pt' x:num><%= dt_detail.Rows[i][0].ToString() %></td>
  <td colspan=3 class=xl143 width=121 style='border-left:none;width:92pt'><%= dt_detail.Rows[i][1].ToString() %></td>
  <td colspan=4 class=xl144 width=261 style='border-right:.5pt solid black;  border-left:none;width:196pt'><%= dt_detail.Rows[i][2].ToString() %></td>
  <td colspan=2 class=xl147 style='border-left:none' x:num><%= dt_detail.Rows[i][3].ToString() %></td>
  <td colspan=4 class=xl140 style='border-right:.5pt solid black;border-left:  none;text-align:right'><%= dt_detail.Rows[i][4].ToString() %></td>
  <td colspan=2 class=xl121 style='border-right:.5pt solid black;border-left:  none'></td>
  <td class=xl66></td>	
</tr>

<%
}
}
for(int k=0;k<_row;k++){
%>
<tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=2 height=33 class=xl121 style='border-right:.5pt solid black;  height:24.95pt' x:num></td>
  <td colspan=3 class=xl143 width=121 style='border-left:none;width:92pt'></td>
  <td colspan=4 class=xl144 width=261 style='border-right:.5pt solid black;  border-left:none;width:196pt'></td>
  <td colspan=2 class=xl147 style='border-left:none' x:num></td>
  <td colspan=4 class=xl140 style='border-right:.5pt solid black;border-left:  none;text-align:right'></td>
  <td colspan=2 class=xl121 style='border-right:.5pt solid black;border-left:  none'></td>
  <td class=xl66></td>	
</tr>
<%}%>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=9 height=33 class=xl151 style='border-right:.5pt solid black;  height:24.95pt'>Total</td>
  <td colspan=2 class=xl154 style='border-left:none' x:num><%=p_total_debit%></td>
  <td colspan=4 class=xl155 style='border-right:.5pt solid black;border-left:  none' x:num><%=p_total_credit%></td>
  <td colspan=2 class=xl151 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr height=154 style='mso-height-source:userset;height:115.5pt'>
  <td colspan=17 height=154 class=xl148 style='border-right:.5pt solid black;
  height:115.5pt'>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=17 height=25 class=xl121 style='border-right:.5pt solid black;
  height:18.75pt'>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=5 style='width:4pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=9 style='width:7pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=9 style='width:7pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=5 style='width:4pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
