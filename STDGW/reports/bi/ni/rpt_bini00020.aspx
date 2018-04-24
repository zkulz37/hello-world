﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%        
    string p_whtype = Request.QueryString["p_whtype"];
    string p_tin_warehouse_pk = Request.QueryString["p_tin_warehouse_pk"];
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string p_ref_no_vendor = Request.QueryString["p_ref_no_vendor"]; 
    string p_item = Request.QueryString["p_item"];
    string para = " '" + p_whtype + "','" + p_tin_warehouse_pk + "','" + p_from_date + "','" + p_to_date + "','" + p_ref_no_vendor + "','" + p_item + "'";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("lg_rpt_bini00020", para);
    //-----------------------
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    dt1 = ESysLib.TableReadOpen(str_sql);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bini00020_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bini00020_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bini00020_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-11-01T07:22:00Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-11-01T07:22:32Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:1.0in .17in .39in .17in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
.style66
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl25
	{mso-style-parent:style0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style66;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style66;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-size:22.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
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
     <x:LeftColumnVisible>8</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>5745</x:WindowHeight>
  <x:WindowWidth>18780</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>7140</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1851 style='border-collapse:
 collapse;table-layout:fixed;width:1390pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=192 style='mso-width-source:userset;mso-width-alt:7021;width:144pt'>
 <col width=64 style='width:48pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=114 span=2 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col width=64 style='width:48pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=203 style='mso-width-source:userset;mso-width-alt:7424;width:152pt'>
 <col width=137 style='mso-width-source:userset;mso-width-alt:5010;width:103pt'>
 <col width=191 style='mso-width-source:userset;mso-width-alt:6985;width:143pt'>
 <col width=64 style='width:48pt'>
 <tr class=xl28 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 width=97 style='height:15.0pt;width:73pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:.5pt;margin-top:.5pt;width:73pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl27 align=left width=64 style='width:48pt'><%= dt1.Rows[0]["partner_name"] %></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl26 width=32 style='width:24pt'></td>
  <td class=xl28 width=71 style='width:53pt'></td>
  <td class=xl29 width=192 style='width:144pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
  <td class=xl29 width=49 style='width:37pt'></td>
  <td colspan=9 class=xl30 width=1090 style='width:819pt'>Tel: <%= dt1.Rows[0]["phone_no"]%></td>
  <td class=xl28 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl28 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26 align=left><%= dt1.Rows[0]["addr1"]%></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl30 width=1090 style='width:819pt'>Fax: <%= dt1.Rows[0]["fax_no"] %></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26 colspan=2 align=left style='mso-ignore:colspan'>Tax code: <%= dt1.Rows[0]["tax_code"] %></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl32 width=1090 style='width:819pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td class=xl28></td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=18 height=43 class=xl36 style='height:32.25pt'>Report Stock
  Incoming Checking</td>
  <td></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'>W/H</td>
  <td class=xl33 style='border-left:none'>In Date</td>
  <td class=xl33 style='border-left:none'>Slip No</td>
  <td class=xl33 style='border-left:none'>Ref No</td>
  <td class=xl33 style='border-left:none'>Seq</td>
  <td class=xl33 style='border-left:none'>Item Code</td>
  <td class=xl33 style='border-left:none'>Item Name</td>
  <td class=xl33 style='border-left:none'>In Qty</td>
  <td class=xl33 style='border-left:none'>UOM</td>
  <td class=xl33 style='border-left:none'>U/P</td>
  <td class=xl33 style='border-left:none'>Amount</td>
  <td class=xl33 style='border-left:none'>VAT(%)</td>
  <td class=xl33 style='border-left:none'>VAT Amt</td>
  <td class=xl33 style='border-left:none'>Total Amt</td>
  <td class=xl33 style='border-left:none'>CCY</td>
  <td class=xl33 style='border-left:none'>Supplier</td>
  <td class=xl33 style='border-left:none'>P/L</td>
  <td class=xl33 style='border-left:none'>Description</td>
  <td class=xl25></td>
 </tr>
 <%

            for (int i = 0; i < dt.Rows.Count; i++)
            {%>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 align=left style='height:12.75pt'><%= dt.Rows[i]["wh_id"]%></td>
  <td class=xl38 align=middle style='border-left:none'><%= System.DateTime.ParseExact(dt.Rows[i]["in_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td class=xl39 align=left style='border-left:none'><%= dt.Rows[i]["slip_no"]%></td>
  <td class=xl37 align=left style='border-left:none'><%= dt.Rows[i]["ref_no"]%></td>
  <td class=xl40 style='border-left:none' x:num><%= dt.Rows[i]["seq"]%></td>
  <td class=xl37 align=left style='border-left:none'><%= dt.Rows[i]["item_code"]%></td>
  <td class=xl39 align=left style='border-left:none'><%= dt.Rows[i]["item_name"]%></td>
  <td class=xl41 align=right style='border-left:none' x:num><%= dt.Rows[i]["in_qty"]%></td>
  <td class=xl40 style='border-left:none'><%= dt.Rows[i]["in_uom"]%></td>
  <td class=xl42 align=right style='border-left:none' x:num><%= dt.Rows[i]["unit_price"]%></td>
  <td class=xl41 align=right style='border-left:none' x:num><%= dt.Rows[i]["item_amount"]%></td>
  <td class=xl42 align=right style='border-left:none' x:num><%= dt.Rows[i]["vat_rate"]%></td>
  <td class=xl42 align=right style='border-left:none' x:num><%= dt.Rows[i]["vat_amount"]%></td>
  <td class=xl41 align=right style='border-left:none' x:num><%= dt.Rows[i]["total_amount"]%></td>
  <td class=xl40 style='border-left:none'><%= dt.Rows[i]["ccy"]%></td>
  <td class=xl39 align=left style='border-left:none'><%= dt.Rows[i]["partner_name"]%></td>
  <td class=xl39 align=left style='border-left:none'><%= dt.Rows[i]["pl"]%></td>
  <td class=xl39 align=left style='border-left:none'><%= dt.Rows[i]["description"]%></td>
  <td></td>
 </tr>
 <%} %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl35 style='height:16.5pt;border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 align=center x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>H6:H<%= dt.Rows.Count+5%><%}else{%>H8:H8<%}%>)"></td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>K6:K<%= dt.Rows.Count+5%><%}else{%>K8:K8<%}%>)"></td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>M6:M<%= dt.Rows.Count+5%><%}else{%>M8:M8<%}%>)"></td>
  <td class=xl34 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>N6:N<%= dt.Rows.Count+5%><%}else{%>N8:N8<%}%>)"></td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=97 style='width:73pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=192 style='width:144pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=203 style='width:152pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
