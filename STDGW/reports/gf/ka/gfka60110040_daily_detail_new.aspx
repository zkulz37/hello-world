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
    string l_company_pk = Request["company_pk"];
	string l_date_from	= Request["dtbFrom"]; // From Date
	string l_date_to = Request["dtbTo"];   // To Date
	string l_book_ccy = Request["Bookccy"];
	string l_status = Request["status"];
    string v_from_ddmmyy = "";
    string v_to_ddmmyy = "";
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
    string p_open_book = "0";
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
    decimal p_bankopenbal_vnd = 0, p_bankopenbal_fgccy = 0, p_bankopenbal_book= 0, p_bankopenbal_trans = 0;
    decimal l_bal_vnd = 0, l_bal_fgccy = 0, l_rec_vnd = 0, l_rec_fgccy = 0, l_spend_vnd = 0, l_spend_fgccy = 0;
    
    string p_accpk_main = "";
    
    ///////////////// count doi ung
    string l_stt = "";
    string l_tr_ccy = "";
	string l_voucherno = "";
    decimal l_rec_trans = 0;
    decimal l_spend_trans = 0;
    decimal l_rec_book = 0;
    decimal l_spend_book = 0;
    decimal p_opentrans_num = 0;
    decimal p_open_book_num = 0;
    
    decimal l_amt = 0;
    decimal l_bal_book = 0, l_bal_trans = 0;
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
    /*  list of accounts cash on hand */
     SQL
        = "SELECT AC_CODE, (SELECT AC_NM FROM TAC_ABACCTCODE WHERE PK = D.TAC_ABACCTCODE_PK ) AC_NM, D.TAC_ABACCTCODE_PK, " +
        " (SELECT CCY FROM TAC_ABACCTCODE WHERE PK = D.TAC_ABACCTCODE_PK ) CCY " + 
            " FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP P " +
            " WHERE P.ac_grp = 'CASH' " +
            " and P.del_if = 0 " +
            " and p.app_grp = 'G' " +            
            " and P.PK = D.TAC_ABTRACGRP_PK " +
            " and D.del_if 		= 0 ORDER BY 1 ASC ";
    DataTable dtAccLst = ESysLib.TableReadOpen(SQL);
	%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka60110040_daily_detail%201%20_files/filelist.xml">
