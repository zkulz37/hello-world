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
    string l_company_pk = "" +Request["company_pk"];
	string l_date_from	= Request["dtbFrom"];
	string l_date_to = Request["dtbTo"];
	string l_book_ccy = Request["Bookccy"];
	string l_status = Request["status"];
   
    string p_cmp_name = "";
	string p_cmp_add = "";	
	string p_cmp_taxcode = "";
	string p_cmp_fname = "";
	string p_cmp_fadd ="";
	string p_cmp_fname2 ="";
	string p_rpt_date = "";
    string p_date_frm = "";
    string p_date_to = "";
    string p_acpk = "";
    string p_accd = "";
    string p_acnm = "";
    string p_opentrans = "0";
    int i = 0;
    int j = 0;
    int k = 0, m = 0; // counter account code
    string SQLDetail = "";
    string SQLTotal = "";
    string p_bankpk = "";
    string p_bankacc = "";
    string p_bankid = "";
    string p_accbank_pklist = "";
    string p_strtmp = "";
    string p_bankopenbal = "";
    string p_accpk_main = "";
    string p_open_usd = "0";
    ///////////////// count doi ung
    string l_stt = "";
    string l_tr_ccy = "";
	string l_voucherno = "";
    decimal l_rec_usd = 0;
    decimal l_spend_usd = 0;
    decimal l_rec_vnd = 0;
    decimal l_spend_vnd = 0;
    
    decimal l_amt = 0;
    decimal l_bal_vnd = 0, l_bal_usd = 0;
    int l_flag = 0;
	 string SQL = " SELECT partner_lname, addr2, tax_code,to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
	SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date, partner_name, addr1,UPPER(partner_name),TRIM(INITCAP(TO_CHAR(SYSDATE,'MONTH')))||' '||LOWER(TO_CHAR(SYSDATE,'DDTH YYYY'))  FROM tco_company WHERE pk = '" + l_company_pk + "' ";
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
		p_date_frm = dt.Rows[0][3].ToString();
		p_date_to = dt.Rows[0][4].ToString();
		p_cmp_fname = dt.Rows[0][5].ToString();
		p_cmp_fadd = dt.Rows[0][6].ToString();
		p_cmp_fname2 = dt.Rows[0][7].ToString();
		p_rpt_date = dt.Rows[0][8].ToString(); 
    }  
    /*  list of accounts */
     SQL
        = "SELECT AC_CODE, (SELECT AC_NM FROM AC_GET_DRCRTYPETAC_ABACCTCODE WHERE PK = D.TAC_ABACCTCODE_PK ) AC_NM, D.TAC_ABACCTCODE_PK, " +
        " (SELECT CCY FROM AC_GET_DRCRTYPETAC_ABACCTCODE WHERE PK = D.TAC_ABACCTCODE_PK ) CCY " + 
            " FROM ACNT.TAC_ABTRACGRPD D, ACNT.TAC_ABTRACGRP P " +
            " WHERE P.ac_grp = '111' " +
            " and P.del_if = 0 " +
            " and p.app_grp = 'Y' " +
            " and P.tco_company_pk = " + l_company_pk +
            " and P.PK = D.TAC_ABTRACGRP_PK " +
            " and D.del_if 		= 0  ";
    DataTable dtAccLst = ESysLib.TableReadOpen(SQL);
	%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka60110040_daily_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka60110040_daily_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka60110040_daily_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2009-03-05T07:53:55Z</o:LastPrinted>
  <o:Created>2009-03-05T07:33:05Z</o:Created>
  <o:LastSaved>2009-03-05T08:43:40Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P";
	margin:.25in .2in .28in .2in;
	mso-header-margin:.2in;
	mso-footer-margin:.2in;
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
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]dd\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style16;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]dd\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style16;
	color:black;
	font-size:5.5pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	color:red;
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
.xl44
	{mso-style-parent:style16;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	color:black;
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
.xl55
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style16;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl59
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style16;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	color:blue;
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
.xl66
	{mso-style-parent:style16;
	color:blue;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style16;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style16;
	color:blue;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl81
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl82
	{mso-style-parent:style16;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl87
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0\;\[Red\]\#\,\#\#0\.0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl91
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl92
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl93
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl94
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
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
.xl97
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
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
.xl98
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	color:blue;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl118
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl119
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl120
	{mso-style-parent:style16;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl121
	{mso-style-parent:style16;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl122
	{mso-style-parent:style16;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl123
	{mso-style-parent:style16;
	color:red;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl124
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl125
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl126
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl127
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl128
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl129
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl130
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl131
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl132
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl133
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl134
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl135
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl136
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl137
	{mso-style-parent:style16;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl138
	{mso-style-parent:style16;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl139
	{mso-style-parent:style16;
	color:blue;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl140
	{mso-style-parent:style16;
	color:blue;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl141
	{mso-style-parent:style16;
	color:black;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl142
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl143
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl144
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl145
	{mso-style-parent:style16;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl146
	{mso-style-parent:style16;
	color:blue;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl147
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl148
	{mso-style-parent:style16;
	color:blue;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl149
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl150
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl151
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl152
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl153
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl154
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl155
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl156
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl157
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl158
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl159
	{mso-style-parent:style16;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl160
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl161
	{mso-style-parent:style16;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl162
	{mso-style-parent:style16;
	color:blue;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl163
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl164
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl165
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl166
	{mso-style-parent:style16;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl167
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl168
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl169
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl170
	{mso-style-parent:style16;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl171
	{mso-style-parent:style16;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl172
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl173
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Cash &amp; Bank</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>22</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8415</x:WindowHeight>
  <x:WindowWidth>15240</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Cash &amp; Bank'!$7:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1019 style='border-collapse:
 collapse;table-layout:fixed;width:765pt'>
 <col class=xl24 width=24 style='mso-width-source:userset;mso-width-alt:877;
 width:18pt'>
 <col class=xl25 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl25 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=302 style='mso-width-source:userset;mso-width-alt:11044;
 width:227pt'>
 <col class=xl24 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl26 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl26 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl26 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl26 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl27 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=12 height=22 class=xl86 width=1019 style='height:16.5pt;
  width:765pt'><%= p_cmp_fname%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=12 height=22 class=xl86 style='height:16.5pt'><%= p_cmp_fadd%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=12 height=22 class=xl86 style='height:16.5pt'>Tax code : <%= p_cmp_taxcode%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=12 height=32 class=xl28 style='height:24.0pt'><%= p_cmp_fname2%>- DETAIL OF DAILY SPENDING REPORT</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=6 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl30 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=6 class=xl31 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=4 class=xl87>Reported date : <%= p_rpt_date%></td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr class=xl30 height=54 style='mso-height-source:userset;height:40.5pt'>
  <td height=54 class=xl34 style='height:40.5pt'>NO</td>
  <td class=xl35>DATE</td>
  <td class=xl36 width=40 style='width:30pt'>CODE<br>
    NO.</td>
  <td class=xl37 width=302 style='width:227pt'>CONTENT</td>
  <td colspan=2 class=xl89 width=143 style='border-right:.5pt solid black;
  border-left:none;width:108pt'>RECEIVING</td>
  <td colspan=2 class=xl91 style='border-right:.5pt solid black;border-left:
  none' x:str="SPENDING"><span style='mso-spacerun:yes'> </span>SPENDING<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl93 width=174 style='border-right:.5pt solid black;
  border-left:none;width:131pt' x:str="BALANCE "><span
  style='mso-spacerun:yes'> </span>BALANCE<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 width=47 style='width:35pt' x:str="Exchange &#10;Rate VND/USD"><span
  style='mso-spacerun:yes'> </span>Exchange <br>
    Rate VND/USD<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl96 width=55 style='border-bottom:.5pt solid black;
  border-top:none;width:41pt'>Remark <br>
    ( N.o Voucher)</td>
 </tr>
 <% 
     for (k = 0; k < dtAccLst.Rows.Count; k++)
    {        
 %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=3 height=32 class=xl98 width=131 style='border-right:.5pt solid black;
  height:24.0pt;width:98pt'><%=dtAccLst.Rows[k][1].ToString()%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40 width=57 style='width:43pt' x:str="USD"><span
  style='mso-spacerun:yes'> </span>USD<span style='mso-spacerun:yes'> </span></td>
  <td class=xl40 width=86 style='width:65pt' x:str="VND"><span
  style='mso-spacerun:yes'> </span>VND<span style='mso-spacerun:yes'> </span></td>
  <td class=xl40 width=72 style='width:54pt' x:str="USD"><span
  style='mso-spacerun:yes'> </span>USD<span style='mso-spacerun:yes'> </span></td>
  <td class=xl40 width=95 style='width:71pt' x:str="VND"><span
  style='mso-spacerun:yes'> </span>VND<span style='mso-spacerun:yes'> </span></td>
  <td class=xl40 width=84 style='width:63pt' x:str="USD"><span
  style='mso-spacerun:yes'> </span>USD<span style='mso-spacerun:yes'> </span></td>
  <td class=xl40 width=90 style='width:68pt' x:str="VND"><span
  style='mso-spacerun:yes'> </span>VND<span style='mso-spacerun:yes'> </span></td>
  <td class=xl41 width=47 style='width:35pt'>&nbsp;</td>
 </tr>
<%
    SQL = "SELECT T.PK, T.AC_CD, T.AC_NM,  " +
        " TO_CHAR(TO_NUMBER(DECODE(T.DRCR_TYPE,'D','1','-1'))* (ACNT.SF_GET_DRCR_OPENBAL(T.TCO_COMPANY_PK,T.PK,'" + dtAccLst.Rows[k][3].ToString() + "','" + l_date_from + "','" + l_status + "','D','TRANS') - ACNT.SF_GET_DRCR_OPENBAL(T.TCO_COMPANY_PK,T.PK,'" + dtAccLst.Rows[k][3].ToString() + "','" + l_date_from + "','" + l_status + "','C','TRANS')),'9,999,999,999,990')   OPEN_BAL  " +
        "FROM ACNT.TAC_ABACCTCODE T  " +
        "WHERE T.DEL_IF =0  " +
        "AND T.LEAF_YN ='Y' " +
        "CONNECT BY pac_pk = PRIOR pk START WITH pk = (SELECT PK FROM ACNT.TAC_ABACCTCODE  " +
        "WHERE DEL_IF =0 AND TCO_COMPANY_PK = " + l_company_pk + " AND AC_CD = '" + dtAccLst.Rows[k][0].ToString() + "') ";
    DataTable dt_cash = ESysLib.TableReadOpen(SQL);
    p_opentrans = "0";
    p_open_usd = "0";     
    if (dt_cash.Rows.Count > 0)
    {
        for (i = 0; i < dt_cash.Rows.Count; i++)
        {
            p_acpk = dt_cash.Rows[i][0].ToString();
            p_accd = dt_cash.Rows[i][1].ToString();
            p_acnm = dt_cash.Rows[i][2].ToString();
            if(dtAccLst.Rows[k][3].ToString() == "VND")
                p_opentrans = dt_cash.Rows[i][3].ToString();
            else
                p_open_usd = dt_cash.Rows[i][3].ToString();
 %>
 
 <tr class=xl42 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=3 height=29 class=xl101 width=131 style='border-right:.5pt solid black;
  height:21.75pt;width:98pt'><%= dtAccLst.Rows[k][1]%></td>
  <td class=xl43 width=302 style='width:227pt'>A balance carried forward from
  the last account</td>
  <td class=xl119>&nbsp;</td>
  <td class=xl120>&nbsp;</td>
  <td class=xl121>&nbsp;</td>
  <td class=xl122>&nbsp;</td>
  <td class=xl44 style='mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= p_open_usd%></td>
  <td class=xl44 x:num><%= p_opentrans%></td>
  <td class=xl123>&nbsp;</td>
  <% if (i != 0)
     { %>
  <td class=xl123>&nbsp;</td>
  <%
    }
          %>
 </tr>
 <% 
    SQLDetail
        = "select * from  " +
            "( " +
            "select * from  " +
            "( " +
            "         SELECT 1 STT, INITCAP(TO_CHAR(H.TR_DATE,'DD-MON-YY')) TR_DATE,  " +
            "         D.REMARK, DECODE(D.DRCR_TYPE,'D',DECODE(D.CCY,'VND',0,TR_AMT),0) REC_USD,  " +
            "         DECODE(D.DRCR_TYPE,'D',DECODE(D.CCY,'VND',TR_AMT,0),0) REC_VND,  " +
            "         DECODE(D.DRCR_TYPE,'C',DECODE(D.CCY,'VND',0,TR_AMT),0) SPEN_USD,  " +
            "         DECODE(D.DRCR_TYPE,'C',DECODE(D.CCY,'VND',TR_AMT,0),0) SPEN_VND,  " +
            "         (TO_NUMBER('" + p_open_usd + "','9,999,999,999,990')+ SUM(DECODE (d.drcr_type,'D', DECODE (d.ccy, 'VND', 0, tr_amt),0) -DECODE (d.drcr_type,'C', DECODE (d.ccy, 'VND', 0, tr_amt), 0)) OVER (ORDER BY h.tr_date, h.pk, d.pk, h.voucherno) ) BAL_USD,  " +
            "         (TO_NUMBER('" + p_opentrans + "','9,999,999,999,990')+ SUM(DECODE (d.drcr_type,'D', DECODE (d.ccy, 'VND', tr_amt, 0),0) -DECODE (d.drcr_type,'C', DECODE (d.ccy, 'VND', tr_amt, 0), 0)) OVER (ORDER BY h.tr_date, h.pk, d.pk, h.voucherno) )  BAL_VND,  " +
            "         D.TR_RATE, H.VOUCHERNO, D.CCY  " +
            "         FROM ACNT.TAC_HGTRH H, ACNT.TAC_HGTRD D  " +
            "         WHERE H.DEL_IF =0   " +
            "         AND D.DEL_IF =0  " +
            "         AND H.PK = D.TAC_HGTRH_PK    " +
            "         AND H.TCO_COMPANY_PK = " + l_company_pk +
            "         AND H.TR_DATE BETWEEN TO_DATE('" + l_date_from + "','YYYYMMDD') AND TO_DATE('" + l_date_to + "','YYYYMMDD')  " +
	        " AND H.TR_STATUS in ('2', '0') " +
            "        AND D.TAC_ABACCTCODE_PK = " + p_acpk +
            "         ORDER BY H.TR_DATE,H.PK,D.PK ,H.VOUCHERNO " +
            ") " +
            "union all " +
            "select * from " +
            "( " +
            " SELECT 2 STT, INITCAP(TO_CHAR(H.TR_DATE,'DD-MON-YY')) TR_DATE, R.REMARK, " +
            " DECODE(R.DRCR_TYPE,'D',DECODE(D.CCY,'VND',0, r.TR_AMT),0) REC_USD,  " +
            " DECODE(R.DRCR_TYPE,'D',DECODE(D.CCY,'VND', r.TR_AMT,0),0) REC_VND,  " +
            " DECODE(R.DRCR_TYPE,'C',DECODE(D.CCY,'VND',0, r.TR_AMT),0)  SPEN_USD,  " +
            " DECODE(R.DRCR_TYPE,'C',DECODE(D.CCY,'VND', r.TR_AMT,0),0)  SPEN_VND,  " +
            " 0 BAL_USD,  " +
            " 0  BAL_VND,  " +
            " D.TR_RATE, H.VOUCHERNO, D.CCY   " +
            "  FROM acnt.tac_hgtrh h, acnt.tac_hgtrd_ref r, acnt.TAC_HGTRD D  " +
            " WHERE h.del_if = 0  " +
            "   AND h.pk = r.tac_hgtrh_pk  " +
	        " AND H.TR_STATUS in ('2', '0') " +
            "   AND r.del_if = 0  " +
            "   AND r.drcr_type = 'C'  " +
            "   AND r.tac_abacctcode_pk_dr = " + p_acpk + 
            "   AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD')  " +
            "   AND h.tco_company_pk = " + l_company_pk +
            "   and r.tac_hgtrd_pk = D.pk " +
            "   and d.del_if  = 0     " +
            "  ORDER BY h.tr_date,h.voucherno,h.pk " +
            "    )  " +
            "    union all " +
            "    select * from " +
            "	( " +
            "         SELECT 2 STT, INITCAP(TO_CHAR(H.TR_DATE,'DD-MON-YY')) TR_DATE,  " +
            "         R.REMARK, DECODE(R.DRCR_TYPE,'C',DECODE(D.CCY,'VND',0, r.TR_AMT),0) REC_USD,  " +
            "         DECODE(R.DRCR_TYPE,'C',DECODE(D.CCY,'VND', r.TR_AMT,0),0) REC_VND,  " +
            "        DECODE(R.DRCR_TYPE,'D',DECODE(D.CCY,'VND',0, r.TR_AMT),0)  SPEN_USD,  " +
            "        DECODE(R.DRCR_TYPE,'D',DECODE(D.CCY,'VND', r.TR_AMT,0),0)  SPEN_VND,  " +
            "         0 BAL_USD,  " +
            "         0  BAL_VND,  " +
            "         D.TR_RATE, H.VOUCHERNO , D.CCY   " +
            "          FROM acnt.tac_hgtrh h, acnt.tac_hgtrd_ref r, acnt.TAC_HGTRD D  " +
            "         WHERE h.del_if = 0  " +
            "           AND h.pk = r.tac_hgtrh_pk  " +
	        "   AND H.TR_STATUS in ('2', '0') " + 
            "           AND r.del_if = 0  " +
            "           AND r.drcr_type = 'C'  " +
            "           AND r.tac_abacctcode_pk_cr = " + p_acpk + 
            "           AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD')  " +
            "           AND h.tco_company_pk = '" + l_company_pk + "' " +
            "           and r.tac_hgtrd_pk = D.pk " +
            "           and d.del_if  = 0     " +
            "          ORDER BY h.tr_date,h.voucherno,h.pk " +
            "	) " +
            "    ) a " +
            "    order by a.tr_date, a.voucherno, a.STT " +
            "               ";
    DataTable dt_detail = ESysLib.TableReadOpen(SQLDetail);
    if (dt_detail.Rows.Count > 0)
    {
        //if (dt_detail.Rows[0][7].ToString() != "")
        //    l_bal_usd = decimal.Parse(dt_detail.Rows[0][7].ToString());
        //else
        l_bal_usd = decimal.Parse(p_open_usd.Replace(",", "")); 
        //if (dt_detail.Rows[0][8].ToString() != "" && dt_detail.Rows[0][8].ToString() != "0")
        //    l_bal_vnd = decimal.Parse(dt_detail.Rows[0][8].ToString());
        //else
        l_bal_vnd = decimal.Parse(p_opentrans.Replace(",", ""));
        
        for (j = 0; j < dt_detail.Rows.Count; j++)
        {
            l_stt = dt_detail.Rows[j][0].ToString();
            if (l_stt == "1")
            {
                l_tr_ccy = dt_detail.Rows[j][11].ToString();
            }
            else if (l_stt == "2")
            {
                if (dt_detail.Rows[j][3].ToString() != "")
                    l_rec_usd = decimal.Parse(dt_detail.Rows[j][3].ToString());
                else
                    l_rec_usd = 0;
                if (dt_detail.Rows[j][5].ToString() != "")
                    l_spend_usd = decimal.Parse(dt_detail.Rows[j][5].ToString());
                else
                    l_spend_usd = 0;
                if (dt_detail.Rows[j][4].ToString() != "")
                    l_rec_vnd = decimal.Parse(dt_detail.Rows[j][4].ToString());
                else
                    l_rec_vnd = 0;
                if (dt_detail.Rows[j][6].ToString() != "")
                    l_spend_vnd = decimal.Parse(dt_detail.Rows[j][6].ToString());
                else
                    l_spend_vnd = 0;
                
                if (l_tr_ccy == l_book_ccy)
                {
                    if (dt_detail.Rows[j][11].ToString() != l_tr_ccy)
                    {
                        if (l_book_ccy == "VND")
                            l_rec_usd = decimal.Round(l_rec_usd * decimal.Parse(dt_detail.Rows[j][9].ToString()), 0);
                        else
                            l_rec_usd = decimal.Round(l_rec_usd * decimal.Parse(dt_detail.Rows[j][9].ToString()), 2);
                        l_rec_vnd = l_rec_usd;
                        l_rec_usd = 0;
                        if (l_book_ccy == "VND")
                            l_spend_usd = decimal.Round(l_spend_usd * decimal.Parse(dt_detail.Rows[j][9].ToString()), 0);
                        else
                            l_spend_usd = decimal.Round(l_spend_usd * decimal.Parse(dt_detail.Rows[j][9].ToString()), 2);
                        l_spend_vnd = l_spend_usd;
                        l_spend_usd = 0;
                    }                                            
                }
                l_bal_vnd += l_rec_vnd - l_spend_vnd;
                l_bal_usd += l_rec_usd - l_spend_usd;
                
  %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl45 style='height:18.75pt' x:num><%=(j + 1)%></td>
  <td class=xl46 x:num><%= dt_detail.Rows[j][1].ToString()%></td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48 ><%= dt_detail.Rows[j][2].ToString()%></td>
  <td class=xl124 x:num><%= l_rec_usd%></td>
  <td class=xl125  x:num><%= l_rec_vnd%></td>
  <td class=xl124  x:num><%= l_spend_usd%></td>
  <td class=xl127  x:num><%= l_spend_vnd%></td>
  <td class=xl124  x:num><%= l_bal_usd%></td>
  <td class=xl49 x:num><%= l_bal_vnd%></td>
  <td class=xl128 x:num></td>
  <td class=xl167 x:str><%= dt_detail.Rows[j][10].ToString()%></td>
 </tr>
<%
    } //if 
} // for j
}
//
SQLTotal = " SELECT    " +
"         NVL(SUM(DECODE (d.drcr_type,'D', DECODE (d.ccy, 'VND', 0, tr_amt),0)),0) rec_usd, " +
"         SUM(DECODE (d.drcr_type,'D', DECODE (d.ccy, 'VND', tr_amt, 0), 0)) rec_vnd, " +
"         SUM(DECODE (d.drcr_type,'C', DECODE (d.ccy, 'VND', 0, tr_amt), 0)) spen_usd, " +
"         SUM(DECODE (d.drcr_type,'C', DECODE (d.ccy, 'VND', tr_amt, 0),0)) spen_vnd, " +
"         NVL((TO_NUMBER('" + p_open_usd + "','9,999,999,999,990.99')+ SUM(DECODE (d.drcr_type,'D', DECODE (d.ccy, 'VND', 0, tr_amt),0) - " +
" DECODE (d.drcr_type,'C', DECODE (d.ccy, 'VND', 0, tr_amt), 0)) ) ,0)       bal_usd, " +
"         NVL((TO_NUMBER('" + p_opentrans + "','9,999,999,999,990')+ SUM(DECODE (d.drcr_type,'D', DECODE (d.ccy, 'VND', tr_amt, 0),0) - " +
" DECODE (d.drcr_type,'C', DECODE (d.ccy, 'VND', tr_amt, 0), 0)) ) ,0)       bal_vnd " +
"          " +
"    FROM acnt.tac_hgtrh h, acnt.tac_hgtrd d " +
"   WHERE h.del_if = 0 " +
"     AND d.del_if = 0 " +
"     AND h.pk = d.tac_hgtrh_pk " +
        " AND H.TCO_COMPANY_PK = " + l_company_pk +
 " AND H.TR_DATE BETWEEN TO_DATE('" + l_date_from + "','YYYYMMDD') AND TO_DATE('" + l_date_to + "','YYYYMMDD') " +
 " AND H.TR_STATUS in ('2', '0') " +
 "AND D.TAC_ABACCTCODE_PK = " + p_acpk;
DataTable dt_total1 = ESysLib.TableReadOpen(SQLTotal);
if (dt_total1.Rows.Count > 0)
{ 
 %>
<tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl89 width=433 style='border-right:.5pt solid black;
  height:18.0pt;width:325pt'>TOTAL</td>
  <td class=xl129  style='border-top:.5pt solid black;'  x:num><%= dt_total1.Rows[0][0].ToString()%></td>
  <td class=xl133  style='border-top:.5pt solid black;'  x:num><%= dt_total1.Rows[0][1].ToString()%></td>
  <td class=xl134  style='border-top:.5pt solid black;'  x:num><%= dt_total1.Rows[0][2].ToString()%></td>
  <td class=xl133  style='border-top:.5pt solid black;'  x:num><%= dt_total1.Rows[0][3].ToString()%></td>
  <td class=xl135  style='border-top:.5pt solid black; mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";'  x:num><%= dt_total1.Rows[0][4].ToString()%></td>
  <td class=xl44  style='border-top:.5pt solid black;'   x:num><%= dt_total1.Rows[0][5].ToString()%></td>
  <td class=xl132  style='border-top:.5pt solid black;'>&nbsp;</td>
  <td class=xl169 style='border-top:.5pt solid black;' >&nbsp;</td>
 </tr> 
<%
    }
} // for i
} // if
}// for k
    /////////////////112
     SQL
        = "SELECT AC_CODE, (SELECT AC_NM FROM acnt.TAC_ABACCTCODE WHERE PK = D.TAC_ABACCTCODE_PK ) AC_NM, D.TAC_ABACCTCODE_PK, " +
            " (SELECT CCY FROM acnt.TAC_ABACCTCODE WHERE PK = D.TAC_ABACCTCODE_PK ) CCY " +
            "FROM acnt.TAC_ABTRACGRPD D, acnt.TAC_ABTRACGRP P " +
            "WHERE P.ac_grp = '112' " +
            "and P.del_if = 0 " +
            "and P.tco_company_pk = " + l_company_pk +
            "and P.PK = D.TAC_ABTRACGRP_PK " +
            "and D.del_if 		= 0  ";
    
     dtAccLst = ESysLib.TableReadOpen(SQL);
     for (k = 0; k < dtAccLst.Rows.Count; k++)
     {            
 %> 
 <tr class=xl56 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=3 height=38 class=xl104 width=131 style='border-right:.5pt solid black;
  height:28.5pt;width:98pt'><%=dtAccLst.Rows[k][1]%></td>
  <td class=xl58 width=302 style='width:227pt'></td>
  <td class=xl143>&nbsp;</td>
  <td class=xl144>&nbsp;</td>
  <td class=xl145>&nbsp;</td>
  <td class=xl144>&nbsp;</td>
  <td class=xl146>&nbsp;</td>
  <td class=xl147>&nbsp;</td>
  <td class=xl148>&nbsp;</td>
  <td class=xl171>&nbsp;</td>
 </tr>
<%
    SQL = " SELECT T.PK, T.AC_CD, T.AC_NM  " +
      " FROM acnt.TAC_ABACCTCODE T  " +
      " WHERE T.DEL_IF =0  " +
      " AND T.LEAF_YN ='Y' " +
      " CONNECT BY pac_pk = PRIOR pk START WITH pk = (SELECT PK FROM acnt.TAC_ABACCTCODE  " +
      " WHERE DEL_IF = 0 AND TCO_COMPANY_PK = " + l_company_pk + " AND AC_CD = '" + dtAccLst.Rows[k][0].ToString() + "') ";
    DataTable dt_accbank = ESysLib.TableReadOpen(SQL);
    p_accpk_main = dtAccLst.Rows[k][2].ToString();
    p_accbank_pklist = "";
    p_strtmp = "";
    if (dt_accbank.Rows.Count > 0)
    {
        for (i = 0; i < dt_accbank.Rows.Count; i++)
        {
            p_accbank_pklist = p_accbank_pklist + p_strtmp + dt_accbank.Rows[i][0].ToString();
            p_strtmp = ",";
        }
    }
    if (dtAccLst.Rows[k][0].ToString() == "1AA112200") // Foreign Currency
    {
        SQL = "SELECT PK, ACCOUNT_NO,BANK_ID, TO_CHAR(acnt.SF_GET_BANK_OPENBAL_MONTH('" + l_company_pk + "',PK,'" + l_date_from + "','','" + l_status + "','TRANS'),'9,999,999,999,990.99')  FROM acnt.TAC_ABDEPOMT WHERE DEL_IF =0 AND CCY IN ('" + dtAccLst.Rows[k][3].ToString() + "', 'EUR')  "; 
    }
    else
    {
        SQL = "SELECT PK, ACCOUNT_NO,BANK_ID, TO_CHAR(acnt.SF_GET_BANK_OPENBAL_MONTH('" + l_company_pk + "',PK,'" + l_date_from + "','','" + l_status + "','TRANS'),'9,999,999,999,990.99')  FROM acnt.TAC_ABDEPOMT WHERE DEL_IF =0 AND CCY ='" + dtAccLst.Rows[k][3].ToString() + "' ";
    }
    DataTable dt_bank = ESysLib.TableReadOpen(SQL);
    if (dt_bank.Rows.Count > 0)
    {
        
        for (i = 0; i < dt_bank.Rows.Count; i++)
        {
            p_bankpk = dt_bank.Rows[i][0].ToString();
            p_bankacc = dt_bank.Rows[i][1].ToString();
            p_bankid = dt_bank.Rows[i][2].ToString();
            p_bankopenbal = "0";
            p_open_usd = "0";
            l_bal_vnd = 0;
            l_bal_usd = 0;
            if (dtAccLst.Rows[k][3].ToString() == "VND")
            {
                p_bankopenbal = dt_bank.Rows[i][3].ToString();
                l_bal_vnd = decimal.Parse(p_bankopenbal.Replace(",", ""));
            }
            else
            {
                p_open_usd = dt_bank.Rows[i][3].ToString();
                l_bal_usd = decimal.Parse(p_open_usd.Replace(",", ""));
            }
 %> 
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=3 height=38 class=xl107 width=131 style='border-right:.5pt solid black;
  height:28.5pt;width:98pt'><%= p_bankid%></td>
  <td class=xl54 width=302 style='width:227pt'>A balance carried forward from
  the last account</td>
  <td class=xl129>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl130>&nbsp;</td>
  <td class=xl131>&nbsp;</td>
  <td class=xl59 style='mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%=p_open_usd %></td>
  <td class=xl59 x:num><%= p_bankopenbal%></td>
  <td class=xl132>&nbsp;</td>
  <td class=xl169>&nbsp;</td>
 </tr>
<%    
    SQLDetail
    = " select * from ( " +
        " select * from  " +
        " ( " +
        "         SELECT  h.pk h_pk, h.voucherno,h.remark,h.remark2 , INITCAP(TO_CHAR(H.TR_DATE,'DD-MON-YY')) trans_date,B.CCY CCY,  " +
        "         DECODE(B.CCY,'VND',0,NVL(B.YMD_DRTRANS,0)) in_amt_usd,  " +
        "         DECODE(B.CCY,'VND',NVL(B.YMD_DRTRANS,0),0) in_amt_vnd,  " +
        "         DECODE(B.CCY,'VND',0,NVL(B.YMD_CRTRANS,0)) out_amt_usd,   " +
        "         DECODE(B.CCY,'VND',NVL(B.YMD_CRTRANS,0),0) out_amt_vnd, " +
        "          (TO_NUMBER(TRIM('" + p_open_usd + "'),'9,999,999,999,990.99')+SUM( decode(B.CCY, 'VND', 0, NVL(B.YMD_DRTRANS,0)) - decode(B.CCY, 'VND', 0, NVL(B.YMD_CRTRANS,0) ) )OVER (ORDER BY  tr_date,h.voucherno,h.pk,B.PK )) BAL_USD_AMT,  " +
        "         (TO_NUMBER(TRIM('" + p_bankopenbal + "'),'9,999,999,999,990.99')+SUM( decode(B.CCY, 'VND', NVL(B.YMD_DRTRANS,0), 0) - decode(B.CCY, 'VND', NVL(B.YMD_CRTRANS,0), 0) )OVER (ORDER BY  tr_date,h.voucherno,h.pk,B.PK ))BAL_AMT,  " +
        "          h.tr_date,B.PK B_PK , 1 STT " +
        "                FROM acnt.TAC_HGTRH H, acnt.TAC_HGDEPODDBAL B  " +
        "                WHERE H.DEL_IF =0  AND B.DEL_IF =0  " +
        "                AND H.PK = B.TAC_HGTRH_PK  " +
        "                AND B.TR_STATUS =  " + l_status +
        "                AND B.TAC_ABDEPOMT_PK =  " + p_bankpk +
        "                AND B.TAC_ABACCTCODE_PK IN (" + p_accbank_pklist + ") " +
        "                AND H.TCO_COMPANY_PK = " + l_company_pk +
        "        AND H.TR_STATUS in ('2', '0') " +
        "                AND H.TR_DATE BETWEEN TO_DATE('" + l_date_from + "','YYYYMMDD') AND TO_DATE('" + l_date_to + "' ,'YYYYMMDD')  " +
        "                AND B.STD_YMD BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'  " +        
        " AND NVL (B.YMD_DRTRANS, 0) <> 0 " +
        "          ORDER BY  tr_date,voucherno,H_pK,B_PK " +
        ")	            " +
        "union all " +
        "select * from ( " +
        "         SELECT  h.pk h_pk, h.voucherno,r.remark,r.remark2 , INITCAP(TO_CHAR(H.TR_DATE,'DD-MON-YY')) trans_date, D.CCY CCY,  " +
        "         DECODE(r.drcr_type, 'C', DECODE(D.CCY,'VND', 0, NVL(D.TR_AMT,0)), 0 )  in_amt_usd,  " +
        "         DECODE(r.drcr_type, 'C', DECODE(D.CCY,'VND', NVL(D.TR_AMT,0), 0), 0 )  in_amt_vnd,  " +
        "        DECODE(r.drcr_type, 'C', 0, DECODE(D.CCY,'VND',0,NVL(D.TR_AMT,0)) ) out_amt_usd,   " +
        "        DECODE(r.drcr_type, 'C', 0, DECODE(D.CCY,'VND',NVL(D.TR_AMT,0), 0) )  out_amt_vnd,  " +
        "         0 BAL_USD_AMT,  " +
        "         0 BAL_AMT,  " +
        "          h.tr_date, D.PK D_PK, 2 STT  " +
        "          FROM acnt.tac_hgtrh h, acnt.tac_hgtrd_ref r, acnt.TAC_HGTRD D  " +
        "         WHERE h.del_if = 0  " +
        "           AND h.pk = r.tac_hgtrh_pk  " +
        "        AND H.TR_STATUS in ('2', '0' ) " +
        "           AND r.del_if = 0  " +
        "           AND r.drcr_type = 'C'  " +
        "           AND r.tac_abacctcode_pk_cr IN (SELECT     pk  " +
        "                                                FROM acnt.tac_abacctcode  " +
        "                                               WHERE del_if = 0 AND leaf_yn = 'Y'  " +
        "                                          CONNECT BY pac_pk = PRIOR pk  " +
        "                                          START WITH pk = " + p_accpk_main + ")  " +
        "           AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD')  " +
        "           AND h.tco_company_pk = " + l_company_pk +
        "           and r.tac_hgtrd_pk = D.pk " +
        "           and d.del_if  = 0  " +
        "           and h.pk in ( " +
        "           		select H1.PK " +
        "                        FROM acnt.TAC_HGTRH H1,acnt.TAC_HGDEPODDBAL B  " +
        "                        WHERE H1.DEL_IF =0  AND B.DEL_IF =0  " +
        "                        AND H1.PK = B.TAC_HGTRH_PK  " +
        "                        AND B.TR_STATUS =  " + l_status +
        "                        AND B.TAC_ABDEPOMT_PK =  " + p_bankpk +
        "                        AND B.TAC_ABACCTCODE_PK IN (" + p_accbank_pklist + ") " +
        "                        AND H1.TCO_COMPANY_PK = " + l_company_pk +
        "        AND H1.TR_STATUS in ('2', '0') " +
        "                        AND H1.TR_DATE BETWEEN TO_DATE('" + l_date_from + "','YYYYMMDD') AND TO_DATE('" + l_date_to + "' ,'YYYYMMDD')  " +
        "                        AND B.STD_YMD BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'" +
        "   AND NVL (B.YMD_DRTRANS, 0) <> 0 " +
        "           )       " +
        "          ORDER BY h.tr_date,h.voucherno,h.pk " +
        "	) " +
	" union all " +
        " select * from  " +
        " ( " +
        "         SELECT  h.pk h_pk, h.voucherno,h.remark,h.remark2 , INITCAP(TO_CHAR(H.TR_DATE,'DD-MON-YY')) trans_date,B.CCY CCY,  " +
        "         DECODE(B.CCY,'VND',0,NVL(B.YMD_DRTRANS,0)) in_amt_usd,  " +
        "         DECODE(B.CCY,'VND',NVL(B.YMD_DRTRANS,0),0) in_amt_vnd,  " +
        "         DECODE(B.CCY,'VND',0,NVL(B.YMD_CRTRANS,0)) out_amt_usd,   " +
        "         DECODE(B.CCY,'VND',NVL(B.YMD_CRTRANS,0),0) out_amt_vnd, " +
        "          (TO_NUMBER(TRIM('" + p_open_usd + "'),'9,999,999,999,990.99')+SUM( decode(B.CCY, 'VND', 0, NVL(B.YMD_DRTRANS,0)) - decode(B.CCY, 'VND', 0, NVL(B.YMD_CRTRANS,0) ) )OVER (ORDER BY  tr_date,h.voucherno,h.pk,B.PK )) BAL_USD_AMT,  " +
        "         (TO_NUMBER(TRIM('" + p_bankopenbal + "'),'9,999,999,999,990.99')+SUM( decode(B.CCY, 'VND', NVL(B.YMD_DRTRANS,0), 0) - decode(B.CCY, 'VND', NVL(B.YMD_CRTRANS,0), 0) )OVER (ORDER BY  tr_date,h.voucherno,h.pk,B.PK ))BAL_AMT,  " +
        "          h.tr_date,B.PK B_PK , 1 STT " +
        "                FROM acnt.TAC_HGTRH H, acnt.TAC_HGDEPODDBAL B  " +
        "                WHERE H.DEL_IF =0  AND B.DEL_IF =0  " +
        "                AND H.PK = B.TAC_HGTRH_PK  " +
        "                AND B.TR_STATUS =  " + l_status +
        "                AND B.TAC_ABDEPOMT_PK =  " + p_bankpk +
        "                AND B.TAC_ABACCTCODE_PK IN (" + p_accbank_pklist + ") " +
        "                AND H.TCO_COMPANY_PK = " + l_company_pk +
        "        AND H.TR_STATUS in ('2', '0') " +
        "                AND H.TR_DATE BETWEEN TO_DATE('" + l_date_from + "','YYYYMMDD') AND TO_DATE('" + l_date_to + "' ,'YYYYMMDD')  " +
        "                AND B.STD_YMD BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'  " +        
        " AND NVL (B.YMD_CRTRANS, 0) <> 0 " +
        " and not exists (select 'X' from acnt.TAC_HGDEPODDBAL B1 where B1.tac_hgtrh_pk = H.pk and B1.del_if = 0 and NVL(B1.YMD_DRTRANS, 0) <> 0) " +
        "          ORDER BY  tr_date,voucherno,H_pK,B_PK " +
        ")	            " +        
        "	union all " +
        "        select  * from " +
        "	( " +
        "             SELECT  h.pk h_pk, h.voucherno, r.remark, r.remark2 , INITCAP(TO_CHAR(H.TR_DATE,'DD-MON-YY')) trans_date, D.CCY CCY,  " +
        "             DECODE(r.drcr_type, 'C', 0, DECODE(D.CCY,'VND', 0, NVL(R.TR_AMT,0)) )  in_amt_usd,  " +
        "             DECODE(r.drcr_type, 'C', 0, DECODE(D.CCY,'VND', NVL(R.TR_AMT,0), 0) )  in_amt_vnd,  " +
        "            DECODE(r.drcr_type, 'C', DECODE(D.CCY,'VND', 0, NVL(R.TR_AMT,0)), 0 ) out_amt_usd,   " +
        "             DECODE(r.drcr_type, 'C',  DECODE(D.CCY, 'VND', NVL(R.TR_AMT,0), 0), 0 ) out_amt_vnd,  " +
        "             0 BAL_USD_AMT,  " +
        "             0 BAL_AMT,  " +
        "              h.tr_date, D.PK D_PK, 2 STT  " +
        "              FROM acnt.tac_hgtrh h, acnt.tac_hgtrd_ref r, acnt.TAC_HGTRD D  " +
        "             WHERE h.del_if = 0  " +
        "               AND h.pk = r.tac_hgtrh_pk  " +
        "        AND H.TR_STATUS in ('2', '0') " +
        "                   and h.pk in ( " +
        "                                select H1.PK " +
        "                                FROM acnt.TAC_HGTRH H1, acnt.TAC_HGDEPODDBAL B  " +
        "                                WHERE H1.DEL_IF =0  AND B.DEL_IF =0  " +
        "                                AND H1.PK = B.TAC_HGTRH_PK  " +
        "                                AND B.TR_STATUS =  " + l_status +
        "                                AND B.TAC_ABDEPOMT_PK =  " + p_bankpk +
        "                                AND B.TAC_ABACCTCODE_PK IN (" + p_accbank_pklist + ") " +
        "                                AND H1.TCO_COMPANY_PK = " + l_company_pk +
        "        AND H1.TR_STATUS in ('2', '0') " +
        "                                AND H1.TR_DATE BETWEEN TO_DATE('" + l_date_from + "','YYYYMMDD') AND TO_DATE('" + l_date_to + "' ,'YYYYMMDD')  " +
        "                                AND B.STD_YMD BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'             " +
        " AND NVL (B.YMD_CRTRANS, 0) <> 0 " +
        " and not exists (select 'X' from acnt.TAC_HGDEPODDBAL B1 where B1.tac_hgtrh_pk = H1.pk and B1.del_if = 0 and NVL(B1.YMD_DRTRANS, 0) <> 0) " +
        "                   )                                      " +
        "                  AND r.del_if = 0  " +
        "               AND r.drcr_type = 'C'  " +
        "               AND r.tac_abacctcode_pk_dr IN (SELECT     pk  " +
        "                                                    FROM acnt.tac_abacctcode  " +
        "                                                   WHERE del_if = 0 AND leaf_yn = 'Y'  " +
        "                                              CONNECT BY pac_pk = PRIOR pk  " +
        "                                              START WITH pk = " + p_accpk_main + ")  " +
        "               AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD')  " +
        "               AND h.tco_company_pk = " + l_company_pk +
        "               and r.tac_hgtrd_pk = D.pk " +
        "               and d.del_if  = 0                       " +
        "              ORDER BY h.tr_date,h.voucherno,h.pk         " +
        "                    )                                     " +
        ") a                   " +
        "ORDER BY a.tr_date, a.voucherno, a.STT ";
//Response.Write(SQLDetail);
//Response.End();
            
    DataTable dt_detail = ESysLib.TableReadOpen(SQLDetail);
    if (dt_detail.Rows.Count > 0)
    {
        for (j = 0; j < dt_detail.Rows.Count; j++)
        {
            l_stt = dt_detail.Rows[j][14].ToString();
            if (l_stt == "2")
            {
                if (dt_detail.Rows[j][6].ToString().Trim() != "")
                {
                    l_bal_usd += decimal.Parse(dt_detail.Rows[j][6].ToString().Trim());
                }
                if (dt_detail.Rows[j][7].ToString().Trim() != "")
                {
                    l_bal_vnd += decimal.Parse(dt_detail.Rows[j][7].ToString().Trim());
                }
                if (dt_detail.Rows[j][8].ToString().Trim() != "")
                {
                    l_bal_usd -= decimal.Parse(dt_detail.Rows[j][8].ToString().Trim());
                }
                if (dt_detail.Rows[j][9].ToString().Trim() != "")
                {
                    l_bal_vnd -= decimal.Parse(dt_detail.Rows[j][9].ToString().Trim());
                }
                
 %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl60 width=24 style='height:20.25pt;width:18pt' x:num><%= (j + 1)%></td>
  <td class=xl46 x:num><%= dt_detail.Rows[j][4].ToString()%></td>
  <td class=xl61 width=40 style='width:30pt'></td>
  <td class=xl48><%= dt_detail.Rows[j][2].ToString()%></td>
  <td class=xl149 x:num ><%= dt_detail.Rows[j][6].ToString()%></td>
  <td class=xl150 x:num ><%= dt_detail.Rows[j][7].ToString()%></td>
  <td class=xl126 x:num ><%= dt_detail.Rows[j][8].ToString()%></td>
  <td class=xl151 x:num ><%= dt_detail.Rows[j][9].ToString()%></td>
  <td class=xl152 x:num ><%= l_bal_usd%></td>
  <td class=xl62 x:num ><%= l_bal_vnd%></td>
  <td class=xl153 x:num></td>
  <td class=xl167 ><%= dt_detail.Rows[j][1].ToString()%></td>
 </tr>
 <%
    }// if stt = 2
} // if j
} // if dt_details.rows.count > 0
SQLTotal = "SELECT   " +
"         NVL(SUM(DECODE (b.ccy, 'VND', 0, b.ymd_drtrans)),0) in_amt_usd, " +
"         NVL(SUM(DECODE (b.ccy, 'VND', b.ymd_drtrans, 0)),0) in_amt_vnd, " +
"         NVL(SUM(DECODE (b.ccy, 'VND', 0, b.ymd_crtrans)),0) out_amt_usd, " +
"         NVL(SUM(DECODE (b.ccy, 'VND', b.ymd_crtrans, 0)),0) out_amt_vnd, " +
"         (TO_NUMBER (TRIM ('" + p_open_usd + "'), '9,999,999,999,990.99') + NVL(SUM ( decode(b.ccy, 'VND', 0, b.ymd_drtrans) - decode(b.ccy, 'VND', 0, b.ymd_crtrans)),0)) bal_usd_amt, " +
"         (TO_NUMBER (TRIM ('" + p_bankopenbal + "'), '9,999,999,999,990.99') + NVL(SUM (decode(b.ccy, 'VND', b.ymd_drtrans, 0) - decode(b.ccy, 'VND', b.ymd_crtrans, 0)),0)) bal_amt " +
"    FROM acnt.tac_hgtrh h, acnt.tac_hgdepoddbal b " +
"   WHERE h.del_if = 0 " +
"     AND b.del_if = 0 " +
"     AND h.pk = b.tac_hgtrh_pk " +
 "        AND B.TR_STATUS =  " + l_status +
        "        AND B.TAC_ABDEPOMT_PK =  " + p_bankpk +
        "        AND B.TAC_ABACCTCODE_PK IN (  " + p_accbank_pklist + ")" +
        "        AND H.TCO_COMPANY_PK =   " + l_company_pk +
        "        AND H.TR_STATUS IN ('2', '0') " +
        "        AND H.TR_DATE BETWEEN TO_DATE('" + l_date_from + "','YYYYMMDD') AND TO_DATE('" + l_date_to + "' ,'YYYYMMDD') " +
        "        AND B.STD_YMD BETWEEN '" + l_date_from + "' AND '" + l_date_to + "' ";
DataTable dt_total = ESysLib.TableReadOpen(SQLTotal);
if (dt_total.Rows.Count > 0)
{
  %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl89 width=433 style='border-right:.5pt solid black;height:18.0pt;width:325pt'>TOTAL</td>
  <td class=xl154  style='border-top:.5pt solid black;'  x:num><%= dt_total.Rows[0][0].ToString()%></td>
  <td class=xl155  style='border-top:.5pt solid black;'  x:num><%= dt_total.Rows[0][1].ToString()%></td>
  <td class=xl154  style='border-top:.5pt solid black;'  x:num><%= dt_total.Rows[0][2].ToString()%></td>
  <td class=xl155  style='border-top:.5pt solid black;'  x:num><%= dt_total.Rows[0][3].ToString()%></td>
  <td class=xl156  style='border-top:.5pt solid black;'  x:num><%= dt_total.Rows[0][4].ToString()%></td>
  <td class=xl63  style='border-top:.5pt solid black;'    x:num><%= dt_total.Rows[0][5].ToString()%></td>
  <td class=xl157  style='border-top:.5pt solid black;' >&nbsp;</td>
  <td class=xl172  style='border-top:.5pt solid black;' >&nbsp;</td>
 </tr>
<%
    }
} // for i
}// if dt_bank.count > 0
}// for k
 %>
 
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl75 width=24 style='height:22.5pt;width:18pt'>&nbsp;</td>
  <td class=xl76 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl76 width=40 style='width:30pt'>&nbsp;</td>
  <td class=xl76 width=302 style='width:227pt'>&nbsp;</td>
  <td class=xl77 width=57 style='width:43pt'>&nbsp;</td>
  <td class=xl78 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td class=xl80 width=95 style='width:71pt'>&nbsp;</td>
  <td class=xl81 width=84 style='width:63pt'>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
 </tr>
 <tr class=xl56 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=4 height=33 class=xl116 style='border-right:.5pt solid black;
  height:24.75pt'>Prepared by: Ms. Minh</td>
  <td class=xl85><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td colspan=7 class=xl116 style='border-right:.5pt solid black'>Checked by:
  Mr. CHO SUNG JUN</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=24 style='width:18pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=302 style='width:227pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
