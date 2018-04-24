<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_prod_date = Request.QueryString["prod_date"];

    DataTable dt_kn, dt_lk, dt_is, dt_pst, dt_pws, dt_st, dt_pr, dt_ct, dt_sw, dt_lb, dt_pk;
    dt_kn = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_knitting", "'" + p_prod_date + "'");
    dt_lk = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_linking", "'" + p_prod_date + "'");
    dt_is = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_inspect", "'" + p_prod_date + "'");
    dt_pst = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_pre_set", "'" + p_prod_date + "'");
    dt_pws = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_washing", "'" + p_prod_date + "'");
    dt_st = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_setting", "'" + p_prod_date + "'");
    dt_pr = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_pairing", "'" + p_prod_date + "'");
    dt_ct = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_cutting", "'" + p_prod_date + "'");
    dt_sw = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_sewing", "'" + p_prod_date + "'");
    dt_lb = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_label", "'" + p_prod_date + "'");
    dt_pk = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00080_snj_packing", "'" + p_prod_date + "'");
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00080_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00080_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00080_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>CTY TIN HOC HOANG KHA </o:Author>
  <o:LastAuthor>user</o:LastAuthor>
  <o:LastPrinted>2011-10-03T02:57:47Z</o:LastPrinted>
  <o:Created>2010-04-27T07:27:24Z</o:Created>
  <o:LastSaved>2011-10-04T07:22:46Z</o:LastSaved>
  <o:Company>DT:0650.35559627</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.23in .16in .18in .16in;
	mso-header-margin:.23in;
	mso-footer-margin:.18in;
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style20
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
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
	font-family:BatangChe, monospace;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:BatangChe, monospace;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl29
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0000";}
.xl30
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl32
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0000";}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";}
.xl37
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:black;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	background:black;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	color:white;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	text-align:right;
	background:black;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	color:white;
	font-size:11.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	background:black;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl47
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style16;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style16;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl80
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style16;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	background:white;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	background:white;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl116
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl117
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl118
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl119
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl120
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl129
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl130
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl131
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl132
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl133
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl134
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl135
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl136
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl137
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl138
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl139
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl141
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl142
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl143
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl144
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl145
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl146
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl147
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl148
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl149
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl150
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl151
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl152
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl153
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl154
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl155
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl156
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl157
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl158
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl159
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl160
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl161
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl162
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl163
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl164
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;}
.xl165
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl166
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl167
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl168
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl169
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl170
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl171
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl172
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl173
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl174
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl175
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl176
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl177
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl178
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl179
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl180
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl181
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl182
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl183
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl184
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl185
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl186
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl187
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl188
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl189
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl190
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl191
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl192
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl193
	{mso-style-parent:style0;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl194
	{mso-style-parent:style0;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl195
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl196
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl197
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:1.0pt solid black;
	border-left:2.0pt double windowtext;
	background:white;
	mso-pattern:auto none;}
.xl198
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl199
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:2.0pt double windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl200
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl201
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl202
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl203
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl204
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl205
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl206
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl207
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl208
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl209
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl210
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl211
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl212
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl213
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl214
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl215
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:2.0pt double windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl216
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl217
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl218
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl219
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl220
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl221
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl222
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl223
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid black;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl224
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl225
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl226
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl227
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl228
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl229
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl230
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl231
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl232
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl233
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl234
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:2.0pt double windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl235
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl236
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl237
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl238
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl239
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl240
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl241
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl242
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl243
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl244
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl245
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl246
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl247
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl248
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl249
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl250
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl251
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl252
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl253
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl254
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl255
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl256
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl257
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl258
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl259
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl260
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Arial Black", sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:aqua;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>45</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>70</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>62</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8220</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2115</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1034"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2552 style='border-collapse:
 collapse;table-layout:fixed;width:1919pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:2880;
 width:68pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:3648;
 width:86pt'>
 <col class=xl24 width=126 style='mso-width-source:userset;mso-width-alt:4032;
 width:95pt'>
 <col class=xl24 width=77 span=10 style='mso-width-source:userset;mso-width-alt:
 2464;width:58pt'>
 <col class=xl24 width=109 style='mso-width-source:userset;mso-width-alt:3488;
 width:82pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2592;
 width:61pt'>
 <col class=xl24 width=116 style='mso-width-source:userset;mso-width-alt:3712;
 width:87pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:1792;
 width:42pt'>
 <col class=xl25 width=126 style='mso-width-source:userset;mso-width-alt:4032;
 width:95pt'>
 <col class=xl25 width=48 style='mso-width-source:userset;mso-width-alt:1536;
 width:36pt'>
 <col class=xl25 width=126 style='mso-width-source:userset;mso-width-alt:4032;
 width:95pt'>
 <col class=xl25 width=48 style='mso-width-source:userset;mso-width-alt:1536;
 width:36pt'>
 <col class=xl26 width=151 style='mso-width-source:userset;mso-width-alt:4832;
 width:113pt'>
 <col class=xl26 width=125 style='mso-width-source:userset;mso-width-alt:4000;
 width:94pt'>
 <col class=xl24 width=165 style='mso-width-source:userset;mso-width-alt:5280;
 width:124pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:2816;
 width:66pt'>
 <col class=xl24 width=71 span=231 style='mso-width-source:userset;mso-width-alt:
 2272;width:53pt'>
 <tr class=xl27 height=54 style='mso-height-source:userset;height:40.5pt'>
  <td colspan=24 height=54 width=2251 style='height:40.5pt;width:1694pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1033" type="#_x0000_t75" style='position:absolute;
   margin-left:507pt;margin-top:5.25pt;width:132pt;height:68.25pt;z-index:1'>
   <v:imagedata src="rpt_fppr00080_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:676px;margin-top:7px;width:176px;
  height:91px'><img width=176 height=91 src="rpt_fppr00080_files/image002.jpg"
  v:shapes="_x0000_s1033"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=24 height=54 class=xl193 width=2251 style='height:40.5pt;
    width:1694pt'>S&amp;J HOSIERY(VIETNAM) Co.,LTD</td>
   </tr>
  </table>
  </span></td>
  <td class=xl28 width=88 style='width:66pt'></td>
  <td class=xl28 width=71 style='width:53pt'></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl28 width=71 style='width:53pt'></td>
 </tr>
 <tr class=xl30 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=24 height=40 class=xl194 style='height:30.0pt'>DAILY PRODUCTION
  REPORT</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl31></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=16 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl33 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=20 style='height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'></td>
  <td class=xl36></td>
  <td colspan=11 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=27 style='height:20.25pt'>
  <td height=27 class=xl40 style='height:20.25pt'>DATE :</td>
  <td class=xl41><%= System.DateTime.ParseExact(p_prod_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("yyyy-MM-dd")%>&nbsp;</td>
  <td class=xl42>UNIT :</td>
  <td class=xl43>PRS.</td>
  <td colspan=9 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl44 style='height:24.95pt'>KNITTI<span style='display:
  none'>NG SECTION</span></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td colspan=2 class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td rowspan=3 class=xl195 style='border-bottom:1.0pt solid black'>REMARKS</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td rowspan=2 height=42 class=xl198 style='border-bottom:.5pt solid black;
  height:31.9pt;border-top:none'>Needle</td>
  <td rowspan=2 class=xl200 style='border-bottom:.5pt solid black;border-top:
  none'>M/C Q'TY</td>
  <td rowspan=2 class=xl202 style='border-bottom:.5pt solid black;border-top:
  none'>TARGET Q'TY</td>
  <td colspan=4 class=xl205 style='border-left:none'>DAY SHIFT</td>
  <td class=xl53>&nbsp;</td>
  <td colspan=5 class=xl205 style='border-right:1.0pt solid black;border-left:
  none'>Night shift</td>
  <td rowspan=2 class=xl207 style='border-bottom:.5pt solid black;border-top:
  none'>Total Prod.</td>
  <td rowspan=2 class=xl209 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl200 style='border-bottom:.5pt solid black;border-top:
  none'>B-Grade</td>
  <td rowspan=2 class=xl200 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl200 style='border-bottom:.5pt solid black;border-top:
  none'>C-Grade</td>
  <td rowspan=2 class=xl200 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl200 style='border-bottom:.5pt solid black;border-top:
  none'>Damage</td>
  <td rowspan=2 class=xl202 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl211 style='border-bottom:.5pt solid black;border-top:
  none'>Mini WHS Stock</td>
  <td rowspan=2 class=xl213>Working Time</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl54 width=77 style='height:15.95pt;width:58pt'>M/C</td>
  <td class=xl55 width=77 style='width:58pt'>Prod.Q'ty</td>
  <td class=xl56 width=77 style='width:58pt'>B-Grade</td>
  <td class=xl55 width=77 style='width:58pt'>C-Grade</td>
  <td class=xl57 width=77 style='width:58pt'>Damage</td>
  <td class=xl54 width=77 style='width:58pt'>M/C</td>
  <td class=xl54 width=77 style='width:58pt'>Prod.Q'ty</td>
  <td class=xl54 width=77 style='width:58pt'>B-Grade</td>
  <td class=xl55 width=77 style='width:58pt'>C-Grade</td>
  <td class=xl57 width=77 style='width:58pt'>Damage</td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <%
     Decimal kn_mc_qty = 0;
     Decimal kn_tg_qty = 0;
     Decimal kn_day_mc_qty = 0;
     Decimal kn_day_prod_qty = 0;
     Decimal kn_day_b_qty = 0;
     Decimal kn_day_c_qty = 0;
     Decimal kn_day_d_qty = 0;
     Decimal kn_night_mc_qty = 0;
     Decimal kn_night_prod_qty = 0;
     Decimal kn_night_b_qty = 0;
     Decimal kn_night_c_qty = 0;
     Decimal kn_night_d_qty = 0;
     Decimal kn_total_prod = 0;
     Decimal kn_total_b_qty = 0;
     Decimal kn_total_c_qty = 0;
     Decimal kn_total_d_qty = 0;
     for (int i = 0; i < dt_kn.Rows.Count; i++)
     {
        kn_mc_qty = kn_mc_qty + Convert.ToDecimal(dt_kn.Rows[i]["mc_qty"]);
        kn_tg_qty = kn_tg_qty + Convert.ToDecimal(dt_kn.Rows[i]["target_qty"]);
        kn_day_mc_qty = kn_day_mc_qty + Convert.ToDecimal(dt_kn.Rows[i]["day_mc_qty"]);
        kn_day_prod_qty = kn_day_prod_qty + Convert.ToDecimal(dt_kn.Rows[i]["day_prod_qty"]);
        kn_day_b_qty = kn_day_b_qty + Convert.ToDecimal(dt_kn.Rows[i]["day_b_qty"]);
        kn_day_c_qty = kn_day_c_qty + Convert.ToDecimal(dt_kn.Rows[i]["day_c_qty"]);
        kn_day_d_qty = kn_day_d_qty + Convert.ToDecimal(dt_kn.Rows[i]["day_d_qty"]);
        kn_night_mc_qty = kn_night_mc_qty + Convert.ToDecimal(dt_kn.Rows[i]["night_mc_qty"]);
        kn_night_prod_qty = kn_night_prod_qty + Convert.ToDecimal(dt_kn.Rows[i]["night_prod_qty"]);
        kn_night_b_qty = kn_night_b_qty + Convert.ToDecimal(dt_kn.Rows[i]["night_b_qty"]);
        kn_night_c_qty = kn_night_c_qty + Convert.ToDecimal(dt_kn.Rows[i]["night_c_qty"]);
        kn_night_d_qty = kn_night_d_qty + Convert.ToDecimal(dt_kn.Rows[i]["night_d_qty"]);
        kn_total_prod = kn_total_prod + Convert.ToDecimal(dt_kn.Rows[i]["total_prod"]);
        kn_total_b_qty = kn_total_b_qty + Convert.ToDecimal(dt_kn.Rows[i]["total_b_qty"]);
        kn_total_c_qty = kn_total_c_qty + Convert.ToDecimal(dt_kn.Rows[i]["total_c_qty"]);
        kn_total_d_qty = kn_total_d_qty + Convert.ToDecimal(dt_kn.Rows[i]["total_d_qty"]);
        %>
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'><%=dt_kn.Rows[i]["needle"]%></td>
  <td class=xl59 x:num><%=dt_kn.Rows[i]["mc_qty"]%></td>
  <td class=xl60 x:num><%=dt_kn.Rows[i]["target_qty"]%></td>
  <td class=xl61 x:num><%=dt_kn.Rows[i]["day_mc_qty"]%></td>
  <td class=xl62 x:num><%=dt_kn.Rows[i]["day_prod_qty"]%></td>
  <td class=xl62 x:num><%=dt_kn.Rows[i]["day_b_qty"]%></td>
  <td class=xl63 x:num><%=dt_kn.Rows[i]["day_c_qty"]%></td>
  <td class=xl64 x:num><%=dt_kn.Rows[i]["day_d_qty"]%></td>
  <td class=xl62 x:num><%=dt_kn.Rows[i]["night_mc_qty"]%></td>
  <td class=xl62 x:num><%=dt_kn.Rows[i]["night_prod_qty"]%></td>
  <td class=xl62 x:num><%=dt_kn.Rows[i]["night_b_qty"]%></td>
  <td class=xl63 x:num><%=dt_kn.Rows[i]["night_c_qty"]%></td>
  <td class=xl64 x:num><%=dt_kn.Rows[i]["night_d_qty"]%></td>
  <td class=xl65 x:num><%=dt_kn.Rows[i]["total_prod"]%></td>
  <td class=xl66 x:num><%=dt_kn.Rows[i]["total_rate"]%></td>
  <td class=xl67 x:num><%=dt_kn.Rows[i]["total_b_qty"]%></td>
  <td class=xl66 x:num><%=dt_kn.Rows[i]["total_b_rate"]%></td>
  <td class=xl67 x:num><%=dt_kn.Rows[i]["total_c_qty"]%></td>
  <td class=xl66 x:num><%=dt_kn.Rows[i]["total_c_rate"]%></td>
  <td class=xl67 x:num><%=dt_kn.Rows[i]["total_d_qty"]%></td>
  <td class=xl66 x:num><%=dt_kn.Rows[i]["total_d_rate"]%></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=kn_mc_qty %></td>
  <td class=xl73 x:num><%=kn_tg_qty %></td>
  <td class=xl74 x:num><%=kn_day_mc_qty %></td>
  <td class=xl75 x:num><%=kn_day_prod_qty %></td>
  <td class=xl75 x:num><%=kn_day_b_qty %></td>
  <td class=xl75 x:num><%=kn_day_c_qty %></td>
  <td class=xl76 x:num><%=kn_day_d_qty %></td>
  <td class=xl77 x:num><%=kn_night_mc_qty %></td>
  <td class=xl78 x:num><%=kn_night_prod_qty %></td>
  <td class=xl75 x:num><%=kn_night_b_qty %></td>
  <td class=xl75 x:num><%=kn_night_c_qty %></td>
  <td class=xl75 x:num><%=kn_night_d_qty %></td>
  <td class=xl79 x:num><%=kn_total_prod %></td>
  <td class=xl80 x:num><%=kn_total_prod/kn_tg_qty %></td>
  <td class=xl81 x:num><%=kn_total_b_qty %></td>
  <td class=xl80 x:num><%=kn_total_b_qty/kn_total_prod %></td>
  <td class=xl81 x:num><%=kn_total_c_qty %></td>
  <td class=xl66 x:num><%=kn_total_c_qty/kn_total_prod %></td>
  <td class=xl81 x:num><%=kn_total_d_qty %></td>
  <td class=xl66 x:num><%=kn_total_d_qty/kn_total_prod %></td>
  <td class=xl83 x:num>&nbsp;</td>
  <td class=xl84 x:num>&nbsp;</td>
  <td class=xl85 x:num>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl93 colspan=3 style='height:24.95pt;mso-ignore:colspan'>LINKING
  SECTION</td>
  <td colspan=2 class=xl95>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td colspan=2 class=xl95>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl96>&nbsp;</td>
  <td class=xl96>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
  <td class=xl102>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td rowspan=2 height=42 class=xl214 style='border-bottom:.5pt solid black;
  height:31.9pt;border-top:none'>Line</td>
  <td rowspan=2 class=xl216 style='border-bottom:.5pt solid black;border-top:
  none'>M/C Q'TY</td>
  <td rowspan=2 class=xl218 style='border-bottom:.5pt solid black;border-top:
  none'>TARGET Q'TY</td>
  <td colspan=5 class=xl221 width=385 style='border-right:1.0pt solid black;
  border-left:none;width:290pt'>DAY SHIFT</td>
  <td colspan=5 class=xl223 width=385 style='border-right:1.0pt solid black;
  border-left:none;width:290pt'>Night shift</td>
  <td rowspan=2 class=xl225 style='border-bottom:.5pt solid black;border-top:
  none'>Total Prod.</td>
  <td rowspan=2 class=xl227 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl229 style='border-bottom:.5pt solid black;border-top:
  none'>Mending</td>
  <td rowspan=2 class=xl216 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl231 style='border-bottom:.5pt solid black;border-top:
  none' x:str="Cutter"><span style='mso-spacerun:yes'> </span>Cutter<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl216 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl231 style='border-bottom:.5pt solid black;border-top:
  none' x:str="Damage"><span style='mso-spacerun:yes'> </span>Damage<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl218 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl103>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl105 width=77 style='height:15.95pt;width:58pt'>M/C</td>
  <td class=xl106 width=77 style='width:58pt'>Prod.Q'ty</td>
  <td class=xl107 width=77 style='width:58pt'>Mending</td>
  <td class=xl106 width=77 style='width:58pt'>Cutter</td>
  <td class=xl108 width=77 style='width:58pt'>Damage</td>
  <td class=xl105 width=77 style='width:58pt'>M/C</td>
  <td class=xl106 width=77 style='width:58pt'>Prod.Q'ty</td>
  <td class=xl107 width=77 style='width:58pt'>Mending</td>
  <td class=xl106 width=77 style='width:58pt'>Cutter</td>
  <td class=xl108 width=77 style='width:58pt'>Damage</td>
  <td class=xl109>&nbsp;</td>
  <td class=xl110>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td colspan=4 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 
  <%
     Decimal lk_mc_qty = 0;
     Decimal lk_tg_qty = 0;
     Decimal lk_day_mc_qty = 0;
     Decimal lk_day_prod_qty = 0;
     Decimal lk_day_mending_qty = 0;
     Decimal lk_day_cut_qty = 0;
     Decimal lk_day_damage_qty = 0;
     Decimal lk_night_mc_qty = 0;
     Decimal lk_night_prod_qty = 0;
     Decimal lk_night_mending_qty = 0;
     Decimal lk_night_cut_qty = 0;
     Decimal lk_night_damage_qty = 0;
     Decimal lk_total_prod = 0;
     Decimal lk_total_mending_qty = 0;
     Decimal lk_total_cut_qty = 0;
     Decimal lk_total_damage_qty = 0;
     
     for (int i = 0; i < dt_lk.Rows.Count; i++)
     {
        lk_mc_qty = lk_mc_qty + Convert.ToDecimal(dt_lk.Rows[i]["mc_qty"]);
        lk_tg_qty = lk_tg_qty + Convert.ToDecimal(dt_lk.Rows[i]["target_qty"]);
        lk_day_mc_qty = lk_day_mc_qty + Convert.ToDecimal(dt_lk.Rows[i]["day_mc_qty"]);
        lk_day_prod_qty = lk_day_prod_qty + Convert.ToDecimal(dt_lk.Rows[i]["day_prod_qty"]);
        lk_day_mending_qty = lk_day_mending_qty + Convert.ToDecimal(dt_lk.Rows[i]["day_mending_qty"]);
        lk_day_cut_qty = lk_day_cut_qty + Convert.ToDecimal(dt_lk.Rows[i]["day_cut_qty"]);
        lk_day_damage_qty = lk_day_damage_qty + Convert.ToDecimal(dt_lk.Rows[i]["day_damage_qty"]);
        lk_night_mc_qty = lk_night_mc_qty + Convert.ToDecimal(dt_lk.Rows[i]["night_mc_qty"]);
        lk_night_prod_qty = lk_night_prod_qty + Convert.ToDecimal(dt_lk.Rows[i]["night_prod_qty"]);
        lk_night_mending_qty = lk_night_mending_qty + Convert.ToDecimal(dt_lk.Rows[i]["night_mending_qty"]);
        lk_night_cut_qty = lk_night_cut_qty + Convert.ToDecimal(dt_lk.Rows[i]["night_cut_qty"]);
        lk_night_damage_qty = lk_night_damage_qty + Convert.ToDecimal(dt_lk.Rows[i]["night_damage_qty"]);
        lk_total_prod = lk_total_prod + Convert.ToDecimal(dt_lk.Rows[i]["total_prod"]);
        lk_total_mending_qty = lk_total_mending_qty + Convert.ToDecimal(dt_lk.Rows[i]["total_mending_qty"]);
        lk_total_cut_qty = lk_total_cut_qty + Convert.ToDecimal(dt_lk.Rows[i]["total_cut_qty"]);
        lk_total_damage_qty = lk_total_damage_qty + Convert.ToDecimal(dt_lk.Rows[i]["total_damage_qty"]);
        %>
        
        
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'> <%=dt_lk.Rows[i]["line_id"]%></td>
  <td class=xl59 x:num><%=dt_lk.Rows[i]["mc_qty"]%></td>
  <td class=xl60 x:num><%=dt_lk.Rows[i]["target_qty"]%></td>
  <td class=xl61 x:num><%=dt_lk.Rows[i]["day_mc_qty"]%></td>
  <td class=xl62 x:num><%=dt_lk.Rows[i]["day_prod_qty"]%></td>
  <td class=xl62 x:num><%=dt_lk.Rows[i]["day_mending_qty"]%></td>
  <td class=xl63 x:num><%=dt_lk.Rows[i]["day_cut_qty"]%></td>
  <td class=xl64 x:num><%=dt_lk.Rows[i]["day_damage_qty"]%></td>
  <td class=xl62 x:num><%=dt_lk.Rows[i]["night_mc_qty"]%></td>
  <td class=xl62 x:num><%=dt_lk.Rows[i]["night_prod_qty"]%></td>
  <td class=xl62 x:num><%=dt_lk.Rows[i]["night_mending_qty"]%></td>
  <td class=xl63 x:num><%=dt_lk.Rows[i]["night_cut_qty"]%></td>
  <td class=xl64 x:num><%=dt_lk.Rows[i]["night_damage_qty"]%></td>
  <td class=xl65 x:num><%=dt_lk.Rows[i]["total_prod"]%></td>
  <td class=xl66 x:num><%=dt_lk.Rows[i]["total_rate"]%></td>
  <td class=xl67 x:num><%=dt_lk.Rows[i]["total_mending_qty"]%></td>
  <td class=xl66 x:num><%=dt_lk.Rows[i]["total_mending_rate"]%></td>
  <td class=xl67 x:num><%=dt_lk.Rows[i]["total_cut_qty"]%></td>
  <td class=xl66 x:num><%=dt_lk.Rows[i]["total_cut_rate"]%></td>
  <td class=xl67 x:num><%=dt_lk.Rows[i]["total_damage_qty"]%></td>
  <td class=xl66 x:num><%=dt_lk.Rows[i]["total_damage_rate"]%></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=lk_mc_qty %></td>
  <td class=xl73 x:num><%=lk_tg_qty %></td>
  <td class=xl74 x:num><%=lk_day_mc_qty %></td>
  <td class=xl75 x:num><%=lk_day_prod_qty %></td>
  <td class=xl75 x:num><%=lk_day_mending_qty %></td>
  <td class=xl75 x:num><%=lk_day_cut_qty %></td>
  <td class=xl76 x:num><%=lk_day_damage_qty %></td>
  <td class=xl77 x:num><%=lk_night_mc_qty %></td>
  <td class=xl78 x:num><%=lk_night_prod_qty %></td>
  <td class=xl75 x:num><%=lk_night_mending_qty %></td>
  <td class=xl75 x:num><%=lk_night_cut_qty %></td>
  <td class=xl75 x:num><%=lk_night_damage_qty %></td>
  <td class=xl79 x:num><%=lk_total_prod %></td>
  <td class=xl80 x:num><%=lk_total_prod/lk_tg_qty %></td>
  <td class=xl81 x:num><%=lk_total_mending_qty %></td>
  <td class=xl80 x:num><%=lk_total_mending_qty/lk_total_prod %></td>
  <td class=xl81 x:num><%=lk_total_cut_qty %></td>
  <td class=xl66 x:num><%=lk_total_cut_qty/lk_total_prod %></td>
  <td class=xl81 x:num><%=lk_total_damage_qty %></td>
  <td class=xl66 x:num><%=lk_total_damage_qty/lk_total_prod %></td>
  <td class=xl83 x:num></td>
  <td class=xl84 x:num></td>
  <td class=xl85 x:num></td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl251 style='height:24.95pt'>INSPEC<span
  style='display:none'>TION SECTION</span></td>
  <td class=xl252>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl253>&nbsp;</td>
  <td class=xl254>&nbsp;</td>
  <td class=xl254>&nbsp;</td>
  <td class=xl254>&nbsp;</td>
  <td class=xl254>&nbsp;</td>
  <td class=xl254>&nbsp;</td>
  <td class=xl255>&nbsp;</td>
  <td class=xl111>&nbsp;</td>
  <td class=xl112>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=42 style='mso-height-source:userset;height:32.1pt'>
  <td height=42 class=xl113 style='height:32.1pt'>RECORDER</td>
  <td class=xl114 width=114 style='width:86pt'>TOTAL INSPECTOR</td>
  <td class=xl115>TARGET Q'TY</td>
  <td class=xl116>Inspector</td>
  <td class=xl117>Prod.Qty</td>
  <td class=xl117>B-Grade</td>
  <td class=xl117>C-Grade</td>
  <td class=xl117>Mending</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl115>&nbsp;</td>
  <td class=xl118>Total Prod.</td>
  <td class=xl117>%</td>
  <td class=xl117>B-Grade</td>
  <td class=xl117>%</td>
  <td class=xl117>C-Grade</td>
  <td class=xl117>%</td>
  <td class=xl117>Mending</td>
  <td class=xl115>%</td>
  <td class=xl119>Mini WHS Stock</td>
  <td class=xl120>&nbsp;</td>
  <td class=xl121>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
     Decimal is_inspector_qty = 0;
     Decimal is_target_qty = 0;
     Decimal is_prod_qty = 0;
     Decimal is_b_qty = 0;
     Decimal is_c_qty = 0;
     Decimal is_mending_qty = 0;
     Decimal is_total_prod = 0;
     Decimal is_total_b_qty = 0;
     Decimal is_total_c_qty = 0;
     Decimal is_total_mending_qty = 0;
     
     for (int i = 0; i < dt_is.Rows.Count; i++)
     {
           is_inspector_qty = is_inspector_qty + Convert.ToDecimal(dt_is.Rows[i]["inspector_qty"]);
           is_target_qty = is_target_qty + Convert.ToDecimal(dt_is.Rows[i]["target_qty"]);
           is_prod_qty = is_prod_qty + Convert.ToDecimal(dt_is.Rows[i]["prod_qty"]);
           is_b_qty = is_b_qty + Convert.ToDecimal(dt_is.Rows[i]["b_qty"]);
           is_c_qty = is_c_qty + Convert.ToDecimal(dt_is.Rows[i]["c_qty"]);
           is_mending_qty = is_mending_qty + Convert.ToDecimal(dt_is.Rows[i]["mending_qty"]);
           is_total_prod = is_total_prod + Convert.ToDecimal(dt_is.Rows[i]["total_prod"]);
           is_total_b_qty = is_total_b_qty + Convert.ToDecimal(dt_is.Rows[i]["total_b_qty"]);
           is_total_c_qty = is_total_c_qty + Convert.ToDecimal(dt_is.Rows[i]["total_c_qty"]);
           is_total_mending_qty = is_total_mending_qty + Convert.ToDecimal(dt_is.Rows[i]["total_mending_qty"]);
          %>
          
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'> <%=dt_is.Rows[i]["line_id"]%> </td>
  <td class=xl59 x:num><%=dt_is.Rows[i]["inspector_qty"]%></td>
  <td class=xl60 x:num><%=dt_is.Rows[i]["target_qty"]%></td>
  <td class=xl61 x:num><%=dt_is.Rows[i]["working_inspector"]%></td>
  <td class=xl62 x:num><%=dt_is.Rows[i]["prod_qty"]%></td>
  <td class=xl62 x:num><%=dt_is.Rows[i]["b_qty"]%></td>
  <td class=xl63 x:num><%=dt_is.Rows[i]["c_qty"]%></td>
  <td class=xl64 x:num><%=dt_is.Rows[i]["mending_qty"]%></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 x:num><%=dt_is.Rows[i]["total_prod"]%></td>
  <td class=xl66 x:num><%=dt_is.Rows[i]["total_rate"]%></td>
  <td class=xl67 x:num><%=dt_is.Rows[i]["total_b_qty"]%></td>
  <td class=xl66 x:num><%=dt_is.Rows[i]["total_b_rate"]%></td>
  <td class=xl67 x:num><%=dt_is.Rows[i]["total_c_qty"]%></td>
  <td class=xl66 x:num><%=dt_is.Rows[i]["total_c_rate"]%></td>
  <td class=xl67 x:num><%=dt_is.Rows[i]["total_mending_qty"]%></td>
  <td class=xl66 x:num><%=dt_is.Rows[i]["total_mending_rate"]%></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=is_inspector_qty %></td>
  <td class=xl73 x:num><%=is_target_qty %></td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75 x:num><%=is_prod_qty %></td>
  <td class=xl75 x:num><%=is_b_qty %></td>
  <td class=xl75 x:num><%=is_c_qty %></td>
  <td class=xl76 x:num><%=is_mending_qty %></td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl79 x:num><%=is_total_prod %></td>
  <td class=xl80 x:num><%=is_total_prod/is_target_qty %></td>
  <td class=xl81 x:num><%=is_total_b_qty %></td>
  <td class=xl80 x:num><%=is_total_b_qty/is_total_prod %></td>
  <td class=xl81 x:num><%=is_total_c_qty %></td>
  <td class=xl80 x:num><%=is_total_c_qty/is_total_prod %></td>
  <td class=xl81 x:num><%=is_total_mending_qty %></td>
  <td class=xl80 x:num><%=is_total_mending_qty/is_total_prod%></td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl122 colspan=3 style='height:24.95pt;mso-ignore:colspan'>PRE
  SETTING SECTION</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td class=xl112>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td rowspan=2 height=42 class=xl233 style='border-bottom:.5pt solid black;
  height:31.9pt;border-top:none'>M/C</td>
  <td rowspan=2 class=xl235 style='border-bottom:.5pt solid black;border-top:
  none'>OPERATOR</td>
  <td rowspan=2 class=xl237 style='border-bottom:.5pt solid black;border-top:
  none'>TARGET Q'TY</td>
  <td colspan=2 class=xl239 width=154 style='border-right:1.0pt solid black;
  border-left:none;width:116pt'>Prod.Q'ty</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td rowspan=2 class=xl241 style='border-bottom:.5pt solid black;border-top:
  none'>Total Prod.</td>
  <td rowspan=2 class=xl243 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl247 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl249 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl129>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl130 style='height:15.95pt'>D/S</td>
  <td class=xl131>N/S</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl133 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl134>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
  <%
     Decimal  pst_operator_qty =0;
     Decimal  pst_target_qty =0;
     Decimal  pst_day_prod_qty =0;
     Decimal  pst_night_prod_qty =0;
     Decimal  pst_total_prod =0;
     
     for (int i = 0; i < dt_pst.Rows.Count; i++)
     {
        pst_operator_qty = pst_operator_qty + Convert.ToDecimal(dt_pst.Rows[i]["operator_qty"]);
        pst_target_qty = pst_target_qty + Convert.ToDecimal(dt_pst.Rows[i]["target_qty"]);
        pst_day_prod_qty = pst_day_prod_qty + Convert.ToDecimal(dt_pst.Rows[i]["day_prod_qty"]);
        pst_night_prod_qty = pst_night_prod_qty + Convert.ToDecimal(dt_pst.Rows[i]["night_prod_qty"]);
        pst_total_prod = pst_total_prod + Convert.ToDecimal(dt_pst.Rows[i]["total_prod"]);
          %>
 
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'><%=dt_pst.Rows[i]["line_id"]%></td>
  <td class=xl59 x:num><%=dt_pst.Rows[i]["operator_qty"]%></td>
  <td class=xl60 x:num><%=dt_pst.Rows[i]["target_qty"]%></td>
  <td class=xl61 x:num><%=dt_pst.Rows[i]["day_prod_qty"]%></td>
  <td class=xl62 x:num><%=dt_pst.Rows[i]["night_prod_qty"]%></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 x:num><%=dt_pst.Rows[i]["total_prod"]%></td>
  <td class=xl66 x:num><%=dt_pst.Rows[i]["total_rate"]%></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=pst_operator_qty %></td>
  <td class=xl73 x:num><%=pst_target_qty %></td>
  <td class=xl74 x:num><%=pst_day_prod_qty %></td>
  <td class=xl75 x:num><%=pst_night_prod_qty %></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl79 x:num><%=pst_total_prod %></td>
  <td class=xl80 x:num><%=(pst_total_prod/pst_target_qty) %></td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl122 colspan=2 style='height:24.95pt;mso-ignore:colspan'>PRE
  WASHING</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl138>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td class=xl112>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td rowspan=2 height=42 class=xl233 style='border-bottom:.5pt solid black;
  height:31.9pt;border-top:none'>M/C&nbsp;</td>
  <td rowspan=2 class=xl235 style='border-bottom:.5pt solid black;border-top:
  none'>OPERATOR</td>
  <td rowspan=2 class=xl237 style='border-bottom:.5pt solid black;border-top:
  none'>TARGET Q'TY</td>
  <td colspan=2 class=xl239 width=154 style='border-right:1.0pt solid black;
  border-left:none;width:116pt'>Prod.Q'ty</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td rowspan=2 class=xl241 style='border-bottom:.5pt solid black;border-top:
  none'>Total Prod.</td>
  <td rowspan=2 class=xl243 style='border-bottom:.5pt solid black;border-top:
  none'>%</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl245 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl247 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl249 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl129>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl130 style='height:15.95pt'>D/S</td>
  <td class=xl131>N/S</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl128>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl129>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
       Decimal pws_operator_qty =0;
       Decimal pws_target_qty =0;
       Decimal pws_day_prod_qty =0;
       Decimal pws_night_prod_qty =0;
       Decimal pws_total_prod =0;
       
       for (int i = 0; i < dt_pws.Rows.Count; i++)
       {
            pws_operator_qty = pws_operator_qty + Convert.ToDecimal(dt_pws.Rows[i]["operator_qty"]);
            pws_target_qty = pws_target_qty + Convert.ToDecimal(dt_pws.Rows[i]["target_qty"]);
            pws_day_prod_qty = pws_day_prod_qty + Convert.ToDecimal(dt_pws.Rows[i]["day_prod_qty"]);
            pws_night_prod_qty = pws_night_prod_qty + Convert.ToDecimal(dt_pws.Rows[i]["night_prod_qty"]);
            pws_total_prod = pws_total_prod + Convert.ToDecimal(dt_pws.Rows[i]["total_prod"]);
          %>
          
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'> <%=dt_pws.Rows[i]["line_id"]%> </td>
  <td class=xl59 x:num><%=dt_pws.Rows[i]["operator_qty"]%></td>
  <td class=xl60 x:num><%=dt_pws.Rows[i]["target_qty"]%></td>
  <td class=xl61 x:num><%=dt_pws.Rows[i]["day_prod_qty"]%></td>
  <td class=xl62 x:num><%=dt_pws.Rows[i]["night_prod_qty"]%></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 x:num><%=dt_pws.Rows[i]["total_prod"]%></td>
  <td class=xl66 x:num><%=dt_pws.Rows[i]["total_rate"]%></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=pws_operator_qty %></td>
  <td class=xl73 x:num><%=pws_target_qty %></td>
  <td class=xl74 x:num><%=pws_day_prod_qty %></td>
  <td class=xl75 x:num><%=pws_night_prod_qty %></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl79 x:num><%=pws_total_prod %></td>
  <td class=xl80 x:num><%=(pws_total_prod/pws_target_qty) %></td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl122 colspan=3 style='height:24.95pt;mso-ignore:colspan'>SETTING
  SECTION</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl137>&nbsp;</td>
  <td class=xl138>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td class=xl112>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td rowspan=2 height=42 class=xl233 style='border-bottom:.5pt solid black;
  height:31.9pt;border-top:none'>M/C</td>
  <td rowspan=2 class=xl235 style='border-bottom:.5pt solid black;border-top:
  none'>OPERATOR</td>
  <td rowspan=2 class=xl237 style='border-bottom:.5pt solid black;border-top:
  none'>TARGET Q'TY</td>
  <td colspan=2 class=xl239 width=154 style='border-right:1.0pt solid black;
  border-left:none;width:116pt'>Prod.Q'ty</td>
  <td class=xl139>&nbsp;</td>
  <td class=xl139>&nbsp;</td>
  <td class=xl139>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl125>&nbsp;</td>
  <td class=xl125>&nbsp;</td>
  <td class=xl125>&nbsp;</td>
  <td class=xl125>&nbsp;</td>
  <td class=xl125>&nbsp;</td>
  <td class=xl140>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl129>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl130 style='height:15.95pt'>D/S</td>
  <td class=xl131>N/S</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl132 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl133 width=77 style='width:58pt'>&nbsp;</td>
  <td class=xl141>Total Prod.</td>
  <td class=xl142>%</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl130>&nbsp;</td>
  <td class=xl143>&nbsp;</td>
  <td class=xl134>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
  <%
       Decimal st_operator_qty =0;
       Decimal st_target_qty =0;
       Decimal st_day_prod_qty =0;
       Decimal st_night_prod_qty =0;
       Decimal st_total_prod =0;
       
       for (int i = 0; i < dt_st.Rows.Count; i++)
       {
       
            st_operator_qty = st_operator_qty + Convert.ToDecimal(dt_st.Rows[i]["operator_qty"]);
            st_target_qty = st_target_qty + Convert.ToDecimal(dt_st.Rows[i]["target_qty"]);
            st_day_prod_qty = st_day_prod_qty + Convert.ToDecimal(dt_st.Rows[i]["day_prod_qty"]);
            st_night_prod_qty = st_night_prod_qty + Convert.ToDecimal(dt_st.Rows[i]["night_prod_qty"]);
            st_total_prod = st_total_prod + Convert.ToDecimal(dt_st.Rows[i]["total_prod"]);
            
          %>
          
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'><%=dt_st.Rows[i]["line_id"]%></td>
  <td class=xl59 x:num><%=dt_st.Rows[i]["operator_qty"]%></td>
  <td class=xl60 x:num><%=dt_st.Rows[i]["target_qty"]%></td>
  <td class=xl61 x:num><%=dt_st.Rows[i]["day_prod_qty"]%></td>
  <td class=xl62 x:num><%=dt_st.Rows[i]["night_prod_qty"]%></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 x:num><%=dt_st.Rows[i]["total_prod"]%></td>
  <td class=xl66 x:num><%=dt_st.Rows[i]["total_rate"]%></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=st_operator_qty %></td>
  <td class=xl73 x:num><%=st_target_qty %></td>
  <td class=xl74 x:num><%=st_day_prod_qty %></td>
  <td class=xl75 x:num><%=st_night_prod_qty %></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl79 x:num><%=st_total_prod %></td>
  <td class=xl80 x:num><%=(st_total_prod/st_target_qty) %></td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl122 colspan=3 style='height:24.95pt;mso-ignore:colspan'>PAIRING
  SECTION</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl123>&nbsp;</td>
  <td class=xl256>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td class=xl112>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=42 style='mso-height-source:userset;height:32.1pt'>
  <td height=42 class=xl144 style='height:32.1pt'>RECORDER</td>
  <td class=xl145>PAIRER</td>
  <td class=xl130>TARGET Q'TY</td>
  <td class=xl146>PAIRER</td>
  <td class=xl147>Prod.Qty</td>
  <td class=xl148>&nbsp;</td>
  <td class=xl148>&nbsp;</td>
  <td class=xl148>&nbsp;</td>
  <td class=xl148>&nbsp;</td>
  <td class=xl148>&nbsp;</td>
  <td class=xl148>&nbsp;</td>
  <td class=xl148>&nbsp;</td>
  <td class=xl139>&nbsp;</td>
  <td class=xl141>Total Prod.</td>
  <td class=xl142>%</td>
  <td class=xl149>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl142>&nbsp;</td>
  <td class=xl143>&nbsp;</td>
  <td class=xl134>&nbsp;</td>
  <td class=xl121>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
 
 <%
       Decimal pr_operator_qty =0;
       Decimal pr_target_qty =0;
       Decimal pr_prod_qty =0;
       for (int i = 0; i < dt_pr.Rows.Count; i++)
       {
          pr_operator_qty = pr_operator_qty +   Convert.ToDecimal(dt_pr.Rows[i]["operator_qty"]);
          pr_target_qty = pr_target_qty +   Convert.ToDecimal(dt_pr.Rows[i]["target_qty"]);
          pr_prod_qty = pr_prod_qty +   Convert.ToDecimal(dt_pr.Rows[i]["prod_qty"]);
          %>
          
          
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'><%=dt_pr.Rows[i]["line_id"]%></td>
  <td class=xl59 x:num><%=dt_pr.Rows[i]["operator_qty"]%></td>
  <td class=xl60 x:num><%=dt_pr.Rows[i]["target_qty"]%></td>
  <td class=xl61>&nbsp;</td>
  <td class=xl62 x:num><%=dt_pr.Rows[i]["prod_qty"]%></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 x:num><%=dt_pr.Rows[i]["prod_qty"]%></td>
  <td class=xl66 x:num><%=dt_pr.Rows[i]["total_rate"]%></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=pr_operator_qty %></td>
  <td class=xl73 x:num><%=pr_target_qty %></td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75 x:num><%=pr_prod_qty %></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl79 x:num><%=pr_prod_qty %></td>
  <td class=xl80 x:num><%=(pr_prod_qty/pr_target_qty) %></td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl46 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl150 colspan=3 style='height:24.95pt;mso-ignore:colspan'>CUTTING
  SECTION</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl257>&nbsp;</td>
  <td class=xl258>&nbsp;</td>
  <td class=xl152>&nbsp;</td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=42 style='mso-height-source:userset;height:32.1pt'>
  <td height=42 class=xl153 style='height:32.1pt'>TABLE</td>
  <td class=xl154>CUTTER</td>
  <td class=xl155>TARGET Q'TY</td>
  <td class=xl156>CUTTER</td>
  <td class=xl157>Prod.Qty</td>
  <td class=xl158>&nbsp;</td>
  <td class=xl158>&nbsp;</td>
  <td class=xl158>&nbsp;</td>
  <td class=xl158>&nbsp;</td>
  <td class=xl158>&nbsp;</td>
  <td class=xl158>&nbsp;</td>
  <td class=xl158>&nbsp;</td>
  <td class=xl159>&nbsp;</td>
  <td class=xl160>Total Prod.</td>
  <td class=xl161>%</td>
  <td class=xl161>&nbsp;</td>
  <td class=xl161>&nbsp;</td>
  <td class=xl161>&nbsp;</td>
  <td class=xl161>&nbsp;</td>
  <td class=xl161>&nbsp;</td>
  <td class=xl155>&nbsp;</td>
  <td class=xl162>&nbsp;</td>
  <td class=xl163>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
       Decimal ct_operator_qty =0 ;
       Decimal ct_target_qty =0 ;
       Decimal ct_prod_qty =0 ;
       for (int i = 0; i < dt_ct.Rows.Count; i++)
       {
           ct_operator_qty = ct_operator_qty + Convert.ToDecimal(dt_ct.Rows[i]["operator_qty"]);
           ct_target_qty = ct_target_qty + Convert.ToDecimal(dt_ct.Rows[i]["target_qty"]);
           ct_prod_qty = ct_prod_qty + Convert.ToDecimal(dt_ct.Rows[i]["prod_qty"]);
          %>
          
          
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'> <%=dt_ct.Rows[i]["line_id"]%> </td>
  <td class=xl59 x:num><%=dt_ct.Rows[i]["operator_qty"]%></td>
  <td class=xl60 x:num><%=dt_ct.Rows[i]["target_qty"]%></td>
  <td class=xl61>&nbsp;</td>
  <td class=xl62 x:num><%=dt_ct.Rows[i]["prod_qty"]%></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 x:num><%=dt_ct.Rows[i]["prod_qty"]%></td>
  <td class=xl66 x:num><%=dt_ct.Rows[i]["total_rate"]%></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=ct_operator_qty %></td>
  <td class=xl73 x:num><%=ct_target_qty %></td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75 x:num><%=ct_prod_qty %></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl79 x:num><%=ct_prod_qty %></td>
  <td class=xl80 x:num><%=(ct_prod_qty/ct_target_qty) %></td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl164 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl150 colspan=3 style='height:24.95pt;mso-ignore:colspan'>SEWING
  SECTION</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl257>&nbsp;</td>
  <td class=xl259>&nbsp;</td>
  <td class=xl165>&nbsp;</td>
  <td colspan=4 class=xl164 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=42 style='mso-height-source:userset;height:32.1pt'>
  <td height=42 class=xl166 style='height:32.1pt'>M/C</td>
  <td class=xl167>SEWER</td>
  <td class=xl168>TARGET Q'TY</td>
  <td class=xl169>&nbsp;</td>
  <td class=xl157>Prod.Qty</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl171>&nbsp;</td>
  <td class=xl172>Total Prod.</td>
  <td class=xl173>%</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl174>&nbsp;</td>
  <td class=xl175>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
       Decimal sw_operator_qty =0; 
       Decimal sw_target_qty =0;
       Decimal sw_prod_qty =0; 
       for (int i = 0; i < dt_sw.Rows.Count; i++)
       {
          sw_operator_qty = sw_operator_qty + Convert.ToDecimal(dt_sw.Rows[i]["operator_qty"]);  
          sw_target_qty = sw_target_qty + Convert.ToDecimal(dt_sw.Rows[i]["target_qty"]);
          sw_prod_qty = sw_prod_qty + Convert.ToDecimal(dt_sw.Rows[i]["prod_qty"]);
          %>
          
          
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'><%=dt_sw.Rows[i]["line_id"]%></td>
  <td class=xl59 x:num><%=dt_sw.Rows[i]["operator_qty"]%></td>
  <td class=xl60 x:num><%=dt_sw.Rows[i]["target_qty"]%></td>
  <td class=xl61>&nbsp;</td>
  <td class=xl62 x:num><%=dt_sw.Rows[i]["prod_qty"]%></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 x:num><%=dt_sw.Rows[i]["prod_qty"]%></td>
  <td class=xl66 x:num><%=dt_sw.Rows[i]["total_rate"]%></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=sw_operator_qty %></td>
  <td class=xl73 x:num><%=sw_target_qty %></td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75 x:num><%=sw_prod_qty %></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl79 x:num><%=sw_prod_qty %></td>
  <td class=xl80 x:num><%=(sw_prod_qty/sw_target_qty) %></td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl164 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl150 colspan=2 style='height:24.95pt;mso-ignore:colspan'>LABEL
  SECTION</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl151>&nbsp;</td>
  <td class=xl257>&nbsp;</td>
  <td class=xl259>&nbsp;</td>
  <td class=xl176>&nbsp;</td>
  <td colspan=4 class=xl164 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=42 style='mso-height-source:userset;height:32.1pt'>
  <td height=42 class=xl177 style='height:32.1pt'>M/C</td>
  <td class=xl173>LABELER</td>
  <td class=xl168>TARGET Q'TY</td>
  <td class=xl178>&nbsp;</td>
  <td class=xl179>Prod.Q'ty</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl170>&nbsp;</td>
  <td class=xl171>&nbsp;</td>
  <td class=xl172>Total Prod.</td>
  <td class=xl173>%</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl173>&nbsp;</td>
  <td class=xl168>&nbsp;</td>
  <td class=xl180>&nbsp;</td>
  <td class=xl181>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
  <%
    Decimal lb_operator_qty = 0;
    Decimal lb_target_qty = 0;
    Decimal lb_prod_qty = 0;
     for (int i = 0; i < dt_lb.Rows.Count; i++)
     {
          lb_operator_qty = lb_operator_qty + Convert.ToDecimal(dt_lb.Rows[i]["operator_qty"]);
          lb_target_qty = lb_target_qty + Convert.ToDecimal(dt_lb.Rows[i]["target_qty"]);
          lb_prod_qty = lb_prod_qty + Convert.ToDecimal(dt_lb.Rows[i]["prod_qty"]);
          %>
          
          
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'> <%=dt_lb.Rows[i]["line_id"]%></td>
  <td class=xl59 x:num><%=dt_lb.Rows[i]["operator_qty"]%></td>
  <td class=xl60 x:num><%=dt_lb.Rows[i]["target_qty"]%></td>
  <td class=xl61>&nbsp;</td>
  <td class=xl62 x:num><%=dt_lb.Rows[i]["prod_qty"]%></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 x:num><%=dt_lb.Rows[i]["prod_qty"]%></td>
  <td class=xl66 x:num><%=dt_lb.Rows[i]["total_rate"]%></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=lb_operator_qty %></td>
  <td class=xl73 x:num><%=lb_target_qty %></td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75 x:num><%=lb_prod_qty %></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl79 x:num><%=lb_prod_qty %></td>
  <td class=xl80 x:num><%=(lb_prod_qty/lb_target_qty) %></td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl87 style='height:8.1pt'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td colspan=11 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl89 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl82></td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl164 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl182 colspan=3 style='height:24.95pt;mso-ignore:colspan'>PACKING
  SECTION</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl183>&nbsp;</td>
  <td class=xl260>&nbsp;</td>
  <td class=xl176>&nbsp;</td>
  <td colspan=4 class=xl164 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=42 style='mso-height-source:userset;height:32.1pt'>
  <td height=42 class=xl184 style='height:32.1pt'>PACKING</td>
  <td class=xl185>PACKER</td>
  <td class=xl186>TARGET Q'TY</td>
  <td class=xl187>&nbsp;</td>
  <td class=xl188>Prod.Q'ty</td>
  <td class=xl189>&nbsp;</td>
  <td class=xl189>&nbsp;</td>
  <td class=xl189>&nbsp;</td>
  <td class=xl189>&nbsp;</td>
  <td class=xl189>&nbsp;</td>
  <td class=xl189>&nbsp;</td>
  <td class=xl189>&nbsp;</td>
  <td class=xl189>&nbsp;</td>
  <td class=xl185>Total Prod.</td>
  <td class=xl185>%</td>
  <td class=xl185>&nbsp;</td>
  <td class=xl190>&nbsp;</td>
  <td class=xl185>&nbsp;</td>
  <td class=xl185>&nbsp;</td>
  <td class=xl185>&nbsp;</td>
  <td class=xl185>&nbsp;</td>
  <td class=xl191>&nbsp;</td>
  <td class=xl192>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 
  <%
    Decimal pk_operator_qty =0 ;
    Decimal pk_target_qty =0 ;
    Decimal pk_prod_qty =0 ;
    
     for (int i = 0; i < dt_pk.Rows.Count; i++)
     {
        pk_operator_qty = pk_operator_qty + Convert.ToDecimal(dt_pk.Rows[i]["operator_qty"]);
        pk_target_qty = pk_target_qty + Convert.ToDecimal(dt_pk.Rows[i]["target_qty"]);
        pk_prod_qty = pk_prod_qty + Convert.ToDecimal(dt_pk.Rows[i]["prod_qty"]);
          %>
          
          
 <tr class=xl33 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl58 style='height:20.1pt'><%=dt_pk.Rows[i]["line_id"]%> </td>
  <td class=xl59 x:num><%=dt_pk.Rows[i]["operator_qty"]%></td>
  <td class=xl60 x:num><%=dt_pk.Rows[i]["target_qty"]%></td>
  <td class=xl61>&nbsp;</td>
  <td class=xl62 x:num><%=dt_pk.Rows[i]["prod_qty"]%></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65 x:num><%=dt_pk.Rows[i]["prod_qty"]%></td>
  <td class=xl66 x:num><%=dt_pk.Rows[i]["total_rate"]%></td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70 width=165 style='width:124pt'>&nbsp;</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
      %>
 <tr class=xl38 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl71 style='height:24.95pt'>TOTAL</td>
  <td class=xl72 x:num><%=pk_operator_qty %></td>
  <td class=xl73 x:num><%=pk_target_qty %></td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75 x:num><%=pk_prod_qty %></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl79 x:num><%=pk_prod_qty %></td>
  <td class=xl80 x:num><%=(pk_prod_qty/pk_target_qty) %></td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=16 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=16 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=16 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=16 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=16 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=16 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=90 style='width:68pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=151 style='width:113pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=165 style='width:124pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
