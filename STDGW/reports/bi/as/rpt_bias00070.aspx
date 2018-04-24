<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string para = "'" + p_from_date + "','" + p_to_date + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("inv.sp_rpt_bias00070", para); 
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_bias00070_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_bias00070_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_bias00070_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-05-09T04:13:52Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-05-09T04:14:07Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
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
            margin: .25in .25in .25in .25in;
            mso-header-margin: .25in;
            mso-footer-margin: .25in;
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
            text-align: center;
        }
        .xl26
        {
            mso-style-parent: style0;
            color: red;
            font-size: 16.0pt;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl27
        {
            mso-style-parent: style0;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl28
        {
            mso-style-parent: style0;
            font-size: 9.0pt;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl29
        {
            mso-style-parent: style0;
            font-size: 9.0pt;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl30
        {
            mso-style-parent: style0;
            color: blue;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl31
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl32
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl33
        {
            mso-style-parent: style0;
            font-size: 9.0pt;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0\.000";
            vertical-align: middle;
            border: .5pt solid windowtext;
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
       <x:ActiveRow>12</x:ActiveRow>
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
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1143" style='border-collapse: collapse;
        table-layout: fixed; width: 858pt'>
        <col width="74" style='mso-width-source: userset; mso-width-alt: 2706; width: 56pt'>
        <col width="64" span="2" style='width: 48pt'>
        <col width="123" style='mso-width-source: userset; mso-width-alt: 4498; width: 92pt'>
        <col width="86" style='mso-width-source: userset; mso-width-alt: 3145; width: 65pt'>
        <col width="141" style='mso-width-source: userset; mso-width-alt: 5156; width: 106pt'>
        <col width="64" style='width: 48pt'>
        <col width="51" style='mso-width-source: userset; mso-width-alt: 1865; width: 38pt'>
        <col width="92" style='mso-width-source: userset; mso-width-alt: 3364; width: 69pt'>
        <col width="141" style='mso-width-source: userset; mso-width-alt: 5156; width: 106pt'>
        <col width="64" style='width: 48pt'>
        <col width="51" style='mso-width-source: userset; mso-width-alt: 1865; width: 38pt'>
        <col width="64" span="2" style='width: 48pt'>
        <tr class="xl24" height="33" style='mso-height-source: userset; height: 24.75pt'>
            <td colspan="13" height="33" class="xl26" width="1079" style='height: 24.75pt; width: 810pt'>
                STOCK EXCHANGE APPROVE
            </td>
            <td class="xl24" width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="14" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="21" style='mso-height-source: userset; height: 15.75pt'>
            <td height="21" class="xl30" style='height: 15.75pt' x:str="Ex Date ">
                Ex Date<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl30" style='border-left: none' x:str="Slip No ">
                Slip No<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl30" style='border-left: none'>
                Ref No
            </td>
            <td class="xl30" style='border-left: none'>
                <span style='mso-spacerun: yes'></span>W/H Name
            </td>
            <td class="xl30" style='border-left: none'>
                Ex Item Code
            </td>
            <td class="xl30" style='border-left: none'>
                Ex Item Name
            </td>
            <td class="xl30" style='border-left: none'>
                Ex Qty
            </td>
            <td class="xl30" style='border-left: none'>
                Ex Uom
            </td>
            <td class="xl30" style='border-left: none'>
                Out Item Code
            </td>
            <td class="xl30" style='border-left: none'>
                Out Item Name
            </td>
            <td class="xl30" style='border-left: none'>
                Out Qty
            </td>
            <td class="xl30" style='border-left: none'>
                Out Uom
            </td>
            <td colspan="2" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <% 
            //------ merge ------
            string pro = string.Empty;
            int[] arrDate_count = new int[dt.Rows.Count];
            int a = 0;
            int strDate_count = 1;

            for (int y = 0; y < dt.Rows.Count; y++)
            {
                if (pro == "" || pro == null)
                {
                    pro = dt.Rows[y]["ex_date"].ToString();
                    strDate_count = 1;
                }
                else
                {
                    if (dt.Rows[y]["ex_date"].ToString().Trim() != pro.Trim())
                    {
                        arrDate_count[a] = strDate_count;
                        strDate_count = 1;
                        a++;
                        pro = dt.Rows[y]["ex_date"].ToString();
                    }
                    else
                    {
                        strDate_count++;
                    }
                }
            }
            arrDate_count[a] = strDate_count;
            a = 0;
            pro = string.Empty;

            //----- end merge -----
            for (int i = 0; i < dt.Rows.Count; i++)
            {
        %>
        <tr height="46" style='mso-height-source: userset; height: 34.5pt'>
            <% 
                if (!pro.Equals(dt.Rows[i]["ex_date"].ToString()))
                {
            %>
            <td rowspan="<%= arrDate_count[a]  %>" height="46" class="xl28" style='height: 34.5pt;
                border-top: none'>
                <%= dt.Rows[i]["ex_date"]%>
            </td>
            <% 
                pro = dt.Rows[i]["ex_date"].ToString();
                a++;
                } %>
            <td class="xl29" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["slip_no"]%>
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["ref_no"]%>
            </td>
            <td class="xl31" width="123" style='border-top: none; border-left: none; width: 92pt'>
                <%= dt.Rows[i]["wh_name"]%>
            </td>
            <td class="xl32" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["ex_item_code"]%>
            </td>
            <td class="xl27" width="141" style='border-top: none; border-left: none; width: 106pt'>
                <%= dt.Rows[i]["ex_item_name"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["ex_qty"]%>
            </td>
            <td class="xl28" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["ex_uom"]%>
            </td>
            <td class="xl32" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["out_item_code"]%>
            </td>
            <td class="xl27" width="141" style='border-top: none; border-left: none; width: 106pt'>
                <%= dt.Rows[i]["out_item_name"]%>
            </td>
            <td class="xl33" align="right" style='border-top: none; border-left: none' x:num>
                <%= dt.Rows[i]["out_qty"]%>
            </td>
            <td class="xl28" style='border-top: none; border-left: none'>
                <%= dt.Rows[i]["out_uom"]%>
            </td>
            <td colspan="2" style='mso-ignore: colspan'>
            </td>
        </tr>
        <% } %>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="74" style='width: 56pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="123" style='width: 92pt'>
            </td>
            <td width="86" style='width: 65pt'>
            </td>
            <td width="141" style='width: 106pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
            <td width="92" style='width: 69pt'>
            </td>
            <td width="141" style='width: 106pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="51" style='width: 38pt'>
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
