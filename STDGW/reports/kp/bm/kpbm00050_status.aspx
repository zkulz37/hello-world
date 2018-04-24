﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("ec111");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_project_pk = Request["p_project_pk"];
    string l_project_cd = Request["p_project_cd"];
    string l_project_nm = Request["p_project_nm"];
	string l_budget_no  = Request["p_budget_no"];

	string l_parameter = "";
    l_parameter = "'" + l_project_pk + "','" + l_budget_no + "'";
    
	DataTable dt = ESysLib.TableReadOpenCursor("EC111.SP_RPT_KPBM00050_STATUS", l_parameter);
	    
	if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }    
	DataTable dtSum = ESysLib.TableReadOpenCursor("EC111.SP_RPT_KPBM00050_STATUS_SUM", l_parameter);
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpbm00050_status_files/filelist.xml">
<link rel=Edit-Time-Data href="kpbm00050_status_files/editdata.mso">
<link rel=OLE-Object-Data href="kpbm00050_status_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:LastPrinted>2011-07-05T08:58:35Z</o:LastPrinted>
  <o:Created>2011-06-11T02:11:00Z</o:Created>
  <o:LastSaved>2011-07-05T08:59:18Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .33in .5in .49in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
.style22
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2";}
.style24
	{mso-number-format:0%;
	mso-style-name:"Percent 2";}
