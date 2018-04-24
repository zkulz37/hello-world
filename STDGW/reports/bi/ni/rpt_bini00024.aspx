<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_tin_wh = Request.QueryString["p_tin_warehouse_pk"];
    string p_wh_type = Request.QueryString["p_whtype"];
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string p_item = Request.QueryString["p_item"];
    string p_ref_no_vendor = Request.QueryString["p_ref_no_vendor"];
    string p_ccy = Request.QueryString["p_ccy"];
    string p_in_type = Request.QueryString["p_in_type"];
    string p_check = Request.QueryString["p_check"];
    string para = " '" + p_wh_type + " ','" + p_tin_wh + "','" + p_in_type + "','" + p_from_date + "','" + p_to_date + "','" + p_ref_no_vendor + "','" + p_item + "','" + p_ccy + "','" + p_check + "'";
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("lg_rpt_bini00024", para); 
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="aaa_files/filelist.xml">
    <link rel="Edit-Time-Data" href="aaa_files/editdata.mso">
    <link rel="OLE-Object-Data" href="aaa_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-04-27T04:19:05Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-04-27T04:19:08Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
    <style>
        <!--table
        {
            mso-displayed-decimal-separator: "\.";
            mso-displayed-thousand-separator: "\,";
        }
        @page
        {
            margin: .25in .5in .75in .5in;
            mso-header-margin: .5in;
            mso-footer-margin: 0in;
            mso-page-orientation: landscape;
        }
        tr
        {
            mso-height-source: auto;
        }
        col
        {
            mso-width-source: auto;
        }
        br
        {
            mso-data-placement: same-cell;
        }
        .style0
        {
            mso-number-format: General;
            text-align: general;
            vertical-align: bottom;
            white-space: nowrap;
            mso-rotate: 0;
            mso-background-source: auto;
            mso-pattern: auto;
            color: windowtext;
            font-size: 10.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Arial;
            mso-generic-font-family: auto;
            mso-font-charset: 0;
            border: none;
            mso-protection: locked visible;
            mso-style-name: Normal;
            mso-style-id: 0;
        }
        td
        {
            mso-style-parent: style0;
            padding-top: 1px;
            padding-right: 1px;
            padding-left: 1px;
            mso-ignore: padding;
            color: windowtext;
            font-size: 10.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Arial;
            mso-generic-font-family: auto;
            mso-font-charset: 0;
            mso-number-format: General;
            text-align: general;
            vertical-align: bottom;
            border: none;
            mso-background-source: auto;
            mso-pattern: auto;
            mso-protection: locked visible;
            white-space: nowrap;
            mso-rotate: 0;
        }
        .xl24
        {
            mso-style-parent: style0;
            vertical-align: middle;
        }
        .xl25
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid #3366FF;
            border-bottom: .5pt solid #3366FF;
            border-left: .5pt solid #3366FF;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl26
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid #3366FF;
            border-bottom: .5pt solid #3366FF;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl27
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
        }
        .xl28
        {
            mso-style-parent: style0;
            border-top: none;
            border-right: .5pt solid #3366FF;
            border-bottom: .5pt solid #3366FF;
            border-left: .5pt solid #3366FF;
            background: #FFCC99;
            mso-pattern: auto none;
        }
        .xl29
        {
            mso-style-parent: style0;
            border-top: none;
            border-right: .5pt solid #3366FF;
            border-bottom: .5pt solid #3366FF;
            border-left: none;
            background: #FFCC99;
            mso-pattern: auto none;
        }
        .xl30
        {
            mso-style-parent: style0;
            font-weight: 700;
            text-decoration: underline;
            text-underline-style: single;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0\.000";
            border-top: none;
            border-right: .5pt solid #3366FF;
            border-bottom: .5pt solid #3366FF;
            border-left: none;
            background: #FFCC99;
            mso-pattern: auto none;
        }
        .xl31
        {
            mso-style-parent: style0;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid #3366FF;
            border-bottom: .5pt solid #3366FF;
            border-left: .5pt solid #3366FF;
        }
        .xl32
        {
            mso-style-parent: style0;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid #3366FF;
            border-bottom: .5pt solid #3366FF;
            border-left: none;
        }
        .xl33
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0\.000";
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid #3366FF;
            border-bottom: .5pt solid #3366FF;
            border-left: none;
        }
        .xl34
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid #3366FF;
            border-bottom: .5pt solid #3366FF;
            border-left: none;
        }
        .xl35
        {
            mso-style-parent: style0;
            color: red;
            font-size: 18.0pt;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid #3366FF;
            border-left: none;
            mso-background-source: auto;
            mso-pattern: auto none;
        }
        --></style>
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
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>2</x:SplitHorizontal>
     <x:TopRowBottomPane>2</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
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
    <!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]-->
