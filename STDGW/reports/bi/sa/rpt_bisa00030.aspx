<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_pk = Request.QueryString["p_pk"];
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_bisa00040_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_bisa00040_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_bisa00040_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr. Khanh</o:LastAuthor>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-09-17T06:03:28Z</o:LastSaved>
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
	{
    mso-number-format:0;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	vertical-align:middle;
	border-left:.5pt solid blue;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	vertical-align:middle;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	white-space:normal;}
.xl27
	{
	text-align:center;
	vertical-align:middle;		
	border-top:none;
	border-right:.5pt solid blue;
	vertical-align:middle;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:Standard;
	border-top:none;
	vertical-align:middle;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-number-format:Standard;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:none;
	vertical-align:middle;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;}
.xl31
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	vertical-align:middle;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:silver;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	text-align:center;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	color:blue;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	text-align:center;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	color:blue;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	text-align:center;
	border-top:none;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid blue;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	vertical-align:middle;
	border-right:none;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	text-align:left;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:none;
	background:#CCFFCC;
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
       <x:ActiveRow>9</x:ActiveRow>
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
<body link="blue" vlink="purple">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1207" style='border-collapse: collapse;
        table-layout: fixed; width: 906pt'>
        <col width="56" style='mso-width-source: userset; mso-width-alt: 2048; width: 42pt'>
        <col width="94" style='mso-width-source: userset; mso-width-alt: 3437; width: 71pt'>
        <col width="277" style='mso-width-source: userset; mso-width-alt: 10130; width: 208pt'>
        <col width="75" style='mso-width-source: userset; mso-width-alt: 2742; width: 56pt'>
        <col width="64" style='width: 48pt'>
        <col width="71" style='mso-width-source: userset; mso-width-alt: 2596; width: 53pt'>
        <col width="96" style='mso-width-source: userset; mso-width-alt: 3510; width: 72pt'>
        <col width="66" style='mso-width-source: userset; mso-width-alt: 2413; width: 50pt'>
        <col width="95" style='mso-width-source: userset; mso-width-alt: 3474; width: 71pt'>
        <col width="71" style='mso-width-source: userset; mso-width-alt: 2596; width: 53pt'>
        <col width="100" style='mso-width-source: userset; mso-width-alt: 3657; width: 75pt'>
        <col width="142" style='mso-width-source: userset; mso-width-alt: 5193; width: 107pt'>
        <tr height="31" style='height: 23.25pt'>
            <td colspan="12" height="31" class="xl30" width="1207" style='border-right: .5pt solid blue;
                height: 23.25pt; width: 906pt'>
                W/H Stock Adjust</td>
        </tr>
        <%
            string para = " '" + p_pk + "'";
            DataTable dt,dt1;
            dt = ESysLib.TableReadOpenCursor("INV.SP_RPT_BISA00030_1", para);
            for (int i = 0; i < dt.Rows.Count; i++)
            {  
        %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl34" style='height: 12.75pt'>
                W/H</td>
            <td colspan="2" class="xl41">
                <%= dt.Rows[i]["wh_name"]%>
            </td>
            <td class="xl33">
                Stock Date</td>
            <td class="xl41" colspan="2" style='mso-ignore: colspan'>
                <%= System.DateTime.ParseExact(dt.Rows[i]["stock_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%>
            </td>
            <td class="xl42">
                &nbsp;</td>
            <td class="xl33">
                Charger</td>
            <td colspan="4" class="xl41" style='border-right: .5pt solid blue'>
                <%= dt.Rows[i]["adjust_emp"]%>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl34" style='height: 12.75pt'>
                Remark</td>
            <td colspan="11" class="xl41" style='border-right: .5pt solid blue'>
                <%= dt.Rows[i]["description"]%>
            </td>
        </tr>
        <%} %>
        <tr class="xl35" height="17" style='height: 12.75pt'>
            <td colspan="12" height="17" class="xl36" style='border-right: .5pt solid blue; height: 12.75pt'>
                &nbsp;</td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl39" style='height: 12.75pt'>
                Seq</td>
            <td class="xl40">
                Item Code</td>
            <td class="xl40">
                Item Name</td>
            <td class="xl40">
                UOM</td>
            <td class="xl40">
                Lot No</td>
            <td class="xl40">
                Stock Qty</td>
            <td class="xl40">
                Stock Amount</td>
            <td class="xl40">
                Check Qty</td>
            <td class="xl40">
                Check Amount</td>
            <td class="xl40">
                Adjust Qty</td>
            <td class="xl40">
                Adjust Amount</td>
            <td class="xl40">
                Description</td>
        </tr>
                <%
            dt1 = ESysLib.TableReadOpenCursor("INV.SP_RPT_BISA00030_2", para);
            for (int y = 0; y < dt1.Rows.Count; y++)
            {
        %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl24" style='height: 12.75pt' x:num>
                <%= dt1.Rows[y]["seq"] %></td>
            <td class="xl25">
                <%= dt1.Rows[y]["item_code"] %></td>
            <td class="xl26" width="277" style='width: 208pt'>
                <%= dt1.Rows[y]["item_name"] %></td>
            <td class="xl27">
                <%= dt1.Rows[y]["uom"] %></td>
            <td class="xl28" align="right" x:num>
                <%= dt1.Rows[y]["lot_no"] %></td>
            <td class="xl29" align="right" x:num>
                <%= dt1.Rows[y]["stock_qty"] %></td>
            <td class="xl28" align="right" x:num>
                <%= dt1.Rows[y]["stock_amount"] %></td>
            <td class="xl29" align="right" x:num>
                <%= dt1.Rows[y]["check_qty"] %></td>
            <td class="xl28" align="right" x:num>
                <%= dt1.Rows[y]["check_amount"] %></td>
            <td class="xl29" x:num>
                <%= dt1.Rows[y]["adjust_qty"] %></td>
            <td class="xl29" x:num>
                <%= dt1.Rows[y]["adjust_amount"]%></td>
            <td class="xl27">
                <%= dt1.Rows[y]["description"]%></td>
        </tr>
        <%} %>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="56" style='width: 42pt'>
            </td>
            <td width="94" style='width: 71pt'>
            </td>
            <td width="277" style='width: 208pt'>
            </td>
            <td width="75" style='width: 56pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="71" style='width: 53pt'>
            </td>
            <td width="96" style='width: 72pt'>
            </td>
            <td width="66" style='width: 50pt'>
            </td>
            <td width="95" style='width: 71pt'>
            </td>
            <td width="71" style='width: 53pt'>
            </td>
            <td width="100" style='width: 75pt'>
            </td>
            <td width="142" style='width: 107pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
