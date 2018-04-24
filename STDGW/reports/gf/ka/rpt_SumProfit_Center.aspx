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
    string ls_tco_company_pk = "", ls_tr_date_from = "", ls_tr_date_to = "";
    string SQL = "";
    string ls_tac_abpl_pk = "", ls_tac_abcenter_pk = "" ;
    ls_tco_company_pk           = Request["company_pk"];
    ls_tr_date_from             = Request["tr_date_from"];
    ls_tr_date_to               = Request["tr_date_to"];
    ls_tac_abcenter_pk          = Request["tac_abcenter_pk"];
	ls_tac_abpl_pk              = Request["tac_abpl_pk"];
    string ls_grp_tra_ve        = "SALESO" ; // account nhom tra ve
    string ls_grp_ban_ve        = "SALESI" ; // account nhom ban ve
    string ls_grp_hop_dong      = "SALESC" ; // account nhom hop dong
    string ls_grp_expenses      = "";
    string ls_from_to_date = "Từ ngày " + ls_tr_date_from.Substring(6, 2) + "/" + ls_tr_date_from.Substring(4, 2) + "/" + ls_tr_date_from.Substring(0, 4) + " đến ngày " + ls_tr_date_to.Substring(6, 2) + "/" + ls_tr_date_to.Substring(4, 2) + "/" + ls_tr_date_to.Substring(0, 4);
	SQL
	= "   SELECT partner_name, " + 
        "          NVL (addr1, '') || ' ' || NVL (addr2, ' ') || ' ' || NVL (addr3, ''), " +
        "          tax_code " +
        "     FROM comm.tco_company " +
        "    WHERE del_if = 0 AND pk = '" + ls_tco_company_pk + "' " ;
    DataTable dtComp = new DataTable();        
    dtComp = ESysLib.TableReadOpen(SQL) ;       
	if(dtComp.Rows.Count == 0)
	{
		Response.Write("The report is not enough information to display!");
		Response.End();
	}
