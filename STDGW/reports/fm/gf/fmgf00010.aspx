<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("acnt");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>

<%
    string company, itemCode, matCode,transdate;
    
    company = Request["company"]; 
    itemCode = Request["itemCode"];
    matCode = Request["matCode"];
    transdate = Request["transdate"];
    
    DataTable dt = new DataTable ();
    string SQL
     = " SELECT to_char(to_date(table1.process_date,'yyyymmdd'),'dd/mm/yyyy'), table1.wh_prod,table1.item_code, table1.item_name, " +
         "             table1.prod_qty, table1.item_uom, table2.grp_nm, " +
         "             table2.st_item_code, table2.st_item_name, table2.item_uom, " +
         "             table2.norm_qty, table2.loss_rate,table2.need_qty, " +
         "             table2.item_name, nvl(table3.qty,0),prod.sf_get_warehouse_name (table3.tin_warehouse_pk) wh_mat  " +
         "             " +
         "        FROM (SELECT a.pk tac_stocknorm_pk, a.process_date, a.prod_takein_dt, " +
         "                     a.product_pk, b.item_code, b.item_name, a.prod_qty, " +
         "                     a.item_uom, a.tin_warehouse_pk, " +
         "                     prod.sf_get_warehouse_name (a.tin_warehouse_pk) wh_prod " +
         "                FROM acnt.tac_stocknorm a, comm.tco_item b " +
         "               WHERE a.del_if = 0 " +
         "                 AND a.close_yn = 'N' " +
         "                 AND b.del_if = 0 " +
         "                 AND a.product_pk = b.pk " +
         "                 AND (   b.item_code LIKE '%' || UPPER ('" + itemCode + "') || '%' " +
         "                      OR b.item_name LIKE '%' || UPPER ('" + itemCode + "') || '%' " +
         "                      ) " +
         "                 AND SUBSTR (a.process_date, 0, 6) = '" + transdate + "') table1, " +
         "             (SELECT a1.pk tac_stocknormd_pk, a1.tac_stocknorm_pk, " +
         "                     b1.tco_itemgrp_pk, c1.grp_nm, b1.tco_stitem_pk, " +
         "                     d1.item_code st_item_code, d1.item_name st_item_name, " +
         "                     a1.item_pk, b1.item_code, b1.item_name, a1.item_uom, " +
         "                     a1.norm_qty, a1.loss_rate, a1.need_qty, a1.map_qty " +
         "                FROM acnt.tac_stocknormd a1, " +
         "                     comm.tco_item b1, " +
         "                     comm.tco_itemgrp c1, " +
         "                     comm.tco_stitem d1 " +
         "               WHERE a1.del_if = 0 " +
         "                 AND a1.close_yn = 'N' " +
         "                 AND b1.del_if = 0 " +
         "                 AND c1.del_if(+) = 0 " +
         "                 AND d1.del_if(+) = 0 " +
         "                 AND a1.item_pk = b1.pk " +
         "                 AND b1.tco_itemgrp_pk = c1.pk(+) " +
         "                 AND b1.tco_stitem_pk = d1.pk(+) " +
         "                 AND (   b1.item_code LIKE '%' || UPPER ('" + matCode + "') || '%' " +
         "                      OR b1.item_name LIKE '%' || UPPER ('" + matCode + "') || '%' " +
         "                     )) table2, " +
         "             acnt.tac_stocktrnorm table3 " +
         "       WHERE table1.tac_stocknorm_pk = table2.tac_stocknorm_pk " +
         "         AND table3.del_if(+) = 0 " +
         "         AND table3.close_yn(+) = 'N' " +
         "         AND table2.tac_stocknormd_pk = table3.tac_stocknormd_pk(+) " +
         "         order by table1.process_date, table1.wh_prod,table1.item_code, table1.prod_qty,table2.grp_nm " +
         "             ,table2.st_item_code " +
         "          ";
     dt = ESysLib.TableReadOpen(SQL);  
