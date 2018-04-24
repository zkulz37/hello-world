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
<link rel=File-List href="rpt_jama00050_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jama00050_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jama00050_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Lee</o:LastAuthor>
  <o:LastPrinted>2010-04-13T01:46:00Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-04-13T01:46:13Z</o:LastSaved>
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
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;}
.xl33
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
.xl34
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
.xl35
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
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
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl38
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
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
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
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
.xl42
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
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
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
.xl44
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
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
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	text-align:center;}
.xl62
	{mso-style-parent:style20;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style16;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>OOD PNL</x:Name>
    <x:WorksheetOptions>
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
     <x:TopRowVisible>69</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>76</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:Formula>='OOD PNL'!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=524 style='border-collapse:
 collapse;table-layout:fixed;width:393pt'>
 <col class=xl24 width=351 style='mso-width-source:userset;mso-width-alt:12836;
 width:263pt'>
 <col class=xl61 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl61 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl32 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl61 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=5 height=36 class=xl68 width=524 style='height:27.0pt;width:393pt'>Other
  Operated Departments Statement of Income &amp; Expenses<br>
    From <%=dtFrom%> To <%=dtTo%></td>
 </tr>
 <tr height=117 style='mso-height-source:userset;height:87.75pt'>
  <td height=117 class=xl33 width=351 style='height:87.75pt;width:263pt'>Other
  Operated Departments Statement of Income &amp; Expenses</td>
  <td rowspan=2 class=xl34 width=53 style='width:40pt'>Account Code</td>
  <td rowspan=2 class=xl35 width=43 style='width:32pt'>Dept Code</td>
  <td rowspan=2 class=xl36 width=39 style='width:29pt'>Convenience Store</td>
  <td rowspan=2 class=xl37 width=38 style='width:29pt'>Others</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt;border-top:none'
  x:str="'in Vietnam Dong">in Vietnam Dong</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl38 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl39 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl40 width=43 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td colspan=2 class=xl43 width=77 style='border-right:1.0pt solid black;
  width:58pt'>Outlets</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt;border-top:none'>REVENUE</td>
  <td class=xl39 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl40 width=43 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'>Convenience
  Store</td>
  <td class=xl47 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Food</td>
  <td class=xl25 style='border-top:none'>270</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Beverages</td>
  <td class=xl25 style='border-top:none'>271</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Tobacco</td>
  <td class=xl25 style='border-top:none'>272</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>273</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'
  x:str="Telephone ">Telephone<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Local Calls</td>
  <td class=xl25 style='border-top:none'>276</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Long Distance calls</td>
  <td class=xl25 style='border-top:none'>277</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'
  x:str="Laundry ">Laundry<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- laundry &amp; Valet</td>
  <td class=xl25 style='border-top:none'>280</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Dry Cleaning</td>
  <td class=xl25 style='border-top:none'>281</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Tennis</td>
  <td class=xl25 style='border-top:none'>286</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none'>Total Revenue</td>
  <td class=xl47 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl48 width=43 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl47 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl48 width=43 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt;border-top:none'>COST OF SALES</td>
  <td class=xl47 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl48 width=43 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'>Convenience
  Store</td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Food</td>
  <td class=xl25 style='border-top:none'>210</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Beverages</td>
  <td class=xl25 style='border-top:none'>212</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Tobacco</td>
  <td class=xl25 style='border-top:none'>213</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>219</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'
  x:str="Telephone ">Telephone<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Local Calls</td>
  <td class=xl25 style='border-top:none'>220</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Long Distance calls</td>
  <td class=xl25 style='border-top:none'>221</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'
  x:str="Laundry ">Laundry<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- laundry &amp; Valet</td>
  <td class=xl25 style='border-top:none'>226</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Dry Cleaning</td>
  <td class=xl25 style='border-top:none'>227</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'>Others</td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Tennis</td>
  <td class=xl25 style='border-top:none'>230</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'>Total Cost of
  Sales</td>
  <td class=xl47 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl48 width=43 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl47 width=53 style='border-top:none;width:40pt'>&nbsp;</td>
  <td class=xl48 width=43 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl50 style='height:15.75pt;border-top:none'>PAYROLL &amp;
  RELATED EXPENSES</td>
  <td class=xl51 style='border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Salaries
  &amp; Wages</td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Base Salary</td>
  <td class=xl25 style='border-top:none'>300</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Allowances</td>
  <td class=xl25 style='border-top:none'>301</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Extra Wages / Overtime</td>
  <td class=xl25 style='border-top:none'>302</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Bonus</td>
  <td class=xl25 style='border-top:none'>303</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Vacation Pay</td>
  <td class=xl25 style='border-top:none'>304</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Sick Pay</td>
  <td class=xl25 style='border-top:none'>305</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Severance Pay</td>
  <td class=xl25 style='border-top:none'>306</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>309</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Employee
  Benefits</td>
  <td class=xl25 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Employee Meals</td>
  <td class=xl27 style='border-top:none'>330</td>
  <td class=xl28 style='border-top:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl54 width=351 style='height:12.75pt;border-top:none;
  width:263pt'><span style='mso-spacerun:yes'> </span>- Workmen Compensation
  Insurance</td>
  <td class=xl27 style='border-top:none'>331</td>
  <td class=xl28 style='border-top:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Social Insurance</td>
  <td class=xl27 style='border-top:none'>332</td>
  <td class=xl28 style='border-top:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- National Pension</td>
  <td class=xl27 style='border-top:none'>333</td>
  <td class=xl28 style='border-top:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Medical Expenses</td>
  <td class=xl27 style='border-top:none'>334</td>
  <td class=xl28 style='border-top:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl27 style='border-top:none'>339</td>
  <td class=xl28 style='border-top:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'>Total Payroll
  &amp; Related Exp</td>
  <td class=xl55 style='border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl49 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl55 style='border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl50 style='height:15.75pt;border-top:none'>OTHER
  EXPENSES</td>
  <td class=xl51 style='border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Contract
  Service</td>
  <td class=xl25 style='border-top:none'>504</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Employee
  Transportation</td>
  <td class=xl25 style='border-top:none'>514</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Internet
  Access</td>
  <td class=xl27 style='border-top:none'>523</td>
  <td class=xl28 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Laundry &amp;
  Valet - Uniform</td>
  <td class=xl25 style='border-top:none'>531</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>License</td>
  <td class=xl25 style='border-top:none'>533</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Operating
  Supplies</td>
  <td class=xl55 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Cleaning</td>
  <td class=xl25 style='border-top:none'>547</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Guest</td>
  <td class=xl25 style='border-top:none'>550</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Paper</td>
  <td class=xl25 style='border-top:none'>556</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Printing &amp; Stationery</td>
  <td class=xl25 style='border-top:none'>557</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td class=xl25 style='border-top:none'>565</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Postage</td>
  <td class=xl25 style='border-top:none'>570</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Sport &amp;
  Social Activities</td>
  <td class=xl25 style='border-top:none'>588</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Telecommunication</td>
  <td class=xl25 style='border-top:none'>590</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Training
  Expenses</td>
  <td class=xl25 style='border-top:none'>592</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl53 style='height:12.75pt;border-top:none'>Uniform
  Replacement</td>
  <td class=xl25 style='border-top:none'>600</td>
  <td class=xl28 style='border-top:none;border-left:none'>06</td>
  <td class=xl26 style='border-top:none'>1</td>
  <td class=xl45 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl53 style='height:13.5pt;border-top:none'>Others</td>
  <td class=xl31 style='border-top:none'>602</td>
  <td class=xl57 style='border-top:none;border-left:none'>06</td>
  <td class=xl58 style='border-top:none'>1</td>
  <td class=xl59 style='border-top:none;border-left:none' x:num>2</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl60 style='height:12.75pt;border-top:none'>Total Other
  Expenses</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl60 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl62 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Total Cost
  &amp; Expenses</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>Departmental
  Profit</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl65 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>Occupancy %</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>No. of Room
  Guests</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'>Average Spend
  of Room Guest:</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Convenience Store</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt;border-top:none'><span
  style='mso-spacerun:yes'> </span>- Others</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl67 style='height:12.75pt;border-top:none'>No. of
  employee</td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl61></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=351 style='width:263pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=38 style='width:29pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
