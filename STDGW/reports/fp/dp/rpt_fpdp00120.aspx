﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% Response.Charset = "utf-8"; %>
<% ESysLib.SetUser("prod");%>
<% Response.Buffer = false;%>

<%            
    string _style_pk = Request.QueryString["style_pk"];
    
    DataTable dt ;      
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpdp00120_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpdp00120_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpdp00120_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>QuangNguyen</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2010-05-06T07:14:48Z</o:LastPrinted>
  <o:Created>2010-05-06T06:55:32Z</o:Created>
  <o:LastSaved>2010-05-06T07:15:23Z</o:LastSaved>
  <o:Company>VinaGenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .26in .22in .26in;
	mso-header-margin:.26in;
	mso-footer-margin:.23in;}
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
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt dotted windowtext;}
.xl27
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt dotted windowtext;}
.xl28
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt dotted windowtext;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dotted windowtext;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dotted windowtext;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dotted windowtext;}
.xl33
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
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
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=805 style='border-collapse:
 collapse;table-layout:fixed;width:605pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=150 style='mso-width-source:userset;mso-width-alt:5485;width:113pt'>
 <col width=120 style='mso-width-source:userset;mso-width-alt:4388;width:90pt'>
 <col width=140 style='mso-width-source:userset;mso-width-alt:5120;width:105pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=120 style='mso-width-source:userset;mso-width-alt:4388;width:90pt'>
 <col width=140 style='mso-width-source:userset;mso-width-alt:5120;width:105pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <%
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpdp00120", _style_pk);  
     
    for (int i = 0; i < dt.Rows.Count; i++)
    { 
 %>      
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=9 height=40 class=xl41 width=805 style='height:30.0pt;width:605pt'><%=dt.Rows[i]["style_name"]%></td>
 </tr>
 <%
    }
 %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl33 style='height:18.75pt;border-top:none'>Seq</td>
  <td class=xl34 style='border-top:none;border-left:none'>Work Process</td>
  <td class=xl36 style='border-top:none'>Picture</td>
  <td class=xl34 style='border-top:none;border-left:none'>In Component</td>
  <td class=xl34 style='border-top:none;border-left:none'>Qty</td>
  <td class=xl34 style='border-top:none;border-left:none'>Picture</td>
  <td class=xl34 style='border-top:none;border-left:none'>Out Component</td>
  <td class=xl34 style='border-top:none;border-left:none'>Qty</td>
  <td class=xl35 style='border-top:none;border-left:none'>Req Qty</td>
 </tr>
 <%
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpdp00120_1", _style_pk);

    string wprocess_01 = "";
    string wprocess_02 = ""; 
     
    for (int i = 0; i < dt.Rows.Count; i++)
    { 
 %>  
 <tr height=100 style='mso-height-source:userset;height:75.0pt'> 
 <%   
     if (wprocess_01 != dt.Rows[i]["wprocess"].ToString())
     {
         wprocess_01 = dt.Rows[i]["wprocess"].ToString();
 %>    
  <td height=100 class=xl40 style='height:75.0pt;border-top:none' x:num><%=dt.Rows[i]["seq"].ToString()%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt.Rows[i]["wprocess"].ToString()%></td>
 <% 
     }
     else
     {
 %> 
  <td height=100 class=xl40 style='height:75.0pt;border-top:none' x:num></td>
  <td class=xl39 style='border-top:none;border-left:none'></td>
 <%
     }
 %>
  <td height=100 class=xl37 width=120 style='height:75.0pt;border-top:none;
  width:90pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
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
   margin-left:1.5pt;margin-top:1.5pt;width:87.75pt;height:72.75pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["in_com_picture"].ToString()%>&table_name=TES_LGPICTURE" o:title="Water lilies"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=2 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=117 height=97 src="rpt_fpdp00120_files/image002.jpg" v:shapes="_x0000_s1025"></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:90.0pt;height:75.0pt'></span><![endif]--></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i]["in_comp_name"].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["in_qty"].ToString()%></td>
 
 <%   
     if ( wprocess_02 != dt.Rows[i]["wprocess"].ToString() )
     {
         wprocess_02 = dt.Rows[i]["wprocess"].ToString();
 %> 
 
  <td height=100 class=xl29 width=120 style='height:75.0pt;border-top:none;
  border-left:none;width:90pt'><!--[if gte vml 1]><v:shape id="_x0000_s1026"
   type="#_x0000_t75" style='position:absolute;margin-left:1.5pt;margin-top:1.5pt;
   width:87.75pt;height:72.75pt;z-index:2'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["out_com_picture"].ToString()%>&table_name=TES_LGPICTURE" o:title="Sunset"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=2 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=117 height=97 src="rpt_fpdp00120_files/image004.jpg" v:shapes="_x0000_s1026"></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:90.0pt;height:75.0pt'></span><![endif]--></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i]["out_comp_name"].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["out_qty"].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["req_qty"].ToString()%></td>
 <% 
     }
     else
     {
 %>  
   <td height=100 class=xl29 width=120 style='height:75.0pt;border-top:none;
  border-left:none;width:90pt'></td>
   <td class=xl30 style='border-top:none;border-left:none'></td>
   <td class=xl30 style='border-top:none;border-left:none' x:num></td> 
   <td class=xl32 style='border-top:none;border-left:none' x:num></td>
 <%
     }
 %>  
 </tr>
 <%
    }
 %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>  
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=150 style='width:113pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=50 style='width:38pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