<link rel=Edit-Time-Data
href="gfka60110040_daily_detail%201%20_files/editdata.mso">
<link rel=OLE-Object-Data
href="gfka60110040_daily_detail%201%20_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>VanLe</o:LastAuthor>
  <o:LastPrinted>2012-01-31T09:51:16Z</o:LastPrinted>
  <o:Created>2009-03-05T07:33:05Z</o:Created>
  <o:LastSaved>2012-01-31T09:52:23Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.25in .2in .25in .2in;
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
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
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
.xl31
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
.xl32
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
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
.xl34
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
.xl35
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
.xl36
	{mso-style-parent:style16;
	color:black;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
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
.xl39
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
.xl40
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
.xl41
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
.xl42
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
.xl43
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
.xl44
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
.xl45
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
.xl46
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
.xl47
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
.xl48
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
.xl49
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style16;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]dd\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
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
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl71
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
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl72
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
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
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
	border-bottom:none;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style16;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style16;
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
.xl84
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
.xl88
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl89
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style0;
	color:blue;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
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
.xl93
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
.xl94
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
.xl95
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
.xl96
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
.xl97
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
.xl98
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl100
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl101
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
.xl102
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
.xl103
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
.xl104
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
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
.xl105
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
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
.xl106
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
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
.xl107
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl108
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
.xl109
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl111
	{mso-style-parent:style16;
	color:black;
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
	background:#FFFF99;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style16;
	color:black;
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
	background:#FFFF99;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style16;
	color:black;
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
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl115
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl116
	{mso-style-parent:style16;
	color:black;
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
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl118
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl119
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl120
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl121
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl122
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl123
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl126
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl127
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl128
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
.xl129
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
.xl130
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>73</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>3</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1409 style='border-collapse:
 collapse;table-layout:fixed;width:1062pt'>
 <col class=xl24 width=24 style='mso-width-source:userset;mso-width-alt:877;
 width:18pt'>
 <col class=xl25 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl64 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col class=xl60 width=264 style='mso-width-source:userset;mso-width-alt:9654;
 width:198pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl85 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl85 width=82 span=2 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl26 width=89 span=2 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl85 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl26 width=90 span=2 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <col class=xl27 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=16 height=22 class=xl117 align=left width=1409 style='height:
  16.5pt;width:1062pt'><%= p_cmp_fname%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=16 height=22 class=xl117 align=left style='height:16.5pt'><%= p_cmp_fadd%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=16 height=22 class=xl117 align=left style='height:16.5pt'>Tax
  code : <%= p_cmp_taxcode%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=16 height=32 class=xl118 style='height:24.0pt'><%= p_cmp_fname2%> -
  DETAIL OF DAILY SPENDING REPORT</td>
 </tr>
  <% 
     string v_month = "";
     int v_mm = 0;
     v_mm = int.Parse(l_date_from.Substring(4, 2));
     if (v_mm == 1)
     {
         v_month = "Jan";
     }
     else if (v_mm == 2)
     {
         v_month = "Feb";         
     }
     else if (v_mm == 3)
     {
         v_month = "Mar";
     }
     else if (v_mm == 4)
     {
         v_month = "Apr";
     }
     else if (v_mm == 5)
     {
         v_month = "May";
     }
     else if (v_mm == 6)
     {
         v_month = "Jun";
     }
     else if (v_mm == 7)
     {
         v_month = "Jul";
     }
     else if (v_mm == 8)
     {
         v_month = "Aug";
     }
     else if (v_mm == 9)
     {
         v_month = "Sep";
     }
     else if (v_mm == 10)
     {
         v_month = "Oct";
     }
     else if (v_mm == 11)
     {
         v_month = "Nov";
     }
     else if (v_mm == 12)
     {
         v_month = "Dec";
     }
     v_from_ddmmyy = l_date_from.Substring(6, 2) + "-" + v_month + "-" + l_date_from.Substring(0, 4);
     v_mm = int.Parse(l_date_to.Substring(4, 2));
     if (v_mm == 1)
     {
         v_month = "Jan";
     }
     else if (v_mm == 2)
     {
         v_month = "Feb";
     }
     else if (v_mm == 3)
     {
         v_month = "Mar";
     }
     else if (v_mm == 4)
     {
         v_month = "Apr";
     }
     else if (v_mm == 5)
     {
         v_month = "May";
     }
     else if (v_mm == 6)
     {
         v_month = "Jun";
     }
     else if (v_mm == 7)
     {
         v_month = "Jul";
     }
     else if (v_mm == 8)
     {
         v_month = "Aug";
     }
     else if (v_mm == 9)
     {
         v_month = "Sep";
     }
     else if (v_mm == 10)
     {
         v_month = "Oct";
     }
     else if (v_mm == 11)
     {
         v_month = "Nov";
     }
     else if (v_mm == 12)
     {
         v_month = "Dec";
     }
     v_to_ddmmyy = l_date_to.Substring(6, 2) + "-" + v_month + "-" + l_date_to.Substring(0, 4);
 %>

 <tr height=21 style='height:15.75pt'>
  <td colspan=16 height=21 class=xl107 style='height:15.75pt'>From: <%=v_from_ddmmyy%>
  to <%=v_to_ddmmyy%></td>
 </tr>
 <tr class=xl28 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl29 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl80></td>
  <td class=xl29></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=5 class=xl108>Reported date : <%= p_rpt_date%></td>
  <td class=xl31>&nbsp;</td>
 </tr>
 <tr class=xl28 height=34 style='height:25.5pt'>
  <td height=34 class=xl70 style='height:25.5pt'>NO</td>
  <td class=xl71>DATE</td>
  <td class=xl72>Voucher No</td>
  <td class=xl73>CONTENT</td>
  <td class=xl74 width=33 style='width:25pt'>CCY</td>
  <td colspan=3 class=xl109 width=250 style='border-right:.5pt solid black;
  width:189pt'>RECEIVING</td>
  <td colspan=3 class=xl111 style='border-right:.5pt solid black;border-left:
  none' x:str="SPENDING"><span style='mso-spacerun:yes'> </span>SPENDING<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl114 width=262 style='border-right:.5pt solid black;
  border-left:none;width:198pt' x:str="BALANCE "><span
  style='mso-spacerun:yes'> </span>BALANCE<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl75 width=69 style='width:52pt' x:str="Exchange &#10;Rate"><span
  style='mso-spacerun:yes'> </span>Exchange <br>
    Rate<span style='mso-spacerun:yes'> </span></td>
  <td class=xl76 width=52 style='border-top:none;border-left:none;width:39pt'
  x:str="Remark ">Remark<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl104 width=219 style='border-right:.5pt solid black;
  height:12.75pt;width:165pt'>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl79 style='border-top:none' x:str="VND"><span
  style='mso-spacerun:yes'> </span>VND<span style='mso-spacerun:yes'> </span></td>
  <td class=xl67 style='border-top:none;border-left:none' x:str="FG CCY"><span
  style='mso-spacerun:yes'> </span>FG CCY<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl79 style='border-top:none;border-left:none' x:str="BOOKS"><span
  style='mso-spacerun:yes'> </span>BOOKS<span style='mso-spacerun:yes'> </span></td>
  <td class=xl79 style='border-top:none;border-left:none' x:str="VND"><span
  style='mso-spacerun:yes'> </span>VND<span style='mso-spacerun:yes'> </span></td>
  <td class=xl67 style='border-top:none;border-left:none' x:str="FG CCY"><span
  style='mso-spacerun:yes'> </span>FG CCY<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl67 style='border-top:none;border-left:none' x:str="BOOKS"><span
  style='mso-spacerun:yes'> </span>BOOKS<span style='mso-spacerun:yes'> </span></td>
  <td class=xl79 style='border-top:none;border-left:none' x:str="VND"><span
  style='mso-spacerun:yes'> </span>VND<span style='mso-spacerun:yes'> </span></td>
  <td class=xl67 style='border-top:none;border-left:none' x:str="FG CCY"><span
  style='mso-spacerun:yes'> </span>FG CCY<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl67 style='border-top:none;border-left:none' x:str="BOOKS"><span
  style='mso-spacerun:yes'> </span>BOOKS<span style='mso-spacerun:yes'> </span></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl61 width=52 style='border-top:none;border-left:none;width:39pt'>&nbsp;</td>
 </tr>
 <% 
     string p_ccy_acct = "";
     string p_acct_pk = "";
     int l_Row = 0;  // Row 
     decimal v_tot_rec_trans = 0, v_tot_rec_book = 0;
     decimal v_tot_spend_trans = 0, v_tot_spend_book = 0;
     for (k = 0; k < dtAccLst.Rows.Count; k++)
     {
         p_ccy_acct = dtAccLst.Rows[k][3].ToString(); // CCY of Account Code
         p_acct_pk = dtAccLst.Rows[k][2].ToString();
         SQL = "SELECT T.PK, T.AC_CD, T.AC_NM,  " +
         "SF_GET_DRCR_OPENBAL_2('" + l_company_pk + "', T.PK, '" + p_ccy_acct + "', '" + l_date_from + "', '" + l_date_to + "', '" + l_status + "', 'D', 'BOOK') OPEN_TRANS, " +
	"SF_GET_DRCR_OPENBAL_2('" + l_company_pk + "', T.PK, '" + p_ccy_acct + "', '" + l_date_from + "', '" + l_date_to + "', '" + l_status + "', 'D', 'BOOK') OPEN_BOOK " +
         "FROM TAC_ABACCTCODE T  " +
         "WHERE T.DEL_IF =0  " +
         "AND T.LEAF_YN ='Y' " +
         "CONNECT BY pac_pk = PRIOR pk START WITH pk = (SELECT PK FROM TAC_ABACCTCODE " +
         "WHERE DEL_IF =0 AND PK = '" + p_acct_pk + "' ) ORDER BY 1 asc ";
         
         DataTable dt_cash = ESysLib.TableReadOpen(SQL);
         p_opentrans = "0";
         p_open_book = "0";
         if (dt_cash.Rows.Count > 0)
         {
             for (i = 0; i < 1; i++) //dt_cash.Rows.Count
             {
                 p_acpk = dt_cash.Rows[i][0].ToString();
                 p_accd = dt_cash.Rows[i][1].ToString();
                 p_acnm = dt_cash.Rows[i][2].ToString();
                 p_opentrans = dt_cash.Rows[i][3].ToString();
                 p_open_book = dt_cash.Rows[i][4].ToString();
                 p_opentrans_num = decimal.Parse(p_opentrans.Replace(",", ""));
                 p_open_book_num = decimal.Parse(p_open_book.Replace(",", ""));      

  %>
 
 <tr class=xl32 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=3 height=29 class=xl98 style='border-right:.5pt solid black;
  height:21.75pt'><%=p_acnm%></td>
  <td class=xl78 align=left>A balance carried forward from the last account</td>
  <td class=xl33 width=33 style='width:25pt'>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <% 
     if (p_ccy_acct == "VND")
     {
  %>
  <td class=xl81 style='border-top:none;border-left:none' x:num><%=p_opentrans_num%></td>
  <% 
     }
     else
     {
  %>
  <td class=xl81 style='border-top:none;border-left:none' x:num="0"></td>
  <% 
     }
  %>
  <% 
     if (p_ccy_acct != "VND")
     {
  %>
  <td class=xl86 x:num><%=p_opentrans_num%></td>
  <% 
     }
     else
     {                 
  %>
  <td class=xl86 x:num="0"></td>
 <% 
     }
 %>
  <td class=xl129 x:num><%=p_open_book_num%></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
     SQLDetail = "'" + l_date_from + "', '" + l_date_to + "', '" + p_ccy_acct + "', '" + l_company_pk + "', '" + p_acpk + "', '" + p_opentrans_num.ToString() + "', '" + p_open_book_num.ToString() + "'";
     DataTable dt_detail = ESysLib.TableReadOpenCursor("SP_SEL_DAILYCASH_DETAIL", SQLDetail);
     l_bal_trans = p_opentrans_num;
     l_bal_book = p_open_book_num;
     l_Row = 0;
     v_tot_rec_trans = 0; v_tot_rec_book = 0;
     v_tot_spend_trans = 0; v_tot_spend_book = 0;

     if (dt_detail.Rows.Count > 0)
     {
         for (j = 0; j < dt_detail.Rows.Count; j++)
         {
             l_stt = dt_detail.Rows[j][0].ToString();
             l_tr_ccy = dt_detail.Rows[j][11].ToString(); // Trans Ccy
             if (l_stt == "1")
             {
                 l_tr_ccy = dt_detail.Rows[j][11].ToString(); // Trans Ccy
             }
             else if (l_stt == "2")
             {
                 l_Row += 1;
                 l_tr_ccy = dt_detail.Rows[j][11].ToString(); // Trans Ccy
                 if (dt_detail.Rows[j][3].ToString() != "")
                 {
                     l_rec_trans = decimal.Parse(dt_detail.Rows[j][3].ToString());
                     v_tot_rec_trans += l_rec_trans;
                 }
                 else
                     l_rec_trans = 0;
                 if (dt_detail.Rows[j][5].ToString() != "")
                 {
                     l_spend_trans = decimal.Parse(dt_detail.Rows[j][5].ToString());
                     v_tot_spend_trans += l_spend_trans;
                 }
                 else
                     l_spend_trans = 0;
                 if (dt_detail.Rows[j][4].ToString() != "")
                 {
                     l_rec_book = decimal.Parse(dt_detail.Rows[j][4].ToString());
                     v_tot_rec_book += l_rec_book;
                 }
                 else
                     l_rec_book = 0;
                 if (dt_detail.Rows[j][6].ToString() != "")
                 {
                     l_spend_book = decimal.Parse(dt_detail.Rows[j][6].ToString());
                     v_tot_spend_book += l_spend_book;
                 }
                 else
                     l_spend_book = 0;

                 l_bal_book += l_rec_book - l_spend_book;
                 l_bal_trans += l_rec_trans - l_spend_trans;                
  %> 
 
 <tr height=68 style='height:51.0pt'>
  <td height=68 class=xl69 width=24 style='height:51.0pt;width:18pt' x:num><%=l_Row%></td>
  <td class=xl55 x:num><%=dt_detail.Rows[j][1].ToString()%></td>
  <td class=xl63><%=dt_detail.Rows[j][10].ToString()%> <span style='display:none'></span></td>
  <td class=xl65 width=264 style='width:198pt'><%=dt_detail.Rows[j][2].ToString()%></td>
  <td class=xl62 style='border-top:none;border-left:none'><%=dt_detail.Rows[j][11].ToString()%></td>
  <% 
     if (l_tr_ccy == "VND")
     {                 
  %>
  <td class=xl120 style='border-top:none' x:num><%=l_rec_trans%></td>
  <% 
     }
     else
     {
  %>
  <td class=xl120 style='border-top:none' x:num="0"></td> <!--VND Trans-->
  <% 
     }
  %>  
  
    <% 
     if (l_tr_ccy != "VND")
     {                 
  %>
  <td class=xl87 x:num><span
  style='mso-spacerun:yes'> </span><%=l_rec_trans%> </td>
  <% 
     }
     else
     {
  %>
  <td class=xl87 x:num="0"><span
  style='mso-spacerun:yes'> </span></td>
  <% 
     }
  %>
  
  <td class=xl126 align=left style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'> </span><%=l_rec_book%> </td>

  <% 
     if (l_tr_ccy == "VND")
     {                 
  %>
    <td class=xl120 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=l_spend_trans%><span style='mso-spacerun:yes'>   </span></td>

  <% 
     }
     else
     {
  %>
  <td class=xl120 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>   </span></td>
  <% 
     }
  %>  
  
  
  <% 
     if (l_tr_ccy != "VND")
     {                 
  %>
    <td class=xl87 x:num><span style='mso-spacerun:yes'> </span><%=l_spend_trans%><span
  style='mso-spacerun:yes'>   </span></td>
  <% 
     }
     else
     {
  %>
    <td class=xl87 x:num="0"><span style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'>   </span></td>
  <% 
     }
  %>
  
  
  <td class=xl126 align=left style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=l_spend_book%><span style='mso-spacerun:yes'>   </span></td>

  <% 
     if (l_tr_ccy == "VND")
     {
  %>
  <td class=xl120 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=l_bal_trans%><span style='mso-spacerun:yes'>   </span></td>
  <% 
     }
     else
     {           
  %>
  <td class=xl120 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>   </span></td>
  <% 
     }
  %>

  <% 
     if (l_tr_ccy != "VND")
     {
  %>
    <td class=xl87 x:num><span
  style='mso-spacerun:yes'> </span><%=l_bal_trans%> </td>

  <% 
     }
     else
     {           
  %>
    <td class=xl87 x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
  <% 
     }
  %>
  
  <td class=xl120 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= l_bal_book%><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl130 style='border-top:none;border-left:none' x:num><%=dt_detail.Rows[j][9].ToString()%></td>
  <td class=xl53 style='border-top:none;border-left:none'><%=dt_detail.Rows[j][13].ToString()%></td>
 </tr>
 <% 
     } //if stt = 2
         }
     }             
 %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl95 width=483 style='border-right:.5pt solid black;
  height:18.0pt;width:363pt'>TOTAL</td>
  <td class=xl43 width=33 style='width:25pt'>&nbsp;</td>
  <%
     if (p_ccy_acct == "VND")
     { 
  %>
  <td class=xl119 style='border-top:none' x:num><%=v_tot_rec_trans%></td>
  <% 
     }
     else
     {
 %>
 <td class=xl119 style='border-top:none' x:num="0"></td>
 <% 
     }
 %>

  <%
     if (p_ccy_acct != "VND")
     { 
  %>
  <td class=xl128 x:num><span
  style='mso-spacerun:yes'> </span><%=v_tot_rec_trans%> </td>
  <% 
     }
     else
     {
 %>
  <td class=xl128 x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
 <% 
     }
 %>

  
  <td class=xl127 align=left style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=v_tot_rec_book%><span style='mso-spacerun:yes'>   </span></td>

  <%
     if (p_ccy_acct == "VND")
     { 
  %>
  <td class=xl119 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=v_tot_spend_trans%> </td>
  <% 
     }
     else
     {
 %>
  <td class=xl119 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
 <% 
     }
 %>
  
  <%
     if (p_ccy_acct != "VND")
     { 
  %>
<td class=xl128 x:num><span
  style='mso-spacerun:yes'> </span><%=v_tot_spend_trans%> </td>  
  <% 
     }
     else
     {
 %>
<td class=xl128 x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>    
 <% 
     }
 %>
  
  <td class=xl127 align=left style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'> </span><%=v_tot_spend_book%> </td>

  <%
     if (p_ccy_acct == "VND")
     { 
  %>
  <td class=xl119 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=l_bal_trans%> </td>
  <%
     }
     else
     {
 %>
  <td class=xl119 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
 <% 
     }
 %>

  <%
     if (p_ccy_acct != "VND")
     { 
  %>
  <td class=xl128 x:num><span
  style='mso-spacerun:yes'> </span><%=l_bal_trans%> </td>
  <%
     }
     else
     {
 %>
  <td class=xl128 x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
 <% 
     }
 %>
  
  <td class=xl119 style='border-top:none;border-left:none' x:num><%=l_bal_book%></td>
  <td class=xl121>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
            }
         }
     }//For k
    /////////////////112
    decimal v_bank_open_trans = 0, v_bank_open_book = 0, v_recv_trans = 0, v_recv_book = 0, v_spend_trans = 0, v_spend_book = 0;
    decimal v_bank_bal_trans = 0, v_bank_bal_book = 0;
    decimal v_tot_recv_trans = 0, v_tot_recv_book = 0;
    decimal v_acc_tot_recv_trans = 0, v_acc_tot_recv_book = 0, v_acc_tot_spend_trans = 0, v_acc_tot_spend_book = 0;
    decimal v_acc_bal_trans = 0, v_acc_bal_book = 0; 
     SQL
        = "SELECT AC_CODE, (SELECT AC_NM FROM TAC_ABACCTCODE WHERE PK = D.TAC_ABACCTCODE_PK ) AC_NM, D.TAC_ABACCTCODE_PK, " +
        " (SELECT CCY FROM TAC_ABACCTCODE WHERE PK = D.TAC_ABACCTCODE_PK ) CCY " + 
            " FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP P " +
            " WHERE P.ac_grp = 'BANK' " +
            " and P.del_if = 0 " +
            " and p.app_grp = 'G' " +            
            " and P.PK = D.TAC_ABTRACGRP_PK " +
            " and D.del_if 		= 0 ORDER BY 1 ASC ";
    
     dtAccLst = ESysLib.TableReadOpen(SQL);
     for (k = 0; k < dtAccLst.Rows.Count; k++)
     {
         p_ccy_acct = dtAccLst.Rows[k][3].ToString(); // Currency of acct. code
         p_acnm = dtAccLst.Rows[k][1].ToString(); // Account Name
         p_accpk_main = dtAccLst.Rows[k][2].ToString(); //Account Pk
         SQL = "select PK from TAC_ABDEPOMT where tac_abacctcode_pk = '" + p_accpk_main + "' and del_if = 0 and tco_company_pk = '" + l_company_pk + "' ";
         DataTable dtCheckBank = new DataTable();
         dtCheckBank = ESysLib.TableReadOpen(SQL);
         if (dtCheckBank.Rows.Count == 0)
         {
             continue;
         }                                
         SQL = "SELECT T.PK, T.AC_CD, T.AC_NM,  " +         
         "SF_GET_DRCR_OPENBAL_2('" + l_company_pk + "', T.PK, '" + p_ccy_acct + "', '" + l_date_from + "', '" + l_date_to + "', '" + l_status + "', 'D', 'TRANS') OPEN_TRANS, " +         
         "SF_GET_DRCR_OPENBAL_2('" + l_company_pk + "', T.PK, '" + p_ccy_acct + "', '" + l_date_from + "', '" + l_date_to + "', '" + l_status + "', 'D', 'BOOK') OPEN_BOOK " +
         "FROM TAC_ABACCTCODE T  " +
         "WHERE T.PK = " + p_accpk_main;
         DataTable dt_acctbank = new DataTable();
         dt_acctbank = ESysLib.TableReadOpen(SQL);
         v_acc_tot_recv_trans = 0;
         v_acc_tot_recv_book = 0;
         v_acc_tot_spend_trans = 0;
         v_acc_tot_spend_book = 0;
         if (dt_acctbank.Rows.Count > 0)
         {
             p_opentrans_num = decimal.Parse(dt_acctbank.Rows[0][3].ToString());
             p_open_book_num = decimal.Parse(dt_acctbank.Rows[0][4].ToString());
         }
         else
         {
             p_opentrans_num = 0;
             p_open_book_num = 0;
         }
 %>
 <tr class=xl37 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=3 height=38 class=xl89 style='border-right:.5pt solid black;
  height:28.5pt'><%=p_acnm%></td>
  <td class=xl58>&nbsp;</td>
  <td class=xl38 width=33 style='width:25pt'>&nbsp;</td>
  <td class=xl82 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl82 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <%
     if (p_ccy_acct == "VND")
     {
  %>
  
  <td class=xl82 style='border-top:none;border-left:none' x:num><%=p_opentrans_num%></td>
  <% 
     }
     else
     {
  %>
  <td class=xl82 style='border-top:none;border-left:none' x:num>0</td>
  <% 
     }
  %>
  <%
     if (p_ccy_acct != "VND")
     {
  %>
  <td class=xl87 x:num><%=p_opentrans_num%></td>
 <% 
     }
     else
     {
 %>
 <td class=xl87 x:num>0</td>
 <% } %>
  <td class=xl40 x:num><span
  style='mso-spacerun:yes'> </span><%=p_open_book_num%> </td>
  <td class=xl41>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
     //SQL = "SELECT PK, ACCOUNT_NO, BANK_ID,  FROM TAC_ABDEPOMT WHERE DEL_IF =0 AND CCY IN ('" + p_ccy_acct + "') AND TCO_COMPANY_PK LIKE '" + l_company_pk + "' AND TAC_ABACCTCODE_PK LIKE '" + p_accpk_main + "' ";
    //SP_SEL_MONTH_BANK_DEP_BAL  
     SQL = "'" + l_company_pk + "', '" + l_date_from + "', '" + l_date_to + "', '', '" + l_status + "', '" + p_ccy_acct + "' ";
     DataTable dt_bank = ESysLib.TableReadOpenCursor("SP_SEL_MONTH_BANK_DEP_BAL", SQL);
     if (dt_bank.Rows.Count > 0)
     {
         for (i = 1; i < dt_bank.Rows.Count; i++)
         {
             p_bankpk = dt_bank.Rows[i]["PK"].ToString(); // BANK PK
             p_bankacc = dt_bank.Rows[i]["BANK_ID"].ToString(); // BANK ID 
             p_bankid = dt_bank.Rows[i]["BANK_ID"].ToString();
             if (p_ccy_acct == "VND")
             {
                 v_bank_open_trans = decimal.Parse(dt_bank.Rows[i]["o_mm_vnd_bal"].ToString()); // Bank Open Trans
             }
             else
             {
                 v_bank_open_trans = decimal.Parse(dt_bank.Rows[i]["o_mm_usd_bal"].ToString()); // Bank Open Trans
             }   
             v_bank_open_book = decimal.Parse(dt_bank.Rows[i]["o_mm_book_bal"].ToString()); // Bank Open Book
             v_bank_bal_trans = v_bank_open_trans;
             v_bank_bal_book = v_bank_open_book;                                                               
 %>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=3 height=38 class=xl92 width=219 style='border-right:.5pt solid black;
  height:28.5pt;width:165pt'><%=p_bankid%></td>
  <td class=xl77 align=left>A balance carried forward from the last account</td>
  <td class=xl33 width=33 style='width:25pt'>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl81 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <% 
     if (p_ccy_acct == "VND")
     {
  %>  
  <td class=xl81 style='border-top:none;border-left:none' x:num><%=v_bank_open_trans%></td>
  <% 
     }
     else
     {             
   %>
  <td class=xl81 style='border-top:none;border-left:none' x:num="0"></td>
  <% 
     }
  %>   
  <% 
     if (p_ccy_acct != "VND")
     {
  %>
  <td class=xl86 x:num><%=v_bank_open_trans%></td>
  <% 
     }
     else
     {
   %>
  <td class=xl86 x:num>0</td>
  <% 
     }
 %>
  <td class=xl129 x:num><span
  style='mso-spacerun:yes'> </span><%=v_bank_open_book%> </td>
  <td class=xl35>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
     DataTable dt_bankdt = new DataTable();
     SQLDetail = "'" + l_company_pk + "', '" + p_bankpk + "', '" + l_date_from + "', '" + l_date_to + "', '" + l_status + "', '" + p_ccy_acct + "', '', '', '', '" + v_bank_open_trans + "', '" + v_bank_open_book + "', " + p_accpk_main + " ";
         //l_date_from + "', '" + l_date_to + "', '" + p_ccy_acct + "', '" + l_company_pk + "', '" + p_accpk_main + "', '" + v_bank_open_trans + "', '" + v_bank_open_book + "', '" + l_status + "', '" + p_bankpk + "' ";
     //Response.Write(SQLDetail);
     //Response.End();
     dt_bankdt = ESysLib.TableReadOpenCursor("sp_sel_Deposit_Voucher_2", SQLDetail);
     v_bank_bal_trans = v_bank_open_trans;
     v_bank_bal_book = v_bank_open_book;
     v_tot_recv_trans = 0;
     v_tot_recv_book = 0;
     v_tot_spend_trans = 0;
     v_tot_spend_book = 0;
     if (dt_bankdt.Rows.Count > 0)
     {
         for (j = 1; j < dt_bankdt.Rows.Count; j++)
         {
                 v_recv_trans = decimal.Parse(dt_bankdt.Rows[j]["in_amt"].ToString()); // Received Trans Amt
                 v_tot_recv_trans += v_recv_trans;
                 v_recv_book = decimal.Parse(dt_bankdt.Rows[j]["in_bamt"].ToString()); // Received Book Amt
                 v_tot_recv_book += v_recv_book;
                 v_spend_trans = decimal.Parse(dt_bankdt.Rows[j]["out_amt"].ToString()); // Spend Trans Amt
                 v_tot_spend_trans += v_spend_trans;
                 v_spend_book = decimal.Parse(dt_bankdt.Rows[j]["out_bamt"].ToString());  // Spend Book Amt
                 v_tot_spend_book += v_spend_book;
                 v_bank_bal_trans = v_bank_bal_trans + v_recv_trans - v_spend_trans;
                 v_bank_bal_book = v_bank_bal_book + v_recv_book - v_spend_book;
                 l_voucherno = dt_bankdt.Rows[j]["voucherno"].ToString(); //Voucher No
 %>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl124 width=24 style='height:28.5pt;border-top:none;
  width:18pt' x:num><%=j%></td>
  <td class=xl125 width=57 style='border-top:none;border-left:none;width:43pt'
  x:num><%=dt_bankdt.Rows[j]["trans_date"].ToString()%></td>
  <td class=xl123 width=138 style='border-top:none;border-left:none;width:104pt'><%=l_voucherno%></td>
  <td class=xl122 align=left style='border-top:none;border-left:none'><%=dt_bankdt.Rows[j]["remark"].ToString()%></td> <!-- Remark -->
  <td class=xl62 style='border-top:none;border-left:none'><%=dt_bankdt.Rows[j]["CCY"].ToString()%></td>
  <% 
     if (p_ccy_acct == "VND")
     {                
 %>
  <td class=xl120 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=v_recv_trans%> </td>
  <% 
     }
     else
     {                
  %>
  <td class=xl120 style='border-top:none' x:num="0" ><span
  style='mso-spacerun:yes'> </span></td>
   <% 
     }
   %>
  <% 
     if (p_ccy_acct != "VND")
     {                
 %>
  <td class=xl87 x:num><span
  style='mso-spacerun:yes'> </span><%=v_recv_trans%> </td>
  <% 
     }
     else
     {           
  %>
  <td class=xl87 x:num><span
  style='mso-spacerun:yes'> </span>0 </td>
  <% 
     }
 %>    
  <td class=xl126 align=left style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'> </span><%=v_recv_book%> </td>
  <% 
     if (p_ccy_acct == "VND")
     {                
 %>  
  <td class=xl120 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=v_spend_trans%> </td>
  <% 
     }
     else
     {
  %>
  <td class=xl120 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
  <% 
     }
   %>    
  <% 
     if (p_ccy_acct != "VND")
     {                
 %>  
  <td class=xl87 x:num><span
  style='mso-spacerun:yes'> </span><%=v_spend_trans%> </td>
  <% 
     }
     else
     {              
  %>
  <td class=xl87 x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
  <% 
     } 
  %>  
  <td class=xl126 align=left style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'> </span><%=v_spend_book%> </td>
  
  <% 
     if (p_ccy_acct == "VND")
     {                
 %>    
  <td class=xl120 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=v_bank_bal_trans%> </td>

<% 
     }
     else
     {                
 %>  
  <td class=xl120 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
 <% 
     }
%>
  <% 
     if (p_ccy_acct != "VND")
     {                
 %> 
   <td class=xl87 x:num><span
  style='mso-spacerun:yes'> </span><%=v_bank_bal_trans%> </td>
 
 <% 
     }
     else
     {            
%>  
   <td class=xl87 x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
<% 
     }
 %>
  <td class=xl120 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=v_bank_bal_book%> </td>
  <td class=xl130 style='border-top:none;border-left:none' x:num></td>
  <td class=xl53 style='border-top:none;border-left:none'><%=dt_bankdt.Rows[j]["h_pk"].ToString()%></td>
 </tr>
 <% 
     }
     }
     v_acc_tot_recv_trans += v_tot_recv_trans;
     v_acc_tot_recv_book += v_tot_recv_book;
     v_acc_tot_spend_trans += v_tot_spend_trans;
     v_acc_tot_spend_book += v_tot_spend_book;                                
 %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl95 width=483 style='border-right:.5pt solid black;
  height:18.0pt;width:363pt'>TOTAL</td>
  <td class=xl43 width=33 style='width:25pt'>&nbsp;</td>
  <% 
     if (p_ccy_acct == "VND")
     {             
  %>
  <td class=xl119 style='border-top:none' x:num><span style='mso-spacerun:yes'>  </span><%=v_tot_recv_trans%> </td>
  <% 
     }
     else
     {             
  %>
  <td class=xl119 style='border-top:none' x:num="0"><span style='mso-spacerun:yes'>  </span> </td>
  <% 
     }
   %>
  <% 
     if (p_ccy_acct != "VND")
     {             
  %>
  <td class=xl128 x:num><span
  style='mso-spacerun:yes'> </span><%=v_tot_recv_trans%> </td>
  <% 
     }
     else
     {             
  %>
  <td class=xl128 x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
  <% 
     }
  %>  
  <td class=xl127 align=left style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=v_tot_recv_book%><span style='mso-spacerun:yes'>   </span></td>
  <% 
     if (p_ccy_acct == "VND")
     {             
  %>
  <td class=xl119 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=v_tot_spend_trans%> </td>
  <% 
     }
     else
     {                           
  %>
  <td class=xl119 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
  <% 
     }
  %>  
  <% 
     if (p_ccy_acct != "VND")
     {                     
  %>
  <td class=xl128 x:num><span
  style='mso-spacerun:yes'> </span><%=v_tot_spend_trans%> </td>
  <% 
     }
     else
     {             
   %>
  <td class=xl128 x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
  <% 
     }
   %>  
  <td class=xl127 align=left style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'> </span><%=v_tot_spend_book%> </td>
 <% 
     if (p_ccy_acct == "VND")
     {             
  %> 
  <td class=xl119 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=v_bank_bal_trans%> </td>
  <% 
     }
     else
     {                      
  %>
  <td class=xl119 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
  <% 
     }
  %>
  <% 
     if (p_ccy_acct != "VND")
     {             
   %>
  <td class=xl128 x:num><span
  style='mso-spacerun:yes'> </span><%=v_bank_bal_trans%> </td>
  <% 
     }
     else
     {             
  %>
  <td class=xl128 x:num="0"><span
  style='mso-spacerun:yes'> </span> </td>
  <% 
     }
  %>  
  <td class=xl119 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'> 
  </span><%=v_bank_bal_book%> </td>
  <td class=xl121>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
        }
     }   // if (dt_bank.Rows.Count > 0)
 %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl95 width=483 style='border-right:.5pt solid black;
  height:18.0pt;width:363pt'>TOTAL</td>
  <td class=xl43 width=33 style='width:25pt'>&nbsp;</td>
  <% 
     if (p_ccy_acct == "VND")
     {
  %>
  <td class=xl119 style='border-top:none' x:num><%=v_acc_tot_recv_trans%></td>
  <%
     }
     else
     { 
    %>
  <td class=xl119 style='border-top:none' x:num="0"></td>
  <% 
     }
  %>  
  <% 
     if (p_ccy_acct != "VND")
     {
  %>  
    <td class=xl128 x:num><span style='mso-spacerun:yes'> </span><%=v_acc_tot_recv_trans%><span
  style='mso-spacerun:yes'>   </span></td>  
 <%
     }
     else
     { 
   %>    
    <td class=xl128 x:num="0"></td>  
<% 
     }
    %>   
  <td class=xl127 align=left style='border-top:none;border-left:none' x:num><%=v_acc_tot_recv_book%></td>    
  <% 
     if (p_ccy_acct == "VND")
     {
   %>
   <td class=xl119 style='border-top:none;border-left:none' x:num><%=v_acc_tot_spend_trans%></td>
 
  <% 
     }
     else
     {
  %>
  <td class=xl119 style='border-top:none;border-left:none' x:num="0"></td>  
  <% 
     }
     %>
  <% 
     if (p_ccy_acct != "VND")
     {
   %>
   <td class=xl128 x:num><%=v_acc_tot_spend_trans%></td>
  
  <% 
     }
     else
     {
  %>
  <td class=xl128 x:num="0"></td>
  <% 
     }
   %>
   <td class=xl127 align=left style='border-top:none;border-left:none' x:num><%=v_acc_tot_spend_book%></td>  
  <% 
      v_acc_bal_trans = p_opentrans_num + v_acc_tot_recv_trans - v_acc_tot_spend_trans;
      v_acc_bal_book = p_open_book_num + v_acc_tot_recv_book - v_acc_tot_spend_trans;   
  %>
  <% 
      if (p_ccy_acct == "VND")
      {         
  %>
  <td class=xl119 style='border-top:none;border-left:none' x:num><%=v_acc_bal_trans%></td>
  <% 
      }
      else
      {
   %>
   <td class=xl119 style='border-top:none;border-left:none' x:num="0"></td>
   <%
      } 
     %>
 <% 
     if (p_ccy_acct != "VND")
     {         
 %> 
  <td class=xl128 x:num><%=v_acc_bal_trans%></td>
  <% 
     }
     else
     {         
  %>
  <td class=xl128 x:num="0"></td>
  <% 
     }
  %>
  <td class=xl119 style='border-top:none;border-left:none' x:num><%=v_acc_bal_book %></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
     } // for k in 112
  %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl42 width=24 style='height:22.5pt;width:18pt'>&nbsp;</td>
  <td class=xl43 width=57 style='width:43pt'>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl43 width=33 style='width:25pt'>&nbsp;</td>
  <td class=xl83 width=82 style='width:62pt'>&nbsp;</td>
  <td class=xl88 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl83 width=82 style='width:62pt'>&nbsp;</td>
  <td class=xl83 width=82 style='width:62pt'>&nbsp;</td>
  <td class=xl88 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl44 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl83 width=82 style='width:62pt'>&nbsp;</td>
  <td class=xl88 width=90 style='width:68pt'>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
 </tr>
 <tr class=xl37 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:495'>
  <td colspan=4 class=xl101 style='border-right:.5pt solid black'>Prepared by:
  </td>
  <td class=xl48><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl84><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl48><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td colspan=9 class=xl101 style='border-right:.5pt solid black'>Checked by:
  </td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl64></td>
  <td class=xl60></td>
  <td class=xl24></td>
  <td class=xl85></td>
  <td class=xl24></td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl85></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl64></td>
  <td class=xl60></td>
  <td class=xl24></td>
  <td class=xl85></td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-left:none'>&nbsp;</td>
  <td class=xl85></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl64></td>
  <td class=xl60></td>
  <td class=xl24></td>
  <td class=xl85></td>
  <td rowspan=4 class=xl50 style='border-top:none'>&nbsp;</td>
  <td rowspan=4 class=xl50 style='border-top:none'>&nbsp;</td>
  <td rowspan=4 class=xl50 style='border-top:none'>&nbsp;</td>
  <td rowspan=4 class=xl66 style='border-top:none'>&nbsp;</td>
  <td rowspan=4 class=xl66 style='border-top:none'>&nbsp;</td>
  <td class=xl85></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl64></td>
  <td class=xl60></td>
  <td class=xl24></td>
  <td class=xl85></td>
  <td class=xl85></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl64></td>
  <td class=xl60></td>
  <td class=xl24></td>
  <td class=xl85></td>
  <td class=xl85></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl64></td>
  <td class=xl60></td>
  <td class=xl24></td>
  <td class=xl85></td>
  <td class=xl85></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl25></td>
  <td class=xl64></td>
  <td class=xl60></td>
  <td class=xl24></td>
  <td class=xl85></td>
  <td class=xl24></td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl85></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=24 style='width:18pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=264 style='width:198pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=52 style='width:39pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>