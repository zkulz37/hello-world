<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
string p_std_ym = Request["std_ym"];

int iYear, iMonth;

string iFromDt, iToDt;
    
 //p_std_ym = p_std_ym.Substring(3, 4) + p_std_ym.Substring(0, 2);
 iYear    = int.Parse(p_std_ym.Substring(0, 4));
 iMonth   = int.Parse(p_std_ym.Substring(4, 2));
 iFromDt  = "01/" + p_std_ym.Substring(4, 2) + "/" + p_std_ym.Substring(0, 4);
    
 iToDt = DateTime.DaysInMonth(iYear, iMonth).ToString() + "/" + p_std_ym.Substring(4, 2) + "/" + p_std_ym.Substring(0, 4);    
    
 string SQL
    = "SELECT   a2.months, a2.st_item_code, a2.st_item_name, a2.item_uom, '' u_p, " +
        "         SUM (a2.begin_qty), SUM (a2.begin_amt), SUM (a2.ap_qty), " +
        "         SUM (a2.ap_amt), SUM (a2.takeout_qty), SUM (a2.takeout_amt), " +
        "         SUM (a2.end_qty), SUM (a2.end_amt) " +
        "    FROM (SELECT a1.months, a1.st_item_code, a1.st_item_name, a1.item_uom, " +
        "                 b1.begin_qty, b1.begin_amt, c1.ap_qty, c1.ap_amt, " +
        "                 d1.takeout_qty, d1.takeout_amt, e1.end_qty, e1.end_amt " +
        "            FROM (SELECT DISTINCT SUBSTR (a.tr_date, 0, 6) months, d.grp_nm, " +
        "                                  b.tco_stitem_pk, c.item_code st_item_code, " +
        "                                  c.item_name st_item_name, a.tco_item_pk, " +
        "                                  b.item_code, b.item_name, a.item_uom " +
        "                             FROM acnt.tac_stocktr a, " +
        "                                  comm.tco_item b, " +
        "                                  comm.tco_stitem c, " +
        "                                  comm.tco_itemgrp d " +
        "                            WHERE a.del_if = 0 " +
        "                              AND a.close_yn = 'N' " +
        "                              AND b.del_if = 0 " +
        "                              AND c.del_if(+) = 0 " +
        "                              AND d.del_if = 0 " +
        "                              AND a.tco_item_pk = b.pk " +
        "                              AND b.tco_stitem_pk = c.pk(+) " +
        "                              AND b.tco_itemgrp_pk = d.pk " +
        "                              AND ( a.trin_type in ('10','90')  " +
        "                                 OR a.trout_type in ('10') ) " +
        "                              AND SUBSTR (a.tr_date, 0, 6) = '" + p_std_ym + "') a1, " +
        "                 (SELECT   b.tco_item_pk, SUM (b.input_qty) begin_qty, " +
        "                           SUM (b.in_amt) begin_amt " +
        "                      FROM acnt.tac_stocktr b " +
        "                     WHERE b.del_if = 0 " +
        "                       AND b.close_yn = 'N' " +
        "                       AND b.trin_type = '90' " +
        "                       AND b.std_ym = '" + p_std_ym + "' " +
        "                  GROUP BY b.tco_item_pk) b1, " +
        "                 (SELECT   c.tco_item_pk, SUM (c.input_qty) ap_qty, " +
        "                           SUM (c.in_tramt) ap_amt " +
        "                      FROM acnt.tac_stocktr c " +
        "                     WHERE c.del_if = 0 " +
        "                       AND c.close_yn = 'N' " +
        "                       AND c.trin_type = '10' " +
        "                       AND SUBSTR (c.tr_date, 0, 6) = '" + p_std_ym + "' " +
        "                  GROUP BY c.tco_item_pk) c1, " +
        "                 (SELECT   d.tco_item_pk, SUM (d.output_qty) takeout_qty, " +
        "                           SUM (d.out_tramt) takeout_amt " +
        "                      FROM acnt.tac_stocktr d " +
        "                     WHERE d.del_if = 0 " +
        "                       AND d.close_yn = 'N' " +
        "                       AND d.trout_type = '10' " +
        "                       AND SUBSTR (d.tr_date, 0, 6) = '" + p_std_ym + "' " +
        "                  GROUP BY d.tco_item_pk) d1, " +
        "                 (SELECT   e.tco_item_pk, SUM (e.input_qty) end_qty, " +
        "                           SUM (e.in_amt) end_amt " +
        "                      FROM acnt.tac_stocktr e " +
        "                     WHERE e.del_if = 0 " +
        "                       AND e.close_yn = 'N' " +
        "                       AND e.trin_type = '90' " +
        "                       AND e.std_ym = " +
        "                              TO_CHAR (ADD_MONTHS (TO_DATE ('" + p_std_ym + "', " +
        "                                                            'YYYYMM'), " +
        "                                                   1 " +
        "                                                  ), " +
        "                                       'YYYYMM' " +
        "                                      ) " +
        "                  GROUP BY e.tco_item_pk) e1 " +
        "           WHERE a1.tco_item_pk = b1.tco_item_pk(+) " +
        "             AND a1.tco_item_pk = c1.tco_item_pk(+) " +
        "             AND a1.tco_item_pk = d1.tco_item_pk(+) " +
        "             AND a1.tco_item_pk = e1.tco_item_pk(+)) a2 " +
        " GROUP BY a2.months, a2.st_item_code, a2.st_item_name, a2.item_uom " +
        " order by a2.st_item_code ";

        DataTable dt = ESysLib.TableReadOpen(SQL);
        SQL =
                "SELECT   a2.months, a2.st_item_code, a2.st_item_name, a2.item_uom, '' u_p, " +
                "         SUM (a2.begin_qty), SUM (a2.begin_amt), SUM (a2.ap_qty), " +
                "         SUM (a2.ap_amt), SUM (a2.takeout_qty), SUM (a2.takeout_amt), " +
                "         SUM (a2.end_qty), SUM (a2.end_amt) " +
                "    FROM (SELECT a1.months, a1.st_item_code, a1.st_item_name, a1.item_uom, " +
                "                 b1.begin_qty, b1.begin_amt, c1.ap_qty, c1.ap_amt, " +
                "                 d1.takeout_qty, d1.takeout_amt, e1.end_qty, e1.end_amt " +
                "            FROM (SELECT DISTINCT SUBSTR (a.tr_date, 0, 6) months, d.grp_nm, " +
                "                                  b.tco_stitem_pk, c.item_code st_item_code, " +
                "                                  c.item_name st_item_name, a.tco_item_pk, " +
                "                                  b.item_code, b.item_name, a.item_uom " +
                "                             FROM acnt.tac_stocktr a, " +
                "                                  comm.tco_item b, " +
                "                                  comm.tco_stitem c, " +
                "                                  comm.tco_itemgrp d, " +
                "                                  inv.tin_warehouse e " +
                "                            WHERE a.del_if = 0 " +
                "                              AND a.close_yn = 'N' " +
                "                              AND b.del_if = 0 " +
                "                              AND c.del_if(+) = 0 " +
                "                              AND d.del_if = 0 " +
                "                              AND e.del_if = 0 " +
                "                              AND a.tco_item_pk = b.pk " +
                "                              AND b.tco_stitem_pk = c.pk(+) " +
                "                              AND b.tco_itemgrp_pk = d.pk " +
                "                              AND a.tin_warehouse_pk = e.pk " +
                "                              AND e.wh_type = '01' " +
                "                              AND ( a.trin_type in ('10','90')  " +
                "                                 OR a.trout_type in ('10') ) " +                
                "                              AND SUBSTR (a.tr_date, 0, 6) = '" + p_std_ym + "') a1, " +
                "                 (SELECT   b.tco_item_pk, SUM (b.input_qty) begin_qty, " +
                "                           SUM (b.in_amt) begin_amt " +
                "                      FROM acnt.tac_stocktr b, inv.tin_warehouse c " +
                "                     WHERE b.del_if = 0 " +
                "                       AND b.close_yn = 'N' " +
                "                       AND c.del_if = 0 " +
                "                       AND b.tin_warehouse_pk = c.pk " +
                "                       AND c.wh_type = '01' " +
                "                       AND b.trin_type = '90' " +
                "                       AND b.std_ym = '" + p_std_ym + "' " +
                "                  GROUP BY b.tco_item_pk) b1, " +
                "                 (SELECT   c.tco_item_pk, SUM (c.input_qty) ap_qty, " +
                "                           SUM (c.in_tramt) ap_amt " +
                "                      FROM acnt.tac_stocktr c, inv.tin_warehouse d " +
                "                     WHERE c.del_if = 0 " +
                "                       AND c.close_yn = 'N' " +
                "                       AND c.tin_warehouse_pk = d.pk " +
                "                       AND d.wh_type = '01' " +
                "                       AND c.trin_type = '10' " +
                "                       AND SUBSTR (c.tr_date, 0, 6) = '" + p_std_ym + "' " +
                "                  GROUP BY c.tco_item_pk) c1, " +
                "                 (SELECT   d.tco_item_pk, SUM (d.output_qty) takeout_qty, " +
                "                           SUM (d.out_tramt) takeout_amt " +
                "                      FROM acnt.tac_stocktr d, inv.tin_warehouse e " +
                "                     WHERE d.del_if = 0 " +
                "                       AND d.close_yn = 'N' " +
                "                       AND d.tin_warehouse_pk = e.pk " +
                "                       AND e.wh_type = '01' " +
                "                       AND d.trout_type = '10' " +
                "                       AND SUBSTR (d.tr_date, 0, 6) = '" + p_std_ym + "' " +
                "                  GROUP BY d.tco_item_pk) d1, " +
                "                 (SELECT   e.tco_item_pk, SUM (e.input_qty) end_qty, " +
                "                           SUM (e.in_amt) end_amt " +
                "                      FROM acnt.tac_stocktr e, inv.tin_warehouse f " +
                "                     WHERE e.del_if = 0 " +
                "                       AND e.close_yn = 'N' " +
                "                       AND e.tin_warehouse_pk = f.pk " +
                "                       AND f.wh_type = '01' " +
                "                       AND e.trin_type = '90' " +
                "                       AND e.std_ym = " +
                "                              TO_CHAR (ADD_MONTHS (TO_DATE ('" + p_std_ym + "', " +
                "                                                            'YYYYMM'),1),'YYYYMM') " +
                "                  GROUP BY e.tco_item_pk) e1 " +
                "           WHERE a1.tco_item_pk = b1.tco_item_pk(+) " +
                "             AND a1.tco_item_pk = c1.tco_item_pk(+) " +
                "             AND a1.tco_item_pk = d1.tco_item_pk(+) " +
                "             AND a1.tco_item_pk = e1.tco_item_pk(+)) a2 " +
                "GROUP BY a2.months, a2.st_item_code, a2.st_item_name, a2.item_uom " +
                " order by a2.st_item_code ";
    
        DataTable dt_sea = ESysLib.TableReadOpen(SQL);
        SQL
            = "SELECT   a2.months, a2.st_item_code, a2.st_item_name, a2.item_uom, '' u_p, " +
                "         SUM (a2.begin_qty), SUM (a2.begin_amt), SUM (a2.ap_qty), " +
                "         SUM (a2.ap_amt), SUM (a2.takeout_qty), SUM (a2.takeout_amt), " +
                "         SUM (a2.end_qty), SUM (a2.end_amt) " +
                "    FROM (SELECT a1.months, a1.st_item_code, a1.st_item_name, a1.item_uom, " +
                "                 b1.begin_qty, b1.begin_amt, c1.ap_qty, c1.ap_amt, " +
                "                 d1.takeout_qty, d1.takeout_amt, e1.end_qty, e1.end_amt " +
                "            FROM (SELECT DISTINCT SUBSTR (a.tr_date, 0, 6) months, d.grp_nm, " +
                "                                  b.tco_stitem_pk, c.item_code st_item_code, " +
                "                                  c.item_name st_item_name, a.tco_item_pk, " +
                "                                  b.item_code, b.item_name, a.item_uom " +
                "                             FROM acnt.tac_stocktr a, " +
                "                                  comm.tco_item b, " +
                "                                  comm.tco_stitem c, " +
                "                                  comm.tco_itemgrp d, " +
                "                                  inv.tin_warehouse e " +
                "                            WHERE a.del_if = 0 " +
                "                              AND a.close_yn = 'N' " +
                "                              AND b.del_if = 0 " +
                "                              AND c.del_if(+) = 0 " +
                "                              AND d.del_if = 0 " +
                "                              AND e.del_if = 0 " +
                "                              AND a.tco_item_pk = b.pk " +
                "                              AND b.tco_stitem_pk = c.pk(+) " +
                "                              AND b.tco_itemgrp_pk = d.pk " +
                "                              AND a.tin_warehouse_pk = e.pk " +
                "                              AND e.wh_type = '02' " +
                "                              AND ( a.trin_type in ('10','90')  " +
                "                                 OR a.trout_type in ('10') ) " + 
                "                              AND SUBSTR (a.tr_date, 0, 6) = '" + p_std_ym + "') a1, " +
                "                 (SELECT   b.tco_item_pk, SUM (b.input_qty) begin_qty, " +
                "                           SUM (b.in_amt) begin_amt " +
                "                      FROM acnt.tac_stocktr b, inv.tin_warehouse c " +
                "                     WHERE b.del_if = 0 " +
                "                       AND b.close_yn = 'N' " +
                "                       AND c.del_if = 0 " +
                "                       AND b.tin_warehouse_pk = c.pk " +
                "                       AND c.wh_type = '02' " +
                "                       AND b.trin_type = '90' " +
                "                       AND b.std_ym = '" + p_std_ym + "' " +
                "                  GROUP BY b.tco_item_pk) b1, " +
                "                 (SELECT   c.tco_item_pk, SUM (c.input_qty) ap_qty, " +
                "                           SUM (c.in_tramt) ap_amt " +
                "                      FROM acnt.tac_stocktr c, inv.tin_warehouse d " +
                "                     WHERE c.del_if = 0 " +
                "                       AND c.close_yn = 'N' " +
                "                       AND c.tin_warehouse_pk = d.pk " +
                "                       AND d.wh_type = '02' " +
                "                       AND c.trin_type = '10' " +
                "                       AND SUBSTR (c.tr_date, 0, 6) = '" + p_std_ym + "' " +
                "                  GROUP BY c.tco_item_pk) c1, " +
                "                 (SELECT   d.tco_item_pk, SUM (d.output_qty) takeout_qty, " +
                "                           SUM (d.out_tramt) takeout_amt " +
                "                      FROM acnt.tac_stocktr d, inv.tin_warehouse e " +
                "                     WHERE d.del_if = 0 " +
                "                       AND d.close_yn = 'N' " +
                "                       AND d.tin_warehouse_pk = e.pk " +
                "                       AND e.wh_type = '02' " +
                "                       AND d.trout_type = '10' " +
                "                       AND SUBSTR (d.tr_date, 0, 6) = '" + p_std_ym + "' " +
                "                  GROUP BY d.tco_item_pk) d1, " +
                "                 (SELECT   e.tco_item_pk, SUM (e.input_qty) end_qty, " +
                "                           SUM (e.in_amt) end_amt " +
                "                      FROM acnt.tac_stocktr e, inv.tin_warehouse f " +
                "                     WHERE e.del_if = 0 " +
                "                       AND e.close_yn = 'N' " +
                "                       AND e.tin_warehouse_pk = f.pk " +
                "                       AND f.wh_type = '02' " +
                "                       AND e.trin_type = '90' " +
                "                       AND e.std_ym = " +
                "                              TO_CHAR (ADD_MONTHS (TO_DATE ('" + p_std_ym + "', " +
                "                                                            'YYYYMM'), " +
                "                                                   1 " +
                "                                                  ), " +
                "                                       'YYYYMM' " +
                "                                      ) " +
                "                  GROUP BY e.tco_item_pk) e1 " +
                "           WHERE a1.tco_item_pk = b1.tco_item_pk(+) " +
                "             AND a1.tco_item_pk = c1.tco_item_pk(+) " +
                "             AND a1.tco_item_pk = d1.tco_item_pk(+) " +
                "             AND a1.tco_item_pk = e1.tco_item_pk(+)) a2 " +
                "GROUP BY a2.months, a2.st_item_code, a2.st_item_name, a2.item_uom " +
                " order by a2.st_item_code ";
        DataTable dt_domes = ESysLib.TableReadOpen(SQL);
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00010_1_files/filelist.xml">
<link rel=Edit-Time-Data href="fmgf00010_1_files/editdata.mso">
<link rel=OLE-Object-Data href="fmgf00010_1_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2008-09-10T03:36:00Z</o:LastPrinted>
  <o:Created>2008-09-10T03:06:12Z</o:Created>
  <o:LastSaved>2008-09-17T10:49:35Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .25in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;	
	white-space:normal;
	}
