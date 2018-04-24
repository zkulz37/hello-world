<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
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
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        //Response.End();
    }
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
  <o:LastPrinted>2012-09-06T07:14:40Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-09-06T07:17:00Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.27in .17in .39in .17in;
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
.style58
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
	font-family:\B3CB\C6C0, monospace;
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
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl70
	{mso-style-parent:style58;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl77
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
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl86
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
.xl87
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl88
	{mso-style-parent:style58;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>81</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
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
  <x:WindowHeight>5745</x:WindowHeight>
  <x:WindowWidth>18780</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>7140</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1337 style='border-collapse:
 collapse;table-layout:fixed;width:1005pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=150 style='mso-width-source:userset;mso-width-alt:5485;width:113pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=237 style='mso-width-source:userset;mso-width-alt:8667;width:178pt'>
 <col width=64 style='width:48pt'>
 <tr class=xl66 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 width=74 style='height:15.0pt;width:56pt'><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:10.5pt;margin-top:.5pt;width:73pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape></td>
  <td class=xl66 width=62 style='width:47pt'></td>
  <td class=xl68 colspan=3 width=279 style='mso-ignore:colspan;width:210pt'><%= dt1.Rows[0]["partner_name"] %></td>
  <td class=xl66 width=65 style='width:49pt'></td>
  <td class=xl69 width=47 style='width:35pt'></td>
  <td class=xl69 width=61 style='width:46pt'></td>
  <td class=xl69 width=123 style='width:92pt'></td>
  <td colspan=5 class=xl87 width=562 style='width:422pt'>Tel: <%= dt1.Rows[0]["phone_no"]%></td>
  <td class=xl66 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl66 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt'></td>
  <td class=xl66></td>
  <td class=xl67 colspan=3 style='mso-ignore:colspan'><%= dt1.Rows[0]["addr1"]%></td>
  <td class=xl66></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl87 width=562 style='width:422pt'>Fax: <%= dt1.Rows[0]["fax_no"] %></td>
  <td class=xl66></td>
 </tr>
 <tr class=xl66 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt'></td>
  <td class=xl66></td>
  <td class=xl67 colspan=2 style='mso-ignore:colspan'>Tax code: <%= dt1.Rows[0]["tax_code"] %></td>
  <td class=xl67></td>
  <td class=xl66></td>
  <td colspan=3 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl88 width=562 style='width:422pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td class=xl66></td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=14 height=43 class=xl86 style='height:32.25pt'>Report Stock
  Incoming Checking</td>
  <td></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl71 style='height:15.75pt'>In Date</td>
  <td class=xl71>Slip No</td>
  <td class=xl71>Ref No</td>
  <td class=xl71>Item Code</td>
  <td class=xl71>Item Name</td>
  <td class=xl71>In Qty</td>
  <td class=xl71>UOM</td>
  <td class=xl71>U/P</td>
  <td class=xl71>Amount</td>
  <td class=xl71>VAT(%)</td>
  <td class=xl71>VAT Amt</td>
  <td class=xl71>Total Amt</td>
  <td class=xl71>CCY</td>
  <td class=xl71>Supplier</td>
  <td></td>
 </tr>
  <%

            for (int i = 0; i < dt.Rows.Count; i++)
            {%>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl72 style='height:12.75pt'><%= System.DateTime.ParseExact(dt.Rows[i]["in_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td class=xl72><%= dt.Rows[i]["slip_no"]%></td>
  <td class=xl73><%= dt.Rows[i]["ref_no"]%></td>
  <td class=xl73><%= dt.Rows[i]["item_code"]%></td>
  <td class=xl72><%= dt.Rows[i]["item_name"]%></td>
  <td class=xl80 align=right x:num><%= dt.Rows[i]["in_qty"]%></td>
  <td class=xl74><%= dt.Rows[i]["in_uom"]%></td>
  <td class=xl82 align=right x:num><%= dt.Rows[i]["unit_price"]%></td>
  <td class=xl78 align=right x:num><%= dt.Rows[i]["item_amount"]%></td>
  <td class=xl84 align=right x:num><%= dt.Rows[i]["vat_rate"]%></td>
  <td class=xl75 align=right x:num><%= dt.Rows[i]["vat_amount"]%></td>
  <td class=xl78 align=right x:num><%= dt.Rows[i]["total_amount"]%></td>
  <td class=xl74><%= dt.Rows[i]["ccy"]%></td>
  <td class=xl72><%= dt.Rows[i]["partner_name"]%></td>
  <td></td>
 </tr>
  <%} %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl76 style='height:16.5pt'>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td class=xl81 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>F6:F<%= dt.Rows.Count+5%><%}else{%>F8:F8<%}%>)"></td>
  <td class=xl76>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl79 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>I6:I<%= dt.Rows.Count+5%><%}else{%>I8:I8<%}%>)"></td>
  <td class=xl85>&nbsp;</td>
  <td class=xl77 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>K6:K<%= dt.Rows.Count+5%><%}else{%>K8:K8<%}%>)"></td>
  <td class=xl79 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>L6:L<%= dt.Rows.Count+5%><%}else{%>L8:L8<%}%>)"></td>
  <td class=xl76>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=150 style='width:113pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=237 style='width:178pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