.style25
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"\C27C\D45C \[0\] 3";}
.style26
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
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"\D45C\C900_monthly project profit\(jun\)-rolling";}
td
	{mso-style-parent:style0;
	padding:0px;
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
.xl28
	{mso-style-parent:style22;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style22;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style22;
	color:windowtext;
	font-size:20.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style22;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style22;
	color:windowtext;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style22;
	color:windowtext;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style22;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style22;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style26;
	color:windowtext;
	font-size:8.0pt;
	font-family:HY\ACAC\ACE0\B515, serif;
	mso-font-charset:129;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#003300;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style26;
	color:windowtext;
	font-size:10.0pt;
	font-family:HY\ACAC\ACE0\B515, serif;
	mso-font-charset:129;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#003300;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style22;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style22;
	color:windowtext;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style25;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CC00;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CC00;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CC00;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style25;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style25;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style25;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style25;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style22;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl64
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CC00;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CC00;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style22;
	color:windowtext;
	font-size:22.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style22;
	color:windowtext;
	font-size:22.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl86
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl87
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style22;
	color:windowtext;
	font-size:22.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style22;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style22;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style26;
	color:windowtext;
	font-size:10.0pt;
	font-family:HY\ACAC\ACE0\B515, serif;
	mso-font-charset:129;
	vertical-align:middle;
	background:#003300;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl96
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style22;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CC00;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style24;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Budget status</x:Name>
    <x:WorksheetOptions>
     <x:StandardWidth>2304</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>75</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:RangeSelection>$A$4:$M$4</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>13830</x:WindowHeight>
  <x:WindowWidth>28800</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Budget status'!$1:$19</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl28>

<table x:str border=0 cellpadding=0 cellspacing=0 width=17330 style='border-collapse:
 collapse;table-layout:fixed;width:12999pt'>
 <col class=xl28 width=31 style='mso-width-source:userset;mso-width-alt:992;
 width:23pt'>
 <col class=xl28 width=13 span=2 style='mso-width-source:userset;mso-width-alt:
 416;width:10pt'>
 <col class=xl28 width=246 style='mso-width-source:userset;mso-width-alt:7872;
 width:185pt'>
 <col class=xl28 width=71 style='mso-width-source:userset;mso-width-alt:2272;
 width:53pt'>
 <col class=xl28 width=78 style='mso-width-source:userset;mso-width-alt:2496;
 width:59pt'>
 <col class=xl28 width=254 style='mso-width-source:userset;mso-width-alt:8128;
 width:191pt'>
 <col class=xl28 width=69 style='mso-width-source:userset;mso-width-alt:2208;
 width:52pt'>
 <col class=xl28 width=195 style='mso-width-source:userset;mso-width-alt:6240;
 width:146pt'>
 <col class=xl28 width=72 style='mso-width-source:userset;mso-width-alt:2304;
 width:54pt'>
 <col class=xl28 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:4000'>
 <col class=xl28 width=251 style='mso-width-source:userset;mso-width-alt:8032;
 width:188pt'>
 <col class=xl28 width=125 style='mso-width-source:userset;mso-width-alt:4000;
 width:94pt'>
 <col class=xl29 width=72 span=221 style='width:54pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=31 style='height:12.75pt;width:23pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_3" o:spid="_x0000_s1025" type="#_x0000_t75"
   alt="newlogo.JPG" style='position:absolute;margin-left:0;margin-top:0;
   width:147pt;height:35.25pt;z-index:1;visibility:visible'>
   <v:imagedata src="kpbm00050_status_files/image001.jpg" o:title="newlogo"/>
   <v:path arrowok="t"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:196px;
  height:47px'><img width=196 height=47
  src="kpbm00050_status_files/image002.jpg" alt=newlogo.JPG v:shapes="Picture_x0020_3"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl28 width=31 style='height:12.75pt;width:23pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl28 width=13 style='width:10pt'></td>
  <td class=xl28 width=13 style='width:10pt'></td>
  <td class=xl28 width=246 style='width:185pt'></td>
  <td class=xl28 width=71 style='width:53pt'></td>
  <td class=xl28 width=78 style='width:59pt'></td>
  <td class=xl28 width=254 style='width:191pt'></td>
  <td class=xl28 width=69 style='width:52pt'></td>
  <td class=xl28 width=195 style='width:146pt'></td>
  <td class=xl28 width=72 style='width:54pt'></td>
  <td class=xl28 width=0></td>
  <td class=xl28 width=251 style='width:188pt'></td>
  <td class=xl28 width=125 style='width:94pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
  <td class=xl29 width=72 style='width:54pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=13 class=xl28 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='height:27.75pt'>
  <td colspan=13 height=37 class=xl82 style='border-right:2.0pt double black;
  height:27.75pt'>WORKING BUDGET STATUS</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl30 style='height:25.5pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl33 colspan=4 style='height:18.0pt;mso-ignore:colspan'
  x:str>PROJECT CODE : <%=l_project_cd %><span style='mso-spacerun:yes'> </span> </td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl89></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl33 colspan=4 style='height:18.0pt;mso-ignore:colspan'>PROJECT
  NAME : <%=l_project_nm %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl90></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl33 style='height:9.0pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td class=xl36>+</td>
  <td class=xl28></td>
  <td class=xl28>CLIENT NAME :</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl91></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl33 style='height:4.5pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl28></td>
  <td class=xl28>REASON TO REVISE :</td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl33 style='height:4.5pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl28></td>
  <td class=xl38 colspan=2 style='mso-ignore:colspan'>HOW WE CAN KEEP PROFIT
  RATE :</td>
  <td colspan=7 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl33 style='height:5.25pt'>&nbsp;</td>
  <td class=xl32></td>
  <td colspan=10 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl39 x:str="Provision for retention  :  ">Provision for
  retention<span style='mso-spacerun:yes'>  </span>:<span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl39>Export proj.</td>
  <td class=xl93 align=right x:num></td>
  <td colspan=2 rowspan=2 class=xl70></td>
  <td class=xl39></td>
  <td class=xl39></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl39>( See the regulation )</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl39>Others</td>
  <td class=xl93 align=right x:num></td>
  <td class=xl39></td>
  <td class=xl39></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl43 style='height:7.5pt'>&nbsp;</td>
  <td colspan=11 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=6 rowspan=2 height=84 class=xl94 style='border-right:.5pt solid black
  border-bottom:.5pt solid black;height:63.0pt'>CONTENTS</td>
  <td colspan=2 class=xl85 width=323 style='border-right:.5pt solid black;border-left:.5pt solid black;
  width:243pt'>ORIGINAL (<%=dtSum.Rows[0]["app_date"].ToString() %>)</td>
  <td colspan=2 class=xl87 width=267 style='border-right:.5pt solid black;
  border-left:.5pt solid black;;width:200pt'>As - is (<%=dtSum.Rows[0]["app_date"].ToString() %>)</td>
  <td class=xl39></td>
  <td colspan=2 class=xl85 width=376 style='border-right:2.0pt double black;
  width:282pt'>FINAL (<%=dtSum.Rows[0]["app_date"].ToString() %>)</td>
  <td colspan=216 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl44 style='border-left:.5pt solid black;height:33.0pt' x:str="AMOUNT ">AMOUNT<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl45>%</td>
  <td class=xl44 x:str="AMOUNT ">AMOUNT<span style='mso-spacerun:yes'> </span></td>
  <td class=xl45>%</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl47 width=251 style='width:188pt' x:str="AMOUNT ">AMOUNT<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl48 width=125 style='width:94pt'>%</td>
  <td colspan=216 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=6 height=32 class=xl74 style='border-right:.5pt solid black;
  height:24.0pt'><span style='mso-spacerun:yes'> </span>I. CONTRACT</td>
  <td class=xl49 x:num><span
  style='mso-spacerun:yes'>                                       
  </span><%=dtSum.Rows[0]["cont_org"].ToString()%></td>
  <td class=xl50 x:num="1">100%</td>
  <td class=xl49 x:num><span
  style='mso-spacerun:yes'>                          </span><%=dtSum.Rows[0]["cont_as"].ToString()%></td>
  <td class=xl50 x:num="1">100%</td>
  <td class=xl51 align=center x:num>#######</td>
  <td class=xl49 x:num><%=dtSum.Rows[0]["cont_final"].ToString()%></td>
  <td class=xl104 style='border-top:none' x:num="1">100%</td>
  <td colspan=216 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=0 style='mso-height-source:userset;height:0.0pt'>
  <td colspan=6 height=0 class=xl77 style='border-right:.5pt solid black;
  height:0.0pt'><span style='mso-spacerun:yes'> </span>II. DIRECT COST</td>
  <td class=xl52 x:num><span
  style='mso-spacerun:yes'> </span><%=dtSum.Rows[0]["sum_org"].ToString() %></td>
  <td class="xl53" x:num x:fmla="=G21/G20"></td>
  <td class=xl52 x:num><span
  style='mso-spacerun:yes'> </span><%=dtSum.Rows[0]["sum_as"].ToString() %></td>
  <td class=xl53 x:num="0.5" x:fmla="=I21/I20">50.00%</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl52 x:num><span
  style='mso-spacerun:yes'> </span><%=dtSum.Rows[0]["sum_final"].ToString() %></td>
  <td class=xl105 x:num x:fmla="=L21/I20"></td>
  <td colspan=216 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <%
    string _space = "", strBegin = "", strEnd = "";
    double per = 0, per_as = 0, per_final = 0;
     
	for(int row = 0; row < dt.Rows.Count; row++)
	{
	    strBegin = "";
	    strEnd = "";
	    
	    if(dt.Rows[row]["leaf_yn"].ToString()=="F")
		 {
			strBegin = "<b>";
			strEnd = "</b>";
		 }
		 
	    _space = "";
	    
	    switch(dt.Rows[row]["undertakelevel"].ToString())
		   {
			 case "2":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "3":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "4":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "5":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "6":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "7":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "8":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "9":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "10":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
           }

           per = 0;
           per = double.Parse(dt.Rows[row]["amt_org"].ToString()) / double.Parse(dtSum.Rows[0]["cont_org"].ToString());

           per_as = 0;
           per_as = double.Parse(dt.Rows[row]["amt_as"].ToString()) / double.Parse(dtSum.Rows[0]["cont_as"].ToString());

           per_final = 0;
           per_final = double.Parse(dt.Rows[row]["amt_final"].ToString()) / double.Parse(dtSum.Rows[0]["cont_final"].ToString());
 %>
 <tr class=xl39 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl55 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl80 style='border-right:.5pt solid black'><%=strBegin%><%=_space%><%=dt.Rows[row]["level_name"].ToString()%><%=strEnd%></td>
  <td class=xl56 x:num><%=strBegin%><%=dt.Rows[row]["amt_org"].ToString()%><%=strEnd%></td>
  <td class=xl57 x:num><%=strBegin%><%=per%><%=strEnd%></td>
  <td class=xl56 x:num><%=strBegin%><%=dt.Rows[row]["amt_as"].ToString()%><%=strEnd%></td>
  <td class=xl58 x:num><%=strBegin%><%=per_as%><%=strEnd%></td>
  <td class=xl59 x:num>hide</td>
  <td class=xl56 x:num><%=strBegin%><%=dt.Rows[row]["amt_final"].ToString()%><%=strEnd%></td>
  <td class=xl105 x:num><%=strBegin%><%=per_final%><%=strEnd%></td>
  <td colspan=216 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }
 %>
 <tr class=xl39 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=6 height=32 class=xl101 style='border-right:.5pt solid black;
  height:24.0pt'><span style='mso-spacerun:yes'> </span>V. Net Profit</td>
  <td class=xl60 x:num x:fmla="=G20-G21"><span style='mso-spacerun:yes'> </span></td>
  <td class=xl61 x:num x:fmla="=(G20-G21)/G20"></td>
  <td class=xl60 x:num x:fmla="=I20-I21"><span style='mso-spacerun:yes'> </span></td>
  <td class=xl61 x:num x:fmla="=(I20-I21)/I20"></td>
  <td class=xl62 x:num ></td>
  <td class=xl60 x:num x:fmla="=L20-L21"><span style='mso-spacerun:yes'> </span></td>
  <td class=xl106 x:num x:fmla="=(L20-L21)/L20"></td>
  <td colspan=216 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>&nbsp;</td>
  <td colspan=11 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>&nbsp;</td>
  <td colspan=11 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=0 style='display:none'>
  <td class=xl40>&nbsp;</td>
  <td colspan=11 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=0 style='display:none'>
  <td class=xl40>&nbsp;</td>
  <td colspan=11 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=0 style='display:none'>
  <td class=xl40>&nbsp;</td>
  <td colspan=11 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=0 style='display:none'>
  <td class=xl40>&nbsp;</td>
  <td colspan=11 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl40 style='height:16.5pt'>&nbsp;</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl70>Prepared by</td>
  <td class=xl70></td>
  <td class=xl39></td>
  <td colspan=2 class=xl70>Checked by</td>
  <td colspan=2 class=xl70>Reviewed by</td>
  <td class=xl39></td>
  <td colspan=2 class=xl70 style='border-right:2.0pt double black'>Approval by</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl40 style='height:16.5pt'>&nbsp;</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl70>PM ENGINNEER</td>
  <td class=xl70></td>
  <td class=xl39></td>
  <td colspan=2 class=xl70>TEAM LEADER</td>
  <td colspan=2 class=xl70>GROUP LEADER</td>
  <td class=xl39></td>
  <td colspan=2 class=xl73 style='border-right:2.0pt double black'>GENERAL
  DIRECTOR</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl40 style='height:16.5pt'>&nbsp;</td>
  <td colspan=11 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl63>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl40 style='height:16.5pt'>&nbsp;</td>
  <td colspan=11 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl63>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl40 style='height:16.5pt'>&nbsp;</td>
  <td colspan=10 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='border-right:2.0pt double black'></td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl40 style='height:16.5pt'>&nbsp;</td>
  <td colspan=6 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl93></td>
  <td class=xl70></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl64>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=6 height=22 class=xl72 style='height:16.5pt'>&nbsp;</td>
  <td class=xl39></td>
  <td class=xl93></td>
  <td colspan=3 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl65>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl66 style='height:16.5pt'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td colspan=221 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=13 class=xl28 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=221 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=246 style='width:185pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=254 style='width:191pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=0></td>
  <td width=251 style='width:188pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>