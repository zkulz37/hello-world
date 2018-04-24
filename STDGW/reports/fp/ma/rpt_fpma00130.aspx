<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("genuwin");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<%    
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("lg_rpt_fpma00130");
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_fpma00130_1", "'" + Request.QueryString["p_master_pk"] + "'");
    dt2 = ESysLib.TableReadOpenCursor("lg_rpt_fpma00130_2", "'" + Request.QueryString["p_master_pk"] + "'");
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_fpma00130_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_fpma00130_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_fpma00130_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Server_Test</o:LastAuthor>
  <o:LastPrinted>2011-06-28T09:43:17Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-06-28T09:43:35Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
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
            mso-footer-data:"&CPage &P of &N";
            margin: .1in .25in .1in .25in;
            mso-header-margin: 0in;
            mso-footer-margin: 0in;
        }
        .font8
        {
            color: windowtext;
            font-size: 9.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
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
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
        }
        .xl25
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl26
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl27
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl28
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl29
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl30
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl31
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
        }
        .xl32
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl33
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl34
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl35
        {
            mso-style-parent: style0;
            color: blue;
            border-bottom: 2.0pt double windowtext;
            font-size: 22.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl36
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        .xl37
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl38
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: right;
        }
        .xl39
        {
            mso-style-parent: style0;
            font-size: 9.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
<body link="blue" vlink="purple" class="xl24">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="802" style='border-collapse: collapse;
        table-layout: fixed; width: 604pt'>
        <col class="xl24" width="33" style='mso-width-source: userset; mso-width-alt: 1206;
            width: 25pt'>
        <col class="xl24" width="46" style='mso-width-source: userset; mso-width-alt: 1682;
            width: 35pt'>
        <col class="xl24" width="38" style='mso-width-source: userset; mso-width-alt: 1389;
            width: 29pt'>
        <col class="xl24" width="241" style='mso-width-source: userset; mso-width-alt: 8813;
            width: 181pt'>
        <col class="xl24" width="78" style='mso-width-source: userset; mso-width-alt: 2852;
            width: 59pt'>
        <col class="xl24" width="67" style='mso-width-source: userset; mso-width-alt: 2450;
            width: 50pt'>
        <col class="xl24" width="7" style='mso-width-source: userset; mso-width-alt: 256;
            width: 5pt'>
        <col class="xl24" width="22" style='mso-width-source: userset; mso-width-alt: 804;
            width: 17pt'>
        <col class="xl24" width="64" style='width: 48pt'>
        <col class="xl24" width="112" style='mso-width-source: userset; mso-width-alt: 4096;
            width: 84pt'>
        <col class="xl24" width="94" style='mso-width-source: userset; mso-width-alt: 3437;
            width: 71pt'>
        <tr height="52" style='mso-height-source: userset; height: 39.0pt'>
            <td colspan="10" height="52" class="xl35" width="708" style='height: 39.0pt; width: 533pt'>
                <v:shape id="_x0000_s2051" type="#_x0000_t75" style='position: absolute; margin-left: 0.5pt;
                    margin-top: 0.5pt; width: 78.75pt; height: 35.25pt; z-index: 1'>
                    <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto"
                        o:title="image001" />
                    <x:clientdata objecttype="Pict">
                        <x:sizewithcells />
                        <x:cf>Bitmap</x:cf>
                    </x:clientdata>
                </v:shape>
                Asset Liquidation Entry
            </td>
            <td class="xl24" width="94" style='width: 71pt'>
            </td>
        </tr>
        <tr height="21" style='mso-height-source: userset; height: 15.75pt'>
            <td height="21" class="xl39" colspan="2" style='height: 15.75pt; mso-ignore: colspan'>
                Slip No
            </td>
            <td class="xl24" colspan="2" style='mso-ignore: colspan'>
                <%= dt1.Rows[0]["slip_no"] %>
            </td>
            <td class="xl39">
                Date
            </td>
            <td class="xl24" colspan="2" style='mso-ignore: colspan'>
                <%= DateTime.ParseExact(dt1.Rows[0]["liquid_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%>
            </td>
            <td class="xl24">
            </td>
            <td class="xl39" colspan="3" style='mso-ignore: colspan'>
                Print Date:<font class="font8">
                    <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></font>
            </td>
        </tr>
        <tr height="21" style='mso-height-source: userset; height: 15.75pt'>
            <td height="21" class="xl39" colspan="2" style='height: 15.75pt; mso-ignore: colspan'>
                Charger
            </td>
            <td class="xl24" colspan="2" style='mso-ignore: colspan'>
                <%= dt1.Rows[0]["charger_name"]%>
            </td>
            <td class="xl39">
                Liquid Type
            </td>
            <td class="xl24">
                <%= dt1.Rows[0]["liquid_type"]%>
            </td>
            <td colspan="5" class="xl24" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="21" style='mso-height-source: userset; height: 15.75pt'>
            <td height="21" class="xl39" colspan="2" style='height: 15.75pt; mso-ignore: colspan'>
                Description
            </td>
            <td class="xl24" colspan="2" style='mso-ignore: colspan'>
                <%= dt1.Rows[0]["description"]%>
            </td>
            <td colspan="7" class="xl24" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl24" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td height="20" class="xl25" style='height: 15.0pt'>
                Seq
            </td>
            <td colspan="2" class="xl26" style='border-right: .5pt solid black; border-left: none'>
                Asset Code
            </td>
            <td class="xl25" style='border-left: none'>
                Asset Name
            </td>
            <td class="xl25" style='border-left: none'>
                UOM
            </td>
            <td class="xl25" style='border-left: none' x:str="Amount ">
                Amount<span style='mso-spacerun: yes'> </span>
            </td>
            <td colspan="4" class="xl26" style='border-right: .5pt solid black; border-left: none'>
                Remark
            </td>
            <td class="xl24">
            </td>
        </tr>
        <%
            for (int i = 0; i < dt2.Rows.Count; i++)
            {
        %>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td height="20" class="xl29" style='height: 15.0pt; border-top: none' x:num>
                <%= dt2.Rows[i]["seq"]%>
            </td>
            <td colspan="2" class="xl36" width="84" style='border-right: .5pt solid black; border-left: none;
                width: 64pt'>
                <%= dt2.Rows[i]["asset_code"]%>
            </td>
            <td class="xl34" width="241" style='border-top: none; border-left: none; width: 181pt'>
                <%= dt2.Rows[i]["asset_name"]%>
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                <%= dt2.Rows[i]["uom"]%>
            </td>
            <td class="xl30" style='border-top: none; border-left: none' x:num>
                <span style='mso-spacerun: yes'></span>
                <%= dt2.Rows[i]["amount"]%>
            </td>
            <td colspan="4" class="xl31" style='border-right: .5pt solid black; border-left: none'>
                <%= dt2.Rows[i]["description"]%>
            </td>
            <td class="xl24">
            </td>
        </tr>
        <%} %>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="33" style='width: 25pt'>
            </td>
            <td width="46" style='width: 35pt'>
            </td>
            <td width="38" style='width: 29pt'>
            </td>
            <td width="241" style='width: 181pt'>
            </td>
            <td width="78" style='width: 59pt'>
            </td>
            <td width="67" style='width: 50pt'>
            </td>
            <td width="7" style='width: 5pt'>
            </td>
            <td width="22" style='width: 17pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="112" style='width: 84pt'>
            </td>
            <td width="94" style='width: 71pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
