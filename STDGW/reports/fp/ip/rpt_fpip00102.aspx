<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string saleorderpk="";
    saleorderpk=Request.QueryString["saleorderpk"];
    //saleorderpk = "2";
    DataTable dt;
    string sql = "select * from prod.WI_PROD_CARD a where a.del_if=0 and ref_table_name = 'PP_ORDPLAND' and a.REF_TABLE_PK ='" + saleorderpk + "'";
    dt = ESysLib.TableReadOpen(sql);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="report_s&amp;j_new_files/filelist.xml">
<link rel=Edit-Time-Data href="report_s&amp;j_new_files/editdata.mso">
<link rel=OLE-Object-Data href="report_s&amp;j_new_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Window XP Service Pack 2</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2010-04-29T07:15:07Z</o:LastPrinted>
  <o:Created>2008-01-28T02:29:49Z</o:Created>
  <o:LastSaved>2010-04-29T07:15:26Z</o:LastSaved>
  <o:Company>Microsoft</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.78in .16in .45in .18in;
	mso-header-margin:.28in;
	mso-footer-margin:.56in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
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
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl64
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	color:black;}
.xl72
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]mmmm\\ d\\\,\\ yyyy\;\@";
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl81
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid black;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl101
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl102
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl103
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl104
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:1.0pt solid windowtext;}
.xl108
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl109
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl110
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl112
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:2.0pt double windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl113
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid black;}
.xl114
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl115
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl116
	{mso-style-parent:style0;
	color:black;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid black;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl117
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl118
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl119
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl120
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl121
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid black;}
.xl122
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl123
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl124
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl125
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl126
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl127
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl128
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl129
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl130
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl131
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl132
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl133
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl134
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl135
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl136
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl137
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid black;}
.xl138
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl139
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl140
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl141
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;}
.xl142
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:none;}
.xl143
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:none;}
.xl144
	{mso-style-parent:style0;
	color:black;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid black;
	border-left:none;}
