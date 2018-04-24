<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_tin_wh = Request.QueryString["p_tin_warehouse_pk"];
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string p_item = Request.QueryString["p_item"];
    string p_ref_no_vendor = Request.QueryString["p_ref_no_vendor"]; 
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_bini00020_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_bini00020_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_bini00020_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr. Khanh</o:LastAuthor>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-09-16T09:43:07Z</o:LastSaved>
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	vertical-align:middle;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid #3366FF;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;
	mso-number-format:"Short Date";
	border:.5pt solid #3366FF;}
.xl27
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid #3366FF;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid #3366FF;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid #3366FF;}
.xl30
	{mso-style-parent:style0;
	border:.5pt solid #3366FF;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border:.5pt solid #3366FF;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border:.5pt solid #3366FF;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid #3366FF;
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
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
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
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1815" style='border-collapse: collapse;
        table-layout: fixed; width: 1374pt'>
        <col width="97" style='mso-width-source: userset; mso-width-alt: 3547; width: 73pt'>
        <col width="64" span="3" style='width: 48pt'>
        <col width="39" style='mso-width-source: userset; mso-width-alt: 1426; width: 29pt'>
        <col width="71" style='mso-width-source: userset; mso-width-alt: 2596; width: 53pt'>
        <col width="192" style='mso-width-source: userset; mso-width-alt: 7021; width: 144pt'>
        <col width="64" span="2" style='width: 48pt'>
        <col width="114" span="2" style='mso-width-source: userset; mso-width-alt: 4169;
            width: 86pt'>
        <col width="64" style='width: 48pt'>
        <col width="104" style='mso-width-source: userset; mso-width-alt: 3803; width: 78pt'>
        <col width="114" style='mso-width-source: userset; mso-width-alt: 4169; width: 86pt'>
        <col width="64" style='width: 48pt'>
        <col width="203" style='mso-width-source: userset; mso-width-alt: 7424; width: 152pt'>
        <col width="100" style='mso-width-source: userset; mso-width-alt: 5000; width: 100pt'>
        <col width="191" style='mso-width-source: userset; mso-width-alt: 6985; width: 143pt'>
        <col width="64" style='width: 48pt'>
        <tr height="31" style='height: 23.25pt'>
            <td colspan="18" height="31" class="xl32" width="1751" style='height: 23.25pt; width: 1314pt'>
                Report Stock Incoming Checking</td>
            <td width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl31" style='height: 12.75pt; border-top: none'>
                W/H</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                In Date</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                Slip No</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                Ref No</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                Seq</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                Item Code</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                Item Name</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                In Qty</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                UOM</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                U/P</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                Amount</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                VAT(%)</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                VAT Amt</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                Total Amt</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                CYY</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                Supplier</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                P/L</td>
            <td class="xl31" style='border-top: none; border-left: none'>
                Description</td>
            <td class="xl24">
            </td>
        </tr>
        <%
            string para = " '" + p_tin_wh + "','" + p_from_date + "','" + p_to_date + "','" + p_ref_no_vendor + "','" + p_item + "' ";
            DataTable dt;
            dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_bini00020", para);

            decimal TotalInQty = 0;
            decimal TotalAmount = 0;
            decimal TotalVatAmount = 0;
            decimal TotalAmt = 0;
            //------------------- W/P Name -------------------    
            string strWhName = string.Empty;
            int[] arrWH_count = new int[dt.Rows.Count];
            int strWH_count = 1;
            int a = 0;
            for (int y = 0; y < dt.Rows.Count; y++)
            {
                if (strWhName == "" || strWhName == null)
                {
                    strWhName = dt.Rows[y]["wh_id"].ToString().Trim();
                    strWH_count = 1;
                }
                else
                {
                    if (dt.Rows[y]["wh_id"].ToString().Trim() != strWhName.Trim())
                    {
                        arrWH_count[a] = strWH_count;
                        strWH_count = 1;
                        a++;
                        strWhName = dt.Rows[y]["wh_id"].ToString().Trim();
                    }
                    else
                    {
                        strWH_count++;
                    }
                }
            }
            //------------------------ 
            arrWH_count[a] = strWH_count;
            a = 0;
            strWhName = string.Empty;
            //--------------- End W/P Name -------------------   

            //------------------- Slip No -------------------    
            string strSlipNo = string.Empty;
            int[] arrSlipNo_count = new int[dt.Rows.Count];
            int strSlipNo_count = 1;
            int b = 0;
            for (int z = 0; z < dt.Rows.Count; z++)
            {
                if (strSlipNo == "" || strSlipNo == null)
                {
                    strSlipNo = dt.Rows[z]["slip_no"].ToString().Trim();
                    strSlipNo_count = 1;
                }
                else
                {
                    if (dt.Rows[z]["slip_no"].ToString().Trim() != strSlipNo.Trim())
                    {
                        arrSlipNo_count[b] = strSlipNo_count;
                        strSlipNo_count = 1;
                        b++;
                        strSlipNo = dt.Rows[z]["slip_no"].ToString().Trim();
                    }
                    else
                    {
                        strSlipNo_count++;
                    }
                }
            }
            //------------------------ 
            arrSlipNo_count[b] = strSlipNo_count;
            b = 0;
            strSlipNo = string.Empty;
            //--------------- End Slip No -------------------   
            //=======================
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TotalInQty += Convert.ToDecimal(dt.Rows[i]["in_qty"]);
                TotalAmount += Convert.ToDecimal(dt.Rows[i]["item_amount"]);
                TotalVatAmount += Convert.ToDecimal(dt.Rows[i]["vat_amount"]);
                TotalAmt += Convert.ToDecimal(dt.Rows[i]["total_amount"]);
        %>
        <tr height="17" style='height: 12.75pt'>
            <%  if (strWhName != dt.Rows[i]["wh_id"].ToString())
                {
            %>
            <td rowspan="<%= arrWH_count[a] %>" height="17" class="xl25" style='height: 12.75pt;
                border-top: none'>
                <%= dt.Rows[i]["wh_id"]%>
            </td>
            <%                         
                strWhName = dt.Rows[i]["wh_id"].ToString();
                a++;
            }                   
            %>
            <%  if (strSlipNo != dt.Rows[i]["slip_no"].ToString())
                {
            %>
            <td rowspan="<%= arrSlipNo_count[b]%>" class="xl26" align="right" style='border-top: none;
                border-left: none' x:num>
                <%= System.DateTime.ParseExact(dt.Rows[i]["in_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%>
            </td>
            <td rowspan="<%= arrSlipNo_count[b] %>" class="xl27" align="right" style='border-top: none;
                border-left: none' x:num>
                <%= dt.Rows[i]["slip_no"]%>
            </td>
            <td rowspan="<%= arrSlipNo_count[b] %>" class="xl25" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["ref_no"]%>
            </td>
            <%                         
                strSlipNo = dt.Rows[i]["slip_no"].ToString();
                b++;
            }                   
            %>
            <td class="xl27" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["seq"]%>
            </td>
            <td class="xl25" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["item_code"]%>
            </td>
            <td class="xl27" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["item_name"]%>
            </td>
            <td class="xl28" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["in_qty"]%>
            </td>
            <td class="xl27" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["in_uom"]%>
            </td>
            <td class="xl29" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["unit_price"]%>
            </td>
            <td class="xl28" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["item_amount"]%>
            </td>
            <td class="xl29" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["vat_rate"]%>
            </td>
            <td class="xl29" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["vat_amount"]%>
            </td>
            <td class="xl28" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["total_amount"]%>
            </td>
            <td class="xl27" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["ccy"]%>
            </td>
            <td class="xl27" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["partner_name"]%>
            </td>
            <td class="xl27" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["pl"]%>
            </td>
            <td class="xl27" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["description"]%>
            </td>
            <td>
            </td>
        </tr>
        <% } %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl30" style='height: 12.75pt; border-top: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= TotalInQty %>
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= TotalAmount %>
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= TotalVatAmount %>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= TotalAmt %>
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl30" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td>
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="97" style='width: 73pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="39" style='width: 29pt'>
            </td>
            <td width="71" style='width: 53pt'>
            </td>
            <td width="192" style='width: 144pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="114" style='width: 86pt'>
            </td>
            <td width="114" style='width: 86pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="104" style='width: 78pt'>
            </td>
            <td width="114" style='width: 86pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="203" style='width: 152pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="191" style='width: 143pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
