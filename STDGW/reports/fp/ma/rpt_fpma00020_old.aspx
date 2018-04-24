<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_assetdoc_pk = Request.QueryString["AssetDoc_pk"];
    string p_AssetPK1 = Request.QueryString["AssetPK1"];
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_fpma00020", "'" + p_assetdoc_pk + "'");
    dt2 = ESysLib.TableReadOpenCursor("prod.sp_rpt_fpma00020_2", "'" + p_AssetPK1 + "'");
    dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_fpma00020_1");
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="Maint%20Rpt%20Design%20110617_files/filelist.xml">
    <link rel="Edit-Time-Data" href="Maint%20Rpt%20Design%20110617_files/editdata.mso">
    <link rel="OLE-Object-Data" href="Maint%20Rpt%20Design%20110617_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>Server_Test</o:LastAuthor>
  <o:LastPrinted>2011-06-17T08:04:10Z</o:LastPrinted>
  <o:Created>2011-06-16T06:41:53Z</o:Created>
  <o:LastSaved>2011-06-21T03:12:55Z</o:LastSaved>
  <o:Company>Prive</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
    {mso-displayed-decimal-separator: "\.";
     mso-displayed-thousand-separator: "\,";}
@page
        {margin: 1.0in .75in 1.0in .75in;
         mso-header-margin: .5in;
         mso-footer-margin: .5in;}
        .font0
        {
            color: windowtext;
            font-size: 10.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Arial;
            mso-generic-font-family: auto;
            mso-font-charset: 0;
        }
        .font8
        {
            color: windowtext;
            font-size: 10.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
        }
        tr{mso-height-source: auto;}
        col{mso-width-source: auto;}
        br{mso-data-placement: same-cell;}
        .style0
        {mso-number-format: General;
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
         mso-style-id: 0;}
        td
        {mso-style-parent: style0;
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
         mso-rotate: 0;}
        .xl65
        {mso-style-parent: style0;
         vertical-align: middle;
         white-space: normal;}
        .xl66
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl67
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl68
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        .xl69
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl70
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "Short Date";
            text-align: left;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl71
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: none;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl72
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: 2.0pt double windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl73
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl74
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl75
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl76
        {
            mso-style-parent: style0;
            font-size: 9.0pt;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl77
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        .xl78
        {
            mso-style-parent: style0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl79
        {
            mso-style-parent: style0;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl80
        {
            mso-style-parent: style0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        .xl81
        {
            mso-style-parent: style0;
            vertical-align: top;
            white-space: normal;
        }
        .xl82
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: none;
            border-bottom: none;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl83
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl84
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl85
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        .xl86
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl87
        {
            mso-style-parent: style0;
            font-size: 26.0pt;
            font-weight: 500;
            font-family: "Code39\(1\:2\)" , sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: none;
            border-left: none;
        }
        .xl88
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: right;
            vertical-align: middle;
            border-top: none;
            border-right: 2.0pt double windowtext;
            border-bottom: none;
            border-left: none;
            white-space: normal;
        }
        .xl89
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            white-space: normal;
        }
        .xl90
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: none;
            border-left: 2.0pt double windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl91
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: none;
            border-left: none;
            background: yellow;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl92
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: none;
            border-left: none;
            background: yellow;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl93
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 2.0pt double windowtext;
            border-left: 2.0pt double windowtext;
            background: yellow;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl94
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
            background: yellow;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl95
        {
            mso-style-parent: style0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: 2.0pt double windowtext;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
            background: yellow;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl96
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Arial, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: 2.0pt double windowtext;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl97
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
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl98
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
            border-left: none;
            white-space: normal;
        }
        .xl99
        {
            mso-style-parent: style0;
            text-align: left;
            vertical-align: top;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: none;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl100
        {
            mso-style-parent: style0;
            text-align: left;
            vertical-align: top;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: none;
            border-left: none;
            white-space: normal;
        }
        .xl101
        {
            mso-style-parent: style0;
            text-align: left;
            vertical-align: top;
            border-top: .5pt solid windowtext;
            border-right: 2.0pt double windowtext;
            border-bottom: none;
            border-left: none;
            white-space: normal;
        }
        .xl102
        {
            mso-style-parent: style0;
            text-align: left;
            vertical-align: top;
            border-top: none;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: 2.0pt double windowtext;
            white-space: normal;
        }
        .xl103
        {
            mso-style-parent: style0;
            text-align: left;
            vertical-align: top;
            border-top: none;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl104
        {
            mso-style-parent: style0;
            text-align: left;
            vertical-align: top;
            border-top: none;
            border-right: 2.0pt double windowtext;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
-->
</style>
    <!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Asset Label</x:Name>
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
       <x:ActiveRow>24</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PublishObjects>
     <x:PublishObject>
      <x:Id>31878</x:Id>
      <x:DivID>Maint Rpt Design 110617_31878</x:DivID>
      <x:SourceType>SourceSheet</x:SourceType>
      <x:HtmlType>HtmlStatic</x:HtmlType>
      <x:Location
       HRef="C:\Documents and Settings\ntxuan\My Documents\main\Maint Rpt Design 110617.htm"/>
      <x:Title>Asset Label</x:Title>
     </x:PublishObject>
    </x:PublishObjects>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>17835</x:WindowWidth>
  <x:WindowTopX>600</x:WindowTopX>
  <x:WindowTopY>345</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]-->
</head>
<body link="blue" vlink="purple" class="xl65">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="901" style='border-collapse: collapse;
        table-layout: fixed; width: 676pt'>
        <col class="xl65" width="82" style='mso-width-source: userset; mso-width-alt: 2998;
            width: 62pt'>
        <col class="xl65" width="192" style='mso-width-source: userset; mso-width-alt: 7021;
            width: 144pt'>
        <col class="xl65" width="132" style='mso-width-source: userset; mso-width-alt: 4827;
            width: 99pt'>
        <col class="xl65" width="175" style='mso-width-source: userset; mso-width-alt: 6400;
            width: 131pt'>
        <col class="xl65" width="64" span="5" style='width: 48pt'>
        <tr height="18" style='height: 13.5pt'>
            <td height="18" class="xl65" width="82" style='height: 13.5pt; width: 62pt'>
            </td>
            <td class="xl65" width="192" style='width: 144pt'>
            </td>
            <td class="xl65" width="132" style='width: 99pt'>
            </td>
            <td class="xl81" width="175" style='width: 131pt'>
            </td>
            <td class="xl65" width="64" style='width: 48pt'>
            </td>
            <td class="xl65" width="64" style='width: 48pt'>
            </td>
            <td class="xl65" width="64" style='width: 48pt'>
            </td>
            <td class="xl65" width="64" style='width: 48pt'>
            </td>
            <td class="xl65" width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr height="46" style='mso-height-source: userset; height: 34.5pt'>
            <td height="46" class="xl82" width="82" style='height: 34.5pt; width: 62pt'>
                <v:shape id="Picture_x0020_2" o:spid="_x0000_s4126" type="#_x0000_t75" alt="image001"
                    style='position: absolute; margin-left: 3pt; margin-top: 1.5pt; width: 57.75pt;
                    height: 31.5pt; z-index: 1; visibility: visible'>
                    <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto"
                        o:title="image001" />
                    <x:clientdata objecttype="Pict">
                        <x:sizewithcells />
                        <x:cf>Bitmap</x:cf>
                        <x:autopict />
                    </x:clientdata>
                </v:shape>
            </td>
            <td colspan="2" class="xl96" width="324" style='width: 243pt'>
                <%= dt1.Rows[0]["partner_name"] %>
            </td>
            <td class="xl87" x:num>
                *<%= dt.Rows[0]["asset_code"]%>*
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td height="22" class="xl83" width="82" style='height: 16.5pt; width: 62pt'>
                Asset Type:
            </td>
            <td class="xl84" width="192" style='border-top: none; width: 144pt'>
                <%= dt.Rows[0]["asset_type"]%>
            </td>
            <td class="xl85" width="132" style='border-top: none; border-left: none; width: 99pt'>
                Model:
            </td>
            <td class="xl86" width="175" style='width: 131pt'>
                <%= dt.Rows[0]["asset_model"]%>
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td height="22" class="xl66" width="82" style='height: 16.5pt; border-top: none;
                width: 62pt'>
                Group:
            </td>
            <td class="xl67" width="192" style='border-top: none; width: 144pt'>
                <%= dt.Rows[0]["groupitem"]%>
            </td>
            <td class="xl68" width="132" style='border-top: none; border-left: none; width: 99pt'>
                Brand:
            </td>
            <td class="xl69" width="175" style='border-top: none; width: 131pt'>
                <%= dt.Rows[0]["brand"]%>
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td height="22" class="xl66" width="82" style='height: 16.5pt; border-top: none;
                width: 62pt'>
                Item Code:
            </td>
            <td class="xl67" width="192" style='border-top: none; width: 144pt'>
                <%= dt.Rows[0]["asset_code"]%>
            </td>
            <td class="xl68" width="132" style='border-top: none; border-left: none; width: 99pt'>
                Warranty:
            </td>
            <td class="xl69" width="175" style='border-top: none; width: 131pt'>
                <%= dt.Rows[0]["warranty"]%>
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 25.0pt'>
            <td height="22" class="xl66" width="82" style='height: 16.5pt; border-top: none;
                width: 62pt'>
                Item Name:
            </td>
            <td class="xl67" width="192" style='border-top: none; width: 144pt'>
                <%= dt.Rows[0]["asset_name"]%>
            </td>
            <td class="xl68" width="132" style='border-top: none; border-left: none; width: 99pt'>
                Ass Checking Date:
            </td>
            <td class="xl70" width="175" style='border-top: none; width: 131pt' x:num="40664">
                <%= dt.Rows[0]["asset_checking_date"]%>
            </td>
            <td colspan="2" class="xl65" style='mso-ignore: colspan'>
            </td>
            <td class="xl65" width="64" style='width: 48pt'>
                <span style='mso-spacerun: yes'></span>
            </td>
            <td colspan="2" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td height="22" class="xl66" width="82" style='height: 16.5pt; border-top: none;
                width: 62pt'>
                User:
            </td>
            <td class="xl67" width="192" style='border-top: none; width: 144pt'>
                <%= dt.Rows[0]["asset_user"]%>
            </td>
            <td class="xl68" width="132" style='border-top: none; border-left: none; width: 99pt'>
                Using from:
            </td>
            <td class="xl70" width="175" style='border-top: none; width: 131pt' >
                <%= dt.Rows[0]["using_from"]%>
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td colspan="2" height="22" class="xl97" width="274" style='height: 16.5pt; width: 206pt'>
            </td>
            <td class="xl68" width="132" style='border-top: none; width: 99pt'>
                Location:
            </td>
            <td class="xl70" width="175" style='border-top: none; width: 131pt'>
                <%= dt.Rows[0]["asset_location"]%>
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td colspan="4" rowspan="2" height="44" class="xl99" width="581" style='border-right: 2.0pt double black;
                border-bottom: 1.0pt solid black; height: 33.0pt; width: 436pt'>
                Spec Description:
                <%= dt.Rows[0]["description"]%>
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td height="22" colspan="5" class="xl65" style='height: 16.5pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td height="22" class="xl71" width="82" style='height: 16.5pt; width: 62pt'>
                Accessory
            </td>
            <td colspan="2" class="xl65" style='mso-ignore: colspan'>
            </td>
            <td class="xl88" width="175" style='width: 131pt'>
                Print Date:
                <%= DateTime.Now.ToString("dd/MM/yyyy") %>
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td height="22" class="xl72" width="82" style='height: 16.5pt; width: 62pt'>
                No.
            </td>
            <td class="xl73" width="192" style='border-left: none; width: 144pt'>
                Accessory Description
            </td>
            <td class="xl73" width="132" style='border-left: none; width: 99pt'>
                Quantity
            </td>
            <td class="xl74" width="175" style='border-left: none; width: 131pt'>
                Remark
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <% for (int i = 0; i < dt2.Rows.Count; i++)
           {
        %>
        <tr height="22" style='mso-height-source: userset; height: 24.0pt'>
            <td height="22" class="xl75" width="82" style='height: 16.5pt; border-top: none;
                width: 62pt' x:num>
                <%= dt2.Rows[i]["SEQ"]%>
            </td>
            <td class="xl76" width="192" style='border-top: none; border-left: none; width: 144pt'>
                <%= dt2.Rows[i]["asset_code"]%>
                -
                <%= dt2.Rows[i]["asset_name"]%>
            </td>
            <td class="xl76" width="132" style='border-top: none; border-left: none; width: 99pt'
                x:num>
                <%= dt2.Rows[i]["qty"]%>
            </td>
            <td class="xl77" width="175" style='border-top: none; border-left: none; width: 131pt'>
                <%= dt2.Rows[i]["DESCRIPTION"]%>
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%} %>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td colspan="4" rowspan="2" height="44" class="xl90" width="581" style='border-right: 2.0pt double black;
                border-bottom: 2.0pt double black; height: 33.0pt; width: 436pt'>
                Notice: For any problems, please contact to MAINTENANCE DEPT (08-38122775 or 0909 123456)
                <br />
                This is <b><%= dt1.Rows[0]["partner_name"] %></b>'s property and must be returned upon request or if found.
            </td>
            <td colspan="5" class="xl65" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td height="22" colspan="5" class="xl65" style='height: 16.5pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="18" style='height: 13.5pt'>
            <td height="18" colspan="8" class="xl65" style='height: 13.5pt; mso-ignore: colspan'>
            </td>
            <td class="xl89">
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="82" style='width: 62pt'>
            </td>
            <td width="192" style='width: 144pt'>
            </td>
            <td width="132" style='width: 99pt'>
            </td>
            <td width="175" style='width: 131pt'>
            </td>
            <td width="64" style='width: 48pt'>
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