%>
<html 
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40" xmlns:>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00010.xls_files/filelist.xml">
<link rel=Edit-Time-Data href="fmgf00010.xls_files/editdata.mso">
<link rel=OLE-Object-Data href="fmgf00010.xls_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2008-09-17T02:00:07Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2008-09-18T02:01:20Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .25in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\\\(\#\,\#\#0\.000\\\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\\\(\#\,\#\#0\.000\\\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000000_\)\;_\(* \\\(\#\,\#\#0\.000000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000000_\)\;_\(* \\\(\#\,\#\#0\.000000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000000_\)\;_\(* \\\(\#\,\#\#0\.000000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\\\(\#\,\#\#0\.000\\\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\\\(\#\,\#\#0\.000\\\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\\\(\#\,\#\#0\.000\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\)\;\[Red\]\\\(\#\,\#\#0\.00000\\\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00000_\)\;\[Red\]\\\(\#\,\#\#0\.000\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
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
      <x:Scale>69</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:LeftColumnVisible>4</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
       <x:RangeSelection>$K$14:$K$18</x:RangeSelection>
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
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025" u1:ext="edit" u2:ext="edit"
  u3:ext="edit" u4:ext="edit"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1523 style='border-collapse:
 collapse;table-layout:fixed;width:1146pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=142 style='mso-width-source:userset;mso-width-alt:5193;width:107pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=139 style='mso-width-source:userset;mso-width-alt:5083;width:104pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=139 style='mso-width-source:userset;mso-width-alt:5083;width:104pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=142 style='mso-width-source:userset;mso-width-alt:5193;width:107pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=64 style='width:48pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:2706;width:70pt'>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=17 height=39 class=xl33 width=1523 style='height:29.25pt;
  width:1146pt'>Chi ph&#237; nguy&#234;n v&#7853;t li&#7879;u</td>
 </tr>
 <tr height=70 style='height:52.5pt'>
  <td height=70 class=xl24 style='height:52.5pt'>Ng&#224;y nh&#7853;p TP</td>
  <td class=xl25>Kho TP</td>
  <td class=xl25>M&#227; h&#224;ng</td>
  <td class=xl25>T&#234;n h&#224;ng</td>
  <td class=xl26 width=82 style='width:62pt'>S&#7889; l&#432;&#7907;ng s&#7843;n ph&#7849;m nh&#7853;p kho</td>
  <td class=xl27>DVT</td>
  <td class=xl28 width=139 style='width:104pt'>Nh&#243;m nguy&#234;n ph&#7909; li&#7879;u</td>
  <td class=xl28 width=68 style='width:51pt'>M&#227; NPL</td>
  <td class=xl28 width=139 style='width:104pt'>T&#234;n NPL</td>
  <td class=xl28 width=54 style='width:41pt'>DVT</td>
  <td class=xl28 width=69 style='width:52pt'>&#272;&#7883;nh m&#7913;c s&#7917; d&#7909;ng</td>
  <td class=xl28 width=72 style='width:54pt'>T&#7927; l&#7879; hao h&#7909;t(%)</td>
  <td class=xl28 width=78 style='width:59pt'>&#272;&#7883;nh m&#7913;c k&#7875; c&#7843; hao h&#7909;t</td>
  <td class=xl26 width=142 style='width:107pt'>Nguy&#234;n v&#7853;t li&#7879;u (item)</td>
  <td class=xl26 width=68 style='width:51pt'>Xu&#7845;t kho &#273;&#7875; SX TP</td>
  <td class=xl26 width=64 style='width:48pt'>Kho xu&#7845;t </td>
  <td class=xl26 width=95 style='width:70pt'>L&#432;&#7907;ng nguy&#234;n  V&#7853;t li&#7879;u (t&#7893;ng cho nh&#243;m &#273;&#243;)<br>
 </td>
  </tr>
 <% 
     int i, j,status;
     int count = 0,countMatGrp=0;
     double sumQty = 0;
   
     string dateval = "", wh = "", itemcode = "",matGroup ="", qty = "-1",material ="";
     for (i = 0; i < dt.Rows.Count; i++)
     {
         status = 0;
         
  %>
 <tr height=17 style='height:12.75pt'>
 <% 
      //rowspan date
     if (!Comparer.Equals(dt.Rows[i][0].ToString(), dateval))
     {
          dateval = dt.Rows[i][0].ToString();
         count = 0;
         for (j = i; j < dt.Rows.Count; j++)
         {
             if (Comparer.Equals(dateval, dt.Rows[j][0].ToString()))
             {
                 count++;
             }
             else
             {
               
                 break;
             }
         }
         %>
                     <td rowspan=<%=count%> height=561 class=xl35 style='border-bottom:.5pt solid black;
                     height:420.75pt;border-top:none' ><%=dt.Rows[i][0].ToString()%></td>
         <%
             status = 1;
     }
     //rowspan wH
     if (!Comparer.Equals(dt.Rows[i][1].ToString(), wh) || status >0 )
     {
         wh = dt.Rows[i][1].ToString();
         count = 0;
         for (j = i; j < dt.Rows.Count; j++)
         {
             if (Comparer.Equals(wh, dt.Rows[j][1].ToString()) && Comparer.Equals(dt.Rows[j][0].ToString(), dateval))
             {
                 count++;
             }
             else
             {
              
                 break;
             }
         }
          %>
                    <td rowspan=<%=count%> class=xl38 style='border-bottom:.5pt solid black;border-top:none'><%=dt.Rows[i][1].ToString()%></td>
           <%
               status = 2;
     }
     //rowspan product
     if (!Comparer.Equals(dt.Rows[i][2].ToString(), itemcode) || status >0)
     {
         itemcode = dt.Rows[i][2].ToString();
         count = 0;
         for (j = i; j < dt.Rows.Count; j++)
         {
             if (Comparer.Equals(itemcode, dt.Rows[j][2].ToString()) && Comparer.Equals(dt.Rows[j][1].ToString(), wh))
             {
                 count++;
             }
             else
             {
               break;
             }
         }
         
               %>
                    <td rowspan=<%=count%> class=xl38 style='border-bottom:.5pt solid black;border-top:none'><%=dt.Rows[i][2].ToString()%></td>
                    <td rowspan=<%=count%> class=xl41 width=142 style='border-bottom:.5pt solid black; border-top:none;width:107pt'><%=dt.Rows[i][3].ToString()%></td>
               <%
                   status = 3;
     }
     //rowspan qty
      if (!Comparer.Equals(dt.Rows[i][4].ToString(), qty) || status >0)
     {
         qty = dt.Rows[i][4].ToString();
         count = 0;
         for (j = i; j < dt.Rows.Count; j++)
         {
             if (Comparer.Equals(qty, dt.Rows[j][4].ToString()) && Comparer.Equals(dt.Rows[j][2].ToString(), itemcode))
             {
                 count++;
             }
             else
             {
               break;
             }
         }
         
               %>
                    <td rowspan=<%=count%>  class=xl38 style='border-bottom:.5pt solid black' x:num><%=dt.Rows[i][4].ToString()%></td>
                    <td rowspan=<%=count%>  class=xl38 style='border-bottom:.5pt solid black; text-align:center'><%=dt.Rows[i][5].ToString()%></td>
               <%
                   status = 4;
     }
     //rowspan material group
     if (!Comparer.Equals(dt.Rows[i][6].ToString(), matGroup) || status >0)
     {
         matGroup = dt.Rows[i][6].ToString();
         count = 0;
         sumQty = 0;
         for (j = i; j < dt.Rows.Count; j++)
         {
             if (Comparer.Equals(matGroup, dt.Rows[j][6].ToString()) && Comparer.Equals(dt.Rows[j][4].ToString(), qty))
             {
                 count++;
                 sumQty = sumQty + Double.Parse(dt.Rows[j][14].ToString());
             }
             else
             {
               
               break;
             }
         }
         countMatGrp = count;
         %>
                    <td rowspan=<%=count%> class=xl38 style='border-bottom:.5pt solid black;border-top:
                  none'><%=dt.Rows[i][6].ToString()%></td>
                               <%
                 status = 5;
     }
      //rowspan material item
     if (!Comparer.Equals(dt.Rows[i][7].ToString(), material) || status > 0)
     {
         material = dt.Rows[i][7].ToString();
         count = 0;
         for (j = i; j < dt.Rows.Count; j++)
         {
             if (Comparer.Equals(material, dt.Rows[j][7].ToString()) && Comparer.Equals(dt.Rows[j][6].ToString(), matGroup))
             {
                 count++;
             }
             else
             {
               
               break;
             }
         }
         %>
                  <td rowspan=<%=count%> class=xl38 style='border-bottom:.5pt solid black;border-top:
                  none'><%=dt.Rows[i][7].ToString()%></td>
                  <td rowspan=<%=count%> class=xl38 style='border-bottom:.5pt solid black;border-top:
                  none'><%=dt.Rows[i][8].ToString()%></td>
                  <td rowspan=<%=count%> class=xl38 style='border-bottom:.5pt solid black;border-top:
                  none; text-align:center'><%=dt.Rows[i][9].ToString()%></td>
                  <td rowspan=<%=count%> class=xl38 style='border-bottom:.5pt solid black' x:num><%=dt.Rows[i][10].ToString()%> </td>
                  <td rowspan=<%=count%> class=xl47 style='border-bottom:.5pt solid black' x:num><%=dt.Rows[i][11].ToString()%></td>
                  <td rowspan=<%=count%> class=xl38 style='border-bottom:.5pt solid black' x:num><%=dt.Rows[i][12].ToString()%> </td>  
        <%
                 status = 0;
     }
 %>
            
  <td class=xl29><%=dt.Rows[i][13].ToString()%></td>
  <td class=xl30 x:num><%=dt.Rows[i][14].ToString()%></td>
  <td class=xl30 ><%=dt.Rows[i][15].ToString()%></td>
  <% if (countMatGrp > 0)
     { %>
  <td rowspan=<%=countMatGrp%> class=xl52 style='border-bottom:.5pt solid black' x:num><%=sumQty%>
  </td>
  <%
      countMatGrp = 0;
     } %>
  </tr>
 <%
    
     } //end for loop
     
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=104 style='width:78pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=74 style='width:70pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
