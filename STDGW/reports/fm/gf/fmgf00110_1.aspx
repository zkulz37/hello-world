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
    
    string ls_std_ym = Request["std_ym"];
    string ls_std_ym_to = Request["std_ym_to"];
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
    
    //ls_item_code
        
 //p_std_ym = p_std_ym.Substring(3, 4) + p_std_ym.Substring(0, 2);
    iYear    = int.Parse(ls_std_ym_to.Substring(0, 4));
    iMonth   = int.Parse(ls_std_ym_to.Substring(4, 2));
    iFromDt  = "01/" + ls_std_ym.Substring(4, 2) + "/" + ls_std_ym.Substring(0, 4);
    iToDt = DateTime.DaysInMonth(iYear, iMonth).ToString() + "/" + ls_std_ym_to.Substring(4, 2) + "/" + ls_std_ym_to.Substring(0, 4);    
    DataTable lstWH = new DataTable();
    
    SQL
	= "SELECT pk, wh_name " + 
        "  FROM inv.tin_warehouse " +
        " WHERE del_if = 0 " +
        "   AND DECODE ( '" + ls_tin_warehouse_pk + "', 'ALL', '" + ls_tin_warehouse_pk + "', pk) = '" + ls_tin_warehouse_pk + "'";    
        
            
    lstWH = ESysLib.TableReadOpen(SQL) ;
	
	SQL
	= "select partner_name, nvl(addr1, '') || ' ' || nvl(addr2, '') || ' ' || nvl(addr3, '') address, tax_code from comm.tco_company where pk like '" + ls_company_pk + "' " ;
    DataTable dtComp = new DataTable();
	dtComp = ESysLib.TableReadOpen(SQL);
    // parameter
    string l_param = "";
    l_param = "'" + ls_company_pk + "', '" + ls_std_ym + "', '" + ls_std_ym_to + "', '" + ls_ac_cd + "', '" + ls_item_pk + "', '" + ls_pl_cd + "', '";
    DataTable dtItem = new DataTable();
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="NXTON_files/filelist.xml">
<link rel=Edit-Time-Data href="NXTON_files/editdata.mso">
<link rel=OLE-Object-Data href="NXTON_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>van</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:Created>2008-11-18T05:46:44Z</o:Created>
  <o:LastSaved>2011-10-15T07:05:17Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>9</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>15</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9360</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1820 style='border-collapse:
 collapse;table-layout:fixed;width:1370pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
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
 <col class=xl24 width=110 span=5 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=2 width=202 style='height:15.0pt;mso-ignore:
  colspan;width:152pt'><%=dtComp.Rows[0][0] %></td>
  <td class=xl24 width=94 style='width:71pt'></td>
  <td class=xl24 width=125 style='width:94pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=74 style='width:56pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=66 style='width:50pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 colspan=5 style='height:15.0pt;mso-ignore:colspan'><%=dtComp.Rows[0][1] %></td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=19 class=xl24 style='height:8.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=18 height=27 class=xl35 style='height:20.25pt'>BẢNG TỔNG HỢP NHẬP
  XUẤT TỒN VẬT TƯ, HÀNG HÓA</td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=18 height=20 class=xl25 style='height:15.0pt'>Từ ngày <%=iFromDt %>
  đến ngày <%=iToDt%></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=19 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=19 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td colspan=2 rowspan=2 height=40 class=xl39 style='border-right:.5pt solid black;
  height:30.0pt'>Kho</td>
  <td colspan=3 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>Vật tư hàng hóa</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Đơn giá</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>Tồn đầu kỳ</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>Nhập trong kỳ</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>Xuất trong kỳ</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>Nhập lũy kế</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>Xuất lũy kế</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>Tồn cuối kỳ</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Ghi chú</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'>Mã</td>
  <td class=xl26>Tên VT, háng hóa</td>
  <td class=xl26>Đơn vị tính</td>
  <td class=xl27>Số lượng</td>
  <td class=xl28>Giá trị</td>
  <td class=xl27>Số lượng</td>
  <td class=xl28>Giá trị</td>
  <td class=xl27>Số lượng</td>
  <td class=xl28>Giá trị</td>
  <td class=xl28>Q'ty</td>
  <td class=xl28>Amount</td>
  <td class=xl28>Q'ty</td>
  <td class=xl28>Amount</td>
  <td class=xl27>Số lượng</td>
  <td class=xl28>Giá trị</td>
 </tr>
  <%     
     string l_param_whpk = "";
    decimal lOpen_Qty = 0, lOpen_Amt = 0;
    decimal lIn_Qty = 0, lIn_Amt = 0;
    decimal lOut_Qty = 0, lOut_Amt = 0;
    decimal lBal_Qty = 0, lBal_Amt = 0;
    decimal lBegin_Qty_Acc = 0, lBegin_amt_Acc = 0, lInput_qty_Acc = 0, lInput_amt_Acc = 0, lOut_Qty_Acc = 0;
    decimal lOut_amt_Acc = 0, lEnd_qty_Acc = 0, lEnd_amt_Acc = 0;
    decimal lCumulative_InQty = 0, lCumulative_InAmt = 0, lCumulative_OutQty = 0, lCumulative_OutAmt = 0;
      
    string ac_cd = "" ;
        l_param_whpk = l_param + "ALL'";
        dtItem = ESysLib.TableReadOpenCursor("ACNT.sp_sel_fmgf00110_1", l_param_whpk);

     lOpen_Qty = 0; lOpen_Amt = 0;
     lIn_Qty = 0; lIn_Amt = 0;
    lOut_Qty = 0; lOut_Amt = 0;
     lBal_Qty = 0; lBal_Amt = 0;
    lBegin_Qty_Acc = 0; lBegin_amt_Acc = 0; lInput_qty_Acc = 0; lInput_amt_Acc = 0; lOut_Qty_Acc = 0; lOut_amt_Acc = 0; lEnd_qty_Acc = 0; lEnd_amt_Acc = 0;
     ac_cd = "" ;

     for (i = 0; i < dtItem.Rows.Count; i++)
     {
         ac_cd = dtItem.Rows[i][1].ToString().Trim();
         if (dtItem.Rows[i][10].ToString().Trim() != "")
         {
             lOpen_Qty = lOpen_Qty + decimal.Parse(dtItem.Rows[i][10].ToString());
         }

         if (dtItem.Rows[i][11].ToString().Trim() != "")
         {
             lOpen_Amt = lOpen_Amt + decimal.Parse(dtItem.Rows[i][11].ToString());
         }
         if (dtItem.Rows[i][12].ToString().Trim() != "")
         {
             lIn_Qty += decimal.Parse(dtItem.Rows[i][12].ToString().Trim());
         }
         if (dtItem.Rows[i][13].ToString().Trim() != "")
         {
             lIn_Amt = lIn_Amt + decimal.Parse(dtItem.Rows[i][13].ToString().Trim());
         }
         if (dtItem.Rows[i][14].ToString().Trim() != "")
         {
             lOut_Qty = lOut_Qty + decimal.Parse(dtItem.Rows[i][14].ToString().Trim());
         }
         if (dtItem.Rows[i][15].ToString().Trim() != "")
         {
             lOut_Amt = lOut_Amt + decimal.Parse(dtItem.Rows[i][15].ToString().Trim());
         }
         if (dtItem.Rows[i][16].ToString().Trim() != "")
         {
             lBal_Qty = lBal_Qty + decimal.Parse(dtItem.Rows[i][16].ToString().Trim());
         }
         if (dtItem.Rows[i][17].ToString().Trim() != "")
         {
             lBal_Amt = lBal_Amt + decimal.Parse(dtItem.Rows[i][17].ToString().Trim());
         }
         if (dtItem.Rows[i][19].ToString().Trim() != "")
         {
             lCumulative_InQty += decimal.Parse(dtItem.Rows[i][19].ToString());       
         }
         if (dtItem.Rows[i][20].ToString().Trim() != "")
         {
             lCumulative_InAmt += decimal.Parse(dtItem.Rows[i][20].ToString());
         }
         if (dtItem.Rows[i][21].ToString().Trim() != "")
         {
             lCumulative_OutQty += decimal.Parse(dtItem.Rows[i][21].ToString());
         }
         if (dtItem.Rows[i][22].ToString().Trim() != "")
         {
             lCumulative_OutAmt += decimal.Parse(dtItem.Rows[i][22].ToString());
         }
         
 %>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=2 height=41 class=xl44 width=202 style='border-right:.5pt solid black;
  height:30.75pt;width:152pt'><%=dtItem.Rows[i][7]%></td>
  <td class=xl43 width=94 style="width:71pt; border-bottom:.5pt solid windowtext; "><%=dtItem.Rows[i][3]%></td> <!-- Item code -->
  <td class=xl29 width=125 style='width:94pt'><%=dtItem.Rows[i][4]%></td>
  <td class=xl29 width=79 style='width:59pt'><%= dtItem.Rows[i][6]%></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%= dtItem.Rows[i][10]%> </td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%= dtItem.Rows[i][11]%> </td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%= dtItem.Rows[i][12]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%= dtItem.Rows[i][13]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%= dtItem.Rows[i][14]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%= dtItem.Rows[i][15]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl49 x:num><%=dtItem.Rows[i][19]%></td>
  <td class=xl48 x:num><%=dtItem.Rows[i][20]%></td>
  <td class=xl49 x:num><%=dtItem.Rows[i][21]%></td>
  <td class=xl48 x:num><%=dtItem.Rows[i][22]%></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][16]%> </td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][17]%> </td>
  <td class=xl32 style='border-top:none;border-left:none'><%=ac_cd%></td>
 </tr>
 <% 
      }
 %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl44 width=202 style='height:15.0pt;width:152pt'>&nbsp;</td>
  <td class=xl41 width=94 style='width:71pt'>&nbsp;</td>
  <td class=xl31>Tổng cộng</td>
  <td class=xl29 width=79 style='width:59pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=lOpen_Qty%> </td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=lOpen_Amt%></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=lIn_Qty%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=lIn_Amt%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=lOut_Qty %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=lOut_Amt %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl49 x:num><%=lCumulative_InQty %></td>
  <td class=xl48 x:num><span style='mso-spacerun:yes'> </span><%=lCumulative_InAmt%> </td>
  <td class=xl49 x:num><%=lCumulative_OutQty%></td>
  <td class=xl48 x:num><span style='mso-spacerun:yes'> </span><%=lCumulative_OutAmt%> </td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=lBal_Qty %> </td>
  <td class=xl30 x:num><span style='mso-spacerun:yes'> </span><%=lBal_Amt %> </td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=82 style='width:62pt'></td>
  <td width=120 style='width:90pt'></td>
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
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=66 style='width:50pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
