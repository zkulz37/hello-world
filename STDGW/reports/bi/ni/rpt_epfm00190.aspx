<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_master_pk = Request.QueryString["p_master_pk"];
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epfm00190_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epfm00190_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epfm00190_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr. Khanh</o:LastAuthor>
  <o:LastPrinted>2010-10-13T06:16:27Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-10-13T06:16:33Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .32in 1.0in .27in;
	mso-header-margin:.5in;
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
	text-align:right;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:Code128, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:Code128, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:Code128, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl44
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=690 style='border-collapse:
 collapse;table-layout:fixed;width:518pt'>
 <col width=30 style='mso-width-source:userset;mso-width-alt:1097;width:23pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=124 style='mso-width-source:userset;mso-width-alt:4534;width:93pt'>
 <col width=64 style='mso-width-source:userset;mso-width-alt:2340;width:48pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td colspan=10 height=53 class=xl32 width=619 style='height:39.75pt;
  width:465pt'>STOCK INCOMING REQUEST</td>
  <td width=71 style='width:53pt'></td>
 </tr>
 <%
     string para = " '" + p_master_pk + "'";
     DataTable dt,dt1;
     dt = ESysLib.TableReadOpenCursor("INV.SP_RPT_EPFM00190_1", para);
     dt1 = ESysLib.TableReadOpenCursor("INV.SP_RPT_EPFM00190_2", para);
 %>  
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl24 style='height:12.75pt'>Voucher No</td>
  <td class=xl25><%= dt.Rows[0]["slip_no"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24>Charger</td>
  <td class=xl25><%= dt.Rows[0]["charger_name"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24>Date</td>
  <td class=xl25><%=System.DateTime.ParseExact(dt.Rows[0]["req_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl24 style='height:12.75pt'>W/H</td>
  <td class=xl25><%= dt.Rows[0]["wh_name"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24>Partner</td>
  <td class=xl25><%= dt.Rows[0]["supplier_name"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 rowspan=2 class=xl43>*<%= dt.Rows[0]["slip_no"]%>*</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl24 style='height:12.75pt'>P/L</td>
  <td class=xl25><%= dt.Rows[0]["pl"]%></td>
  <td></td>
  <td class=xl24></td>
  <td class=xl44>Requester</td>
  <td class=xl25><%= dt.Rows[0]["requester_name"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl24 style='height:12.75pt'>Remark</td>
  <td colspan=3 rowspan=2 class=xl33 width=242 style='width:182pt'><%= dt.Rows[0]["description"]%></td>
  <td class=xl24>Line</td>
  <td class=xl25>a</td>
  <td></td>
  <td class=xl26></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>Seq</td>
  <td colspan=3 class=xl29 style='border-right:.5pt solid black;border-left:
  none'>Item</td>
  <td class=xl27 style='border-left:none'>UOM</td>
  <td class=xl27 style='border-left:none'>Req Qty</td>
  <td class=xl27 style='border-left:none'>Lot No</td>
  <td class=xl27 style='border-left:none'>Ref No</td>
  <td colspan=3 class=xl29 style='border-right:.5pt solid black;border-left:
  none'>Remark</td>
 </tr>
     <%
     for (int i = 0; i < dt1.Rows.Count; i++)
     {        
     %>  
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none' x:num><%= dt1.Rows[i]["seq"]%></td>
  <td colspan=3 class=xl38 width=235 style='border-right:.5pt solid black;
  border-left:none;width:176pt'><%= dt1.Rows[i]["item_code"]%> - <%= dt1.Rows[i]["item_name"]%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%= dt1.Rows[i]["req_uom_01"]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["req_qty_01"]%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%= dt1.Rows[i]["lot_no"]%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%= dt1.Rows[i]["ref_no"]%></td>
  <td colspan=3 class=xl31 style='border-right:.5pt solid black;border-left:
  none'><%= dt1.Rows[i]["description"]%></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=71 style='width:53pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
