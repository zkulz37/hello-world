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
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_jama00060_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jama00060_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jama00060_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Lee</o:LastAuthor>
  <o:LastPrinted>2010-04-13T01:54:08Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-04-13T01:54:41Z</o:LastSaved>
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
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
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
.xl28
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
.xl29
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
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
.xl31
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
.xl32
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl33
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	text-align:center;}
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
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style16;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl42
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Other I&amp;R</x:Name>
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
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
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
  <x:Formula>='Other I&amp;R'!$6:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=519 style='border-collapse:
 collapse;table-layout:fixed;width:389pt'>
 <col class=xl24 width=351 style='mso-width-source:userset;mso-width-alt:12836;
 width:263pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=3 height=37 class=xl35 width=455 style='height:27.75pt;
  width:341pt'>Other Operated Departments Statement of Income &amp;
  Expenses<br>
    Form <%=dtFrom%> To <%=dtTo%> </td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=93 style='height:69.75pt'>
  <td height=93 class=xl28 width=351 style='height:69.75pt;width:263pt'>Other
  Operated Departments Statement of Income &amp; Expenses</td>
  <td rowspan=2 class=xl37 width=51 style='width:38pt'>Account Code</td>
  <td rowspan=2 class=xl38 width=53 style='width:40pt'>Dept Code</td>
  <td class=xl42>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none'
  x:str="'in Vietnam Dong">in Vietnam Dong</td>
  <td class=xl42>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl30 width=51 style='border-top:none;width:38pt'>&nbsp;</td>
  <td class=xl31 width=53 style='border-top:none;border-left:none;width:40pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt;border-top:none'>REVENUE</td>
  <td class=xl30 width=51 style='border-top:none;width:38pt'>&nbsp;</td>
  <td class=xl30 width=53 style='border-top:none;border-left:none;width:40pt'>&nbsp;</td>
  <td class=xl42 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 width=351 style='height:12.75pt;border-top:none;
  width:263pt'>Cancellation Penalty</td>
  <td class=xl25 style='border-top:none'>200</td>
  <td class=xl25 style='border-top:none;border-left:none'>09</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 width=351 style='height:12.75pt;border-top:none;
  width:263pt'>Cash Discount Earned</td>
  <td class=xl25 style='border-top:none'>201</td>
  <td class=xl25 style='border-top:none;border-left:none'>09</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 width=351 style='height:12.75pt;border-top:none;
  width:263pt'>Commissions</td>
  <td class=xl25 style='border-top:none'>202</td>
  <td class=xl25 style='border-top:none;border-left:none'>09</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 width=351 style='height:12.75pt;border-top:none;
  width:263pt'>Concessions</td>
  <td class=xl25 style='border-top:none'>203</td>
  <td class=xl25 style='border-top:none;border-left:none'>09</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 width=351 style='height:12.75pt;border-top:none;
  width:263pt'>Foreign Exchange Gains (Losses)</td>
  <td class=xl25 style='border-top:none'>210</td>
  <td class=xl25 style='border-top:none;border-left:none'>09</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 width=351 style='height:12.75pt;border-top:none;
  width:263pt'>Interest Income</td>
  <td class=xl25 style='border-top:none'>211</td>
  <td class=xl25 style='border-top:none;border-left:none'>09</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 width=351 style='height:12.75pt;border-top:none;
  width:263pt'>Space Rentals</td>
  <td class=xl25 style='border-top:none'>212</td>
  <td class=xl25 style='border-top:none;border-left:none'>09</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 width=351 style='height:12.75pt;border-top:none;
  width:263pt'>Others</td>
  <td class=xl25 style='border-top:none'>219</td>
  <td class=xl25 style='border-top:none;border-left:none'>09</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'>Total Revenue</td>
  <td class=xl32 width=51 style='border-top:none;width:38pt'>&nbsp;</td>
  <td class=xl32 width=53 style='border-top:none;border-left:none;width:40pt'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'>In US$</td>
  <td class=xl32 width=51 style='border-top:none;width:38pt'>&nbsp;</td>
  <td class=xl32 width=53 style='border-top:none;border-left:none;width:40pt'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>Departmental
  Profit</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none'>In US$</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 colspan=4 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 class=xl41 style='height:14.25pt'>Occupnacy %</td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 class=xl41 style='height:14.25pt'>No. of Room Guests</td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 class=xl40 style='height:14.25pt'>No of Commercial Space Rented
  Out</td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 class=xl40 style='height:14.25pt'>Sq M of Commercial Space
  Rented Out</td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 class=xl40 style='height:14.25pt'>VND per Sq M of Coomercial
  Space Rented Out</td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 colspan=4 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 colspan=4 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 colspan=4 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 colspan=4 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 colspan=4 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 colspan=4 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 colspan=4 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=19 style='height:14.25pt'>
  <td height=19 colspan=4 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=351 style='width:263pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
