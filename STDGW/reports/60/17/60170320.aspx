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


int iYear, iMonth;

string iFromDt, iToDt, SQL = "", ls_tin_warehouse_pk = "", ls_ac_cd = "", ls_company_pk = "", ls_item_code = "";
    
    string ls_std_ym = Request["std_ym"];
    ls_ac_cd = Request["ac_cd"];
    ls_ac_cd = ls_ac_cd.Trim();
    ls_tin_warehouse_pk = Request["tin_warehouse_pk"];
    ls_tin_warehouse_pk = ls_tin_warehouse_pk.Trim();
    ls_company_pk = Request["tco_company_pk"];
    ls_company_pk = ls_company_pk.Trim();
    ls_item_code = Request["item_code"];
    ls_item_code = ls_item_code.Trim();
    
    iYear    = int.Parse(ls_std_ym.Substring(0, 4));
    iMonth   = int.Parse(ls_std_ym.Substring(4, 2));
    iFromDt  = "01/" + ls_std_ym.Substring(4, 2) + "/" + ls_std_ym.Substring(0, 4);
    iToDt = DateTime.DaysInMonth(iYear, iMonth).ToString() + "/" + ls_std_ym.Substring(4, 2) + "/" + ls_std_ym.Substring(0, 4);    
    DataTable lstWH = new DataTable();
    SQL = "select pk, WH_NAME from inv.tin_warehouse where del_if = 0 and decode('" + ls_tin_warehouse_pk + "', 'ALL', '" + ls_tin_warehouse_pk + "', pk) = '" + ls_tin_warehouse_pk + "'" ;
    lstWH = ESysLib.TableReadOpen(SQL) ;
    DataTable dt = new DataTable();
	SQL
	= "select partner_name, nvl(addr1, '') || ' ' || nvl(addr2, '') || ' ' || nvl(addr3, '') address, tax_code from comm.tco_company where pk = '" + ls_company_pk + "' " ;
    DataTable dtComp = new DataTable();
	dtComp = ESysLib.TableReadOpen(SQL);
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
	mso-text-control:shrinktofit;
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
  colspan;width:133pt'><%=dtComp.Rows[0][0]%></td>
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
  <td height=20 class=xl25 colspan=4 style='height:15.0pt;mso-ignore:colspan'><%=dtComp.Rows[0][1]%></td>
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
<% 
    int i, j, k;
    for(k = 0 ; k < lstWH.Rows.Count; k++)
    {
    SQL
	= "select '" + ls_std_ym + "', tbl_Begin.GRP_CD, tbl_Begin.GRP_NM, tbl_Begin.ITEM_UOM, NULL Price, NVL(tbl_Begin.Begin_Qty, 0) Begin_Qty, NVL(tbl_Begin.Begin_Amt, 0) Begin_Amt,  " + 
        "    tbl_In.in_qty,tbl_In.in_amt, tbl_Out.out_qty, tbl_Out.out_amt, tbl_Begin.Begin_Qty + NVL(tbl_In.in_qty,0) - NVL(tbl_Out.out_qty,0) iQty,  " +
        "    tbl_Begin.Begin_Amt + NVL(tbl_In.in_amt, 0) - NVL(tbl_Out.out_amt,0) iAmt, tbl_Acc.ac_cd  " +
        "from   " +
        "(  " +
        "    select c.pk, c.GRP_CD, c.GRP_NM, c.ITEM_UOM, a.tac_abacctcode_pk, SUM(a.LAST_QTY) Begin_Qty, SUM(a.LAST_AMT) Begin_amt   " +
        "    from acnt.tac_stockmm a, comm.tco_item b, comm.tco_itemgrp c, inv.tin_warehouse w, acnt.tac_abacctcode t  " +
        "    where a.del_if = 0  " +
        "    and b.del_if = 0  " +
        "    and c.del_if = 0  " +
        "    and w.del_if(+) = 0  " +
        "    and t.del_if(+) = 0  " +
        "    and a.TCO_ITEM_PK = b.pk  " +
        "    and b.TCO_ITEMGRP_PK = c.pk  " +
        "    and a.TIN_WAREHOUSE_PK = w.pk(+)  " +
        "    and a.tac_abacctcode_pk = t.pk(+)  " +
        "    and a.std_ym = '" + ls_std_ym + "'" + 
        "    and decode('" + ls_ac_cd + "', '', 'ALL', substr(t.ac_cd, 0, 3)) like decode('" + ls_ac_cd + "', '', 'ALL', substr('" + ls_ac_cd + "', 0, 3))   " +
        "    and a.tin_warehouse_pk = " + lstWH.Rows[k][0].ToString() + 
        "    and decode('" + ls_item_code + "', '', 'ALL', b.item_code) like decode('" + ls_item_code + "', '', 'ALL', '" + ls_item_code + "') " +
        "    group by c.pk, c.GRP_CD, c.GRP_NM, c.ITEM_UOM, a.tac_abacctcode_pk ) tbl_Begin,  " +
        "    (SELECT c.pk, c.GRP_CD, c.grp_nm, c.ITEM_UOM, a.tac_abacctcode_pk, SUM(a.INPUT_QTY) in_qty, SUM(a.IN_AMT) in_amt  " +
        "     FROM acnt.tac_stocktr a,   " +
        "          comm.tco_item b,   " +
        "          comm.tco_itemgrp c,   " +
        "          inv.tin_warehouse w, " +
        "          acnt.tac_abacctcode t  " +
        "    WHERE a.del_if = 0   " +
        "      AND a.close_yn = 'N'   " +
        "      AND b.del_if = 0   " +
        "      AND c.del_if = 0   " +
        "      AND w.del_if(+) = 0 " +
        "      AND t.del_if(+) = 0 " +
        "      AND a.tco_item_pk = b.pk                                  " +
        "      AND b.tco_itemgrp_pk = c.pk  " +
        "      and a.TIN_WAREHOUSE_PK = w.pk(+) " +
        "      and a.tac_abacctcode_pk = t.pk(+)  " +
        "      AND a.trin_type in ('10', '20')                                     " +
        "      AND ( substr(a.tr_date, 0, 6) = '" + ls_std_ym + "' or a.std_ym like '" + ls_std_ym + "' ) " +
        "    and decode('" + ls_ac_cd + "', '', 'ALL', substr(t.ac_cd, 0, 3)) like decode('" + ls_ac_cd + "', '', 'ALL', substr('" + ls_ac_cd + "', 0, 3)) " +
        "    and a.tin_warehouse_pk = " + lstWH.Rows[k][0].ToString() + 
        "    and decode('" + ls_item_code + "', '', 'ALL', b.item_code) like decode('" + ls_item_code + "', '', 'ALL', '" + ls_item_code + "') " +
        "      group by c.pk, c.GRP_CD, c.grp_nm, c.ITEM_UOM, a.tac_abacctcode_pk) tbl_In,  " +
        "    (SELECT c.pk, c.GRP_CD, c.grp_nm, c.ITEM_UOM, a.tac_abacctcode_pk, SUM(a.OUTPUT_QTY) out_qty, SUM(a.OUT_AMT) out_amt  " +
        "     FROM acnt.tac_stocktr a,   " +
        "          comm.tco_item b,   " +
        "          comm.tco_itemgrp c,   " +
        "          inv.tin_warehouse w, " +
        "          acnt.tac_abacctcode t  " +
        "    WHERE a.del_if = 0   " +
        "      AND a.close_yn = 'N'   " +
        "      AND b.del_if = 0   " +
        "      AND c.del_if = 0   " +
        "      AND w.del_if(+) = 0 " +
        "      AND t.del_if(+) = 0 " +
        "      AND a.tco_item_pk = b.pk                                  " +
        "      AND b.tco_itemgrp_pk = c.pk " +
        "      and a.TIN_WAREHOUSE_PK = w.pk(+) " +
        "      and a.tac_abacctcode_pk = t.pk(+) " +
        "      AND a.trout_type in ('10', '20')                                     " +
        "      AND ( SUBSTR (a.tr_date, 0, 6) = '" + ls_std_ym + "' or a.std_ym = '" + ls_std_ym + "' )         " +
        "    and decode('" + ls_ac_cd + "', '', 'ALL', substr(t.ac_cd, 0, 3)) like decode('" + ls_ac_cd + "', '', 'ALL', substr('" + ls_ac_cd + "', 0, 3)) " +
        "    and a.tin_warehouse_pk = " + lstWH.Rows[k][0].ToString() + 
        "    and decode('" + ls_item_code + "', '', 'ALL', b.item_code) like decode('" + ls_item_code + "', '', 'ALL', '" + ls_item_code + "') " +
        "      group by c.pk, c.GRP_CD, c.grp_nm, c.ITEM_UOM, a.tac_abacctcode_pk ) tbl_Out,   " +
        " acnt.tac_abacctcode tbl_Acc  " +
        "      where tbl_Begin.pk = tbl_In.pk(+)  " +
        " and  tbl_Begin.tac_abacctcode_pk = tbl_In.tac_abacctcode_pk(+)  " +
        "      and tbl_Begin.pk = tbl_Out.pk(+)  " +
        " and  tbl_Begin.tac_abacctcode_pk = tbl_Out.tac_abacctcode_pk(+)  " +
        " and tbl_Acc.pk = tbl_Begin.tac_abacctcode_pk and tbl_Acc.del_if = 0  " +
        " and NVL(tbl_Begin.Begin_Qty, 0) + NVL(tbl_In.in_qty, 0) + NVL(tbl_Out.out_qty,0) <> 0  " +
        " order by tbl_Acc.ac_cd, tbl_Begin.GRP_CD  " ;
        dt = ESysLib.TableReadOpen(SQL) ;
        //Response.Write(SQL);
        //Response.End();
%> 
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt' x:str>Kho:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'><%=lstWH.Rows[k][1] %></td>
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
    
    float lBegin_Qty, lBegin_amt, lInput_qty, lInput_amt, lOut_Qty, lOut_amt, lEnd_qty, lEnd_amt;
    float lBegin_Qty_Acc, lBegin_amt_Acc, lInput_qty_Acc, lInput_amt_Acc, lOut_Qty_Acc, lOut_amt_Acc, lEnd_qty_Acc, lEnd_amt_Acc;
    string ac_cd ="" ; 
     
    lBegin_Qty = 0;
    lBegin_amt = 0;     
    lInput_qty = 0;
    lInput_amt = 0;
    lOut_Qty = 0 ; 
    lOut_amt = 0 ;
    lEnd_qty = 0 ;
    lEnd_amt = 0 ;
    lBegin_Qty_Acc = 0;
    lBegin_amt_Acc = 0;
    lInput_qty_Acc = 0;
    lInput_amt_Acc = 0;
    lOut_Qty_Acc = 0;
    lOut_amt_Acc = 0;
    lEnd_qty_Acc = 0;
    lEnd_amt_Acc = 0;
    
    if(dt.Rows.Count > 0)
    {
        ac_cd = dt.Rows[0][13].ToString().Trim();
    }
    
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
        if( dt.Rows[i][13].ToString().Trim() != ac_cd)
        {                                    
 %>
  <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'><b>Tài khoản: <%=ac_cd %></b></td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lBegin_Qty_Acc%></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lBegin_amt_Acc%></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lInput_qty_Acc %></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lInput_amt_Acc %></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lOut_Qty_Acc %></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lOut_amt_Acc %></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lEnd_qty_Acc%></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lEnd_amt_Acc %></b></td>  
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][11]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][12]%></td>
 </tr> 