</head>
<body link="blue" vlink="purple">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1038" style='border-collapse: collapse;
        table-layout: fixed; width: 779pt'>
        <col width="225" style='mso-width-source: userset; mso-width-alt: 8228; width: 169pt'>
        <col width="115" style='mso-width-source: userset; mso-width-alt: 4205; width: 86pt'>
        <col width="232" style='mso-width-source: userset; mso-width-alt: 8484; width: 174pt'>
        <col width="76" style='mso-width-source: userset; mso-width-alt: 2779; width: 57pt'>
        <col width="68" style='mso-width-source: userset; mso-width-alt: 2486; width: 51pt'>
        <col width="129" span="2" style='mso-width-source: userset; mso-width-alt: 4717;
            width: 97pt'>
        <col width="64" style='width: 48pt'>
        <tr height="37" style='mso-height-source: userset; height: 27.75pt'>
            <td colspan="7" height="37" class="xl35" width="974" style='height: 27.75pt; width: 731pt'>
                Report Stock Incoming Checking
            </td>
            <td width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr class="xl24" height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl25" style='height: 18.0pt'>
                Supplier
            </td>
            <td class="xl26">
                Item Code
            </td>
            <td class="xl26">
                Item Name
            </td>
            <td class="xl26">
                Qty
            </td>
            <td class="xl26">
                UOM
            </td>
            <td class="xl26">
                Amount
            </td>
            <td class="xl26">
                Total Amount
            </td>
            <td class="xl27">
            </td>
        </tr>
        <% 
            for (int i = 0; i < dt.Rows.Count; i++)
            {
        %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl31" style='height: 12.75pt'>
                <%= dt.Rows[i]["partner_name"]%>
            </td>
            <td class="xl32">
                <%= dt.Rows[i]["item_code"]%>
            </td>
            <td class="xl32">
                <%= dt.Rows[i]["item_name"]%>
            </td>
            <td class="xl33" align="right" x:num>
                <%= dt.Rows[i]["in_qty"]%>
            </td>
            <td class="xl34">
                <%= dt.Rows[i]["in_uom"]%>
            </td>
            <td class="xl33" align="right" x:num>
                <%= dt.Rows[i]["item_amount"]%>
            </td>
            <td class="xl33" align="right" x:num>
                <%= dt.Rows[i]["total_amount"]%>
            </td>
            <td>
            </td>
        </tr>
        <%} %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl28" style='height: 12.75pt'>
                &nbsp;
            </td>
            <td class="xl29">
                &nbsp;
            </td>
            <td class="xl29">
                &nbsp;
            </td>
            <td class="xl30" align="right" x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>D3:D<%=dt.Rows.Count+2%><%}else{%>D4:D4<%}%>)">
			</td>
            <td class="xl29">
                &nbsp;
            </td>
            <td class="xl30" align="right" x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>F3:F<%=dt.Rows.Count+2%><%}else{%>F4:F4<%}%>)">
            </td>
            <td class="xl30" align="right" x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>G3:G<%=dt.Rows.Count+2%><%}else{%>G4:G4<%}%>)">
            </td>
            <td>
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="225" style='width: 169pt'>
            </td>
            <td width="115" style='width: 86pt'>
            </td>
            <td width="232" style='width: 174pt'>
            </td>
            <td width="76" style='width: 57pt'>
            </td>
            <td width="68" style='width: 51pt'>
            </td>
            <td width="129" style='width: 97pt'>
            </td>
            <td width="129" style='width: 97pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
