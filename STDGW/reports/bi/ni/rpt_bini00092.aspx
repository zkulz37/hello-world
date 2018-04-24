<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser(Session["APP_DBUSER"].ToString());%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_tin_warehouse_pk = Request.QueryString["p_tin_warehouse_pk"];
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string p_po_vendor = Request.QueryString["p_po_vendor"];
    string p_item = Request.QueryString["p_item"];
    string p_tin_warehouse_name = Request.QueryString["p_tin_warehouse_name"];
    string ccy = Request.QueryString["ccy"];
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bini00022_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bini00022_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bini00022_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:Created>2010-12-14T02:33:33Z</o:Created>
  <o:LastSaved>2010-12-14T03:03:39Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .5in .75in .5in;
	mso-header-margin:.5in;
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
	vertical-align:middle;
	border-top:none;
	border-right:none ;
	border-bottom:none ;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl34
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
.xl35
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
.xl36
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
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
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1462 style='border-collapse:
 collapse;table-layout:fixed;width:1097pt'>
 <col width=190 style='mso-width-source:userset;mso-width-alt:6948;width:143pt'>
 <col width=195 style='mso-width-source:userset;mso-width-alt:7131;width:146pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=64 span=7 style='width:48pt'>
 <tr height=31 style='height:23.25pt'>
  <td colspan=10 height=31 class=xl34 width=1014 style='border-right:.5pt solid black;
  height:23.25pt;width:761pt'>Report Stock Incoming Checking</td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Ware
  house: <%= p_tin_warehouse_name %></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>Date: <span style='mso-spacerun:yes'><%= System.DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy") %>
                ~
                <%= System.DateTime.ParseExact(p_to_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></span></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Supplier</td>
  <td class=xl29>Group</td>
  <td class=xl29>Quantity</td>
  <td class=xl29>UOM</td>
  <td class=xl29>Item Amount</td>
  <td class=xl29>Vat Rate</td>
  <td class=xl29>Vat Amt</td>
  <td class=xl29>Total Amt</td>
  <td class=xl29>CCY</td>
  <td class=xl29>Total <%=ccy%> Amt</td>
 </tr>
           <%
            string para = "'" + p_tin_warehouse_pk + "','" + p_from_date + "','" +p_to_date + "','" + p_po_vendor+ "','" + p_item+ "','"+ccy+"'" ;
            DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_bini00092", para);
            decimal TotalQuantity = 0;
            decimal TotalVatAmt = 0;
            decimal TotalAmt = 0;
            decimal TotalDisAmt = 0;
            //=================Supplier================
            string strSupplier = string.Empty;
            int[] arrSupplier_count = new int[1000];
            int strSupplier_count = 1;
            int iChangeSup = 0;
            int a = 0;
            for (int y = 0; y < dt.Rows.Count; y++)
            {
                if (strSupplier == "" || strSupplier == null)
                {
                    strSupplier = dt.Rows[y]["partner_name"].ToString().Trim();
                    strSupplier_count = 1;
                }
                else
                {
                    if (dt.Rows[y]["partner_name"].ToString().Trim() != strSupplier.Trim())
                    {
                        arrSupplier_count[a] = strSupplier_count;
                        strSupplier_count = 1;
                        a++;
                        strSupplier = dt.Rows[y]["partner_name"].ToString().Trim();
                    }
                    else
                    {
                        strSupplier_count++;
                    }
                }
            }
            //------------------------ 
            arrSupplier_count[a] = strSupplier_count;
            a = 0;
            strSupplier = string.Empty;
            //=================Group================
            string strGroup = string.Empty;
            string strG2 = string.Empty;
            int[] arrGroup_count = new int[1000];
            int strGroup_count = 1;
            int b = 0;
            for (int z = 0; z < dt.Rows.Count; z++)
            {
                if (strGroup == "" || strGroup == null)
                {
                    strGroup = dt.Rows[z]["grp_nm"].ToString().Trim();
                    strSupplier = dt.Rows[z]["partner_name"].ToString().Trim() ;
                    strGroup_count = 1;
                }
                else
                {
                    if (dt.Rows[z]["grp_nm"].ToString().Trim() != strGroup.Trim() || dt.Rows[z]["partner_name"].ToString().Trim() != strSupplier.Trim())
                    {
                        arrGroup_count[b] = strGroup_count;
                        strGroup_count = 1;
                        b++;
                        strGroup = dt.Rows[z]["grp_nm"].ToString().Trim();
                        strSupplier = dt.Rows[z]["partner_name"].ToString().Trim() ;
                    }
                    else
                    {
                        strGroup_count++;
                    }
                }
            }
            //------------------------ 
            arrGroup_count[b] = strGroup_count;
            b = 0;
            strGroup = string.Empty;
            //=====================================
            for (int i = 0; i < dt.Rows.Count; i++)
            {  
         %>
 <tr height=17 style='height:12.75pt'>
 <% if (strSupplier != dt.Rows[i]["partner_name"].ToString()) {%>
  <td rowspan="<%= arrSupplier_count[a] %>" height=17 class=xl37 width=190 style='height:12.75pt;width:143pt'><%= dt.Rows[i]["partner_name"]%></td>
  <%                strSupplier = dt.Rows[i]["partner_name"].ToString();
                    a++;
                    iChangeSup = 1;
    }%>
   <% if ( strGroup != dt.Rows[i]["grp_nm"].ToString() || iChangeSup == 1 ) {%>
  <td rowspan="<%= arrGroup_count[b] %>" class=xl41 width=195 style='width:146pt'><%= dt.Rows[i]["grp_nm"]%></td>
    <%                strGroup = dt.Rows[i]["grp_nm"].ToString();
                    b++;
                    iChangeSup = 0;
    }%>
  <td class=xl38 align=right x:num><%= dt.Rows[i]["in_qty"]%></td>
  <td class=xl40><%= dt.Rows[i]["in_uom"]%></td>
  <td class=xl39 align=right x:num><%= dt.Rows[i]["item_amount"]%></td>
  <td class=xl39 align=right x:num><%= dt.Rows[i]["vat_rate"]%></td>
  <td class=xl39 align=right x:num><%= dt.Rows[i]["vat_amount"]%></td>
  <td class=xl38 align=right x:num><%= dt.Rows[i]["total_amount"]%></td>  
  <td class=xl30><%= dt.Rows[i]["ccy"]%></td>
  <td class=xl38 align=right x:num><%= dt.Rows[i]["dis_amount"]%></td>
 </tr><%
     TotalQuantity += Convert.ToDecimal(dt.Rows[i]["in_qty"]);
     TotalVatAmt += Convert.ToDecimal(dt.Rows[i]["vat_amount"]);
     TotalAmt += Convert.ToDecimal(dt.Rows[i]["total_amount"]);
     TotalDisAmt += Convert.ToDecimal(dt.Rows[i]["dis_amount"]);           
 } %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33 align=right x:num><%= TotalQuantity %></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33 align=right x:num><%= TotalVatAmt%></td>
  <td class=xl33 align=right x:num><%= TotalAmt%></td>  
  <td class=xl32>&nbsp;</td>
  <td class=xl33 align=right x:num><%= TotalDisAmt%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=190 style='width:143pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
