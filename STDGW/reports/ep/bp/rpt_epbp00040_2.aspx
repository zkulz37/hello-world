<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("sale");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string p_po_vendor = Request.QueryString["p_po_vendor"];
    string p_item_group_pk = Request.QueryString["p_item_group_pk"];
    string p_item = Request.QueryString["p_item"];
    DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00040_1", "'" + Session["User_ID"].ToString() + "'");    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00040_2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00040_2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00040_2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-10-12T08:58:25Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-10-12T09:01:12Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .2in .22in .2in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
.font6
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
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
.style21
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
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
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
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
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
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl41
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	color:red;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
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
      <x:VerticalResolution>300</x:VerticalResolution>
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
  <x:WindowHeight>6930</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1093 style='border-collapse:
 collapse;table-layout:fixed;width:821pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=143 style='mso-width-source:userset;mso-width-alt:5229;width:107pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=64 span=3 style='width:48pt'>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 width=99 style='height:15.0pt;width:74pt'> <!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl27 width=68 style='width:51pt'><%= dt1.Rows[0]["partner_name"] %></td>
  <td class=xl27 width=80 style='width:60pt'></td>
  <td class=xl27 width=27 style='width:20pt'></td>
  <td class=xl26 width=143 style='width:107pt'></td>
  <td class=xl25 width=82 style='width:62pt'></td>
  <td class=xl28 width=40 style='width:30pt'></td>
  <td class=xl28 width=52 style='width:39pt'></td>
  <td class=xl28 width=90 style='width:68pt'></td>
  <td colspan=5 class=xl40 width=348 style='width:262pt'>Tel: <%= dt1.Rows[0]["phone_no"] %></td>
  <td class=xl28 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26><%= dt1.Rows[0]["addr1"] %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl40 width=348 style='width:262pt'>Fax: <%= dt1.Rows[0]["fax_no"] %></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Tax code: <%= dt1.Rows[0]["tax_code"] %></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl41 width=348 style='width:262pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td class=xl29></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=14 height=39 class=xl42 style='height:29.25pt'>Report Purchase
  Order By Group</td>
  <td></td>
 </tr>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl30 style='height:15.75pt'>Supplier</td>
  <td class=xl31>P/O Date</td>
  <td class=xl31>P/O No</td>
  <td class=xl31>Seq</td>
  <td class=xl31>Item Name</td>
  <td class=xl31>P/O Qty</td>
  <td class=xl31>UOM</td>
  <td class=xl31>U/P</td>
  <td class=xl31>P/O Amount</td>
  <td class=xl31>VAT Rate</td>
  <td class=xl31>VAT Amount</td>
  <td class=xl31>Amount</td>
  <td class=xl31>Currency</td>
  <td class=xl31>Remark</td>
  <td class=xl32></td>
 </tr>
 <%
     string para = "'" + p_from_date + "','" + p_to_date + "','" + p_po_vendor + "','" + p_item_group_pk + "','" + p_item + "' ";
            DataTable dt;
            dt = ESysLib.TableReadOpenCursor("lg_rpt_epbp00040_2", para);
            string strGroup = string.Empty;

            decimal PoQty = 0;
            decimal PoAmount = 0;
            decimal Amount = 0;
            strGroup = dt.Rows[0]["grp_nm"].ToString();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (strGroup != dt.Rows[i]["grp_nm"].ToString())
                {   
                       
        %>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=5 height=20 class=xl43 style='border-right:.5pt solid black;
  height:15.0pt'>Total <font class="font6"><%= dt.Rows[i-1]["grp_nm"]%></font></td>
  <td class=xl38 align=right x:num><%= PoQty%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 align=right x:num><%= PoAmount%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 align=right x:num><%= Amount%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl26></td>
 </tr>       
         <%  
            strGroup = dt.Rows[i]["grp_nm"].ToString();
            PoQty = 0; PoAmount = 0; Amount = 0;
              }
        %> 
 <tr class=xl26 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl33 width=99 style='height:14.25pt;width:74pt'><%= dt.Rows[i]["partner_name"]%></td>
  <td class=xl34><%=System.DateTime.ParseExact(dt.Rows[i]["po_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td class=xl35><%= dt.Rows[i]["po_no"]%></td>
  <td class=xl34 x:num><%= dt.Rows[i]["seq"]%></td>
  <td class=xl36 width=143 style='width:107pt'><%= dt.Rows[i]["item_name"]%></td>
  <td class=xl37 align=right x:num><%= dt.Rows[i]["po_qty_01"]%></td>
  <td class=xl34><%= dt.Rows[i]["po_uom_01"]%></td>
  <td class=xl37 align=right x:num><%= dt.Rows[i]["unit_price"]%></td>
  <td class=xl37 align=right x:num><%= dt.Rows[i]["po_amt"]%></td>
  <td class=xl37 align=right x:num><%= dt.Rows[i]["vat_rate"]%></td>
  <td class=xl37 align=right x:num><%= dt.Rows[i]["vat_amount"]%></td>
  <td class=xl37 align=right x:num><%= dt.Rows[i]["total_amt"]%></td>
  <td class=xl34><%= dt.Rows[i]["po_ccy"]%></td>
  <td class=xl36 width=64 style='width:48pt'><%= dt.Rows[i]["description"]%></td>
  <td class=xl26></td>
 </tr>
         <%           
            PoQty += Convert.ToDecimal(dt.Rows[i]["po_qty_01"]);
            PoAmount += Convert.ToDecimal(dt.Rows[i]["po_amt"]);
            Amount += Convert.ToDecimal(dt.Rows[i]["total_amt"]);
            } %>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=5 height=20 class=xl43 style='border-right:.5pt solid black;
  height:15.0pt'>Total <font class="font6"><%= strGroup%></font></td>
  <td class=xl38 align=right x:num><%= PoQty%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 align=right x:num><%= PoAmount%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 align=right x:num><%= Amount%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl26></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=99 style='width:74pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
