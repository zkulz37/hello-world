﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("prod");%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string po_pk;
	po_pk	=	Request.QueryString["master_pk"];
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_jain00010", "'" + po_pk + "'");
    dt1 = ESysLib.TableReadOpenCursor("crm.sp_rpt_jain00010_1", "'" + po_pk + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_jain00010_AMB_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jain00010_AMB_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jain00010_AMB_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Trung</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2010-05-19T09:10:18Z</o:LastPrinted>
  <o:Created>2010-05-19T07:56:49Z</o:Created>
  <o:LastSaved>2010-05-19T09:11:15Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl89
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>73</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>-75</x:WindowTopX>
  <x:WindowTopY>945</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1263 style='border-collapse:
 collapse;table-layout:fixed;width:949pt'>
 <col width=29 style='mso-width-source:userset;mso-width-alt:1060;width:22pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:4132;width:85pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=274 style='mso-width-source:userset;mso-width-alt:10020;width:206pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=118 style='mso-width-source:userset;mso-width-alt:4315;width:89pt'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=14 rowspan=4 height=68 width=1263 style='height:51.0pt;
  width:949pt' align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:6.75pt;margin-top:12.75pt;width:65.25pt;height:76.5pt;z-index:1'>
   <v:imagedata src="rpt_jain00010_AMB_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![if gte mso 9]><o:OLEObject Type="Embed" ProgID="PBrush"
   ShapeID="_x0000_s1025" DrawAspect="Content" ObjectID="MBD00BB92DE">
  </o:OLEObject>
 <![endif]><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:9px;margin-top:17px;width:87px;height:102px'><img
  width=87 height=102 src="rpt_jain00010_AMB_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=14 rowspan=4 height=68 class=xl53 width=1263 style='height:
    51.0pt;width:949pt'>PURCHASE REQUEST</td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=2 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl47 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>Requesting
  Department: <%=dt.Rows[0]["pl_nm"]%></td>
  <td colspan=3 rowspan=2 class=xl54 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Expected date of Delivery: 10 days</td>
  <td colspan=3 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>New Request? New</td>
  <td colspan=2 rowspan=2 class=xl54 style='border-bottom:.5pt solid black'>PR
  No. <%=dt.Rows[0]["pr_no"]%></td>
  <td rowspan=4 class=xl60 width=118 style='width:89pt'>Selected Vendor No.1</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=2 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl50 style='border-right:.5pt solid black'>Date of
  Request: <%=dt.Rows[0]["req_date"]%></td>
  <td colspan=3 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>Direct issue? Stock</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 rowspan=2 class=xl54 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Reason of Request : <%=dt.Rows[0]["description"]%></td>
  <td colspan=3 rowspan=2 class=xl54 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Budgeted? Amount</td>
  <td colspan=3 rowspan=2 class=xl54 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Payment terms:</td>
  <td colspan=2 rowspan=2 class=xl54 style='border-bottom:.5pt solid black'>PO
  Reference No. <%=dt.Rows[0]["ref_po_no"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl61 style='border-right:.5pt solid black;
  height:15.0pt'>Managed by Watertree</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td rowspan=2 class=xl63 width=67 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt'>Qty Needed</td>
  <td rowspan=2 class=xl65 style='border-bottom:.5pt solid black;border-top:
  none'>Unit of Measure</td>
  <td rowspan=2 class=xl65 style='border-bottom:.5pt solid black;border-top:
  none'>Item Code</td>
  <td rowspan=2 class=xl65 style='border-bottom:.5pt solid black;border-top:
  none'>Description</td>
  <td rowspan=2 class=xl63 width=71 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt'>Expense Code</td>
  <td rowspan=2 class=xl67 width=79 style='border-bottom:.5pt solid black;
  border-top:none;width:59pt'>Mothly<br>
    Consumption</td>
  <td colspan=2 class=xl25 style='border-right:.5pt solid black'>Qty on Hand</td>
  <td colspan=4 class=xl24 style='border-right:.5pt solid black;border-left:
  none'>Unit Price</td>
  <td rowspan=2 class=xl72 width=118 style='border-bottom:.5pt solid black;
  width:89pt'>Total Amount</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl26 style='height:15.75pt'>No.</td>
  <td class=xl27 x:str="Qty  ">Qty<span style='mso-spacerun:yes'></span></td>
  <td class=xl27>Days</td>
  <td class=xl28>Last Order</td>
  <td class=xl29>Vendor-1</td>
  <td class=xl25>Vendor-2</td>
  <td class=xl29>Vendor-3</td>
 </tr>
 <%
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl30 align=right style='height:19.5pt;border-top:none'x:num><%=i+1 %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["req_qty_01"]%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dt1.Rows[i]["req_uom_01"]%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dt1.Rows[i]["item_code"]%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%=dt1.Rows[i]["item_name"]%></td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 align=right style='border-top:none;border-left:none'x:num><%=dt1.Rows[i]["unit_price"]%></td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 align=right style='border-top:none;border-left:none'x:num><%=dt1.Rows[i]["amount"]%></td>
 </tr>
         <% 
     }
      %>
 <%
     for (int k = 0; k < 15 - dt1.Rows.Count; k++)
     {
         %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl30 style='height:19.5pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
         <% 
     }
  %>
 
 
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl73 style='border-right:1.0pt solid black;
  height:15.0pt'>Requested by:</td>
  <td colspan=6 class=xl74 style='border-right:1.0pt solid black'>Approved by:</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black'>Sub-total</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num >28,500,000</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl46 style='border-right:.5pt solid black;
  height:12.75pt'>Initiator (Name, Position)</td>
  <td class=xl38 style='border-top:none;border-left:none'>Department Head
  (Name)</td>
  <td colspan=2 class=xl25 style='border-right:.5pt solid black'>Controller</td>
  <td colspan=2 class=xl28 style='border-right:.5pt solid black;border-left:
  none'>General Manager</td>
  <td colspan=2 class=xl28 style='border-right:1.0pt solid black;border-left:
  none'>Owner Representative</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black'>VAT</td>
  <td class=xl33 align=right style='border-top:none;border-left:none'
  x:num="2850000" x:fmla="=N23*10%">2,850,000</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=4 rowspan=4 height=104 class=xl76 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:78.0pt'>Signatures:</td>
  <td rowspan=4 class=xl85 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td colspan=2 rowspan=4 class=xl70 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=2 rowspan=4 class=xl24 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=2 rowspan=4 class=xl24 style='border-right:1.0pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black'>sub-total</td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num="31350000" x:fmla="=SUM(N23, N24)">31,350,000</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl44 style='border-right:.5pt solid black;
  height:19.5pt'>Other costs (pl specify)</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl44 style='border-right:.5pt solid black;
  height:19.5pt'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl44 style='border-right:.5pt solid black;
  height:19.5pt'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl76 style='border-right:.5pt solid black;
  height:18.0pt'>Date:</td>
  <td class=xl39 style='border-left:none'>Date:</td>
  <td colspan=2 class=xl98 style='border-right:.5pt solid black;border-left:
  none'>Date:</td>
  <td colspan=2 class=xl98 style='border-right:.5pt solid black'>Date:</td>
  <td colspan=2 class=xl98 style='border-right:.5pt solid black'>Date:</td>
  <td colspan=2 class=xl95 style='border-right:.5pt solid black'>Total Amount</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=14 rowspan=3 height=60 class=xl97 style='height:45.0pt'>Remark:
  Caddie towel serve for golf course</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl40 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Notes:</td>
  <td colspan=12 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl42 colspan=9 style='height:17.25pt;mso-ignore:colspan'>1.
  All Purchase Requests (PR), Expenditure Contracts/Agreements with a value of
  US$25,000 and more require Owner's signatory approval.on the PR / Contract /
  Agreement</td>
  <td colspan=5 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl42 colspan=10 style='height:17.25pt;mso-ignore:colspan'>2.
  All Purchase Requests (PR), Expenditure Contracts/Agreements for a contract
  period of 1 year and more require Owner's signatory approval on the PR /
  Contract / Agreement</td>
  <td colspan=4 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl42 colspan=10 style='height:17.25pt;mso-ignore:colspan'>3.
  All Capex (Capital Expenditure) with a value of US$4,000 and more for each
  item require Owner's approval signatory on the Purchase Request (PR) /
  Purchase Contract / Agreement</td>
  <td colspan=4 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=274 style='width:206pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=118 style='width:89pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>