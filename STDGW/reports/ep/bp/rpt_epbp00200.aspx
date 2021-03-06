﻿<%@ page language="C#" %>

<%@ import namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    DataTable dt;
    dt  = ESysLib.TableReadOpenCursor("LG_RPT_EPBP00200");
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data.");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="barcode_files/filelist.xml">
<link rel=Edit-Time-Data href="barcode_files/editdata.mso">
<link rel=OLE-Object-Data href="barcode_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HRSV1</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2010-05-18T02:51:54Z</o:LastPrinted>
  <o:Created>2010-02-01T03:18:02Z</o:Created>
  <o:LastSaved>2012-05-16T03:10:52Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.47in .48in 1.0in .47in;
	mso-header-margin:.35in;
	mso-footer-margin:.5in;}
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
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-size:36.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>82</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
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
    <x:PageBreaks>
     <x:ColBreaks>
      <x:ColBreak>
       <x:Column>5</x:Column>
      </x:ColBreak>
     </x:ColBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7365</x:WindowHeight>
  <x:WindowWidth>15240</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$1:$E$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1073 style='border-collapse:
 collapse;table-layout:fixed;width:805pt'>
 <col width=64 style='width:48pt'>
 <col width=172 style='mso-width-source:userset;mso-width-alt:6290;width:129pt'>
 <col width=217 style='mso-width-source:userset;mso-width-alt:7936;width:163pt'>
 <col width=332 style='mso-width-source:userset;mso-width-alt:12141;width:249pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=64 style='width:48pt'>
 <col width=64 span=3 style='width:48pt'>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=4 height=26 class=xl35 width=785 style='border-right:.5pt solid black;
  height:19.5pt;width:589pt'><a name="Print_Area">DEPARTMENTS</a></td>
  <td class=xl25 width=32 style='width:24pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt'>No</td>
  <td class=xl27>Code</td>
  <td class=xl27>Name</td>
  <td class=xl27>B/C</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <% for (int i = 0; i < dt.Rows.Count; i++)
    {
 %>
 <tr height=93 style='mso-height-source:userset;height:69.95pt'>
  <td rowspan=2 height=117 class=xl39 style='height:87.95pt;border-bottom:.5pt solid black;border-top:none' x:num><%= i + 1 %></td>
  <td rowspan=2 class=xl41 style='border-bottom:.5pt solid black;border-top:  none'><%= dt.Rows[i]["dept_id"]%></td>
  <td rowspan=2 class=xl42 style='border-bottom:.5pt solid black;border-top:  none'><%= dt.Rows[i]["dept_name"]%></td>
  <td class=xl28>*#<%= dt.Rows[i]["dept_id"]%>*</td>
  <td class=xl29></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl31 style='height:18.0pt'><%= dt.Rows[i]["dept_id"]%></td>
  <td class=xl29></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44></td>
 </tr> 
 <% } %>
 <tr height=39 style='height:29.25pt'>
  <td colspan=2 height=39 class=xl45 style='height:29.25pt'>SAVE</td>
  <td class=xl32></td>
  <td class=xl32>CANCEL</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44></td>
 </tr>
 <tr height=71 style='mso-height-source:userset;height:53.25pt'>
  <td colspan=2 height=71 class=xl33 style='height:53.25pt'>*SAVE*</td>
  <td class=xl33></td>
  <td class=xl33>*CANCEL*</td>
  <td></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=9 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 style='height:11.25pt'></td>
  <td class=xl30></td>
  <td></td>
  <td class=xl30></td>
  <td class=xl24></td>
  <td class=xl30></td>
  <td class=xl34></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=9 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt;mso-xlrowspan:
  2'>
  <td height=30 colspan=9 style='height:22.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=172 style='width:129pt'></td>
  <td width=217 style='width:163pt'></td>
  <td width=332 style='width:249pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
