<%@ Page Language="C#"%>
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
    dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00110_1_AMB", "'" + po_pk + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00110_AMB_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00110_AMB_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00110_AMB_files/oledata.mso">
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
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2010-05-19T01:57:11Z</o:LastPrinted>
  <o:Created>2009-11-06T18:13:27Z</o:Created>
  <o:LastSaved>2010-05-19T01:58:43Z</o:LastSaved>
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	text-align:left;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	text-align:right;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl40
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
.xl41
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl43
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl44
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
.xl45
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
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
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
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
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
.xl54
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
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl57
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl63
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
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
        font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
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
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
       <x:RangeSelection>$B$11:$C$11</x:RangeSelection>
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
 <o:shapedefaults v:ext="edit" spidmax="3073" fillcolor="none [9]">
  <v:fill color="none [9]"/>
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="2"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=834 style='border-collapse:
 collapse;table-layout:fixed;width:627pt'>
 <col width=20 style='mso-width-source:userset;mso-width-alt:731;width:15pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=147 style='mso-width-source:userset;mso-width-alt:5376;width:110pt'>
 <col width=64 style='width:48pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=130 style='mso-width-source:userset;mso-width-alt:4754;width:98pt'>
 <col width=64 span=3 style='width:48pt'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 rowspan=2 height=34 class=xl43 width=642 style='height:25.5pt;
  width:483pt'>PURCHASE ORDER</td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 style='height:19.5pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s2049" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:3.75pt;width:97.5pt;height:97.5pt;z-index:1'>
   <v:imagedata src="rpt_epbp00110_AMB_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![if gte mso 9]><o:OLEObject Type="Embed" ProgID="PBrush"
   ShapeID="_x0000_s2049" DrawAspect="Content" ObjectID="MBD0015C850">
  </o:OLEObject>
 <![endif]><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:0px;margin-top:5px;width:130px;height:130px'><img
  width=130 height=130 src="rpt_epbp00110_AMB_files/image002.jpg" v:shapes="_x0000_s2049"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl31 width=20 style='height:19.5pt;width:15pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl31></td>
  <td class=xl39></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl62>Date : <%=dt.Rows[0]["po_date"]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=5 class=xl31 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl63>No : <%=dt.Rows[0]["po_no"]%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td colspan=2 rowspan=5 height=103 class=xl56 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:77.25pt'>Managed by watertree</td>
  <td colspan=5 class=xl44 style='border-right:.5pt solid black;border-left:
  .5pt solid black'>Vendor Name : <%=dt.Rows[0]["partner_name"]%></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl50 style='border-right:.5pt solid black;
  height:12.75pt;border-left:.5pt solid black'>Address : <%=dt.Rows[0]["addr1"]%></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl64 style='border-right:.5pt solid black;
  height:12.75pt;border-left:.5pt solid black'>Telephone : <%=dt.Rows[0]["phone_no"]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl40 colspan=3 style='height:19.5pt;mso-ignore:colspan'>Delivery Date : <%=dt.Rows[0]["delivery_dt"]%></td>
  <td colspan=2 class=xl60>PR Ref No : <%=dt.Rows[0]["ref_po_no"]%></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=5 height=26 class=xl60 style='height:19.5pt;border-left:.5pt solid black'>Expiry
  Date of this Purchase Order: <%=dt.Rows[0]["expiry_dt"]%></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=30 style='height:22.5pt'>
  <td height=30 class=xl29 style='height:22.5pt;border-top:none'>No.</td>
  <td class=xl34 style='border-top:none;border-left:none'>Item Description</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Quantity</td>
  <td class=xl35 width=73 style='border-top:none;border-left:none;width:55pt'>Unit
  of Measure</td>
  <td class=xl29 style='border-top:none;border-left:none'>Unit Price</td>
  <td class=xl29 style='border-top:none;border-left:none'>Amount VND</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     double sub_total = 0;
     double vat = 0;
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         sub_total = sub_total + CommondLib.ConvertToDbl(dt1.Rows[i]["po_amt"].ToString());
         vat = vat + CommondLib.ConvertToDbl(dt1.Rows[i]["vat_amount"].ToString());
            %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl65 style='height:19.5pt;border-top:none'><%=i+1 %></td>
  <td colspan=2 class=xl61 style='border-left:none'><%=dt1.Rows[i]["po_item_name"]%></td>
  <td class=xl33 style='border-top:none;border-left:none'x:num><%=dt1.Rows[i]["po_qty_01"]%></td>
  <td class=xl65 style='border-top:none;border-left:none'><%=dt1.Rows[i]["po_uom_01"]%></td>
  <td class=xl33 style='border-top:none;border-left:none'x:num><%=dt1.Rows[i]["unit_price"]%></td>
  <td class=xl33 style='border-top:none;border-left:none'x:num><%=dt1.Rows[i]["po_amt"]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
            <% 
     }
     
     double total = sub_total + vat;
      %>
 <%
     for(int k=0;k<15-dt1.Rows.Count;k++)
         %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl33 style='height:19.5pt;border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl61 style='border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
         <%
      %>

 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=5 rowspan=3 height=76 class=xl44 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:57.0pt'>Remark: <%=dt.Rows[0]["description"] %></td>
  <td class=xl30 style='border-top:none;border-left:none'>Sub-total</td>
  <td class=xl33 style='border-top:none;border-left:none'x:num><%=sub_total %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl30 style='height:19.5pt;border-top:none;border-left:
  none'>VAT</td>
  <td class=xl33 style='border-top:none;border-left:none'x:num><%=vat %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl30 style='height:18.0pt;border-top:none;border-left:
  none'>Total Amount</td>
  <td class=xl33 style='border-top:none;border-left:none'x:num><%=total %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 colspan=3 style='height:12.75pt;mso-ignore:colspan'>Authorized
  and Approved by:</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=7 rowspan=4 height=68 class=xl66 style='height:51.0pt'>Department
  Head &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Purchasing Supervisor &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chief Accountant 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial Controller&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;General Manager</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl32 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl42 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Terms
  &amp; Conditions:</td>
  <td colspan=4 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 class=xl26 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Delivery:</td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 align=right style='height:12.75pt' x:num>1</td>
  <td colspan=6 class=xl37>Delivery must be to the Receiving Office of Song Gia
  Resort Complex, Thuy Nguyen, Haiphong</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 align=right style='height:12.75pt' x:num>2</td>
  <td colspan=6 class=xl37>Partial delivery is not allowed unless specified in
  the above remark column</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 align=right style='height:12.75pt' x:num>3</td>
  <td colspan=6 class=xl37
  x:str="Goods delivered must be as per the specifications of this Purchase Order. ">Goods
  delivered must be as per the specifications of this Purchase Order.<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl38 align=right style='height:22.5pt' x:num>4</td>
  <td colspan=6 class=xl55 width=622 style='width:468pt'>Song Gia Resort
  reserved the rights to reject any goods delivered before or after the above
  specified &quot;Deliver Date&quot; and/or when this Purchase Order has
  expired.</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 align=right style='height:12.75pt' x:num>5</td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'
  x:str="Telephone no. of Receiving Office is: ">Telephone no. of Receiving
  Office is:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Payment
  Term:</td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 align=right style='height:12.75pt' x:num>1</td>
  <td class=xl25 colspan=5 style='mso-ignore:colspan'>Payment term is 30 days
  from delivery unless specified in the above remark column.</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 class=xl26 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Billing
  Instruction:</td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=15 style='height:11.25pt'>
  <td height=15 class=xl25 align=right style='height:11.25pt' x:num>1</td>
  <td class=xl37 colspan=4 style='mso-ignore:colspan'>Song Gia Resort Complex
  is a trade name of HYUNDAI AMCO VINA Co., Ltd.</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=15 style='height:11.25pt'>
  <td height=15 class=xl25 align=right style='height:11.25pt' x:num>2</td>
  <td class=xl37 colspan=3 style='mso-ignore:colspan'>Invoice should be
  addressed to: HYUNDAI AMCO VINA Co., Ltd</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=15 style='height:11.25pt'>
  <td height=15 class=xl25 align=right style='height:11.25pt' x:num>3</td>
  <td class=xl37 colspan=6 style='mso-ignore:colspan'>Invoice and delivery note
  (if any) should be given to the Receiving Office together with the goods
  delivered</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl38 align=right style='height:22.5pt' x:num>4</td>
  <td colspan=6 class=xl55 width=622 style='width:468pt'>Invoice or Delivery
  Note for goods delivered to and received by the Receiving Office of Song Gia
  Resort Complex must bear the &quot;Receiving Stamp&quot; of Song Gia Resort
  Complex and the signature of the receiver.</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
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
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