.xl145
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>83</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>39</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>54</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
	<x:PageBreaks>
     <x:RowBreaks>
     <% 
        int irow=0;
        for(int k=0; k<dt.Rows.Count;k++) 
        {
        irow=irow+55;
     %> 
      <x:RowBreak>
       <x:Row><%=irow %></x:Row>
      </x:RowBreak>
      <%} %> 
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>26</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5175</x:WindowHeight>
  <x:WindowWidth>12030</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=863 style='border-collapse:
 collapse;table-layout:fixed;width:649pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=20 style='mso-width-source:userset;mso-width-alt:731;width:15pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=137 style='mso-width-source:userset;mso-width-alt:5010;width:103pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=44 style='mso-width-source:userset;mso-width-alt:1609;width:33pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=129 style='mso-width-source:userset;mso-width-alt:4717;width:97pt'>
 
  <%
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=6 height=31 class=xl77 width=451 style='height:23.25pt;
  width:339pt'>S &amp; J HOSIERY (VIETNAM) CO.,LTD.</td>
  <td class=xl24 width=72 style='width:54pt'>EX. FAC.:</td>
  <td colspan=2 class=xl79 width=137 style='width:103pt'><%=dt.Rows[i]["ATT05"]%></td>
  <td class=xl24 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl25 width=129 style='width:97pt'>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl26 style='height:20.1pt'>S&amp;J Order #:</td>
  <td colspan=2 class=xl80><%=dt.Rows[i]["REF_PO_NO"]%></td>
  <td class=xl27>Article #:</td>
  <td class=xl29><%=dt.Rows[i]["STYLE_ID"]%></td>
  <td class=xl28></td>
  <td class=xl30>Desc.:</td>
  <td colspan=3 class=xl81><%=dt.Rows[i]["STYLE_NAME"]%></td>
  <td class=xl31>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl26 style='height:20.1pt'>Buyer Order #:</td>
  <td colspan=2 class=xl80><%=dt.Rows[i]["ATT01"]%></td>
  <td class=xl27>Order Qty:</td>
  <td class=xl32 x:num><%=dt.Rows[i]["ORDER_QTY"]%></td>
  <td class=xl28></td>
  <td class=xl30>Colorway:</td>
  <td colspan=2 class=xl33><%=dt.Rows[i]["SPEC02"]%></td>
  <td class=xl34>SIZE:</td>
  <td class=xl35><%=dt.Rows[i]["SPEC03"]%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl26 style='height:20.1pt'>Foot/Shaft/Rim:</td>
  <td colspan=2 class=xl82><%=dt.Rows[i]["ATT03"]%></td>
  <td class=xl27>Link Type:</td>
  <td class=xl33><%=dt.Rows[i]["ATT02"]%></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37>Card Qty:</td>
  <td colspan=2 class=xl83><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl34>NDL.:</td>
  <td class=xl38><%=dt.Rows[i]["ATT04"]%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=5 height=19 class=xl84 style='height:14.25pt'>Printed by Knitting
  Department</td>
  <td colspan=6 class=xl86 style='border-right:1.0pt solid black'>Card <%=dt.Rows[i]["CARD_SEQ"]%> of <%=dt.Rows[i]["ATT06"]%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl88 style='border-right:.5pt solid black;
  height:13.5pt'>DEFECT LIST</td>
  <td class=xl39>Ins_ID#:</td>
  <td class=xl40>Pairing</td>
  <td class=xl40>DEFECT LIST</td>
  <td class=xl39>Inspection</td>
  <td class=xl40>Pairing</td>
  <td class=xl41>SECTION</td>
  <td class=xl42>ID #</td>
  <td class=xl43>M/C#</td>
  <td class=xl44>TL GOOD</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Missing Logo</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl45>Yarn Prob./Offshade</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>KNITTING</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Missing Design</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl45>Incorrect color</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>LINKING</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Missing Terry</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl45>Loose Stitches</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>INSPEC.</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Twisted Rubber</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Dropstitch</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>PRE-SET</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Misaligned Logo</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Incorrect yarn count</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>WASHING</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Plating</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Washing Oil</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>SETTING</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Needle Defect</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Damage</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>PAIRING</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Stripping-Body</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>W/Ears Looping</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>SEWING</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Stripping-H/T</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Bad Looping</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>LABELING</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Excess Yarn</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Dirty Looping</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl27>PACKING</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Cut Yarn</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Incorrect Looping yarn</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Holes in Welt</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Bad Mending</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td colspan=4 rowspan=2 class=xl92 style='border-right:1.0pt solid black;
  border-bottom:.5pt solid black'><%=dt.Rows[i]["CARD_ID"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Holes in Rubber</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Damage Linking</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Holes in Heel</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>Mending Toe</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td colspan=4 rowspan=3 class=xl98 style='border-right:1.0pt solid black;
  border-bottom:.5pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl90 style='border-right:.5pt solid black;
  height:15.0pt'>Holes in Toe</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>No Pair</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl107 style='border-right:.5pt solid black;
  height:15.0pt'>Holes in Foot</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>Re-Setting</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl109 style='height:16.5pt'>Labelling Shift:</td>
  <td colspan=3 class=xl111 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl113 style='border-left:none'>Packing Shift:</td>
  <td colspan=4 class=xl115 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Card Qty:</td>
  <td class=xl65 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl66>Labeler ID#:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>Card Qty:</td>
  <td class=xl68 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl66>&nbsp;</td>
  <td colspan=2 class=xl117>Packer_ID#:</td>
  <td class=xl69>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Date Start:</td>
  <td class=xl70>&nbsp;</td>
  <td class=xl65>Date Finish:</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl67>M/C# :</td>
  <td class=xl66>Date Start:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td colspan=2 class=xl117>Date Finish:</td>
  <td class=xl69>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl118 style='height:15.0pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl119 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl121 style='border-left:none'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl122 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=55 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;height:41.85pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl132 style='border-right:.5pt solid black;
  height:16.5pt'>Pairing Shift:</td>
  <td colspan=3 class=xl134 style='border-right:1.0pt solid black;border-left:
  none'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl137 style='border-left:none'>Sewing Shift:</td>
  <td colspan=4 class=xl135 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Card Qty:</td>
  <td class=xl68 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl66>Pairer_ID#:</td>
  <td class=xl63></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl66>Card Qty:</td>
  <td class=xl68 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl66>Optr_ID#:</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl66>Mach No:</td>
  <td class=xl73>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Date Start:</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl66>Date Finish:</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl66>Date Start:</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl65>Date Finish:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl118 style='height:15.0pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl122 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl121 style='border-left:none'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl122 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=55 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;height:41.85pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl132 style='height:16.5pt'>Washing Shift:</td>
  <td colspan=3 class=xl139 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl137 style='border-right:.5pt solid black;border-left:
  none'>Setting Shift:</td>
  <td colspan=4 class=xl134 style='border-right:1.0pt solid black;border-left:
  none'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Card Qty:</td>
  <td class=xl68 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl66>Washer :</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>Card Qty:</td>
  <td class=xl68 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl76>Oprt_ID#:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>M/C # :</td>
  <td class=xl69>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Date Start:</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl66>Date Finish:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl66>Date Start:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>Date Finish:</td>
  <td class=xl63></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl118 style='height:15.0pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl122 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl121 style='border-left:none'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl122 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=51 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;height:38.85pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=2 height=26 class=xl132 style='height:20.1pt'>Inspection Shift:</td>
  <td colspan=3 class=xl135 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl137 style='border-left:none'>Pre-Setting Shift:</td>
  <td colspan=4 class=xl135 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Card Qty:</td>
  <td class=xl68 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td colspan=2 class=xl74>Inspection_ID#:</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>Card Qty:</td>
  <td class=xl68 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl66>Oprt_ID#:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>M/C # :</td>
  <td class=xl69>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Date Start:</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl66>Date Finish:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl66>Date Start:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>Date Finish:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl118 style='height:15.0pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl122 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl121 style='border-left:none'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl122 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=56 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;height:42.6pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl132 style='height:15.0pt'>Knitting Shift:</td>
  <td colspan=3 class=xl135 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
  <td colspan=2 class=xl137 style='border-left:none'>Linking Shift:</td>
  <td colspan=4 class=xl135 style='border-right:1.0pt solid black'><%=dt.Rows[i]["ref_po_no"]%> / <%=dt.Rows[i]["STYLE_ID"]%> / <%=dt.Rows[i]["SPEC02"]%> / <%=dt.Rows[i]["SPEC03"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Card Qty:</td>
  <td class=xl68 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl66>M/C#</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl69>Hand Linking</td>
  <td class=xl66>Card Qty:</td>
  <td class=xl68 x:num><%=dt.Rows[i]["CARD_QTY"]%></td>
  <td class=xl66>M/C#</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=2 class=xl117 style='border-right:1.0pt solid black'>Hand Linking</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Date Start:</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl66>Date Fin:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl69>B-Grade:</td>
  <td class=xl66>Date Start:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>Date Fin:</td>
  <td class=xl66>&nbsp;</td>
  <td colspan=2 class=xl117 style='border-right:1.0pt solid black'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'>Oprt ID#:</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl66>Q/C:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl69>C-Grade:</td>
  <td class=xl66>Oprt ID#:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>Reverser:</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl118 style='height:15.0pt'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=2 class=xl122 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
  <td colspan=3 class=xl121 style='border-left:none'><%=dt.Rows[i]["CARD_ID"]%></td>
  <td colspan=3 class=xl122 style='border-right:1.0pt solid black'>Card <%=i+1%> of <%=dt.Rows[i]["ATT06"]%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=5 rowspan=2 height=58 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;height:44.1pt'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
  <td colspan=6 rowspan=2 class=xl124 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black'>*<%=dt.Rows[i]["CARD_ID"]%>*</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl71 style='height:24.0pt'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl71 style='height:24.0pt'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
  <% 
        } 
     %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=99 style='width:74pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=129 style='width:97pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