.xl28
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>bang tong hop xnt</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet2</x:CodeName>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8595</x:WindowHeight>
  <x:WindowWidth>17400</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:TabRatio>489</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='bang tong hop xnt'!$A$8:$M$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1194 style='border-collapse:
 collapse;table-layout:fixed;width:898pt'>
 <col class=xl25 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl25 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl25 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl25 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl25 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl25 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl25 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl25 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl25 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl25 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl25 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=2 width=176 style='height:15.0pt;mso-ignore:
  colspan;width:133pt'>
   CTY TNHH SAMIL VINA</td>
  <td class=xl25 width=125 style='width:94pt'></td>
  <td class=xl25 width=79 style='width:59pt'></td>
  <td class=xl25 width=74 style='width:56pt'></td>
  <td class=xl25 width=75 style='width:56pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=75 style='width:56pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=75 style='width:56pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=75 style='width:56pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=4 style='height:15.0pt;mso-ignore:colspan'>KCN
  LONG THÀNH, LONG THÀNH, ĐỒNG NAI</td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=13 class=xl25 style='height:8.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=13 height=27 class=xl32 style='height:20.25pt'>BẢNG TỔNG HỢP XUẤT
  NHẬP TỒN VẬT TƯ, HÀNG HÓA</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=13 height=20 class=xl26 style='height:15.0pt'>Từ ngày <%=iFromDt %>
  đến ngày <%=iToDt %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt' x:str>Kho:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl24 style='height:30.0pt'>Tháng</td>
  <td colspan=3 class=xl24 style='border-left:none'>Vật tư hàng hóa</td>
  <td rowspan=2 class=xl24>Đơn giá</td>
  <td colspan=2 class=xl24 style='border-left:none'>Tồn đầu kỳ</td>
  <td colspan=2 class=xl24 style='border-left:none'>Nhập trong kỳ</td>
  <td colspan=2 class=xl24 style='border-left:none'>Xuất trong kỳ</td>
  <td colspan=2 class=xl24 style='border-left:none'>Tồn cuối kỳ</td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt;border-top:none;border-left:
  none'>Mã</td>
  <td class=xl24 style='border-top:none;border-left:none'>Tên VT, háng hóa</td>
  <td class=xl24 style='border-top:none;border-left:none'>Đơn vị tính</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
 </tr>
 <% 
    int i, j;
    float lBegin_Qty, lBegin_amt, lInput_qty, lInput_amt, lOut_Qty, lOut_amt, lEnd_qty, lEnd_amt;
     
    lBegin_Qty = 0;
    lBegin_amt = 0;     
    lInput_qty = 0;
    lInput_amt = 0;
    lOut_Qty = 0 ; 
    lOut_amt = 0 ;
    lEnd_qty = 0 ;
    lEnd_amt = 0 ;
    for (i = 0; i < dt.Rows.Count; i++)
    {
        if(dt.Rows[i][5].ToString().Trim() != "")
            lBegin_Qty += float.Parse(dt.Rows[i][5].ToString());
        if (dt.Rows[i][6].ToString().Trim() != "")
            lBegin_amt += float.Parse(dt.Rows[i][6].ToString());
        if (dt.Rows[i][7].ToString().Trim() != "")
            lInput_qty += float.Parse(dt.Rows[i][7].ToString());
        if (dt.Rows[i][8].ToString().Trim() != "")
            lInput_amt += float.Parse(dt.Rows[i][8].ToString());
        if (dt.Rows[i][9].ToString().Trim() != "")
            lOut_Qty += float.Parse(dt.Rows[i][9].ToString());
        if (dt.Rows[i][10].ToString().Trim() != "")
            lOut_amt += float.Parse(dt.Rows[i][10].ToString());
        if (dt.Rows[i][11].ToString().Trim() != "")
            lEnd_qty += float.Parse(dt.Rows[i][11].ToString());
        if (dt.Rows[i][12].ToString().Trim() != "")
            lEnd_amt += float.Parse(dt.Rows[i][12].ToString());
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][4]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][5]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][6]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][7]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][8]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][9]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][10]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][11]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][12]%></td>
 </tr>
 <% } %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Tổng cộng</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lBegin_Qty%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lBegin_amt%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lInput_qty %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lInput_amt %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lOut_Qty %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lOut_amt %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lEnd_qty%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lEnd_amt %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=2 style='height:15.0pt;mso-ignore:colspan'>CTY
  TNHH SAMIL VINA</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=4 style='height:15.0pt;mso-ignore:colspan'>KCN
  LONG THÀNH, LONG THÀNH, ĐỒNG NAI</td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=13 height=27 class=xl32 style='height:20.25pt'>BẢNG TỔNG HỢP XUẤT
  NHẬP TỒN VẬT TƯ, HÀNG HÓA</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=13 height=20 class=xl26 style='height:15.0pt'>Từ ngày <%=iFromDt %>
  đến ngày <%=iToDt %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Kho:
  Nước Ngoài</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl24 style='height:30.0pt'>Tháng</td>
  <td colspan=3 class=xl24 style='border-left:none'>Vật tư hàng hóa</td>
  <td rowspan=2 class=xl24>Đơn giá</td>
  <td colspan=2 class=xl24 style='border-left:none'>Tồn đầu kỳ</td>
  <td colspan=2 class=xl24 style='border-left:none'>Nhập trong kỳ</td>
  <td colspan=2 class=xl24 style='border-left:none'>Xuất trong kỳ</td>
  <td colspan=2 class=xl24 style='border-left:none'>Tồn cuối kỳ</td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt;border-top:none;border-left:
  none'>Mã</td>
  <td class=xl24 style='border-top:none;border-left:none'>Tên VT, háng hóa</td>
  <td class=xl24 style='border-top:none;border-left:none'>Đơn vị tính</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
 </tr>
 <% 
    lBegin_Qty = 0;
    lBegin_amt = 0;     
    lInput_qty = 0;
    lInput_amt = 0;
    lOut_Qty = 0 ; 
    lOut_amt = 0 ;
    lEnd_qty = 0 ;
    lEnd_amt = 0 ;
    for (i = 0; i < dt_sea.Rows.Count; i++)
    {
        if(dt_sea.Rows[i][5].ToString().Trim() != "")
            lBegin_Qty += float.Parse(dt_sea.Rows[i][5].ToString());
        if (dt_sea.Rows[i][6].ToString().Trim() != "")
            lBegin_amt += float.Parse(dt_sea.Rows[i][6].ToString());
        if (dt_sea.Rows[i][7].ToString().Trim() != "")
            lInput_qty += float.Parse(dt_sea.Rows[i][7].ToString());
        if (dt_sea.Rows[i][8].ToString().Trim() != "")
            lInput_amt += float.Parse(dt_sea.Rows[i][8].ToString());
        if (dt_sea.Rows[i][9].ToString().Trim() != "")
            lOut_Qty += float.Parse(dt_sea.Rows[i][9].ToString());
        if (dt_sea.Rows[i][10].ToString().Trim() != "")
            lOut_amt += float.Parse(dt_sea.Rows[i][10].ToString());
        if (dt_sea.Rows[i][11].ToString().Trim() != "")
            lEnd_qty += float.Parse(dt_sea.Rows[i][11].ToString());
        if (dt_sea.Rows[i][12].ToString().Trim() != "")
            lEnd_amt += float.Parse(dt_sea.Rows[i][12].ToString());
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'><%=dt_sea.Rows[i][0] %></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt_sea.Rows[i][1] %></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt_sea.Rows[i][2] %></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt_sea.Rows[i][3] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_sea.Rows[i][4] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_sea.Rows[i][5] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_sea.Rows[i][6] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_sea.Rows[i][7] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_sea.Rows[i][8] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_sea.Rows[i][9] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_sea.Rows[i][10] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_sea.Rows[i][11] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_sea.Rows[i][12] %></td>
 </tr>
 <% } %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Tổng cộng</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lBegin_Qty %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lBegin_amt%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lInput_qty%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lInput_amt%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lOut_Qty%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lOut_amt %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lEnd_qty %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lEnd_amt%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=2 style='height:15.0pt;mso-ignore:colspan'>CTY
  TNHH SAMIL VINA</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=4 style='height:15.0pt;mso-ignore:colspan'>KCN
  LONG THÀNH, LONG THÀNH, ĐỒNG NAI</td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=13 height=27 class=xl32 style='height:20.25pt'>BẢNG TỔNG HỢP XUẤT
  NHẬP TỒN VẬT TƯ, HÀNG HÓA</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=13 height=20 class=xl26 style='height:15.0pt'>Từ ngày <%=iFromDt %>
  đến ngày <%=iToDt %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Kho:
  Trong Nước</td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl24 style='height:30.0pt'>Tháng</td>
  <td colspan=3 class=xl24 style='border-left:none'>Vật tư hàng hóa</td>
  <td rowspan=2 class=xl24>Đơn giá</td>
  <td colspan=2 class=xl24 style='border-left:none'>Tồn đầu kỳ</td>
  <td colspan=2 class=xl24 style='border-left:none'>Nhập trong kỳ</td>
  <td colspan=2 class=xl24 style='border-left:none'>Xuất trong kỳ</td>
  <td colspan=2 class=xl24 style='border-left:none'>Tồn cuối kỳ</td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt;border-top:none;border-left:
  none'>Mã</td>
  <td class=xl24 style='border-top:none;border-left:none'>Tên VT, háng hóa</td>
  <td class=xl24 style='border-top:none;border-left:none'>Đơn vị tính</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl30 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl31 style='border-top:none;border-left:none'>Giá trị</td>
 </tr>
 <%
    lBegin_Qty = 0;
    lBegin_amt = 0;     
    lInput_qty = 0;
    lInput_amt = 0;
    lOut_Qty = 0 ; 
    lOut_amt = 0 ;
    lEnd_qty = 0 ;
    lEnd_amt = 0 ;     
    for (i = 0; i < dt_domes.Rows.Count; i++)
    {
        if (dt_domes.Rows[i][5].ToString().Trim() != "")
            lBegin_Qty += float.Parse(dt_domes.Rows[i][5].ToString());
        if (dt_domes.Rows[i][6].ToString().Trim() != "")
            lBegin_amt += float.Parse(dt_domes.Rows[i][6].ToString());
        if (dt_domes.Rows[i][7].ToString().Trim() != "")
            lInput_qty += float.Parse(dt_domes.Rows[i][7].ToString());
        if (dt_domes.Rows[i][8].ToString().Trim() != "")
            lInput_amt += float.Parse(dt_domes.Rows[i][8].ToString());
        if (dt_domes.Rows[i][9].ToString().Trim() != "")
            lOut_Qty += float.Parse(dt_domes.Rows[i][9].ToString());
        if (dt_domes.Rows[i][10].ToString().Trim() != "")
            lOut_amt += float.Parse(dt_domes.Rows[i][10].ToString());
        if (dt_domes.Rows[i][11].ToString().Trim() != "")
            lEnd_qty += float.Parse(dt_domes.Rows[i][11].ToString());
        if (dt_domes.Rows[i][12].ToString().Trim() != "")
            lEnd_amt += float.Parse(dt_domes.Rows[i][12].ToString());
         
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'><%=dt_domes.Rows[i][0]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt_domes.Rows[i][1]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt_domes.Rows[i][2]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt_domes.Rows[i][3]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_domes.Rows[i][4]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_domes.Rows[i][5]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_domes.Rows[i][6]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_domes.Rows[i][7]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_domes.Rows[i][8]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_domes.Rows[i][9]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_domes.Rows[i][10]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_domes.Rows[i][11]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_domes.Rows[i][12]%></td>
 </tr>
 <% } %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Tổng cộng</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lBegin_Qty %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lBegin_amt %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lInput_qty %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lInput_amt%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lOut_Qty %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lOut_amt %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lEnd_qty%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=lEnd_amt %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=82 style='width:62pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>