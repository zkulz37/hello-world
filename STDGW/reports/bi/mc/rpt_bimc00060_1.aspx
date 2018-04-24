<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("inv");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_tin_warehouse_pk = Request.QueryString["p_tin_warehouse_pk"];
    string p_stock_date = Request.QueryString["p_stock_date"];
    string p_tin_warehouse_name = Request.QueryString["p_tin_warehouse_name"];
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="test_files/filelist.xml">
<link rel=Edit-Time-Data href="test_files/editdata.mso">
<link rel=OLE-Object-Data href="test_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-01-06T04:15:26Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-01-06T04:16:10Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .21in .25in 0in;
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
.xl24
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	color:red;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	color:maroon;
	font-size:9.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	color:maroon;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
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
  <x:WindowHeight>12585</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1030 style='border-collapse:
 collapse;table-layout:fixed;width:774pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=195 style='mso-width-source:userset;mso-width-alt:7131;width:146pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=69 span=2 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col width=68 span=3 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2304'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=14 rowspan=2 height=38 class=xl29 width=1030 style='height:28.5pt;
  width:774pt'>W/H Daily Closing</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=3 style='height:14.25pt;mso-ignore:colspan'>W/H: <%= p_tin_warehouse_name %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>Stock Date: <%= System.DateTime.ParseExact(p_stock_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'>Seq</td>
  <td class=xl31>Item Code</td>
  <td class=xl31>Item Name</td>
  <td class=xl31>UOM</td>
  <td class=xl31>Begin Qty</td>
  <td class=xl31>In Qty</td>
  <td class=xl31>Sale</td>
  <td class=xl31>FOC</td>
  <td class=xl31>Trans</td>
  <td class=xl31>Adjust Qty</td>
  <td class=xl31>Hide</td>
  <td class=xl31>Out Qty</td>
  <td class=xl31>End Qty</td>
  <td class=xl31>Remark</td>
 </tr>
     <%
            string para = "'" + p_tin_warehouse_pk + "','" + p_stock_date + "'" ;
            DataTable dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_bimc00060_1", para);
            decimal TotalBeginQty = 0;
            decimal TotalOutQty= 0;
            decimal TotalEndQty = 0;
            for (int i = 0; i < dt.Rows.Count; i++)
            { 
%> 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl32 style='height:12.75pt'><%= dt.Rows[i]["seq"]%></td>
  <td class=xl33><%= dt.Rows[i]["item_code"]%></td>
  <td class=xl25 width=195 style='width:146pt'><%= dt.Rows[i]["item_name"]%></td>
  <td class=xl26><%= dt.Rows[i]["uom"]%></td>
  <td class=xl35 x:num=""><span style='mso-spacerun:yes'>         
  </span><%= dt.Rows[i]["begin_qty"]%></td>
  <td class=xl35 x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[i]["in_qty"]%></td>
  <td class=xl35 x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[i]["out_01_qty"]%></td>
  <td class=xl35 x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[i]["out_02_qty"]%></td>
  <td class=xl35 x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[i]["out_03_qty"]%></td>
  <td class=xl35 x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[i]["out_04_qty"]%></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[i]["out_qty"]%></td>
  <td class=xl35 x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[i]["end_qty"]%></td>
  <td class=xl34><%= dt.Rows[i]["description"]%></td>
 </tr>
   <%
     TotalBeginQty += Convert.ToDecimal(dt.Rows[i]["begin_qty"]);
     TotalOutQty += Convert.ToDecimal(dt.Rows[i]["out_qty"]);
     TotalEndQty += Convert.ToDecimal(dt.Rows[i]["end_qty"]);
            } %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'></span><%= TotalBeginQty%>
  </td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'></span><%= TotalOutQty%><span style='mso-spacerun:yes'></span></td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'></span><%= TotalEndQty%>
  </td>
  <td class=xl28>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=0></td>
  <td width=70 style='width:53pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=123 style='width:92pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
