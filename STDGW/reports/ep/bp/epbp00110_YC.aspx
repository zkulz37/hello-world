<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
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
    DataTable dt_mst, dt_dtl;
    string l_po_pk = "";
    l_po_pk = Request["PO_PK"];

    dt_mst = ESysLib.TableReadOpenCursor("PROD.SP_RPT_EPBP00110_YC", l_po_pk);
    dt_dtl = ESysLib.TableReadOpenCursor("PROD.SP_RPT_EPBP00110_YC_1", l_po_pk);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="epbp00110_YC_files/filelist.xml">
<link rel=Edit-Time-Data href="epbp00110_YC_files/editdata.mso">
<link rel=OLE-Object-Data href="epbp00110_YC_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HRSV1</o:Author>
  <o:LastAuthor>HRSV1</o:LastAuthor>
  <o:LastPrinted>2009-11-24T05:40:48Z</o:LastPrinted>
  <o:Created>2009-11-24T02:11:17Z</o:Created>
  <o:LastSaved>2009-11-24T05:41:08Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.62in .16in 1.0in .42in;
	mso-header-margin:.51in;
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
.xl24
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl37
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	color:red;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:left;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
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
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=902 style='border-collapse:
 collapse;table-layout:fixed;width:677pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=5 rowspan=2 height=64 width=406 style='height:48.0pt;width:305pt'
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
   margin-left:1.5pt;margin-top:1.5pt;width:281.25pt;height:47.25pt;z-index:1'>
   <v:imagedata src="epbp00110_YC_files/image001.png" o:title="image002"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:2px;margin-top:2px;width:375px;
  height:63px'><img width=375 height=63 src="epbp00110_YC_files/image002.gif"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=5 rowspan=2 height=64 class=xl34 width=406 style='height:48.0pt;
    width:305pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl35 width=496 style='width:372pt'>CÔNG TY C&#7892;
  PH&#7846;N NH&#7920;A YOULCHON VINA</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=6 height=29 class=xl33 style='height:21.75pt'>LÔ K-3-CN , Khu
  công nghi&#7879;p M&#7929; Ph&#432;&#7899;c 2 Huy&#7879;n B&#7871;n Cát Bình
  D&#432;&#417;ng</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=5 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl33>&#272;T : 0650-3556017- Fax :0650-3556018</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=5 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl33>MST : 3700810887 - Nhân viên ph&#7909; trách<span
  style='mso-spacerun:yes'>  </span>Mr.Cang : 0903 931 292</td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=11 height=34 class=xl36 style='height:25.5pt'>PURCHASE ORDER</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=3 style='height:20.25pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl38>(CONTRACT NO : <%= dt_mst.Rows[0]["CONTRACT_NO"].ToString() %> )</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl39 style='height:16.5pt'>PO NO</td>
  <td colspan=3 class=xl24 style='border-left:none'><%=dt_mst.Rows[0]["po_no"].ToString()%></td>
  <td class=xl25 style='border-left:none'>PO DATE</td>
  <td colspan=5 class=xl40 style='border-left:none' x:num><%=dt_mst.Rows[0]["po_date"].ToString()%></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 height=23 class=xl39 style='height:17.25pt'>SUPPLIER</td>
  <td colspan=3 class=xl24 style='border-left:none'><%=dt_mst.Rows[0]["supplier"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'>ETD</td>
  <td colspan=5 class=xl40 style='border-left:none' x:num><%=dt_mst.Rows[0]["etd_from"].ToString()%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl39 style='height:18.0pt'>SHIP TO</td>
  <td colspan=3 class=xl24 style='border-left:none'><%=dt_mst.Rows[0]["ship_to"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'>CHARGER</td>
  <td colspan=5 class=xl24 style='border-left:none'><%=dt_mst.Rows[0]["charger_name"].ToString()%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=11 class=xl26 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td rowspan=2 height=47 class=xl41 style='height:35.25pt'>SEQ</td>
  <td colspan=5 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>Item</td>
  <td rowspan=2 class=xl41>Qty</td>
  <td rowspan=2 class=xl41>U/P</td>
  <td rowspan=2 class=xl41>UNIT</td>
  <td rowspan=2 class=xl41>Amount</td>
  <td rowspan=2 class=xl41>Remark</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl42 style='border-right:.5pt solid black;
  height:15.75pt;border-left:none'>Name</td>
  <td colspan=2 class=xl47 style='border-left:none'>Spec</td>
 </tr>
 <% 
     int row = 0;
     if (dt_dtl.Rows.Count > 0)
     {
         for (int i = 0; i < dt_dtl.Rows.Count; i++)
         {
             row++;
 %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl27 style='height:20.25pt;border-top:none' x:num><%=row%></td>
  <td colspan=3 class=xl24 style='border-left:none'><%=dt_dtl.Rows[i]["item_name"].ToString()%></td>
  <td colspan=2 class=xl24 style='border-left:none'><%=dt_dtl.Rows[i]["item_spec"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt_dtl.Rows[i]["po_qty"].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt_dtl.Rows[i]["item_price"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt_dtl.Rows[i]["ITEM_UNIT"].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'x:num><%=dt_dtl.Rows[i]["po_amt"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none'><%=dt_dtl.Rows[i]["description"].ToString()%></td>
 </tr>
 <% 
        }
     }
 %>

 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl30 style='height:17.25pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none'>Total</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td  class=xl48 style='border-top:none'
  x:num><%=dt_mst.Rows[0]["po_amt"].ToString()%></td>
  <td class=xl31 style='border-right:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=11 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=2 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl26>Charger</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl26>Manager</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=83 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
