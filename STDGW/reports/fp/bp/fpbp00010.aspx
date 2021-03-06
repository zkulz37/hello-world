<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
  	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string wh_pk,group_pk, item_name, lot_yn;
    wh_pk = Request["wh_pk"];
    group_pk = Request["group_pk"];
    item_name = Request["item"];
    lot_yn = Request["lot"];
    string SQL ="";
    if (lot_yn=="N")
    {
    SQL	= "SELECT " + 

        "                               b.item_name " +
        "                                                                        st_nm, " +
        "                               b.standard_qty, " +
        "                                              c.item_name, c.uom, " +
        "                               prod.sf_get_fpbp00010_4 ('1', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_1, " +
        "                               prod.sf_get_fpbp00010_4 ('2', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_2, " +
        "                               prod.sf_get_fpbp00010_4 ('3', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_3, " +
        "                               prod.sf_get_fpbp00010_4 ('4', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_4, " +
        "                               prod.sf_get_fpbp00010_4 ('5', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_5, " +
        "                                " +
        "                               d.lot_no, a.end_bal stock_qty, " +
        "                               prod.sf_get_fpbp00010_5 " +
        "                                                      (a.tco_item_pk) " +
        "                                                                     cons_qty, " +
        "                               prod.sf_get_fpbp00010_6 " +
        "                                                   (a.tco_item_pk) " +
        "                                                                  takeout_qty, " +
	    "                               prod.sf_get_fpbp00010_7 (a.tco_item_pk) po_qty ,TCO_STITEMPHOTO_PK " +
        "                          FROM prod.vprod_currentstock a, " +
        "                               comm.tco_stitem b, " +
        "                               comm.tco_item c, " +
        "                               prod.tpr_lotno d, " +
        "                               comm.tco_itemgrp e " +
        "                         WHERE c.del_if = 0 " +
        "                           AND b.del_if(+) = 0 " +
        "                           AND d.del_if(+) = 0 " +
        "                           AND e.del_if = 0 " +
        "                           AND a.tco_item_pk = c.pk " +
        "                           AND c.tco_stitem_pk = b.pk(+) " +
        "                           AND a.tpr_lotno_pk = d.pk(+) " +
        "                           AND c.tco_itemgrp_pk = e.pk " +
        "                           AND (c.pur_yn LIKE 'Y' OR c.pur_yn IS NULL) " +
        "                           AND a.tin_warehouse_pk = " +
        "                                  DECODE ( '" + wh_pk +"'"+
        "                                         , 'ALL', a.tin_warehouse_pk, '" + wh_pk + "'"+
        "                                        ) " +
        "                           AND c.tco_itemgrp_pk = " +
        "                                  DECODE ('" + group_pk + "', " +
        "                                          'ALL', c.tco_itemgrp_pk, '" + group_pk +"'" +
        "                                         ) " +
        "                           AND (   c.item_code LIKE " +
        "                                                   '%' || UPPER ('"+item_name+"') " +
        "                                                   || '%' " +
        "                                OR c.item_name LIKE " +
        "                                                   '%' || UPPER ('"+item_name+"') " +
        "                                                   || '%' " +
        "                               ) " +
        "                      ORDER BY a.tin_warehouse_pk,c.tco_itemgrp_pk,b.item_name ,TCO_STITEMPHOTO_PK" ;

    }else
    {
       SQL	= " SELECT " + 
        "                                b.item_name " +
        "                                                                        st_nm, " +
        "                               b.standard_qty,                                         " +
        "                                              c.item_name, c.uom, " +
        "                               prod.sf_get_fpbp00010_4 ('1', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_1, " +
        "                               prod.sf_get_fpbp00010_4 ('2', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_2, " +
        "                               prod.sf_get_fpbp00010_4 ('3', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_3, " +
        "                               prod.sf_get_fpbp00010_4 ('4', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_4, " +
        "                               prod.sf_get_fpbp00010_4 ('5', " +
        "                                                        a.tco_item_pk " +
        "                                                       ) spec_5, null, " +
        "                               SUM (a.end_bal) stock_qty, " +
        "                               SUM " +
        "                                  (prod.sf_get_fpbp00010_5 (a.tco_item_pk) " +
        "                                  ) cons_qty, " +
        "                               SUM " +
        "                                  (prod.sf_get_fpbp00010_6 (a.tco_item_pk) " +
        "                                  ) takeout_qty, " +
        "                               SUM " +
        "                                  (prod.sf_get_fpbp00010_7 (a.tco_item_pk) " +
        "                                  ) po_qty ,b.TCO_STITEMPHOTO_PK" +
        "                          FROM prod.vprod_currentstock a, " +
        "                               comm.tco_stitem b, " +
        "                               comm.tco_item c, " +
        "                               comm.tco_itemgrp e " +
        "                         WHERE c.del_if = 0 " +
        "                           AND b.del_if(+) = 0 " +
        "                           AND e.del_if = 0 " +
        "                           AND a.tco_item_pk = c.pk " +
        "                           AND c.tco_stitem_pk = b.pk(+) " +
        "                           AND c.tco_itemgrp_pk = e.pk " +
        "                           AND (c.pur_yn LIKE 'Y' OR c.pur_yn IS NULL) " +
        "                           AND c.tco_itemgrp_pk = " +
        "                                  DECODE ('"+ group_pk + "', " +
        "                                          'ALL', c.tco_itemgrp_pk, " +
        "                                          '"+ group_pk + "'"+
        "                                         ) " +
        "                           AND (   c.item_code LIKE " +
        "                                                   '%' || UPPER ('"+item_name+"') " +
        "                                                   || '%' " +
        "                                OR c.item_name LIKE " +
        "                                                   '%' || UPPER ('"+item_name+"') " +
        "                                                   || '%' " +
        "                               ) " +
        "                      GROUP BY e.grp_nm, " +
        "                               b.item_name, " +
        "                               b.standard_qty, " +
        "                               c.item_name, " +
        "                               c.uom, " +
        "                               prod.sf_get_fpbp00010_4 ('1', a.tco_item_pk), " +
        "                               prod.sf_get_fpbp00010_4 ('2', a.tco_item_pk), " +
        "                               prod.sf_get_fpbp00010_4 ('3', a.tco_item_pk), " +
        "                               prod.sf_get_fpbp00010_4 ('4', a.tco_item_pk), " +
        "                               prod.sf_get_fpbp00010_4 ('5', a.tco_item_pk) ,TCO_STITEMPHOTO_PK " +
        "                      ORDER BY e.grp_nm, b.item_name ,TCO_STITEMPHOTO_PK" ;

    }
   //Response.Write(SQL);
   //Response.End();	
  DataTable dt = ESysLib.TableReadOpen(SQL);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=unicode">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpbp00010_files/filelist.xml">
