﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_master_pk = Request.QueryString["master_pk"];
    string para = "'" + p_master_pk + "'";
    DataTable  dt1, dt2;
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_fppr00182_dorco", para);
    dt2 = ESysLib.TableReadOpenCursor("lg_rpt_fppr00182_1_dorco", para);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00022_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00022_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00022_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr.Cuong</o:Author>
  <o:LastAuthor>Windows User</o:LastAuthor>
  <o:LastPrinted>2011-11-30T08:13:21Z</o:LastPrinted>
  <o:Created>2011-10-13T06:18:26Z</o:Created>
  <o:LastSaved>2011-12-01T08:22:41Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&C&P\/&N";
	margin:.38in .32in .79in .51in;
	mso-header-margin:.2in;
	mso-footer-margin:.31in;}
.font5
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;}
.xl28
	{mso-style-parent:style16;
	font-size:12.0pt;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl39
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style16;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl42
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl52
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:left;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl70
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl72
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:top;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl74
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	text-align:left;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl87
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl89
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl90
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl92
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
    <x:Name>Nhap kho</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>2340</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>10</x:TabColorIndex>
     <x:Zoom>70</x:Zoom>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11640</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Nhap kho'!$13:$16</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1230 style='border-collapse:
 collapse;table-layout:fixed;width:925pt'>
 <col class=xl24 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl24 width=209 style='mso-width-source:userset;mso-width-alt:7643;
 width:157pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl25 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=162 style='mso-width-source:userset;mso-width-alt:5924;
 width:122pt'>
 <col class=xl24 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl24 width=64 span=4 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl76 width=311 style='height:15.75pt;
  width:234pt'>Công ty TNHH Dorco Vina</td>
  <td class=xl24 width=68 style='width:51pt'></td>
  <td class=xl24 width=86 style='width:65pt'></td>
  <td class=xl25 width=73 style='width:55pt'></td>
  <td class=xl27 width=83 style='width:62pt'></td>
  <td class=xl28 width=94 style='width:71pt'><span
  style='mso-spacerun:yes'> </span>Mẫu số:02</td>
  <td class=xl27 width=162 style='width:122pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl77 style='height:15.75pt'>Đường B3, khu B,
  KCN Phố Nối A</td>
  <td class=xl30>Số/No:<%= dt1.Rows[0]["SLIP_NO"]%></td>
  <td class=xl30></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>QĐ số:15/2006/QĐ/BTC</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl78 width=311 style='height:15.75pt;
  width:234pt'>Xã Minh Hải Huyện Văn Lâm, Hưng Yên</td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>Đơn hàng/PO:<%= dt1.Rows[0]["REF_NO"]%></td>
  <td class=xl25></td>
  <td class=xl32></td>
  <td class=xl33 colspan=2 style='mso-ignore:colspan'>Decree No 15/2006/QĐ/BTC</td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl34 style='height:18.0pt'></td>
  <td class=xl35></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>Ngày 20/3/2006 của Bộ
  trưởng BTC</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl35 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=4 rowspan=2 class=xl79>PHIẾU XUẤT KHO</td>
  <td class=xl36></td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan'>Dated Mar,20th,2006 of
  Financial Ministry</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl38 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl39></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl40 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl80><span style='mso-spacerun:yes'>             
  </span>Ngày/ Date:</td>
  <td colspan=2 class=xl81><%= dt1.Rows[0]["PROD_DATE"]%></td>
  <td class=xl40></td>
  <td class=xl41></td>
  <td class=xl42></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl43 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl44></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td class=xl45></td>
  <td class=xl46></td>
  <td class=xl47></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:19.15pt'>
  <td colspan=6 height=25 class=xl82 width=538 style='height:19.15pt;
  width:405pt'>Đơn vị giao hàng :<%= dt1.Rows[0]["LINE_NAME"]%></td>
  <td class=xl48 colspan=2 style='mso-ignore:colspan'>Loại tiền(Curency):</td>
  <td class=xl50></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:19.15pt'>
  <td colspan=2 height=25 class=xl82 width=238 style='height:19.15pt;
  width:179pt'>Địa chỉ :</td>
  <td colspan=3 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl52></td>
  <td class=xl45 colspan=2 style='mso-ignore:colspan'>Tỷ giá(Exchange rate):</td>
  <td class=xl54></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:19.15pt'>
  <td colspan=9 height=25 class=xl48 style='height:19.15pt'>Nhập tại kho:<%= dt1.Rows[0]["WH_NAME"]%></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:19.15pt'>
  <td colspan=9 height=25 class=xl83 width=877 style='height:19.15pt;
  width:660pt'>Lý do nhập:<%= dt1.Rows[0]["DESCRIPTION"]%></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td rowspan=3 height=108 class=xl85 width=29 style='border-bottom:.5pt solid black;
  height:81.0pt;border-top:none;width:22pt'>Stt<br>
    <span style='mso-spacerun:yes'> </span>No</td>
  <td rowspan=3 class=xl85 width=209 style='border-bottom:.5pt solid black;
  border-top:none;width:157pt'>Tên vật tư<br>
    <font class="font8">(Material name)</font></td>
  <td rowspan=3 class=xl85 width=73 style='border-bottom:.5pt solid black;
  border-top:none;width:55pt'>Mã số<br>
    <font class="font8">(Code)</font></td>
  <td rowspan=3 class=xl85 width=68 style='border-bottom:.5pt solid black;
  border-top:none;width:51pt'>Đơn vị tính<br>
    (<font class="font8">Q.unit)</font></td>
  <td rowspan=3 class=xl85 width=86 style='border-bottom:.5pt solid black;
  border-top:none;width:65pt'>Số lượng nhập kho (Actual input Quantity)</td>
  <td rowspan=3 class=xl88 width=73 style='border-bottom:.5pt solid black;
  border-top:none;width:55pt'>Đơn giá<br>
    <font class="font8">(Unit price)<br>
    USD</font></td>
  <td rowspan=3 class=xl85 width=83 style='border-bottom:.5pt solid black;
  border-top:none;width:62pt'>Đơn giá<br>
    <font class="font8">(Unit price)<br>
    VNĐ</font></td>
  <td rowspan=3 class=xl91 width=94 style='border-bottom:.5pt solid black;
  border-top:none;width:71pt' x:str="Thuế nhập khẩu"><span
  style='mso-spacerun:yes'> </span>Thuế nhập khẩu<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl85 width=162 style='border-bottom:.5pt solid black;
  border-top:none;width:122pt'>Thành tiền<br>
    <span style='mso-spacerun:yes'> </span><font class="font8">(VNDAmount)</font></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 colspan=5 class=xl24 style='height:27.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 colspan=5 class=xl24 style='height:27.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:16.15pt'>
  <td height=21 class=xl55 width=29 style='height:16.15pt;width:22pt'>A</td>
  <td class=xl56 width=209 style='width:157pt'>B</td>
  <td class=xl56 width=73 style='width:55pt'>C</td>
  <td class=xl56 width=68 style='width:51pt'>D</td>
  <td class=xl56 width=86 style='width:65pt' x:num>1</td>
  <td class=xl57 width=73 style='width:55pt' x:num>2</td>
  <td class=xl56 width=83 style='width:62pt' x:num>3</td>
  <td class=xl57 width=94 style='width:71pt' x:num>4</td>
  <td class=xl56 width=162 style='width:122pt' x:num>5</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
	double total=0;
	for(int i=0;i<dt2.Rows.Count;i++)
	{
		total= total + CommondLib.ConvertToDbl(dt2.Rows[i]["out_qty"]);
	%>
 <tr height=83 style='mso-height-source:userset;height:62.25pt'>
  <td height=83 class=xl58 width=29 style='height:62.25pt;width:22pt'><%= i+1%></td>
  <td class=xl59 width=209 style='width:157pt'><%= dt2.Rows[i]["item_name"] %>
  <font class="font8"><%= dt2.Rows[i]["item_lname"] %></font><font class="font5"><span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl60 width=73 style='width:55pt'><%= dt2.Rows[i]["item_code"]%></td>
  <td class=xl60 width=68 style='width:51pt'><%= dt2.Rows[i]["OUT_uom"]%></td>
  <td class=xl61 width=86 style='width:65pt' x:num><%= dt2.Rows[i]["OUT_qty"]%></td>
  <td class=xl62 width=73 style='width:55pt'></td>
  <td class=xl63 width=83 style='width:62pt'></td>
  <td class=xl64></td>
  <td class=xl65 width=162 style='width:122pt'></td>
  <td class=xl66></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
	}
 %>
 <tr class=xl30 height=45 style='mso-height-source:userset;height:34.15pt'>
  <td height=45 class=xl67 width=29 style='height:34.15pt;width:22pt'></td>
  <td class=xl68 width=209 style='width:157pt'>Cộng/<font class="font14"> Total</font></td>
  <td class=xl69 width=73 style='width:55pt'></td>
  <td class=xl69 width=68 style='width:51pt'></td>
  <td class=xl68 width=86 style='width:65pt'x:num><%=total%></td>
  <td class=xl70 width=73 style='width:55pt'></td>
  <td class=xl71 width=83 style='width:62pt'></td>
  <td class=xl70 width=94 style='width:71pt'></td>
  <td class=xl70 width=162 style='width:122pt'></td>
  <td colspan=5 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl73 style='height:15.75pt'><span
  style='mso-spacerun:yes'>  </span>Người lập phiếu</td>
  <td colspan=2 class=xl73>Người giao</td>
  <td class=xl24></td>
  <td colspan=2 class=xl74>Thủ kho/Người nhận</td>
  <td class=xl74></td>
  <td class=xl73>Quản lý kho</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl73 style='height:15.75pt'>Prepared by</td>
  <td colspan=2 class=xl73>Deliver</td>
  <td class=xl24></td>
  <td colspan=2 class=xl74>Stock keeper/Receiver</td>
  <td class=xl31></td>
  <td class=xl73>Warehouse manager</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl73 style='height:15.75pt'>(Ký, họ tên-
  Signature)</td>
  <td colspan=2 class=xl73>(Ký, họ tên- Signature)</td>
  <td class=xl24></td>
  <td colspan=2 class=xl74>(Ký, họ tên- Signature)</td>
  <td class=xl74></td>
  <td class=xl73>(Ký, họ tên- Signature)</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl34 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl34 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl34 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl75 style='height:15.75pt'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=209 style='width:157pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=162 style='width:122pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
