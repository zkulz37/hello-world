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
<link rel=File-List href="jama00100_files/filelist.xml">
<link rel=Edit-Time-Data href="jama00100_files/editdata.mso">
<link rel=OLE-Object-Data href="jama00100_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Lee</o:LastAuthor>
  <o:LastPrinted>2010-04-12T08:39:13Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-04-12T08:39:47Z</o:LastSaved>
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
.xl25
	{mso-style-parent:style0;}
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
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl33
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
.xl34
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
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
.xl38
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
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
.xl39
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
.xl40
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
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>POMEC Exp</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
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
       <x:ActiveRow>13</x:ActiveRow>
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
  <x:Formula>='POMEC Exp'!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=417 style='border-collapse:
 collapse;table-layout:fixed;width:313pt'>
 <col class=xl36 width=293 style='mso-width-source:userset;mso-width-alt:10715;
 width:220pt'>
 <col class=xl51 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl51 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=3 height=43 class=xl52 width=417 style='height:32.25pt;
  width:313pt'>POMEC (Property Operation Maintenance &amp; Energy Costs)<br>
    From <%=dtFrom%> To <%=dtTo%></td>
 </tr>
 <tr height=93 style='height:69.75pt'>
  <td height=93 class=xl24 width=293 style='height:69.75pt;width:220pt'>POMEC
  (Property Operation Maintenance &amp; Energy Costs)</td>
  <td rowspan=2 class=xl37 width=63 style='width:47pt'>Account Code</td>
  <td rowspan=2 class=xl37 width=61 style='width:46pt'>Dept Code</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'
  x:str="'in Vietnam Dong">in Vietnam Dong</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'>PAYROLL &amp;
  RELATED EXPENSES</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl28 style='height:14.25pt;border-top:none'>Salaries
  &amp; Wages</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl40 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Base Salary</td>
  <td class=xl29 style='border-top:none'>300</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Allowances</td>
  <td class=xl29 style='border-top:none'>301</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Extra Wages / Overtime</td>
  <td class=xl29 style='border-top:none'>302</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Bonus</td>
  <td class=xl29 style='border-top:none'>303</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Vacation Pay</td>
  <td class=xl29 style='border-top:none'>304</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Sick Pay</td>
  <td class=xl29 style='border-top:none'>305</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Severance Pay</td>
  <td class=xl29 style='border-top:none'>306</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl29 style='border-top:none'>309</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl28 style='height:14.25pt;border-top:none'>Employee
  Benefits</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl40 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Employee Meals</td>
  <td class=xl29 style='border-top:none'>330</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl31 width=293 style='height:14.25pt;border-top:none;
  width:220pt'><span style='mso-spacerun:yes'> </span>- Workmen Compensation
  Insurance</td>
  <td class=xl29 style='border-top:none'>331</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Social Insurance</td>
  <td class=xl29 style='border-top:none'>332</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- National Pension</td>
  <td class=xl29 style='border-top:none'>333</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Medical Expenses</td>
  <td class=xl29 style='border-top:none'>334</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl29 style='border-top:none'>339</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl41 style='height:14.25pt;border-top:none'>Total Payroll
  &amp; Related Exp</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl41 style='height:14.25pt;border-top:none'>In US$</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'>OTHER
  EXPENSES</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'>Employee
  Transportation</td>
  <td class=xl29 style='border-top:none'>514</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'>Entertainment</td>
  <td class=xl29 style='border-top:none'>515</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'>Internet
  Access</td>
  <td class=xl29 style='border-top:none'>523</td>
  <td class=xl29 style='border-top:none;border-left:none'>523</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'>Laundry &amp;
  Valet - Uniform</td>
  <td class=xl29 style='border-top:none'>531</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'>Licenses
  &amp; Taxes</td>
  <td class=xl29 style='border-top:none'>533</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'>Meeting
  Expenses</td>
  <td class=xl29 style='border-top:none'>540</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl42 style='height:14.25pt;border-top:none'>Supplies:</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'
  x:str=" - Cleaning "><span style='mso-spacerun:yes'> </span>- Cleaning<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29 style='border-top:none'>547</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Printing &amp; Stationery</td>
  <td class=xl29 style='border-top:none'>557</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl29 style='border-top:none'>565</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'>Postage</td>
  <td class=xl29 style='border-top:none'>570</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'>Removal of
  Waste Matters</td>
  <td class=xl29 style='border-top:none'>577</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'>Sport &amp;
  Social Activities</td>
  <td class=xl29 style='border-top:none'>588</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'>Telecommunication</td>
  <td class=xl29 style='border-top:none'>590</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'>Trade
  Association &amp; Public Dues</td>
  <td class=xl29 style='border-top:none'>591</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'>Training
  Expenses</td>
  <td class=xl29 style='border-top:none'>592</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'>Uniform
  Replacement</td>
  <td class=xl29 style='border-top:none'>600</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl30 style='height:14.25pt;border-top:none'>Others</td>
  <td class=xl29 style='border-top:none'>602</td>
  <td class=xl40 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl43 style='height:14.25pt;border-top:none'>Sub - Total</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl41 style='height:14.25pt;border-top:none'>In US$</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'>Repairs &amp;
  Maintenance Expenses:</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Air Condition
  &amp; Refrigeration</td>
  <td class=xl29 style='border-top:none'>750</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Building</td>
  <td class=xl29 style='border-top:none'>751</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Consultancy
  Fees</td>
  <td class=xl29 style='border-top:none'>756</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'>Curtain &amp;
  Draperies</td>
  <td class=xl29 style='border-top:none'>757</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Data
  Processing Equipment</td>
  <td class=xl29 style='border-top:none'>760</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Electrical</td>
  <td class=xl29 style='border-top:none'>761</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Elevators</td>
  <td class=xl29 style='border-top:none'>762</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Floor &amp;
  Wall Coverings</td>
  <td class=xl29 style='border-top:none'>766</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Furniture</td>
  <td class=xl29 style='border-top:none'>767</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Ground &amp;
  Landscaping</td>
  <td class=xl29 style='border-top:none'>770</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Kitchen
  Equipment</td>
  <td class=xl29 style='border-top:none'>771</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Laundry
  Equipment</td>
  <td class=xl29 style='border-top:none'>772</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Mechanical</td>
  <td class=xl29 style='border-top:none'>773</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Painting
  &amp; Decoration</td>
  <td class=xl29 style='border-top:none'>780</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Plumbing
  &amp; Heating</td>
  <td class=xl29 style='border-top:none'>781</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Recreation
  Facilities</td>
  <td class=xl29 style='border-top:none'>782</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Signs</td>
  <td class=xl29 style='border-top:none'>783</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'
  x:str="Supplies: ">Supplies:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Chemical</td>
  <td class=xl29 style='border-top:none'>790</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Electric Bulbs</td>
  <td class=xl29 style='border-top:none'>791</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Engineering Supplies</td>
  <td class=xl29 style='border-top:none'>792</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl29 style='border-top:none'>795</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Telecommunication
  Equipment</td>
  <td class=xl29 style='border-top:none'>800</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none' x:str="Tools ">Tools<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29 style='border-top:none'>801</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Waste Water
  Treatment</td>
  <td class=xl29 style='border-top:none'>802</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl29 style='border-top:none'>809</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl43 style='height:14.25pt;border-top:none'>Sub - Total</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl41 style='height:14.25pt;border-top:none'>In US$</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'>Contract
  Services</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Consultancy
  Fees</td>
  <td class=xl29 style='border-top:none'>810</td>
  <td class=xl33 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Maintenance
  Contracts</td>
  <td class=xl29 style='border-top:none'>811</td>
  <td class=xl33 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'>Sub - Total</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'>Utility Cost
  - Non Golf</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Diesel</td>
  <td class=xl29 style='border-top:none'>820</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Electricity</td>
  <td class=xl29 style='border-top:none'>821</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Gas</td>
  <td class=xl29 style='border-top:none'>822</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>Gasoline</td>
  <td class=xl29 style='border-top:none'>823</td>
  <td class=xl29 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl44 style='height:13.5pt;border-top:none'>Water</td>
  <td class=xl34 style='border-top:none'>824</td>
  <td class=xl34 style='border-top:none;border-left:none'>54</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'>Sub - Total</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl48 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl48 style='height:12.75pt;border-top:none'>Total POMEC
  Expenses</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl48 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl48 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'
  x:str="Key Rooms ">Key Rooms<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'>Occupancy %</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'>Occupied Room</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'>Number of
  Employees</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl50 style='height:12.75pt'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl50 style='height:12.75pt'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl50 style='height:12.75pt'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=293 style='width:220pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=61 style='width:46pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
