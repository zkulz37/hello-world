<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());  
	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_from_date          = Request.QueryString["p_from_date"];
    string p_to_date            = Request.QueryString["p_to_date"];
    string p_ref_no_pl          = Request.QueryString["p_ref_no_pl"];
    string p_out_item           = Request.QueryString["p_out_item"];
    string p_ex_item            = Request.QueryString["p_ex_item"];
    string p_ex_warehouse_pk    = Request.QueryString["p_ex_warehouse_pk"];

    string para = "'" + p_from_date + "','" + p_to_date + "','" + p_ref_no_pl + "','" + p_out_item + "','" + p_ex_item + "','" + p_ex_warehouse_pk + "'";
	DataTable dt;
    dt  = ESysLib.TableReadOpenCursor("lg_rpt_bias00080", para);   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bias00080_1_filelist.xml">
<link rel=Edit-Time-Data href="rpt_bias00080_1_editdata.mso">
<link rel=OLE-Object-Data href="rpt_bias00080_1_oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Nguyen Thanh Xuan</o:LastAuthor>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-07-19T08:28:22Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:DoNotOrganizeInFolder/>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
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
.xl65
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFFCC;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFFCC;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFFCC;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl83
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
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
      <x:Scale>57</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1965 style='border-collapse:
 collapse;table-layout:fixed;width:1476pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=64 style='width:48pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=189 style='mso-width-source:userset;mso-width-alt:6912;width:142pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=180 style='mso-width-source:userset;mso-width-alt:6582;width:135pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:4132;width:85pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=169 style='mso-width-source:userset;mso-width-alt:6180;width:127pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=125 style='mso-width-source:userset;mso-width-alt:4571;width:94pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=17 height=41 class=xl81 width=1784 style='height:30.75pt;
  width:1340pt'>STOCK EXCHANGE CHECKING</td>
  <td class=xl72 width=109 style='width:82pt'></td>
  <td class=xl72 width=72 style='width:54pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl66 style='height:18.0pt'>Date</td>
  <td class=xl67>Slip No</td>
  <td class=xl67>Ref No</td>
  <td class=xl67>Seq</td>
  <td class=xl67>Out Item Code</td>
  <td class=xl67>Out Item Name</td>
  <td class=xl67>Ex Item Code</td>
  <td class=xl67>Ex Item Name</td>
  <td class=xl67>Out Qty</td>
  <td class=xl67>Out UOM</td>
  <td class=xl67>Ex Qty</td>
  <td class=xl67>Ex UOM</td>
  <td class=xl67>Out Lot No</td>
  <td class=xl67>Ex Lot No</td>
  <td class=xl67>WH Name</td>
  <td class=xl67>P/L NM</td>
  <td class=xl67>Description</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 
 <% 
     double total1 = 0;
     double total2 = 0;
    for (int i = 0; i < dt.Rows.Count; i++)
    {
        total1 = total1 + CommondLib.ConvertToDbl(dt.Rows[i]["out_qty"].ToString());
        total2 = total2 + CommondLib.ConvertToDbl(dt.Rows[i]["ex_qty"].ToString());
 %>
 <tr class=xl68 height=16 style='height:12.0pt'>
  <td height=16 class=xl69 align=right style='height:12.0pt' ><%= dt.Rows[i]["ex_date"]%></td>
  <td class=xl71 x:num><%= dt.Rows[i]["slip_no"]%></td>
  <td class=xl71><%= dt.Rows[i]["ref_no"]%></td>
  <td class=xl71 x:num><%= dt.Rows[i]["seq"]%></td>
  <td class=xl73><%= dt.Rows[i]["out_item_cd"]%></td>
  <td class=xl74 width=189 style='width:142pt'><%= dt.Rows[i]["out_item_nm"]%></td>
  <td class=xl75><%= dt.Rows[i]["ex_item_cd"]%></td>
  <td class=xl76><%= dt.Rows[i]["ex_item_nm"]%></td>
  <td class=xl77 align=right x:num><%= dt.Rows[i]["out_qty"]%></td>
  <td class=xl78><%= dt.Rows[i]["out_uom"]%></td>
  <td class=xl75 align=right x:num><%= dt.Rows[i]["ex_qty"]%></td>
  <td class=xl79><%= dt.Rows[i]["ex_uom"]%></td>
  <td class=xl73><%= dt.Rows[i]["out_lot_no"]%></td>
  <td class=xl80><%= dt.Rows[i]["ex_lot_no"]%></td>
  <td class=xl70><%= dt.Rows[i]["wh_name"]%></td>
  <td class=xl70><%= dt.Rows[i]["plc_nm"]%></td>
  <td class=xl70><%= dt.Rows[i]["description"]%></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <% } %>
 <tr class=xl82 height=16 style='height:12.0pt'>
  <td height=16 class=xl83 style='height:12.0pt'>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85 align=right x:num ><%=total1 %></td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85 align=right x:num ><%=total2 %></td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=69 style='width:52pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=169 style='width:127pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
