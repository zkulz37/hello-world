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
    
    DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_bini00050", "'" + master_pk + "'");    
    DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_bini00050_1", "'" + master_pk + "'");        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bini00053_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bini00053_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bini00053_files/oledata.mso">
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
  <o:LastPrinted>2011-11-23T07:03:49Z</o:LastPrinted>
  <o:Created>2011-11-15T06:42:07Z</o:Created>
  <o:LastSaved>2011-11-23T07:03:56Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.44in .31in .59in .38in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;}
.font5
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font14
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
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style20;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl38
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style20;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl43
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
.xl44
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
.xl45
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
.xl46
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
.xl47
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
.xl48
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
.xl49
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
.xl50
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
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	white-space:normal;}
.xl54
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
.xl55
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
.xl56
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
.xl57
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
.xl58
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
.xl59
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
.xl60
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
.xl61
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
.xl62
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl63
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
.xl64
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
.xl65
	{mso-style-parent:style20;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
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
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl74
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
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style20;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl78
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
.xl79
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Outgoing Slip</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
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
  <o:idmap v:ext="edit" data="8"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl42>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1049 style='border-collapse:
 collapse;table-layout:fixed;width:789pt'>
 <col class=xl42 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl42 width=90 span=2 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <col class=xl42 width=280 style='mso-width-source:userset;mso-width-alt:10240;
 width:210pt'>
 <col class=xl42 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl42 width=95 span=2 style='mso-width-source:userset;mso-width-alt:
 3474;width:71pt'>
 <col class=xl42 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl42 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl42 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 width=30 style='height:15.0pt;width:23pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s8193" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:7.5pt;margin-top:3pt;width:80.25pt;
   height:38.25pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:10px;margin-top:4px;width:107px;
  height:51px'><img width=107 height=51 src="rpt_bini00053_files/image002.jpg"
  v:shapes="_x0000_s8193"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl31 width=30 style='height:15.0pt;width:23pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 width=90 style='width:68pt'></td>
  <td class=xl26 colspan=2 align=left width=370 style='mso-ignore:colspan;
  width:278pt'><%=dt.Rows[0]["partner_name"]%></td>
  <td class=xl25 width=50 style='width:38pt'></td>
  <td class=xl25 width=95 style='width:71pt'></td>
  <td class=xl25 width=95 style='width:71pt'></td>
  <td class=xl27 width=100 style='width:75pt'>Tel: <%=dt.Rows[0]["phone_no"]%></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=109 style='width:82pt'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td colspan=4 class=xl69 width=515 style='width:387pt'><%=dt.Rows[0]["addr1"]%></td>
  <td class=xl25></td>
  <td class=xl27>Fax: <%=dt.Rows[0]["fax_no"]%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl32 colspan=2 align=left style='mso-ignore:colspan'>Tax No: <%=dt.Rows[0]["tax_code"]%></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl28>Print Date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl25 style='height:7.5pt'></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=6 rowspan=2 height=50 class=xl70 style='border-right:.5pt hairline black;
  height:37.5pt'>PHI&#7870;U XU&#7844;T KHO<font class="font9"> </font><font
  class="font14">(OUTGOING SLIP)</font></td>
  <td class=xl62 style='border-left:none'>S&#7889; <font class="font7">Slip No</font></td>
  <td class=xl40 style='border-left:none' x:num><%=dt1.Rows[0]["slip_no"] %></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl62 style='height:18.75pt;border-top:none;border-left:
  none'>Ngày<font class="font5"> </font><font class="font7">Date</font></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt1.Rows[0]["dd"] %>/<%=dt1.Rows[0]["mm"] %>/<%=dt1.Rows[0]["yyyy"] %></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl66 width=120 style='height:22.5pt;width:91pt'>Xu&#7845;t
  cho <font class="font7">outgo To</font></td>
  <td colspan=3 class=xl75><%=dt1.Rows[0]["supplier_name"] %></td>
  <td class=xl30 align=left>Kho<font class="font7"> Out WH</font><font
  class="font5"><span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl77><%=dt1.Rows[0]["wh_name"] %></td>
  <td class=xl41></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl29 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl66 width=120 style='height:22.5pt;width:91pt'>Di&#7877;n
  gi&#7843;i <font class="font7">Description</font></td>
  <td colspan=3 class=xl76><%=dt1.Rows[0]["description"] %></td>
  <td class=xl30 align=left>S&#7889; P/O <font class="font7">PO No</font></td>
  <td colspan=2 class=xl65><%=dt1.Rows[0]["ref_no"] %></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=55 class=xl73 width=30 style='border-bottom:.5pt solid black;
  height:41.25pt;width:23pt'>TT<br>
    <font class="font7">No</font></td>
  <td rowspan=2 class=xl72 width=90 style='border-bottom:.5pt solid black;
  width:68pt'>S&#7889; &#272;&#7889;i chi&#7871;u<font class="font5"><br>
    Ref No.</font></td>
  <td rowspan=2 class=xl72 width=90 style='border-bottom:.5pt solid black;
  border-top:none;width:68pt'>Mã hàng<br>
    <font class="font7">Item Code</font></td>
  <td rowspan=2 class=xl72 width=280 style='border-bottom:.5pt solid black;
  border-top:none;width:210pt'>Tên hàng<br>
    <font class="font7">Item Description</font></td>
  <td rowspan=2 class=xl72 width=50 style='border-bottom:.5pt solid black;
  border-top:none;width:38pt'>&#272;VT<br>
    <font class="font7">Unit</font></td>
  <td colspan=2 class=xl72 width=190 style='border-left:none;width:142pt'>S&#7889;
  l&#432;&#7907;ng<font class="font7"> Quantity</font></td>
  <td rowspan=2 class=xl78 width=100 style='border-bottom:.5pt solid black;
  border-top:none;width:75pt'>Ghi chú<br>
    <font class="font7">Remark</font></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl43 width=95 style='height:26.25pt;border-top:none;
  border-left:none;width:71pt'>Yêu c&#7847;u<br>
    <font class="font7">Req</font></td>
  <td class=xl43 width=95 style='border-top:none;border-left:none;width:71pt'>Th&#7921;c
  xu&#7845;t<br>
    <font class="font7">Actual</font></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
    <%
     double total1 = 0, total2 = 0, total3 = 0, total4 = 0, total5 = 0;
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
         total1 = total1 + CommondLib.ConvertToDbl(dt2.Rows[i]["req_qty"]);
         total2 = total2 + CommondLib.ConvertToDbl(dt2.Rows[i]["out_qty"]);
         
         %>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl44 width=30 style='height:33.75pt;border-top:none;
  width:23pt' x:num><%=i+1 %></td>
  <td class=xl45 width=90 style='border-top:none;border-left:none;width:68pt'><%=dt2.Rows[i]["ref_no"]%></td>
  <td class=xl46 width=90 style='border-top:none;border-left:none;width:68pt'
  x:num><%=dt2.Rows[i]["item_code"]%></td>
  <td class=xl47 width=280 style='border-top:none;border-left:none;width:210pt'><%=dt2.Rows[i]["item_name"]%><font class="font5"><br>
    </font><font class="font7"><%=dt2.Rows[i]["item_lname"]%></font></td>
  <td class=xl46 width=50 style='border-top:none;border-left:none;width:38pt'><%=dt2.Rows[i]["out_uom"]%></td>
  <td class=xl48 width=95 style='border-top:none;border-left:none;width:71pt'
  x:num><%=dt2.Rows[i]["req_qty"]%></td>
  <td class=xl48 width=95 style='border-top:none;border-left:none;width:71pt'
  x:num><%=dt2.Rows[i]["out_qty"]%></td>
  <td class=xl49 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt2.Rows[i]["description"]%></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
            <% 
     }
  %>
 
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=5 height=38 class=xl67 width=540 style='height:28.5pt;width:407pt'>T&#7893;ng
  c&#7897;ng<span style='mso-spacerun:yes'>  </span><font class="font12">Total</font></td>
  <td class=xl63 width=95 style='border-top:none;width:71pt' x:num><%=total1 %></td>
  <td class=xl64 align=left style='border-top:none;border-left:none'
  x:num><%=total2 %></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=3 class=xl42 style='height:21.0pt;mso-ignore:colspan'></td>
  <td colspan=5 rowspan=8 height=147 class=xl42 width=620 style='mso-ignore:
  colspan-rowspan;height:110.25pt;width:465pt'><!--[if gte vml 1]><v:shape
   id="_x0000_s8194" type="#_x0000_t75" style='position:absolute;direction:LTR;
   text-align:left;margin-left:147.75pt;margin-top:11.25pt;width:302.25pt;
   height:93pt;z-index:2' fillcolor="windowText [64]" strokecolor="window [65]"
   strokeweight="3e-5mm" o:insetmode="auto">
   <v:fill color2="window [65]"/>
   <v:imagedata src="rpt_bini00053_files/image003.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:AutoFill>False</x:AutoFill>
    <x:AutoLine>False</x:AutoLine>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=197 height=15></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=403 height=124 src="rpt_bini00053_files/image004.gif"
    v:shapes="_x0000_s8194"></td>
    <td width=20></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:465.0pt;height:110.25pt'></span><![endif]--></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl42 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl42 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl42 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl42 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl42 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl42 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl42 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=280 style='width:210pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=109 style='width:82pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
