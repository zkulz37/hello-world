<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% Response.Charset = "utf-8"; %>
<% ESysLib.SetUser("prod");%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string p_workins_pk = Request.QueryString["workins_pk"];
    string SQL        ="";
    
       
  SQL = "          SELECT   a.wi_cutting_ins_pk, a.style_pk, style.item_code style_code, a.mat_pk, " +
        "         mat.item_code mat_code, sale.sf_get_dsbs00010_3 (7, a.mat_pk) spec1, " +
        "         sale.sf_get_dsbs00010_3 (2, a.mat_pk) spec2, " +
        "         sale.sf_get_dsbs00010_3 (3, a.mat_pk) spec3, a.tpr_pattern_group_pk, " +
        "         grp.pattern_group_id, a.lot_id, a.ord_qty, a.ord_balance_qty, " +
        "         a.lot_qty, a.size01_set_qty S, a.size02_set_qty M, a.size03_set_qty L, " +
        "         a.size04_set_qty XL, a.size05_set_qty XXL, a.size06_set_qty XXXL, " +
        "         a.size07_set_qty XXXXL, a.size08_set_qty, a.size09_set_qty, " +
        "         a.size10_set_qty, a.wi_qty, a.mat_unit_qty, a.mat_gross_qty, " +
        "         a.mat_length, a.mat_weight, a.mat_gross_qty mat_actual_qty, mat.uom mat_uom, a.description, " +
        "         a.pk, a.so_po_pk, a.so_po " +
        "    FROM prod.wi_cutting_issue a, " +
        "         comm.tco_stitem style, " +
        "         comm.tco_item mat, " +
        "         prod.tpr_pattern_group grp " +
        "    WHERE a.del_if = 0 " +
        "     AND style.del_if = 0 " +
        "     AND mat.del_if = 0 " +
        "     AND grp.del_if = 0 " +
        "     AND a.style_pk = style.pk " +
        "     AND a.mat_pk = mat.pk " +
        "     AND a.tpr_pattern_group_pk = grp.pk " +
        "     AND a.wi_cutting_ins_pk = "+ p_workins_pk  +"" +
        "    ORDER BY lot_id, style.item_code, mat.item_code " ;    

  DataTable wi_detail = ESysLib.TableReadOpen(SQL);

  SQL = "  SELECT   a.pk, a.wi_no, a.wi_date, a.array_so_pk, a.ref_po_no, " +
        "       a.tpr_line_pk, b.line_id, b.line_name, a.charger_pk, " +
        "       c.full_name, a.description " +
        "  FROM prod.wi_cutting_ins a, prod.tpr_line b, hr.thr_employee c " +
        " WHERE a.del_if = 0 " +
        "   AND b.del_if(+) = 0 " +
        "   AND c.del_if(+) = 0 " +
        "   AND a.tpr_line_pk = b.pk(+) " +
        "   AND a.charger_pk = c.pk(+) " +
        "   AND a.pk = " + p_workins_pk + "" +
        " ORDER BY a.wi_date DESC, a.wi_no ";

  DataTable wi_master = ESysLib.TableReadOpen(SQL);
        
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpcw00100_files/filelist.xml">
<link rel=Edit-Time-Data href="fpcw00100_files/editdata.mso">
<link rel=OLE-Object-Data href="fpcw00100_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>QuangNguyen</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:Created>2009-08-04T08:01:51Z</o:Created>
  <o:LastSaved>2009-08-04T11:49:17Z</o:LastSaved>
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
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
.xl28
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	text-align:right;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
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
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;}
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
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1051 style='border-collapse:
 collapse;table-layout:fixed;width:789pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=151 style='mso-width-source:userset;mso-width-alt:5522;width:113pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=64 style='width:48pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=64 span=6 style='width:48pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=9 height=40 class=xl35 width=667 style='border-right:.5pt solid black;
  height:30.0pt;width:501pt'>CUTTING WORK INSTRUCTION</td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl24 style='height:22.5pt'>Date</td>
  <td colspan=4 class=xl38 style='border-right:.5pt solid black;border-left:
  none'><%=wi_master.Rows[0][2].ToString()%></td>
  <td colspan=4 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>*W<%=wi_master.Rows[0][1].ToString()%>*</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt'>Charger</td>
  <td colspan=4 class=xl38 style='border-right:.5pt solid black;border-left:
  none'><%=wi_master.Rows[0][9].ToString()%></td>
  <td colspan=4 class=xl45 style='border-right:.5pt solid black;border-left:
  none'><%=wi_master.Rows[0][1].ToString()%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl26 style='height:18.75pt'>No</td>
  <td class=xl27>Mat</td>
  <td class=xl27>Mat Color</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black;border-left:
  none'>Mat Req Qty</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black;border-left:
  none'>Actual</td>
  <td class=xl27>Defect</td>
  <td class=xl27>Remark</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
  <% 
      if (wi_detail.Rows.Count > 0)
      {
          for (int i = 0; i < wi_detail.Rows.Count; i++)
          {
  %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl28 style='height:18.75pt' x:num><%=i+1%></td>
  <td class=xl29><%=wi_detail.Rows[i]["mat_code"]%></td>
  <td class=xl25><%=wi_detail.Rows[i]["spec1"]%></td>
  <td class=xl30><%=wi_detail.Rows[i]["mat_actual_qty"]%></td>
  <td class=xl31><%=wi_detail.Rows[i]["mat_uom"]%></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
    <%
      }
  }   
    %>

 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl28 style='height:18.75pt' x:num></td>
  <td class=xl29></td>
  <td class=xl25></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=7 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl33 style='height:18.75pt'>Style Code</td>
  <td class=xl34>Mat Code</td>
  <td class=xl34>Color</td>
  <td class=xl34>Group ID</td>
  <td class=xl34>Lot ID</td>
  <td class=xl34>Balance</td>
  <td class=xl34>Lot Qty</td>
  <td class=xl34>S</td>
  <td class=xl34>M</td>
  <td class=xl34>L</td>
  <td class=xl34>XL</td>
  <td class=xl34>2XL</td>
  <td class=xl34>3XL</td>
  <td class=xl34>4XL</td>
  <td class=xl34>WI Qty</td>
 </tr>
   <% 
      if (wi_detail.Rows.Count > 0)
      {
          for (int i = 0; i < wi_detail.Rows.Count; i++)
          {
  %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl49 style='height:18.75pt;border-top:none'><%=wi_detail.Rows[i]["style_code"]%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["mat_code"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["spec1"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["pattern_group_id"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["lot_id"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["ord_balance_qty"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["lot_qty"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["S"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["M"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["L"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["XL"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["XXL"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["XXXL"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["XXXXL"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=wi_detail.Rows[i]["wi_qty"]%></td>
  
 </tr>
    <%
      }
  }   
    %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=15 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=15 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=15 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=15 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=15 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=15 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=15 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=100 style='mso-height-source:userset;height:75.0pt;mso-xlrowspan:
  4'>
  <td height=100 colspan=15 style='height:75.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=151 style='width:113pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
