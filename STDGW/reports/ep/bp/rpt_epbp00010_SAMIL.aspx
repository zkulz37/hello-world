<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("sale");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_master_pk = Request.QueryString["master_pk"];   

    string para = "'" + p_master_pk + "'";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("lg_rpt_epbp00010_SAMIL_1", para);
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00010_SAMIL_2", para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00010_SAMIL_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00010_SAMIL_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00010_SAMIL_files/oledata.mso">
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
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-05-04T01:34:48Z</o:LastPrinted>
  <o:Created>2012-05-03T07:51:26Z</o:Created>
  <o:LastSaved>2012-05-04T01:38:23Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font6
	{color:black;
	font-size:24.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:10.0pt;
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
.style17
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
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
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style20
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\B9D1\C740 \ACE0\B515", monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2 2";}
.style22
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\B9D1\C740 \ACE0\B515", monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2 2 3";}
.style23
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\B9D1\C740 \ACE0\B515", monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2 2 3 2";}
.style24
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
	mso-style-name:Normal_Sheet1;}
.style27
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
	mso-style-name:"\D45C\C900_EVERY 10 DAY_YEU CAU MUA HANG-NHUNG";}
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
.xl31
	{mso-style-parent:style20;
	color:black;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style20;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style20;
	color:black;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style17;
	color:black;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style17;
	color:black;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style17;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style20;
	color:black;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style20;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style17;
	color:black;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style17;
	color:black;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style17;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style20;
	color:black;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style17;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl50
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style22;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style23;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style17;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style17;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-\[$$-409\]* \#\,\#\#0_ \;_-\[$$-409\]* \\-\#\,\#\#0\\ \;_-\[$$-409\]* \0022-\0022??_ \;_-\@_ ";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:none;}
.xl69
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl70
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style20;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl78
	{mso-style-parent:style20;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style20;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style17;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
	{mso-style-parent:style27;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl82
	{mso-style-parent:style17;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style20;
	color:black;
	font-size:24.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style20;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style24;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style20;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
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
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=853 style='border-collapse:
 collapse;table-layout:fixed;width:641pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=70 span=2 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=126 style='mso-width-source:userset;mso-width-alt:4608;width:95pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=10 height=48 class=xl83 width=853 style='height:36.0pt;
  width:641pt'>&#44396; &#47588; &#49888; &#52397; &#49436; <font class="font6">(Yêu
  c&#7847;u mua hàng)</font></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl31 style='height:18.75pt' x:str="&#49688;&#49888; (Kính g&#7917;i): ">&#49688;&#49888;
  (Kính <span style='display:none'>g&#7917;i):<span
  style='mso-spacerun:yes'> </span></span></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33><%= dt.Rows[0]["request_to"]%></td>
  <td class=xl31>&nbsp;</td>
  <td class=xl34></td>
  <td class=xl35 x:str="&#49324; &#50857; &#48512; &#49436; ( B&#7897; ph&#7853;n s&#7917; d&#7909;ng):"><span
  style='mso-spacerun:yes'> </span>&#49324; &#50857; &#48512; &#49436; (
  B&#7897; ph&#7853;n s&#7917; d&#7909;ng):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl37 ><span
  style='mso-spacerun:yes'> </span><%= dt.Rows[0]["dept_name"]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl31>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl38 style='height:18.75pt;border-top:none'
  x:str="&#45216;&#51676; (Ngày) : ">&#45216;&#51676; (Ngày<span
  style='display:none'>) :<span style='mso-spacerun:yes'> </span></span></td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl40 colspan=2 style='mso-ignore:colspan'><%= dt.Rows[0]["req_date"]%></td>
  <td class=xl34></td>
  <td class=xl41 style='border-top:none' x:str="&#50900;&#49324; &#50857; &#54620;&#46020; (Ngân sách/tháng):"><span
  style='mso-spacerun:yes'> </span>&#50900;&#49324; &#50857; &#54620;&#46020;
  (Ngân sách/tháng):<span style='mso-spacerun:yes'> </span></td>
  <td class=xl42 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none' x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[0]["ngan_sach"]%></td>
  <td class=xl38 style='border-top:none'>($) V.A.T &#48324;&#46020;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl38 style='height:18.75pt;border-top:none'
  x:str="&#44396;&#47588;&#52376; (Nhà cung c&#7845;p): ">&#44396;&#47588;&#52376;
  (Nh<span style='display:none'>à cung c&#7845;p):<span
  style='mso-spacerun:yes'> </span></span></td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl40 colspan=2 style='mso-ignore:colspan'><%= dt.Rows[0]["supplier"]%></td>
  <td class=xl44></td>
  <td class=xl41 style='border-top:none' x:str="&#45572;&#51201; &#49324;&#50857;&#50529; (S&#7889; c&#7897;ng d&#7891;n):"><span
  style='mso-spacerun:yes'> </span>&#45572;&#51201; &#49324;&#50857;&#50529;
  (S&#7889; c&#7897;ng d&#7891;n):<span style='mso-spacerun:yes'> </span></td>
  <td class=xl42 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none' x:num ><span
  style='mso-spacerun:yes'></span><%= dt.Rows[0]["so_cong_don"]%></td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl38 style='height:18.75pt;border-top:none'
  x:str="&#45824;&#48516;&#47448; (Phân lo&#7841;i): ">&#45824;&#48516;&#47448;
  (Ph<span style='display:none'>ân lo&#7841;i):<span
  style='mso-spacerun:yes'> </span></span></td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl40 style='border-top:none'><%= dt.Rows[0]["phan_loai"]%></td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl34></td>
  <td class=xl41 style='border-top:none' x:str="&#51092; &#50668; &#50529; (S&#7889; còn l&#7841;i):"><span
  style='mso-spacerun:yes'> </span>&#51092; &#50668; &#50529; (S&#7889; còn
  l&#7841;i):<span style='mso-spacerun:yes'> </span></td>
  <td class=xl42 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none' x:num><span style='mso-spacerun:yes'>                 
  </span><%= dt.Rows[0]["so_con_lai"]%></td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl38 style='height:18.75pt;border-top:none'>&#51473;&#48516;&#47448;
  (Nh<span style='display:none'>óm hàng):</span></td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl40 style='border-top:none'><%= dt.Rows[0]["nhom_hang"]%></td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl34></td>
  <td class=xl41 style='border-top:none' x:str="&#45225;&#54408; &#55148;&#47581;&#51068; (Ngày Y/C giao):"><span
  style='mso-spacerun:yes'> </span>&#45225;&#54408; &#55148;&#47581;&#51068;
  (Ngày Y/C giao):<span style='mso-spacerun:yes'> </span></td>
  <td class=xl42 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none' x:str><span
  style='mso-spacerun:yes'></span><%= dt.Rows[0]["etd_from"]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl46 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl49 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl77 width=63 style='height:27.0pt;width:47pt'>&#53076;&#46300;<br>
    Mã hàng</td>
  <td colspan=2 class=xl78 width=140 style='border-right:.5pt solid black;
  border-left:none;width:106pt'>&#54408;&#47749;<br>
    Tên hàng (VN)</td>
  <td class=xl78 width=107 style='border-left:none;width:80pt'>&#54408;&#47749;<br>
    Tên hàng (KR)</td>
  <td class=xl79 width=100 style='width:75pt'>&#44508;&#44201;<br>
    Quy cách</td>
  <td class=xl80 width=65 style='border-left:none;width:49pt' x:str="&#45800;&#50948;&#10;&#272;VT"><span
  style='mso-spacerun:yes'> </span>&#45800;&#50948;<br>
    &#272;VT<span style='mso-spacerun:yes'> </span></td>
  <td class=xl80 width=67 style='border-left:none;width:50pt'
  x:str="&#49888;&#52397;&#49688;&#47049;&#10;SL yêu c&#7847;u"><span
  style='mso-spacerun:yes'> </span>&#49888;&#52397;&#49688;&#47049;<br>
    SL yêu c&#7847;u<span style='mso-spacerun:yes'> </span></td>
  <td class=xl80 width=88 style='border-left:none;width:66pt' x:str="&#45800;&#44032;&#10;&#272;&#417;n giá"><span
  style='mso-spacerun:yes'> </span>&#45800;&#44032;<br>
    &#272;&#417;n giá<span style='mso-spacerun:yes'> </span></td>
  <td class=xl80 width=126 style='border-left:none;width:95pt'
  x:str="&#44552; &#50529;&#10;Thành ti&#7873;n"><span
  style='mso-spacerun:yes'> </span>&#44552; &#50529;<br>
    Thành ti&#7873;n<span style='mso-spacerun:yes'> </span></td>
  <td class=xl77 width=97 style='border-left:none;width:73pt'>&#48708;&#44256;<br>
    (Ghi chú)</td>
 </tr>
 <%
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
      %>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl50 style='height:24.75pt;border-top:none'><%= dt1.Rows[i]["item_code"]%></td>
  <td colspan=2 class=xl85 width=140 style='border-left:none;width:106pt'><%= dt1.Rows[i]["item_name"]%></td>
  <td class=xl81 width=107 style='border-top:none;border-left:none;width:80pt'><%= dt1.Rows[i]["item_lname"]%></td>
  <td class=xl81 width=100 style='border-top:none;border-left:none;width:75pt'><%= dt1.Rows[i]["spec01_nm"]%></td>
  <td class=xl51 style='border-top:none;border-left:none'><%= dt1.Rows[i]["req_uom"]%></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["req_qty"]%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%= dt1.Rows[i]["unit_price"]%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>              
  </span><%= dt1.Rows[i]["item_amount"]%></td>
  <td class=xl50 style='border-top:none;border-left:none'><%= dt1.Rows[i]["description"]%></td>
 </tr>
 <%} %>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=5 height=33 class=xl86 style='border-right:.5pt solid black;
  height:24.75pt'>Total</td>
  <td class=xl54 style='border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-left:none' x:num ><span
  style='mso-spacerun:yes'><%= dt.Rows[0]["item_amount"]%></span></td>
  <td class=xl56 style='border-left:none' x:num ><span style='mso-spacerun:yes'><%= dt.Rows[0]["ccy"]%></span>&nbsp;&nbsp;&nbsp;<span
  style='mso-spacerun:yes'><%= dt.Rows[0]["ex_amount"]%></span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl57 colspan=2 style='height:12.75pt;mso-ignore:colspan'>&#44396;&#47588;&#49884;&#50836;&#52397;&#49324;&#54637;:</td>
  <td class=xl59 style='border-top:none'>&nbsp;</td>
  <td class=xl58 style='border-top:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none'>&nbsp;</td>
  <td class=xl61 colspan=2 style='mso-ignore:colspan' x:str="&#51204;&#45804;&#49324;&#54637;:"><span
  style='mso-spacerun:yes'> </span>&#51204;&#45804;&#49324;&#54637;:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl63 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl64 style='height:27.0pt'>&nbsp;</td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl70 style='height:27.0pt'>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl74 style='border-left:none'>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=7 rowspan=8 height=136 width=567 style='mso-ignore:colspan-rowspan;
  height:102.0pt;width:426pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
   margin-left:1pt;margin-top:2.25pt;width:564.48pt;height:142.56pt;z-index:1'
   fillcolor="windowText [64]" strokecolor="window [65]" strokeweight="3e-5mm"
   o:insetmode="auto">
   <v:fill color2="window [65]"/>
   <v:imagedata src="rpt_epbp00010_SAMIL_files/image001.gif" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:AutoFill>False</x:AutoFill>
    <x:AutoLine>False</x:AutoLine>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=51 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td></td>
    <td width=0></td>
   </tr>
   <tr>
    <td height=7></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:425.25pt;height:102.0pt'></span><![endif]--></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=63 style='width:47pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=97 style='width:73pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
