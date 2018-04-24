<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser(Session["APP_DBUSER"].ToString());%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
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
<link rel=File-List href="po%20ck%201_files/filelist.xml">
<link rel=Edit-Time-Data href="po%20ck%201_files/editdata.mso">
<link rel=OLE-Object-Data href="po%20ck%201_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-10-12T07:04:05Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-08-30T02:48:28Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .1in .22in .1in;
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
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
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
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
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
	mso-number-format:"\#\,\#\#0\.000";
	text-align:right;
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
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
	mso-number-format:"\#\,\#\#0\.000";
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
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	color:red;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
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
  <x:WindowHeight>7710</x:WindowHeight>
  <x:WindowWidth>15240</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>645</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1287 style='border-collapse:
 collapse;table-layout:fixed;width:966pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:4132;width:85pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=55 span=2 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 width=109 style='height:15.0pt;width:82pt'>
  <!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl27 colspan=3 width=161 style='mso-ignore:colspan;width:121pt'><%= dt1.Rows[0]["partner_name"] %></td>
  <td class=xl27 width=48 style='width:36pt'></td>
  <td class=xl26 width=72 style='width:54pt'></td>
  <td class=xl25 width=113 style='width:85pt'></td>
  <td class=xl28 width=55 style='width:41pt'></td>
  <td class=xl28 width=47 style='width:35pt'></td>
  <td class=xl28 width=55 style='width:41pt'></td>
  <td class=xl28 width=55 style='width:41pt'></td>
  <td class=xl28 width=69 style='width:52pt'></td>
  <td colspan=3 class=xl40 width=210 style='width:158pt'></td>
  <td colspan=4 class=xl40 width=293 style='width:220pt'>Tel: <%= dt1.Rows[0]["phone_no"] %></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26><%= dt1.Rows[0]["addr1"] %></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl40 width=210 style='width:158pt'></td>
  <td colspan=4 class=xl40 width=293 style='width:220pt'>Fax: <%= dt1.Rows[0]["fax_no"] %></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Tax code: <%= dt1.Rows[0]["tax_code"] %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl41 width=210 style='width:158pt'>&nbsp;</td>
  <td colspan=4 class=xl41 width=293 style='width:220pt'>Print date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
 </tr>
 <tr class=xl25 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td colspan=19 height=44 class=xl42 style='height:33.0pt'>Report Purchase
  Order</td>
 </tr>
 <tr class=xl26 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl30 style='height:13.5pt'>Supplier</td>
  <td class=xl31>P/O Date</td>
  <td class=xl31>P/O No</td>
  <td class=xl31>Seq</td>
  <td class=xl31>Ref No</td>
  <td class=xl31>Item Code</td>
  <td class=xl31>Item Name</td>
  <td class=xl31>P/O Qty</td>
  <td class=xl31>UOM</td>
  <td class=xl31>In Qty</td>
  <td class=xl31>Bal Qty</td>
  <td class=xl31>U/P</td>
  <td class=xl31>P/O Amount</td>
  <td class=xl31>VAT</td>
  <td class=xl31>VAT Amount</td>
  <td class=xl31>Amount</td>
  <td class=xl31>CCY</td>
  <td class=xl31>Dept</td>
  <td class=xl31>Remark</td>
 </tr>
  <%
            string para = "'" + p_from_date + "','" + p_to_date + "','" + p_po_vendor + "','" + p_item_group_pk + "','" + p_item + "' ";
            decimal PoQty = 0;
            decimal PoAmount = 0;
            decimal Amount = 0;
            DataTable dt;
            dt = ESysLib.TableReadOpenCursor("lg_rpt_epbp00040_4", para);
            if (dt == null)
            {
                Response.Write("No DATA");
                Response.End();
            }
            //======================
            string strPoNo = string.Empty;
            int[] arrPoNo_count = new int[1000];
            int strPoNo_count = 1;
            int a = 0;
            for (int y = 0; y < dt.Rows.Count; y++)
            {
                if (strPoNo == "" || strPoNo == null)
                {
                    strPoNo = dt.Rows[y]["po_no"].ToString().Trim();
                    strPoNo_count = 1;
                }
                else
                {
                    if (dt.Rows[y]["po_no"].ToString().Trim() != strPoNo.Trim())
                    {
                        arrPoNo_count[a] = strPoNo_count;
                        strPoNo_count = 1;
                        a++;
                        strPoNo = dt.Rows[y]["po_no"].ToString().Trim();
                    }
                    else
                    {
                        strPoNo_count++;
                    }
                }
            }
            //------------------------ 
            arrPoNo_count[a] = strPoNo_count;
            a = 0;
            strPoNo = string.Empty;
            //======================
            string strSupplier = string.Empty;
            int[] arrSupplier_count = new int[100];
            int strSupplier_count = 1;
            int b = 0;
            for (int z = 0; z < dt.Rows.Count; z++)
            {
                if (strSupplier == "" || strSupplier == null)
                {
                    strSupplier = dt.Rows[z]["partner_name"].ToString().Trim();
                    strSupplier_count = 1;
                }
                else
                {
                    if (dt.Rows[z]["partner_name"].ToString().Trim() != strSupplier.Trim())
                    {
                        arrSupplier_count[b] = strSupplier_count;
                        strSupplier_count = 1;
                        b++;
                        strSupplier = dt.Rows[z]["partner_name"].ToString().Trim();
                    }
                    else
                    {
                        strSupplier_count++;
                    }
                }
            }
            //------------------------ 
            arrSupplier_count[b] = strSupplier_count;
            b = 0;
            strSupplier = string.Empty;
            //========================
            for (int i = 0; i < dt.Rows.Count; i++)
            {
        %>
 <tr class=xl26 height=18 style='mso-height-source:userset;height:13.5pt'>
      <%  if (strSupplier != dt.Rows[i]["partner_name"].ToString())
                {
     %>
  <td rowspan="<%= arrSupplier_count[b] %>" height=18 class=xl32 style='height:13.5pt'><%= dt.Rows[i]["partner_name"]%></td>
       <%                         
                strSupplier = dt.Rows[i]["partner_name"].ToString();
                b++;
            }
     %>
     <%  if (strPoNo != dt.Rows[i]["po_no"].ToString())
                {%>
  <td rowspan="<%= arrPoNo_count[a] %>" class=xl33><%=System.DateTime.ParseExact(dt.Rows[i]["po_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td rowspan="<%= arrPoNo_count[a] %>" class=xl33><%= dt.Rows[i]["po_no"]%></td>
    <%                         
                strPoNo = dt.Rows[i]["po_no"].ToString();
                a++;
            }%>
  <td class=xl33 x:num><%= dt.Rows[i]["seq"]%></td>
  <td class=xl33><%= dt.Rows[i]["ref_no"]%></td>
  <td class=xl34><%= dt.Rows[i]["item_code"]%></td>
  <td class=xl34><%= dt.Rows[i]["item_name"]%></td>
  <td class=xl35 x:num><%= dt.Rows[i]["po_qty"]%></td>
  <td class=xl33><%= dt.Rows[i]["po_uom"]%></td>
  <td class=xl35 x:num><%= dt.Rows[i]["in_qty"]%></td>
  <td class=xl35 x:num><%= dt.Rows[i]["bal_qty"]%></td>
  <td class=xl35 x:num><%= dt.Rows[i]["unit_price"]%></td>
  <td class=xl35 x:num><%= dt.Rows[i]["po_amt"]%></td>
  <td class=xl33 x:num><%= dt.Rows[i]["vat_rate"]%></td>
  <td class=xl35 x:num><%= dt.Rows[i]["vat_amount"]%></td>
  <td class=xl35 x:num><%= dt.Rows[i]["total_amt"]%></td>
  <td class=xl33><%= dt.Rows[i]["po_ccy"]%></td>
  <td class=xl33><%= dt.Rows[i]["dept"]%></td>
  <td class=xl33><%= dt.Rows[i]["description"]%></td>
 </tr>
  <%} %>
 <tr class=xl25 height=14 style='height:10.5pt'>
  <td height=14 class=xl36 style='height:10.5pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>H6:H<%= dt.Rows.Count+5%><%}else{%>H8:H8<%}%>)"></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>J6:J<%= dt.Rows.Count+5%><%}else{%>J8:J8<%}%>)"></td>
  <td class=xl38 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>K6:K<%= dt.Rows.Count+5%><%}else{%>K8:K8<%}%>)"></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>M6:M<%= dt.Rows.Count+5%><%}else{%>M8:M8<%}%>)"></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 align=right x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>P6:P<%= dt.Rows.Count+5%><%}else{%>P8:P8<%}%>)"></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=109 style='width:82pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=73 style='width:55pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
