﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("prod");%>
<% 	
	Response.ContentType = "application/vnd.ms-excel"; 
	Response.Charset = "utf-8";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string po_pk;
	po_pk	=	Request.QueryString["txtMasterPK"];
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00110_AMB", "'" + po_pk + "'");
    dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00110_2_AMB", "'" + po_pk + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00110_AMB_2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00110_AMB_2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00110_AMB_2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>user</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2010-05-19T01:57:11Z</o:LastPrinted>
  <o:Created>2009-11-06T18:13:27Z</o:Created>
  <o:LastSaved>2010-12-08T02:22:32Z</o:LastSaved>
  <o:Company>def</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .25in .75in;
	mso-header-margin:0in;
	mso-footer-margin:0in;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
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
	text-align:left;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl46
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PO</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11640</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2051" fillcolor="none [9]">
  <v:fill color="none [9]"/>
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="2"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=770 style='border-collapse:
 collapse;table-layout:fixed;width:579pt'>
 <col width=20 style='mso-width-source:userset;mso-width-alt:731;width:15pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=147 style='mso-width-source:userset;mso-width-alt:5376;width:110pt'>
 <col width=64 style='width:48pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=130 style='mso-width-source:userset;mso-width-alt:4754;width:98pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 rowspan=2 height=34 class=xl42 width=642 style='height:25.5pt;
  width:483pt'>PURCHASE ORDER</td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 width=20 style='height:19.5pt;width:15pt'><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s2050" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:2.25pt;margin-top:1.5pt;width:93.75pt;
   height:103.5pt;z-index:1'>
   <v:imagedata src="rpt_epbp00110_AMB_2_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43>Date: <%=dt.Rows[0]["po_date"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=5 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl44 x:str="No: ">No: <%=dt.Rows[0]["po_no"]%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td colspan=2 rowspan=5 height=103 class=xl45 style='border-bottom:.5pt solid black;
  height:77.25pt'>Managed by watertree</td>
  <td colspan=5 class=xl47 style='border-right:.5pt solid black'>Vendor Name: <%=dt.Rows[0]["partner_name"]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl49 style='border-right:.5pt solid black;
  height:12.75pt'>Address: <%=dt.Rows[0]["addr1"]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl51 style='border-right:.5pt solid black;
  height:12.75pt'><span
  style='mso-spacerun:yes'>                                                                                               
  </span>Telephone: <%=dt.Rows[0]["phone_no"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 colspan=3 style='height:19.5pt;mso-ignore:colspan'
  x:str="Delivery Date:                                                             ">Delivery
  Date: <%=dt.Rows[0]["delivery_dt"]%><span
  style='mso-spacerun:yes'>                                                             </span></td>
  <td colspan=2 class=xl28 style='border-right:.5pt solid black'>PR Ref No: <%=dt.Rows[0]["ref_po_no"]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=5 height=26 class=xl29 style='border-right:.5pt solid black;
  height:19.5pt'>Expiry Date of this Purchase Order: <%=dt.Rows[0]["expiry_dt"]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=30 style='height:22.5pt'>
  <td height=30 class=xl31 style='height:22.5pt'>No.</td>
  <td class=xl32>Item Description</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>Quantity</td>
  <td class=xl34 width=73 style='width:55pt'>Unit of Measure</td>
  <td class=xl33>Unit Price</td>
  <td class=xl33>Amount VND</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
  <%
     double sub_total = 0;
     double vat = 0;
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         sub_total = sub_total + CommondLib.ConvertToDbl(dt1.Rows[i]["po_amt"].ToString());
         vat = vat + CommondLib.ConvertToDbl(dt1.Rows[i]["vat_amount"].ToString());
            %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl61 style='height:24.0pt' x:num><%=i+1 %></td>
  <td colspan=2 class=xl64 width=257 style='border-right:.5pt solid black;
  border-left:none;width:193pt'><%=dt1.Rows[i]["po_item_name"]%><font class="font0"><br>
    </font><font class="font12"><%=dt1.Rows[i]["po_item_lname"]%></font></td>
  <td class=xl65 x:num><%=dt1.Rows[i]["po_qty_01"]%></td>
  <td class=xl65><%=dt1.Rows[i]["po_uom_01"]%></td>
  <td class=xl66 x:num><%=dt1.Rows[i]["unit_price"]%></td>
  <td class=xl63 align=right x:num><%=dt1.Rows[i]["po_amt"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
  <% 
     }
     
     double total = sub_total + vat;
      %>
 <%
     for(int k=0;k<15-dt1.Rows.Count;k++)
         %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl61 style='height:24.0pt' x:num></td>
  <td colspan=2 class=xl64 width=257 style='border-right:.5pt solid black;
  border-left:none;width:193pt'><font class="font0"><br>
    </font><font class="font12"></font></td>
  <td class=xl65 x:num></td>
  <td class=xl65></td>
  <td class=xl66 x:num></td>
  <td class=xl63 align=right x:num></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
         <%
      %>

 <tr class=xl35 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=5 rowspan=3 height=76 class=xl54 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:57.0pt'>Remark: <%=dt.Rows[0]["description"] %></td>
  <td class=xl36 align=left>Sub-total</td>
  <td class=xl63 align=right x:num><%=sub_total %></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl35 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl36 align=left style='height:19.5pt'>VAT</td>
  <td class=xl62 align=right x:num><%=vat %></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl36 align=left style='height:18.0pt'>Total Amount</td>
  <td class=xl63 align=right x:num><%=total %></td>
  <td class=xl35></td>
  <td class=xl40></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 colspan=3 align=left style='height:12.75pt;
  mso-ignore:colspan'>Authorized and Approved by:</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 rowspan=4 height=68 class=xl38 style='height:51.0pt'>Department
  Head</td>
  <td rowspan=4 class=xl38>Purchasing Manager</td>
  <td colspan=2 rowspan=4 class=xl38>Controller</td>
  <td colspan=2 rowspan=4 class=xl38>General Manager</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl38 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl39 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Terms
  &amp; Conditions:</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=15 style='height:11.25pt'>
  <td height=15 class=xl25 colspan=2 align=left style='height:11.25pt;
  mso-ignore:colspan'>Delivery:</td>
  <td colspan=7 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 align=right style='height:12.75pt' x:num>1</td>
  <td colspan=6 class=xl40>Delivery must be to the Receiving Office of Song Gia
  Resort Complex, Thuy Nguyen, Haiphong</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 align=right style='height:12.75pt' x:num>2</td>
  <td colspan=6 class=xl40>Partial delivery is not allowed unless specified in
  the above remark column</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 align=right style='height:12.75pt' x:num>3</td>
  <td colspan=6 class=xl40
  x:str="Goods delivered must be as per the specifications of this Purchase Order. ">Goods
  delivered must be as per the specifications of this Purchase Order.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl41 align=right style='height:22.5pt' x:num>4</td>
  <td colspan=6 class=xl59 width=622 style='width:468pt'>Song Gia Resort
  reserved the rights to reject any goods delivered before or after the above
  specified &quot;Deliver Date&quot; and/or when this Purchase Order has
  expired.</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 align=right style='height:12.75pt' x:num>5</td>
  <td class=xl35 colspan=2 align=left style='mso-ignore:colspan'
  x:str="Telephone no. of Receiving Office is: ">Telephone no. of Receiving
  Office is:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 colspan=2 align=left style='height:12.75pt;
  mso-ignore:colspan'>Payment Term:</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 align=right style='height:12.75pt' x:num>1</td>
  <td class=xl35 colspan=5 align=left style='mso-ignore:colspan'>Payment term
  is 30 days from delivery unless specified in the above remark column.</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=15 style='height:11.25pt'>
  <td height=15 class=xl25 colspan=2 align=left style='height:11.25pt;
  mso-ignore:colspan'>Billing Instruction:</td>
  <td colspan=7 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=15 style='height:11.25pt'>
  <td height=15 class=xl35 align=right style='height:11.25pt' x:num>1</td>
  <td class=xl40 colspan=4 style='mso-ignore:colspan'>Song Gia Resort Complex
  is a trade name of AMCO-MIBAEK VINA CO., LTD.</td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=15 style='height:11.25pt'>
  <td height=15 class=xl35 align=right style='height:11.25pt' x:num>2</td>
  <td class=xl40 colspan=3 style='mso-ignore:colspan'>Invoice should be
  addressed to: AMCO-MIBAEK VINA CO., LTD</td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=15 style='height:11.25pt'>
  <td height=15 class=xl35 align=right style='height:11.25pt' x:num>3</td>
  <td class=xl40 colspan=6 style='mso-ignore:colspan'>Invoice and delivery note
  (if any) should be given to the Receiving Office together with the goods
  delivered</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl41 align=right style='height:22.5pt' x:num>4</td>
  <td colspan=6 class=xl59 width=622 style='width:468pt'>Invoice or Delivery
  Note for goods delivered to and received by the Receiving Office of Song Gia
  Resort Complex must bear the &quot;Receiving Stamp&quot; of Song Gia Resort
  Complex and the signature of the receiver.</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=20 style='width:15pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=147 style='width:110pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
