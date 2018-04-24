﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_master_pk = Request.QueryString["master_pk"];
    string para = "'" + p_master_pk + "'";
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dscd00020");
    dt1 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dscd00020_1", para);
    dt2 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dscd00020_2", para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dscd00020_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dscd00020_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dscd00020_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr.Cuong</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2012-02-14T02:13:06Z</o:LastPrinted>
  <o:Created>2011-10-13T06:18:26Z</o:Created>
  <o:LastSaved>2012-02-14T02:13:48Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&C&P\/&N";
	margin:.49in .39in .79in .53in;
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
.font6
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:black;
	font-size:12.0pt;
	font-weight:400;
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
.style58
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
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 3";}
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
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl68
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style43;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl75
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl76
	{mso-style-parent:style43;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl79
	{mso-style-parent:style43;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl80
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl83
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl84
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl90
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl95
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl98
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
	border-left:none;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl100
	{mso-style-parent:style43;
	font-size:12.0pt;
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
	white-space:normal;}
.xl101
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl102
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl103
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl105
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl106
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl107
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl109
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
.xl110
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
.xl111
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
.xl112
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl115
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl116
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
	border-left:none;}
.xl117
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl118
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl119
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl121
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl127
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl128
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl131
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>yeu cau xuat kho</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>2340</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>40</x:TabColorIndex>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11520</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>165</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='yeu cau xuat kho'!$13:$15</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1127 style='border-collapse:
 collapse;table-layout:fixed;width:846pt'>
 <col class=xl66 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl66 width=267 style='mso-width-source:userset;mso-width-alt:9764;
 width:200pt'>
 <col class=xl66 width=146 style='mso-width-source:userset;mso-width-alt:5339;
 width:110pt'>
 <col class=xl66 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl66 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl68 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl67 width=167 style='mso-width-source:userset;mso-width-alt:6107;
 width:125pt'>
 <col class=xl66 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl66 width=64 span=3 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl106 colspan=2 width=304 style='height:15.75pt;
  mso-ignore:colspan;width:228pt'>Công ty TNHH Dorco Vina</td>
  <td class=xl106 width=146 style='width:110pt'></td>
  <td class=xl66 width=77 style='width:58pt'></td>
  <td class=xl66 width=88 style='width:66pt'></td>
  <td class=xl68 width=71 style='width:53pt'></td>
  <td class=xl67 width=167 style='width:125pt'></td>
  <td class=xl68 width=82 style='width:62pt'></td>
  <td class=xl68 width=64 style='width:48pt'></td>
  <td class=xl66 width=64 style='width:48pt'></td>
  <td class=xl66 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl69 colspan=2 style='height:15.75pt;mso-ignore:colspan'>&#272;&#432;&#7901;ng
  B3, khu B, KCN Ph&#7889; N&#7889;i A</td>
  <td class=xl107>S&#7889;/No: </td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'><%=dt1.Rows[0]["slip_no"]%></td>
  <td class=xl68></td>
  <td class=xl71></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl113 width=304 style='height:15.75pt;
  width:228pt'>Xã Minh H&#7843;i Huy&#7879;n V&#259;n Lâm, H&#432;ng Yên</td>
  <td class=xl107><span style='mso-spacerun:yes'>           
  </span>&#272;&#417;n hàng/PO: </td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'><%=dt1.Rows[0]["ref_no"]%></td>
  <td class=xl68></td>
  <td class=xl72></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'></td>
  <td class=xl74></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl71></td>
  <td colspan=2 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=2 class=xl74 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl76></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=7 height=36 class=xl115 width=853 style='height:27.0pt;
  width:640pt' x:str="PHI&#7870;U YÊU C&#7846;U XU&#7844;T KHO ">PHI&#7870;U
  YÊU C&#7846;U XU&#7844;T KHO<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=7 height=25 class=xl131 style='height:18.75pt'>Ngày/ Date : <%=dt1.Rows[0]["out_dd"]%>/<%=dt1.Rows[0]["out_mm"]%>/<%=dt1.Rows[0]["out_yy"]%></td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl66></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:13.15pt'>
  <td height=17 colspan=2 class=xl81 style='height:13.15pt;mso-ignore:colspan'></td>
  <td class=xl82></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl75></td>
  <td class=xl83></td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'></td>
  <td class=xl85></td>
  <td class=xl66></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=7 height=23 class=xl112 width=853 style='height:17.25pt;
  width:640pt'>&#272;&#417;n
  v&#7883; nh&#7853;n hàng: <%=dt1.Rows[0]["partner_name"]%></td>
  <td colspan=2 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl87></td>
  <td class=xl66></td>
 </tr>
 <tr class=xl78 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=7 height=23 class=xl112 width=853 style='height:17.25pt;
  width:640pt' >&#272;&#7883;a
  ch&#7881;: <%=dt1.Rows[0]["addr1"]%></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl88></td>
  <td class=xl78></td>
 </tr>
 
 <tr class=xl69 height=23 style='mso-height-source:userset;height:17.25pt'>
 <%
     if (dt2.Rows.Count > 0)
     {
         %>
         <td colspan=7 height=23 class=xl112 width=853 style='height:17.25pt;
  width:640pt'>Xu&#7845;t t&#7841;i
  kho: <%=dt2.Rows[0]["wh_name"]%></td>

         <% 
     }
     else
     {
         %>
         <td colspan=7 height=23 class=xl112 width=853 style='height:17.25pt;
  width:640pt'>Xu&#7845;t t&#7841;i
  kho: </td>
         <% 
     }
      %>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td class=xl69></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=7 height=23 class=xl116 style='height:17.25pt' >Ghi
  chú: <%=dt1.Rows[0]["description"]%></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td rowspan=3 height=64 class=xl109 width=37 style='border-bottom:.5pt solid black;
  height:48.0pt;border-top:none;width:28pt'><font class="font9">STT</font><font
  class="font5"><br>
    <span style='mso-spacerun:yes'> </span>No</font></td>
  <td rowspan=3 class=xl109 width=267 style='border-bottom:.5pt solid black;
  border-top:none;width:200pt'>Tên s&#7843;n ph&#7849;m<br>
    <font class="font6">(Product name)</font></td>
  <td rowspan=3 class=xl109 width=146 style='border-bottom:.5pt solid black;
  border-top:none;width:110pt'>Mã s&#7889;<br>
    <font class="font6">(Code)</font></td>
  <td rowspan=3 class=xl109 width=77 style='border-bottom:.5pt solid black;
  border-top:none;width:58pt'>&#272;&#417;n v&#7883; tính<br>
    (<font class="font6">Q.unit)</font></td>
  <td colspan=2 rowspan=3 class=xl126 width=159 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:119pt'>S&#7889; l&#432;&#7907;ng yêu
  c&#7847;u <font class="font10"><span style='mso-spacerun:yes'> </span><br>
    ( Requirement Quantity)</font></td>
  <td rowspan=3 class=xl123 width=167 style='border-bottom:.5pt solid black;
  border-top:none;width:125pt'>Ghi chú<br>
    <font class="font11">( Remarks)</font></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=4 class=xl66 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=2 class=xl66 style='height:21.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl90 style='mso-ignore:colspan'></td>
 </tr>
 <%
     double total = 0;
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
         total = total + CommondLib.ConvertToDbl(dt2.Rows[i]["req_qty"]);
         %>
 <tr class=xl91 height=71 style='mso-height-source:userset;height:53.25pt'>
  <td height=71 class=xl108 width=37 style='height:53.25pt;width:28pt' x:num><%=i+1 %></td>
  <td class=xl92 width=267 style='width:200pt'><%=dt2.Rows[i]["item_name"]%></td>
  <td class=xl93 width=146 style='width:110pt'><%=dt2.Rows[i]["item_code"]%></td>
  <td class=xl94><%=dt2.Rows[i]["uom"]%></td>
  <td colspan=2 class=xl119 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt2.Rows[i]["req_qty"]%></td>
  <td class=xl95><%=dt2.Rows[i]["description"]%></td>
  <td colspan=2 class=xl96 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl91 style='mso-ignore:colspan'></td>
 </tr>
          <% 
     }
  %>
 <tr class=xl70 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl97 width=37 style='height:24.0pt;width:28pt'>&nbsp;</td>
  <td class=xl98 width=267 style='width:200pt'>C&#7897;ng/<font class="font8">
  Total</font></td>
  <td class=xl99 width=146 style='width:110pt'>&nbsp;</td>
  <td class=xl99 width=77 style='width:58pt'>&nbsp;</td>
  <td colspan=2 class=xl121 width=159 style='border-right:.5pt solid black;
  border-left:none;width:119pt'><%=total %></td>
  <td class=xl100 width=167 style='width:125pt'>&nbsp;</td>
  <td colspan=4 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'></td>
  <td class=xl130>Ng&#432;&#7901;i l&#7853;p phi&#7871;u/ Ng&#432;&#7901;i yêu
  c&#7847;u</td>
  <td class=xl66></td>
  <td colspan=2 class=xl114><span style='mso-spacerun:yes'>            
  </span>Th&#7911; kho</td>
  <td class=xl68></td>
  <td class=xl101>Qu&#7843;n lý kho</td>
  <td class=xl89></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl69 style='height:15.75pt'
  x:str="                           "><span style='mso-spacerun:yes'>        
  </span><span style='display:none'><span
  style='mso-spacerun:yes'>                  </span></span></td>
  <td class=xl81>Prepared by/ Requested by</td>
  <td class=xl66></td>
  <td colspan=2 class=xl117><span style='mso-spacerun:yes'>        
  </span>Stock keeper</td>
  <td class=xl68></td>
  <td class=xl105><span style='mso-spacerun:yes'>  </span>Warehouse manager</td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'
  x:str="                            "><span style='mso-spacerun:yes'>        
  </span><span style='display:none'><span
  style='mso-spacerun:yes'>                   </span></span></td>
  <td class=xl130>(Ký, h&#7885; tên- Signature)</td>
  <td class=xl66></td>
  <td colspan=2 class=xl114>(Ký, h&#7885; tên- Signature)</td>
  <td class=xl68></td>
  <td class=xl102><span style='mso-spacerun:yes'>  </span>(Ký, h&#7885; tên-
  Signature)</td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl73 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl73 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl73 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl103 style='height:15.75pt'></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl67></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=267 style='width:200pt'></td>
  <td width=146 style='width:110pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=167 style='width:125pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
