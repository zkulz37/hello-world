<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string p_master_pk = Request.QueryString["p_master_pk"];
    string p_wh_name = Request.QueryString["p_wh_name"];
	DataTable dt     = ESysLib.TableReadOpenCursor("inv.sp_rpt_bias00040", "'" + p_master_pk + "'");
    DataTable dt2    = ESysLib.TableReadOpenCursor("inv.sp_rpt_bias00040_1", "'" + p_master_pk + "'");      
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bias00040_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bias00040_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bias00040_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-05-09T02:19:47Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-05-09T02:20:11Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .5in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
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
	color:red;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	text-decoration:underline;
	text-underline-style:single;
	text-align:right;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border:.5pt solid windowtext;}
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
       <x:ActiveRow>10</x:ActiveRow>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1132 style='border-collapse:
 collapse;table-layout:fixed;width:851pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=191 style='mso-width-source:userset;mso-width-alt:6985;width:143pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <col width=191 style='mso-width-source:userset;mso-width-alt:6985;width:143pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=12 height=38 class=xl24 width=1132 style='height:28.5pt;
  width:851pt'>STOCK EXCHANGE ENTRY</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Date<font
  class="font0">: </font><font class="font5"><%= dt.Rows[0]["ex_date"] %></font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl27>Slip No:</td>
  <td class=xl28><%=  dt.Rows[0]["slip_no"]%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 colspan=3 style='height:12.75pt;mso-ignore:colspan'>Charger<font
  class="font0">: </font><font class="font5"><%=  dt.Rows[0]["full_name"]%></font></td>
  <td></td>
  <td class=xl27>Ref No:</td>
  <td class=xl28 x:string><%=  dt.Rows[0]["ref_no"]%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Remark<font
  class="font0">: </font><font class="font5"><%=  dt.Rows[0]["description"]%></font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl27>W/H:</td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'><%= p_wh_name%></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl25 style='height:17.25pt'>Seq</td>
  <td class=xl25 style='border-left:none'>Req Item Code</td>
  <td class=xl25 style='border-left:none'>Req Item Name</td>
  <td class=xl25 style='border-left:none'>Trans Item Code</td>
  <td class=xl25 style='border-left:none'>Trans Item Name</td>
  <td class=xl25 style='border-left:none'>Req Qty</td>
  <td class=xl25 style='border-left:none'>UOM</td>
  <td class=xl25 style='border-left:none'>Trans Qty</td>
  <td class=xl25 style='border-left:none'>UOM</td>
  <td class=xl25 style='border-left:none'>Req Lot No<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-left:none'>Lot No</td>
  <td class=xl25 style='border-left:none'><span
  style='mso-spacerun:yes'> </span>Description</td>
 </tr>
 <% 
     for (int i = 0; i < dt2.Rows.Count; i++ )
     {
 %>
 <tr height=32 style='height:24.0pt'>
  <td height=32 class=xl29 style='height:24.0pt;border-top:none' x:num><%= dt2.Rows[i]["seq"]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt2.Rows[i]["item_code"] %></td>
  <td class=xl31 width=191 style='border-top:none;border-left:none;width:143pt'><%= dt2.Rows[i]["item_name"] %></td>
  <td class=xl32 style='border-top:none;border-left:none'><%= dt2.Rows[i]["ex_item_code"]%></td>
  <td class=xl31 width=191 style='border-top:none;border-left:none;width:143pt'><%= dt2.Rows[i]["ex_item_name"]%></td>
  <td class=xl33 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["out_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%= dt2.Rows[i]["out_uom"]%></td>
  <td class=xl33 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["ex_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%= dt2.Rows[i]["ex_uom"]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt2.Rows[i]["out_lot_no"]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt2.Rows[i]["ex_lot_no"]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt2.Rows[i]["description"]%></td>
 </tr>
 <% } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=109 style='width:82pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
