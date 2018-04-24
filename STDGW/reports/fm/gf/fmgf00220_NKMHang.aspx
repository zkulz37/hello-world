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
	string p_std_ym = Request["to_dt"];
	p_std_ym = p_std_ym.Substring(0, 6);
	string p_com_pk = Request["company_pk"];
string SQL
	= "select i.item_code, i.item_name " + 
        ", (select uom_nm from tco_uom where uom_code = i.uom and del_if = 0) uom " +
        ", a.input_qty, a.uprice, a.in_amt, a.output_qty, a.uprice out_uprice " +
        ", a.out_amt, c.ac_cd " +
        "from ( " +
        "select t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk, " +
        "    sum(t.input_qty) input_qty " +
        "    , round((nvl(t.in_amt, 0) + nvl(t.out_amt, 0)) / (nvl(t.input_qty, 0) + nvl(t.output_qty, 0)), 5) uprice " +
        "    , sum(t.in_amt) in_amt " +
        "    , sum(t.output_qty) output_qty, sum(t.out_amt) out_amt     " +
        "from tac_stocktr t " +
        "where t.std_ym = '" + p_std_ym + "' " +
        "and t.del_if = 0 " +
        "and t.tco_company_pk = '" + p_com_pk + "' " +
        "and t.tr_status in ('2', '0', '1') " +
        "group by t.tco_item_pk, t.tac_abacctcode_pk, t.tin_warehouse_pk " +
        "        , round((nvl(t.in_amt, 0) + nvl(t.out_amt, 0)) / (nvl(t.input_qty, 0) + nvl(t.output_qty, 0)), 5) " +
        ") a, tco_item i " +
        ", tac_abacctcode c " +
        "where a.tco_item_pk = i.pk " +
        "and a.tac_abacctcode_pk = c.pk " +
        "order by i.item_code " ;
	DataTable dt = ESysLib.TableReadOpen(SQL);	
	int i;	
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00220_NKMHang_files/filelist.xml">
<style id="Book3_11900_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl1511900
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
.xl2211900
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
.xl2311900
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
.xl2411900
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
.xl2511900
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
.xl2611900
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
.xl2711900
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
	mso-number-format:0;
	text-align:right;
	vertical-align:bottom;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl2811900
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
	mso-number-format:"\#\,\#\#0\.000";
	text-align:general;
	vertical-align:bottom;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl2911900
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
.xl3011900
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
	mso-number-format:"\#\,\#\#0\.000";
	text-align:right;
	vertical-align:bottom;
	border:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3111900
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
.xl3211900
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
.xl3311900
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
	text-align:left;
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

<div id="Book3_11900" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=983 style='border-collapse:
 collapse;table-layout:fixed;width:739pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <col width=209 style='mso-width-source:userset;mso-width-alt:7643;width:157pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl2211900 colspan=2 align=left width=217
  style='height:17.25pt;width:163pt'>Sổ nhật ký Mua hàng</td>
  <td class=xl1511900 width=209 style='width:157pt'></td>
  <td class=xl1511900 width=86 style='width:65pt'></td>
  <td class=xl1511900 width=59 style='width:44pt'></td>
  <td class=xl1511900 width=72 style='width:54pt'></td>
  <td class=xl1511900 width=82 style='width:62pt'></td>
  <td class=xl1511900 width=65 style='width:49pt'></td>
  <td class=xl1511900 width=68 style='width:51pt'></td>
  <td class=xl1511900 width=72 style='width:54pt'></td>
  <td class=xl1511900 width=53 style='width:40pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl1511900 style='height:12.75pt'></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl2311900 colspan=2 align=left style='height:15.75pt'>Tháng
  <%=p_std_ym.Substring(4, 2)%>/<%=p_std_ym.Substring(0, 4)%></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl1511900 style='height:12.75pt'></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
  <td class=xl1511900></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2411900 width=72 style='height:12.75pt;width:54pt'>Mã
  hiệu</td>
  <td class=xl2411900 width=145 style='border-left:none;width:109pt'>Tên vật
  tư - hàng hoá</td>
  <td class=xl2411900 width=209 style='border-left:none;width:157pt'>Đơn vị</td>
  <td class=xl2411900 width=86 style='border-left:none;width:65pt'>Lượng Nhập</td>
  <td class=xl2411900 width=59 style='border-left:none;width:44pt'>Đơn Giá</td>
  <td class=xl2411900 width=72 style='border-left:none;width:54pt'>Tiền Nhập</td>
  <td class=xl2411900 width=82 style='border-left:none;width:62pt'>Lượng Xuất</td>
  <td class=xl2411900 width=65 style='border-left:none;width:49pt'>Đơn Giá</td>
  <td class=xl2411900 width=68 style='border-left:none;width:51pt'>Tiền Xuất</td>
  <td class=xl2411900 width=72 style='border-left:none;width:54pt'>Ghi chú</td>
  <td class=xl2411900 width=53 style='border-left:none;width:40pt'>F11</td>
 </tr>
 <%
	for(i = 0; i < dt.Rows.Count; i++)
	{
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl2511900 align=left width=72 style='height:12.75pt;
  border-top:none;width:54pt'>&nbsp;<%=dt.Rows[i][0]%></td>
  <td class=xl3311900 width=145 style='border-top:none;border-left:none;
  width:109pt'>&nbsp;<%=dt.Rows[i][1]%></td>
  <td class=xl2511900 align=left width=209 style='border-top:none;border-left:
  none;width:157pt'>&nbsp;<%=dt.Rows[i][2]%></td>
  <td class=xl2711900 width=86 style='border-top:none;border-left:none;
  width:65pt'>&nbsp; <%=dt.Rows[i][3]%></td>
  <td class=xl3011900 width=59 style='border-top:none;border-left:none;
  width:44pt' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl2911900 align=left width=72 style='border-top:none;border-left:
  none;width:54pt' x:num><span style='mso-spacerun:yes'>  
  </span><%=dt.Rows[i][5]%> </td>
  <td class=xl3111900 width=82 style='border-top:none;border-left:none;
  width:62pt' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl3011900 width=65 style='border-top:none;border-left:none;
  width:49pt' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl2911900 width=68 style='border-top:none;border-left:none;
  width:51pt' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl2611900 width=72 style='border-top:none;border-left:none;
  width:54pt'>&nbsp; </td>
  <td class=xl2511900 align=left width=53 style='border-top:none;border-left:
  none;width:40pt'>&nbsp;<%=dt.Rows[i][9]%></td>
 </tr>
<%
	}
%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=72 style='width:54pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=209 style='width:157pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=53 style='width:40pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
