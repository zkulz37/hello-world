<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_from_date = Request.QueryString["from_date"];
    string p_to_date = Request.QueryString["to_date"];
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_fppr00040_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_fppr00040_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_fppr00040_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>Mr. Khanh</o:LastAuthor>
  <o:LastPrinted>2010-11-10T10:27:13Z</o:LastPrinted>
  <o:Created>2010-11-10T10:05:02Z</o:Created>
  <o:LastSaved>2010-11-11T01:04:05Z</o:LastSaved>
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
            margin: .52in .31in .51in .33in;
            mso-header-margin: .5in;
            mso-footer-margin: .5in;
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
            font-size: 14.0pt;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
        }
        .xl25
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl26
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl27
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: right;
            vertical-align: middle;
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
            border: .5pt solid windowtext;
            background: #99CCFF;
            mso-pattern: auto none;
        }
        .xl29
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl30
        {
            mso-style-parent: style0;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl31
        {
            mso-style-parent: style0;
            text-align: center;
            border: .5pt solid windowtext;
            background: #99CCFF;
            mso-pattern: auto none;
        }
        .xl32
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
        }
        .xl33
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl34
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl35
        {
            mso-style-parent: style0;
            font-size: 14.0pt;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: none;
            border-left: none;
        }
        .xl36
        {
            mso-style-parent: style0;
            font-size: 14.0pt;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: none;
            border-left: .5pt solid windowtext;
        }
        .xl37
        {
            mso-style-parent: style0;
            font-size: 14.0pt;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: none;
            border-left: .5pt solid windowtext;
        }
        .xl38
        {
            mso-style-parent: style0;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: right;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl39
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #FFCC99;
            mso-pattern: auto none;
        }
        .xl40
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #FFCC99;
            mso-pattern: auto none;
        }
        .xl41
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #FFCC99;
            mso-pattern: auto none;
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>46</x:ActiveRow>
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
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
<body link="blue" vlink="purple">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="887" style='border-collapse: collapse;
        table-layout: fixed; width: 667pt'>
        <col width="190" style='mso-width-source: userset; mso-width-alt: 6948; width: 143pt'>
        <col width="85" span="5" style='mso-width-source: userset; mso-width-alt: 3108; width: 64pt'>
        <col width="80" style='mso-width-source: userset; mso-width-alt: 2925; width: 60pt'>
        <col width="64" span="3" style='width: 48pt'>
        <tr height="40" style='mso-height-source: userset; height: 30.0pt'>
            <td colspan="7" height="40" class="xl35" width="695" style='height: 30.0pt; width: 523pt'>
                COMPONENT OUTGOING REPORT
            </td>
            <td class="xl24" width="64" style='width: 48pt'>
            </td>
            <td class="xl24" width="64" style='width: 48pt'>
            </td>
            <td class="xl24" width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td colspan="7" height="25" class="xl38" style='height: 18.75pt'>
                <%= System.DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("yyyy/MM/dd") %>
                ~
                <%= System.DateTime.ParseExact(p_to_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("yyyy/MM/dd")%>               
                </td>
        </tr>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td height="20" class="xl29" style='height: 15.0pt; border-top: none'>
                Component
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                Spec 01
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                Spec 02
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                Spec 03
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                Spec 04
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                Spec 05
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                Out Qty
            </td>
            <td colspan="3" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%
            string para = "'" + p_from_date + "','" + p_to_date + "'";
            DataTable dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00040", para);
            decimal Total = 0, GrandTotal = 0;

            //---------------------------------------------------------------------------
            string order_plan_pk = string.Empty;


            for (int i = 0; i < dt.Rows.Count; i++)
            {
          
       if (order_plan_pk != dt.Rows[i]["pp_ordplan_pk"].ToString())
       {
        %>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td colspan="7" height="20" class="xl32" style='border-right: .5pt solid black; height: 15.0pt'>
                <%= dt.Rows[i]["po_style"]%>
            </td>
        </tr>
        <%
            Total = 0;
        }
        //---------------------------------------------------------------------------
        para = "'" + p_from_date + "','" + p_to_date + "','" + dt.Rows[i]["pp_ordplan_pk"] + "'";
        DataTable dt1 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00040_1", para);
        //---------------------------------------------------------------------------
        for (int j = 0; j < dt1.Rows.Count; j++)
        {
        %>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl30" style='height: 18.75pt; border-top: none'>
                <%= dt1.Rows[j]["component"]%>
            </td>
            <td class="xl25" style='border-top: none; border-left: none'>
                <%= dt1.Rows[j]["spec01"]%>
            </td>
            <td class="xl25" style='border-top: none; border-left: none'>
                <%= dt1.Rows[j]["spec02"]%>
            </td>
            <td class="xl25" style='border-top: none; border-left: none'>
                <%= dt1.Rows[j]["spec03"]%>
            </td>
            <td class="xl25" style='border-top: none; border-left: none'>
                <%= dt1.Rows[j]["spec04"]%>
            </td>
            <td class="xl25" style='border-top: none; border-left: none'>
                <%= dt1.Rows[j]["spec05"]%>
            </td>
            <td class="xl26" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[j]["out_qty"]%>
            </td>            
        </tr>
        <%  Total += Convert.ToDecimal(dt1.Rows[j]["out_qty"]);
            GrandTotal += Convert.ToDecimal(dt1.Rows[j]["out_qty"]);
        }
        %>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td colspan="6" height="20" class="xl39" style='border-right: .5pt solid black; height: 15.0pt'>
                Total
            </td>
            <td class="xl27" style='border-top: none; border-left: none' x:num>
                <%= Total %>
            </td>           
        </tr>
        <%      
                
            }%>
        <tr height="17" style='height: 12.75pt'>
            <td colspan="6" height="17" class="xl31" style='height: 12.75pt'>
                Grand Total
            </td>
            <td class="xl28" align="right" style='border-top: none; border-left: none' x:num>
                <%= GrandTotal %>
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="190" style='width: 143pt'>
            </td>
            <td width="85" style='width: 64pt'>
            </td>
            <td width="85" style='width: 64pt'>
            </td>
            <td width="85" style='width: 64pt'>
            </td>
            <td width="85" style='width: 64pt'>
            </td>
            <td width="85" style='width: 64pt'>
            </td>
            <td width="80" style='width: 60pt'>
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
