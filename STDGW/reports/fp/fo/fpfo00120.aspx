<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
    ESysLib.SetUser("prod");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = true;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string SQL, tpr_reqiqc_pk, tpr_reqiqcd_pk, isMaster ="";

    tpr_reqiqc_pk = Request.QueryString["tpr_reqiqc_pk"];
    tpr_reqiqcd_pk = Request.QueryString["tpr_reqiqcd_pk"];
    isMaster = Request.QueryString["isMaster"];

    if (isMaster != "1")   
    {
        if (tpr_reqiqcd_pk != "0")
            tpr_reqiqc_pk = "";
    }
    else
    {
        tpr_reqiqcd_pk = "0";
    }

    SQL =  "select t.* " + 
        " from   " +
        "( SELECT to_char(to_date(a.req_date,'YYYYMMDD'),'DD/MM') req_date, c.partner_name,   " +
        " sale.sf_get_dsbs00010_4 ('30', b.tco_item_pk) spec1, sale.sf_get_dsbs00010_3 (1, b.tco_item_pk) item_name,   " +
        " sale.sf_get_dsbs00010_4 ('10', b.tco_item_pk) spec2, f.lot_no, f.PO_NO,     " +
        " bc_03_qty actual_width, f.BC_06_QTY sticker_width, f.item_bc,    " +
        " f.bc_01_qty actual_length, f.bc_02_qty actual_weight, NULL defect, NULL t_remark,   " +
        " f.BC_04_QTY sticker_length, f.BC_05_QTY sticker_weight , b.pk, f.TPR_LOTNO_PK , " +
        "  h.TOTAL_LOT_QTY req_qty, h.TOTAL_WEIGHT weight_qty, nvl(h.lot_qty,1) roll_num " +
        " FROM prod.tpr_reqiqc a, prod.tpr_reqiqcd b, comm.tco_buspartner c,   " +
        " comm.tco_item d, prod.tpr_itembcm f , comm.tco_stitem g, prod.tpr_reqiqc_lot h    " +
        " WHERE a.del_if = 0 and f.del_if=0   " +
        " and d.TCO_STITEM_PK = g.pk(+) and g.del_if(+) =0   " +
        " AND b.del_if(+) = 0 AND c.del_if(+) = 0 AND d.del_if(+) = 0  " +
        " AND a.pk = b.tpr_reqiqc_pk(+) AND b.vendor_pk = c.pk(+)   " +
        " AND b.tco_item_pk = d.pk(+)  " +
        " and h.pk= f.REF_TABLE_PK  and b.pk = h.tpr_reqiqcd_pk " +
        " and f.REF_TABLE_NAME ='TPR_REQIQC_LOT'   " +
        " AND ( (a.pk = '" + tpr_reqiqc_pk + " ' and '" + tpr_reqiqcd_pk + "' = '0' ) or (b.pk = '" + tpr_reqiqcd_pk + "'))  " +
        " ) t " +
        " ORDER BY t.po_no,t.lot_no, t.item_name, t.item_bc  " ;

   
    DataTable dt = ESysLib.TableReadOpen(SQL);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpfo00120_files/filelist.xml">
