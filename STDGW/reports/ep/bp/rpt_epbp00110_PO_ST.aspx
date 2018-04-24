<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00110_standard_po");
	string p_po_pk	=	Request.QueryString["p_po_pk"];
    dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00110_1_standard_po", "'" + p_po_pk + "'");
    dt2 = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00110_2_standard_po", "'" + p_po_pk + "'");
    
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00110_PO_ST_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00110_PO_ST_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00110_PO_ST_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>BK</o:LastAuthor>
  <o:LastPrinted>2011-12-19T08:49:10Z</o:LastPrinted>
  <o:LastSaved>2011-12-19T08:49:22Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.72in .37in .69in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl24
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-style:italic;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-style:italic;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>rpt_epbp00110_PO_ST</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>94</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8895</x:WindowHeight>
  <x:WindowWidth>14940</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>300</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=716 style='border-collapse:
 collapse;table-layout:fixed;width:538pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=164 style='mso-width-source:userset;mso-width-alt:5997;
 width:123pt'>
 <col class=xl24 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <tr class=xl25 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=8 height=28 width=716 style='height:21.0pt;width:538pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
   margin-left:0;margin-top:8.25pt;width:1in;height:40.5pt;z-index:1' filled="t"
   fillcolor="white [9]">
   <v:imagedata src="rpt_epbp00110_PO_ST_files/rpt_epbp00110_PO_ST_11149_image001.jpg"
    o:title="Logo-mr chau" cropbottom="37277f" cropright="33128f"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:Locked>False</x:Locked>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:11px;width:96px;
  height:54px'><img width=96 height=54
  src="rpt_epbp00110_PO_ST_files/image002.gif" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=8 height=28 class=xl42 width=716 style='height:21.0pt;
    width:538pt'>BK VINA CO., LTD</td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl24 style='height:14.25pt'>LOT A-5C-CN, MY
  PHUOC 3 I.P., BEN CAT DIST., BINH DUONG PROVINCE, VIETNAM</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl43 style='height:14.25pt'>TEL:
  84-650-559825<span style='mso-spacerun:yes'>     </span>FAX:
  84-650-559831<span style='mso-spacerun:yes'>     </span>TAX CODE: 3700798566</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=8 height=40 class=xl44 style='height:30.0pt'>PURCHASE ORDER</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 >NO. :<span
  style='mso-spacerun:yes'> </span><%=dt1.Rows[0]["po_no"] %></td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 >DATE :<span
  style='mso-spacerun:yes'> </span><%=dt1.Rows[0]["po_date"] %></td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 >PURCHASER :<span
  style='mso-spacerun:yes'> </span><%=dt1.Rows[0]["buy_rep"]%></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl27 colspan=2 style='height:14.25pt;mso-ignore:colspan'
  >Messrs:<span style='mso-spacerun:yes'>   </span><font class="font5"><%=dt1.Rows[0]["partner_name"]%></font></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'><%=dt1.Rows[0]["addr1"]%></td>
  <td colspan=7 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl26 colspan=2 style='height:14.25pt;mso-ignore:colspan'>Tel
  : <%=dt1.Rows[0]["phone_no"]%><span style='mso-spacerun:yes'>       </span>Fax:<%=dt1.Rows[0]["fax_no"]%></td>
  <td colspan=6 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=7 height=19 class=xl45 style='height:14.25pt'>We've the pleasure
  of placing the following orders with you on the terms and conditions stated
  below:</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td rowspan=2 height=44 class=xl46 style='border-bottom:.5pt solid black;
  height:33.8pt;border-top:none'>No.</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black;border-top:
  none'>Description</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black;border-top:
  none'>Specification</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black;border-top:
  none'>Packing</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black;border-top:
  none'>Unit</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black;border-top:
  none'>Quantity</td>
  <td class=xl29 width=94 style='width:71pt'>Unit Price</td>
  <td class=xl30 width=99 style='width:74pt'>Amount</td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl31 width=94 style='height:16.9pt;width:71pt'>(<%=dt1.Rows[0]["po_ccy"] %>)</td>
  <td class=xl31 width=99 style='width:74pt'>(<%=dt1.Rows[0]["po_ccy"] %>)</td>
 </tr>
 <%
     double total = 0, total1 = 0;
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
         total = total + CommondLib.ConvertToDbl(dt2.Rows[i]["po_qty_01"]);
         total1 = total1 + CommondLib.ConvertToDbl(dt2.Rows[i]["po_amt"]);
        %>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl32 style='height:14.25pt' x:num><%=i + 1%></td>
  <td class=xl33><%=dt2.Rows[i]["po_item_code"]%>-<%=dt2.Rows[i]["po_item_name"]%></td>
  <td class=xl34><%=dt2.Rows[i]["po_item_name_2"]%></td>
  <td class=xl34><%=dt2.Rows[i]["po_item_name_3"]%></td>
  <td class=xl24><%=dt2.Rows[i]["po_uom_01"]%></td>
  <td class=xl35 x:num><%=dt2.Rows[i]["po_qty_01"]%></td>
  <td class=xl35 x:num><%=dt2.Rows[i]["unit_price"]%></td>
  <td class=xl36 x:num><%=dt2.Rows[i]["po_amt"]%></td>
 </tr>
 <%
     }
     string str = CommondLib.Num2EngText(total1.ToString(), dt1.Rows[0]["po_ccy"].ToString());
  %>
  <%
      for (int j = 12; j - dt2.Rows.Count > 0; j--)
      {
          %>
<tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl32 style='height:14.25pt' ></td>
  <td class=xl33></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl24></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl36></td>
 </tr>
          <% 
      }
       %>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=4 height=21 class=xl48 style='border-right:.5pt solid black;
  height:15.75pt'>Total</td>
  <td class=xl37></td>
  <td class=xl38 x:num><%=total%></td>
  <td class=xl38></td>
  <td class=xl39 x:num><%=total1 %></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=8 height=20 class=xl51 style='height:15.0pt'>Say Total:<%=str %></td>
 </tr>
 <% 
     if (dt1.Rows[0]["description"].ToString() != "")
    {
     %>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=5 height=21 class=xl52 style='height:15.75pt'>(<%=dt1.Rows[0]["description"]%>)</td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <%    
    } 
     %>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl26 style='height:14.25pt'>1. QUALITY:<%=dt1.Rows[0]["po_type1"]%></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl26 style='height:14.25pt'>2. DELIVERY TERMS:<%=dt1.Rows[0]["price_type1"]%></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl26 style='height:14.25pt'>3. SHIP BY:<%=dt1.Rows[0]["deli_type"]%></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl26 style='height:14.25pt'>4. PLACE OF
  DELIVERY: AT BK VINA CO.LTD ' S WAREHOUSE</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl26 style='height:14.25pt'>5. TIME OF
  DELIVERY:<%=dt1.Rows[0]["etd_to"]%></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl26 style='height:14.25pt'>6. TRANSHIPMENT:
  N/M</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl26 style='height:14.25pt'>7. PARTIAL
  SHIPMENT: PROHIBITED</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl26 style='height:14.25pt'>8. PAYMENT TERMS:
  T/T AFTER 30 DAYS</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl40 style='height:14.25pt'>Please notify us
  immediately if this order</td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26>We accept to sell the above goods</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl40 style='height:14.25pt'>can not be shipped
  complete on or before</td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26>with the specifications, prices and</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=5 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26>delivery time as this order.</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=3 height=19 class=xl40 style='height:14.25pt'>For and on behalf
  of THE BUYER</td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26>For and on behalf of THE SELLER</td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl52 style='height:15.75pt'>BK VINA CO., LTD</td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl28><%=dt1.Rows[0]["partner_name"]%></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl52 style='height:15.75pt'>LEE SOON SUB (MR.)</td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=3 class=xl27>Please sign, chop and fax back to</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=2 height=19 class=xl40 style='height:14.25pt'>General Director</td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=3 class=xl27>BK VINA Co., Ltd.</td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=8 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=7 class=xl40 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl40><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=164 style='width:123pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=99 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
