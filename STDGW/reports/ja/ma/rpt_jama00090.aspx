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
<link rel=File-List href="jama00090_files/filelist.xml">
<link rel=Edit-Time-Data href="jama00090_files/editdata.mso">
<link rel=OLE-Object-Data href="jama00090_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Lee</o:LastAuthor>
  <o:LastPrinted>2010-04-12T08:27:11Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-04-12T08:27:39Z</o:LastSaved>
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
.xl26
	{mso-style-parent:style0;}
.xl27
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
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
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
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
	border-left:1.0pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
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
	font-weight:700;
	font-style:italic;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	text-align:center;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl49
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl50
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
    <x:Name>SM Exp</x:Name>
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
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:Formula>='SM Exp'!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=430 style='border-collapse:
 collapse;table-layout:fixed;width:323pt'>
 <col class=xl48 width=317 style='mso-width-source:userset;mso-width-alt:11593;
 width:238pt'>
 <col class=xl45 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl45 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=3 height=41 class=xl49 width=430 style='height:30.75pt;
  width:323pt'>Sales &amp; Marketing Expenses<br>
    From <%=dtFrom%> To <%=dtTo%></td>
 </tr>
 <tr height=76 style='mso-height-source:userset;height:57.0pt'>
  <td height=76 class=xl24 width=317 style='height:57.0pt;width:238pt'>Sales
  &amp; Marketing Expenses</td>
  <td rowspan=2 class=xl25 width=58 style='width:44pt'>Account Code</td>
  <td rowspan=2 class=xl25 width=55 style='width:41pt'>Dept Code</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none'
  x:str="'in Vietnam Dong">in Vietnam Dong</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt;border-top:none'>PAYROLL &amp;
  RELATED EXPENSES</td>
  <td class=xl30 style='border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Salaries
  &amp; Wages</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Base Salary</td>
  <td class=xl32 style='border-top:none'>300</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Allowances</td>
  <td class=xl32 style='border-top:none'>301</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Extra Wages / Overtime</td>
  <td class=xl32 style='border-top:none'>302</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Bonus</td>
  <td class=xl32 style='border-top:none'>303</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Vacation Pay</td>
  <td class=xl32 style='border-top:none'>304</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Sick Pay</td>
  <td class=xl32 style='border-top:none'>305</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Severance Pay</td>
  <td class=xl32 style='border-top:none'>306</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl32 style='border-top:none'>309</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Employee
  Benefits</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Employee Meals</td>
  <td class=xl32 style='border-top:none'>330</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 width=317 style='height:12.75pt;border-top:none;
  width:238pt'><span style='mso-spacerun:yes'> </span>- Workmen Compensation
  Insurance</td>
  <td class=xl32 style='border-top:none'>331</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Social Insurance</td>
  <td class=xl32 style='border-top:none'>332</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- National Pension</td>
  <td class=xl32 style='border-top:none'>333</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Medical Expenses</td>
  <td class=xl32 style='border-top:none'>334</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl32 style='border-top:none'>339</td>
  <td class=xl32 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr class=xl36 height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'>Total Payroll
  &amp; Related Exp</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl36 height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt;border-top:none'>OTHER
  EXPENSES</td>
  <td class=xl30 style='border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Employee
  Transportation</td>
  <td class=xl32 style='border-top:none'>514</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Entertainment</td>
  <td class=xl32 style='border-top:none'>515</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Internet
  Access</td>
  <td class=xl32 style='border-top:none'>523</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Laundry &amp;
  Valet - Uniform</td>
  <td class=xl32 style='border-top:none'>531</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Meeting
  Expenses</td>
  <td class=xl32 style='border-top:none'>540</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Printing
  &amp; Stationery</td>
  <td class=xl32 style='border-top:none'>557</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Postage</td>
  <td class=xl32 style='border-top:none'>570</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Promotions</td>
  <td class=xl32 style='border-top:none'>572</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Royalty &amp;
  Frequent Stay Programs</td>
  <td class=xl32 style='border-top:none'>579</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Sales Office
  Expenses</td>
  <td class=xl32 style='border-top:none'>586</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Sport &amp;
  Social Activities</td>
  <td class=xl32 style='border-top:none'>588</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Telecommunication</td>
  <td class=xl32 style='border-top:none'>590</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Trade
  Association &amp; Public Dues</td>
  <td class=xl32 style='border-top:none'>591</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Training
  Expenses</td>
  <td class=xl32 style='border-top:none'>592</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Travelling
  Expenses</td>
  <td class=xl32 style='border-top:none'>594</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Uniform
  Replacement</td>
  <td class=xl32 style='border-top:none'>600</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'
  x:str="Others ">Others<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 style='border-top:none'>602</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt;border-top:none'>Sub-Total</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt;border-top:none'>Advertising
  Expenses</td>
  <td class=xl30 style='border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl36 height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Agency Fees</td>
  <td class=xl32 style='border-top:none'>900</td>
  <td class=xl37 style='border-top:none;border-left:none'>52</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Exchange Due
  Bills</td>
  <td class=xl32 style='border-top:none'>901</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Outdoor Signs</td>
  <td class=xl32 style='border-top:none'>902</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Print -
  Directories</td>
  <td class=xl32 style='border-top:none'>910</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Print -
  F&amp;B</td>
  <td class=xl32 style='border-top:none'>911</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Print -
  Magazines</td>
  <td class=xl32 style='border-top:none'>912</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Print -
  Newspapers</td>
  <td class=xl32 style='border-top:none'>913</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Print -
  Overseas</td>
  <td class=xl32 style='border-top:none'>914</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Productions</td>
  <td class=xl32 style='border-top:none'>915</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Radio &amp;
  TV</td>
  <td class=xl32 style='border-top:none'>920</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Trade Show</td>
  <td class=xl32 style='border-top:none'>921</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl32 style='border-top:none'>929</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt;border-top:none'>Sub-total</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt;border-top:none'>Mechandising
  Expenses</td>
  <td class=xl30 style='border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>In House Graphic</td>
  <td class=xl32 style='border-top:none'>930</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Direct Mail</td>
  <td class=xl32 style='border-top:none'>931</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Other Selling
  Aids</td>
  <td class=xl32 style='border-top:none'>932</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Point of
  Sales Material</td>
  <td class=xl32 style='border-top:none'>933</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt;border-top:none'>Sub-Total</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl35 style='border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt;border-top:none'>Public
  Relation &amp; Publicity Expenses</td>
  <td class=xl30 style='border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Civic &amp;
  Community Project</td>
  <td class=xl32 style='border-top:none'>940</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Outside PR
  Consultancy Fees</td>
  <td class=xl32 style='border-top:none'>941</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Photography</td>
  <td class=xl32 style='border-top:none'>942</td>
  <td class=xl37 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl31 style='height:13.5pt;border-top:none'>Others</td>
  <td class=xl39 style='border-top:none'>943</td>
  <td class=xl40 style='border-top:none;border-left:none'>53</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl41 style='height:12.75pt;border-top:none'>Sub - Total</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'>Total Sales
  &amp; Marketing Expenses</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl43 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'>Key Rooms</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'>Occupancy:</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Rooms</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- 18 Holes</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- E9</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'>No. of Golf
  Club Members</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'>No. of
  Tournaments</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'>No. of Golf
  Groups</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt;border-top:none'>Number of
  Employees</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=317 style='width:238pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
