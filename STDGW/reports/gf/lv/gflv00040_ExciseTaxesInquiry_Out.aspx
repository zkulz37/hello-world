<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
                   string p_compk = Request["compk"];
                   string p_month = Request["month"];
                   string p_vat_type = Request["vat_type"];
                   string p_vat_rate = Request["vat_rate"];
                   string p_ccy = Request["ccy"];
                   string p_status = Request["status"];
                   string p_custpk = Request["custpk"];
                   string p_invoiceno = Request["invoiceno"];
                   string p_ac_cd = Request["ac_cd"];
                   string p_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
                   string p_voucherno = Request["voucherno"];
                   string p_balance_type = Request["balance_type"];
                   string p_dtfr = Request["dtfr"];
                   string p_dtto = Request["dtto"];

                   string p_company_name = "";
                   string p_tax_code = "";
                   string p_cmp_add = "";
                   string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + p_compk + "'";
                   DataTable dt2 = ESysLib.TableReadOpen(SQL);
                   p_company_name = dt2.Rows[0][0].ToString();
                   p_tax_code = dt2.Rows[0][1].ToString();
                   p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString();

                    string l_parameter = "'" + p_compk + "', ";
                    l_parameter += "'" + p_month + "', ";
                    l_parameter += "'" + p_vat_type + "', ";
                    l_parameter += "'" + p_vat_rate + "', ";
                    l_parameter += "'" + p_ccy + "', ";
                    l_parameter += "'" + p_status + "', ";
                    l_parameter += "'" + p_custpk + "', ";
                    l_parameter += "'" + p_invoiceno + "', ";
                    l_parameter += "'" + p_ac_cd + "', ";
                    l_parameter += "'" + p_tac_hgtrh_pk + "', ";  
                    l_parameter += "'" + p_voucherno + "', ";
                    l_parameter += "'" + p_balance_type + "', ";
                    l_parameter += "'" + p_dtfr + "', ";
                    l_parameter += "'" + p_dtto + "' ";
                    //Response.Write(l_parameter);
                    //Response.End(); 
                   DataTable dt_Detail = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00040_1", l_parameter);
                   if (dt_Detail.Rows.Count == 0)
                   {
                       Response.Write("There is no data!!");
                       Response.End();
                   }

                   string p_thang = "";
                   string p_nam = "";
                   p_thang = p_month.Substring(4, 2);
                   p_nam = p_month.Substring(0, 4);         
     %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="dd_files/filelist.xml">
