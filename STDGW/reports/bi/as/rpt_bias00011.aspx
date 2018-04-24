﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string master_pk = Request.QueryString["master_pk"];
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    DataTable dt = ESysLib.TableReadOpen(str_sql);
    
    DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_bias00010", "'" + master_pk + "'");
    DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_bias00010_1", "'" + master_pk + "'");        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bias00011_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bias00011_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bias00011_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VNG</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2011-11-23T07:41:12Z</o:LastPrinted>
  <o:Created>2011-11-15T06:42:07Z</o:Created>
  <o:LastSaved>2011-11-23T07:41:18Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.31in .24in .2in .28in;
	mso-header-margin:.16in;
	mso-footer-margin:.39in;
	mso-page-orientation:landscape;}
.font7
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font18
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style17
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style20
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
	mso-style-name:Normal_PNAP;}
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
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style20;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style20;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>TRANSFER SLIP</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="9217"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="3"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1249 style='border-collapse:
 collapse;table-layout:fixed;width:939pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=250 style='mso-width-source:userset;mso-width-alt:9142;width:188pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=90 span=2 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=100 span=3 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=64 style='width:48pt'>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 width=43 style='height:15.0pt;width:32pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s3073" type="#_x0000_t75" style='position:absolute;
   margin-left:15pt;margin-top:3pt;width:70.5pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:20px;margin-top:4px;width:94px;
  height:56px'><img width=94 height=56 src="rpt_bias00011_files/image002.jpg"
  v:shapes="_x0000_s3073"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl32 width=43 style='height:15.0pt;width:32pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 width=97 style='width:73pt'></td>
  <td colspan=3 class=xl65 width=390 style='width:294pt'><%=dt.Rows[0]["partner_name"] %></td>
  <td class=xl25 width=90 style='width:68pt'></td>
  <td class=xl27 width=90 style='width:68pt'>Tel: <%=dt.Rows[0]["phone_no"] %></td>
  <td width=80 style='width:60pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s3075" type="#_x0000_t75" style='position:absolute;margin-left:24pt;
   margin-top:1.5pt;width:315.75pt;height:95.25pt;z-index:2' fillcolor="windowText [64]"
   strokecolor="window [65]" strokeweight="3e-5mm" o:insetmode="auto">
   <v:fill color2="window [65]"/>
   <v:imagedata src="rpt_bias00011_files/image003.gif" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:AutoFill>False</x:AutoFill>
    <x:AutoLine>False</x:AutoLine>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:32px;margin-top:2px;width:421px;
  height:127px'><img width=421 height=127 src="rpt_bias00011_files/image003.gif"
  v:shapes="_x0000_s3075"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl25 width=80 style='height:15.0pt;width:60pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl35 width=100 style='width:75pt'></td>
  <td class=xl35 width=100 style='width:75pt'></td>
  <td class=xl35 width=100 style='width:75pt'></td>
  <td class=xl35 width=95 style='width:71pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl64 width=390 style='width:294pt'><%=dt.Rows[0]["addr1"] %></td>
  <td class=xl61></td>
  <td class=xl27>Fax: <%=dt.Rows[0]["fax_no"] %></td>
  <td class=xl25></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl66>Tax No: <%=dt.Rows[0]["tax_code"] %></td>
  <td class=xl25></td>
  <td class=xl33>Print Date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=74 style='mso-height-source:userset;height:55.5pt'>
  <td colspan=7 height=74 class=xl69 style='height:55.5pt'>PHI&#7870;U
  CHUY&#7874;N KHO <font class="font18">(TRANSFER SLIP)</font></td>
  <td class=xl28></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl70 width=140 style='height:22.5pt;width:105pt'>Xu&#7845;t
  <font class="font7">Outgo W/H</font></td>
  <td colspan=3 class=xl74><%=dt1.Rows[0]["out_name"]%></td>
  <td class=xl31>Nh&#7853;p<font class="font7"> In W/H</font></td>
  <td colspan=3 class=xl68><%=dt1.Rows[0]["in_name"]%></td>
  <td colspan=2 class=xl63>S&#7889; phi&#7871;u <font class="font12">Slip No</font></td>
  <td class=xl62 style='border-left:none' x:num><%=dt1.Rows[0]["slip_no"]%></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl70 width=140 style='height:22.5pt;width:105pt'>Di&#7877;n
  gi&#7843;i <font class="font7">Description</font></td>
  <td colspan=3 class=xl67><%=dt1.Rows[0]["description"]%></td>
  <td class=xl31>S&#7889; P/O <font class="font7">P/O No</font></td>
  <td colspan=3 class=xl68><%=dt1.Rows[0]["ref_no"]%></td>
  <td colspan=2 class=xl63>Ngày<font class="font13"> </font><font class="font12">Date</font></td>
  <td class=xl62 style='border-top:none;border-left:none'><%=dt1.Rows[0]["dd"] %>/<%=dt1.Rows[0]["mm"] %>/<%=dt1.Rows[0]["yyyy"] %></td>
  <td class=xl28></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=59 class=xl77 width=43 style='border-bottom:.5pt solid black;
  height:44.25pt;width:32pt'>TT<br>
    <font class="font7">No</font></td>
  <td rowspan=2 class=xl73 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>S&#7889; &#272;&#7889;i chi&#7871;u<br>
    <font class="font7">Ref No</font></td>
  <td rowspan=2 class=xl73 width=90 style='border-bottom:.5pt solid black;
  width:68pt'>Mã hàng<br>
    <font class="font7">Item Code</font></td>
  <td rowspan=2 class=xl73 width=250 style='border-bottom:.5pt solid black;
  width:188pt'>Tên hàng<br>
    <font class="font7">Item Description</font></td>
  <td rowspan=2 class=xl73 width=50 style='border-bottom:.5pt solid black;
  width:38pt'>&#272;VT<br>
    <font class="font7">Unit</font></td>
  <td colspan=2 class=xl73 width=180 style='border-left:none;width:136pt'>S&#7889;
  l&#432;&#7907;ng<font class="font7"> Quantity</font></td>
  <td rowspan=2 class=xl73 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>&#272;&#417;n giá<br>
    <font class="font7">Unit Price</font></td>
  <td rowspan=2 class=xl73 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Thành ti&#7873;n VND<br>
    <font class="font7">Amount</font></td>
  <td rowspan=2 class=xl73 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Thu&#7871; VND<br>
    <font class="font7">Tax Amount</font></td>
  <td rowspan=2 class=xl73 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>T&#7893;ng ti&#7873;n VND<br>
    <font class="font7">Total Amount</font></td>
  <td rowspan=2 class=xl71 width=95 style='border-bottom:.5pt solid black;
  width:71pt'>Ghi chú<br>
    <font class="font7">Remark</font></td>
  <td></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl36 width=90 style='height:26.25pt;border-top:none;
  border-left:none;width:68pt'>Yêu c&#7847;u<br>
    <font class="font7">Req</font></td>
  <td class=xl36 width=90 style='border-top:none;border-left:none;width:68pt'>Th&#7921;c
  xu&#7845;t<br>
    <font class="font7">Actual</font></td>
  <td></td>
 </tr>
 <%
     double total1 = 0, total2 = 0, total3 = 0, total4 = 0, total5 = 0;
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
         total1 = total1 + CommondLib.ConvertToDbl(dt2.Rows[i]["req_qty"]);
         total2 = total2 + CommondLib.ConvertToDbl(dt2.Rows[i]["tr_qty"]);
         total3 = total3 + CommondLib.ConvertToDbl(dt2.Rows[i]["item_amount"]);
         total4 = total4 + CommondLib.ConvertToDbl(dt2.Rows[i]["vat_amount"]);
         total5 = total5 + CommondLib.ConvertToDbl(dt2.Rows[i]["total_amount"]);
            %>
<tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl37 width=43 style='height:30.0pt;border-top:none;
  width:32pt' x:num><%=i+1 %></td>
  <td class=xl38 width=97 style='border-top:none;border-left:none;width:73pt'><%=dt2.Rows[i]["ref_no"]%></td>
  <td class=xl39 width=90 style='border-top:none;border-left:none;width:68pt'
  x:num><%=dt2.Rows[i]["item_code"]%></td>
  <td class=xl40 width=250 style='border-top:none;border-left:none;width:188pt'><%=dt2.Rows[i]["item_name"]%></td>
  <td class=xl39 width=50 style='border-top:none;border-left:none;width:38pt'><%=dt2.Rows[i]["req_uom"]%></td>
  <td class=xl42 width=90 style='border-top:none;border-left:none;width:68pt'
  x:num><%=dt2.Rows[i]["req_qty"]%></td>
  <td class=xl41 width=90 style='border-top:none;border-left:none;width:68pt'
  x:num><%=dt2.Rows[i]["tr_qty"]%></td>
  <td class=xl42 width=80 style='border-top:none;border-left:none;width:60pt'
  x:num><%=dt2.Rows[i]["unit_price"]%></td>
  <td class=xl42 width=100 style='border-top:none;border-left:none;width:75pt'
  x:num><%=dt2.Rows[i]["item_amount"]%></td>
  <td class=xl42 width=100 style='border-top:none;border-left:none;width:75pt'
  x:num><%=dt2.Rows[i]["vat_amount"]%></td>
  <td class=xl41 width=100 style='border-top:none;border-left:none;width:75pt'
  x:num><%=dt2.Rows[i]["total_amount"]%></td>
  <td class=xl43 width=95 style='border-top:none;border-left:none;width:71pt'><%=dt2.Rows[i]["description"]%></td>
  <td></td>
 </tr>
            <% 
     }
      %>
 
 
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=5 height=40 class=xl75 width=530 style='height:30.0pt;width:399pt'>T&#7893;ng
  c&#7897;ng VND <font class="font14">Total</font></td>
  <td class=xl59 width=90 style='border-top:none;width:68pt' x:num><%=total1 %></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%=total2 %></td>
  <td class=xl60 style='border-top:none'>&nbsp;</td>
  <td class=xl59 width=100 style='border-top:none;width:75pt' x:num><%=total3 %></td>
  <td class=xl59 width=100 style='border-top:none;border-left:none;width:75pt'
  x:num><%=total4 %></td>
  <td class=xl59 width=100 style='border-top:none;border-left:none;width:75pt'
  x:num><%=total5 %></td>
  <td class=xl34 style='border-top:none'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=13 style='height:21.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl30 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=5 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=85 style='height:63.75pt;mso-xlrowspan:5'>
  <td height=85 colspan=13 style='height:63.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=43 style='width:32pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