<% 
            ac_cd = dt.Rows[i][13].ToString() ;
            lBegin_Qty_Acc = 0;
            lBegin_amt_Acc = 0;
            lInput_qty_Acc = 0;
            lInput_amt_Acc = 0;
            lOut_Qty_Acc = 0;
            lOut_amt_Acc = 0;
            lEnd_qty_Acc = 0;
            lEnd_amt_Acc = 0;                    
        } 
        else
        {
%>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][11]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][12]%></td>
 </tr>
 <% 
        }
        if(dt.Rows[i][5].ToString().Trim() != "")
            lBegin_Qty_Acc += float.Parse(dt.Rows[i][5].ToString());
        if (dt.Rows[i][6].ToString().Trim() != "")
            lBegin_amt_Acc += float.Parse(dt.Rows[i][6].ToString());
        if (dt.Rows[i][7].ToString().Trim() != "")
            lInput_qty_Acc += float.Parse(dt.Rows[i][7].ToString());
        if (dt.Rows[i][8].ToString().Trim() != "")
            lInput_amt_Acc += float.Parse(dt.Rows[i][8].ToString());
        if (dt.Rows[i][9].ToString().Trim() != "")
            lOut_Qty_Acc += float.Parse(dt.Rows[i][9].ToString());
        if (dt.Rows[i][10].ToString().Trim() != "")
            lOut_amt_Acc += float.Parse(dt.Rows[i][10].ToString());
        if (dt.Rows[i][11].ToString().Trim() != "")
            lEnd_qty_Acc += float.Parse(dt.Rows[i][11].ToString());
        if (dt.Rows[i][12].ToString().Trim() != "")
            lEnd_amt_Acc += float.Parse(dt.Rows[i][12].ToString());                
    } 
 %>
   <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'><b>Tài khoản: <%=ac_cd %></b></td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lBegin_Qty_Acc%></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lBegin_amt_Acc%></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lInput_qty_Acc %></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lInput_amt_Acc %></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lOut_Qty_Acc %></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lOut_amt_Acc %></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lEnd_qty_Acc%></b></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><b><%=lEnd_amt_Acc %></b></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Tổng cộng</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=lBegin_Qty%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=lBegin_amt%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=lInput_qty %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=lInput_amt %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=lOut_Qty %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=lOut_amt %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=lEnd_qty%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=lEnd_amt %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <% 
    }
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
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