<link rel=Edit-Time-Data href="dd_files/editdata.mso">
<link rel=OLE-Object-Data href="dd_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-09-29T05:55:05Z</o:LastPrinted>
  <o:Created>2010-09-16T09:07:32Z</o:Created>
  <o:LastSaved>2010-09-29T07:57:27Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .25in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font6
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Mẫu số 01-1TTĐB</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>93</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>15</x:SplitHorizontal>
     <x:TopRowBottomPane>15</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>285</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1067 style='border-collapse:
 collapse;table-layout:fixed;width:800pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl24 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl24 width=159 style='mso-width-source:userset;mso-width-alt:5814;
 width:119pt'>
 <col class=xl24 width=192 style='mso-width-source:userset;mso-width-alt:7021;
 width:144pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl24 width=203 style='mso-width-source:userset;mso-width-alt:7424;
 width:152pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 width=64 style='height:15.75pt;width:48pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=87 style='width:65pt'></td>
  <td class=xl24 width=104 style='width:78pt'></td>
  <td class=xl24 width=159 style='width:119pt'></td>
  <td class=xl24 width=192 style='width:144pt'></td>
  <td class=xl24 width=72 style='width:54pt'></td>
  <td class=xl24 width=104 style='width:78pt'></td>
  <td class=xl25 width=203 style='width:152pt'>Mẫu số:<font class="font6">01-1/TTĐB</font></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl26>(Ban hành kèm theo Thông tư</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl26>Số 60/2007/TT-BTC ngày</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl27>14/06/2007 của Bộ Tài Chính)</td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=9 height=27 class=xl43 style='height:20.25pt'>BẢNG KÊ HÓA ĐƠN
  HÀNG HÓA, DỊCH VỤ BÁN RA CHỊU THUẾ TIÊU THỤ ĐẶC BIỆT</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=9 height=21 class=xl44 style='height:15.75pt'>(Kèm theo Tờ khai
  TTĐB mẫu số 01/TTĐB)</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=9 height=21 class=xl44 style='height:15.75pt'>Kỳ tính thuế:
  tháng <%=p_thang %> Năm <%=p_nam %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Nguời
  nộp thuế:</td>
  <td class=xl28><%=p_company_name%></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'>Địa chỉ:</td>
  <td class=xl24></td>
  <td class=xl28><%=p_cmp_add%></td>
  <td class=xl28></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã
  số thuế:</td>
  <td class=xl28><%=p_tax_code %></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl29>Đơn vị tiền: <%=p_ccy%></td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td rowspan=2 height=84 class=xl45 width=64 style='border-bottom:.5pt solid black;
  height:63.0pt;width:48pt'>STT</td>
  <td colspan=3 class=xl48 width=273 style='border-right:.5pt solid black;
  border-left:none;width:205pt'>Hóa đơn bán hàng</td>
  <td rowspan=2 class=xl45 width=159 style='border-bottom:.5pt solid black;
  width:119pt'>Tên khách hàng</td>
  <td rowspan=2 class=xl45 width=192 style='border-bottom:.5pt solid black;
  width:144pt'>Tên hàng hóa, dịch vụ</td>
  <td rowspan=2 class=xl45 width=72 style='border-bottom:.5pt solid black;
  width:54pt'>Số lượng</td>
  <td rowspan=2 class=xl45 width=104 style='border-bottom:.5pt solid black;
  width:78pt'>Đơn giá</td>
  <td rowspan=2 class=xl45 width=203 style='border-bottom:.5pt solid black;
  width:152pt'>Doanh thu bán có chịu TTĐB (không có thuế GTGT)</td>
 </tr>
 <tr class=xl30 height=63 style='height:47.25pt'>
  <td height=63 class=xl31 width=82 style='height:47.25pt;width:62pt'>Ký hiệu</td>
  <td class=xl31 width=87 style='width:65pt'>Số</td>
  <td class=xl31 width=104 style='width:78pt'>Ngày, tháng, năm phát hành</td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'>(1)</td>
  <td class=xl34>(2)</td>
  <td class=xl34>(3)</td>
  <td class=xl34>(4)</td>
  <td class=xl34>(5)</td>
  <td class=xl34>(6)</td>
  <td class=xl34>(7)</td>
  <td class=xl34>(8)</td>
  <td class=xl34>(9)</td>
 </tr>
 <%
    decimal qty = 0;
    decimal u_price = 0;
    decimal total = 0;
    for(int i = 0; i < dt_Detail.Rows.Count;i++)
    {
                
     %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'><%=dt_Detail.Rows[i][0]%></td>
  <td class=xl36><%=dt_Detail.Rows[i][5]%></td>
  <td class=xl36><%=dt_Detail.Rows[i][7]%></td>
  <td class=xl37><%=dt_Detail.Rows[i][6]%></td>
  <td class=xl38 width=159 style='width:119pt'><%=dt_Detail.Rows[i][9]%></td>
  <td class=xl38 width=192 style='width:144pt'><%=dt_Detail.Rows[i][12]%></td>
  <td class=xl39  x:num><%=dt_Detail.Rows[i][13]%></td>
  <td class=xl39  x:num><%=dt_Detail.Rows[i][14]%></td>
  <td class=xl39  x:num><%=dt_Detail.Rows[i][17]%></td>
 </tr>
 <%}        
    %>
    
  <%
   DataTable dt_total = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00040_report_sum", l_parameter);

   for (int j = 0; j < dt_total.Rows.Count; j++)
   {
         %>
 <tr class=xl40 height=21 style='height:15.75pt'>
<%if (j == 0)
  { %> 
  <td colspan=5 rowspan="<%=dt_total.Rows.Count.ToString()%>"  height=21 class=xl50 style='border-right:.5pt solid black;height:15.75pt'><%=dt_total.Rows[j][0]%></td>
  <%} %>
  <td class=xl41 x:num><%=dt_total.Rows[j][1]%></td>
  <td class=xl42  x:num><%=dt_total.Rows[j][2]%></td>
  <td class=xl42  x:num><%=dt_total.Rows[j][3]%></td>
  <td class=xl42  x:num><%=dt_total.Rows[j][4]%></td>
 </tr>
<%} %> 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=159 style='width:119pt'></td>
  <td width=192 style='width:144pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=203 style='width:152pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
