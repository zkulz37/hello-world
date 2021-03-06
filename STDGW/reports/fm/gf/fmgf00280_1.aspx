<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<% 

int iYear, iMonth, i, k;

	string iFromDt, iToDt, SQL = "", ls_tin_warehouse_pk = "", ls_ac_cd = "", ls_company_pk = "", ls_item_pk = "", ls_pl_cd = "";
	string 
    
    string ls_std_ym = Request["std_ym"];
    string ls_wh_pk = "";
    ls_ac_cd = Request["ac_cd"];
    ls_ac_cd = ls_ac_cd.Trim();
    ls_tin_warehouse_pk = Request["tin_warehouse_pk"];
    ls_tin_warehouse_pk = ls_tin_warehouse_pk.Trim();
    ls_company_pk = Request["tco_company_pk"];
    ls_company_pk = ls_company_pk.Trim();
    ls_item_pk = Request["tco_item_pk"];
    ls_item_pk = ls_item_pk.Trim();
    ls_pl_cd = Request["pl_cd"];
    ls_pl_cd = ls_pl_cd.Trim();
    
    
 //p_std_ym = p_std_ym.Substring(3, 4) + p_std_ym.Substring(0, 2);
    iYear    = int.Parse(ls_std_ym.Substring(0, 4));
    iMonth   = int.Parse(ls_std_ym.Substring(4, 2));
    iFromDt  = "01/" + ls_std_ym.Substring(4, 2) + "/" + ls_std_ym.Substring(0, 4);
    iToDt = DateTime.DaysInMonth(iYear, iMonth).ToString() + "/" + ls_std_ym.Substring(4, 2) + "/" + ls_std_ym.Substring(0, 4);    
    DataTable lstWH = new DataTable();
    
    SQL
	= "SELECT pk, wh_name " + 
        "  FROM inv.tin_warehouse " +
        " WHERE del_if = 0 " +
        "   AND DECODE ( '" + ls_tin_warehouse_pk + "', 'ALL', '" + ls_tin_warehouse_pk + "', pk) = '" +
        ls_tin_warehouse_pk + "'" ;        
    lstWH = ESysLib.TableReadOpen(SQL) ;
	
	SQL
	= "select partner_name, nvl(addr1, '') || ' ' || nvl(addr2, '') || ' ' || nvl(addr3, '') address, tax_code from comm.tco_company where pk = '" + ls_company_pk + "' " ;
    DataTable dtComp = new DataTable();
	dtComp = ESysLib.TableReadOpen(SQL);
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=unicode">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:Created>2008-11-18T05:46:44Z</o:Created>
  <o:LastSaved>2008-11-18T05:47:34Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	}
