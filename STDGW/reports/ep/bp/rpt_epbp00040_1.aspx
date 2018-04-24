<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string p_po_vendor = Request.QueryString["p_po_vendor"];
    string p_item = Request.QueryString["p_item"];
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00040_1_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00040_1_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00040_1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr. Khanh</o:LastAuthor>
  <o:LastPrinted>2010-09-30T02:09:18Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-09-30T02:09:28Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
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
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=979 style='border-collapse:
 collapse;table-layout:fixed;width:735pt'>
 <col width=64 style='width:48pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=143 style='mso-width-source:userset;mso-width-alt:5229;width:107pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=27 style='height:20.25pt'>
  <td colspan=14 height=27 class=xl25 width=979 style='height:20.25pt;
  width:735pt'>Report Purchase Order</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt'>Supplier</td>
  <td class=xl26 style='border-left:none'>P/O Date</td>
  <td class=xl26 style='border-left:none'>P/O No</td>
  <td class=xl26 style='border-left:none'>Seq</td>
  <td class=xl26 style='border-left:none'>Item Code-Name</td>
  <td class=xl26 style='border-left:none'>P/O Qty</td>
  <td class=xl26 style='border-left:none'>UOM</td>
  <td class=xl26 style='border-left:none'>U/P</td>
  <td class=xl26 style='border-left:none'>P/O Amount</td>
  <td class=xl26 style='border-left:none'>VAT Rate</td>
  <td class=xl26 style='border-left:none'>VAT Amount</td>
  <td class=xl26 style='border-left:none'>Amount</td>
  <td class=xl26 style='border-left:none'>Currency</td>
  <td class=xl26 style='border-left:none'>Remark</td>
  <td class=xl24></td>
 </tr>
 <%
        string para = "'" + p_from_date + "','" + p_to_date + "','" + p_po_vendor + "','" + p_item + "' ";     
        DataTable dt;
        dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00040", para);
        //------------------
        decimal PoQty = 0;
        decimal PoAmount = 0;
        decimal Amount = 0;
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
 <tr height=64 style='height:48.0pt'>
            <%  if (strSupplier != dt.Rows[i]["partner_name"].ToString())
                {
            %> 
  <td rowspan="<%= arrSupplier_count[b] %>" height=64 class=xl27 align=left width=64 style='height:48.0pt;border-top:
  none;width:48pt'><%= dt.Rows[i]["partner_name"]%></td>
            <%                         
                    strSupplier = dt.Rows[i]["partner_name"].ToString();
                    b++;
                }
            %>  
            <%  if (strPoNo != dt.Rows[i]["po_no"].ToString())
                {
            %>            
  <td rowspan="<%= arrPoNo_count[a] %>" class=xl28 align=left style='border-top:none;border-left:none'><%=System.DateTime.ParseExact(dt.Rows[i]["po_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td rowspan="<%= arrPoNo_count[a] %>" class=xl28 align=left style='border-top:none;border-left:none'><%= dt.Rows[i]["po_no"]%></td>
            <%                         
                    strPoNo = dt.Rows[i]["po_no"].ToString();
                    a++;
                }
            %>  
  <td class=xl29 style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["seq"]%></td>
  <td class=xl27 align=left width=143 style='border-top:none;border-left:none;
  width:107pt'><%= dt.Rows[i]["item_code"]%>:<%= dt.Rows[i]["item_name"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["po_qty_01"]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%= dt.Rows[i]["po_uom_01"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["unit_price"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["po_amt"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["vat_rate"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["vat_amount"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt.Rows[i]["total_amt"]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%= dt.Rows[i]["po_ccy"]%></td>
  <td class=xl27 align=left width=64 style='border-top:none;border-left:none;
  width:48pt'><%= dt.Rows[i]["description"]%></td>
  <td></td>
 </tr>
 <% 
                 PoQty += Convert.ToDecimal(dt.Rows[i]["po_qty_01"]);
                 PoAmount += Convert.ToDecimal(dt.Rows[i]["po_amt"]);
                 Amount += Convert.ToDecimal(dt.Rows[i]["total_amt"]);
        }   
 %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl32 style='border-right:.5pt solid black;
  height:12.75pt'>&nbsp;</td>
  <td class=xl35 align=right style='border-top:none;border-left:none'
  x:num><%= PoQty %></td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 align=right style='border-top:none;border-left:none'
  x:num><%= PoAmount %></td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
<td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>  
  <td class=xl35 align=right style='border-top:none;border-left:none'
  x:num><%= Amount %></td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
