<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
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
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_bisc00011_1_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_bisc00011_1_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_bisc00011_1_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr. Khanh</o:LastAuthor>
  <o:LastPrinted>2010-09-28T08:08:29Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-09-28T08:08:46Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
    <style>
        <!
        --table
        {
            mso-displayed-decimal-separator: "\.";
            mso-displayed-thousand-separator: "\,";
        }
        @page
        {
            margin: 1.0in .75in 1.0in .75in;
            mso-header-margin: .5in;
            mso-footer-margin: .5in;
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
            color: red;
            font-size: 16.0pt;
            text-align: center;
        }
        .xl25
        {
            mso-style-parent: style0;
            color: red;
            font-size: 16.0pt;
        }
        .xl26
        {
            mso-style-parent: style0;
            text-align: center;
        }
        .xl27
        {
            mso-style-parent: style0;
            text-align: center;
            border: .5pt solid windowtext;
            background: #FFCC99;
           mso-pattern: auto none;
        }
        .xl28
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl29
        {
            mso-style-parent: style0;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl30
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl31
        {
            mso-style-parent: style0;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl32
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0\.000";
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl33
        {
            mso-style-parent: style0;
            mso-number-format: "\#\,\#\#0\.0";
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl34
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0\.000";
            border: .5pt solid windowtext;
            background: #FFCC99;
            mso-pattern: auto none;
        }
        .xl35
        {
            mso-style-parent: style0;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #FFCC99;
            mso-pattern: auto none;
        }
        .xl36
        {
            mso-style-parent: style0;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #FFCC99;
            mso-pattern: auto none;
        }
        .xl37
        {
            mso-style-parent: style0;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #FFCC99;
            mso-pattern: auto none;
        }
        .xl38
        {
            mso-style-parent: style0;
            text-align: center;
            border-top: none;
            border-right: none;
            border-bottom: none;
            border-left: none;
        }
        .xl39
        {
            mso-style-parent: style0;
            text-align: center;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: none;
            border-left: none;
        }
        .xl40
        {
            mso-style-parent: style0;
            text-align: left;
            border-left: none;
            border-top: none;
            border-right: none;
            border-bottom: none;           
        }        
        -- ></style>
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
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1168" style='border-collapse: collapse;
        table-layout: fixed; width: 876pt'>
        <col width="72" style='mso-width-source: userset; mso-width-alt: 2633; width: 54pt'>
        <col width="109" style='mso-width-source: userset; mso-width-alt: 3986; width: 82pt'>
        <col width="57" style='mso-width-source: userset; mso-width-alt: 2084; width: 43pt'>
        <col width="53" style='mso-width-source: userset; mso-width-alt: 1938; width: 40pt'>
        <col width="64" style='width: 48pt'>
        <col width="89" style='mso-width-source: userset; mso-width-alt: 3254; width: 67pt'>
        <col width="64" style='width: 48pt'>
        <col width="95" style='mso-width-source: userset; mso-width-alt: 3474; width: 71pt'>
        <col width="64" style='width: 48pt'>
        <col width="95" style='mso-width-source: userset; mso-width-alt: 3474; width: 71pt'>
        <col width="55" style='mso-width-source: userset; mso-width-alt: 2011; width: 41pt'>
        <col width="95" style='mso-width-source: userset; mso-width-alt: 3474; width: 71pt'>
        <col width="64" span="4" style='width: 48pt'>
        <tr height="27" style='height: 20.25pt'>
            <td colspan="12" height="27" class="xl24" width="912" style='height: 20.25pt; width: 684pt'>
                Report W/H Closing Checking
            </td>
            <td class="xl25" width="64" style='width: 48pt'>
            </td>
            <td class="xl25" width="64" style='width: 48pt'>
            </td>
            <td class="xl25" width="64" style='width: 48pt'>
            </td>
            <td class="xl25" width="64" style='width: 48pt'>
            </td>
        </tr>
        <%
            string para = " '" + p_tin_wh + "','" + p_from_date + "','" + p_to_date + "'"; 
            DataTable dt,dt1;
            dt = ESysLib.TableReadOpenCursor("LG_RPT_BIMC00041", para);
            
            para = " '" + p_tin_wh + "','" + p_from_date + "','" + p_to_date + "','" + p_item + "' ";           
            dt1 = ESysLib.TableReadOpenCursor("LG_RPT_BIMC00041_1", para);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
             %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl40" style='height: 12.75pt'>
                W/H
            </td>
            <td colspan="8" class="xl40" style=' border-left: none'>
                <%= dt.Rows[i]["wh_name"] %>
            </td>
            <td >
                Date: 
            </td>
            <td colspan="2" class="xl38" >
               <%= dt.Rows[i]["t_month"] %>
            </td>
            <td colspan="4" style='mso-ignore: colspan'>
            </td>
        </tr>
        <% } %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="16" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl27" style='height: 12.75pt'>
                Item Code
            </td>
            <td class="xl27" style='border-left: none'>
                Item Name
            </td>
            <td class="xl27" style='border-left: none'>
                UOM
            </td>
            <td class="xl27" style='border-left: none'>
                U/Price
            </td>
            <td class="xl27" style='border-left: none'>
                Begin Qty
            </td>
            <td class="xl27" style='border-left: none'>
                Begin Amount
            </td>
            <td class="xl27" style='border-left: none'>
                In Qty
            </td>
            <td class="xl27" style='border-left: none'>
                In Amount
            </td>
            <td class="xl27" style='border-left: none'>
                Out Qty
            </td>
            <td class="xl27" style='border-left: none'>
                Out Amount
            </td>
            <td class="xl27" style='border-left: none'>
                End Qty
            </td>
            <td class="xl27" style='border-left: none'>
                End Amount
            </td>
            <td colspan="4" class="xl26" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%
            //======= begin_qty,amount =========
            decimal TotalBeginQty = 0;
            decimal TotalBeginAmount = 0;
            //======= in_qty,amount =========
            decimal TotalInQty = 0;
            decimal TotalInAmount = 0;
            //======= out_qty,amount =========
            decimal TotalOutQty = 0;
            decimal TotalOutAmount = 0;
            //======= end_qty,amount =========
            decimal TotalEndQty = 0;
            decimal TotalEndAmount = 0;
            for (int y = 0; y < dt1.Rows.Count; y++)
            {
                //======= begin_qty,amount =========
                TotalBeginQty += Convert.ToDecimal(dt1.Rows[y]["begin_qty"]);
                TotalBeginAmount += Convert.ToDecimal(dt1.Rows[y]["begin_amount"]);
                //======= in_qty,amount =========
                TotalInQty += Convert.ToDecimal(dt1.Rows[y]["in_qty"]);
                TotalInAmount += Convert.ToDecimal(dt1.Rows[y]["in_amount"]);
                //======= out_qty,amount =========
                TotalOutQty += Convert.ToDecimal(dt1.Rows[y]["out_qty"]);
                TotalOutAmount += Convert.ToDecimal(dt1.Rows[y]["out_amount"]);
                //======= end_qty,amount =========
                TotalEndQty += Convert.ToDecimal(dt1.Rows[y]["end_qty"]);
                TotalEndAmount += Convert.ToDecimal(dt1.Rows[y]["end_amount"]);                 
             %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl28" style='height: 12.75pt; border-top: none'>
                <%= dt1.Rows[y]["item_code"]%>
            </td>
            <td class="xl29" width="109" style='border-top: none; border-left: none; width: 82pt'>
                <%= dt1.Rows[y]["item_name"]%><span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl30" style='border-top: none; border-left: none'>
                <%= dt1.Rows[y]["uom"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[y]["unit_price"]%>
            </td>
            <td class="xl32" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[y]["begin_qty"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[y]["begin_amount"]%>
            </td>
            <td class="xl32" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[y]["in_qty"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[y]["in_amount"]%>
            </td>
            <td class="xl32" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[y]["out_qty"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[y]["out_amount"]%>
            </td>
            <td class="xl32" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[y]["end_qty"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[y]["end_amount"]%>
            </td>
            <td colspan="4" style='mso-ignore: colspan'>
            </td>
        </tr>
        <% } %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl35" style='height: 12.75pt; border-top: none'>
                &nbsp;
            </td>
            <td class="xl36" style='border-top: none'>
                &nbsp;
            </td>
            <td class="xl36" style='border-top: none'>
                &nbsp;
            </td>
            <td class="xl37" style='border-top: none'>
                &nbsp;
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%=TotalBeginQty %>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%=TotalBeginAmount %>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%=TotalInQty %>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%=TotalInAmount %>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%=TotalOutQty %>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%=TotalOutAmount %>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%=TotalEndQty %>
            </td>
            <td class="xl34" align="right" style='border-top: none; border-left: none' x:num>
                <%=TotalEndAmount%>
            </td>
            <td colspan="4" style='mso-ignore: colspan'>
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="72" style='width: 54pt'>
            </td>
            <td width="109" style='width: 82pt'>
            </td>
            <td width="57" style='width: 43pt'>
            </td>
            <td width="53" style='width: 40pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="89" style='width: 67pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="95" style='width: 71pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="95" style='width: 71pt'>
            </td>
            <td width="55" style='width: 41pt'>
            </td>
            <td width="95" style='width: 71pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
