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
<link rel=File-List href="jama00080_files/filelist.xml">
<link rel=Edit-Time-Data href="jama00080_files/editdata.mso">
<link rel=OLE-Object-Data href="jama00080_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Lee</o:LastAuthor>
  <o:LastPrinted>2010-04-12T07:16:34Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-04-12T07:16:49Z</o:LastSaved>
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
	mso-horizontal-page-align:center;
	mso-vertical-page-align:center;}
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
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
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
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
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
	border-left:1.0pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl47
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	text-align:center;}
.xl49
	{mso-style-parent:style20;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl52
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl54
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
.xl55
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
.xl56
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
	border-left:1.0pt solid windowtext;
	mso-rotate:90;}
.xl57
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-rotate:90;}
.xl58
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-rotate:90;}
.xl59
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-rotate:90;}
.xl60
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
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
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>HR Exp</x:Name>
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
     <x:TopRowVisible>27</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>36</x:ActiveRow>
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
  <x:Formula>='HR Exp'!$2:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=489 style='border-collapse:
 collapse;table-layout:fixed;width:367pt'>
 <col class=xl51 width=328 style='mso-width-source:userset;mso-width-alt:11995;
 width:246pt'>
 <col class=xl48 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl48 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl48 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl48 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=5 height=39 class=xl52 width=489 style='height:29.25pt;
  width:367pt'>Human Resources Expenses<br>
    Form <%=dtFrom%> To <%=dtTo%></td>
 </tr>
 <tr height=76 style='mso-height-source:userset;height:57.0pt'>
  <td height=76 class=xl24 width=328 style='height:57.0pt;width:246pt'>Human
  Resources Expenses</td>
  <td rowspan=3 class=xl54 width=45 style='width:34pt'>Account Code</td>
  <td rowspan=3 class=xl54 width=40 style='width:30pt'>Dept Code</td>
  <td rowspan=2 class=xl56>Personnel</td>
  <td rowspan=2 class=xl58>Training</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'
  x:str="'in Vietnam Dong">in Vietnam Dong</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl60 style='border-right:1.0pt solid black;border-left:
  none'>Section</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'>PAYROLL &amp;
  RELATED EXPENSES</td>
  <td class=xl28 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Salaries
  &amp; Wages</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Base Salary</td>
  <td class=xl32 style='border-top:none'>300</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Allowances</td>
  <td class=xl32 style='border-top:none'>301</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Extra Wages / Overtime</td>
  <td class=xl32 style='border-top:none'>302</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Bonus</td>
  <td class=xl32 style='border-top:none'>303</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Vacation Pay</td>
  <td class=xl32 style='border-top:none'>304</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Sick Pay</td>
  <td class=xl32 style='border-top:none'>305</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Severance Pay</td>
  <td class=xl32 style='border-top:none'>306</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl32 style='border-top:none'>309</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt;border-top:none'>Employee
  Benefits</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Employee Meals</td>
  <td class=xl32 style='border-top:none'>330</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 width=328 style='height:12.75pt;border-top:none;
  width:246pt'><span style='mso-spacerun:yes'> </span>- Workmen Compensation
  Insurance</td>
  <td class=xl32 style='border-top:none'>331</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Social Insurance</td>
  <td class=xl32 style='border-top:none'>332</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- National Pension</td>
  <td class=xl32 style='border-top:none'>333</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Medical Expenses</td>
  <td class=xl32 style='border-top:none'>334</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl32 style='border-top:none'>339</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt;border-top:none'>Total Payroll
  &amp; Related Exp</td>
  <td class=xl28 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl28 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'>OTHER
  EXPENSES</td>
  <td class=xl28 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Community
  Relation</td>
  <td class=xl32 style='border-top:none'>503</td>
  <td class=xl36 style='border-top:none;border-left:none' x:num>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Employee
  Housing</td>
  <td class=xl32 style='border-top:none'>512</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Employee
  Relocation</td>
  <td class=xl32 style='border-top:none'>513</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Employee
  Transportation</td>
  <td class=xl32 style='border-top:none'>514</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Entertainment</td>
  <td class=xl32 style='border-top:none'>515</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Internet
  Access</td>
  <td class=xl39 style='border-top:none'>523</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Laundry &amp;
  Valet - Uniform</td>
  <td class=xl32 style='border-top:none'>531</td>
  <td class=xl36 style='border-top:none;border-left:none' x:num>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Printing
  &amp; Stationery</td>
  <td class=xl32 style='border-top:none'>557</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Postage</td>
  <td class=xl32 style='border-top:none'>570</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'
  x:str="Recruitment ">Recruitment<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 style='border-top:none'>576</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Sport &amp;
  Social Activities</td>
  <td class=xl32 style='border-top:none'>588</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Telecommunication</td>
  <td class=xl32 style='border-top:none'>590</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Trade
  Association &amp; Public Dues</td>
  <td class=xl32 style='border-top:none'>591</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'
  x:str="Training ">Training<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 style='border-top:none'>592</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Uniform
  Replacement</td>
  <td class=xl32 style='border-top:none'>600</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl32 style='border-top:none'>602</td>
  <td class=xl38 style='border-top:none;border-left:none'>52</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl40 style='height:12.75pt;border-top:none'>Total Other
  Expenses</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl40 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'>Training
  Expenses</td>
  <td class=xl32 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Couse Fees</td>
  <td class=xl32 style='border-top:none'>620</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Printing
  &amp; Stationery</td>
  <td class=xl32 style='border-top:none'>621</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Refreshment</td>
  <td class=xl32 style='border-top:none'>622</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'
  x:str="Trainer Fees ">Trainer Fees<span style='mso-spacerun:yes'> </span></td>
  <td class=xl32 style='border-top:none'>623</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Training
  Materials</td>
  <td class=xl32 style='border-top:none'>624</td>
  <td class=xl32 style='border-top:none;border-left:none'>52</td>
  <td class=xl41 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl33 style='height:13.5pt;border-top:none'>Others</td>
  <td class=xl42 style='border-top:none'>629</td>
  <td class=xl42 style='border-top:none;border-left:none'>52</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Total
  Training Expenses</td>
  <td class=xl46></td>
  <td class=xl47></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl46></td>
  <td class=xl47></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl46></td>
  <td class=xl47></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>Total Human
  Resources Expenses</td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl50 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl50 style='height:12.75pt;border-top:none'>Number of
  Employees</td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=328 style='width:246pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=39 style='width:29pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
