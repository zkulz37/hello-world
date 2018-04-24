﻿<%@ page language="C#" %>

<%@ import namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string strSQL = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk 
                      FROM comm.tco_company 
                      WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM comm.tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
												  
    string p_partner_pk = Request.QueryString["p_partner_pk"];
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
	string p_po = Request.QueryString["p_po"];
    string p_item = Request.QueryString["p_item"];

    
    string para = "'" + p_partner_pk + "','" + p_from_date + "','" + p_to_date + "','" + p_po + "','" + p_item + "'";
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpen(strSQL);
    dt1 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsbs00230", "'" + p_partner_pk + "'");
    dt2 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsbs00230_1", para);
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="Copy%20of%20debit_note_110707_A4_files/filelist.xml">
    <link rel="Edit-Time-Data" href="Copy%20of%20debit_note_110707_A4_files/editdata.mso">
    <link rel="OLE-Object-Data" href="Copy%20of%20debit_note_110707_A4_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>MrTien</o:Author>
  <o:LastAuthor>SERVER_LG</o:LastAuthor>
  <o:LastPrinted>2011-07-09T09:50:08Z</o:LastPrinted>
  <o:Created>2007-01-10T03:24:47Z</o:Created>
  <o:LastSaved>2011-07-09T09:50:20Z</o:LastSaved>
  <o:Company>GENUWIN DC</o:Company>
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
            mso-footer-data: "Page &P of &N";
            margin: .1in .25in .2in .25in;
            mso-header-margin: 0in;
            mso-footer-margin: .01in;
            mso-page-orientation: landscape;
        }
        .font5
        {
            color: windowtext;
            font-size: 8.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
        }
        .font9
        {
            color: windowtext;
            font-size: 10.0pt;
            font-weight: 400;
            font-style: italic;
            text-decoration: none;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
        }
        .font12
        {
            color: windowtext;
            font-size: 8.0pt;
            font-weight: 400;
            font-style: italic;
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
            mso-number-format: "0_\)\;\\\(0\\\)";
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl25
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\@";
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl26
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "dd\/mm\/yyyy";
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl27
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\@";
            text-align: left;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl28
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\@";
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl29
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\@";
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl30
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\@";
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl31
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl32
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl33
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl34
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            white-space: nowrap;
            mso-text-control: shrinktofit;
        }
        .xl35
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            white-space: normal;
        }
        .xl36
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
        }
        .xl37
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl38
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
        }
        .xl39
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl40
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl41
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl42
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            white-space: nowrap;
            mso-text-control: shrinktofit;
        }
        .xl43
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl44
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl45
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl46
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl47
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl48
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl49
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl50
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl51
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "0_\)\;\\\(0\\\)";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl52
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "0_\)\;\\\(0\\\)";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl53
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "0_\)\;\\\(0\\\)";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl54
        {
            mso-style-parent: style0;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl55
        {
            mso-style-parent: style0;
            font-size: 14.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
        }
        .xl56
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
        }
        .xl57
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl58
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "0_\)\;\\\(0\\\)";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl59
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "0_\)\;\\\(0\\\)";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
        }
        .xl60
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "0_\)\;\\\(0\\\)";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
            mso-text-control: shrinktofit;
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
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>6</x:TopRowVisible>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$13:$13</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>
<body link="blue" vlink="purple" class="xl39">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1467" style='border-collapse: collapse;
        table-layout: fixed; width: 1101pt'>
        <col class="xl39" width="49" style='mso-width-source: userset; mso-width-alt: 1792;
            width: 37pt'>
        <col class="xl39" width="99" style='mso-width-source: userset; mso-width-alt: 3620;
            width: 74pt'>
        <col class="xl39" width="75" style='mso-width-source: userset; mso-width-alt: 2742;
            width: 56pt'>
        <col class="xl39" width="117" style='mso-width-source: userset; mso-width-alt: 4278;
            width: 88pt'>
        <col class="xl39" width="114" style='mso-width-source: userset; mso-width-alt: 4169;
            width: 86pt'>
        <col class="xl39" width="268" style='mso-width-source: userset; mso-width-alt: 9801;
            width: 201pt'>
        <col class="xl39" width="124" style='mso-width-source: userset; mso-width-alt: 4534;
            width: 93pt'>
        <col class="xl39" width="47" style='mso-width-source: userset; mso-width-alt: 1718;
            width: 35pt'>
        <col class="xl39" width="62" style='mso-width-source: userset; mso-width-alt: 2267;
            width: 47pt'>
        <col class="xl39" width="99" style='mso-width-source: userset; mso-width-alt: 3620;
            width: 74pt'>
        <col class="xl39" width="101" style='mso-width-source: userset; mso-width-alt: 3693;
            width: 76pt'>
        <col class="xl39" width="120" style='mso-width-source: userset; mso-width-alt: 4388;
            width: 90pt'>
        <col class="xl39" width="64" span="3" style='width: 48pt'>
        <tr class="xl32" height="14" style='height: 10.5pt'>
            <td height="14" class="xl32" width="49" style='height: 10.5pt; width: 37pt'>
                <!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:20.5pt;margin-top:5.5pt;width:78pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
            </td>
            <td class="xl33" width="99" style='width: 74pt'>
            </td>
            <td class="xl33" colspan="3" width="306" style='mso-ignore: colspan; width: 230pt'>
                <%= dt.Rows[0]["partner_name"] %>
            </td>
            <td class="xl34" width="268" style='width: 201pt'>
            </td>
            <td class="xl33" colspan="5" width="433" style='mso-ignore: colspan; width: 325pt'>
                Bank name: Bank for Foreign Trade of Vietnam, Binh Duong Branch
            </td>
            <td class="xl32" width="120" style='width: 90pt'>
            </td>
            <td class="xl32" width="64" style='width: 48pt'>
            </td>
            <td class="xl32" width="64" style='width: 48pt'>
            </td>
            <td class="xl32" width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr class="xl32" height="14" style='height: 10.5pt'>
            <td height="14" class="xl32" style='height: 10.5pt'>
            </td>
            <td class="xl33">
            </td>
            <td class="xl33" colspan="4" style='mso-ignore: colspan'>
                <%= dt.Rows[0]["addr1"] %>
            </td>
            <td class="xl33" colspan="2" style='mso-ignore: colspan'>
                SWIFT NO.: BFTVVNVX028.
            </td>
            <td colspan="3" class="xl33" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl32" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr class="xl32" height="14" style='height: 10.5pt'>
            <td height="14" class="xl32" style='height: 10.5pt'>
            </td>
            <td class="xl33">
            </td>
            <td class="xl33" colspan="3" style='mso-ignore: colspan'>
                Tel:
                <%= dt.Rows[0]["phone_no"] %>
                Fax:
                <%= dt.Rows[0]["fax_no"] %>
            </td>
            <td class="xl34">
            </td>
            <td class="xl33" colspan="6" style='mso-ignore: colspan'>
                Bank add: 72 Binh Duong Avenue, Thu Dau Mot District, Binh Duong Province, VN.
            </td>
            <td colspan="3" class="xl32" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr class="xl32" height="14" style='height: 10.5pt'>
            <td height="14" colspan="2" class="xl32" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td class="xl33">
                Tax No:
                <%= dt.Rows[0]["tax_code"] %>
            </td>
            <td colspan="2" class="xl32" style='mso-ignore: colspan'>
            </td>
            <td class="xl35">
            </td>
            <td class="xl33" colspan="4" style='mso-ignore: colspan'>
                Operating Account (USD): 0281370043953 CIF: 662920.
            </td>
            <td class="xl33">
            </td>
            <td colspan="4" class="xl32" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr class="xl32" height="15" style='height: 11.25pt'>
            <td height="15" class="xl36" style='height: 11.25pt'>
                &nbsp;
            </td>
            <td class="xl36">
                &nbsp;
            </td>
            <td class="xl36">
                &nbsp;
            </td>
            <td class="xl36">
                &nbsp;
            </td>
            <td class="xl36">
                &nbsp;
            </td>
            <td class="xl37" width="268" style='width: 201pt'>
                &nbsp;
            </td>
            <td class="xl38" colspan="4" style='mso-ignore: colspan'>
                Operating Account (VND): 0281000043947 CIF: 662920.
            </td>
            <td class="xl38">
                &nbsp;
            </td>
            <td class="xl36">
                &nbsp;
            </td>
            <td colspan="3" class="xl32" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="18" style='height: 13.5pt'>
            <td height="18" colspan="5" class="xl39" style='height: 13.5pt; mso-ignore: colspan'>
            </td>
            <td class="xl35">
            </td>
            <td colspan="2" class="xl39" style='mso-ignore: colspan'>
            </td>
            <td class="xl33">
            </td>
            <td colspan="6" class="xl39" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td colspan="12" rowspan="2" height="34" class="xl54" style='height: 25.5pt'>
                DEBIT NOTE <%= DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%> ~ <%= DateTime.ParseExact(p_to_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%>
            </td>
            <td colspan="3" class="xl39" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="3" class="xl39" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="30" style='mso-height-source: userset; height: 22.5pt'>
            <td height="30" class="xl39" style='height: 22.5pt'>
            </td>
            <td colspan="2" class="xl57" width="174" style='width: 130pt'>
                Khách hàng <font class="font12">Customer</font><font class="font5">:<span style='mso-spacerun: yes'>
                </span></font>
            </td>
            <td colspan="9" class="xl55">
                <%= dt1.Rows[0]["partner_name"] %>
            </td>
            <td colspan="3" class="xl39" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl39" style='height: 18.75pt'>
            </td>
            <td colspan="2" class="xl57" width="174" style='width: 130pt'>
                &#272;i&#7879;n tho&#7841;i <font class="font12">TEL</font><font class="font5"> :</font>
            </td>
            <td class="xl39">
                <%= dt1.Rows[0]["phone_no"] %>
            </td>
            <td class="xl42">
                Fax :
            </td>
            <td class="xl33">
                <%= dt1.Rows[0]["fax_no"] %>
            </td>
            <td class="xl39">
            </td>
            <td colspan="2" class="xl33" style='mso-ignore: colspan'>
            </td>
            <td colspan="6" class="xl39" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl39" style='height: 18.75pt'>
            </td>
            <td colspan="2" class="xl57" width="174" style='width: 130pt'>
                &#272;&#7883;a ch&#7881; <font class="font12">Address</font><font class="font5"> :<span
                    style='mso-spacerun: yes'> </span></font>
            </td>
            <td colspan="9" class="xl56">
                <%= dt1.Rows[0]["addr1"] %>
            </td>
            <td colspan="3" class="xl39" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td height="20" colspan="15" class="xl39" style='height: 15.0pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr class="xl40" height="40" style='mso-height-source: userset; height: 30.0pt'>
            <td height="40" class="xl31" width="49" style='height: 30.0pt; width: 37pt'>
                TT<br>
                <font class="font12">No</font>
            </td>
            <td class="xl31" width="99" style='border-left: none; width: 74pt'>
                S&#7889; Phi&#7871;u Xu&#7845;t<br>
                <font class="font12">T/O Req No</font>
            </td>
            <td class="xl31" width="75" style='border-left: none; width: 56pt'>
                Ngày xu&#7845;t<br>
                <font class="font12">T/O Date</font>
            </td>
            <td class="xl31" width="117" style='border-left: none; width: 88pt'>
                S&#7889; PO<br>
                <font class="font12">PO. Number</font>
            </td>
            <td class="xl31" width="114" style='border-left: none; width: 86pt'>
                Mã hàng<br>
                <font class="font12">Item Code</font>
            </td>
            <td class="xl31" width="268" style='border-left: none; width: 201pt'>
                Tên hàng<br>
                <font class="font12">Item Description</font>
            </td>
            <td class="xl31" width="124" style='border-left: none; width: 93pt'>
                Màu<br>
                <font class="font12">Color</font>
            </td>
            <td class="xl31" width="47" style='border-left: none; width: 35pt'>
                &#272;VT<br>
                <font class="font12">Unit</font>
            </td>
            <td class="xl31" width="62" style='border-left: none; width: 47pt'>
                S&#7889; l&#432;&#7907;ng<br>
                <font class="font12">Quantity</font>
            </td>
            <td class="xl31" width="99" style='border-left: none; width: 74pt'>
                &#272;&#417;n giá<br>
                <font class="font12">Unit Price</font>
            </td>
            <td class="xl31" width="101" style='border-left: none; width: 76pt'>
                Thành ti&#7873;n<br>
                <font class="font12">Amount</font>
            </td>
            <td class="xl31" width="120" style='border-left: none; width: 90pt'>
                Ghi chú<br>
                <font class="font12">Remark</font>
            </td>
            <td colspan="3" class="xl40" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%
            decimal total = 0;
            decimal subqty = 0;
           
            for (int i = 0; i < dt2.Rows.Count; i++)
            {
                
             %>
        <tr height="34" style='height: 25.5pt'>
            <td height="34" class="xl24" width="49" style='height: 25.5pt; border-top: none;
                width: 37pt'>
                <%= i + 1 %>
            </td>
            <td class="xl25" width="99" style='border-top: none; border-left: none; width: 74pt'>
                <%= dt2.Rows[i]["slip_no"] %>
            </td>
            <td class="xl26" width="75" style='border-top: none; border-left: none; width: 56pt'>
                <%= DateTime.ParseExact(dt2.Rows[i]["out_date"].ToString(),"yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy") %>
            </td>
            <td class="xl25" width="117" style='border-top: none; border-left: none; width: 88pt'>
                <%= dt2.Rows[i]["ref_no"] %>
            </td>
            <td class="xl27" width="114" style='border-top: none; border-left: none; width: 86pt'>
                <%= dt2.Rows[i]["item_code"]%>
            </td>
            <td class="xl25" width="268" style='border-top: none; border-left: none; width: 201pt'>
                <%= dt2.Rows[i]["item_name"]%>
            </td>
            <td class="xl25" width="124" style='border-top: none; border-left: none; width: 93pt'>
                <%= dt2.Rows[i]["color"]%>
            </td>
            <td class="xl28" width="47" style='border-top: none; border-left: none; width: 35pt'>
                <%= dt2.Rows[i]["uom"]%>
            </td>
            <td class="xl45" width="62" style='border-top: none; border-left: none; width: 47pt'
                x:num>
                <span style='mso-spacerun: yes'></span><%= dt2.Rows[i]["out_qty"]%>
            </td>
            <td class="xl47" width="99" style='border-top: none; border-left: none; width: 74pt'
                x:num>
                <span style='mso-spacerun: yes'></span><%= dt2.Rows[i]["unit_price"]%>
            </td>
            <td class="xl43" width="101" style='border-top: none; border-left: none; width: 76pt'
                x:nu="0.77">
                <span style='mso-spacerun: yes'></span><%= dt2.Rows[i]["sel_amt"]%>
            </td>
            <td class="xl25" width="120" style='border-top: none; border-left: none; width: 90pt'>
                <%= dt2.Rows[i]["description"]%>
            </td>
            <td colspan="3" class="xl39" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%
            total += Convert.ToDecimal(dt2.Rows[i]["sel_amt"]);
            subqty += Convert.ToDecimal(dt2.Rows[i]["out_qty"]);

            } %>
        <tr height="32" style='mso-height-source: userset; height: 24.0pt'>
            <td height="32" class="xl51" width="49" style='height: 24.0pt; border-top: none;
                width: 37pt'>
                Sum
            </td>
            <td class="xl52" width="99" style='border-top: none; width: 74pt'>
                &nbsp;
            </td>
            <td class="xl52" width="75" style='border-top: none; width: 56pt'>
                &nbsp;
            </td>
            <td class="xl52" width="117" style='border-top: none; width: 88pt'>
                &nbsp;
            </td>
            <td class="xl52" width="114" style='border-top: none; width: 86pt'>
                &nbsp;
            </td>
            <td class="xl52" width="268" style='border-top: none; width: 201pt'>
                &nbsp;
            </td>
            <td class="xl53" width="124" style='border-top: none; width: 93pt'>
                &nbsp;
            </td>
            <td class="xl29" width="47" style='border-top: none; border-left: none; width: 35pt'>
                 
            </td>
            <td class="xl49" width="62" style='border-top: none; border-left: none; width: 47pt'
                x:num>
                <span style='mso-spacerun: yes'></span><span style='mso-spacerun: yes'> <%= total %> </span>
            </td>
            <td class="xl48" width="99" style='border-top: none; border-left: none; width: 74pt'
                x:num>
                <span style='mso-spacerun: yes'></span><span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl49" width="62" style='border-top: none; border-left: none; width: 47pt'
                x:num>
                <%= subqty %>
            </td>
            <td class="xl30" width="120" style='border-top: none; border-left: none; width: 90pt'>
                &nbsp;
            </td>
            <td colspan="3" class="xl39" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="34" style='mso-height-source: userset; height: 25.5pt'>
            <td colspan="7" height="34" class="xl58" width="846" style='border-right: .5pt solid black;
                height: 25.5pt; width: 635pt'>
                T&#7893;ng c&#7897;ng <font class="font9">Total</font>
            </td>
            <td class="xl41" style='border-top: none; border-left: none'>
                &nbsp;
            </td>
            <td class="xl41" style='border-top: none; border-left: none'>
                &nbsp;
            </td>
            <td class="xl41" style='border-top: none; border-left: none'>
                &nbsp;
            </td>
            <td class="xl49" width="101" style='border-top: none; border-left: none; width: 76pt'
                x:num>
                <span style='mso-spacerun: yes'></span><%= total %>
            </td>
            <td class="xl41" style='border-top: none; border-left: none'>
                &nbsp;
            </td>
            <td colspan="3" class="xl39" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="15" class="xl39" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="3" class="xl39" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
            <td class="xl50" colspan="3" style='mso-ignore: colspan'>
                CHUNSHIN PRECISION VINA CO,. LTD.
            </td>
            <td class="xl50" colspan="2" style='mso-ignore: colspan'>
                PK CORP. (PKSG III)
            </td>
            <td colspan="7" class="xl50" style='mso-ignore: colspan'>
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="49" style='width: 37pt'>
            </td>
            <td width="99" style='width: 74pt'>
            </td>
            <td width="75" style='width: 56pt'>
            </td>
            <td width="117" style='width: 88pt'>
            </td>
            <td width="114" style='width: 86pt'>
            </td>
            <td width="268" style='width: 201pt'>
            </td>
            <td width="124" style='width: 93pt'>
            </td>
            <td width="47" style='width: 35pt'>
            </td>
            <td width="62" style='width: 47pt'>
            </td>
            <td width="99" style='width: 74pt'>
            </td>
            <td width="101" style='width: 76pt'>
            </td>
            <td width="120" style='width: 90pt'>
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
