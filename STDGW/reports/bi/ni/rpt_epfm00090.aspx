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
    <link rel="File-List" href="rpt_epfm00090_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_epfm00090_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_epfm00090_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr. Khanh</o:LastAuthor>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-09-17T02:58:41Z</o:LastSaved>
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	vertical-align:middle;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;}
.xl25
	{mso-style-parent:style0;
	mso-number-format:"\@";
	border-top:none;
	vertical-align:middle;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	border-top:none;
	vertical-align:middle;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
    vertical-align:middle;	
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:Standard;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:Standard;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	color:blue;
	text-align:center;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;}
.xl40
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
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
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1741" style='border-collapse: collapse;
        table-layout: fixed; width: 1306pt'>
        <col width="64" style='width: 48pt'>
        <col width="71" style='mso-width-source: userset; mso-width-alt: 2596; width: 53pt'>
        <col width="64" style='width: 48pt'>
        <col width="76" style='mso-width-source: userset; mso-width-alt: 2779; width: 57pt'>
        <col width="44" style='mso-width-source: userset; mso-width-alt: 1609; width: 33pt'>
        <col width="76" style='mso-width-source: userset; mso-width-alt: 2779; width: 57pt'>
        <col width="216" style='mso-width-source: userset; mso-width-alt: 7899; width: 162pt'>
        <col width="72" span="2" style='mso-width-source: userset; mso-width-alt: 2633; width: 54pt'>
        <col width="111" span="2" style='mso-width-source: userset; mso-width-alt: 4059;
            width: 83pt'>
        <col width="74" span="2" style='mso-width-source: userset; mso-width-alt: 2706; width: 56pt'>
        <col width="127" style='mso-width-source: userset; mso-width-alt: 4644; width: 95pt'>
        <col width="64" style='width: 48pt'>
        <col width="229" style='mso-width-source: userset; mso-width-alt: 8374; width: 172pt'>
       <col width="132" style='mso-width-source: userset; mso-width-alt: 4827; width: 99pt'>
        <col width="132" style='mso-width-source: userset; mso-width-alt: 4827; width: 99pt'>
        <tr height="31" style='height: 23.25pt'>
            <td colspan="18" height="31" class="xl39" width="1741" style='border-right: .5pt solid blue;
                height: 23.25pt; width: 1306pt'>
                Report Stock Outgoing Checking</td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl37" style='height: 12.75pt'>
                W/H</td>
            <td class="xl38">
                Out Date</td>
            <td class="xl38">
                Slip No</td>
            <td class="xl38">
                Ref No</td>
            <td class="xl38">
                Seq</td>
            <td class="xl38">
                Item Code</td>
            <td class="xl38">
                Item Name</td>
            <td class="xl38">
                Out Qty</td>
            <td class="xl38">
                UOM</td>
            <td class="xl38">
                U/P</td>
            <td class="xl38">
                Amount</td>
            <td class="xl38">
                VAT(%)</td>
            <td class="xl38">
                VAT Amt</td>
            <td class="xl38">
                Total Amt</td>
            <td class="xl38">
                CCY</td>
            <td class="xl38">
                Supplier</td>
            <td class="xl38">
                P/L</td>
            <td class="xl38">
                Description</td>
        </tr>
