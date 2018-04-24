<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
	DataTable dt_header;
    dt_header = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00096_1");
		
    string _date         = Request.QueryString["plan_date"];
	string _factory_pk   = Request.QueryString["factory_pk"];	
	string _factory_name = Request.QueryString["factory_name"];
    string p_spec_chk = Request.QueryString["p_spec_chk"];

    string _para = " '" + _factory_pk + "','" + _date + "','" + p_spec_chk + "'";
	DataTable dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00096", _para);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00096_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00096_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00096_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2011-03-28T03:13:13Z</o:LastPrinted>
  <o:Created>2011-03-28T02:43:12Z</o:Created>
  <o:LastSaved>2011-03-28T03:14:22Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.22in .17in .17in .17in;
	mso-header-margin:.2in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
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
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>16155</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
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

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=964 style='border-collapse:
 collapse;table-layout:fixed;width:723pt'>
 <col class=xl25 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl25 width=55 style='mso-width-source:userset;mso-width-alt:2200;
 width:50pt'>
 <col class=xl25 width=60 style='mso-width-source:userset;mso-width-alt:2500;
 width:49pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2800;
 width:71pt'>
 <col class=xl25 width=65 style='mso-width-source:userset;mso-width-alt:2200;
 width:56pt'>
 <col class=xl25 width=60 span=11 style='mso-width-source:userset;mso-width-alt:
 2194;width:45pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=10 height=43 class=xl40 width=660 style='height:32.25pt;
  width:495pt'>PREPARATION/HANDLE REPORT</td>
  <td width=60 style='width:45pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:4.5pt;margin-top:3pt;width:219pt;height:61.5pt;z-index:1'>
   <v:imagedata src="rpt_fppr00096_files/image001.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:6px;margin-top:4px;width:292px;
  height:82px'><img width=292 height=82 src="rpt_fppr00096_files/image002.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=43 class=xl24 width=60 style='height:32.25pt;width:45pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=60 style='width:45pt'></td>
  <td class=xl24 width=60 style='width:45pt'></td>
  <td class=xl24 width=60 style='width:45pt'></td>
  <td class=xl24 width=60 style='width:45pt'></td>
  <td class=xl24 width=60 style='width:45pt'></td>  
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl27 style='height:18.75pt'>Fac</td>
  <td colspan=9 class=xl41><%= _factory_name %></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl27 style='height:18.75pt'>Date</td>
  <td colspan=9 class=xl41><%= System.DateTime.ParseExact(_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td rowspan=2 height=36 class=xl42 style='height:27.0pt'>R/G</td>
  <td rowspan=2 class=xl37>Buyer</td>
  <td rowspan=2 class=xl37>P/O</td>
  <td rowspan=2 class=xl37>Style</td>
  <td rowspan=2 class=xl37>Spec</td>
  <td rowspan=2 class=xl37>Qty</td>
  <td colspan=4 class=xl37 style='border-left:none'>Cutting</td>
  <td colspan=4 class=xl37 style='border-left:none'>Preparation</td>
  <td colspan=2 class=xl37 style='border-left:none'>Handle</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl26 style='height:40.0pt;border-top:none;border-left:none'><%=dt_header.Rows[0]["col_01"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_header.Rows[0]["col_02"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_header.Rows[0]["col_03"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_header.Rows[0]["col_04"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_header.Rows[0]["col_05"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_header.Rows[0]["col_06"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_header.Rows[0]["col_07"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_header.Rows[0]["col_08"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_header.Rows[0]["col_09"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt_header.Rows[0]["col_10"]%></td>
 </tr>
<% 
	 string s_routing_group     = "";
	 
	 int s_plan_qty      	    = 0;
	 int s_cut_in_line 			= 0;
	 int s_total_cut_qty        = 0;
	 int s_cut_wh 			    = 0;
	 int s_total_cut_out_qty    = 0;
	 int s_pre_in_line 			= 0;
	 int s_total_pre_qty        = 0;
	 int s_pre_wh 				= 0;
	 int s_total_pre_out_qty	= 0;
	 int s_sew_in_line		    = 0;
	 int s_sew_qty	            = 0;	 
	 
	 if ( dt.Rows.Count > 0 )
	 {
	 	s_routing_group = dt.Rows[0]["routing_group"].ToString();
	 }
	 
  	 for (int i = 0; i < dt.Rows.Count; i++)
     {   	  			
 	    if ( s_routing_group != dt.Rows[i]["routing_group"].ToString() )
		{		
 %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=5 height=44 class=xl43 style='border-bottom:2.0pt double black;
  height:33.0pt'>Total</td>
  <td class=xl58 style='border-bottom:2.0pt double black;border-top:none' x:num><%=s_plan_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none;border-left:none' x:num><%=s_cut_in_line%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none' x:num ><%=s_total_cut_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none;border-left:none' x:num><%=s_total_cut_out_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none' x:num ><%=s_cut_wh%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;background:#CCFFFF;border-top:none;border-left:none' x:num><%=s_pre_in_line%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;background:#CCFFFF;border-top:none' x:num ><%=s_total_pre_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;background:#CCFFFF;border-top:none;border-left:none' x:num><%=s_total_pre_out_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;background:#CCFFFF;border-top:none' x:num><%=s_pre_wh%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none;border-left:none' x:num><%=s_sew_in_line%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none' x:num><%=s_sew_qty%></td>

 </tr> 
  
<%	
			s_routing_group = dt.Rows[i]["routing_group"].ToString();
			s_plan_qty  		= 0;
			s_cut_in_line  		= 0;
			s_total_cut_qty  	= 0;
			s_cut_wh  			= 0;
			s_total_cut_out_qty = 0;
			s_pre_in_line  		= 0;
			s_total_pre_qty  	= 0;
			s_pre_wh  			= 0;
			s_total_pre_out_qty = 0;
			s_sew_in_line  		= 0;
			s_sew_qty  			= 0;	
		}
			 
	 	s_plan_qty  		= s_plan_qty  		  + Convert.ToInt32(dt.Rows[i]["plan_qty"].ToString()          ) ;
		s_cut_in_line  		= s_cut_in_line  	  + Convert.ToInt32(dt.Rows[i]["cut_in_line"].ToString()       ) ;
		s_total_cut_qty  	= s_total_cut_qty  	  + Convert.ToInt32(dt.Rows[i]["total_cut_qty"].ToString()     ) ;
		s_cut_wh            = s_cut_wh  	      + Convert.ToInt32(dt.Rows[i]["cut_wh"].ToString()            ) ;
		s_total_cut_out_qty = s_total_cut_out_qty + Convert.ToInt32(dt.Rows[i]["total_cut_out_qty"].ToString() ) ;
		s_pre_in_line  	    = s_pre_in_line  	  + Convert.ToInt32(dt.Rows[i]["pre_in_line"].ToString()       ) ;
		s_total_pre_qty  	= s_total_pre_qty  	  + Convert.ToInt32(dt.Rows[i]["total_pre_qty"].ToString()     ) ;
		s_pre_wh  	        = s_pre_wh  	      + Convert.ToInt32(dt.Rows[i]["pre_wh"].ToString()            ) ;
		s_total_pre_out_qty = s_total_pre_out_qty + Convert.ToInt32(dt.Rows[i]["total_pre_out_qty"].ToString() ) ;		
		s_sew_in_line  		= s_sew_in_line  	  + Convert.ToInt32(dt.Rows[i]["total_handle_qty"].ToString()       ) ;		
		s_sew_qty  	        = s_sew_qty  	      + Convert.ToInt32(dt.Rows[i]["handle_shortage"].ToString()         ) ;   
%>

 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=44 class=xl46 style='border-bottom:.5pt solid black;
  height:33.0pt;border-top:none'><%=dt.Rows[i]["routing_group"]%></td>
  <td class=xl44 width=85 style='border-bottom:.5pt solid black;
  border-top:none;width:64pt'><%=dt.Rows[i]["partner_id"]%></td>
  <td class=xl44 width=65 style='border-bottom:.5pt solid black;
  border-top:none;width:49pt'><%=dt.Rows[i]["ref_po_no"]%></td>
  <td class=xl44 width=95 style='border-bottom:.5pt solid black;
  border-top:none;width:71pt'><%=dt.Rows[i]["style_id"]%></td>
  <td class=xl44 width=75 style='border-bottom:.5pt solid black;
  border-top:none;width:56pt'><%=dt.Rows[i]["spec"]%></td>
  <td class=xl52 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=dt.Rows[i]["plan_qty"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_cut_qty"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;border-top:none' x:num><%=dt.Rows[i]["cut_in_line"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_cut_out_qty"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;border-top:none' x:num><%=dt.Rows[i]["cut_wh"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;background:#CCFFFF;border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_pre_qty"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;background:#CCFFFF;border-top:none' x:num><%=dt.Rows[i]["pre_in_line"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;background:#CCFFFF;border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_pre_out_qty"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;background:#CCFFFF;border-top:none' x:num><%=dt.Rows[i]["pre_wh"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_handle_qty"]%></td>
  <td class=xl62 style='border-bottom:.5pt solid black;border-top:none' x:num><%=dt.Rows[i]["handle_shortage"]%></td>

 </tr>
<%
  }
%>

 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=5 height=44 class=xl43 style='border-bottom:2.0pt double black;
  height:33.0pt'>Total</td>
  <td class=xl58 style='border-bottom:2.0pt double black;border-top:none' x:num><%=s_plan_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none;border-left:none' x:num><%=s_total_cut_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none' x:num ><%=s_cut_in_line%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none;border-left:none' x:num><%=s_total_cut_out_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none' x:num ><%=s_cut_wh%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;background:#CCFFFF;border-top:none;border-left:none' x:num><%=s_total_pre_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;background:#CCFFFF;border-top:none' x:num ><%=s_pre_in_line%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;background:#CCFFFF;border-top:none;border-left:none' x:num><%=s_total_pre_out_qty%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;background:#CCFFFF;border-top:none' x:num><%=s_pre_wh%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none;border-left:none' x:num><%=s_sew_in_line%></td>
  <td class=xl64 style='border-bottom:2.0pt double black;border-top:none' x:num><%=s_sew_qty%></td>
  
 </tr> 
  
  <%
  	 
  %>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=14 class=xl25 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
  
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
