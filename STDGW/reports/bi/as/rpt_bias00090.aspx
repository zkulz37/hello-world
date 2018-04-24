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
    string p_out_warehouse_pk = Request.QueryString["p_out_warehouse_pk"];
    string p_in_warehouse_pk  = Request.QueryString["p_in_warehouse_pk"];
    string p_from_date        = Request.QueryString["p_from_date"];
    string p_to_date          = Request.QueryString["p_to_date"];
    string p_ref_no_vendor    = Request.QueryString["p_ref_no_vendor"];
    string p_item             = Request.QueryString["p_item"];
    
	string para = "'" + p_from_date + "','" + p_to_date + "','" + p_ref_no_vendor + "','" + p_item + "','" + p_out_warehouse_pk + "','" + p_in_warehouse_pk + "'";
	DataTable dt;
    dt  = ESysLib.TableReadOpenCursor("lg_rpt_bias00090", para);   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Stock%20Transfer%20Checking_files/filelist.xml">
<link rel=Edit-Time-Data href="Stock%20Transfer%20Checking_files/editdata.mso">
<link rel=OLE-Object-Data href="Stock%20Transfer%20Checking_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-04-07T08:20:43Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
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
.xl24
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
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
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1861 style='border-collapse:
 collapse;table-layout:fixed;width:1397pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=64 style='width:48pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=241 style='mso-width-source:userset;mso-width-alt:8813;width:181pt'>
 <col width=64 style='width:48pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=64 style='width:48pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=173 span=2 style='mso-width-source:userset;mso-width-alt:6326;
 width:130pt'>
 <col width=109 span=2 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=19 height=41 class=xl25 width=1861 style='height:30.75pt;
  width:1397pt'>STOCK TRANSFER CHECKING</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr> 
 <tr class=xl34 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl33 style='height:18.0pt'>Date</td>
  <td class=xl33 style='border-left:none'>Slip No</td>
  <td class=xl33 style='border-left:none'>Ref No</td>
  <td class=xl33 style='border-left:none'>Seq</td>
  <td class=xl33 style='border-left:none'>Item Code</td>
  <td class=xl33 style='border-left:none'>Item Name</td>
  <td class=xl33 style='border-left:none'>Qty</td>
  <td class=xl33 style='border-left:none'>UOM</td>
  <td class=xl33 style='border-left:none'>Unit Price</td>
  <td class=xl33 style='border-left:none'>Item Amount</td>
  <td class=xl33 style='border-left:none'>Vat Rate</td>
  <td class=xl33 style='border-left:none'>Vat Amount</td>
  <td class=xl33 style='border-left:none'>Total Amount</td>
  <td class=xl33 style='border-left:none'>CCY</td>
  <td class=xl33 style='border-left:none'>Out W/H</td>
  <td class=xl33 style='border-left:none'>In W/H</td>
  <td class=xl33 style='border-left:none'>Out P/L</td>
  <td class=xl33 style='border-left:none'>In P/L</td>
  <td class=xl33 style='border-left:none'>Description</td>
 </tr>
 <% 
    for (int i = 0; i < dt.Rows.Count; i++)
    {
 %>
 <tr class=xl29 height=32 style='height:24.0pt'>
  <td height=32 class=xl26 style='height:24.0pt;border-top:none'><%=System.DateTime.ParseExact(dt.Rows[i]["tr_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td class=xl26 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["slip_no"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["ref_no"]%></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["seq"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["item_code"]%></td>
  <td class=xl30 width=241 style='border-top:none;border-left:none;width:181pt'><%= dt.Rows[i]["item_name"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["tr_qty"]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%= dt.Rows[i]["tr_uom"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i]["unit_price"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i]["item_amount"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["vat_rate"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i]["vat_amount"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i]["total_amount"]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%= dt.Rows[i]["ccy"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["out_wh"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["in_wh"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["out_pl"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["in_pl"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["description"]%></td>
 </tr>
 <% } %>
 <tr class=xl24 height=16 style='height:12.0pt'>
  <td height=16 class=xl31 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl32 align=right style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(G<%= dt.Rows.Count > 0 ? 4  : 5%>:G<%= dt.Rows.Count > 0 ? dt.Rows.Count + 3  : 5%>)"></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=SUM(J<%= dt.Rows.Count > 0 ? 4  : 5%>:J<%= dt.Rows.Count > 0 ? dt.Rows.Count + 3 : 5 %>)"></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=SUM(L<%= dt.Rows.Count > 0 ? 4  : 5%>:L<%= dt.Rows.Count > 0 ? dt.Rows.Count + 3 : 5  %>)"></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=SUM(M<%= dt.Rows.Count > 0 ? 4  : 5%>:M<%= dt.Rows.Count > 0 ? dt.Rows.Count + 3 : 5  %>)"></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
  <td class=xl31 style='border-top:none;border-left:none'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=241 style='width:181pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
