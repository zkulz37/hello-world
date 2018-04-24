<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("CRM");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
	string dtFrom = Request["dtfrom"].Substring(0, 4) + "/" + Request["dtfrom"].Substring(4, 2) + "/" + Request["dtfrom"].Substring(6, 2);
    string dtTo	  = Request["dtto"].Substring(0, 4) + "/" + Request["dtto"].Substring(4, 2) + "/" + Request["dtto"].Substring(6, 2);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_jama00030_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jama00030_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jama00030_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Lee</o:LastAuthor>
  <o:LastPrinted>2010-04-13T01:15:40Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-04-13T01:16:51Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .75in .5in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-horizontal-page-align:center;}
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
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
	{mso-style-parent:style0;}
.xl25
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl47
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl52
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl53
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl54
	{mso-style-parent:style0;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-rotate:90;}
.xl56
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl57
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-rotate:90;}
.xl59
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl60
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl61
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style16;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl84
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style16;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Golf Course PNL </x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>99</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Golf Course PNL '!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=618 style='border-collapse:
 collapse;table-layout:fixed;width:465pt'>
 <col class=xl28 width=322 style='mso-width-source:userset;mso-width-alt:11776;
 width:242pt'>
 <col class=xl45 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl45 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl45 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl45 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl30 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl30 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=7 height=40 class=xl48 width=618 style='height:30.0pt;width:465pt'>Golf
  Course Statement of Income & Expenses<br>
    Form <%=dtFrom%> To <%=dtTo%> </td>
 </tr>
 <tr height=135 style='mso-height-source:userset;height:101.25pt'>
  <td height=135 class=xl54 width=322 style='height:101.25pt;width:242pt'>Golf
  Course Statement of Income &amp; Expenses</td>
  <td rowspan=2 class=xl46 width=58 style='width:44pt'>Account Code</td>
  <td rowspan=2 class=xl55>Depart code</td>
  <td rowspan=2 class=xl51 width=40 style='width:30pt'>Golf Operation</td>
  <td rowspan=2 class=xl52 width=42 style='width:32pt'>Course Mtce</td>
  <td rowspan=2 class=xl49 width=53 style='width:40pt'>Vehicle &amp; Machinery
  Mtce</td>
  <td rowspan=2 class=xl56 width=55 style='width:41pt'>Building &amp; General
  Mtce</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl57 style='height:16.5pt;border-top:none'
  x:str="'in Vietnam Dong">in Vietnam Dong</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl61 style='height:15.75pt;border-top:none'>REVENUE</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'
  x:str="18-Holes Golf ">18-Holes Golf<span style='mso-spacerun:yes'> </span></td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Green Fees</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Members' Guests</td>
  <td class=xl25 style='border-top:none'>130</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Visitors FIT</td>
  <td class=xl25 style='border-top:none'>131</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Visitors - Groups</td>
  <td class=xl25 style='border-top:none'>132</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Visitors - Extended Stay</td>
  <td class=xl25 style='border-top:none'>133</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Tournament</td>
  <td class=xl25 style='border-top:none'>134</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Packages</td>
  <td class=xl25 style='border-top:none'>135</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>sub-total</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Caddie Fee</td>
  <td class=xl25 style='border-top:none'>140</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'
  x:str="Cart Fee ">Cart Fee<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>141</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Annual Dues</td>
  <td class=xl25 style='border-top:none'>142</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>sub-total 18
  holes</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>Par-3 Golf</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Green Fees</td>
  <td class=xl25 style='border-top:none'>150</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Members' Guests</td>
  <td class=xl25 style='border-top:none'>151</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Visitors</td>
  <td class=xl27 style='border-top:none'>17</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>sub-total</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Caddie Fee</td>
  <td class=xl25 style='border-top:none'>152</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'
  x:str="Cart Fee ">Cart Fee<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>153</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>sub-total
  Par-3</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Driving Range
  Golf Ball Rental</td>
  <td class=xl25 style='border-top:none'>154</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Teaching Pro
  Tuition Fees</td>
  <td class=xl25 style='border-top:none'>155</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>Total Revenue</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt;border-top:none'>PAYROLL &amp;
  RELATED EXPENSES</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Salaries
  &amp; Wages</td>
  <td class=xl38 style='border-top:none'>mapping</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Base Salary</td>
  <td class=xl25 style='border-top:none'>300</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Allowances</td>
  <td class=xl25 style='border-top:none'>301</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Extra Wages / Overtime</td>
  <td class=xl25 style='border-top:none'>302</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Bonus</td>
  <td class=xl25 style='border-top:none'>303</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Vacation Pay</td>
  <td class=xl25 style='border-top:none'>304</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Sick Pay</td>
  <td class=xl25 style='border-top:none'>305</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Severance Pay</td>
  <td class=xl25 style='border-top:none'>306</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>309</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Employee
  Benefits</td>
  <td class=xl38 style='border-top:none'>mapping</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Employee Meals</td>
  <td class=xl25 style='border-top:none'>310</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 width=322 style='height:12.75pt;border-top:none;
  width:242pt'><span style='mso-spacerun:yes'> </span>- Workmen Compensation
  Insurance</td>
  <td class=xl25 style='border-top:none'>311</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Social Insurance</td>
  <td class=xl25 style='border-top:none'>312</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- National Pension</td>
  <td class=xl25 style='border-top:none'>313</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Medical Expenses</td>
  <td class=xl25 style='border-top:none'>314</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>319</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>Total Payroll
  &amp; Related Exp</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>Payroll cost
  %</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt;border-top:none'>OPERATING
  EQUIPMENT</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Chinaware</td>
  <td class=xl25 style='border-top:none'>400</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Glassware</td>
  <td class=xl25 style='border-top:none'>401</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Silverware</td>
  <td class=xl25 style='border-top:none'>402</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Linen</td>
  <td class=xl25 style='border-top:none'>403</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'
  x:str="Uniform ">Uniform<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>404</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>Total OE</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl73 style='height:14.25pt;border-top:none'>OE %</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt;border-top:none'>OTHER
  EXPENSES</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl63 style='height:14.25pt;border-top:none'>Cleaning
  Expenses<span style='mso-spacerun:yes'>  </span>- Contracts</td>
  <td class=xl27 style='border-top:none'>501</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Decoration</td>
  <td class=xl27 style='border-top:none'>510</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Employee
  Transportation</td>
  <td class=xl25 style='border-top:none'>514</td>
  <td class=xl25 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Entertainment</td>
  <td class=xl25 style='border-top:none'>515</td>
  <td class=xl25 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Internet
  Access</td>
  <td class=xl27 style='border-top:none'>523</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Laundry &amp;
  Valet - Linen</td>
  <td class=xl25 style='border-top:none'>530</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Laundry &amp;
  Valet - Uniform</td>
  <td class=xl25 style='border-top:none'>531</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Licences/permits</td>
  <td class=xl25 style='border-top:none'>533</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Music &amp;
  Entertainment</td>
  <td class=xl25 style='border-top:none'>542</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl75 style='height:14.25pt;border-top:none'
  x:str="Operating Supplies: ">Operating Supplies:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Cleaning</td>
  <td class=xl25 style='border-top:none'>547</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Driving Range Golf Balls</td>
  <td class=xl25 style='border-top:none'>548</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Guest</td>
  <td class=xl25 style='border-top:none'>550</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Printing &amp; Stationery</td>
  <td class=xl25 style='border-top:none'>557</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>565</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Postage</td>
  <td class=xl25 style='border-top:none'>570</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Removal of
  Waste Matters</td>
  <td class=xl25 style='border-top:none'>577</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Sport &amp;
  Social Activities</td>
  <td class=xl25 style='border-top:none'>588</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Telecommunication</td>
  <td class=xl25 style='border-top:none'>590</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Training
  Expenses</td>
  <td class=xl25 style='border-top:none'>592</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>Transportation
  - Guest</td>
  <td class=xl25 style='border-top:none'>593</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt;border-top:none'>TV &amp;
  Cable Subscription</td>
  <td class=xl25 style='border-top:none'>595</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl63 style='height:14.25pt;border-top:none'>Others</td>
  <td class=xl25 style='border-top:none'>602</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl33 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl62 style='height:14.25pt;border-top:none'>Total Other
  Expenses</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl62 style='height:14.25pt;border-top:none'>In US$</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl61 style='height:15.75pt;border-top:none'>GOLF CART
  EXPENSES</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Batteries</td>
  <td class=xl25 style='border-top:none'>700</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Repairs &amp;
  Maintenance</td>
  <td class=xl25 style='border-top:none'>701</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'
  x:str="Spares ">Spares<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>702</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl25 style='border-top:none'>709</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>Total Golf
  Cart Expenses</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt;border-top:none'>VEHICLE &amp;
  MACHINERY MTCE EXPENSE<span style='display:none'>S</span></td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Cleaning
  Supplies</td>
  <td class=xl25 style='border-top:none'>710</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Lubricants</td>
  <td class=xl25 style='border-top:none'>711</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'
  x:str="Spares ">Spares<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>712</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Tires</td>
  <td class=xl25 style='border-top:none'>713</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Tools</td>
  <td class=xl25 style='border-top:none'>714</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl25 style='border-top:none'>719</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Total
  Vehicles &amp; Machinery Expenses</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt;border-top:none'>COURSE
  MAINTENANCE EXPENSES</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Carpentery
  &amp; Masonery</td>
  <td class=xl25 style='border-top:none'>720</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'
  x:str="Chemical ">Chemical<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>721</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Fertilizer</td>
  <td class=xl25 style='border-top:none'>722</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Flowers
  Plants</td>
  <td class=xl25 style='border-top:none'>723</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Irrigations
  &amp; Drainage</td>
  <td class=xl25 style='border-top:none'>730</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Lubricants</td>
  <td class=xl25 style='border-top:none'>731</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Sand</td>
  <td class=xl25 style='border-top:none'>740</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Seeds</td>
  <td class=xl25 style='border-top:none'>741</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none' x:str="Tools ">Tools<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>742</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Topsoil</td>
  <td class=xl25 style='border-top:none'>743</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl25 style='border-top:none'>749</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Total Course
  Mtce Expenses</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt;border-top:none'>BUILDING
  &amp; GENERAL MAINTENANCE E<span style='display:none'>XPENSES</span></td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Air Condition
  &amp; Refrigeration</td>
  <td class=xl25 style='border-top:none'>750</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Building</td>
  <td class=xl25 style='border-top:none'>751</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Consultancy
  Fees</td>
  <td class=xl25 style='border-top:none'>756</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Curtain &amp;
  Draperies</td>
  <td class=xl25 style='border-top:none'>757</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Data
  Processing Equipment</td>
  <td class=xl25 style='border-top:none'>760</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Electrical</td>
  <td class=xl25 style='border-top:none'>761</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Elevators</td>
  <td class=xl25 style='border-top:none'>762</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Floor &amp;
  Wall Coverings</td>
  <td class=xl25 style='border-top:none'>766</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Furniture</td>
  <td class=xl25 style='border-top:none'>767</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Ground &amp;
  Landscaping</td>
  <td class=xl25 style='border-top:none'>770</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Kitchen
  Equipment</td>
  <td class=xl25 style='border-top:none'>771</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Laundry
  Equipment</td>
  <td class=xl25 style='border-top:none'>772</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Mechanical</td>
  <td class=xl25 style='border-top:none'>773</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Painting
  &amp; Decoration</td>
  <td class=xl25 style='border-top:none'>780</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Plumbing
  &amp; Heating</td>
  <td class=xl25 style='border-top:none'>781</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Recreation
  Facilities</td>
  <td class=xl25 style='border-top:none'>782</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Signs</td>
  <td class=xl25 style='border-top:none'>783</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'
  x:str="Supplies: ">Supplies:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Electric Bulbs</td>
  <td class=xl25 style='border-top:none'>791</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Engineering Supplies</td>
  <td class=xl25 style='border-top:none'>792</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>795</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Telecommunication
  Equipment</td>
  <td class=xl25 style='border-top:none'>800</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none' x:str="Tools ">Tools<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>801</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl25 style='border-top:none'>801</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>Total
  Building &amp; Gen Mtce Expenses</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl78 style='height:15.0pt;border-top:none'>Maintenance
  Contract Services</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl79 style='height:12.75pt;border-top:none'>Consultancy
  Fees</td>
  <td class=xl25 style='border-top:none'>810</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl79 style='height:12.75pt;border-top:none'>Maintenance
  Contracts</td>
  <td class=xl25 style='border-top:none'>811</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl77 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>Total Gen
  Mtce Expenses</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>TOTAL MTCE
  EXPENSES</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>ENERGY COSTS</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Electricity</td>
  <td class=xl25 style='border-top:none'>820</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Diesel</td>
  <td class=xl25 style='border-top:none'>821</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none' x:str="Gas ">Gas<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>822</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>1</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>Gasoline</td>
  <td class=xl25 style='border-top:none'>823</td>
  <td class=xl27 style='border-top:none;border-left:none'>03</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>2</td>
  <td class=xl35 style='border-top:none;border-left:none'>3</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl64 style='height:13.5pt;border-top:none'>Water</td>
  <td class=xl81 style='border-top:none'>824</td>
  <td class=xl40 style='border-top:none;border-left:none'>03</td>
  <td class=xl41 style='border-top:none;border-left:none'>1</td>
  <td class=xl42 style='border-top:none;border-left:none'>2</td>
  <td class=xl42 style='border-top:none;border-left:none'>3</td>
  <td class=xl43 style='border-top:none;border-left:none'>4</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl82 style='height:12.75pt;border-top:none'>Total Energy
  Costs</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl84 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl85 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl84 style='height:12.75pt;border-top:none'>Total Cost
  &amp; Expenses</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl84 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>No. of
  Members</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>No. of
  Associated Members</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>Occupancy %</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- 18 Holes</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- E9</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>No. of Days
  Closed</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>No. of Guests</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Members &amp; Associated Membes</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Members' Guests</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Visitors</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Tournaments</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Groups</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Driving Range</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'
  x:str="No. of Tournaments ">No. of Tournaments<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>No.of Groups</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>Green Fees</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Members' Guests</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Visitors</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Tournaments</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Groups</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>No. of Golf
  Cars used by Guests</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl86 style='height:12.75pt;border-top:none'>Ratio of
  Guests using Golf Cars</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl87 style='height:14.25pt;border-top:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl88 style='height:12.75pt;border-top:none'>No. of
  employee</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl88 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Total</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl88 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Operation</td>
  <td colspan=4 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl88 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Caddies</td>
  <td colspan=4 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl88 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Course Maintenance</td>
  <td colspan=4 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl88 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Vehicle &amp;Machinery Maintenance</td>
  <td colspan=4 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl88 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Building &amp; General Maintenance</td>
  <td colspan=4 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=322 style='width:242pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
