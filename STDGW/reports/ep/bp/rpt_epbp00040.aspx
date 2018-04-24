<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser(Session["APP_DBUSER"].ToString());%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string p_company_pk 	= Request.QueryString["p_company_pk"];
    string p_from_date 		= Request.QueryString["p_from_date"];
    string p_to_date 		= Request.QueryString["p_to_date"];
    string p_po_vendor 		= Request.QueryString["p_po_vendor"];
    string p_item_group_pk 	= Request.QueryString["p_item_group_pk"];
    string p_item 			= Request.QueryString["p_item"];
	
    DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00040_1", "'" + Session["User_ID"].ToString() + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00040_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00040_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00040_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-10-12T07:04:05Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-10-12T07:05:32Z</o:LastSaved>
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
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style58;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style58;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
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
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
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
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
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
       <x:ActiveCol>11</x:ActiveCol>
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
  <x:WindowTopX>3825</x:WindowTopX>
  <x:WindowTopY>5115</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1048 style='border-collapse:
 collapse;table-layout:fixed;width:787pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 width=109 style='height:15.0pt;width:82pt'>
      <!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
  </td>
  <td class=xl26 align=left width=65 style='width:49pt'><%= dt1.Rows[0]["partner_name"] %></td>
  <td class=xl26 width=63 style='width:47pt'></td>
  <td class=xl26 width=33 style='width:25pt'></td>
  <td class=xl25 width=72 style='width:54pt'></td>
  <td class=xl27 width=107 style='width:80pt'></td>
  <td class=xl28 width=63 style='width:47pt'></td>
  <td class=xl28 width=47 style='width:35pt'></td>
  <td class=xl28 width=58 style='width:44pt'></td>
  <td colspan=3 class=xl29 width=205 style='width:154pt'></td>
  <td colspan=3 class=xl29 width=226 style='width:170pt'>Tel: <%= dt1.Rows[0]["phone_no"] %></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl25 align=left><%= dt1.Rows[0]["addr1"] %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 width=205 style='width:154pt'></td>
  <td colspan=3 class=xl29 width=226 style='width:170pt'>Fax: <%= dt1.Rows[0]["fax_no"] %></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl25 colspan=2 align=left style='mso-ignore:colspan'>Tax code: <%= dt1.Rows[0]["tax_code"] %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl31 width=205 style='width:154pt'></td>
  <td colspan=3 class=xl31 width=226 style='width:170pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
 </tr>
 <tr class=xl27 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=15 height=40 class=xl42 style='height:30.0pt'>Report Purchase
  Order</td>
 </tr>
 <tr class=xl25 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl41 style='height:13.5pt;border-top:none'>Supplier</td>
  <td class=xl41 style='border-top:none;border-left:none'>P/O Date</td>
  <td class=xl41 style='border-top:none;border-left:none'>P/O No</td>
  <td class=xl41 style='border-top:none;border-left:none'>Seq</td>
  <td class=xl41 style='border-top:none;border-left:none'>Item Code</td>
  <td class=xl41 style='border-top:none;border-left:none'>Item Name</td>
  <td class=xl41 style='border-top:none;border-left:none'>P/O Qty</td>
  <td class=xl41 style='border-top:none;border-left:none'>UOM</td>
  <td class=xl41 style='border-top:none;border-left:none'>U/P</td>
  <td class=xl41 style='border-top:none;border-left:none'>P/O Amount</td>
  <td class=xl41 style='border-top:none;border-left:none'>VAT</td>
  <td class=xl41 style='border-top:none;border-left:none'>VAT Amount</td>
  <td class=xl41 style='border-top:none;border-left:none'>Amount</td>
  <td class=xl41 style='border-top:none;border-left:none'>Currency</td>
  <td class=xl41 style='border-top:none;border-left:none'>Remark</td>
 </tr>
 <%
            string para = "'" + p_company_pk + "','" + p_from_date + "','" + p_to_date + "','" + p_po_vendor + "','" + p_item_group_pk + "','" + p_item + "' ";
			
            decimal PoQty = 0;
            decimal PoAmount = 0;
            decimal Amount = 0;
            DataTable dt;
            dt = ESysLib.TableReadOpenCursor("lg_rpt_epbp00040", para);
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
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
     <%  if (strSupplier != dt.Rows[i]["partner_name"].ToString())
                {
     %>
  <td rowspan="<%= arrSupplier_count[b] %>" height=20 class=xl43 align=left style='height:15.0pt;border-top:none'><%= dt.Rows[i]["partner_name"]%></td>
     <%                         
                strSupplier = dt.Rows[i]["partner_name"].ToString();
                b++;
            }
     %>
     <%  if (strPoNo != dt.Rows[i]["po_no"].ToString())
                {%>
  <td rowspan="<%= arrPoNo_count[a] %>" class=xl44 style='border-top:none;border-left:none'><%=System.DateTime.ParseExact(dt.Rows[i]["po_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td rowspan="<%= arrPoNo_count[a] %>" class=xl43 align=left style='border-top:none;border-left:none'><%= dt.Rows[i]["po_no"]%></td>
  <%                         
                strPoNo = dt.Rows[i]["po_no"].ToString();
                a++;
            }%>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["seq"]%></td>
  <td class=xl33 align=left style='border-top:none;border-left:none'><%= dt.Rows[i]["item_code"]%></td>
  <td class=xl34 align=left width=107 style='border-top:none;border-left:none;
  width:80pt'><%= dt.Rows[i]["item_name"]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["po_qty_01"]%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%= dt.Rows[i]["po_uom_01"]%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["unit_price"]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i]["po_amt"]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["vat_rate"]%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i]["vat_amount"]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none'
  x:num><%= dt.Rows[i]["total_amt"]%></td>
  <td class=xl38 align=left style='border-top:none;border-left:none'><%= dt.Rows[i]["po_ccy"]%></td>
  <td class=xl38 align=left style='border-top:none;border-left:none'><%= dt.Rows[i]["description"]%></td>
 </tr>
 <%} %>
 <tr class=xl27 height=14 style='height:10.5pt'>
  <td height=14 class=xl39 style='height:10.5pt'>&nbsp;</td>
  <td class=xl39 style='border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>G6:G<%= dt.Rows.Count+5%><%}else{%>G8:G8<%}%>)"></td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>J6:J<%= dt.Rows.Count+5%><%}else{%>J8:J8<%}%>)"></td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>M6:M<%= dt.Rows.Count+5%><%}else{%>M8:M8<%}%>)"></td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=109 style='width:82pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=73 style='width:55pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
