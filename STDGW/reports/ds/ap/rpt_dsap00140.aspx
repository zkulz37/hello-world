<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_master_pk = Request.QueryString["master_pk"];

    string para = "'" + p_master_pk + "'";
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("sale.sp_rpt_dsap00140");
    dt1 = ESysLib.TableReadOpenCursor("sale.sp_rpt_dsap00140_1", para);
    dt2 = ESysLib.TableReadOpenCursor("sale.sp_rpt_dsap00140_2", para);

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsap00080_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsap00080_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsap00080_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Khanh</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2011-11-17T07:14:06Z</o:LastPrinted>
  <o:Created>2007-01-10T03:24:47Z</o:Created>
  <o:LastSaved>2011-11-17T07:18:03Z</o:LastSaved>
  <o:Company>VINAGENUWIN</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P";
	margin:.54in .39in .44in .55in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;}
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
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font16
	{color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font17
	{color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font18
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font19
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font20
	{color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font22
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font23
	{color:windowtext;
	font-size:14.0pt;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl29
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
.xl30
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt dotted windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt dotted windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style17;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style17;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style17;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style17;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style17;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style17;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style17;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl53
	{mso-style-parent:style17;
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
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt dotted windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt dotted windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style17;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;
	border:.5pt dotted windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:20.0pt;
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
.xl59
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dotted windowtext;
	border-bottom:none;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dotted windowtext;
	border-bottom:none;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Collection Slip</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9180</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1980</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Collection Slip'!$11:$11</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="4"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=749 style='border-collapse:
 collapse;table-layout:fixed;width:563pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=152 span=3 style='mso-width-source:userset;mso-width-alt:5558;
 width:114pt'>
 <col width=137 style='mso-width-source:userset;mso-width-alt:5010;width:103pt'>
 <col width=64 style='width:48pt'>
 <col width=165 span=2 style='mso-width-source:userset;mso-width-alt:6034;
 width:124pt'>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 width=46 style='height:15.0pt;width:35pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s4097" type="#_x0000_t75" style='position:absolute;
   margin-left:15.75pt;margin-top:.75pt;width:78pt;height:42pt;z-index:1'>
   <v:imagedata src="rpt_dsap00080_files/image001.jpg" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s4098" type="#_x0000_t75" style='position:absolute;
   margin-left:15.75pt;margin-top:.75pt;width:78pt;height:42pt;z-index:2'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="img00001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:21px;margin-top:1px;width:104px;
  height:56px'><img width=104 height=56 src="rpt_dsap00080_files/image002.jpg"
  v:shapes="_x0000_s4097 _x0000_s4098"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl25 width=46 style='height:15.0pt;width:35pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 width=110 style='width:83pt'></td>
  <td class=xl26 width=152 style='width:114pt'><%=dt.Rows[0]["partner_name"]%></td>
  <td class=xl26 width=152 style='width:114pt'></td>
  <td class=xl25 width=152 style='width:114pt'></td>
  <td class=xl28 width=137 style='width:103pt'>Tel: <%=dt.Rows[0]["phone_no"]%></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl61 width=456 style='width:342pt'><%=dt.Rows[0]["addr1"]%></td>
  <td class=xl28>Fax: <%=dt.Rows[0]["fax_no"]%></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td class=xl25>Tax No: <%=dt.Rows[0]["tax_code"]%></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl29>Print Date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
 </tr>
 <tr class=xl24 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=6 rowspan=2 height=86 class=xl58 width=749 style='height:64.5pt;
  width:563pt'>PHI&#7870;U CHI<font class="font16"> <br>
    </font><font class="font23">( PAYMENT SLIP )</font></td>
 </tr>
 <tr class=xl24 height=43 style='mso-height-source:userset;height:32.25pt'>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl62 width=156 style='height:22.5pt;width:118pt'>Nhà cung cấp<font class="font8">Supplier<span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl66 style='border-right:.5pt dotted black'><%=dt1.Rows[0]["partner_name"]%></td>
  <td class=xl32 style='border-left:none'>S&#7889; phi&#7871;u <font
  class="font18">Slip No<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl55 style='border-left:none'><%=dt1.Rows[0]["slip_no"]%></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl62 width=156 style='height:22.5pt;width:118pt'>&#272;i&#7879;n
  tho&#7841;i <font class="font8">tel<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl27 x:num><%=dt1.Rows[0]["phone_no"]%></td>
  <td class=xl26>Fax : <font class="font5"><%=dt1.Rows[0]["fax_no"]%></font></td>
  <td class=xl32 style='border-top:none'>Ngày<font class="font19"> </font><font
  class="font18">Date<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt1.Rows[0]["slip_date"]%></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl62 width=156 style='height:22.5pt;width:118pt'>&#272;&#7883;a
  ch&#7881; <font class="font8">Address<span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl27 style='border-right:.5pt dotted black'><%=dt1.Rows[0]["addr1"]%></td>
  <td class=xl56 width=152 style='border-top:none;border-left:none;width:114pt'>S&#7889;
  ti&#7873;n <font class="font18">Amount (</font><font class="font20"><%=dt1.Rows[0]["tr_ccy"]%>)</font></td>
  <td class=xl57 width=137 style='border-top:none;border-left:none;width:103pt'
  x:num ><span
  style='mso-spacerun:yes'> </span><%=dt1.Rows[0]["total_amount"]%></td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl62 width=156 style='height:22.5pt;width:118pt'>Di&#7877;n
  gi&#7843;i<font class="font8"> Description</font></td>
  <td colspan=2 class=xl27 style='border-right:.5pt dotted black'><%=dt1.Rows[0]["payment_desc"]%></td>
  <td class=xl32 style='border-top:none;border-left:none'>S&#7889; H&#272; <font
  class="font18">Ref No</font><font class="font17"><span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl34><span
  style='mso-spacerun:yes'> </span><%=dt1.Rows[0]["ref_no"]%><span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl50 width=46 style='height:30.0pt;width:35pt'>TT<br>
    <font class="font8">No</font></td>
  <td class=xl51 width=110 style='border-left:none;width:83pt'>S&#7889;
  &#272;&#7889;i chi&#7871;u<br>
    <font class="font6">(</font><font class="font8">Ref No.)</font></td>
  <td class=xl51 width=152 style='border-left:none;width:114pt'>S&#7889;
  ti&#7873;n yêu c&#7847;u<br>
    <font class="font8">(Req Amount)</font></td>
  <td class=xl51 width=152 style='border-left:none;width:114pt'>S&#7889;
  ti&#7873;n chi<br>
    <font class="font8">(Payment Amount)</font></td>
  <td class=xl51 width=152 style='border-left:none;width:114pt'>Còn
  l&#7841;i<br>
    <font class="font6">(</font><font class="font8">Balance Amount)</font></td>
  <td class=xl52 width=137 style='border-left:none;width:103pt'>Ghi chú<br>
    <font class="font8">Remark</font></td>
 </tr>
 
 <%
     double total1 = 0, total2 = 0, total3 = 0;
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
         total1 = total1 + CommondLib.ConvertToDbl(dt2.Rows[i]["item_amount"]);
         total2 = total2 + CommondLib.ConvertToDbl(dt2.Rows[i]["total_amount"]);
         total3 = total3 + CommondLib.ConvertToDbl(dt2.Rows[i]["bal_amount"]);
            %>
<tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl35 width=46 style='height:22.5pt;border-top:none;
  width:35pt' x:num><%=i+1%></td>
  <td class=xl36 width=110 style='border-top:none;width:83pt'><%=dt2.Rows[i]["ref_no"]%></td>
  <td class=xl37 width=152 style='border-top:none;width:114pt' x:num><%=dt2.Rows[i]["item_amount"]%></td>
  <td class=xl38 width=152 style='border-top:none;width:114pt' x:num><%=dt2.Rows[i]["total_amount"]%></td>
  <td class=xl37 width=152 style='border-top:none;width:114pt' x:num><%=dt2.Rows[i]["bal_amount"]%></td>
  <td class=xl47 width=137 style='border-top:none;width:103pt'><%=dt2.Rows[i]["description"]%></td>
 </tr>
            <% 
     }
  %>
 
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=2 height=40 class=xl63 width=156 style='height:30.0pt;width:118pt;border-top:.5pt hairline windowtext'>T&#7893;ng
  c&#7897;ng<font class="font6"> </font><font class="font8">Total (</font><font
  class="font22"><%=dt1.Rows[0]["tr_ccy"]%></font><font class="font8">)</font></td>
  <td class=xl53 width=152 style='border-top:none;border-left:none;width:114pt'
  x:num><%=total1%></td>
  <td class=xl53 width=152 style='border-top:none;border-left:none;width:114pt'
  x:num><%=total2%></td>
  <td class=xl53 width=152 style='border-top:none;border-left:none;width:114pt'
  x:num><%=total3%></td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=6 style='height:21.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 colspan=2 style='height:33.75pt;mso-ignore:colspan'></td>
  <td class=xl33 width=152 style='width:114pt'>Ng&#432;&#7901;i l&#7853;p<br>
    <font class="font10">(Charger)</font></td>
  <td class=xl33 width=152 style='border-left:none;width:114pt'>Ng&#432;&#7901;i
  ki&#7875;m<font class="font5"> <br>
    </font><font class="font10">(Check by)</font></td>
  <td class=xl33 width=152 style='border-left:none;width:114pt'>K&#7871; toán
  tr&#432;&#7903;ng <br>
    <font class="font10">(Chief Acc.)</font></td>
  <td class=xl33 width=137 style='border-left:none;width:103pt'>Giám
  &#273;&#7889;c<font class="font10"> <br>
    (Director)</font></td>
 </tr>
 <tr height=91 style='mso-height-source:userset;height:68.25pt'>
  <td height=91 colspan=2 style='height:68.25pt;mso-ignore:colspan'></td>
  <td class=xl30 width=152 style='border-top:none;width:114pt'>&nbsp;</td>
  <td class=xl30 width=152 style='border-top:none;border-left:none;width:114pt'>&nbsp;</td>
  <td class=xl30 width=152 style='border-top:none;border-left:none;width:114pt'>&nbsp;</td>
  <td class=xl30 width=137 style='border-top:none;border-left:none;width:103pt'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=46 style='width:35pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=152 style='width:114pt'></td>
  <td width=152 style='width:114pt'></td>
  <td width=152 style='width:114pt'></td>
  <td width=137 style='width:103pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
