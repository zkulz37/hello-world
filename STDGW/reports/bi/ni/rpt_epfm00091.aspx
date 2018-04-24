<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("imex");%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string wh_pk = Request.QueryString["p_tin_warehouse_pk"];
    string dt_from = Request.QueryString["p_from_date"];
    string dt_to = Request.QueryString["p_to_date"];
    
    DataTable dt;
    string wh_name = "", date_from = "", date_to = "";
    dt = ESysLib.TableReadOpenCursor("inv.sp_rpt_epfm00091", "'" + wh_pk + "','" + dt_from + "','" + dt_to + "'");
    if (dt.Rows.Count > 0)
    {
        wh_name = dt.Rows[0]["wh_name"].ToString();
        date_from = dt.Rows[0]["date_from"].ToString();
        date_to = dt.Rows[0]["date_to"].ToString();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="epfm00021_files/filelist.xml">
<link rel=Edit-Time-Data href="epfm00021_files/editdata.mso">
<link rel=OLE-Object-Data href="epfm00021_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2010-11-25T08:41:11Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-11-25T08:43:27Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.33in .17in 1.0in .32in;
	mso-header-margin:.17in;
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid windowtext;}
	
.xl41
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
	
.xl42
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}		
	
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
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
      <x:Scale>73</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowHeight>8985</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1055 style='border-collapse:
 collapse;table-layout:fixed;width:791pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <col width=259 style='mso-width-source:userset;mso-width-alt:9472;width:194pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=64 style='width:48pt'>
 <col width=116 style='mso-width-source:userset;mso-width-alt:4242;width:87pt'>
 <col width=127 style='mso-width-source:userset;mso-width-alt:4644;width:95pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:4352;width:89pt'>
 <col width=132 style='mso-width-source:userset;mso-width-alt:4827;width:99pt'>
 <col width=64 style='width:48pt'>
 <tr height=31 style='height:23.25pt'>
  <td colspan=8 height=31 class=xl25 width=991 style='border-right:.5pt solid black;
  height:23.25pt;width:743pt'>Report Stock Outgoing Checking</td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl31 style='height:23.25pt'>Warehouse :</td>
  <td class=xl42><%=wh_name %></td>
  <td colspan=3 class=xl33>Period : <%=date_from %> - <%=date_to %></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt;border-top:none'>Item Code</td>
  <td class=xl28 style='border-top:none;border-left:none'>Item Name</td>
  <td class=xl28 style='border-top:none;border-left:none'>UOM</td>
  <td class=xl28 style='border-top:none;border-left:none'>CCY</td>
  <td class=xl28 style='border-top:none;border-left:none'>Qty</td>
  <td class=xl28 style='border-top:none;border-left:none'>Amount</td>
  <td class=xl28 style='border-top:none;border-left:none'>VAT Amount</td>
  <td class=xl28 style='border-top:none;border-left:none'>Total Amount</td>
  <td class=xl24></td>
 </tr>
 <%
     double tot_qty = 0, tot_amt = 0, tot_vat_amt = 0, tot_total_amt = 0;
     for (int i = 1; i < dt.Rows.Count; i++)
     {
         tot_qty = tot_qty + CommondLib.ConvertToDbl(dt.Rows[i]["in_qty"].ToString());
         tot_amt = tot_amt + CommondLib.ConvertToDbl(dt.Rows[i]["item_amount"].ToString());
         tot_vat_amt = tot_vat_amt + CommondLib.ConvertToDbl(dt.Rows[i]["vat_amount"].ToString());
         tot_total_amt = tot_total_amt + CommondLib.ConvertToDbl(dt.Rows[i]["total_amount"].ToString());
         %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none'><%=dt.Rows[i]["item_code"]%></td>
  <td class=xl37 style='border-top:none;border-left:none'><%=dt.Rows[i]["item_name"]%></td>
  <td class=xl41 style='border-top:none;border-left:none'><%=dt.Rows[i]["in_uom"]%></td>
  <td class=xl41 style='border-top:none;border-left:none'><%=dt.Rows[i]["ccy"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'x:num><%=dt.Rows[i]["in_qty"]%></td>
  <td class=xl40 style='border-top:none;border-left:none'x:num><%=dt.Rows[i]["item_amount"]%></td>
  <td class=xl40 style='border-top:none;border-left:none'x:num><%=dt.Rows[i]["vat_amount"]%></td>
  <td class=xl40 style='border-top:none;border-left:none'x:num><%=dt.Rows[i]["total_amount"]%></td>
  <td class=xl24></td>
 </tr>
         <% 
     }
  %>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'>TOTAL</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'x:num><%=tot_qty %></td>
  <td class=xl30 style='border-top:none;border-left:none'x:num><%=tot_amt %></td>
  <td class=xl30 style='border-top:none;border-left:none'x:num><%=tot_vat_amt %></td>
  <td class=xl30 style='border-top:none;border-left:none'x:num><%=tot_total_amt %></td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=105 style='width:79pt'></td>
  <td width=259 style='width:194pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