.xl31
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11595</x:WindowHeight>
  <x:WindowWidth>19065</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1194 style='border-collapse:
 collapse;table-layout:fixed;width:898pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=2 width=176 style='height:15.0pt;mso-ignore:
  colspan;width:133pt'><%=dtComp.Rows[0][0] %></td>
  <td class=xl24 width=125 style='width:94pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=74 style='width:56pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=4 style='height:15.0pt;mso-ignore:colspan'><%=dtComp.Rows[0][1]%></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=13 class=xl24 style='height:8.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=13 height=27 class=xl25 style='height:20.25pt'>BẢNG TỔNG HỢP XUẤT
  NHẬP TỒN VẬT TƯ, HÀNG HÓA</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=13 height=20 class=xl26 style='height:15.0pt'>Từ ngày <%=iFromDt %>
  đến ngày <%=iToDt%></td>
 </tr>
 <% 
     DataTable dt = new DataTable();
    for( k = 0; k < lstWH.Rows.Count ; k++)
    {
        ls_wh_pk = lstWH.Rows[k][0].ToString();
        SQL
          = "SELECT  '" + ls_std_ym + "', i.item_code, i.item_name, i.uom, "
          + "         NULL price, m.last_qty begin_qty, "
          + "         m.last_amt begin_amt, t_inout.input_qty, t_inout.in_amt, "
          + "         t_inout.output_qty, t_inout.out_amt, "
          + "                 NVL (m.last_qty, 0) "
          + "               + NVL (t_inout.input_qty, 0) "
          + "               - NVL (t_inout.output_qty, 0) end_qty, "
          + "                 NVL (m.last_amt, 0) "
          + "               + NVL (t_inout.in_amt, 0) "
          + "               - NVL (t_inout.out_amt, 0) end_amt, "
          + "         b.ac_cd "
          + "          FROM (SELECT   a.tco_item_pk, a.tin_warehouse_pk,a.tac_abacctcode_pk, "
          + "                         SUM (output_qty) output_qty, "
          + "                         SUM (input_qty) input_qty, SUM (out_amt) out_amt, "
          + "                         SUM (in_amt) in_amt "
          + "                    FROM tac_stocktr a "
          + "                   WHERE a.del_if = 0 "
          + "                     AND a.close_yn = 'N' "
          + "                     AND (   SUBSTR (a.tr_date, 1, 6) = '" + ls_std_ym + "' "
          + "                          OR a.std_ym = '" + ls_std_ym + "' "
          + "                         ) "
          + "                     AND (   a.trout_type IN ('10', '20') "
          + "                          OR a.trin_type IN ('10', '20') "
          + "                         ) "
          + "                     AND a.tr_status NOT IN ('3', '03') "
          + "                GROUP BY a.tco_item_pk, "
          + "                         a.tin_warehouse_pk , "
          + "                         a.tac_abacctcode_pk "
          + "                         ) t_inout, "
          + "               comm.tco_item i, "
          + "               tac_stockmm m, "
          + "               inv.tin_warehouse w, "
          + "               acnt.v_abplcenter pl, "
          + "               tac_abacctcode b "
          + "         WHERE m.del_if = 0 "
          + "           AND i.del_if = 0 "
          + "           AND t_inout.tco_item_pk(+) = m.tco_item_pk "
          + "           AND t_inout.tin_warehouse_pk(+) = m.tin_warehouse_pk "
          + "           AND t_inout.tac_abacctcode_pk(+) = m.tac_abacctcode_pk "
          + "           AND m.tco_company_pk = '" + ls_company_pk + "' "
          + "           AND m.std_ym = '" + ls_std_ym + "' "
          + "           AND m.tco_item_pk = i.pk(+) "
          + "           AND m.tin_warehouse_pk = w.pk(+) "
          + "           AND m.tac_abplcenter_pk = pl.tac_abplcenter_pk(+) "
          + "           AND m.tac_abacctcode_pk = b.pk(+) "
          + "           AND (  ABS (NVL (m.last_qty, 0)) "
          + "               + ABS (NVL (t_inout.input_qty, 0)) "
          + "               + ABS (NVL (t_inout.output_qty, 0)) > 0 "
          + "               OR "
          + "            ABS (NVL (m.last_amt, 0)) "
          + "               + ABS (NVL (t_inout.in_amt, 0)) "
          + "               + ABS (NVL (t_inout.out_amt, 0)) > 0 )                "
          + "           AND  m.tin_warehouse_pk "
          + "                = '" + ls_wh_pk + "' "
          + "           AND (   DECODE ('" + ls_ac_cd + "', '', 'ALL', SUBSTR (b.ac_cd, 1, 3)) LIKE "
          + "                           DECODE ('" + ls_ac_cd + "', "
          + "                                   '', 'ALL', "
          + "                                   SUBSTR ('" + ls_ac_cd + "', 1, 3) "
          + "                                  ) "
          + "                OR b.ac_cd IS NULL "
          + "               ) "
          + "           AND ('" + ls_item_pk + "' IS NULL OR m.tco_item_pk = '" + ls_item_pk + "') "
          + "           AND '%' || UPPER (pl.pl_cd) || '%' LIKE "
          + "                                                  '%' || UPPER ('" + ls_pl_cd + "') "
          + "                                                  || '%' "
          + "      ORDER BY b.ac_cd, i.item_code ASC ";
        dt = ESysLib.TableReadOpen(SQL) ;
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt' x:str>Kho:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'><%=lstWH.Rows[k][1] %></td>
 </tr>
  <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl27 style='height:30.0pt'>Tháng</td>
  <td colspan=3 class=xl27 style='border-left:none'>Vật tư hàng hóa</td>
  <td rowspan=2 class=xl27>Đơn giá</td>
  <td colspan=2 class=xl27 style='border-left:none'>Tồn đầu kỳ</td>
  <td colspan=2 class=xl27 style='border-left:none'>Nhập trong kỳ</td>
  <td colspan=2 class=xl27 style='border-left:none'>Xuất trong kỳ</td>
  <td colspan=2 class=xl27 style='border-left:none'>Tồn cuối kỳ</td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none;border-left:
  none'>Mã</td>
  <td class=xl27 style='border-top:none;border-left:none'>Tên VT, háng hóa</td>
  <td class=xl27 style='border-top:none;border-left:none'>Đơn vị tính</td>
  <td class=xl28 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl29 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl28 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl29 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl28 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl29 style='border-top:none;border-left:none'>Giá trị</td>
  <td class=xl28 style='border-top:none;border-left:none'>Số lượng</td>
  <td class=xl29 style='border-top:none;border-left:none'>Giá trị</td>
 </tr>
 <% 
    decimal lOpen_Qty = 0, lOpen_Amt = 0;
    decimal lIn_Qty = 0, lIn_Amt = 0;
    decimal lOut_Qty = 0, lOut_Amt = 0;
    decimal lBal_Qty = 0, lBal_Amt = 0;
    decimal lBegin_Qty_Acc = 0, lBegin_amt_Acc = 0, lInput_qty_Acc = 0, lInput_amt_Acc = 0, lOut_Qty_Acc = 0, lOut_amt_Acc = 0, lEnd_qty_Acc = 0, lEnd_amt_Acc = 0;
    string ac_cd = "" ;
    if(dt.Rows.Count > 0)
    {
        ac_cd = dt.Rows[0][13].ToString().Trim();
    }
    
    for(i = 0; i < dt.Rows.Count; i++)
    {
        if(dt.Rows[i][5].ToString().Trim() != "")
        {
            lOpen_Qty = lOpen_Qty + decimal.Parse(dt.Rows[i][5].ToString());
        }
                
        if(dt.Rows[i][6].ToString().Trim() != "")
        {
            lOpen_Amt = lOpen_Amt + decimal.Parse(dt.Rows[i][6].ToString());
        }
        if(dt.Rows[i][7].ToString().Trim() != "")
        {
            lIn_Qty += decimal.Parse(dt.Rows[i][7].ToString());
        }
        if(dt.Rows[i][8].ToString().Trim() != "")
        {
            lIn_Amt = lIn_Amt + decimal.Parse(dt.Rows[i][8].ToString());
        }
        if(dt.Rows[i][9].ToString().Trim() != "")
        {
            lOut_Qty = lOut_Qty + decimal.Parse(dt.Rows[i][9].ToString());
        }
        if(dt.Rows[i][10].ToString().Trim() != "")
        {
            lOut_Amt = lOut_Amt + decimal.Parse(dt.Rows[i][10].ToString());
        }
        if(dt.Rows[i][11].ToString().Trim() != "")
        {
            lBal_Qty = lBal_Qty + decimal.Parse(dt.Rows[i][11].ToString());
        }
        if(dt.Rows[i][12].ToString().Trim() != "")
        {
            lBal_Amt = lBal_Amt + decimal.Parse(dt.Rows[i][12].ToString());
        }
        if( dt.Rows[i][13].ToString().Trim() != ac_cd)
        {                                            
 %>
  <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'><b>Tài khoản: <%=ac_cd %></b></td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lBegin_Qty_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lBegin_amt_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lInput_qty_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lInput_amt_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lOut_Qty_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lOut_amt_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lEnd_qty_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lEnd_amt_Acc %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt;border-top:none'><%=dt.Rows[i][0] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt.Rows[i][1] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt.Rows[i][2] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt.Rows[i][3] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][4] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][5] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][6] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][7] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][8]%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][9]%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][10]%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][11]%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][12]%></td>
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
  <td height=20 class=xl30 style='height:15.0pt;border-top:none'><%=dt.Rows[i][0] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt.Rows[i][1] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt.Rows[i][2] %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt.Rows[i][3] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][4] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][5] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][6] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][7] %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][8]%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][9]%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][10]%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][11]%></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][12]%></td>
 </tr>
 <% 
    }    
         if(dt.Rows[i][5].ToString().Trim() != "")
            lBegin_Qty_Acc += decimal.Parse(dt.Rows[i][5].ToString());
        if (dt.Rows[i][6].ToString().Trim() != "")
            lBegin_amt_Acc += decimal.Parse(dt.Rows[i][6].ToString());
        if (dt.Rows[i][7].ToString().Trim() != "")
            lInput_qty_Acc += decimal.Parse(dt.Rows[i][7].ToString());
        if (dt.Rows[i][8].ToString().Trim() != "")
            lInput_amt_Acc += decimal.Parse(dt.Rows[i][8].ToString());
        if (dt.Rows[i][9].ToString().Trim() != "")
            lOut_Qty_Acc += decimal.Parse(dt.Rows[i][9].ToString());
        if (dt.Rows[i][10].ToString().Trim() != "")
            lOut_amt_Acc += decimal.Parse(dt.Rows[i][10].ToString());
        if (dt.Rows[i][11].ToString().Trim() != "")
            lEnd_qty_Acc += decimal.Parse(dt.Rows[i][11].ToString());
        if (dt.Rows[i][12].ToString().Trim() != "")
            lEnd_amt_Acc += decimal.Parse(dt.Rows[i][12].ToString());
          
    }//end dt.rows.count
 %>
   <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'><b>Tài khoản: <%=ac_cd %></b></td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lBegin_Qty_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lBegin_amt_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lInput_qty_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lInput_amt_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lOut_Qty_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lOut_amt_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lEnd_qty_Acc %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lEnd_amt_Acc %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>Tổng cộng</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lOpen_Qty %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lOpen_Amt %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lIn_Qty %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lIn_Amt %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lOut_Qty %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lOut_Amt %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lBal_Qty %></td>
  <td class=xl31 style='border-top:none;border-left:none' x:num><%=lBal_Amt %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <% 
    }//end for lstWH.rows.count
 %>
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