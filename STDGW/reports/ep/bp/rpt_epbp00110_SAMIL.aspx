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
   											  
    string p_po_pk  = Request.QueryString["p_po_pk"];

    string para = "'" + p_po_pk + "'";
    
    DataTable dt, dt1, dt2;
    
    dt   = ESysLib.TableReadOpenCursor("LG_RPT_EPBP00110_DEPT_SAMIL","''");
    dt1  = ESysLib.TableReadOpenCursor("LG_RPT_EPBP00110_DATA_SAMIL",para);
    
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
<link rel=File-List href="rpt_epbp00270_SAMIL_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00270_SAMIL_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00270_SAMIL_files/oledata.mso">
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
  <o:LastPrinted>2012-05-30T04:24:09Z</o:LastPrinted>
  <o:Created>2012-05-16T03:37:08Z</o:Created>
  <o:LastSaved>2012-05-31T01:38:21Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .15in .5in .15in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	mso-style-name:"Normal 2 2";}
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
.xl28
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl38
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl49
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style16;
	color:black;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style22;
	color:black;
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
.xl59
	{mso-style-parent:style22;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl60
	{mso-style-parent:style17;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	color:black;
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
.xl62
	{mso-style-parent:style0;
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
.xl63
	{mso-style-parent:style0;
	color:black;
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
.xl64
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style17;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style17;
	color:red;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style17;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet 1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>50</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
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
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="5"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl28>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1418 style='border-collapse:
 collapse;table-layout:fixed;width:1064pt'>
 <col class=xl30 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl30 width=158 style='mso-width-source:userset;mso-width-alt:5778;
 width:119pt'>
 <col class=xl28 width=139 style='mso-width-source:userset;mso-width-alt:5083;
 width:104pt'>
 <col class=xl28 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl30 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl28 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl28 width=56 span=12 style='mso-width-source:userset;mso-width-alt:
 2048;width:42pt'>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=6 height=45 class=xl81 width=643 style='height:33.75pt;
  width:483pt'>&#44396; &#47588; &#49888; &#52397; &#49436; (Yêu c&#7847;u mua
  hàng) - <%=DateTime.Now.ToString("MM/yyyy")%></td>
  <td width=103 style='width:77pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s5127" type="#_x0000_t75" style='position:absolute;
   margin-left:13.5pt;margin-top:5.25pt;width:564.75pt;height:109.5pt;
   z-index:1' fillcolor="windowText [64]" strokecolor="window [65]"
   strokeweight="3e-5mm" o:insetmode="auto">
   <v:fill color2="window [65]"/>
   <v:imagedata src="rpt_epbp00270_SAMIL_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:AutoFill>False</x:AutoFill>
    <x:AutoLine>False</x:AutoLine>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:18px;margin-top:7px;width:753px;
  height:146px'><img width=753 height=146
  src="rpt_epbp00270_SAMIL_files/image002.jpg" v:shapes="_x0000_s5127"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=45 class=xl48 width=103 style='height:33.75pt;width:77pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
  <td class=xl36 width=56 style='width:42pt'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl41 style='height:26.25pt'>&#49688;<span
  style='display:none'>&#49888; (Kính g&#7917;i)<span
  style='mso-spacerun:yes'></span>:<span style='mso-spacerun:yes'>  
  </span></span></td>
  <td class=xl42 width=158 style='width:119pt'>&nbsp;</td>
  <td class=xl43></td>
  <td class=xl41>&#49324; &#50857; &#48512; &#49436;<span
  style='mso-spacerun:yes'>  </span>( B<span style='display:none'>&#7897;
  ph&#7853;n s&#7917; d&#7909;ng):</span></td>
  <td class=xl42 width=103 style='width:77pt'>&nbsp;</td>
  <td class=xl44 width=103 style='width:77pt'>&nbsp;</td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl45 style='height:26.25pt;border-top:none'>&#45216;<span
  style='display:none'>&#51676;<span style='mso-spacerun:yes'> 
  </span>(Ngày)<span style='mso-spacerun:yes'></span>: <%= DateTime.Now.ToString("yyyy.MM.dd") %></span></td>
  <td class=xl46 width=158 style='border-top:none;width:119pt'>&nbsp;</td>
  <td class=xl43></td>
  <td class=xl45 style='border-top:none'>&#45824;&#48376;&#47448; (Phân lo<span
  style='display:none'>&#7841;i): </span></td>
  <td class=xl46 width=103 style='border-top:none;width:77pt'>&nbsp;</td>
  <td class=xl47 width=103 style='border-top:none;width:77pt'>&nbsp;</td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl45 style='height:26.25pt;border-top:none'>&#44396;<span
  style='display:none'>&#47588;&#52376; (Nhà cung c&#7845;p): </span></td>
  <td class=xl46 width=158 style='border-top:none;width:119pt'>&nbsp;</td>
  <td class=xl43></td>
  <td class=xl45 style='border-top:none'>&#51473;&#48516;&#47448;(Nhóm h<span
  style='display:none'>àng): </span></td>
  <td class=xl46 width=103 style='border-top:none;width:77pt'>&nbsp;</td>
  <td class=xl47 width=103 style='border-top:none;width:77pt'>&nbsp;</td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>&nbsp;</td>
  <td class=xl30></td>
  <td class=xl37></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl30></td>
  <td class=xl37></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl54 style='height:26.25pt'>CCY</td>
  <td class=xl55 width=158 style='border-left:none;width:119pt'>Total</td>
  <td class=xl56 style='border-left:none'>&#49324;&#47924;&#49892; (1)</td>
  <td class=xl56 style='border-left:none'>&#44277;&#47924; (2)</td>
  <td class=xl56 style='border-left:none'>&#50689;&#50629; (3)</td>
  <td class=xl57 style='border-left:none'>&#49892;&#54744; (4)</td>
  <td class=xl56 style='border-left:none'>&#50672;&#49324; (5)</td>
  <td colspan=2 class=xl57 style='border-left:none'>&#49373;&#51648; (6)</td>
  <td colspan=2 class=xl57 style='border-left:none'>&#54200;&#51649; (7)</td>
  <td colspan=2 class=xl74 width=112 style='border-left:none;width:84pt'>&#44288;&#47532;
  (8)</td>
  <td colspan=2 class=xl74 width=112 style='border-left:none;width:84pt'>&#50684;&#49353;
  (9)</td>
  <td colspan=2 class=xl74 width=112 style='border-left:none;width:84pt'>&#44160;&#49324;
  (10)</td>
  <td colspan=2 class=xl74 width=112 style='border-left:none;width:84pt'>&#52636;&#44256;
  (11)</td>
  <td colspan=2 class=xl74 width=112 style='border-left:none;width:84pt'>&#52636;&#44256;
  (12)</td>
  <td colspan=2 class=xl74 width=112 style='border-left:none;width:84pt'>&#52636;&#44256;
  (13)</td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl50 style='height:26.25pt'>VND</td>
  <td class=xl49 width=158 style='border-top:none;border-left:none;width:119pt'
  x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>G<%= dt1.Rows.Count+10%><%}else{%>G14<%}%>"><span style='mso-spacerun:yes'></span></td>
  <td class=xl51 width=139 style='border-top:none;border-left:none;width:104pt'  x:fmla="=<% if(dt1.Rows.Count > 0){%>H<%= dt1.Rows.Count+10%><%}else{%>H14<%}%>"></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>I<%= dt1.Rows.Count+10%><%}else{%>I14<%}%>"><span style='mso-spacerun:yes'></span></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>J<%= dt1.Rows.Count+10%><%}else{%>J14<%}%>"></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>K<%= dt1.Rows.Count+10%><%}else{%>K14<%}%>"></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>L<%= dt1.Rows.Count+10%><%}else{%>L14<%}%>"></td>
  <td colspan=2 class=xl52 style='border-left:none' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>M<%= dt1.Rows.Count+10%><%}else{%>M14<%}%>"></td>
  <td colspan=2 class=xl51 width=112 style='border-left:none;width:84pt' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>N<%= dt1.Rows.Count+10%><%}else{%>N14<%}%>"></td>
  <td colspan=2 class=xl51 width=112 style='border-left:none;width:84pt' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>O<%= dt1.Rows.Count+10%><%}else{%>O14<%}%>"></td>
  <td colspan=2 class=xl51 width=112 style='border-left:none;width:84pt' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>P<%= dt1.Rows.Count+10%><%}else{%>P14<%}%>"></td>
  <td colspan=2 class=xl51 width=112 style='border-left:none;width:84pt' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>Q<%= dt1.Rows.Count+10%><%}else{%>Q14<%}%>"></td>
  <td colspan=2 class=xl52 style='border-left:none' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>R<%= dt1.Rows.Count+10%><%}else{%>R14<%}%>"></td>
  <td colspan=2 class=xl52 style='border-left:none' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>S<%= dt1.Rows.Count+10%><%}else{%>S14<%}%>"></td>
  <td colspan=2 class=xl52 style='border-left:none' x:num x:fmla="=<% if(dt1.Rows.Count > 0){%>T<%= dt1.Rows.Count+10%><%}else{%>T14<%}%>"></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl30 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=14 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl58 width=30 style='border-bottom:.5pt solid windowtext;height:32.25pt;width:23pt'>No.<br>
    TT</td>
  <td class=xl59 width=158 style='border-bottom:.5pt solid windowtext;border-left:none;width:119pt'>&#54408;&#47749;<br>
    Tên hàng (VN)</td>
  <td class=xl59 width=139 style='border-bottom:.5pt solid windowtext;border-left:none;width:104pt'>&#54408;&#47749;<br>
    Tên hàng (KR)</td>
  <td class=xl59 width=110 style='border-bottom:.5pt solid windowtext;border-left:none;width:83pt'>&#44508;&#44201;<br>
    Quy cách</td>
  <td class=xl60 width=103 style='border-bottom:.5pt solid windowtext;border-left:none;width:77pt'
  x:str="&#49888;&#52397;&#49688;&#47049;&#10;SL yêu c&#7847;u"><span
  style='mso-spacerun:yes'> </span>&#49888;&#52397;&#49688;&#47049;<br>
    SL yêu c&#7847;u<span style='mso-spacerun:yes'> </span></td>
  <td class=xl60 width=103 style='border-bottom:.5pt solid windowtext;border-left:none;width:77pt'
  x:str="&#45800;&#44032;&#10;&#272;&#417;n giá"><span
  style='mso-spacerun:yes'> </span>&#45800;&#44032;<br>
    &#272;&#417;n giá<span style='mso-spacerun:yes'> </span></td>
  <td class=xl60 width=103 style='border-bottom:.5pt solid windowtext;border-left:none;width:77pt'
  x:str="&#44552; &#50529;&#10;Thành ti&#7873;n"><span
  style='mso-spacerun:yes'> </span>&#44552; &#50529;<br>
    Thành ti&#7873;n<span style='mso-spacerun:yes'> </span></td> 
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#49324;&#47924;&#49892;<br>
    (1)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#44277;&#47924; <br>
    (2)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#50689;&#50629;<br>
    (3)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#49892;&#54744;<br>
    (4)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#50672;&#49324;<br>
    (5)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#49373;&#51648;<br>
    (6)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#54200;&#51649;<br>
    (7)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#44288;&#47532;<br>
    (8)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#50684;&#49353;<br>
    (9)</td>
  <td class=xl62 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#44160;&#49324;<br>
    (10)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#52636;&#44256;<br>
    (11)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#52636;&#44256;<br>
    (12)</td>
  <td class=xl61 width=56 style='border-bottom:.5pt solid windowtext;width:42pt'>&#52636;&#44256;<br>
    (13)</td>    
  <td class=xl63 width=56 style='border-bottom:.5pt solid windowtext;border-left:none;width:42pt'>&#48708;&#44256;<br>
    Ghi chú</td>
 </tr>
 <%     
     // Tinh tong
     double[] arr = new double[dt.Columns.Count]; // so cot DEPT
     for (int a = 0; a < dt.Columns.Count; a++)
     {
         for (int b = 0; b < dt1.Rows.Count; b++)
         {
             arr[a] += (Convert.ToDouble(dt1.Rows[b]["pur_price"]) * Convert.ToDouble(dt1.Rows[b][6 + a]));
         }
     }
     //----
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
 %>
 <tr class=xl28 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 width=30 style='height:15.0pt;width:23pt' x:num><%= i + 1 %></td>
  <td class=xl64 width=158 style='border-left:none;width:119pt'><%= dt1.Rows[i]["item_lname"] %></td>
  <td class=xl65 style='border-left:none'><%= dt1.Rows[i]["item_fname"] %></td>
  <td class=xl65 style='border-left:none'><%= dt1.Rows[i]["spec01_nm"] %></td>
  <td class=xl66 width=103 style='border-left:none;width:77pt' x:num x:fmla="=SUM(H<%= i + 10 %>:S<%= i + 10 %>)"></td>
  <td class=xl67 style='border-left:none' x:num><span style='mso-spacerun:yes'></span><%= dt1.Rows[i]["pur_price"]%></td>
  <td class=xl68 width=103 style='border-left:none;width:77pt' x:num><span
  style='mso-spacerun:yes'></span><%= dt1.Rows[i]["total_amount"]%></td>
  <td class=xl73 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_01"]%></td>
  <td class=xl73 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_02"]%></td>
  <td class=xl70 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_03"]%></td>
  <td class=xl69 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_04"]%></td>
  <td class=xl70 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_05"]%></td>
  <td class=xl70 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_06"]%></td>
  <td class=xl70 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_07"]%></td>
  <td class=xl70 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_08"]%></td>
  <td class=xl71 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_09"]%></td>
  <td class=xl72 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_10"]%></td>
  <td class=xl70 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_11"]%></td>
  <td class=xl71 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_12"]%></td>
  <td class=xl71 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_13"]%></td>
  <td class=xl71 style='border-left:none' x:num><%= dt1.Rows[i]["req_qty_14"]%></td>
 </tr>
 <% }%> 
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=6 height=28 class=xl78 width=643 style='border-right:.5pt solid black;
  height:21.0pt;width:483pt'>Total Amount (Thành ti&#7873;n) (VND)</td>
  <td class=xl32 width=103 style='border-left:none;width:77pt'
  x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>G10:G<%= dt1.Rows.Count+9%><%}else{%>G12:G12<%}%>)"><span style='mso-spacerun:yes'>      
  </span></td>
  <td class=xl34 width=56 style='width:42pt' x:num><%= arr[0] %></td>
  <td class=xl34 width=56 style='width:42pt' x:num><%= arr[1] %></td>
  <td class=xl35 width=56 style='width:42pt' x:num><%= arr[2] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[3] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[4] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[5] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[6] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[7] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[8] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[9] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[10] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[11] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[12] %></td>
  <td class=xl31 width=56 style='width:42pt' x:num><%= arr[13] %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl75 width=643 style='border-right:.5pt solid black;
  height:15.0pt;width:483pt'>&#44208;&#51116; &#54620;&#46020; ( Ngân sách
  phòng ban) (USD)</td>
  <td class=xl29 width=103 style='border-top:none;border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl38 align=center width=56 style='border-top:none;border-left:none;
  width:42pt' x:num></td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl75 width=643 style='border-right:.5pt solid black;
  height:15.0pt;width:483pt'>&#45572;&#51201; &#49324;&#50857;&#50529;
  (S&#7889; c&#7897;ng d&#7891;n)<span style='mso-spacerun:yes'>  </span>(USD)</td>
  <td class=xl29 width=103 style='border-top:none;border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl75 width=643 style='border-right:.5pt solid black;
  height:15.0pt;width:483pt'>&#51092;&#50668;&#50529; (Ngân sách còn
  l&#7841;i)<span style='mso-spacerun:yes'>  </span>(USD)</td>
  <td class=xl29 width=103 style='border-top:none;border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
  <td class=xl39 width=56 style='border-top:none;border-left:none;width:42pt'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
