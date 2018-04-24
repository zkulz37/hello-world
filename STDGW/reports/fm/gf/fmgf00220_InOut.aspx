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
	p_std_ym = p_std_ym.Substring(0, 6);
	p_com_pk = Request["company_pk"];
	p_wh_pk = Request["warehouse_pk"];
	string p_acc_pk = Request["tac_abacctcode_pk"];
	string SQL = "";
	int i;
	string l_month = p_std_ym.Substring(4, 2);	
	string l_year = p_std_ym.Substring(0, 4);


%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Test_files/filelist.xml">
<link rel=Edit-Time-Data href="Test_files/editdata.mso">
<link rel=OLE-Object-Data href="Test_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>vanle</o:LastAuthor>
  <o:LastSaved>2010-12-28T03:30:17Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl35
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
.xl36
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:Standard;
	text-align:right;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:right;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Test</x:Name>
    <x:WorksheetOptions>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=1421 style='border-collapse:
 collapse;table-layout:fixed;width:1067pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=256 style='mso-width-source:userset;mso-width-alt:9362;width:192pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=96 span=2 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=86 span=2 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=82 span=2 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 width=75 style='height:12.75pt;width:56pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=84 style='width:63pt'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl24 align=left style='height:17.25pt'>Báo cáo
  nhâ&#803;p xuâ&#769;t tô&#768;n theo kho có s&#7889; d&#432; và có phát sinh</td>
  <td class=xl24></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 align=left style='height:12.75pt'>(m&#7895;i
  cu&#7889;i tháng s&#7869; in báo cáo này)</td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl31 align=left style='height:15.75pt'>Tha&#769;ng:
  <%=l_month%>/<%=l_year%></td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=15 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td rowspan=2 height=58 class=xl32 width=75 style='border-bottom:.5pt solid black;
  height:43.5pt;width:56pt'>Ma&#771; sô&#769;</td>
  <td rowspan=2 class=xl32 width=256 style='border-bottom:.5pt solid black;
  width:192pt'>Tên Vâ&#803;t t&#432; - Ha&#768;ng ho&#769;a</td>
  <td rowspan=2 class=xl32 width=67 style='border-bottom:.5pt solid black;
  width:50pt'>&#272;&#417;n vi&#803;</td>
  <td rowspan=2 class=xl32 width=96 style='border-bottom:.5pt solid black;
  width:72pt'>L&#432;&#417;&#803;ng &#273;â&#768;u</td>
  <td rowspan=2 class=xl32 width=96 style='border-bottom:.5pt solid black;
  width:72pt'>Ti&#7873;n VND</td>
  <td rowspan=2 class=xl32 width=81 style='border-bottom:.5pt solid black;
  width:61pt'>Ti&#7873;n &#273;&#7847;u k&#7923;</td>
  <td rowspan=2 class=xl32 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>L&#432;&#417;&#803;ng Nhâ&#803;p</td>
  <td rowspan=2 class=xl32 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>Ti&#7873;n VND</td>
  <td rowspan=2 class=xl32 width=72 style='border-bottom:.5pt solid black;
  width:54pt'>Tiê&#768;n Nhâ&#803;p</td>
  <td rowspan=2 class=xl32 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>L&#432;&#417;&#803;ng Xuâ&#769;t</td>
  <td rowspan=2 class=xl32 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>Ti&#7873;n VND</td>
  <td rowspan=2 class=xl32 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Tiê&#768;n Xuâ&#769;t</td>
  <td rowspan=2 class=xl32 width=99 style='border-bottom:.5pt solid black;
  width:74pt'>L&#432;&#417;&#803;ng cuô&#769;i ky&#768;</td>
  <td rowspan=2 class=xl32 width=91 style='border-bottom:.5pt solid black;
  width:68pt'>Ti&#7873;n VND</td>
  <td rowspan=2 class=xl32 width=84 style='border-bottom:.5pt solid black;
  width:63pt'>Ti&#7873;n cu&#7889;i k&#7923;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
 </tr>
 <% 
     int k;
  SQL
    = "select c.ac_grp, " + 
        "sum(b.last_qty) last_qty, sum(b.last_famt) last_famt, sum(b.last_amt) last_amt,  " +
        " nvl(sum(b.input_qty),0) input_qty, nvl(sum(b.in_amt), 0) in_tramt, nvl(sum(b.in_amt), 0) in_amt,  " +
        "nvl(sum(b.output_qty), 0) output_qty, nvl(sum(b.out_amt),0) out_tramt, nvl(sum(b.out_amt),0) out_amt,  " +
        "sum(nvl(b.last_qty, 0) + nvl(b.input_qty, 0) - nvl(b.output_qty, 0)) bal_qty, " +
        "sum(nvl(b.last_famt, 0) + nvl(b.in_tramt, 0) - nvl(b.out_tramt, 0)) bal_tramt, " +
        "sum(nvl(b.last_amt, 0) + nvl(b.in_amt, 0) - nvl(b.out_amt, 0)) bal_amt " +
        "from (  " +
        "select t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk,  " +
        "    nvl(sum(t.last_qty), 0) last_qty, nvl(sum(t.last_famt), 0) last_famt, nvl(sum(t.last_amt), 0) last_amt,  " +
        "    nvl(sum(t.input_qty), 0) input_qty, nvl(sum(t.in_amt), 0) in_tramt, nvl(sum(t.in_amt), 0) in_amt,  " +
        "    nvl(sum(t.output_qty), 0) output_qty, nvl(sum(t.out_tramt), 0) out_tramt, nvl(sum(t.out_amt), 0) out_amt    " +
        "from (  " +
        "select m.tco_item_pk, m.tac_abacctcode_pk, m.tin_warehouse_pk, m.last_qty, m.last_amt, m.last_famt, " +
        "    0 input_qty, 0 in_tramt, 0 in_amt, 0 output_qty, 0 out_tramt, 0 out_amt   " +
        "from tac_stockmm m  " +
        "where m.std_ym = '" + p_std_ym + "'  " +
        "and m.tco_company_pk = '" + p_com_pk + "'" +
        "and m.del_if = 0  " +
        "and ( m.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0' )  " +
        " and m.last_qty <> 0  " +
        " and ( m.tac_abacctcode_pk like '" + p_acc_pk + "' or '" + p_acc_pk + "' is null)  " +
        "union all  " +
        "select a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk, 0 last_qty, 0 last_famt, 0 last_amt,  " +
        "    nvl(sum(a.input_qty), 0) input_qty, nvl(sum(a.in_tramt), 0) in_tramt,  " +
        "     nvl(sum(a.in_amt), 0) in_amt, nvl(sum(a.output_qty), 0) output_qty,   " +
        "     nvl(sum(a.out_tramt), 0) out_tramt, nvl(sum(a.out_amt), 0) out_amt  " +
        "    from tac_stocktr a  " +
        "    where a.std_ym = '" + p_std_ym + "'  " +
        "    and a.del_if = 0  " +
        "    and a.tr_status in ('1','2', '0')  " +
        "    and a.tco_company_pk = '" + p_com_pk + "'  " +
        "    and ( a.trin_type = '10' or a.trout_type = '10')  " +
        "    and ( a.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0' )  " +
        " and (a.tac_abacctcode_pk like '" + p_acc_pk + "' or '" + p_acc_pk + "' is null ) " +
        "    group by a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk  " +
        "    ) t  " +
        "group by t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk  " +
        "    ) b,  " +
        "    comm.tco_item i,  " +
        " (select distinct d.tac_abacctcode_pk, p.ac_grp " +
        " from tac_abtracgrp p, tac_abtracgrpd d " +
        " where p.pk = d.tac_abtracgrp_pk " +
        " and p.del_if = 0 " +
        " and d.del_if = 0 " +
        " and p.ac_grp in ('152', '153', '156') ) c " +        
        "    where b.tco_item_pk = i.pk and b.tac_abacctcode_pk = c.tac_abacctcode_pk " +
        " and i.del_if = 0 " +        
        " group by c.ac_grp " +
        " order by c.ac_grp  " ;
  DataTable dtAcc = new DataTable();
  dtAcc = ESysLib.TableReadOpen(SQL);
  string l_last_qty = "0", l_last_famt = "0", l_last_amt = "0";
  string l_input_qty = "0", l_input_famt = "0", l_input_amt = "0";
  string l_output_qty = "0", l_output_famt = "0", l_output_amt = "0";
  string l_end_qty = "0", l_end_famt = "0", l_end_amt = "0";   
     string ls_ac_grp = "", l_acc_cd = "";
	int j;
     string ls_itemgrp = "";
     	DataTable dtMst = new DataTable();
DataTable dt = new DataTable();
for (k = 0; k < dtAcc.Rows.Count; k++)
{
    l_acc_cd = dtAcc.Rows[k][0].ToString();
    if (dtAcc.Rows[k][0].ToString() == "152")
    {
        ls_ac_grp = "2 - Nguyên liệu, vật liệu";
    }
    else if (dtAcc.Rows[k][0].ToString() == "153")
    {
        ls_ac_grp = "3 - Công cụ, dụng cụ";
    }
    else if (dtAcc.Rows[k][0].ToString() == "156")
    {
        ls_ac_grp = "4 - Hàng hóa";
    }


    l_last_qty = dtAcc.Rows[k][1].ToString();
    l_last_famt = dtAcc.Rows[k][2].ToString();
    l_last_amt = dtAcc.Rows[k][3].ToString();

    l_input_qty = dtAcc.Rows[k][4].ToString();
    l_input_famt = dtAcc.Rows[k][5].ToString();
    l_input_amt = dtAcc.Rows[k][6].ToString();

    l_output_qty = dtAcc.Rows[k][7].ToString();
    l_output_famt = dtAcc.Rows[k][8].ToString();
    l_output_amt = dtAcc.Rows[k][9].ToString();

    l_end_qty = dtAcc.Rows[k][10].ToString();
    l_end_famt = dtAcc.Rows[k][11].ToString();
    l_end_amt = dtAcc.Rows[k][12].ToString();      
  
        
 %>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=3 height=17 class=xl33 width=398 style='border-right:.5pt solid black;
  height:12.75pt;width:298pt'><%=ls_ac_grp%></td>
  <td class=xl41 width=96 style='width:72pt' x:num><%=l_last_qty%></td>
  <td class=xl37 width=96 style='width:72pt' x:num><%=l_last_famt%></td>
  <td class=xl25 width=81 style='width:61pt' x:num><%=l_last_amt%></td>
  <td class=xl39 width=86 style='width:65pt' x:num><%=l_input_qty%></td>
  <td class=xl28 width=86 style='width:65pt' x:num><%=l_input_famt%></td>
  <td class=xl39 width=72 style='width:54pt' x:num><%=l_input_amt%></td>
  <td class=xl39 width=82 style='width:62pt' x:num><%=l_output_qty%></td>
  <td class=xl28 width=82 style='width:62pt' x:num><%=l_output_famt%></td>
  <td class=xl27 width=68 style='width:51pt' x:num><%=l_output_amt%></td>
  <td class=xl39 width=99 style='width:74pt' x:num><%=l_end_qty%></td>
  <td class=xl39 width=91 style='width:68pt' x:num><%=l_end_famt%></td>
  <td class=xl27 width=84 style='width:63pt' x:num><%=l_end_amt%></td>
 </tr>
 <% 
     SQL
       = "  SELECT substr(i.item_code, 1, 2) item_grp,          " +
           "         sum(b.last_qty) last_qty, " +
           "         sum(b.last_famt) last_famt, " +
           "         sum(b.last_amt) last_amt, " +
           "         NVL(sum(b.input_qty), 0) input_qty, " +
           "         NVL(sum(b.in_tramt), 0) in_tramt, " +
           "         NVL(sum(b.in_amt), 0) in_amt, " +
           "         NVL(sum(b.output_qty), 0) output_qty, " +
           "         NVL(sum(b.out_tramt), 0) out_tramt, " +
           "         NVL(sum(b.out_amt), 0) out_amt , " +
           "         NVL(sum(b.last_qty), 0) + NVL (sum(b.input_qty), 0) - NVL (sum(b.output_qty), 0) bal_qty, " +
           "         NVL(sum(b.last_famt), 0) + NVL (sum(b.in_tramt), 0) - NVL (sum(b.out_tramt), 0) bal_famt,    " +
           "         NVL(sum(b.last_amt), 0) + NVL (sum(b.in_amt), 0) - NVL (sum(b.out_amt), 0) bal_amt " +
           "    FROM (  SELECT t.tco_item_pk, " +
           "                   t.tac_abacctcode_pk, " +
           "                   t.tin_warehouse_pk, " +
           "                   NVL (SUM (t.last_qty), 0) last_qty, " +
           "                   NVL (SUM (t.last_famt), 0) last_famt, " +
           "                   NVL (SUM (t.last_amt), 0) last_amt, " +
           "                   NVL (SUM (t.input_qty), 0) input_qty, " +
           "                   NVL (SUM (t.in_tramt), 0) in_tramt, " +
           "                   NVL (SUM (t.in_amt), 0) in_amt, " +
           "                   NVL (SUM (t.output_qty), 0) output_qty, " +
           "                   NVL (SUM (t.out_tramt), 0) out_tramt, " +
           "                   NVL (SUM (t.out_amt), 0) out_amt " +
           "              FROM (SELECT m.tco_item_pk, " +
           "                           m.tac_abacctcode_pk, " +
           "                           m.tin_warehouse_pk, " +
           "                           m.last_qty, " +
           "                           m.last_famt, " +
           "                           m.last_amt, " +
           "                           0 input_qty, " +
           "                           0 in_tramt, " +
           "                           0 in_amt, " +
           "                           0 output_qty, " +
           "                           0 out_tramt, " +
           "                           0 out_amt " +
           "                      FROM tac_stockmm m " +
           "                     WHERE     m.std_ym = '" + p_std_ym + "' " +
           "                           AND m.tco_company_pk = '" + p_com_pk + "' " +
           "                           AND m.del_if = 0 " +
           "                           AND (m.tin_warehouse_pk LIKE '" + p_wh_pk + "' OR '" + p_wh_pk + "' = '0') " +
           "                           AND m.last_qty <> 0 " +
           "                           AND (m.tac_abacctcode_pk like '" + p_acc_pk + "' or '" + p_acc_pk + "' is null ) " +
           "                    UNION ALL " +
           "                      SELECT a.tco_item_pk, " +
           "                             a.tac_abacctcode_pk, " +
           "                             a.tin_warehouse_pk, " +
           "                             0 last_qty, " +
           "                             0 last_famt, " +
           "                             0 last_amt, " +
           "                             NVL (SUM (a.input_qty), 0) input_qty, " +
           "                             NVL (SUM (a.in_tramt), 0) in_tramt, " +
           "                             NVL (SUM (a.in_amt), 0) in_amt, " +
           "                             NVL (SUM (a.output_qty), 0) output_qty, " +
           "                             NVL (SUM (a.out_tramt), 0) out_tramt, " +
           "                             NVL (SUM (a.out_amt), 0) out_amt                              " +
           "                        FROM tac_stocktr a " +
           "                       WHERE     a.std_ym = '" + p_std_ym + "' " +
           "                             AND a.del_if = 0 " +
           "                             AND a.tr_status IN ('1', '2', '0') " +
           "                             AND a.tco_company_pk = '" + p_com_pk + "' " +
           "                             AND (a.trin_type = '10' OR a.trout_type = '10') " +
           "                             AND (a.tin_warehouse_pk LIKE '" + p_wh_pk + "' OR '" + p_wh_pk + "' = '0') " +
           "                             AND (a.tac_abacctcode_pk like '" + p_acc_pk + "' or '' is null ) " +
           "                    GROUP BY a.tco_item_pk, " +
           "                             a.tac_abacctcode_pk, " +
           "                             a.tin_warehouse_pk) t " +
           "          GROUP BY t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk) b, " +
           "         comm.tco_item i          " +
           "   WHERE b.tco_item_pk = i.pk      " +
           " and b.tac_abacctcode_pk in (select distinct d.tac_abacctcode_pk " +
           " from tac_abtracgrp p, tac_abtracgrpd d " +
               " where p.pk = d.tac_abtracgrp_pk " +
               " and p.del_if = 0 " +
               " and d.del_if = 0 " +
               " and p.ac_grp = '" + l_acc_cd + "' ) " +
           "   group by substr(i.item_code, 1, 2) " +
           "ORDER BY substr(i.item_code, 1, 2) ASC ";
     dtMst = ESysLib.TableReadOpen(SQL);

     for (i = 0; i < dtMst.Rows.Count; i++)
     {
         ls_itemgrp = dtMst.Rows[i][0].ToString();
         SQL
            = "select i.item_code, i.item_name  " +
                ", (select uom_nm from comm.tco_uom  where uom_code = i.uom and del_if = 0) uom  " +
                ", b.last_qty, b.last_famt, b.last_amt,  " +
                "nvl(b.input_qty,0) input_qty, nvl(b.in_tramt, 0) in_tramt, nvl(b.in_amt, 0) in_amt,  " +
                "nvl(b.output_qty, 0) output_qty, nvl(b.out_tramt,0) out_tramt, nvl(b.out_amt,0) out_amt,  " +
                "nvl(b.last_qty, 0) + nvl(b.input_qty, 0) - nvl(b.output_qty, 0) bal_qty,  " +
                "nvl(b.last_famt, 0) + nvl(b.in_tramt, 0) - nvl(b.out_tramt, 0) bal_famt, " +
                "nvl(b.last_amt, 0) + nvl(b.in_amt, 0) - nvl(b.out_amt, 0) bal_amt  " +
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
                "and ( m.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0' )  " +
                " and m.last_qty <> 0  " +
                " and ( m.tac_abacctcode_pk like '" + p_acc_pk + "' or '' is null)  " +
                "union all  " +
                "select a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk, 0 last_qty, 0 last_famt, 0 last_amt,  " +
                "    nvl(sum(a.input_qty), 0) input_qty, nvl(sum(a.in_tramt), 0) in_tramt,  " +
                "     nvl(sum(a.in_amt), 0) in_amt, nvl(sum(a.output_qty), 0) output_qty,   " +
                "     nvl(sum(a.out_tramt), 0) out_amt, nvl(sum(a.out_amt), 0) out_amt  " +
                "    from tac_stocktr a  " +
                "    where a.std_ym = '" + p_std_ym + "'  " +
                "    and a.del_if = 0  " +
                "    and a.tr_status in ('1','2', '0')  " +
                "    and a.tco_company_pk = '" + p_com_pk + "'  " +
                "    and ( a.trin_type = '10' or a.trout_type = '10')  " +
                "    and ( a.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0' )  " +
                " and (a.tac_abacctcode_pk like '" + p_acc_pk + "' or '" + p_acc_pk + "' is null ) " +
                "    group by a.tco_item_pk, a.tac_abacctcode_pk, a.tin_warehouse_pk  " +
                "    ) t  " +
                "group by t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk  " +
                "    ) b,  " +
                "    comm.tco_item i  " +
                "    where b.tco_item_pk = i.pk  " +
                " and i.item_code like '" + ls_itemgrp + "%'  " +
                " order by i.item_code asc  ";
         //Response.Write(SQL);
         //Response.End();
         dt = ESysLib.TableReadOpen(SQL);
         if (dtMst.Rows.Count > 0)
         {
             l_last_qty = dtMst.Rows[i][1].ToString();
             l_last_famt = dtMst.Rows[i][2].ToString();
             l_last_amt = dtMst.Rows[i][3].ToString();

             l_input_qty = dtMst.Rows[i][4].ToString();
             l_input_famt = dtMst.Rows[i][5].ToString();
             l_input_amt = dtMst.Rows[i][6].ToString();

             l_output_qty = dtMst.Rows[i][7].ToString();
             l_output_famt = dtMst.Rows[i][8].ToString();
             l_output_amt = dtMst.Rows[i][9].ToString();

             l_end_qty = dtMst.Rows[i][10].ToString();
             l_end_famt = dtMst.Rows[i][11].ToString();
             l_end_amt = dtMst.Rows[i][12].ToString();

         }
 %>
 
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl26 width=75 style='height:12.75pt;width:56pt'><%=ls_itemgrp%></td>
  <td class=xl25 width=256 style='width:192pt'>&nbsp;</td>
  <td class=xl25 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl41 align=right width=96 style='width:72pt' x:num><%=l_last_qty%></td>
  <td class=xl28 width=96 style='width:72pt' x:num ><%=l_last_famt%></td>
  <td class=xl27 width=81 style='width:61pt' x:num><%=l_last_amt%></td>
  <td class=xl39 width=86 style='width:65pt' x:num><%=l_input_qty%></td>
  <td class=xl28 width=86 style='width:65pt' x:num><%=l_input_famt%></td>
  <td class=xl39 width=72 style='width:54pt' x:num><%=l_input_amt%></td>
  <td class=xl39 width=82 style='width:62pt' x:num><%=l_output_qty%></td>
  <td class=xl28 width=82 style='width:62pt' x:num><%=l_output_famt%></td>
  <td class=xl27 width=68 style='width:51pt' x:num><%=l_output_amt%></td>
  <td class=xl39 width=99 style='width:74pt' x:num><%=l_end_qty%></td>
  <td class=xl39 width=91 style='width:68pt' x:num ><%=l_end_famt%></td>
  <td class=xl27 width=84 style='width:63pt' x:num><%=l_end_amt%></td>
 </tr>
 <% 
     for (j = 0; j < dt.Rows.Count; j++)
     {
 %>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl29 align=left width=75 style='height:12.75pt;
  width:56pt'><%=dt.Rows[j][0]%></td>
  <td class=xl30 align=left width=256 style='width:192pt'><%=dt.Rows[j][1]%></td>
  <td class=xl42 width=67 style='width:50pt'><%=dt.Rows[j][2]%></td>
  <td class=xl30 align=right width=96 style='width:72pt' x:num><%=dt.Rows[j][3]%></td>
  <td class=xl37 width=96 style='width:72pt' x:num><%=dt.Rows[j][4]%></td>
  <td class=xl30 align=right width=81 style='width:61pt' x:num><%=dt.Rows[j][5]%></td>
  <td class=xl40 width=86 style='width:65pt' x:num><%=dt.Rows[j][6]%></td>
  <td class=xl37 width=86 style='width:65pt' x:num><%=dt.Rows[j][7]%></td>
  <td class=xl40 width=72 style='width:54pt' x:num><%=dt.Rows[j][8]%></td>
  <td class=xl40 width=82 style='width:62pt' x:num><%=dt.Rows[j][9]%></td>
  <td class=xl37 width=82 style='width:62pt' x:num ><%=dt.Rows[j][10]%></td>
  <td class=xl38 width=68 style='width:51pt' x:num><%=dt.Rows[j][11]%></td>
  <td class=xl40 width=99 style='width:74pt' x:num><%=dt.Rows[j][12]%></td>
  <td class=xl37 width=91 style='width:68pt' x:num><%=dt.Rows[j][13]%></td>
  <td class=xl38 width=84 style='width:63pt' x:num><%=dt.Rows[j][14]%></td>
 </tr>
 <% 
     }
     }
}
 %>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=75 style='width:56pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=84 style='width:63pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
