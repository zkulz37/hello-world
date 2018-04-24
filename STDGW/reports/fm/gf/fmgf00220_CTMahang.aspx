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
	string SQL = "";
	string p_from_dt = "", p_to_dt = "", p_com_pk = "", p_wh_pk = "", p_item_pk="";
	p_from_dt = Request["from_dt"];
	p_to_dt = Request["to_dt"];
	p_com_pk = Request["company_pk"];
	p_wh_pk = Request["warehouse_pk"];
	p_item_pk = Request["item_pk"];
	SQL = "select m.last_qty, m.last_amt, i.item_code, i.item_name, w.wh_id " +
	" from tac_stockmm m, tco_item i, inv.tin_warehouse w where m.std_ym = substr('" + p_from_dt + "', 1, 6) and m.del_if = 0 " +
		" and tco_item_pk = '" + p_item_pk + "' and tin_warehouse_pk like '" + p_wh_pk + "' or '" +
		p_wh_pk + "' = '0' and m.tco_item_pk = i.pk and m.tin_warehouse_pk = w.pk ";
	DataTable dt = ESysLib.TableReadOpen(SQL);
	string l_last_qty = "0", l_last_amt = "0", l_tuden_ngay = "";
	string l_item_code = "", l_item_name = "", l_wh_id = "";
	if(dt.Rows.Count > 0)
	{
		l_last_qty = dt.Rows[0][0].ToString();
		l_last_amt = dt.Rows[0][1].ToString();
		l_item_code = dt.Rows[0][2].ToString();
		l_item_name = dt.Rows[0][3].ToString();
		l_wh_id = dt.Rows[0][4].ToString();
	}	
	l_tuden_ngay = "Từ ngày " + p_from_dt.Substring(6, 2) + "/" + p_from_dt.Substring(4, 2) + "/" + p_from_dt.Substring(0, 4);
	l_tuden_ngay += " - " + p_to_dt.Substring(6, 2) + "/" + p_to_dt.Substring(4, 2) + "/" + p_to_dt.Substring(0, 4);
 SQL
	= "select to_char(to_date(t.tr_date, 'YYYYMMDD'), 'DD/MM') dt_ddmm " + 
        "    , t.stocktr_no, to_char(to_date(t.tr_date, 'YYYYMMDD'), 'DD/MM/YY') tr_date " +
        "    , t.remark2, decode(t.trin_type, '10', t.in_uprice, t.out_uprice) uprice " +
        "    , t.input_qty, t.in_amt, t.output_qty, t.out_amt " +
        "from tac_stocktr t " +
        "where t.tco_item_pk like '" + p_item_pk + "' " +
        "and ( t.tin_warehouse_pk like '" + p_wh_pk + "' or '" + p_wh_pk + "' = '0')  " +
        "and t.tr_date between '" + p_from_dt + "' and '" + p_to_dt + "' " +
        "and t.tco_company_pk = '" + p_com_pk + "' " +
        "and t.del_if = 0 " +
        "and t.tr_status in ('2', '0', '1') " ;
	DataTable dtDtl = ESysLib.TableReadOpen(SQL);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00220_CTMahang_files/filelist.xml">
