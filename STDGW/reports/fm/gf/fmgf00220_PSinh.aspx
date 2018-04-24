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
	string p_std_ym = "", p_com_pk = "", p_wh_pk = "";
	p_std_ym = Request["std_ym"];
	p_com_pk = Request["company_pk"];
	p_wh_pk = Request["warehouse_pk"];
	p_std_ym = p_std_ym.Substring(0, 6);
	string SQL = "";
     SQL
        = "select c.ac_grp, sum(b.last_qty) last_qty, sum(b.last_famt) last_famt, sum(b.last_amt) last_amt,  " +
            "nvl(sum(b.input_qty),0) input_qty, nvl(sum(b.in_tramt), 0) in_tramt, nvl(sum(b.in_amt), 0) in_amt,  " +
            "nvl(sum(b.output_qty), 0) output_qty, nvl(sum(b.out_tramt),0) out_tramt, nvl(sum(b.out_amt),0) out_amt,  " +
            "nvl(sum(nvl(b.last_qty, 0) + nvl(b.input_qty, 0) - nvl(b.output_qty, 0)), 0) bal_qty,  " +
            "sum(nvl(b.last_famt, 0) + nvl(b.in_tramt, 0) - nvl(b.out_tramt, 0)) bal_famt,  " +
            "sum(nvl(b.last_amt, 0) + nvl(b.in_amt, 0) - nvl(b.out_amt, 0)) bal_amt  " +
            "from (  " +
            "select t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk,  " +
            "    nvl(sum(t.last_qty), 0) last_qty, nvl(sum(t.last_famt), 0) last_famt, nvl(sum(t.last_amt), 0) last_amt,  " +
            "    nvl(sum(t.input_qty), 0) input_qty, nvl(sum(t.in_tramt), 0) in_tramt, nvl(sum(t.in_amt), 0) in_amt,  " +
            "    nvl(sum(t.output_qty), 0) output_qty, nvl(sum(t.out_tramt), 0) out_tramt, nvl(sum(t.out_amt), 0) out_amt    " +
            "from (  " +
            "select m.tco_item_pk, m.tac_abacctcode_pk, m.tin_warehouse_pk, m.last_qty, m.last_famt, m.last_amt,  " +
            "    0 input_qty, 0 in_tramt, 0 in_amt, 0 output_qty, 0 out_tramt, 0 out_amt   " +
            "from tac_stockmm m  " +
            "where m.std_ym = '" + p_std_ym + "'  " +
            "and m.tco_company_pk = '" + p_com_pk + "'  " +
            "and m.del_if = 0  " +
            "and ( m.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0')  " +            
            "union all  " +
            "select a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk, 0 last_qty, 0 last_famt, 0 last_amt,  " +
            "    nvl(sum(a.input_qty), 0) input_qty,  " +
            "     nvl(sum(a.in_tramt), 0) in_tramt, nvl(sum(a.in_amt), 0) in_amt, nvl(sum(a.output_qty), 0) output_qty,   " +
            "     nvl(sum(a.out_tramt), 0) out_tramt, nvl(sum(a.out_amt), 0) out_amt  " +
            "    from tac_stocktr a  " +
            "    where a.std_ym = '" + p_std_ym + "'  " +
            "    and a.del_if = 0  " +
            "    and a.tr_status in ('1', '2', '0')  " +
            "    and a.tco_company_pk = '" + p_com_pk + "'  " +
            "    and ( a.trin_type = '10' or a.trout_type = '10')  " +
            "    and ( a.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0' )  " +
            "    group by a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk  " +
            "    ) t  " +
            " group by t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk " +
            "    ) b,  " +
            "    comm.tco_item i,  " +
             " ( select d.tac_abacctcode_pk, p.ac_grp " +
                " from tac_abtracgrp p, tac_abtracgrpd d " +
                " where p.pk = d.tac_abtracgrp_pk " +
                " and p.del_if = 0 " +
                " and d.del_if = 0 " +
                " and p.ac_grp in ('152', '153', '156') ) c " +            
            "    where b.tco_item_pk = i.pk  " +
            "    and i.del_if = 0  and b.tac_abacctcode_pk = c.tac_abacctcode_pk  " +
            " and (b.input_qty <> 0 or b.output_qty) <> 0 " +
            " group by c.ac_grp order by c.ac_grp " +
            "  ";
     DataTable dtMst = new DataTable();    
     dtMst = ESysLib.TableReadOpen(SQL);
    
	DataTable dt = new DataTable();
	
	int i, j, k;
	string l_month = p_std_ym.Substring(4, 2);	
	string l_year = p_std_ym.Substring(0, 4);
    string ls_itemgrp = "";
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00220_InOut_files/filelist.xml">
<link rel=Edit-Time-Data href="fmgf00220_InOut_files/editdata.mso">
<link rel=OLE-Object-Data href="fmgf00220_InOut_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:Created>2010-04-24T15:38:06Z</o:Created>
  <o:LastSaved>2010-04-24T16:07:27Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
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
	font-size:13.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;
	mso-number-format:"\#\,\#\#0"}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;
	mso-number-format:"\#\,\#\#0\.00"}
	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8535</x:WindowHeight>
  <x:WindowWidth>14265</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1066 style='border-collapse:
 collapse;table-layout:fixed;width:800pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=256 style='mso-width-source:userset;mso-width-alt:9362;width:192pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=75 style='height:12.75pt;width:56pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
 </tr>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl24 colspan=7 align=left style='height:17.25pt;
  mso-ignore:colspan'>Báo cáo nhập xuất tồn theo kho có số dư và có
  phát sinh</td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 align=left style='height:12.75pt;mso-ignore:colspan'>(mỗi
  cuối tháng sẽ in báo cáo này)</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 align=left style='height:15.75pt;
  mso-ignore:colspan'>Tháng: <%=l_month%>/<%=l_year%></td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=68 style='height:51.0pt'>
  <td height=68 class=xl26 width=75 style='height:51.0pt;width:56pt'>Mã số</td>
  <td class=xl27 width=256 style='width:192pt'>Tên Vật tư - Hàng hóa</td>
  <td class=xl27 width=67 style='width:50pt'>Đơn vị</td>
  <td class=xl27 width=96 style='width:72pt'>Lượng đầu kỳ</td>
  <td class=xl27 width=81 style='width:61pt'>Tiền VND</td>
  <td class=xl27 width=81 style='width:61pt'>Tiền đầu kỳ</td>
  <td class=xl27 width=86 style='width:65pt'>Lượng Nhập</td>
  <td class=xl27 width=86 style='width:65pt'>Tiền VND</td>
  <td class=xl27 width=72 style='width:54pt'>Tiền Nhập</td>
  <td class=xl27 width=82 style='width:62pt'>Lượng Xuất</td>
  <td class=xl27 width=68 style='width:51pt'>Tiền VND</td>
  <td class=xl27 width=68 style='width:51pt'>Tiền Xuất</td>
  <td class=xl27 width=99 style='width:74pt'>Lượng cuối kỳ</td>
  <td class=xl27 width=84 style='width:63pt'>Tiền C.Kỳ(VND)</td>
  <td class=xl27 width=84 style='width:63pt'>Tiền cuối kỳ</td>
 </tr>
 <% 
     string ls_ac_grp = "", l_acc_cd = "";
     DataTable dtGrpItem = new DataTable();
    for(k = 0; k < dtMst.Rows.Count; k++)
    {
        l_acc_cd = dtMst.Rows[k][0].ToString();
        if(dtMst.Rows[k][0].ToString() == "152")
        {
            ls_ac_grp = "2 - Nguyên liệu, vật liệu";
        }
        else if(dtMst.Rows[k][0].ToString() == "153")
        {
            ls_ac_grp = "3 - Công cụ, dụng cụ";
        }
        else if(dtMst.Rows[k][0].ToString() == "156")
        {
            ls_ac_grp = "4 - Hàng hóa";    
        }
     SQL
        = "select substr(i.item_code, 1, 2) item_grp  " +
            ", sum(b.last_qty) last_qty, sum(b.last_famt) last_famt, sum(b.last_amt) last_amt,  " +
            "nvl(sum(b.input_qty),0) input_qty, nvl(sum(b.in_tramt), 0) in_tramt, nvl(sum(b.in_amt), 0) in_amt,  " +
            "nvl(sum(b.output_qty), 0) output_qty, nvl(sum(b.out_tramt),0) out_tramt, nvl(sum(b.out_amt),0) out_amt,  " +
            "nvl(sum(nvl(b.last_qty, 0) + nvl(b.input_qty, 0) - nvl(b.output_qty, 0)), 0) bal_qty,  " +
            "sum(nvl(b.last_famt, 0) + nvl(b.in_tramt, 0) - nvl(b.out_tramt, 0)) bal_famt,  " +
            "sum(nvl(b.last_amt, 0) + nvl(b.in_amt, 0) - nvl(b.out_amt, 0)) bal_amt  " +
            "from (  " +
            "select t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk,  " +
            "    nvl(sum(t.last_qty), 0) last_qty, nvl(sum(t.last_famt), 0) last_famt, nvl(sum(t.last_amt), 0) last_amt,  " +
            "    nvl(sum(t.input_qty), 0) input_qty, nvl(sum(t.in_tramt), 0) in_tramt, nvl(sum(t.in_amt), 0) in_amt,  " +
            "    nvl(sum(t.output_qty), 0) output_qty, nvl(sum(t.out_tramt), 0) out_tramt, nvl(sum(t.out_amt), 0) out_amt    " +
            "from (  " +
            "select m.tco_item_pk, m.tac_abacctcode_pk, m.tin_warehouse_pk, m.last_qty, m.last_famt, m.last_amt,  " +
            "    0 input_qty, 0 in_tramt, 0 in_amt, 0 output_qty, 0 out_tramt, 0 out_amt   " +
            "from tac_stockmm m  " +
            "where m.std_ym = '" + p_std_ym + "'  " +
            "and m.tco_company_pk = '" + p_com_pk + "'  " +
            "and m.del_if = 0  " +
            "and ( m.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0')  " +            
            "union all  " +
            "select a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk, 0 last_qty, 0 last_famt, 0 last_amt,  " +
            "    nvl(sum(a.input_qty), 0) input_qty,  " +
            "     nvl(sum(a.in_tramt), 0) in_tramt, nvl(sum(a.in_amt), 0) in_amt, nvl(sum(a.output_qty), 0) output_qty,   " +
            "     nvl(sum(a.out_tramt), 0) out_tramt, nvl(sum(a.out_amt), 0) out_amt  " +
            "    from tac_stocktr a  " +
            "    where a.std_ym = '" + p_std_ym + "'  " +
            "    and a.del_if = 0  " +
            "    and a.tr_status in ('1', '2', '0')  " +
            "    and a.tco_company_pk = '" + p_com_pk + "'  " +
            "    and ( a.trin_type = '10' or a.trout_type = '10')  " +
            "    and ( a.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0' )  " +
            "    group by a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk  " +
            "    ) t  " +
            "group by t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk  " +
            "    ) b,  " +
            "    comm.tco_item i  " +
            "    where b.tco_item_pk = i.pk  " +
            "    and i.del_if = 0 and (b.input_qty <> 0 or b.output_qty <> 0) " +
            " and b.tac_abacctcode_pk in ( " +
            " select distinct d.tac_abacctcode_pk  " +
            " from tac_abtracgrp p, tac_abtracgrpd d " +
            " where p.pk = d.tac_abtracgrp_pk " +
            " and p.del_if = 0 " +
            " and d.del_if = 0 " +
            " and p.ac_grp = '" + l_acc_cd + "') " +            
            "    group by substr(i.item_code, 1, 2) " +
            " order by  substr(i.item_code, 1, 2) ";
     
     dtGrpItem = ESysLib.TableReadOpen(SQL);
     
     %>
  <tr height=17 style='height:12.75pt'>
  <td height=17 colspan="3" class=xl28 align=left width=75 style='height:12.75pt;
  width:56pt;font-weight:700;'><%=ls_ac_grp %></td>    
  <td class=xl29 align=right width=96 style='width:72pt;font-weight:700' x:num><%=dtMst.Rows[k][1]%></td>
  <td class=xl30 align=right width=81 style='font-weight:700; width:61pt' x:num><%=dtMst.Rows[k][2]%></td>
  <td class=xl31 align=right width=81 style='font-weight:700; width:61pt' x:num><%=dtMst.Rows[k][3]%></td>
  <td class=xl29 align=right width=86 style='font-weight:700; width:65pt' x:num><%=dtMst.Rows[k][4]%></td>
  <td class=xl30 align=right width=72 style='font-weight:700; width:54pt' x:num><%=dtMst.Rows[k][5]%></td>
  <td class=xl31 align=right width=72 style='font-weight:700; width:54pt' x:num><%=dtMst.Rows[k][6]%></td>
  <td class=xl29 align=right width=82 style='font-weight:700; width:62pt' x:num><%=dtMst.Rows[k][7]%></td>
  <td class=xl30 align=right width=68 style='font-weight:700; width:51pt' x:num><%=dtMst.Rows[k][8]%></td>
  <td class=xl31 align=right width=68 style='width:51pt;font-weight:700' x:num><%=dtMst.Rows[k][9]%></td>
  <td class=xl29 align=right width=99 style='width:74pt;font-weight:700' x:num><%=dtMst.Rows[k][10]%></td>
  <td class=xl30 align=right width=84 style='width:63pt;font-weight:700' x:num><%=dtMst.Rows[k][11]%></td>
  <td class=xl31 align=right width=84 style='width:63pt;font-weight:700' x:num><%=dtMst.Rows[k][12]%></td>
 </tr>
 
 <%
     for (j = 0; j < dtGrpItem.Rows.Count; j++)
     {
         ls_itemgrp = dtGrpItem.Rows[j][0].ToString();
         SQL
         = "select i.item_code, i.item_name, " +
         " (select uom_nm from tco_uom where uom_code = i.uom and del_if = 0) uom" +
         ", b.last_qty, b.last_famt, b.last_amt, " +
             "nvl(b.input_qty,0) input_qty, nvl(b.in_tramt, 0) in_tramt, nvl(b.in_amt, 0) in_amt, " +
             "nvl(b.output_qty, 0) output_qty, nvl(b.out_tramt,0) out_tramt, nvl(b.out_amt,0) out_amt, " +
             "nvl(b.last_qty, 0) + nvl(b.input_qty, 0) - nvl(b.output_qty, 0) bal_qty, " +
             "nvl(b.last_famt, 0) + nvl(b.in_tramt, 0) - nvl(b.out_tramt, 0) bal_famt, " +
             "nvl(b.last_amt, 0) + nvl(b.in_amt, 0) - nvl(b.out_amt, 0) bal_amt " +
             "from ( " +
             "select t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk, " +
             "    nvl(sum(t.last_qty), 0) last_qty, nvl(sum(t.last_famt), 0) last_famt, nvl(sum(t.last_amt), 0) last_amt, " +
             "    nvl(sum(t.input_qty), 0) input_qty, nvl(sum(t.in_tramt), 0) in_tramt, nvl(sum(t.in_amt), 0) in_amt, " +
             "    nvl(sum(t.output_qty), 0) output_qty, nvl(sum(t.out_tramt), 0) out_tramt, nvl(sum(t.out_amt), 0) out_amt   " +
             "from ( " +
             "select m.tco_item_pk, m.tac_abacctcode_pk, m.tin_warehouse_pk, m.last_qty, m.last_famt, m.last_amt, " +
             "    0 input_qty, 0 in_tramt, 0 in_amt, 0 output_qty, 0 out_tramt, 0 out_amt  " +
             "from tac_stockmm m " +
             "where m.std_ym = '" + p_std_ym + "' " +
             "and m.tco_company_pk = '" + p_com_pk + "' " +
             "and m.del_if = 0 " +
             "and ( m.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0') " +             
             "union all " +
             "select a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk, 0 last_qty, 0 last_famt, 0 last_amt, " +
             "    nvl(sum(a.input_qty), 0) input_qty, " +
             "     nvl(sum(a.in_tramt), 0) in_tramt, nvl(sum(a.in_amt), 0) in_amt, nvl(sum(a.output_qty), 0) output_qty,  " +
             "     nvl(sum(a.out_tramt), 0) out_tramt, nvl(sum(a.out_amt), 0) out_amt " +
             "    from tac_stocktr a " +
             "    where a.std_ym = '" + p_std_ym + "' " +
             "    and a.del_if = 0 " +
             "    and a.tr_status in ('1', '2', '0') " +
             "    and a.tco_company_pk = '" + p_com_pk + "' " +
             "    and ( a.trin_type = '10' or a.trout_type = '10') " +
             "    and ( a.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0' ) " +
             "    group by a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk " +
             "    ) t " +
             "group by t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk " +
             "    ) b, " +
             "    comm.tco_item i " +
             "    where b.tco_item_pk = i.pk and i.item_code like '" + ls_itemgrp + "%' " +
             " and (b.input_qty <> 0 or b.output_qty <> 0) " +
             " order by i.item_code asc ";
         //				" and ((nvl(b.last_qty, 0) > 0) and (b.input_qty + b.output_qty > 0)) " +
         dt = ESysLib.TableReadOpen(SQL);
 %>
  <tr height=17 style='height:12.75pt'>
  <td height=17 colspan="3" class=xl28 align=left width=75 style='font-weight:700; height:12.75pt;
  width:56pt;'>&nbsp;<%=dtGrpItem.Rows[j][0]%></td>    
  <td class=xl29 align=right width=96 style='font-weight:700;width:72pt' x:num><%=dtGrpItem.Rows[j][1]%></td>
  <td class=xl30 align=right width=81 style='font-weight:700;width:61pt' x:num><%=dtGrpItem.Rows[j][2]%></td>
  <td class=xl31 align=right width=81 style='font-weight:700;width:61pt' x:num><%=dtGrpItem.Rows[j][3]%></td>
  <td class=xl29 align=right width=86 style='font-weight:700;width:65pt' x:num><%=dtGrpItem.Rows[j][4]%></td>
  <td class=xl30 align=right width=72 style='font-weight:700;width:54pt' x:num><%=dtGrpItem.Rows[j][5]%></td>
  <td class=xl31 align=right width=72 style='font-weight:700;width:54pt' x:num><%=dtGrpItem.Rows[j][6]%></td>
  <td class=xl29 align=right width=82 style='font-weight:700;width:62pt' x:num><%=dtGrpItem.Rows[j][7]%></td>
  <td class=xl30 align=right width=68 style='font-weight:700;width:51pt' x:num><%=dtGrpItem.Rows[j][8]%></td>
  <td class=xl31 align=right width=68 style='font-weight:700;width:51pt' x:num><%=dtGrpItem.Rows[j][9]%></td>
  <td class=xl29 align=right width=99 style='font-weight:700;width:74pt' x:num><%=dtGrpItem.Rows[j][10]%></td>
  <td class=xl30 align=right width=84 style='font-weight:700;width:63pt' x:num><%=dtGrpItem.Rows[j][11]%></td>
  <td class=xl31 align=right width=84 style='font-weight:700;width:63pt' x:num><%=dtGrpItem.Rows[j][12]%></td>
 </tr>
 <%        
     for (i = 0; i < dt.Rows.Count; i++)
     {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 align=left width=75 style='height:12.75pt;
  width:56pt'>&nbsp;<%=dt.Rows[i][0]%></td>
  <td class=xl29 align=left width=256 style='width:192pt'>&nbsp;<%=dt.Rows[i][1]%></td>
  <td class=xl29 align=left width=67 style='width:50pt'>&nbsp;<%=dt.Rows[i][2]%></td>
  <td class=xl29 align=right width=96 style='width:72pt' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl30 align=right width=81 style='width:61pt' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl31 align=right width=81 style='width:61pt' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl29 align=right width=86 style='width:65pt' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl30 align=right width=72 style='width:54pt' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl31 align=right width=72 style='width:54pt' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl29 align=right width=82 style='width:62pt' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl30 align=right width=68 style='width:51pt' x:num><%=dt.Rows[i][10]%></td>
  <td class=xl31 align=right width=68 style='width:51pt' x:num><%=dt.Rows[i][11]%></td>
  <td class=xl29 align=right width=99 style='width:74pt' x:num><%=dt.Rows[i][12]%></td>
  <td class=xl30 align=right width=84 style='width:63pt' x:num><%=dt.Rows[i][13]%></td>
  <td class=xl31 align=right width=84 style='width:63pt' x:num><%=dt.Rows[i][14]%></td>
 </tr>
<%
     }
     }
     }
%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=75 style='width:56pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=84 style='width:63pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