<%
            string para = " '" + p_tin_wh + "','" + p_from_date + "','" + p_to_date + "','" + p_ref_no_vendor + "','" + p_item + "' ";
            DataTable dt;
            dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00090", para);

            decimal TotalOutQty = 0;
            decimal TotalAmount = 0;
            decimal TotalVatAmount = 0;
            decimal TotalAmt = 0;
            //------------------- W/P ID -------------------    
            string strWhName = string.Empty;
            int[] arrWH_count = new int[100];
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
            int[] arrSlipNo_count = new int[100];
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
                TotalOutQty += Convert.ToDecimal(dt.Rows[i]["out_qty"]);
                TotalAmount += Convert.ToDecimal(dt.Rows[i]["item_amount"]);
                TotalVatAmount += Convert.ToDecimal(dt.Rows[i]["vat_amount"]);
                TotalAmt += Convert.ToDecimal(dt.Rows[i]["total_amount"]);
        %>        
        <tr height="17" style='height: 12.75pt'>
            <%  if (strWhName != dt.Rows[i]["wh_id"].ToString())
                {%>                    
            <td  rowspan="<%= arrWH_count[a] %>" height="17" class="xl24" align="left" style='height: 12.75pt'><%= dt.Rows[i]["wh_id"]%></td>                
            <%                         
                strWhName = dt.Rows[i]["wh_id"].ToString();
                a++;}%> 
            <%  if (strSlipNo != dt.Rows[i]["slip_no"].ToString())
                {%>   
            <td rowspan="<%= arrSlipNo_count[b] %>" class="xl25" align="left">
                <%=System.DateTime.ParseExact(dt.Rows[i]["out_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>            
            <td rowspan="<%= arrSlipNo_count[b] %>" class="xl26" align="right" x:num>           
                <%= dt.Rows[i]["slip_no"]%></td>
            <td rowspan="<%= arrSlipNo_count[b] %>" class="xl27" align="left">
                <%= dt.Rows[i]["ref_no"]%></td>
            <%                         
                strSlipNo = dt.Rows[i]["slip_no"].ToString();
                b++;} %>    
            <td class="xl26" align="right" x:num>
                <%= dt.Rows[i]["seq"]%></td>
            <td class="xl27" align="left">
                <%= dt.Rows[i]["item_code"]%></td>
            <td class="xl28" align="left" width="216" style='width: 162pt'>
                <%= dt.Rows[i]["item_name"]%></td>
            <td class="xl29" align="right" x:num>
                <%= dt.Rows[i]["out_qty"]%></td>
            <td class="xl26" align="left">
                <%= dt.Rows[i]["out_uom"]%></td>
            <td class="xl30" align="right" x:num>
                <%= dt.Rows[i]["unit_price"]%></td>
            <td class="xl29" align="right" x:num>
                <%= dt.Rows[i]["item_amount"]%></td>
            <td class="xl30">
                <%= dt.Rows[i]["vat_rate"]%></td>
            <td class="xl30" align="right" x:num>
                <%= dt.Rows[i]["vat_amount"]%></td>
            <td class="xl29" align="right" x:num>
                <%= dt.Rows[i]["total_amount"]%></td>
            <td class="xl26" align="left">
                <%= dt.Rows[i]["ccy"]%></td>
            <td class="xl26" align="left">
                <%= dt.Rows[i]["partner_name"]%></td>
            <td class="xl26" align="left">
                <%= dt.Rows[i]["pl"]%></td>
            <td class="xl26" align="left">
                <%= dt.Rows[i]["description"]%></td>
        </tr>
        <%} %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl31" style='height: 12.75pt'>
                &nbsp;</td>
            <td class="xl32">
                &nbsp;</td>
            <td class="xl32">
                &nbsp;</td>
            <td class="xl33">
                &nbsp;</td>
            <td class="xl32">
                &nbsp;</td>
            <td class="xl32">
                &nbsp;</td>
            <td class="xl34">
                &nbsp;</td>
            <td class="xl35" align="right" x:num>
                <%= TotalOutQty %></td>
            <td class="xl36">
                &nbsp;</td>
            <td class="xl36">
                &nbsp;</td>
            <td class="xl35" align="right" x:num>
                <%= TotalAmount %></td>
            <td class="xl36">
                &nbsp;</td>
            <td class="xl35" align="right" x:num>
                <%= TotalVatAmount %></td>
            <td class="xl35" align="right" x:num>
                <%= TotalAmt %></td>
            <td class="xl36">
                &nbsp;</td>
            <td class="xl36">
                &nbsp;</td>
            <td class="xl36">
                &nbsp;</td>
            <td class="xl36">
                &nbsp;</td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="71" style='width: 53pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="76" style='width: 57pt'>
            </td>
            <td width="44" style='width: 33pt'>
            </td>
            <td width="76" style='width: 57pt'>
            </td>
            <td width="216" style='width: 162pt'>
            </td>
            <td width="72" style='width: 54pt'>
            </td>
            <td width="72" style='width: 54pt'>
            </td>
            <td width="111" style='width: 83pt'>
            </td>
            <td width="111" style='width: 83pt'>
            </td>
            <td width="74" style='width: 56pt'>
            </td>
            <td width="74" style='width: 56pt'>
            </td>
            <td width="127" style='width: 95pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="229" style='width: 172pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="132" style='width: 99pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