<link rel=Edit-Time-Data href="fmgf00220_CTMahang_files/editdata.mso">
<link rel=OLE-Object-Data href="fmgf00220_CTMahang_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:Created>2010-04-25T21:29:51Z</o:Created>
  <o:LastSaved>2010-04-25T21:51:19Z</o:LastSaved>
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
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl29
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	border:.5pt solid black;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid black;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid black;
	white-space:normal;}
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
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PublishObjects>
     <x:PublishObject>
      <x:Id>26534</x:Id>
      <x:DivID>Book3_26534</x:DivID>
      <x:SourceType>SourceSheet</x:SourceType>
      <x:HtmlType>HtmlStatic</x:HtmlType>
      <x:Location HRef="D:\Van Le\IBC\fmgf00220_CTMahang.htm"/>
     </x:PublishObject>
    </x:PublishObjects>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=961 style='border-collapse:
 collapse;table-layout:fixed;width:722pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=256 style='mso-width-source:userset;mso-width-alt:9362;width:192pt'>
 <col class=xl34 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <tr height=23 style='height:17.25pt'>
  <td height=23 class=xl24 colspan=4 align=left width=450 style='height:17.25pt;
  mso-ignore:colspan;width:337pt'>Báo cáo sổ chi tiết theo từng mã hàng</td>
  <td class=xl34 width=57 style='width:43pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=63 style='width:47pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 align=left style='height:12.75pt;mso-ignore:colspan'>Tên
  mặt hàng: <%=l_item_name%></td>
  <td class=xl35 x:str="Lượng đầu kỳ:"><span
  style='mso-spacerun:yes'> </span>Lượng đầu kỳ:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25>&nbsp;</td>
  <td class=xl26 align=right x:num><%=l_last_qty%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 align=left style='height:12.75pt;mso-ignore:colspan'>Mã
  hiệu: <%=l_item_code%>, Kho hàng: Kho <%=l_wh_id%></td>
  <td class=xl36 x:str="Thành tiền:"><span
  style='mso-spacerun:yes'> </span>Thành tiền:<span
  style='mso-spacerun:yes'> </span></td>
  <td></td>
  <td class=xl27 align=right x:num><%=l_last_amt%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl29 colspan=2 align=left style='mso-ignore:colspan;border-right:
  .5pt solid black'><%=l_tuden_ngay%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl31 width=47 style='height:25.5pt;width:35pt'>Ghi sổ</td>
  <td class=xl31 width=68 style='border-left:none;width:51pt'>Số hiệu</td>
  <td class=xl31 width=79 style='border-left:none;width:59pt'>Ngày tháng</td>
  <td class=xl31 width=256 style='border-left:none;width:192pt'>Diển giãi</td>
  <td class=xl33 width=57 style='border-left:none;width:43pt' x:str="Đơn giá"><span
  style='mso-spacerun:yes'> </span>Đơn giá<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl31 width=86 style='border-left:none;width:65pt'>Lượng Nhập</td>
  <td class=xl31 width=78 style='border-left:none;width:59pt'>Tiền Nhập</td>
  <td class=xl31 width=82 style='border-left:none;width:62pt'>Lượng Xuất</td>
  <td class=xl31 width=68 style='border-left:none;width:51pt'>Tiền Xuất</td>
  <td class=xl31 width=77 style='border-left:none;width:58pt'>Lượng Tồn</td>
  <td class=xl31 width=63 style='border-left:none;width:47pt'>Tiền Tồn</td>
 </tr>
 <%
	int i;
	decimal l_end_qty = 0, l_end_amt = 0;
	l_end_qty = decimal.Parse(l_last_qty);
	l_end_amt = decimal.Parse(l_last_amt);
	for(i = 0 ; i < dtDtl.Rows.Count; i++)
	{
		l_end_qty = l_end_qty + decimal.Parse(dtDtl.Rows[i][5].ToString()) - decimal.Parse(dtDtl.Rows[i][7].ToString());
		l_end_amt = l_end_amt + decimal.Parse(dtDtl.Rows[i][6].ToString()) - decimal.Parse(dtDtl.Rows[i][8].ToString());
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl32 align=left width=47 style='height:12.75pt;
  border-top:none;width:35pt'>&nbsp;<%=dtDtl.Rows[i][0]%></td>
  <td class=xl32 align=left width=68 style='border-top:none;border-left:none;
  width:51pt'>&nbsp;<%=dtDtl.Rows[i][1]%></td>
  <td class=xl32 align=left width=79 style='border-top:none;border-left:none;
  width:59pt'>&nbsp;<%=dtDtl.Rows[i][2]%></td>
  <td class=xl32 align=left width=256 style='border-top:none;border-left:none;
  width:192pt'>&nbsp;<%=dtDtl.Rows[i][3]%></td>
  <td class=xl38 width=57 style='border-top:none;border-left:none;width:43pt'
  x:num><span style='mso-spacerun:yes'>     </span><%=dtDtl.Rows[i][4]%> </td>
  <td class=xl39 align=right width=86 style='border-top:none;border-left:none;
  width:65pt' x:num><%=dtDtl.Rows[i][5]%></td>
  <td class=xl38 width=78 style='border-top:none;border-left:none;width:59pt'
  x:num><span style='mso-spacerun:yes'>         </span><%=dtDtl.Rows[i][6]%> </td>
  <td class=xl39 align=right width=82 style='border-top:none;border-left:none;
  width:62pt' x:num><%=dtDtl.Rows[i][7]%></td>
  <td class=xl38 width=68 style='border-top:none;border-left:none;width:51pt'
  x:num><span style='mso-spacerun:yes'>           </span><%=dtDtl.Rows[i][8]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl39 align=right width=77 style='border-top:none;border-left:none;
  width:58pt' x:num><%=l_end_qty%></td>
  <td class=xl38 width=63 style='border-top:none;border-left:none;width:47pt'
  x:num><span style='mso-spacerun:yes'>   </span><%=l_end_amt%> </td>
 </tr>
	<%		
		}
	%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=256 style='width:192pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=63 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
