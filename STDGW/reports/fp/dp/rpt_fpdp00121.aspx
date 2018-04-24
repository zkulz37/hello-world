<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% Response.Charset = "utf-8"; %>
<% ESysLib.SetUser("prod");%>
<% Response.Buffer = false;%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<%            
    string p_style_pk = Request.QueryString["style_pk"];
    DataTable dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_fpdp00121", p_style_pk);   
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_fpdp00121_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_fpdp00121_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_fpdp00121_files/oledata.mso">
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
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-05-16T02:34:59Z</o:LastPrinted>
  <o:Created>2011-05-13T06:37:58Z</o:Created>
  <o:LastSaved>2011-05-19T09:13:58Z</o:LastSaved>
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
            mso-footer-data: "Page &P of &N";
            margin: .18in .17in .16in .17in;
            mso-header-margin: .17in;
            mso-footer-margin: .16in;
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
        .xl24
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl25
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl26
        {
            mso-style-parent: style0;
            vertical-align: middle;
            white-space: normal;
        }
        .xl27
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: 2.0pt double windowtext;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl28
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl29
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl30
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt dashed windowtext;
            border-bottom: .5pt dashed windowtext;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl31
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt dashed windowtext;
            border-bottom: .5pt dashed windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl32
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt dashed windowtext;
            border-bottom: .5pt dashed windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl33
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            vertical-align: middle;
            border-top: none;
            border-right: 2.0pt double windowtext;
            border-bottom: .5pt dashed windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl34
        {
            mso-style-parent: style0;
            border-top: 2.0pt double windowtext;
            border-right: none;
            border-bottom: none;
            border-left: none;
        }
        .xl35
        {
            mso-style-parent: style0;
            color: #993300;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: 1.0pt solid windowtext;
            white-space: normal;
        }
        .xl36
        {
            mso-style-parent: style0;
            color: #993300;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl37
        {
            mso-style-parent: style0;
            color: #993300;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: 1.0pt solid black;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl38
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: none;
            border-left: 1.0pt solid windowtext;
            white-space: normal;
        }
        .xl39
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid black;
            border-bottom: none;
            border-left: none;
            white-space: normal;
        }
        .xl40
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: none;
            border-left: 1.0pt solid windowtext;
            white-space: normal;
        }
        .xl41
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid black;
            border-bottom: none;
            border-left: none;
            white-space: normal;
        }
        .xl42
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 1.0pt solid black;
            border-left: 1.0pt solid windowtext;
            white-space: normal;
        }
        .xl43
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid black;
            border-bottom: 1.0pt solid black;
            border-left: none;
            white-space: normal;
        }
        .xl44
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl45
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        .xl46
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid black;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl47
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid black;
            white-space: normal;
        }
        .xl48
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid black;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl49
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid black;
            white-space: normal;
        }
        .xl50
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: 1.0pt solid black;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl51
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        .xl52
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid black;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl53
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: .5pt solid black;
            white-space: normal;
        }
        .xl54
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid black;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl55
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "Short Date";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl56
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "Short Date";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: .5pt solid black;
            white-space: normal;
        }
        .xl57
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "Short Date";
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: 1.0pt solid black;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl58
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt dashed windowtext;
            border-bottom: .5pt hairline windowtext;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl59
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt dashed windowtext;
            border-bottom: .5pt hairline windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl60
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt dashed windowtext;
            border-bottom: .5pt hairline windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl61
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            vertical-align: middle;
            border-top: none;
            border-right: 2.0pt double windowtext;
            border-bottom: .5pt hairline windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl62
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            text-align: center;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: .5pt dashed windowtext;
            border-bottom: .5pt hairline windowtext;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl63
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: .5pt dashed windowtext;
            border-bottom: .5pt hairline windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl64
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            text-align: center;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: .5pt dashed windowtext;
            border-bottom: .5pt hairline windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl65
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: .5pt hairline windowtext;
            border-left: none;
            white-space: normal;
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
       <x:ActiveRow>12</x:ActiveRow>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>16155</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1030"/>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>