<link rel=Edit-Time-Data href="fpbp00010_files/editdata.mso">
<link rel=OLE-Object-Data href="fpbp00010_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2008-11-17T03:32:10Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2008-11-17T03:34:53Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .5in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
.style17
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style16;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style16;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style17;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style16;
	color:blue;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style17;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:Fixed;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
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
     <x:StandardWidth>2340</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>58</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path>STOCK(HUNG) _03.11.2008.xls</x:Path>
  <x:SheetName>TOTAL(HQ)</x:SheetName>
  <x:SheetName>TOTAL(VN)</x:SheetName>
  <x:SheetName>CTON2</x:SheetName>
  <x:SheetName>cton3</x:SheetName>
  <x:SheetName>CARTON</x:SheetName>
  <x:SheetName>PEAK</x:SheetName>
  <x:SheetName>H-TAGCBCDPS</x:SheetName>
  <x:SheetName>H-TAG KB</x:SheetName>
  <x:SheetName>STICKER</x:SheetName>
  <x:SheetName>LAB CB</x:SheetName>
  <x:SheetName>LAB KB</x:SheetName>
  <x:SheetName>TOP BT</x:SheetName>
  <x:SheetName>PIT BULL</x:SheetName>
  <x:SheetName> PS</x:SheetName>
  <x:SheetName>LAB CD</x:SheetName>
  <x:SheetName>TIM</x:SheetName>
  <x:SheetName>METAL</x:SheetName>
  <x:SheetName>ZIPPER</x:SheetName>
  <x:SheetName>H-TAG-TP</x:SheetName>
  <x:SheetName>LAB-TP</x:SheetName>
  <x:SheetName>CTON</x:SheetName>
  <x:SheetName>POLY BAG</x:SheetName>
  <x:SheetName>THREAD</x:SheetName>
  <x:SheetName>VELCRO</x:SheetName>
  <x:SheetName>TAPE</x:SheetName>
  <x:SheetName>NON WOVEN</x:SheetName>
  <x:SheetName>STRING</x:SheetName>
  <x:SheetName>KS</x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>0</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>6</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>7</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>8</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>9</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>10</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>11</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>12</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>13</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>14</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>15</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>16</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>17</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>18</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>19</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>20</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>21</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>22</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>23</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>24</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>25</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>26</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>27</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1247 style='border-collapse:
 collapse;table-layout:fixed;width:934pt'>
 <col width=179 style='mso-width-source:userset;mso-width-alt:6546;width:134pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=128 span=5 style='mso-width-source:userset;mso-width-alt:3900;
 width:98pt'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=11 rowspan=2 height=34 class=xl25 width=1247 style='border-bottom:
  .5pt solid black;height:25.5pt;width:934pt'>SUB MATERIAL BALANCE</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr class=xl31 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td rowspan=2 height=34 class=xl27 width=179 style='height:25.5pt;border-top:
  none;width:134pt' x:str="Item"><span
  style='mso-spacerun:yes'> </span>Item<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl27 width=114 style='border-top:none;width:86pt'
  x:str="Image"><span style='mso-spacerun:yes'> </span>Image<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl27 width=107 style='border-top:none;width:80pt'
  x:str="Suitable Stock Q'ty"><span style='mso-spacerun:yes'> </span>Suitable
  Stock Q'ty<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 style='border-top:none' x:str="Unit"><span
  style='mso-spacerun:yes'> </span>Unit<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 style='border-top:none' x:str="Size"><span
  style='mso-spacerun:yes'> </span>Size<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 style='border-top:none' x:str="Color"><span
  style='mso-spacerun:yes'> </span>Color<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl28 style='border-top:none' x:str="Pre-Stock"><span
  style='mso-spacerun:yes'> </span>Pre-Stock<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl27 width=131 style='border-top:none;width:98pt'
  x:str="W.D consumption"><span style='mso-spacerun:yes'> </span>W.D
  consumption<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl29 width=131 style='border-top:none;width:98pt'>Present
  <br>
    Stock</td>
  <td rowspan=2 class=xl29 width=131 style='border-top:none;width:98pt'>PO Qty</td>
  <td rowspan=2 class=xl30 width=131 style='border-top:none;width:98pt'>Expecting
  Stock</td>
 </tr>
 <tr class=xl31 height=17 style='height:12.75pt'>
 </tr>
 <% 
        if (dt.Rows.Count > 0)
        {
              double common_qty =0;
              double expecting_qty =0;
              int count =1;
              string stValue ="###";
              for ( int i =0 ; i< dt.Rows.Count; i++)
              {
                common_qty = double.Parse(dt.Rows[i][10].ToString()) - double.Parse(dt.Rows[i][11].ToString())- double.Parse(dt.Rows[i][12].ToString());
                expecting_qty = common_qty + double.Parse(dt.Rows[i][13].ToString());
                %>
                      <tr height=33 style='mso-height-source:userset;height:24.95pt'>
                <%
                 if (!stValue.Equals(dt.Rows[i][0].ToString()))
                {  
                    count =1;
                    stValue = dt.Rows[i][0].ToString();
                    for(int j =i+1 ; j< dt.Rows.Count ; j ++ )
                        {
                            
                             if (dt.Rows[i][0].Equals(dt.Rows[j][0]))
                             {
                                count ++;
                             }else
                             {
                                break;
                             }
                          
                        }
                    %>
                      <td height=33 class=xl38 align=right width=179 style='height:24.95pt;
                      border-top:none;width:134pt' rowspan="<%=count%>" > <%=dt.Rows[i][0].ToString()%> </td>
                      <td height=33 rowspan="<%=count%>" class=xl35 width=114 style='height:24.95pt;border-top:none;
                      border-left:none;width:86pt' ><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
                      </v:shapetype><v:shape id="_x0000_s1049" type="#_x0000_t75" style='position:absolute;
                       margin-left:25.5pt;margin-top:0;width:33pt;height:24pt;z-index:1'>
                       <v:imagedata src="" o:title="c73d"/>
                       <x:ClientData ObjectType="Pict">
                        <x:SizeWithCells/>
                        </x:ClientData>
                      </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
                      <table cellpadding=0 cellspacing=0>
                       <tr>
                        <td width=34 height=0></td>
                       </tr>
                       <tr>
                        <td></td>
                        <td><img width=44 height=32 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i][14].ToString()%>&table_name=comm.TCO_STITEMPHOTO" v:shapes="_x0000_s1049"></td>
                        <td width=36></td>
                       </tr>
                       <tr>
                        <td height=1></td>
                       </tr>
                      </table>
                      </span><![endif]><!--[if !mso & vml]><span style='width:85.5pt;height:24.75pt'></span><![endif]--></td>
                       <% 
                            }
                       %>
                      <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1].ToString()%></td>
                      <td class=xl37 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3].ToString()%></td>
                      <td class=xl37 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4].ToString()%></td>
                      <td class=xl37 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5].ToString()%></td>
                      <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10].ToString()%></td>
                      <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][11].ToString()%></td>
                      <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=common_qty%></td>
                      <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][13].ToString()%></td>
                      <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=expecting_qty%></td>
                     </tr>
                   <% 
            
        }
    }
  %>
  
   
 <tr height=136 style='height:102.0pt;mso-xlrowspan:8'>
  <td height=136 colspan=11 style='height:102.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=179 style='width:134pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
