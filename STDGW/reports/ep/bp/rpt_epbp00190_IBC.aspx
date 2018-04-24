<%@ page language="C#" %>

<%@ import namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
   											  
    string p_master_pk = Request.QueryString["p_master_pk"];
    string para = "'" + p_master_pk + "'";
    
    DataTable dt,dt1, dt2;
    
    dt  = ESysLib.TableReadOpenCursor("lg_rpt_epbp00190_2");
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00190", para);
    dt2 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00190_1", para);
    if(dt1.Rows.Count==0)
    {
        Response.Write("There is no data.");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="epbp00190_files/filelist.xml">
<link rel=Edit-Time-Data href="epbp00190_files/editdata.mso">
<link rel=OLE-Object-Data href="epbp00190_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2012-01-18T06:40:21Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-01-18T06:44:43Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&L&G&CPage &P of &N";
	margin:.33in .3in .31in .3in;
	mso-header-margin:.26in;
	mso-footer-margin:.38in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font8
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font17
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
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
.style22
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:ë‹ì›€, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl25
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl33
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.1pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl41
	{mso-style-parent:style22;
	color:black;
	font-size:10.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	font-weight:700;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.1pt dashed windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:none;
	border-bottom:.1pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	font-weight:700;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.1pt dashed windowtext;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl51
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl57
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:none;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt dashed windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.1pt dashed windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.1pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl63
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt dashed windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl64
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl65
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl67
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl68
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl69
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl70
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl71
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl72
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	 
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	 
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	 
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:800;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl82
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.1pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl86
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl87
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl89
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl90
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt dashed windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.1pt dashed windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl92
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.1pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl93
	{mso-style-parent:style22;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.1pt dashed windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.1pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl194
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}	

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
      <x:Scale>91</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8745</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$11</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table border=0 cellpadding=0 cellspacing=0 width=1308 style='border-collapse:
 collapse;table-layout:fixed;width:982pt'>
 <col class=xl66 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl66 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl66 width=116 style='mso-width-source:userset;mso-width-alt:4242;
 width:87pt'>
 <col class=xl66 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl66 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl66 width=145 span=4 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col class=xl66 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl66 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl66 width=173 style='mso-width-source:userset;mso-width-alt:6326;
 width:130pt'>
 <tr class=xl26 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=2 rowspan=3 height=20 class=xl82 width=155 style='border-bottom:
  2.0pt double black;height:15.0pt;width:116pt'><!--[if gte vml 1]> </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:5.5pt;margin-top:1.5pt;width:190.75pt;height:75.5pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl79 width=247 style='width:185pt'></td>
  <td class=xl79 width=120 style='width:90pt'><%= dt.Rows[0]["partner_name"]%></td>
  <td class=xl40 width=120 style='width:90pt'></td>
  <td class=xl40 width=120 style='width:90pt'></td>
  <td class=xl40 width=120 style='width:90pt'></td>
  <td class=xl40 width=120 style='width:90pt'></td>
  <td class=xl40></td>
  <td colspan=3 class=xl40 width=120 style='width:90pt'>Tel: <%= dt.Rows[0]["phone_no"]%></td>
   
  <td class=xl26 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl26  style='mso-height-source:userset;height:25.0pt'>
  <td height=20 class=xl26  style='height:15.0pt;mso-ignore:colspan'></td>
  <td   class=xl26    style='mso-ignore:colspan'><%= dt.Rows[0]["addr1"]%></td>
   <td class=xl40></td>
 
  <td class=xl40></td>
   <td class=xl40></td>
 
  <td class=xl40></td>
  <td class=xl40></td>
  <td colspan=3 class=xl40 width=120 style='width:90pt'>Fax: <%= dt.Rows[0]["fax_no"]%></td>
  
  <td class=xl26></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:25.0pt'>
  <td  height=20 class=xl80 style='height:15.0pt'></td>
  <td colspan=3 class=xl41 width=120 style='width:90pt'>MST: <%= dt.Rows[0]["tax_code"]%></td>
   
  <td class=xl41 width=120 style='width:90pt'>&nbsp;</td>
  <td class=xl41 width=120 style='width:90pt'>&nbsp;</td>
  <td class=xl55></td>
  <td colspan=3 class=xl55 width=274 style='width:206pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td class=xl26></td>
 </tr>
 <tr height=70 style='mso-height-source:userset;height:52.5pt'>
  <td colspan=12 height=70 class=xl66 width=1036 style='height:52.5pt;
  width:777pt'>PHIẾU YÊU CẦU MUA HÀNG<br>
    <font class="font10">( PURCHASE REQUISITION )</font></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=12 height=20 class=xl56 style='height:15.0pt'>Số :<font
  class="font12"> <%= dt1.Rows[0]["slip_no"]%></font><font class="font5">/</font><font class="font11"> </font><font
  class="font5">Ngày : </font><font class="font13"><%= dt1.Rows[0]["quot_date"]%></font></td>
  <td class=xl25></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=2 class=xl25 style='height:7.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 
 <tr class=xl26 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl73 style='height:18.75pt'
   >P.Ban y/cầu (Req Dept)<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl42 width=607 style='width:455pt'><%= dt1.Rows[0]["DEPT_NAME"]%></td>
  <td class=xl42 width=120 style='border-top:none;width:90pt'>&nbsp;</td>
  <td class=xl42 width=74 style='border-top:none;width:56pt'>&nbsp;</td>
   <td class=xl42 width=74 style='border-top:none;width:56pt'>&nbsp;</td>
  <td class=xl37 width=80 style='border-top:none;width:60pt'>&nbsp;</td>
  <td class=xl26></td>
 </tr>
 <tr class=xl26 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl75 style='height:18.75pt'>Nhân viên (Charger)</td>
  <td colspan=6 class=xl43 width=607 style='width:455pt'><%= dt1.Rows[0]["charger"]%></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl38 width=80 style='width:60pt'>&nbsp;</td>
  <td class=xl26></td>
 </tr>
 <tr class=xl26 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl77 style='height:18.75pt'>Mục đích (Purpose)</td>
  <td colspan=6 class=xl44 width=607 style='width:455pt'><%= dt1.Rows[0]["description"]%></td>
  <td class=xl44 width=120 style='width:90pt'>&nbsp;</td>
  <td class=xl44 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl44 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl39 width=80 style='width:60pt'>&nbsp;</td>
  <td class=xl26></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl29 style='height:7.5pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=37 class=xl85 width=31 style='height:27.75pt;border-top:
  none;width:23pt'>STT</td>
  <td colspan=2 rowspan=2 class=xl67 width=240 style='border-right:.5pt solid black;
  width:180pt'>Tên hàng<font class="font17"><br>
    </font><font class="font8">Item Description</font></td>
  <td rowspan=2 class=xl64 width=51 style='border-top:none;width:38pt'>ĐVT<font
  class="font17"><br>
    </font><font class="font8">UOM</font></td>
  <td rowspan=2 class=xl64 width=80 style='border-top:none;width:60pt'>Số lượng
  <font class="font8">Quantity</font></td>
  <td colspan=3 rowspan=2 class=xl67 width=360 style='border-right:.5pt solid black;
  border-bottom:.1pt solid black;width:270pt'>Đơn giá<br>
    <font class="font8">Unit price</font></td>
  <td rowspan=2 class=xl64 width=120 style='border-bottom:.1pt solid black;
  border-top:none;width:90pt'>Lần mua trước<br>
    <font class="font8">Last purchase<br>
    (Qty *<span style='mso-spacerun:yes'>  </span>Unit Price)</font></td>
  <td rowspan=2 class=xl64 width=74 style='border-bottom:.1pt solid black;
  border-top:none;width:56pt'>Tồn kho<br>
    <font class="font8">In stock</font></td>
   <td rowspan=2 class=xl64 width=74 style='border-bottom:.1pt solid black;
  border-top:none;width:56pt'>Thủ kho<br>
    <font class="font8">Store keeper</font></td>
  <td rowspan=2 class=xl64 width=80 style='border-bottom:.1pt solid black;width:60pt'>Ghi chú<br>
    <font class="font8">Remark</font></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=2 class=xl31 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
  <% 
      Decimal total = 0;
      Decimal total_p1 = 0,total_p2 = 0,total_p3 = 0;     
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
  %>
 <tr class=xl31 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td rowspan=2 height=70 class=xl90 width=31 style='border-bottom:.1pt solid black;
  height:52.5pt;width:23pt' x:num><%= i+1 %></td>
  <td colspan=2 rowspan=2 class=xl92 width=240 style='border-bottom:.1pt solid black;
  width:180pt'><b>&nbsp; <%= dt2.Rows[i]["item_lname"]%></b>
   <br /><i>&nbsp; <%= dt2.Rows[i]["item_name"]%></td>
  <td rowspan=2 class=xl45 width=51 style='border-bottom:.1pt solid black;
  width:38pt'><%= dt2.Rows[i]["uom"]%></td>
  <td rowspan=2 class=xl60 width=80 style='border-bottom:.1pt solid black;
  width:60pt' x:num><span style='mso-spacerun:yes'>            
  </span><%= dt2.Rows[i]["req_qty"]%></td>
  <td class=xl45 width=120 style='border-top:none;border-left:none;width:90pt'><%= dt2.Rows[i]["partner_1"]%></td>
  <td class=xl45 width=120 style='border-top:none;border-left:none;width:90pt'><%= dt2.Rows[i]["partner_2"]%></td>
  <td class=xl45 width=120 style='border-top:none;border-left:none;width:90pt'><%= dt2.Rows[i]["partner_3"]%></td>
  <td class=xl45 width=120 style='border-top:none;border-left:none;width:90pt'><%= dt2.Rows[i]["price_date"]%></td>
  <td rowspan=2 class=xl57 width=74 style='border-bottom:.1pt solid black;
  border-top:none;width:56pt' x:num><span
  style='mso-spacerun:yes'>   <%= dt2.Rows[i]["stock_qty"]%></span></td>
  <td rowspan=2 class=xl57 width=74 style='border-bottom:.1pt solid black;
  border-top:none;width:56pt'></td>
  <td rowspan=2 class=xl62 width=80 style='border-bottom:.1pt solid black;
  border-top:none;width:60pt'><%= dt2.Rows[i]["description"]%></td>
  <td class=xl31></td>
 </tr>
 
 <tr class=xl31 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl46 width=120 style='height:22.5pt;border-top:none;
  border-left:none;width:90pt' x:num><span
  style='mso-spacerun:yes'>                    </span><%= dt2.Rows[i]["price_1"]%></td>
  <td class=xl46 width=120 style='border-top:none;border-left:none;width:90pt'
  x:num><span style='mso-spacerun:yes'>                   
  </span><%= dt2.Rows[i]["price_2"]%> </td>
  <td class=xl46 width=120 style='border-top:none;border-left:none;width:90pt'
  x:num><span style='mso-spacerun:yes'>                   
  </span><%= dt2.Rows[i]["price_3"]%>  </td>
  <td class=xl48 width=120 style='border-top:none;border-left:none;width:90pt'
  x:num><%= dt2.Rows[i]["last_price"]%></td>
  <td class=xl31></td>
 </tr>
 <%
    if (dt2.Rows[i]["req_qty"] !="")
    {    
        total += Convert.ToDecimal(dt2.Rows[i]["req_qty"]);
       
           total_p1 += Convert.ToDecimal(dt2.Rows[i]["req_qty"]) * Convert.ToDecimal(dt2.Rows[i]["price_1"]);
      
      
           total_p2 += Convert.ToDecimal(dt2.Rows[i]["req_qty"]) * Convert.ToDecimal(dt2.Rows[i]["price_2"]);
       
      
           total_p3 += Convert.ToDecimal(dt2.Rows[i]["req_qty"]) * Convert.ToDecimal(dt2.Rows[i]["price_3"]);
       
    }
                   
    }
  %>
 
 <tr class=xl32 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=3 height=30 class=xl83 width=271 style='height:22.5pt;width:203pt'>Total</td>
  <td class=xl49 width=51 style='border-top:none;width:38pt'>&nbsp;</td>
  <td class=xl52 width=80 style='border-top:none;border-left:none;width:60pt'
  x:num><%=total%></td>
  <td class=xl33 width=120 style='width:90pt' x:num ><%=total_p1%></td>
  <td class=xl50 width=120 style='border-top:none;border-left:none;width:90pt' x:num ><%=total_p2%></td>
  <td class=xl51 width=120 style='border-top:none;width:90pt' x:num ><%=total_p3%></td>
  <td class=xl34 width=120 style='width:90pt'>&nbsp;</td>
   <td class=xl34 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl34 width=74 style='width:56pt'>&nbsp;</td>
  <td class=xl34 width=80 style='width:60pt'>&nbsp;</td>
  <td class=xl32></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl35 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20  class=xl35 style='height:15.0pt;mso-ignore:colspan'></td>
  <td height=20 colspan=3 class=xl35 style='height:15.0pt;mso-ignore:colspan'><B>RECOMMENDATION & REASON: </B><%= dt1.Rows[0]["recommend"]%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17  class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td height=17  class=xl194 style='height:12.75pt;mso-ignore:colspan' align=center>SUPERVISOR</td
  <td height=17 colspan=4 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=5 rowspan=8 height=136 class=xl25 width=682 style='mso-ignore:
  colspan-rowspan;height:102.0pt;width:524pt'><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s1030" type="#_x0000_t75" style='position:absolute;
   margin-left:50pt;margin-top:0;width:480.25pt;height:130.25pt;z-index:2'>
   <v:imagedata src="epbp00190_files/image004.gif" o:title="untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=116 height=0></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=523 height=180 src="epbp00190_files/image004.gif" v:shapes="_x0000_s1030"></td>
    <td width=59></td>
   </tr>
   <tr>
    <td height=9></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:523.5pt;height:102.0pt'></span><![endif]--></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17  class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td height=17  rowspan="3" class=xl194 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 rowspan=5 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=0></td>
  <td width=0></td>
   <td width=74 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