<link rel=Edit-Time-Data href="fpfo00120_files/editdata.mso">
<link rel=OLE-Object-Data href="fpfo00120_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Le Huu Phuc</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2009-08-08T08:44:44Z</o:LastPrinted>
  <o:Created>2009-08-05T07:35:28Z</o:Created>
  <o:LastSaved>2009-08-08T08:47:11Z</o:LastSaved>
  <o:Company>COMPANY</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.32in .2in .46in .28in;
	mso-header-margin:.17in;
	mso-footer-margin:.32in;
	mso-page-orientation:landscape;}
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
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:right;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"0\.000";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:RangeSelection>$A$1:$P$1</x:RangeSelection>
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
  <x:WindowHeight>6660</x:WindowHeight>
  <x:WindowWidth>12960</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1272 style='border-collapse:
 collapse;table-layout:fixed;width:956pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=192 style='mso-width-source:userset;mso-width-alt:7021;width:144pt'>
 <col width=64 span=5 style='width:48pt'>
 <col class=xl60 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2230'>
 <col width=61 span=2 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:2230'>
 <col width=61 span=2 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col width=64 style='width:48pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=16 height=40 width=1140 style='height:30.0pt;width:857pt'
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
   margin-left:258pt;margin-top:2.25pt;width:18.75pt;height:19.5pt;z-index:1'>
   <v:imagedata src="fpfo00120_files/image001.png" o:title="New Image"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:344px;margin-top:3px;width:25px;
  height:26px'><img width=25 height=26 src="fpfo00120_files/image002.gif"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=16 height=40 class=xl50 width=1140 style='height:30.0pt;
    width:857pt'>MATERIAL INPUT &amp; INSPECTION</td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl24 width=68 style='width:51pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=35 class=xl51 style='border-bottom:1.0pt solid black;
  height:26.25pt;border-top:none'>No</td>
  <td rowspan=2 class=xl53 style='border-bottom:1.0pt solid black;border-top:       
  none'>Date</td>
  <td rowspan=2 class=xl53 style='border-bottom:1.0pt solid black;border-top:
  none'>Buyer</td>
  <td rowspan=2 class=xl53 style='border-bottom:1.0pt solid black;border-top:
  none'>Contents</td>
  <td rowspan=2 class=xl53 style='border-bottom:1.0pt solid black;border-top:
  none'>Dimension</td>
  <td rowspan=2 class=xl53 style='border-bottom:1.0pt solid black;border-top:
  none'>Color</td>
  <td rowspan=2 class=xl53 style='border-bottom:1.0pt solid black;border-top:
  none'>Lot No</td>
  <td rowspan=2 class=xl53 style='border-bottom:1.0pt solid black;border-top:
  none'>PO No</td>
  <td rowspan=2 class=xl53 style='border-bottom:1.0pt solid black;border-top:
  none'>Roll No</td>
  <td rowspan=2 class=xl56 style='border-bottom:1.0pt solid black;border-top:
  none'>BC ID</td>
  <td colspan=3 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>Stiker Qty</td>
  <td colspan=3 class=xl45 style='border-right:.5pt solid black;border-left:
  none'>Actual Qty</td>
  <td rowspan=2 class=xl46 style='border-bottom:1.0pt solid black;border-top:
  none'>Defect</td>
  <td rowspan=2 class=xl48 style='border-bottom:1.0pt solid black;border-top:
  none'>Remark</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl25 style='height:13.5pt'>Width</td>
  <td class=xl25>Q'ty</td>
  <td class=xl25>Weight</td>
  <td class=xl25>Width</td>
  <td class=xl25>Q'ty</td>
  <td class=xl25>Weight</td>
 </tr>
  <%
        
    string lot_no ="", item_name="";
    int count =0,lot_num = 1, start_row=4;
    for (int i = 0; i < dt.Rows.Count; i++)
    {    
        if (lot_no != dt.Rows[i]["lot_no"].ToString() )
        {
%>
<%
    if (lot_no != "")
    {      
 %>
<tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl26 style='height:24.0pt'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl35>Total</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl35 x:num x:fmla="=SUM(L<%=start_row %>:L<%=dt.Rows.Count+start_row-1 %>)"></td>
  <td class=xl35 x:num x:fmla="=SUM(M<%=start_row %>:M<%=dt.Rows.Count+start_row-1 %>)"></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <%
     start_row = start_row + i;
    } %>
 <tr class=xl55 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl26 style='height:24.0pt' x:num><%=lot_num%></td>
  <td class=xl27><%=dt.Rows[i]["req_date"]%></td>
  <td class=xl28 width=74 style='width:56pt'><%=dt.Rows[i]["partner_name"]%></td>
  <td class=xl28 width=192 style='width:144pt'><%=dt.Rows[i]["item_name"]%></td>
  <td class=xl29><%=dt.Rows[i]["spec1"]%></td>
  <td class=xl33><%=dt.Rows[i]["spec2"]%></td>
  <td class=xl27><%=dt.Rows[i]["lot_no"]%></td>
  <td class=xl29><%=dt.Rows[i]["po_no"]%></td>
  <td class=xl27 x:num><%=count +1 %></td> 
  <td class=xl58><%=dt.Rows[i]["item_bc"]%></td>
  <td class=xl31 x:num><%=dt.Rows[i]["sticker_width"]%></td>
  <td class=xl31 x:num><%=dt.Rows[i]["sticker_length"]%></td>
  <td class=xl32 x:num><%=dt.Rows[i]["sticker_weight"]%></td>
  <td class=xl31 x:num><%=dt.Rows[i]["actual_width"]%></td>
  <td class=xl31 x:num><%=dt.Rows[i]["actual_length"]%></td>
  <td class=xl31 x:num><%=dt.Rows[i]["actual_weight"]%></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <% 
   lot_no = dt.Rows[i]["lot_no"].ToString();
   lot_num = lot_num + 1;
    }
    else
    {
%>
 <tr class=xl55 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl26 style='height:24.0pt'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl28 width=192 style='width:144pt'><%=dt.Rows[i]["item_name"]%></td>
  <td class=xl29><%=dt.Rows[i]["spec1"]%></td>
  <td class=xl33><%=dt.Rows[i]["spec2"]%></td>
  <td class=xl27><%=dt.Rows[i]["lot_no"]%></td>
  <td class=xl29><%=dt.Rows[i]["po_no"]%></td>
  <td class=xl27 x:num><%=count +1 %></td>
  <td class=xl58><%=dt.Rows[i]["item_bc"]%></td>
  <td class=xl31 x:num><%=dt.Rows[i]["sticker_width"]%></td>
  <td class=xl31 x:num><%=dt.Rows[i]["sticker_length"]%></td>
  <td class=xl32 x:num><%=dt.Rows[i]["sticker_weight"]%></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl31></td>
  <td class=xl33></td>
  <td class=xl34></td>
 </tr>
 <%
     }
    // count = count + 1;
    //if (count == Convert.ToInt32(dt.Rows[i]["roll_num"]))
    //{
    //    count = 0; 
%>
<!--
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl26 style='height:24.0pt'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl35>Total</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl35 x:num><%=dt.Rows[i]["req_qty"]%></td>
  <td class=xl35 x:num><%=dt.Rows[i]["weight_qty"]%></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 -->
 <%
      //}
      
//    }
  } 
%>
<tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl26 style='height:24.0pt'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl35>Total</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl35 x:num x:fmla="=SUM(L<%=start_row %>:L<%=dt.Rows.Count+start_row-1 %>)"></td>
  <td class=xl35 x:num x:fmla="=SUM(M<%=start_row %>:M<%=dt.Rows.Count+start_row-1 %>)"></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl36 style='height:24.0pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=192 style='width:144pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=68 style='width:51pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
