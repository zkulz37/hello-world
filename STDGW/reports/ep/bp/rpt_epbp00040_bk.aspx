<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string p_po_vendor = Request.QueryString["p_po_vendor"];
    string p_item = Request.QueryString["p_item"];
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_epbp00040_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_epbp00040_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_epbp00040_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr. Khanh</o:LastAuthor>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-09-18T07:48:54Z</o:LastSaved>
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
	color:red;
	font-size:18.0pt;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border:.5pt solid blue;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid black;
	border-left:.5pt solid blue;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:.5pt solid black;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	border-top:.5pt solid black;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid black;
	border-left:.5pt solid blue;}
.xl30
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid black;
	border-left:.5pt solid blue;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid black;
	border-left:.5pt solid blue;}
.xl32
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid black;
	border-left:.5pt solid blue;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid black;
	border-left:.5pt solid blue;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid black;
	border-left:.5pt solid blue;}
.xl35
	{mso-style-parent:style0;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	border-top:.5pt solid black;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
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
<body link="blue" vlink="purple">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1444" style='border-collapse: collapse;
        table-layout: fixed; width: 1084pt'>
        <col width="142" style='mso-width-source: userset; mso-width-alt: 5193; width: 107pt'>
        <col width="75" style='mso-width-source: userset; mso-width-alt: 2742; width: 56pt'>
        <col width="83" style='mso-width-source: userset; mso-width-alt: 3035; width: 62pt'>
        <col width="39" style='mso-width-source: userset; mso-width-alt: 1426; width: 29pt'>
        <col width="102" style='mso-width-source: userset; mso-width-alt: 3730; width: 77pt'>
        <col width="277" style='mso-width-source: userset; mso-width-alt: 10130; width: 208pt'>
        <col width="76" style='mso-width-source: userset; mso-width-alt: 2779; width: 57pt'>
        <col width="64" style='width: 48pt'>
        <col width="82" style='mso-width-source: userset; mso-width-alt: 2998; width: 62pt'>
        <col width="111" style='mso-width-source: userset; mso-width-alt: 4059; width: 83pt'>
        <col width="64" style='width: 48pt'>
        <col width="81" style='mso-width-source: userset; mso-width-alt: 2962; width: 61pt'>
        <col width="111" style='mso-width-source: userset; mso-width-alt: 4059; width: 83pt'>
        <col width="64" style='width: 48pt'>
        <col width="73" style='mso-width-source: userset; mso-width-alt: 2669; width: 55pt'>
        <tr height="31" style='height: 23.25pt'>
            <td colspan="15" height="31" class="xl24" width="1444" style='height: 23.25pt; width: 1084pt'>
                Report Purchase Order</td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl25" style='height: 12.75pt'>
                Supplier</td>
            <td class="xl25" style='border-left: none'>
                P/O Date</td>
            <td class="xl25" style='border-left: none'>
                P/O No</td>
            <td class="xl25" style='border-left: none'>
                Seq</td>
            <td class="xl25" style='border-left: none'>
                Item Code</td>
            <td class="xl25" style='border-left: none'>
                Item Name</td>
            <td class="xl25" style='border-left: none'>
                P/O Qty</td>
            <td class="xl25" style='border-left: none'>
                UOM</td>
            <td class="xl25" style='border-left: none'>
                U/P</td>
            <td class="xl25" style='border-left: none'>
                P/O Amount</td>
            <td class="xl25" style='border-left: none'>
                VAT Rate</td>
            <td class="xl25" style='border-left: none'>
                VAT Amount</td>
            <td class="xl25" style='border-left: none'>
                Amount</td>
            <td class="xl25" style='border-left: none'>
                Currency</td>
            <td class="xl25" style='border-left: none'>
                Remark</td>
        </tr>
        <%
            string para = "'" + p_from_date + "','" + p_to_date + "','" + p_po_vendor + "','" + p_item + "' ";
            decimal PoQty = 0;
            decimal PoAmount = 0;
            decimal Amount = 0;
            DataTable dt;
            dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00040", para);
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
                PoQty += Convert.ToDecimal(dt.Rows[i]["po_qty_01"]);
                PoAmount += Convert.ToDecimal(dt.Rows[i]["po_amt"]);
                Amount += Convert.ToDecimal(dt.Rows[i]["total_amt"]);
        %>
        <tr height="17" style='height: 12.75pt'>
            <%  if (strSupplier != dt.Rows[i]["partner_name"].ToString())
                {%>
            <td rowspan="<%= arrSupplier_count[b] %>" height="17" class="xl26" style='height: 12.75pt;
                border-top: none'>
                <%= dt.Rows[i]["partner_name"]%>
            </td>
            <%                         
                strSupplier = dt.Rows[i]["partner_name"].ToString();
                b++;
            }%>
            <%  if (strPoNo != dt.Rows[i]["po_no"].ToString())
                {%>
            <td rowspan="<%= arrPoNo_count[a] %>" class="xl29" style='border-top: none; border-left: none'>
                <%=System.DateTime.ParseExact(dt.Rows[i]["po_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%>
            </td>
            <td rowspan="<%= arrPoNo_count[a] %>" class="xl30" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["po_no"]%>
            </td>
            <%                         
                strPoNo = dt.Rows[i]["po_no"].ToString();
                a++;
            }%>
            <td class="xl30" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["seq"]%>
            </td>
            <td class="xl31" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["item_code"]%>
            </td>
            <td class="xl32" width="277" style='border-top: none; border-left: none; width: 208pt'>
                <%= dt.Rows[i]["item_name"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["po_qty_01"]%>
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["po_uom_01"]%>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["unit_price"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["po_amt"]%>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["vat_rate"]%>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["vat_amount"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["total_amt"]%>
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["po_ccy"]%>
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["description"]%>
            </td>
        </tr>
        <% } %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl28" style='height: 12.75pt; border-top: none'>
                &nbsp;</td>
            <td class="xl28" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl35" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl36" style='border-top: none'>
                &nbsp;</td>
            <td class="xl36" style='border-top: none'>
                &nbsp;</td>
            <td class="xl37" style='border-top: none'>
                &nbsp;</td>
            <td class="xl27" align="right" style='border-top: none; border-left: none' x:num>
                <%= PoQty %>
            </td>
            <td class="xl35" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl37" style='border-top: none'>
                &nbsp;</td>
            <td class="xl27" align="right" style='border-top: none; border-left: none' x:num>
                <%= PoAmount %>
            </td>
            <td class="xl35" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl37" style='border-top: none'>
                &nbsp;</td>
            <td class="xl27" align="right" style='border-top: none; border-left: none' x:num>
                <%= Amount %>
            </td>
            <td class="xl35" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl37" style='border-top: none'>
                &nbsp;</td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="142" style='width: 107pt'>
            </td>
            <td width="75" style='width: 56pt'>
            </td>
            <td width="83" style='width: 62pt'>
            </td>
            <td width="39" style='width: 29pt'>
            </td>
            <td width="102" style='width: 77pt'>
            </td>
            <td width="277" style='width: 208pt'>
            </td>
            <td width="76" style='width: 57pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="82" style='width: 62pt'>
            </td>
            <td width="111" style='width: 83pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="81" style='width: 61pt'>
            </td>
            <td width="111" style='width: 83pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="73" style='width: 55pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
