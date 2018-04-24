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
    
    dt  = ESysLib.TableReadOpenCursor("lg_rpt_epbp00191_IBC_2");
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00191_IBC", para);
    dt2 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00191_IBC_1", para);
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
<link rel=File-List href="rpt_epbp00191_IBC_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00191_IBC_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00191_IBC_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-06-22T06:40:41Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-06-22T06:40:43Z</o:LastSaved>
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
.font6
	{color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:18.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font15
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font19
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font21
	{color:black;
	font-size:8.0pt;
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
.style21
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
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:800;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:800;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style21;
	color:black;
	font-size:12.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl40
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl49
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl51
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl52
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl58
	{mso-style-parent:style0;
	text-align:center;}
.xl59
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl61
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl69
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl70
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl71
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl72
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl73
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
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
.xl74
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl78
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl82
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid black;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl83
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl84
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl85
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl87
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl89
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl92
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl93
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl94
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl95
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl96
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl97
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl98
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl105
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl106
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl107
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl108
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl110
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl112
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl113
	{mso-style-parent:style21;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl114
	{mso-style-parent:style21;
	color:black;
	font-size:12.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>450</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>13035</x:WindowHeight>
  <x:WindowWidth>19260</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
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
 <o:shapedefaults v:ext="edit" spidmax="1041"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1325 style='border-collapse:
 collapse;table-layout:fixed;width:995pt'>
 <col class=xl26 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl26 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl26 width=116 style='mso-width-source:userset;mso-width-alt:4242;
 width:87pt'>
 <col class=xl26 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl26 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl26 width=145 span=3 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col class=xl26 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl26 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl26 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl26 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=2 rowspan=3 height=106 width=155 style='height:79.9pt;width:116pt'
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:5.25pt;margin-top:1.5pt;width:190.5pt;height:75.75pt;z-index:1'>
   <v:imagedata src="rpt_epbp00191_IBC_files/image001.png" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:7px;margin-top:2px;width:254px;
  height:101px'><img width=254 height=101
  src="rpt_epbp00191_IBC_files/image002.gif" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 rowspan=3 height=106 class=xl59 width=155 style='height:79.9pt;
    width:116pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 width=116 style='width:87pt'></td>
  <td class=xl28 colspan=4 width=405 style='mso-ignore:colspan;width:305pt'><%= dt.Rows[0]["partner_name"]%></td>
  <td class=xl28 width=145 style='width:109pt'></td>
  <td class=xl28 width=65 style='width:49pt'></td>
  <td class=xl29 width=80 style='width:60pt'></td>
  <td colspan=3 class=xl29 width=295 style='width:221pt'>Tel: <%= dt.Rows[0]["phone_no"]%></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl25 style='height:24.95pt'></td>
  <td class=xl30 colspan=4 style='mso-ignore:colspan'><%= dt.Rows[0]["addr1"]%></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 width=295 style='width:221pt'>Fax: <%= dt.Rows[0]["fax_no"]%></td>
  <td class=xl25></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl112 style='height:24.95pt'></td>
  <td colspan=3 class=xl113 width=260 style='width:196pt'>Tax No: <%= dt.Rows[0]["tax_code"]%></td>
  <td colspan=3 class=xl114 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=3 class=xl31 width=295 style='width:221pt'>Print date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl32 height=92 style='mso-height-source:userset;height:69.0pt'>
  <td colspan=14 height=92 class=xl115 width=1325 style='height:69.0pt;
  width:995pt'>PHIẾU YÊU CẦU MUA HÀNG<br>
    <font class="font13">( PURCHASE REQUISITION )</font></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=14 height=36 class=xl60 style='height:27.0pt'>Số :<font
  class="font14"> </font><font class="font6"><%= dt1.Rows[0]["slip_no"]%></font><font class="font14"> </font><font
  class="font5">/</font><font class="font15"> </font><font class="font5">Ngày :
  </font><font class="font14"><%= dt1.Rows[0]["quot_date"]%></font></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=2 class=xl25 style='height:7.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl30 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl61 style='height:18.75pt'
 >P.Ban y/cầu (Req Dept)<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl63 width=666 style='width:501pt'><%= dt1.Rows[0]["DEPT_NAME"]%></td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl110>&nbsp;</td>
 </tr>
 <tr class=xl30 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl64 style='height:18.75pt'>Nhân viên (Charger)</td>
  <td colspan=6 class=xl35 width=666 style='width:501pt'><%= dt1.Rows[0]["charger"]%></td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl109>&nbsp;</td>
 </tr>
 <tr class=xl30 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl66 style='height:18.75pt'>Mục đích (Purpose)</td>
  <td colspan=6 class=xl36 width=666 style='width:501pt'><%= dt1.Rows[0]["description"]%></td>
  <td class=xl36 width=65 style='width:49pt'>&nbsp;</td>
  <td class=xl36 width=80 style='width:60pt'>&nbsp;</td>
  <td class=xl36 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl36 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl36 width=145 style='width:109pt'>&nbsp;</td>
  <td class=xl111>&nbsp;</td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl37 style='height:7.5pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=42 class=xl68 width=31 style='border-bottom:.5pt solid black;
  height:31.5pt;border-top:none;width:23pt'>STT</td>
  <td colspan=2 rowspan=2 class=xl70 width=240 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:180pt'>Tên hàng<font class="font19"><br>
    </font><font class="font21">Item Description</font></td>
  <td rowspan=2 class=xl74 width=45 style='border-bottom:.5pt solid black;
  border-top:none;width:34pt'>ĐVT<font class="font19"><br>
    </font><font class="font21">UOM</font></td>
  <td rowspan=2 class=xl74 width=70 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt'>Số lượng <font class="font21">Quantity</font></td>
  <td colspan=3 rowspan=2 class=xl70 width=435 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:327pt'>Đơn giá<br>
    <font class="font21">Unit price</font></td>
  <td colspan=2 rowspan=2 class=xl70 width=145 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:109pt'>Lần mua trước<br>
    <font class="font21">Last purchase<br>
    (Qty *<span style='mso-spacerun:yes'>  </span>Unit Price)</font></td>
  <td rowspan=2 class=xl82 width=75 style='border-bottom:.5pt solid black;
  border-top:none;width:56pt'>Tồn kho<br>
    <font class="font21">In stock</font></td>
  <td rowspan=2 class=xl74 width=75 style='border-bottom:.5pt solid black;
  border-top:none;width:56pt'>Thủ kho<br>
    <font class="font21">Store keeper</font></td>
  <td rowspan=2 class=xl74 width=145 style='border-bottom:.5pt solid black;
  width:109pt'>Được chọn<br>
    <font class="font21">Agree</font></td>
  <td rowspan=2 class=xl74 width=64 style='border-bottom:.5pt solid black;
  width:48pt'>Chú thích<br>
    <font class="font21">Remark</font></td>
 </tr>
 <tr class=xl39 height=22 style='mso-height-source:userset;height:16.5pt'>
 </tr>
  <% 
      Decimal total = 0;
      Decimal total_p1 = 0,total_p2 = 0,total_p3 = 0,total_p4 = 0;     
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
  %>
 <tr class=xl39 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td rowspan=2 height=70 class=xl84 width=31 style='border-bottom:.5pt solid black;
  height:52.5pt;border-top:none;width:23pt' x:num><%= i+1 %></td>
  <td colspan=2 rowspan=2 class=xl86 width=240 style='border-right:.5pt hairline black;
  border-bottom:.5pt solid black;width:180pt'>&nbsp;<%= dt2.Rows[i]["item_lname"]%><font class="font19">
  <br>
    </font><font class="font21">&nbsp;<%= dt2.Rows[i]["item_name"]%></font></td>
  <td rowspan=2 class=xl90 width=45 style='border-bottom:.5pt solid black;
  border-top:none;width:34pt'><%= dt2.Rows[i]["uom"]%></td>
  <td rowspan=2 class=xl92 width=70 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt' x:num><span style='mso-spacerun:yes'>     
  </span><%= dt2.Rows[i]["req_qty"]%></td>
  <td class=xl40 width=145 style='width:109pt'><%= dt2.Rows[i]["partner_1"]%></td>
  <td class=xl40 width=145 style='width:109pt'><%= dt2.Rows[i]["partner_2"]%></td>
  <td class=xl41 width=145 style='width:109pt'><%= dt2.Rows[i]["partner_3"]%></td>
  <td colspan=2 class=xl94 width=145 style='border-right:.5pt solid black;
  width:109pt'><%= dt2.Rows[i]["price_date"]%></td>
  <td rowspan=2 class=xl96 width=75 style='border-bottom:.5pt solid black;
  border-top:none;width:56pt' x:num><span style='mso-spacerun:yes'></span><%= dt2.Rows[i]["stock_qty"]%></td>
  <td rowspan=2 class=xl98 width=75 style='border-bottom:.5pt solid black;
  border-top:none;width:56pt'>&nbsp;</td>
  <td class=xl42 width=145 style='width:109pt'><%= dt2.Rows[i]["select_partner"]%></td>
  <td rowspan=2 class=xl100 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'><%= dt2.Rows[i]["description"]%></td>
 </tr>
 <tr class=xl39 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl43 width=145 style='height:22.5pt;width:109pt' x:num><span
  style='mso-spacerun:yes'>                           </span><%= dt2.Rows[i]["price_1"]%></td>
  <td class=xl43 width=145 style='width:109pt' x:num><span
  style='mso-spacerun:yes'>                         </span><%= dt2.Rows[i]["price_2"]%></td>
  <td class=xl44 width=145 style='width:109pt' x:num><span
  style='mso-spacerun:yes'>                         </span><%= dt2.Rows[i]["price_3"]%></td>
  <td class=xl45 width=65 style='width:49pt' ><span
  style='mso-spacerun:yes'>            </span><%= dt2.Rows[i]["last_qty"]%></td>
  <td class=xl46 width=80 style='width:60pt' ><span
  style='mso-spacerun:yes'>      </span><%= dt2.Rows[i]["last_price"]%></td>
  <td class=xl47 width=145 style='width:109pt' x:num><span
  style='mso-spacerun:yes'>                           </span><%= dt2.Rows[i]["select_unit_price"]%> </td>
 </tr>
 <%
    if (dt2.Rows[i]["req_qty"] !="")
    {    
           total += Convert.ToDecimal(dt2.Rows[i]["req_qty"]);
       
           total_p1 += Convert.ToDecimal(dt2.Rows[i]["req_qty"]) * Convert.ToDecimal(dt2.Rows[i]["price_1"]);
      
      
           total_p2 += Convert.ToDecimal(dt2.Rows[i]["req_qty"]) * Convert.ToDecimal(dt2.Rows[i]["price_2"]);
       
      
           total_p3 += Convert.ToDecimal(dt2.Rows[i]["req_qty"]) * Convert.ToDecimal(dt2.Rows[i]["price_3"]);
           
           
           total_p4 += Convert.ToDecimal(dt2.Rows[i]["req_qty"]) * Convert.ToDecimal(dt2.Rows[i]["select_unit_price"]);
       
    }
                   
    }
  %>
 <tr class=xl48 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=4 height=30 class=xl102 width=316 style='border-right:.5pt solid black;
  height:22.5pt;width:237pt'>Total</td>
  <td class=xl49 width=70 style='width:53pt' x:num><span
  style='mso-spacerun:yes'>      </span><%=total%> </td>
  <td class=xl50 width=145 style='width:109pt' x:num><span
  style='mso-spacerun:yes'>                            </span><%=total_p1%> </td>
  <td class=xl51 width=145 style='width:109pt' x:num><span
  style='mso-spacerun:yes'>                            </span><%=total_p2%> </td>
  <td class=xl52 width=145 style='width:109pt' x:num><span
  style='mso-spacerun:yes'>                            </span><%=total_p3%> </td>
  <td colspan=2 class=xl105 width=145 style='border-right:.5pt solid black;
  width:109pt'>&nbsp;</td>
  <td colspan=2 class=xl107 width=150 style='border-right:.5pt solid black;
  border-left:none;width:112pt'>&nbsp;</td>
  <td class=xl53 width=145 style='width:109pt' x:num><span
  style='mso-spacerun:yes'>                            </span><%=total_p4%> </td>
  <td class=xl54 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl55 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl55 style='height:15.0pt'></td>
  <td class=xl57 colspan=4 style='mso-ignore:colspan'>RECOMMENDATION &amp;
  REASON: <font class="font5"><%= dt1.Rows[0]["recommend"]%></font></td>
  <td class=xl57></td>
  <td colspan=3 class=xl55 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1040"
   type="#_x0000_t75" style='position:absolute;margin-left:2.25pt;margin-top:11.25pt;
   width:130.5pt;height:143.25pt;z-index:3'>
   <v:imagedata src="rpt_epbp00191_IBC_files/image003.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:3;margin-left:3px;margin-top:15px;width:174px;
  height:191px'><img width=174 height=191
  src="rpt_epbp00191_IBC_files/image004.jpg" v:shapes="_x0000_s1040"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl25 width=124 style='height:12.75pt;width:93pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1038"
   type="#_x0000_t75" style='position:absolute;margin-left:9pt;margin-top:12pt;
   width:606pt;height:139.5pt;z-index:2'>
   <v:imagedata src="rpt_epbp00191_IBC_files/image005.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:12px;margin-top:16px;width:808px;
  height:186px'><img width=808 height=186
  src="rpt_epbp00191_IBC_files/image006.jpg" v:shapes="_x0000_s1038"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl25 width=145 style='height:12.75pt;width:109pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 class=xl25 style='height:22.5pt'></td>
  <td class=xl58></td>
  <td colspan=10 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 class=xl25 style='height:22.5pt'></td>
  <td class=xl58></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 class=xl25 style='height:22.5pt'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 colspan=6 class=xl26 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 colspan=6 class=xl26 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 colspan=6 class=xl26 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 colspan=6 class=xl26 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 colspan=6 class=xl26 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