SQL
	= "SELECT   to_char(to_date(tbl_in.tr_date, 'yyyymmdd'),'dd/mm/yyyy') trans_date,   pl.pl_cd,             plc.plc_cd,     plc.plc_nm,        " + 
        "         sum(tbl_in.qty_banve) qty,          tbl_in.u_price price, sum(tbl_in.bk_amt_trave) dt_tra_ve, " +
        "         sum(tbl_in.bk_amt_banve) dt_ban_ve,    sum(tbl_in.bk_amt_hopdong) dt_hop_dong " +
        "from  " +
        "( " +
        "        select ar_mst.tr_date,              xe.pk tac_abpl_pk,          xe_chn.tac_abcenter_pk,  " +
        "        xe_chn.pk tac_abplcenter_pk,        ar.u_price,                 ar_mst.serial_no serial_no,  " +
        "        ar_mst.invoice_no,                  sum(ar.qty) qty_banve,      sum(ar.net_bk_amt) bk_amt_banve, " +
        "        0 qty_tra_ve, 0 bk_amt_trave, 0 bk_amt_hopdong  " +
        "        from tac_crcad ar, tac_crca ar_mst, tac_abpl xe, tac_abplcenter xe_chn             " +
        "        where ar.del_if     = 0  " +
        "        and   ar_mst.del_if = 0 " +
        "        and   xe_chn.del_if = 0 " +
        "        and  ar_mst.tr_status in ('2', '0', '4')       " +
        "        and   ar.tac_crca_pk = ar_mst.pk " +
        "        and ar.tac_abplcenter_pk = xe_chn.pk   " +
        "        and xe_chn.tac_abpl_pk   = xe.pk " +
        "		and decode('" + ls_tac_abpl_pk + "', '', 'ALL', xe.pk) = decode('" + ls_tac_abpl_pk + "', '', 'ALL', '" + ls_tac_abpl_pk + "') " +
        "		and decode('" + ls_tac_abcenter_pk + "', '', 'ALL', xe_chn.tac_abcenter_pk) = decode('" + ls_tac_abcenter_pk + "', '', 'ALL', '" + ls_tac_abcenter_pk + "')  		 " +
        "        and ar.tac_abacctcode_pk IN ( " +
        "          SELECT D.TAC_ABACCTCODE_PK  " +
        "            FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "           WHERE D.DEL_IF           = 0  " +
        "             AND H.DEL_IF           = 0 " +
        "             AND D.TAC_ABTRACGRP_PK = H.PK " +
        "             AND H.AC_GRP           = '" + ls_grp_ban_ve + "' " +
        "        ) " +
        "        and ar_mst.tr_date between '" + ls_tr_date_from + "' and '" + ls_tr_date_to  + "'  " +
        "        group by ar_mst.tr_date, xe.pk, xe_chn.tac_abcenter_pk, xe_chn.pk, ar.u_price, ar_mst.serial_no, ar_mst.invoice_no " +
        "        union all " +
        "        select ar_mst.tr_date,              xe.pk tac_abpl_pk,          xe_chn.tac_abcenter_pk,  " +
        "        xe_chn.pk tac_abplcenter_pk,        ar.u_price u_price,      ar_mst.serial_no serial_no,  " +
        "        ar_mst.invoice_no, 0 qty_banve, 0 bk_amt_banve,                   " +
        "        sum(ar.qty) qty_trave,      sum(ar.net_bk_amt) bk_amt_trave, " +
        "        0 bk_amt_hopdong  " +
        "        from tac_crcad ar, tac_crca ar_mst, tac_abpl xe, tac_abplcenter xe_chn " +
        "        where ar.del_if     = 0  " +
        "        and   ar_mst.del_if = 0 " +
        "        and   xe_chn.del_if = 0 " +
        "        and  ar_mst.tr_status in ('2', '0', '4')         " +
        "        and   ar.tac_crca_pk = ar_mst.pk " +
        "        and ar.tac_abplcenter_pk = xe_chn.pk   " +
        "        and xe_chn.tac_abpl_pk   = xe.pk " +
        "		and decode('" + ls_tac_abpl_pk + "', '', 'ALL', xe.pk) = decode('" + ls_tac_abpl_pk + "', '', 'ALL', '" + ls_tac_abpl_pk + "') " +
        "		and decode('" + ls_tac_abcenter_pk + "', '', 'ALL', xe_chn.tac_abcenter_pk) = decode('" + ls_tac_abcenter_pk + "', '', 'ALL', '" + ls_tac_abcenter_pk + "')   " +
        "        and ar.tac_abacctcode_pk IN ( " +
        "          SELECT D.TAC_ABACCTCODE_PK  " +
        "            FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "           WHERE D.DEL_IF           = 0  " +
        "             AND H.DEL_IF           = 0 " +
        "             AND D.TAC_ABTRACGRP_PK = H.PK " +
        "             AND H.AC_GRP           = '" + ls_grp_tra_ve + "' " +
        "        ) " +
        "        and ar_mst.tr_date between '" + ls_tr_date_from + "' and '" + ls_tr_date_to  + "'              " +
        "        group by ar_mst.tr_date, xe.pk, xe_chn.tac_abcenter_pk, xe_chn.pk, ar.u_price, ar_mst.serial_no, ar_mst.invoice_no " +
        "        union all " +
        "        select ar_mst.tr_date,              xe.pk tac_abpl_pk,          xe_chn.tac_abcenter_pk,  " +
        "        xe_chn.pk tac_abplcenter_pk,        ar.u_price u_price,         ar_mst.serial_no serial_no,  " +
        "        ar_mst.invoice_no, 0 qty_banve, 0 bk_amt_banve,                   " +
        "        0 qty_trave,      0 bk_amt_trave, " +
        "        sum(ar.net_bk_amt) bk_amt_hopdong  " +
        "        from tac_crcad ar, tac_crca ar_mst, tac_abpl xe, tac_abplcenter xe_chn " +
        "        where ar.del_if     = 0  " +
        "        and   ar_mst.del_if = 0 " +
        "        and   xe_chn.del_if = 0 " +
        "        and  ar_mst.tr_status in ('2', '0', '4')         " +
        "        and   ar.tac_crca_pk = ar_mst.pk " +
        "        and ar.tac_abplcenter_pk = xe_chn.pk   " +
        "        and xe_chn.tac_abpl_pk   = xe.pk " +
        "		and decode('" + ls_tac_abpl_pk + "', '', 'ALL', xe.pk) = decode('" + ls_tac_abpl_pk + "', '', 'ALL', '" + ls_tac_abpl_pk + "') " +
        "		and decode('" + ls_tac_abcenter_pk + "', '', 'ALL', xe_chn.tac_abcenter_pk) = decode('" + ls_tac_abcenter_pk + "', '', 'ALL', '" + ls_tac_abcenter_pk + "')   " +
        "        and ar.tac_abacctcode_pk IN ( " +
        "          SELECT D.TAC_ABACCTCODE_PK  " +
        "            FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "           WHERE D.DEL_IF           = 0  " +
        "             AND H.DEL_IF           = 0 " +
        "             AND D.TAC_ABTRACGRP_PK = H.PK " +
        "             AND H.AC_GRP           = '" + ls_grp_hop_dong + "' " +
        "        ) " +
        "        and ar_mst.tr_date between '" + ls_tr_date_from + "' and '" + ls_tr_date_to  + "'              " +
        "        group by ar_mst.tr_date, xe.pk, xe_chn.tac_abcenter_pk, xe_chn.pk, ar.u_price, ar_mst.serial_no, ar_mst.invoice_no " +
        ") " +
        "tbl_in, " +
        "tac_abpl pl, " +
        "tac_abcenter plc " +
        "	where tbl_in.tac_abpl_pk = pl.pk(+) " +
        "	and   tbl_in.tac_abcenter_pk = plc.pk(+) " +
        "group by tbl_in.tr_date, plc.plc_cd,       plc.plc_nm,     pl.pl_cd, " +
        "        tbl_in.tac_abpl_pk, tbl_in.tac_abcenter_pk,  " +
        "        tbl_in.tac_abplcenter_pk,        tbl_in.u_price,                 tbl_in.serial_no,  " +
        "        tbl_in.invoice_no " +
        "        order by tbl_in.tr_date asc       " ;	
    DataTable dtIncome = new DataTable();        
    dtIncome = ESysLib.TableReadOpen(SQL) ;       
	if(dtIncome.Rows.Count == 0)
	{
		Response.Write("The report is not enough information to display!");
		Response.End();
	}
		
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="DOANH%20THU%20TONG%20HOP_KUMHO_files/filelist.xml">
<link rel=Edit-Time-Data
href="DOANH%20THU%20TONG%20HOP_KUMHO_files/editdata.mso">
<link rel=OLE-Object-Data
href="DOANH%20THU%20TONG%20HOP_KUMHO_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2009-05-06T07:35:40Z</o:LastPrinted>
  <o:Created>2009-05-06T07:22:28Z</o:Created>
  <o:LastSaved>2009-05-06T07:36:26Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
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
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	text-align:left;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";}
.xl36
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	}	
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
       <x:RangeSelection>$E$5:$E$6</x:RangeSelection>
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
  <x:WindowHeight>10065</x:WindowHeight>
  <x:WindowWidth>13305</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=939 style='border-collapse:
 collapse;table-layout:fixed;width:705pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=138 style='mso-width-source:userset;mso-width-alt:5046;width:104pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=64 style='width:48pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=122 style='mso-width-source:userset;mso-width-alt:4461;width:92pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 width=119 style='height:12.75pt;mso-ignore:colspan;
  width:89pt'>Tên công ty: <%=dtComp.Rows[0][0]%></td>
  <td colspan=4 class=xl26 width=380 style='width:285pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=122 style='width:92pt'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Địa chỉ công
  ty: <%=dtComp.Rows[0][1]%></td>
  <td colspan=3 class=xl26 width=300 style='width:225pt'></td>
  <td class=xl24 colspan=6 style='mso-ignore:colspan'>BẢNG TỔNG HỢP DOANH THU
  THEO TUYẾN</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Mã số thuế: <%=dtComp.Rows[0][2]%></td>
  <td colspan=2 class=xl25  ></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl28 style='height:25.5pt'>Stt</td>
  <td rowspan=2 class=xl28>Ngày</td>
  <td colspan=2 class=xl27 style='border-left:none'>Tuyến</td>
  <td rowspan=2 class=xl29 style='border-bottom:.5pt solid black'>Biển số xe</td>
  <td rowspan=2 class=xl29 style='border-bottom:.5pt solid black'>Số lượng vé</td>
  <td rowspan=2 class=xl29 style='border-bottom:.5pt solid black'>Đơn giá</td>
  <td rowspan=2 class=xl31 width=88 style='border-bottom:.5pt solid black;
  width:66pt'>Doanh thu trả vé</td>
  <td rowspan=2 class=xl31 width=78 style='border-bottom:.5pt solid black;
  width:59pt'>Doanh thu bán vé</td>
  <td rowspan=2 class=xl31 width=88 style='border-bottom:.5pt solid black;
  width:66pt'>Doanh thu hợp đồng</td>
  <td rowspan=2 class=xl29 style='border-bottom:.5pt solid black'>Tổng doanh
  thu</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none;border-left:
  none'>Mã</td>
  <td class=xl27 style='border-top:none;border-left:none'>Tên</td>
 </tr>
 <%
	int i;
	decimal l_tot_income = 0;
	decimal l_sum_qty_ve = 0, l_sum_tra_ve = 0, l_sum_ban_ve = 0, l_sum_hop_dong = 0, l_sum_tot_income = 0;
	for(i = 0; i < dtIncome.Rows.Count ; i++)
	{
		l_tot_income = 0;
		l_tot_income = Decimal.Parse(dtIncome.Rows[i][6].ToString()) + Decimal.Parse(dtIncome.Rows[i][7].ToString()) + Decimal.Parse(dtIncome.Rows[i][8].ToString());
		l_sum_qty_ve += Decimal.Parse(dtIncome.Rows[i][4].ToString());
		l_sum_tra_ve += Decimal.Parse(dtIncome.Rows[i][6].ToString());
		l_sum_ban_ve += Decimal.Parse(dtIncome.Rows[i][7].ToString());
		l_sum_hop_dong += Decimal.Parse(dtIncome.Rows[i][8].ToString());
		l_sum_tot_income += l_tot_income ;
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt; border:.5pt solid windowtext;' x:num><%=(i + 1)%></td>
  <td class=xl33 style='border:.5pt solid windowtext;'><%=dtIncome.Rows[i][0] %></td>
  <td class=xl25 style='border:.5pt solid windowtext;' ><%=dtIncome.Rows[i][2] %></td>
  <td class=xl34 style='border:.5pt solid windowtext;' ><%=dtIncome.Rows[i][3] %></td>
  <td class=xl25 style='border:.5pt solid windowtext;' ><%=dtIncome.Rows[i][1] %></td>
  <td class=xl36 align=right x:num><%=dtIncome.Rows[i][4] %></td>
  <td class=xl36 align=right x:num><%=dtIncome.Rows[i][5] %></td>
  <td class=xl40 align=right style='border-top:none' x:num><%=dtIncome.Rows[i][6] %></td>
  <td class=xl40 align=right x:num><%=dtIncome.Rows[i][7] %></td>
  <td class=xl40 align=right style='border-top:none' x:num><%=dtIncome.Rows[i][8] %></td>
  <td class=xl40 align=right x:num><%=l_tot_income%></td>
 </tr>
 <%
	}
 %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl37 style='border-right:.5pt solid black;
  height:17.25pt'>TỔNG CỘNG</td>
  <td class=xl36 align=right style='border-left:none' x:num><%=l_sum_qty_ve%></td>
  <td class=xl36 align=right style='border-left:none' x:num></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_sum_tra_ve%></td>
  <td class=xl36 align=right style='border-left:none' x:num><%=l_sum_ban_ve%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_hop_dong%></td>
  <td class=xl36 align=right style='border-left:none' x:num><%=l_sum_tot_income%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=39 style='width:29pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=122 style='width:92pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