<body link="blue" vlink="purple">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="970" style='border-collapse: collapse;
        table-layout: fixed; width: 727pt'>
        <col width="40" style='mso-width-source: userset; mso-width-alt: 1462; width: 30pt'>
        <col width="95" span="2" style='mso-width-source: userset; mso-width-alt: 3474; width: 71pt'>
        <col width="100" style='mso-width-source: userset; mso-width-alt: 3657; width: 75pt'>
        <col width="40" style='mso-width-source: userset; mso-width-alt: 1462; width: 30pt'>
        <col width="120" span="5" style='mso-width-source: userset; mso-width-alt: 4388;
            width: 90pt'>
        <tr height="35" style='height: 26.25pt'>
            <td colspan="10" height="35" class="xl35" width="970" style='border-right: 1.0pt solid black;
                height: 26.25pt; width: 727pt'>
                STYLE PROCESS COMPONENT
            </td>
        </tr>
        <tr height="28" style='mso-height-source: userset; height: 21.0pt'>
            <td colspan="2" rowspan="3" height="84" width="135" style='border-right: .5pt solid black;
                border-bottom: 1.0pt solid black; height: 63.0pt; width: 101pt' align="left"
                valign="top">
                <!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
   margin-left:2.25pt;margin-top:1.5pt;width:96.75pt;height:59.25pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_stitemphoto_pk"]%>&table_name=TES_LGPICTURE" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
                <![if !vml]><span style='mso-ignore: vglayout; position: absolute; z-index: 1; margin-left: 3px;
                    margin-top: 2px; width: 129px; height: 79px'>
                    <img width="129" height="79" src="rpt_fpdp00121_files/image002.jpg" v:shapes="_x0000_s1025">
                </span><![endif]><span style='mso-ignore: vglayout2'>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="2" rowspan="3" height="84" class="xl38" width="135" style='border-right: .5pt solid black;
                                border-bottom: 1.0pt solid black; height: 63.0pt; width: 101pt'>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </span>
            </td>
            <td class="xl24" width="95" style='width: 71pt'>
                BUYER
            </td>
            <td colspan="2" class="xl45" width="140" style='border-right: .5pt solid black; border-left: none;
                width: 105pt' x:num>
                <%= dt.Rows[0]["partner_name"]%>
            </td>
            <td colspan="2" class="xl47" width="240" style='border-right: .5pt solid black; border-left: none;
                width: 180pt'>
                STYLE NO
            </td>
            <td colspan="3" class="xl49" width="360" style='border-right: 1.0pt solid black;
                border-left: none; width: 270pt'>
                <%= dt.Rows[0]["item_code"]%>
            </td>
        </tr>
        <tr height="28" style='mso-height-source: userset; height: 21.0pt'>
            <td height="28" class="xl24" width="95" style='height: 21.0pt; width: 71pt'>
                P/O No
            </td>
            <td colspan="2" class="xl45" width="140" style='border-right: .5pt solid black; border-left: none;
                width: 105pt'>
                &nbsp;
            </td>
            <td colspan="2" class="xl47" width="240" style='border-right: .5pt solid black; border-left: none;
                width: 180pt'>
                BUYER STYLE NO
            </td>
            <td colspan="3" class="xl49" width="360" style='border-right: 1.0pt solid black;
                border-left: none; width: 270pt'>
                &nbsp;
            </td>
        </tr>
        <tr height="28" style='mso-height-source: userset; height: 21.0pt'>
            <td height="28" class="xl25" width="95" style='height: 21.0pt; width: 71pt'>
                QTY
            </td>
            <td colspan="2" class="xl51" width="140" style='border-right: .5pt solid black; border-left: none;
                width: 105pt'>
                &nbsp;
            </td>
            <td colspan="2" class="xl53" width="240" style='border-right: .5pt solid black; border-left: none;
                width: 180pt'>
                DATE
            </td>
            <td colspan="3" class="xl56" width="360" style='border-right: 1.0pt solid black;
                border-left: none; width: 270pt'>
                <%= System.DateTime.Now.ToString("dd/MM/yyyy HH:mm") %>
            </td>
        </tr>
        <tr height="10" style='mso-height-source: userset; height: 7.5pt'>
            <td height="10" colspan="10" class="xl26" style='height: 7.5pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="19" style='height: 14.25pt'>
            <td height="19" class="xl27" width="40" style='height: 14.25pt; width: 30pt'>
                NO
            </td>
            <td class="xl28" width="95" style='width: 71pt'>
                IN COMP
            </td>
            <td class="xl28" width="95" style='width: 71pt'>
                OUT COMP
            </td>
            <td class="xl28" width="100" style='width: 75pt'>
                REMARK
            </td>
            <td class="xl28" width="40" style='width: 30pt'>
                CUT
            </td>
            <td class="xl28" width="120" style='width: 90pt'>
                Ph&#432;&#417;ng pháp c&#7855;t
            </td>
            <td class="xl28" width="120" style='width: 90pt'>
                Dao
            </td>
            <td class="xl28" width="120" style='width: 90pt'>
                D&#7853;p chu&#7849;n
            </td>
            <td class="xl28" width="120" style='width: 90pt'>
                Máy c&#7855;t gi&#7845;y
            </td>
            <td class="xl29" width="120" style='width: 90pt'>
                Ph&#432;&#417;ng pháp làm
            </td>
        </tr>
        <% 
            dt = new DataTable();
            dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_fpdp00121_1", p_style_pk);
            int a = Convert.ToInt32(dt.Rows[0]["out_comp_pk"]);
            int b = 0;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["out_comp_pk"].ToString().Equals(a.ToString()))
                {
        %>
        <tr height="40" style='mso-height-source: userset; height: 30.0pt'>
            <td height="40" class="xl30" width="40" style='height: 30.0pt; width: 30pt' x:num>
                <%= dt.Rows[i]["seq"]%>
            </td>
            <td height="40" class="xl31" width="95" style='height: 30.0pt; width: 71pt'>
                <!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:1.5pt;
   margin-top:1.5pt;width:68.25pt;height:27.5pt;z-index:2'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["in_photo_pk"].ToString()%>&table_name=TES_LGPICTURE" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
            </td>
            <% if (i == 0)
               {
                   b = 1;%>
            <td height="40" class="xl31" width="95" style='height: 30.0pt; width: 71pt'>
                <!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:1.5pt;
   margin-top:1.5pt;width:68.25pt;height:27.5pt;z-index:2'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["out_photo_pk"].ToString()%>&table_name=TES_LGPICTURE" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
            </td>
            <% 
                }
                else
                {
                    if (b == 1)
                    {%>
               <td height="40" class="xl31" width="95" style='height: 30.0pt; width: 71pt'><%=dt.Rows[i]["component_name"] %></td>
            <% b = 0;
           }
           else
           { %><td height="40" class="xl31" width="95" style='height: 30.0pt; width: 71pt'></td> <%}
                      } %>
            <td class="xl32" width="100" style='width: 75pt'>
                <%= dt.Rows[i]["description"]%>
            </td>
            <td class="xl32" width="40" style='width: 30pt' x:num>
                <%= dt.Rows[i]["need_qty"]%>
            </td>
            <td class="xl31" width="120" style='width: 90pt'>
                &nbsp;
            </td>
            <td class="xl31" width="120" style='width: 90pt'>
                &nbsp;
            </td>
            <td class="xl31" width="120" style='width: 90pt'>
                &nbsp;
            </td>
            <td class="xl31" width="120" style='width: 90pt'>
                &nbsp;
            </td>
            <td class="xl33" width="120" style='width: 90pt'>
                &nbsp;
            </td>
        </tr>
        <% a = Convert.ToInt32(dt.Rows[i]["out_comp_pk"]);
                }
                else
                {%>
        <tr height="40" style='mso-height-source: userset; height: 30.0pt'>
            <td height="40" class="xl62" width="40" style='height: 30.0pt; width: 30pt' x:num>
                <%= dt.Rows[i]["seq"]%>
            </td>
            <td height="40" class="xl63" width="95" style='height: 30.0pt; width: 71pt'>
                <!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:1.5pt;
   margin-top:1.5pt;width:68.25pt;height:27.5pt;z-index:2'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["in_photo_pk"].ToString()%>&table_name=TES_LGPICTURE" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
            </td>
            <% if (!dt.Rows[i]["out_comp_pk"].ToString().Equals(a.ToString()))
               { %>
            <td height="40" class="xl63" width="95" style='height: 30.0pt; width: 71pt'>
                <!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:1.5pt;
   margin-top:1.5pt;width:68.25pt;height:27.5pt;z-index:2'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["out_photo_pk"].ToString()%>&table_name=TES_LGPICTURE" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
            </td><%a = Convert.ToInt32(dt.Rows[i]["out_comp_pk"]); b = 1;
               }
                   %>
                                                                                                                                                         
            <td class="xl64" width="100" style='width: 75pt'>
                <%= dt.Rows[i]["description"]%>
            </td>
            <td class="xl64" width="40" style='width: 30pt' x:num>
                <%= dt.Rows[i]["need_qty"]%>
            </td>
            <td class="xl63" width="120" style='width: 90pt'>
                &nbsp;
            </td>
            <td class="xl63" width="120" style='width: 90pt'>
                &nbsp;
            </td>
            <td class="xl63" width="120" style='width: 90pt'>
                &nbsp;
            </td>
            <td class="xl63" width="120" style='width: 90pt'>
                &nbsp;
            </td>
            <td class="xl65" width="120" style='width: 90pt'>
                &nbsp;
            </td>
        </tr>
        <% }
            } %>
        <tr height="18" style='height: 13.5pt'>
            <td height="18" class="xl34" style='height: 13.5pt'>
                &nbsp;
            </td>
            <td class="xl34">
                &nbsp;
            </td>
            <td class="xl34">
                &nbsp;
            </td>
            <td class="xl34">
                &nbsp;
            </td>
            <td class="xl34">
                &nbsp;
            </td>
            <td class="xl34">
                &nbsp;
            </td>
            <td class="xl34">
                &nbsp;
            </td>
            <td class="xl34">
                &nbsp;
            </td>
            <td class="xl34">
                &nbsp;
            </td>
            <td class="xl34">
                &nbsp;
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="40" style='width: 30pt'>
            </td>
            <td width="95" style='width: 71pt'>
            </td>
            <td width="95" style='width: 71pt'>
            </td>
            <td width="100" style='width: 75pt'>
            </td>
            <td width="40" style='width: 30pt'>
            </td>
            <td width="120" style='width: 90pt'>
            </td>
            <td width="120" style='width: 90pt'>
            </td>
            <td width="120" style='width: 90pt'>
            </td>
            <td width="120" style='width: 90pt'>
            </td>
            <td width="120" style='width: 90pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
