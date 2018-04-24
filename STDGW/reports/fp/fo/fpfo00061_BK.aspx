<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% Response.Charset = "utf-8"; %>
<% ESysLib.SetUser("prod");%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<%

    string sSQL, qc_ireq_d_pk;

    qc_ireq_d_pk = Request.QueryString["qc_ireq_d_pk"];

         sSQL = " SELECT   tco_item_pk, item_code, substr(item_name,1,28) item_name, po_no, tpr_lotno_pk,  " +
                " lot_no, bc_seq, item_bc, sticker_length, item_length, " +
                " item_length_uom, sticker_weight, item_weight, item_weight_uom " +
                " FROM prod.tpr_itembcm a WHERE a.del_if = 0 " +
                " AND ref_table_name = 'QC_IREQ_D' " +
                " AND ref_table_pk = '" + qc_ireq_d_pk + "' " +
                " ORDER BY item_code, po_no, lot_no, bc_seq " ;
    
    
    DataTable dt = ESysLib.TableReadOpen(sSQL);          
   
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="fpfo00061_files/filelist.xml">
    <link rel="Edit-Time-Data" href="fpfo00061_files/editdata.mso">
    <link rel="OLE-Object-Data" href="fpfo00061_files/oledata.mso">
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
  <o:Author>QuangNguyen</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2009-06-12T02:37:23Z</o:LastPrinted>
  <o:Created>2009-06-12T02:24:46Z</o:Created>
  <o:LastSaved>2009-06-12T02:37:38Z</o:LastSaved>
  <o:Company>VinaGenuwin</o:Company>
  <o:Version>11.6360</o:Version>
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
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
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
	padding:0px;
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
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
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
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>
<body link="blue" vlink="purple">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="200" style='border-collapse: collapse;
        table-layout: fixed; width: 150pt'>
        <col width="50" style='mso-width-source: userset; mso-width-alt: 1828; width: 38pt'>
        <col width="75" span="2" style='mso-width-source: userset; mso-width-alt: 2742; width: 56pt'>
        
<%
        for (int i = 0; i < dt.Rows.Count; i++)
        {
                   
%>

        <tr height="30" style='mso-height-source: userset; height: 22.5pt'>
            <td height="30" width="50" style='height: 22.5pt; width: 38pt' align="left" valign="top">
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
   margin-left:15pt;margin-top:1.5pt;width:18.75pt;height:19.5pt;z-index:1'>
   <v:imagedata src="fpfo00061_files/image001.gif" o:title="CottonLogo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]-->
                <![if !vml]><span style='mso-ignore: vglayout; position: absolute; z-index: 1; margin-left: 20px;
                    margin-top: 2px; width: 25px; height: 26px'>
                    <img width="25" height="26" src="fpfo00061_files/image003.gif" v:shapes="_x0000_s1025"></span>
                <![endif]><span style='mso-ignore: vglayout2'>
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td height="30" class="xl24" width="50" style='height: 22.5pt; width: 38pt'>
                                &nbsp;</td>
                        </tr>
                    </table>
                </span>
            </td>
            <td colspan="2" class="xl36" width="150" style='border-right: 1.0pt solid black;
                width: 112pt'>
                The <font class="font5">Cotton</font><font class="font0"> Factory</font></td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td colspan="3" height="25" class="xl38" style='border-right: 1.0pt solid black;
                height: 18.75pt'>
                <!-- <%=dt.Rows[i]["item_code"]%>
                &nbsp;/&nbsp; --> <%=dt.Rows[i]["item_name"]%>
               </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl25" style='height: 12.75pt'>
                Roll No</td>
            <td class="xl26">
                PO No</td>
            <td class="xl27">
                Lot No</td>
        </tr>
        <tr class="xl28" height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl29" style='height: 18.75pt'>
                <%=dt.Rows[i]["bc_seq"]%></td>
            <td class="xl30">
                <%=dt.Rows[i]["po_no"]%></td>
            <td class="xl31">
                <%=dt.Rows[i]["lot_no"]%></td>
        </tr>
        <tr class="xl28" height="17" style='height: 12.75pt'>
            <td height="17" class="xl32" style='height: 12.75pt'>
                &nbsp;</td>
            <td class="xl33">
                Length&nbsp;(<%=dt.Rows[i]["item_length_uom"]%>)</td>
            <td class="xl34">
                Weight&nbsp;(<%=dt.Rows[i]["item_weight_uom"]%>)</td>
        </tr>
        <tr class="xl28" height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl35" style='height: 18.75pt'>
                Sticker</td>
            <td class="xl30">
                <%=dt.Rows[i]["sticker_length"]%></td>
            <td class="xl31">
                <%=dt.Rows[i]["sticker_weight"]%></td>
        </tr>
        <tr class="xl28" height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl35" style='height: 18.75pt'>
                Actual</td>
            <td class="xl30">
                </td>
            <td class="xl31">
                </td>
        </tr>
        <tr class="xl28" height="38" style='mso-height-source: userset; height: 28.5pt'>
            <td colspan="3" height="38" class="xl45" style='border-right: 1.0pt solid black;
                height: 28.5pt'>
                *<%=dt.Rows[i]["item_bc"]%>*</td>
        </tr>
        <tr class="xl28" height="18" style='mso-height-source: userset; height: 13.5pt'>
            <td colspan="3" height="18" class="xl41" style='border-right: 1.0pt solid black;
                height: 13.5pt'>
                <%=dt.Rows[i]["item_bc"]%></td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td colspan="3" height="17" class="xl44" style='height: 12.75pt'>
                &nbsp;</td>
        </tr>
        
<%         
} 
%>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="50" style='width: 38pt'>
            </td>
            <td width="75" style='width: 56pt'>
            </td>
            <td width="75" style='width: 56pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
