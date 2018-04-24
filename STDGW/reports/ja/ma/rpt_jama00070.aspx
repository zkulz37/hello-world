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
<link rel=File-List href="rpt_jama00070_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jama00070_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jama00070_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Lee</o:LastAuthor>
  <o:LastPrinted>2010-04-13T01:58:51Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-04-13T01:59:14Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .5in .75in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	color:black;
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
.xl31
	{mso-style-parent:style0;
	color:black;
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
.xl32
	{mso-style-parent:style0;
	color:black;
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
.xl33
	{mso-style-parent:style0;
	color:black;
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
.xl34
	{mso-style-parent:style0;
	color:black;
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
.xl35
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl36
	{mso-style-parent:style0;
	color:black;
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
.xl37
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
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
.xl47
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
.xl48
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
.xl49
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl50
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
.xl51
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl52
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
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
.xl59
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
.xl60
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
.xl61
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style20;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl72
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>A&amp;G Exp</x:Name>
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
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>19</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
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
  <x:Formula>='A&amp;G Exp'!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=583 style='border-collapse:
 collapse;table-layout:fixed;width:439pt'>
 <col class=xl70 width=277 style='mso-width-source:userset;mso-width-alt:10130;
 width:208pt'>
 <col class=xl27 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl27 width=48 span=2 style='mso-width-source:userset;mso-width-alt:
 1755;width:36pt'>
 <col class=xl27 width=46 span=2 style='mso-width-source:userset;mso-width-alt:
 1682;width:35pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td colspan=6 height=42 class=xl72 width=519 style='height:31.5pt;width:391pt'>Administrative
  &amp; General Expenses<br>
    From <%=dtFrom%> To <%=dtTo%></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=137 style='mso-height-source:userset;height:102.75pt'>
  <td height=137 class=xl28 width=277 style='height:102.75pt;width:208pt'>Administrative
  &amp; General Expenses</td>
  <td rowspan=3 class=xl29 width=54 style='width:41pt'>Account code</td>
  <td rowspan=3 class=xl29 width=48 style='width:36pt'>Dept Code</td>
  <td rowspan=2 class=xl30 width=48 style='width:36pt'>Executive Office</td>
  <td rowspan=2 class=xl31 width=46 style='width:35pt'>Accounting &amp;
  Control, &amp; IT</td>
  <td rowspan=2 class=xl32 width=46 style='width:35pt'>Purchasing, Receiving
  &amp; Inventory Control</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'
  x:str="'in Vietnam Dong">in Vietnam Dong</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl37 width=140 style='border-right:1.0pt solid black;
  border-left:none;width:106pt'>Section</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt;border-top:none'>PAYROLL &amp;
  RELATED EXPENSES</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Salaries
  &amp; Wages</td>
  <td class=xl46 style='border-top:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>mapping</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Base Salary</td>
  <td class=xl25 style='border-top:none'>300</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Allowances</td>
  <td class=xl25 style='border-top:none'>301</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Extra Wages / Overtime</td>
  <td class=xl25 style='border-top:none'>302</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Bonus</td>
  <td class=xl25 style='border-top:none'>303</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Vacation Pay</td>
  <td class=xl25 style='border-top:none'>304</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Sick Pay</td>
  <td class=xl25 style='border-top:none'>305</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Severance Pay</td>
  <td class=xl25 style='border-top:none'>306</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>309</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Employee
  Benefits</td>
  <td class=xl46 style='border-top:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>mapping</td>
  <td class=xl48 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Employee Meals</td>
  <td class=xl25 style='border-top:none'>330</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl52 width=277 style='height:12.75pt;border-top:none;
  width:208pt'><span style='mso-spacerun:yes'> </span>- Workmen Compensation
  Insurance</td>
  <td class=xl25 style='border-top:none'>331</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Social Insurance</td>
  <td class=xl25 style='border-top:none'>332</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- National Pension</td>
  <td class=xl25 style='border-top:none'>333</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Medical Expenses</td>
  <td class=xl25 style='border-top:none'>334</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>339</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Total Payroll
  &amp; Related Exp</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt;border-top:none'>OTHER
  EXPENSES</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Bank Charges</td>
  <td class=xl25 style='border-top:none'>500</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl58 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Credit &amp;
  Collection Charges</td>
  <td class=xl25 style='border-top:none'>505</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Credit Card
  Charges</td>
  <td class=xl25 style='border-top:none'>506</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Donations</td>
  <td class=xl25 style='border-top:none'>510</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Employee
  Transportation</td>
  <td class=xl25 style='border-top:none'>514</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl57 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Entertainment</td>
  <td class=xl25 style='border-top:none'>515</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>External
  Audit Expenses</td>
  <td class=xl25 style='border-top:none'>516</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Insurance
  (non property)</td>
  <td class=xl25 style='border-top:none'>521</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Internal
  Audit Expenses</td>
  <td class=xl25 style='border-top:none'>522</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Internet
  Access</td>
  <td class=xl61 style='border-top:none'>523</td>
  <td class=xl46 style='border-top:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Laundry &amp;
  Valet - Uniform</td>
  <td class=xl25 style='border-top:none'>531</td>
  <td class=xl54 style='border-top:none;border-left:none' x:num>51</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl57 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Legal &amp;
  Other Professional Fees</td>
  <td class=xl25 style='border-top:none'>532</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>License &amp;
  Taxes</td>
  <td class=xl25 style='border-top:none'>533</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Loss &amp;
  Damages to Guest Property</td>
  <td class=xl25 style='border-top:none'>534</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Meeting
  Expenses</td>
  <td class=xl25 style='border-top:none'>540</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Printing
  &amp; Stationery</td>
  <td class=xl25 style='border-top:none'>557</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Postage</td>
  <td class=xl25 style='border-top:none'>570</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Provision for
  Doubtful Debts</td>
  <td class=xl25 style='border-top:none'>573</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Sport &amp;
  Social Activities</td>
  <td class=xl25 style='border-top:none'>588</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Telecommunication</td>
  <td class=xl25 style='border-top:none'>590</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Trade
  Association &amp; Public Dues</td>
  <td class=xl25 style='border-top:none'>591</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Training
  Expenses</td>
  <td class=xl25 style='border-top:none'>592</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Travelling
  Expenses</td>
  <td class=xl25 style='border-top:none'>594</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Uniform
  Replacement</td>
  <td class=xl25 style='border-top:none'>600</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl25 style='border-top:none'>602</td>
  <td class=xl46 style='border-top:none;border-left:none'>51</td>
  <td class=xl48 style='border-top:none;border-left:none'>1</td>
  <td class=xl49 style='border-top:none;border-left:none'>2</td>
  <td class=xl50 style='border-top:none;border-left:none'>3</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Total Other
  Expenses</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl62 style='height:15.0pt;border-top:none'>INFORMATION
  SYSTEMS</td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Contract
  Service</td>
  <td class=xl25 style='border-top:none'>610</td>
  <td class=xl25 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Equipment
  Maintenance</td>
  <td class=xl25 style='border-top:none'>611</td>
  <td class=xl25 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Operating
  Supplies</td>
  <td class=xl25 style='border-top:none'>612</td>
  <td class=xl25 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Printing
  &amp; Stationery</td>
  <td class=xl25 style='border-top:none'>613</td>
  <td class=xl25 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Software</td>
  <td class=xl25 style='border-top:none'>614</td>
  <td class=xl25 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Telecommunication
  / Data Line</td>
  <td class=xl25 style='border-top:none'>615</td>
  <td class=xl25 style='border-top:none;border-left:none'>51</td>
  <td class=xl59 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl60 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl45 style='height:13.5pt;border-top:none'>Others</td>
  <td class=xl63 style='border-top:none'>619</td>
  <td class=xl63 style='border-top:none;border-left:none'>51</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl65 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl67 style='height:12.75pt;border-top:none'>Total IS
  Expenses</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl67 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl68 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl67 style='height:12.75pt;border-top:none'>Total A&amp;G
  Expenses</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl67 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl69 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl69 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl69 style='height:12.75pt;border-top:none'>Number of
  Employees</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=277 style='width:208pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
