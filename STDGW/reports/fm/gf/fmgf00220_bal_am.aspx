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
string p_com_pk = "", p_std_ym = "";
	p_com_pk = Request["company_pk"];
	p_std_ym = Request["std_ym"];
	p_std_ym = p_std_ym.Substring(0, 6);
string SQL= "";
 SQL
	= "select t.item_code, t.item_name, t.uom, m.last_qty, m.last_amt, " + 
        "    i.input_qty, i.in_amt, i.output_qty, i.out_amt,  " +
        "    m.last_qty + nvl(i.input_qty,0) - nvl(i.output_qty,0) bal_qty, " +
        "    m.last_amt + nvl(i.in_amt,0) - nvl(i.out_amt,0) bal_amt " +
        "from tac_stockmm m, " +
        "    ( select tco_item_pk, tac_abacctcode_pk, tin_warehouse_pk, nvl(sum(input_qty), 0) input_qty, " +
        "        nvl(sum(in_amt),0) in_amt, nvl(sum(output_qty), 0) output_qty, nvl(sum(out_amt),0) out_amt " +
        "        from tac_stocktr  " +
        "        where tco_company_pk = '" + p_com_pk + "' " +
        "        and del_if = 0 " +
        "        and std_ym = '" + p_std_ym + "' " +
        "        and tr_status in ('2', '0') " +
        "        and (trin_type = '10' or trout_type = '10')         " +
        "        group by tco_item_pk, tac_abacctcode_pk, tin_warehouse_pk " +
        "    ) i, " +
        "    comm.tco_item t " +
        "where m.std_ym = '" + p_std_ym + "' " +
        "    and m.del_if = 0 " +
        "    and m.tco_company_pk = '" + p_com_pk + "' " +
        "    and m.tco_item_pk = i.tco_item_pk(+) " +
        "    and m.tac_abacctcode_pk = i.tac_abacctcode_pk(+) " +
        "    and m.tin_warehouse_pk = i.tin_warehouse_pk(+) " +
        "    and m.tco_item_pk = t.pk      " ;
    SQL = SQL + " and ( m.last_qty + nvl(i.input_qty,0) - nvl(i.output_qty,0) < 0 " +
          " or ( m.last_qty + nvl(i.input_qty,0) - nvl(i.output_qty,0) = 0  " +
               " and m.last_amt + nvl(i.in_amt,0) - nvl(i.out_amt,0) <> 0) " +
       " ) ";		
	DataTable dt = ESysLib.TableReadOpen(SQL);
	int i;
	decimal l_tot_b_qty = 0, l_tot_b_amt = 0;
	decimal l_tot_i_qty = 0, l_tot_i_amt = 0;
	decimal l_tot_o_qty = 0, l_tot_o_amt = 0;
	decimal l_tot_e_qty = 0, l_tot_e_amt = 0;	
	string l_month = p_std_ym.Substring(4, 2);
	string l_year = p_std_ym.Substring(0, 4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00220_bal_am_files/filelist.xml">
<style id="fmgf00220_bal_am_16356_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl1516356
	{padding-top:1px;
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
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2216356
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2316356
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2416356
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl2516356
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl2616356
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl2716356
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl2816356
	{padding-top:1px;
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
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2916356
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:bottom;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3016356
	{padding-top:1px;
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
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3116356
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:bottom;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3216356
	{padding-top:1px;
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
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3316356
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:right;
	vertical-align:bottom;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="fmgf00220_bal_am_16356" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1045 style='border-collapse:
 collapse;table-layout:fixed;width:785pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=256 style='mso-width-source:userset;mso-width-alt:9362;width:192pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col class=xl3016356 width=96 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <col class=xl2816356 width=81 style='mso-width-source:userset;mso-width-alt:
 2962;width:61pt'>
 <col class=xl3016356 width=86 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col class=xl2816356 width=72 style='mso-width-source:userset;mso-width-alt:
 2633;width:54pt'>
 <col class=xl3016356 width=82 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl3216356 width=68 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl3016356 width=99 style='mso-width-source:userset;mso-width-alt:
 3620;width:74pt'>
 <col class=xl2816356 width=84 style='mso-width-source:userset;mso-width-alt:
 3072;width:63pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl2216356 colspan=4 align=left width=473
  style='height:15.75pt;width:355pt'>Bảng báo cáo những bất hợp lệ trong
  kho</td>
  <td class=xl2816356 width=81 style='width:61pt'></td>
  <td class=xl3016356 width=86 style='width:65pt'></td>
  <td class=xl2816356 width=72 style='width:54pt'></td>
  <td class=xl3016356 width=82 style='width:62pt'></td>
  <td class=xl3216356 width=68 style='width:51pt'></td>
  <td class=xl3016356 width=99 style='width:74pt'></td>
  <td class=xl2816356 width=84 style='width:63pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2316356 style='height:15.0pt'></td>
  <td class=xl1516356></td>
  <td class=xl1516356></td>
  <td class=xl3016356></td>
  <td class=xl2816356></td>
  <td class=xl3016356></td>
  <td class=xl2816356></td>
  <td class=xl3016356></td>
  <td class=xl3216356></td>
  <td class=xl3016356></td>
  <td class=xl2816356></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2316356 colspan=2 align=left style='height:15.0pt'>Tháng:
  <%=l_month%>/<%=l_year%></td>
  <td class=xl1516356></td>
  <td class=xl3016356></td>
  <td class=xl2816356></td>
  <td class=xl3016356></td>
  <td class=xl2816356></td>
  <td class=xl3016356></td>
  <td class=xl3216356></td>
  <td class=xl3016356></td>
  <td class=xl2816356></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl1516356 style='height:12.75pt'></td>
  <td class=xl1516356></td>
  <td class=xl1516356></td>
  <td class=xl3016356></td>
  <td class=xl2816356></td>
  <td class=xl3016356></td>
  <td class=xl2816356></td>
  <td class=xl3016356></td>
  <td class=xl3216356></td>
  <td class=xl3016356></td>
  <td class=xl2816356></td>
 </tr>
 <tr height=68 style='height:51.0pt'>
  <td height=68 class=xl2416356 width=73 style='height:51.0pt;width:55pt'>Mã
  số</td>
  <td class=xl2416356 width=256 style='border-left:none;width:192pt'>Tên Vật
  tư - Hàng hóa</td>
  <td class=xl2416356 width=48 style='border-left:none;width:36pt'>Đơn vị</td>
  <td class=xl2716356 width=96 style='border-left:none;width:72pt'>Lượng đầu
  kỳ</td>
  <td class=xl2616356 width=81 style='border-left:none;width:61pt'
  x:str><span style='mso-spacerun:yes'> </span>Tiền đầu
  kỳ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl2716356 width=86 style='border-left:none;width:65pt'>Lượng Nhập</td>
  <td class=xl2616356 width=72 style='border-left:none;width:54pt'
  x:str><span style='mso-spacerun:yes'> </span>Tiền Nhập<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl2716356 width=82 style='border-left:none;width:62pt'>Lượng Xuất</td>
  <td class=xl2416356 width=68 style='border-left:none;width:51pt'>Tiền Xuất</td>
  <td class=xl2716356 width=99 style='border-left:none;width:74pt'>Lượng cuối
  kỳ</td>
  <td class=xl2616356 width=84 style='border-left:none;width:63pt'
  x:str><span style='mso-spacerun:yes'> </span>Tiền cuối
  kỳ<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <%
	for(i = 0; i < dt.Rows.Count ; i++)
	{
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2516356 align=left width=73 style='height:12.75pt;
  border-top:none;width:55pt'>&nbsp;<%=dt.Rows[i][0]%></td>
  <td class=xl2516356 align=left width=256 style='border-top:none;border-left:
  none;width:192pt'>&nbsp;<%=dt.Rows[i][1]%></td>
  <td class=xl2516356 align=left width=48 style='border-top:none;border-left:
  none;width:36pt'>&nbsp;<%=dt.Rows[i][2]%></td>
  <td class=xl3116356 width=96 style='border-top:none;border-left:none;
  width:72pt' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl2916356 width=81 style='border-top:none;border-left:none;
  width:61pt' x:num><span style='mso-spacerun:yes'>         
  </span><%=dt.Rows[i][4]%> </td>
  <td class=xl3116356 width=86 style='border-top:none;border-left:none;
  width:65pt' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl2916356 width=72 style='border-top:none;border-left:none;
  width:54pt' x:num><span style='mso-spacerun:yes'>           
  </span><%=dt.Rows[i][6]%><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl3116356 width=82 style='border-top:none;border-left:none;
  width:62pt' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl3316356 width=68 style='border-top:none;border-left:none;
  width:51pt' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl3116356 width=99 style='border-top:none;border-left:none;
  width:74pt' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl2916356 width=84 style='border-top:none;border-left:none;
  width:63pt' x:num><span style='mso-spacerun:yes'>           
  </span><%=dt.Rows[i][10]%> </td>
 </tr>
 <%
	}
 %>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=73 style='width:55pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=48 style='width:36pt'></td>
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

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
