﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_tsa_revision_m_pk = Request.QueryString["p_tsa_revision_m_pk"];
    string para = "'" + p_tsa_revision_m_pk + "'";
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("sale.sp_rpt_dsre00070", para);
    dt1 = ESysLib.TableReadOpenCursor("sale.sp_rpt_dsre00070_1", para);
    dt2 = ESysLib.TableReadOpenCursor("sale.sp_rpt_dsre00070_2");  
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_dsre00070_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_dsre00070_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_dsre00070_files/oledata.mso">
    <!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>Server_Test</o:LastAuthor>
  <o:LastPrinted>2011-06-23T03:31:49Z</o:LastPrinted>
  <o:Created>2011-06-10T09:01:23Z</o:Created>
  <o:LastSaved>2011-06-23T03:31:52Z</o:LastSaved>
  <o:Company>Prive</o:Company>
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
            mso-footer-data: "Page &P of &N";
            margin: .37in .27in .46in .28in;
            mso-header-margin: .33in;
            mso-footer-margin: .31in;
            mso-page-orientation: landscape;
        }
        .font8
        {
            color: black;
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
            font-size: 8.0pt;
            font-weight: 700;
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
        .style21
        {
            mso-number-format: General;
            text-align: general;
            vertical-align: bottom;
            white-space: nowrap;
            mso-rotate: 0;
            mso-background-source: auto;
            mso-pattern: auto;
            color: windowtext;
            font-size: 11.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: 돋움, monospace;
            mso-font-charset: 129;
            border: none;
            mso-protection: locked visible;
            mso-style-name: Normal_Sheet1;
        }
        td
        {
            mso-style-parent: style0;
            padding: 0px;
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
        .xl25
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            white-space: normal;
        }
        .xl26
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            white-space: normal;
        }
        .xl27
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl28
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl29
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            white-space: normal;
        }
        .xl30
        {
            mso-style-parent: style21;
            color: black;
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
        .xl31
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl32
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl33
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl34
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        .xl35
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0";
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl36
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0";
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            mso-background-source: auto;
            mso-pattern: #CCCCFF gray-0625;
            white-space: normal;
        }
        .xl37
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0";
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            mso-background-source: auto;
            mso-pattern: #CCCCFF gray-0625;
            white-space: normal;
        }
        .xl38
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0";
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            mso-background-source: auto;
            mso-pattern: #CCCCFF gray-0625;
            white-space: normal;
        }
        .xl39
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0";
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl40
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl41
        {
            mso-style-parent: style21;
            color: black;
            font-size: 18.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            white-space: normal;
        }
        .xl42
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl43
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl44
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "Short Date";
            text-align: left;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl45
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
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
            white-space: normal;
        }
        .xl46
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid black;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl47
        {
            mso-style-parent: style21;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid black;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl48
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "dd\/mm\/yy";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        .xl49
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "dd\/mm\/yy";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid black;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl50
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "dd\/mm\/yy";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid black;
            white-space: normal;
        }
        -- ></style>
    <!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>ORD_REVISION</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>210</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6765</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=ORD_REVISION!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"/>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>
