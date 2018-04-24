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
<link rel=File-List href="a_files/filelist.xml">
<link rel=Edit-Time-Data href="a_files/editdata.mso">
<link rel=OLE-Object-Data href="a_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Lee</o:LastAuthor>
  <o:LastPrinted>2010-04-12T08:12:21Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-04-12T08:12:50Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .75in .75in .75in;
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
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;}
.xl27
	{mso-style-parent:style0;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl29
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
.xl30
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-rotate:90;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
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
.xl32
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl35
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
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-rotate:90;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	mso-rotate:90;}
.xl38
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl39
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style16;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl45
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
.xl46
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl50
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl51
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
.xl52
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl53
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
.xl54
	{mso-style-parent:style16;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
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
.xl56
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl59
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
.xl60
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl62
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
.xl63
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-style:italic;
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
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl68
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
.xl69
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl74
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl75
	{mso-style-parent:style16;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl78
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Rooms PNL</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
  <x:Formula>='Rooms PNL'!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=493 style='border-collapse:
 collapse;table-layout:fixed;width:371pt'>
 <col class=xl49 width=277 style='mso-width-source:userset;mso-width-alt:10130;
 width:208pt'>
 <col class=xl77 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl78 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl77 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl77 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl77 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl26 width=64 span=4 style='width:48pt'>
 <col class=xl26 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=6 height=39 class=xl24 width=493 style='height:29.25pt;
  width:371pt'>Rooms Statement of Income &amp; Expenses<br>
    From <%=dtFrom%> To <%=dtTo%></td>
 </tr>
 <tr height=99 style='mso-height-source:userset;height:74.25pt'>
  <td height=99 class=xl27 width=277 style='height:74.25pt;width:208pt'>Rooms
  Statement of Income &amp; Expenses</td>
  <td rowspan=3 class=xl28 width=54 style='width:41pt'>Account Code</td>
  <td rowspan=3 class=xl29 width=43 style='width:32pt'>Dept Code</td>
  <td rowspan=2 class=xl30>Front Office</td>
  <td rowspan=2 class=xl31 width=40 style='width:30pt'>House keeping</td>
  <td rowspan=2 class=xl32 width=41 style='width:31pt'>Property Mgmt</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt;border-top:none'
  x:str="'in Vietnam Dong">in Vietnam Dong</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl40 style='border-right:1.0pt solid black;border-left:
  none'>Section</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt;border-top:none'>REVENUE</td>
  <td class=xl34 width=54 style='border-top:none;width:41pt'>&nbsp;</td>
  <td class=xl35 width=43 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl40 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'
  x:str="Individual ">Individual<span style='mso-spacerun:yes'> </span></td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>mapping</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'>                    </span>- Corporate</td>
  <td class=xl50 style='border-top:none'>100</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'>                    </span>- Leisure</td>
  <td class=xl50 style='border-top:none'>101</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'>                    </span>- Packages</td>
  <td class=xl50 style='border-top:none'>102</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'
  x:str="Groups    ">Groups<span style='mso-spacerun:yes'>    </span></td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>mapping</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'>                    </span>- Corporate</td>
  <td class=xl50 style='border-top:none'>108</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'>                    </span>- Leisure</td>
  <td class=xl50 style='border-top:none'>109</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl54 style='height:12.75pt;border-top:none'>Extended Stay</td>
  <td class=xl50 style='border-top:none'>115</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'>Property
  Management Fee</td>
  <td class=xl50 style='border-top:none'>119</td>
  <td class=xl51 style='border-top:none;border-left:none'>01</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt;border-top:none'>Total Room
  Revenue</td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl57 style='height:15.75pt;border-top:none'>PAYROLL &amp;
  RELATED EXPENSES</td>
  <td class=xl58 style='border-top:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Salaries
  &amp; Wages</td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>mapping</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Base Salary</td>
  <td class=xl50 style='border-top:none'>300</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Allowances</td>
  <td class=xl50 style='border-top:none'>301</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Extra Wages / Overtime</td>
  <td class=xl50 style='border-top:none'>302</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Bonus</td>
  <td class=xl50 style='border-top:none'>303</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Vacation Pay</td>
  <td class=xl50 style='border-top:none'>304</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Sick Pay</td>
  <td class=xl50 style='border-top:none'>305</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Severance Pay</td>
  <td class=xl50 style='border-top:none'>306</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl50 style='border-top:none'>309</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Employee
  Benefits</td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>mapping</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Employee Meals</td>
  <td class=xl64 style='border-top:none'>330</td>
  <td class=xl51 style='border-top:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Workmen Compensation Insurance</td>
  <td class=xl64 style='border-top:none'>331</td>
  <td class=xl51 style='border-top:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Social Insurance</td>
  <td class=xl64 style='border-top:none'>332</td>
  <td class=xl51 style='border-top:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- National Pension</td>
  <td class=xl64 style='border-top:none'>333</td>
  <td class=xl51 style='border-top:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Medical Expenses</td>
  <td class=xl64 style='border-top:none'>334</td>
  <td class=xl51 style='border-top:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl64 style='border-top:none'>339</td>
  <td class=xl51 style='border-top:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl65 style='height:12.75pt;border-top:none'>Total Payroll
  &amp; Related Exp</td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl57 style='height:15.75pt;border-top:none'>OPERATING
  EQUIPMENT</td>
  <td class=xl58 style='border-top:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Chinaware</td>
  <td class=xl50 style='border-top:none'>400</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Glassware</td>
  <td class=xl50 style='border-top:none'>401</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Silverware</td>
  <td class=xl50 style='border-top:none'>402</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Linen</td>
  <td class=xl50 style='border-top:none'>403</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Uniform</td>
  <td class=xl50 style='border-top:none'>404</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl65 style='height:12.75pt;border-top:none'>Total OE</td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl56 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl57 style='height:15.75pt;border-top:none'>OTHER
  EXPENSES</td>
  <td class=xl58 style='border-top:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'>Cleaning
  Expenses - Contracts</td>
  <td class=xl44 style='border-top:none' x:num>501</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'>Commission -
  TA</td>
  <td class=xl44 style='border-top:none' x:num>502</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Decoration</td>
  <td class=xl44 style='border-top:none' x:num>510</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Employee
  Transportation</td>
  <td class=xl44 style='border-top:none' x:num>514</td>
  <td class=xl51 style='border-top:none;border-left:none'>01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Entertainment</td>
  <td class=xl44 style='border-top:none' x:num>515</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Internet
  Access</td>
  <td class=xl44 style='border-top:none' x:num>523</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Laundry &amp;
  Valet - Linen</td>
  <td class=xl50 style='border-top:none'>530</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Laundry &amp;
  Valet - Uniform</td>
  <td class=xl50 style='border-top:none'>531</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Licences/permits</td>
  <td class=xl44 style='border-top:none' x:num>533</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Music &amp;
  Entertainment</td>
  <td class=xl44 style='border-top:none' x:num>542</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'
  x:str="Operating Supplies: ">Operating Supplies:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Cleaning</td>
  <td class=xl44 style='border-top:none' x:num>547</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'
  x:str=" - Guest "><span style='mso-spacerun:yes'> </span>- Guest<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 style='border-top:none' x:num>550</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'
  x:str=" - Guest - F&amp;B "><span style='mso-spacerun:yes'> </span>- Guest -
  F&amp;B<span style='mso-spacerun:yes'> </span></td>
  <td class=xl44 style='border-top:none' x:num>551</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Printing &amp; Stationery</td>
  <td class=xl44 style='border-top:none' x:num>557</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl44 style='border-top:none' x:num>565</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Postage</td>
  <td class=xl44 style='border-top:none' x:num>570</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Removal of
  Waste Matters</td>
  <td class=xl44 style='border-top:none' x:num>577</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Reservation
  Expenses</td>
  <td class=xl44 style='border-top:none' x:num>578</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Sport &amp;
  Social Activities</td>
  <td class=xl44 style='border-top:none' x:num>587</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Telecommunication</td>
  <td class=xl44 style='border-top:none' x:num>590</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Training
  Expenses</td>
  <td class=xl44 style='border-top:none' x:num>592</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Transportation
  - Guest</td>
  <td class=xl44 style='border-top:none' x:num>593</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>TV &amp;
  Cable Subscription</td>
  <td class=xl44 style='border-top:none' x:num>595</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Utensils</td>
  <td class=xl44 style='border-top:none' x:num>601</td>
  <td class=xl51 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl48 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=18 style='height:13.5pt'>
  <td height=18 class=xl43 style='height:13.5pt;border-top:none'>Others</td>
  <td class=xl67 style='border-top:none' x:num>602</td>
  <td class=xl68 style='border-top:none;border-left:none' x:str="'01">01</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl70 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num>3</td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl72 style='height:12.75pt;border-top:none'>Total Other
  Expenses</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl72 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl72 style='height:12.75pt;border-top:none'>Total Cost
  &amp; Expenses</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl72 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl72 style='height:12.75pt;border-top:none'>Rooms
  Departmental Profit</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl72 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl76 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>Key Rooms</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'
  x:str="Occupied Rooms ">Occupied Rooms<span style='mso-spacerun:yes'> </span></td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>Occupancy %</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>Average Rate
  (VND)</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>Average Rate
  (US$)</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>RevPar</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'
  x:str="Number of Guest ">Number of Guest<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>Average
  Length of Stay</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>%tage of FIT</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>% tage of
  Groups</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl75 style='height:12.75pt;border-top:none'>%tage of
  Extended Stay</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl76 style='height:12.75pt;border-top:none'>No. of
  employee</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt'><span
  style='mso-spacerun:yes'> </span>- Total</td>
  <td class=xl73></td>
  <td class=xl74></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl49 style='height:14.25pt'><span
  style='mso-spacerun:yes'> </span>- Front Office</td>
  <td class=xl77></td>
  <td class=xl78></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl49 style='height:14.25pt'><span
  style='mso-spacerun:yes'> </span>- Housekeeping</td>
  <td class=xl77></td>
  <td class=xl78></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl49 style='height:14.25pt'><span
  style='mso-spacerun:yes'> </span>- Property Management</td>
  <td class=xl77></td>
  <td class=xl78></td>
  <td colspan=3 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=277 style='width:208pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=41 style='width:31pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
