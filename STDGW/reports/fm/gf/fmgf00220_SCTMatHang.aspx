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
	string p_from_dt = "", p_to_dt = "", p_com_pk = "" ;
	p_from_dt = Request["from_dt"];
	p_to_dt = Request["to_dt"];
	p_com_pk = Request["company_pk"];
	
	int i;
	string l_item_pk = "", l_wh_pk = "";	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00220_SCTMatHang_files/filelist.xml">
<style id="Book1_20402_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl1520402
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
.xl2220402
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:13.5pt;
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
.xl2320402
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
.xl2420402
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
.xl2520402
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
.xl2620402
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
	mso-number-format:"\#\,\#\#0\.000";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2720402
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
	mso-number-format:"\#\,\#\#0\.000";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl2820402
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
	mso-number-format:"\#\,\#\#0\.00";
	text-align:general;
	vertical-align:bottom;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl2920402
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
.xl3020402
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
	text-align:right;
	vertical-align:middle;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3120402
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
.xl3220402
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
	text-align:general;
	vertical-align:bottom;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3320402
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
.xl3420402
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
.xl3520402
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
	text-align:left;
	vertical-align:middle;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3620402
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
	text-align:general;
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

<div id="Book1_20402" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=983 style='border-collapse:
 collapse;table-layout:fixed;width:738pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=256 style='mso-width-source:userset;mso-width-alt:9362;width:192pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col class=xl2620402 wwidth=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl2920402 width=86 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col class=xl3320402 width=76 style='mso-width-source:userset;mso-width-alt:
 2779;width:57pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl2220402 colspan=3 align=left width=407
  style='height:17.25pt;width:305pt'>Sổ chi tiết toàn bộ các mã
  hàng</td>
  <td class=xl1520402 width=67 style='width:50pt'></td>
  <td class=xl2620402 width=57 style='width:43pt'></td>
  <td class=xl2920402 width=86 style='width:65pt'></td>
  <td class=xl3320402 width=76 style='width:57pt'></td>
  <td class=xl1520402 width=82 style='width:62pt'></td>
  <td class=xl1520402 width=68 style='width:51pt'></td>
  <td class=xl1520402 width=77 style='width:58pt'></td>
  <td class=xl1520402 width=63 style='width:47pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl1520402 style='height:12.75pt'></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl2620402></td>
  <td class=xl2920402></td>
  <td class=xl3320402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl2320402 colspan=2 align=left style='height:15.75pt'>Tháng
  3/2010</td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl2620402></td>
  <td class=xl2920402></td>
  <td class=xl3320402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl1520402 style='height:12.75pt'></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl2620402></td>
  <td class=xl2920402></td>
  <td class=xl3320402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
  <td class=xl1520402></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl2420402 width=72 style='height:25.5pt;width:54pt'>Số
  CT</td>
  <td class=xl2420402 width=79 style='border-left:none;width:59pt'>Ngày tháng</td>
  <td class=xl2420402 width=256 style='border-left:none;width:192pt'>Diển
  giãi</td>
  <td class=xl2420402 width=67 style='border-left:none;width:50pt'>Đơn vị</td>
  <td class=xl2720402 width=75 style='width:56pt'>Đơn giá</td>
  <td class=xl3020402 width=86 style='border-left:none;width:65pt'>Lượng Nhập</td>
  <td class=xl3520402 width=76 style='border-left:none;width:57pt'
  x:str="Tiền Nhập"><span style='mso-spacerun:yes'> </span>Tiền Nhập<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl2420402 width=82 style='border-left:none;width:62pt'>Lượng Xuất</td>
  <td class=xl2420402 width=68 style='border-left:none;width:51pt'>Tiền Xuất</td>
  <td class=xl2420402 width=77 style='border-left:none;width:58pt'>Lượng Tồn</td>
  <td class=xl2420402 width=63 style='border-left:none;width:47pt'>Tiền Tồn</td>
 </tr>
 <%
	int j, l_cnt_dtl = 0 ; 
	string l_last_qty = "0", l_last_amt = "0";
	decimal l_end_qty = 0, l_end_amt = 0;
	decimal l_input_qty = 0, l_in_amt = 0, l_output_qty = 0, l_out_amt = 0, l_bal_qty = 0, l_bal_amt=0;