<body link="blue" vlink="purple" class="xl25">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1986" style='border-collapse: collapse;
        table-layout: fixed; width: 1491pt'>
        <col class="xl25" width="110" style='mso-width-source: userset; mso-width-alt: 4022;
            width: 83pt'>
        <col class="xl25" width="100" span="4" style='mso-width-source: userset; mso-width-alt: 3657;
            width: 75pt'>
        <col class="xl25" width="85" style='mso-width-source: userset; mso-width-alt: 3108;
            width: 64pt'>
        <col class="xl25" width="120" span="4" style='mso-width-source: userset; mso-width-alt: 4388;
            width: 90pt'>
        <col class="xl25" width="106" style='mso-width-source: userset; mso-width-alt: 3876;
            width: 80pt'>
        <col class="xl25" width="215" style='mso-width-source: userset; mso-width-alt: 7862;
            width: 161pt'>
        <col class="xl25" width="102" style='mso-width-source: userset; mso-width-alt: 3730;
            width: 77pt'>
        <col class="xl25" width="232" style='mso-width-source: userset; mso-width-alt: 8484;
            width: 174pt'>
        <col class="xl25" width="64" span="4" style='width: 48pt'>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td colspan="9" rowspan="2" height="40" width="955" style='height: 30.0pt; width: 717pt'
                align="left" valign="top">
                <!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:2.25pt;margin-top:3pt;width:72.75pt;height:34.5pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt2.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]-->
                <![if !vml]><span style='mso-ignore: vglayout; position: absolute; z-index: 1; margin-left: 3px;
                    margin-top: 4px; width: 97px; height: 46px'>
                    <img width="97" height="46" src="rpt_dsre00070_files/image001.jpg" v:shapes="_x0000_s1025">
                </span><![endif]><span style='mso-ignore: vglayout2'>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="9" rowspan="2" height="40" class="xl41" width="955" style='height: 30.0pt;
                                width: 717pt'>
                                ORDER REVISION
                            </td>
                        </tr>
                    </table>
                </span>
            </td>
            <td colspan="2" class="xl42" width="226" style='width: 170pt'>
                Print Date : <font class="font8">
                    <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></font>
            </td>
            <td class="xl26" width="215" style='width: 161pt'>
            </td>
            <td class="xl26" width="102" style='width: 77pt'>
            </td>
            <td class="xl26" width="232" style='width: 174pt'>
            </td>
            <td class="xl26" width="64" style='width: 48pt'>
            </td>
            <td class="xl26" width="64" style='width: 48pt'>
            </td>
            <td class="xl26" width="64" style='width: 48pt'>
            </td>
            <td class="xl26" width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td height="20" class="xl27" style='height: 15.0pt'>
                Status :<font class="font8"><span style='mso-spacerun: yes'></span></font>
            </td>
            <td class="xl28">
                <%= dt.Rows[0]["status"]%>
            </td>
            <td colspan="3" class="xl26" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td height="20" class="xl29" style='height: 15.0pt'>
            </td>
            <td colspan="3" class="xl43" width="300" style='width: 225pt'>
                Charger : <font class="font9">
                    <%= dt.Rows[0]["full_name"]%></font>
            </td>
            <td colspan="5" class="xl44" width="545" style='width: 409pt'>
                Customer :<font class="font9"><%= dt.Rows[0]["partner_name"]%></font>
            </td>
            <td class="xl27">
                Rev Date :<font class="font8"><span style='mso-spacerun: yes'></span></font>
            </td>
            <td class="xl28">
                <%= dt.Rows[0]["rev_date"]%>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="30" style='mso-height-source: userset; height: 22.5pt'>
            <td height="30" class="xl30" width="110" style='height: 22.5pt; width: 83pt'>
                SO Item No
            </td>
            <td class="xl31" width="100" style='width: 75pt'>
                Rev Type
            </td>
            <td class="xl32" width="100" style='width: 75pt'>
                Desc 01
            </td>
            <td class="xl33" width="100" style='width: 75pt'>
                Desc 02
            </td>
            <td class="xl31" width="100" style='width: 75pt'>
                Desc 03
            </td>
            <td class="xl31" width="85" style='width: 64pt'>
                Column
            </td>
            <td colspan="2" class="xl45" width="240" style='border-right: .5pt solid black; border-left: none;
                width: 180pt'>
                Before Revision
            </td>
            <td colspan="2" class="xl47" width="240" style='border-right: .5pt solid black; border-left: none;
                width: 180pt'>
                After Revision
            </td>
            <td class="xl31" width="106" style='width: 80pt'>
                Remark
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <% for (int i = 0; i < dt1.Rows.Count; i++)
           {
        %>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl34" width="110" style='height: 18.75pt; width: 83pt'>
                <%=dt1.Rows[i]["ref_no"]%>
            </td>
            <td class="xl35" width="100" style='width: 75pt'>
                <%=dt1.Rows[i]["revision_type"]%>
            </td>
            <td class="xl36" width="100" style='width: 75pt'>
                <%=dt1.Rows[i]["desc_01"]%>
            </td>
            <td class="xl37" width="100" style='width: 75pt'>
                <%=dt1.Rows[i]["desc_02"]%>
            </td>
            <td class="xl38" width="100" style='width: 75pt'>
                <%=dt1.Rows[i]["desc_03"]%>
            </td>
            <td class="xl39" width="85" style='width: 64pt'>
                <%=dt1.Rows[i]["column_name"]%>
            </td>
            <td colspan="2" class="xl48" width="240" style='border-right: .5pt solid black; border-left: none;
                width: 180pt'>
                <%=dt1.Rows[i]["old_item"]%>
            </td>
            <td colspan="2" class="xl50" width="240" style='border-right: .5pt solid black; border-left: none;
                width: 180pt'>
                <%=dt1.Rows[i]["new_item"]%>
            </td>
            <td class="xl40" width="106" style='width: 80pt'>
               <%=dt1.Rows[i]["description"]%>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%} %>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="18" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="18" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="18" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="18" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="5" rowspan="10" height="140" class="xl25" width="586" style='mso-ignore: colspan-rowspan;
                height: 105.0pt; width: 440pt'>
                <!--[if gte vml 1]><v:shape id="_x0000_s1026"
   type="#_x0000_t75" style='position:absolute;margin-left:8.25pt;margin-top:2.25pt;
   width:409.5pt;height:93.75pt;z-index:2'>
   <v:imagedata src="rpt_dsre00070_files/image002.png" o:title="sign"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
                <![if !vml]><span style='mso-ignore: vglayout'>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="11" height="3">
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <img width="546" height="125" src="rpt_dsre00070_files/image003.jpg" v:shapes="_x0000_s1026">
                            </td>
                            <td width="29">
                            </td>
                        </tr>
                        <tr>
                            <td height="12">
                            </td>
                        </tr>
                    </table>
                </span><![endif]><!--[if !mso & vml]><span style='width:439.5pt;height:105.0pt'></span><![endif]-->
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="14" style='height: 10.5pt'>
            <td height="14" colspan="6" class="xl25" style='height: 10.5pt; mso-ignore: colspan'>
            </td>
            <td colspan="7" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="110" style='width: 83pt'>
            </td>
            <td width="100" style='width: 75pt'>
            </td>
            <td width="100" style='width: 75pt'>
            </td>
            <td width="100" style='width: 75pt'>
            </td>
            <td width="100" style='width: 75pt'>
            </td>
            <td width="85" style='width: 64pt'>
            </td>
            <td width="120" style='width: 90pt'>
            </td>
            <td width="120" style='width: 90pt'>
            </td>
            <td width="120" style='width: 90pt'>
            </td>
            <td width="120" style='width: 90pt'>
            </td>
            <td width="106" style='width: 80pt'>
            </td>
            <td width="215" style='width: 161pt'>
            </td>
            <td width="102" style='width: 77pt'>
            </td>
            <td width="232" style='width: 174pt'>
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