string SQL
	= "select b.dt_ddmm, b.stocktr_no, b.tr_date, b.remark2, b.uprice  " + 
        "    , b.input_qty, b.in_amt, b.output_qty, b.out_amt " +
        "    , b.ac_cd, b.item_code, b.item_name, m.last_qty, m.last_amt, m.item_uom " +
        "from ( " +
        "select to_char(to_date(t.tr_date, 'YYYYMMDD'), 'DD/MM') dt_ddmm  " +
        "    , t.stocktr_no, to_char(to_date(t.tr_date, 'YYYYMMDD'), 'DD/MM/YY') tr_date  " +
        "    , t.remark2, round(decode(t.trin_type, '10', t.in_uprice, t.out_uprice), 0) uprice  " +
        "    , t.input_qty, round(t.in_amt, 2) in_amt, 0 output_qty, 0 out_amt " +
        "    , (select c.ac_cd from tac_abacctcode c where c.pk = a.tac_abacctcode_pk) ac_cd  " +
        "    , (select i.item_code from tco_item i where i.pk = t.tco_item_pk) item_code " +
        "    , (select i.item_name from tco_item i where i.pk = t.tco_item_pk) item_name " +
        "    , t.tco_item_pk " +
        "from tac_stocktr t, tac_crdad d, tac_crda a " +
        "where t.tr_date between '" + p_from_dt + "' and '" + p_to_dt + "'  " +
        "and t.tco_company_pk = '" + p_com_pk + "'  " +
        "and t.del_if = 0  " +
        "and t.tr_status in ('2', '0') " +
        "and t.tr_table_nm = 'TAC_CRDAD' " +
        "and t.tr_table_pk = d.pk " +
        "and d.del_if = 0 " +
        "and d.tac_crda_pk = a.pk " +
        "union all " +
        "select to_char(to_date(t.tr_date, 'YYYYMMDD'), 'DD/MM') dt_ddmm  " +
        "    , t.stocktr_no, to_char(to_date(t.tr_date, 'YYYYMMDD'), 'DD/MM/YY') tr_date  " +
        "    , t.remark2, round(decode(t.trin_type, '10', t.in_uprice, t.out_uprice), 0) uprice  " +
        "    , 0 input_qty, 0 in_amt, t.output_qty, round(t.out_amt, 2) out_amt " +
        "    , (select c.ac_cd from tac_abacctcode c where c.pk = d.debit_acctcode_pk) ac_cd  " +
        "    , (select i.item_code from tco_item i where i.pk = t.tco_item_pk) item_code " +
        "    , (select i.item_name from tco_item i where i.pk = t.tco_item_pk) item_name " +
        "    , t.tco_item_pk " +
        "from tac_stocktr t, tac_omcost_pricerd d " +
        "where t.tr_date between '" + p_from_dt + "' and '" + p_to_dt + "'  " +
        "and t.tco_company_pk = '" + p_com_pk + "'  " +
        "and t.del_if = 0  " +
        "and t.tr_status in ('2', '0') " +
        "and t.tr_table_nm = 'TAC_OMCOST_PRICERD' " +
        "and t.tr_table_pk = d.pk " +
        "and d.del_if = 0 " +
        ") b, " +
        "tac_stockmm m " +
        "where m.tco_item_pk = b.tco_item_pk(+) " +
        "and m.del_if = 0 " +
        "and m.std_ym = substr('" + p_to_dt + "', 1, 6) " +
        "order by b.item_code, b.tr_date " ;
	DataTable dt = ESysLib.TableReadOpen(SQL);	
	for(j = 0; j < dt.Rows.Count; j++)
	{
		if(l_item_pk != dt.Rows[j][10].ToString())
		{
			l_item_pk = dt.Rows[j][10].ToString();
			l_end_qty = decimal.Parse(dt.Rows[j][12].ToString());
			l_end_amt = decimal.Parse(dt.Rows[j][13].ToString());
			//l_input_qty = 0, l_in_amt = 0, l_output_qty = 0, l_out_amt = 0, l_bal_qty = 0, l_bal_amt=0;
			l_input_qty = 0; l_in_amt = 0; l_output_qty = 0; l_out_amt = 0;
			for(i = j ; i < dt.Rows.Count; i++)
			{
				if(dt.Rows[i][10].ToString() == l_item_pk)
				{
					if(dt.Rows[i][5].ToString().Trim() != "")
						l_input_qty += decimal.Parse(dt.Rows[i][5].ToString());
					if(dt.Rows[i][6].ToString().Trim() != "")	
						l_in_amt += decimal.Parse(dt.Rows[i][6].ToString());
					if(dt.Rows[i][7].ToString().Trim() != "")	
						l_output_qty += decimal.Parse(dt.Rows[i][7].ToString());
					if(dt.Rows[i][8].ToString().Trim() != "")	
						l_out_amt += decimal.Parse(dt.Rows[i][8].ToString());
				}
				else
				{
					break;
				}	
			}
			l_bal_qty = l_end_qty + l_input_qty - l_output_qty;
			l_bal_amt = l_end_amt + l_in_amt - l_out_amt;
%>
<tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2520402 align=left width=72 style='height:12.75pt;
  border-top:none;width:54pt'>&nbsp;</td>
  <td class=xl2520402 align=left width=79 style='border-top:none;border-left:
  none;width:59pt'>&nbsp;</td>
  <td class=xl2520402 align=left width=256 style='border-top:none;border-left:
  none;width:192pt'>&nbsp;<%=dt.Rows[j][10]%> - <%=dt.Rows[j][11]%></td>
  <td class=xl2520402 align=left width=67 style='border-top:none;border-left:
  none;width:50pt'>&nbsp;<%=dt.Rows[j][14]%></td>
  <td class=xl2820402 align=right width=57 style='border-top:none;border-left:
  none;width:43pt' x:num></td>
  <td class=xl3120402 width=86 style='border-top:none;border-left:none;
  width:65pt' x:num><%=l_input_qty%></td>
  <td class=xl3420402 width=76 style='border-top:none;border-left:none;
  width:57pt' x:num><span style='mso-spacerun:yes'>        </span><%=l_in_amt%>
  </td>
  <td class=xl3620402 align=right width=82 style='border-top:none;border-left:
  none;width:62pt' x:num><%=l_output_qty%></td>
  <td class=xl3420402 width=68 style='border-top:none;border-left:none;
  width:51pt' x:num><span style='mso-spacerun:yes'>           </span><%=l_out_amt%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl3620402 align=right width=77 style='border-top:none;border-left:
  none;width:58pt' x:num><%=l_bal_qty%></td>
  <td class=xl3220402 align=left width=63 style='border-top:none;border-left:
  none;width:47pt' x:num><span style='mso-spacerun:yes'>    
  </span><%=l_bal_amt%> </td>
 </tr>
<%			
		}	
		if(dt.Rows[j][5].ToString() != "")		
			l_end_qty = l_end_qty + decimal.Parse(dt.Rows[j][5].ToString());  // input_qty
		if(	dt.Rows[j][7].ToString() != "" )
			l_end_qty = l_end_qty - decimal.Parse(dt.Rows[j][7].ToString()); //output_qty
		if(	dt.Rows[j][6].ToString() != "" )
			l_end_amt = l_end_amt + decimal.Parse(dt.Rows[j][6].ToString()); //in_amt
		if(	dt.Rows[j][8].ToString() != "" )
			l_end_amt = l_end_amt - decimal.Parse(dt.Rows[j][8].ToString());	//out_amt
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2520402 align=left width=72 style='height:12.75pt;
  border-top:none;width:54pt'>&nbsp;<%=dt.Rows[j][1]%></td>
  <td class=xl2520402 align=left width=79 style='border-top:none;border-left:
  none;width:59pt'>&nbsp;<%=dt.Rows[j][2]%></td>
  <td class=xl2520402 align=left width=256 style='border-top:none;border-left:
  none;width:192pt'>&nbsp;<%=dt.Rows[j][3]%></td>
  <td class=xl2520402 align=left width=67 style='border-top:none;border-left:
  none;width:50pt'>&nbsp;<%=dt.Rows[j][9]%></td>
  <td class=xl2820402 align=right width=57 style='border-top:none;border-left:
  none;width:43pt' x:num><%=dt.Rows[j][4]%></td>
  <td class=xl3120402 width=86 style='border-top:none;border-left:none;
  width:65pt' x:num><%=dt.Rows[j][5]%></td>
  <td class=xl3420402 width=76 style='border-top:none;border-left:none;
  width:57pt' x:num><span style='mso-spacerun:yes'>        </span><%=dt.Rows[j][6]%>
  </td>
  <td class=xl3620402 align=right width=82 style='border-top:none;border-left:
  none;width:62pt' x:num><%=dt.Rows[j][7]%></td>
  <td class=xl3420402 width=68 style='border-top:none;border-left:none;
  width:51pt' x:num><span style='mso-spacerun:yes'>           </span><%=dt.Rows[j][8]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl3620402 align=right width=77 style='border-top:none;border-left:
  none;width:58pt' x:num><%=l_end_qty%></td>
  <td class=xl3220402 align=left width=63 style='border-top:none;border-left:
  none;width:47pt' x:num><span style='mso-spacerun:yes'>    
  </span><%=l_end_amt%> </td>
 </tr>
<%
	}
%>
	<![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=72 style='width:54pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=63 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
