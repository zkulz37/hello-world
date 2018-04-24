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
<link rel=File-List
href="To%20Khai%20Thue%20Tieu%20Thu%20Dac%20Biet_files/filelist.xml">
<link rel=Edit-Time-Data
href="To%20Khai%20Thue%20Tieu%20Thu%20Dac%20Biet_files/editdata.mso">
<link rel=OLE-Object-Data
href="To%20Khai%20Thue%20Tieu%20Thu%20Dac%20Biet_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>LONG</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-10-02T02:25:38Z</o:LastPrinted>
  <o:Created>2010-09-29T03:28:43Z</o:Created>
  <o:LastSaved>2010-10-02T02:27:09Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .5in 1.0in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font8
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-style:italic;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-style:italic;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-style:italic;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>71</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>14</x:SplitHorizontal>
     <x:TopRowBottomPane>14</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:RangeSelection>$A$7:$J$7</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6600</x:WindowHeight>
  <x:WindowWidth>19320</x:WindowWidth>
  <x:WindowTopX>-285</x:WindowTopX>
  <x:WindowTopY>5865</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1364 style='border-collapse:
 collapse;table-layout:fixed;width:1023pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl24 width=491 style='mso-width-source:userset;mso-width-alt:17956;
 width:368pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl24 width=116 style='mso-width-source:userset;mso-width-alt:4242;
 width:87pt'>
 <col class=xl24 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl24 width=141 style='mso-width-source:userset;mso-width-alt:5156;
 width:106pt'>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 width=39 style='height:19.5pt;width:29pt'></td>
  <td class=xl24 width=491 style='width:368pt'></td>
  <td class=xl24 width=68 style='width:51pt'></td>
  <td class=xl24 width=111 style='width:83pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=115 style='width:86pt'></td>
  <td class=xl24 width=48 style='width:36pt'></td>
  <td class=xl24 width=116 style='width:87pt'></td>
  <td colspan=2 class=xl45 width=266 style='border-right:.5pt solid black;
  width:200pt'>Mẫu số: 01/TTĐB (Ban hành kèm theo</td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=8 class=xl24 style='height:10.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid black'>Thông tư số
  60/2007/TT-BTC</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=8 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black'>ngày 14/6/2007
  của Bộ Tài Chính)</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=10 height=21 class=xl44 style='height:15.75pt'>CỘNG HÒA XÃ HỘI
  CHỦ NGHĨA VIỆT NAM</td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td colspan=10 height=15 class=xl44 style='height:11.25pt'>Độc lập - Tự do -
  Hạnh phúc</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=10 height=27 class=xl39 style='height:20.25pt'>TỜ KHAI THUẾ TIÊU
  THỤ ĐẶC BIỆT(Mẫu số 01/TTĐB)</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=10 height=22 class=xl38 style='height:16.5pt'>Kỳ tính thuế tháng
  <%=p_thang %> năm <%=p_nam%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl24>Mã số thuế:<span style='mso-spacerun:yes'>         </span><font
  class="font8"><%=p_tax_code%></font></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl24>Người nộp thuế:<span style='mso-spacerun:yes'>   </span><font
  class="font8"><%=p_company_name %></font></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl24>Địa chỉ:<span style='mso-spacerun:yes'>               </span><font
  class="font8"><%=p_cmp_add %></font></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=76 style='mso-height-source:userset;height:57.0pt'>
  <td height=76 class=xl27 width=39 style='height:57.0pt;width:29pt'>STT</td>
  <td class=xl27 width=491 style='border-left:none;width:368pt'>Tên hàng hóa,
  dịch vụ</td>
  <td class=xl27 width=68 style='border-left:none;width:51pt'>Đơn vị tính</td>
  <td class=xl27 width=111 style='border-left:none;width:83pt'>Sản lượng tiêu
  thụ</td>
  <td class=xl27 width=110 style='border-left:none;width:83pt'>Doanh số bán
  (chưa có thuế GTGT)</td>
  <td class=xl27 width=115 style='border-left:none;width:86pt'>Giá tính thuế
  TTĐB</td>
  <td class=xl27 width=48 style='border-left:none;width:36pt'>Thuế suất (%)</td>
  <td class=xl27 width=116 style='border-left:none;width:87pt'>Thuế TTĐB được
  khấu trừ</td>
  <td class=xl27 width=125 style='border-left:none;width:94pt'>Điều chỉnh thuế
  TTĐB của các kỳ trước. Tăng (+); Giảm (-)</td>
  <td class=xl27 width=141 style='border-left:none;width:106pt'>Thuế TTĐB phải
  nộp</td>
 </tr>
 <tr class=xl30 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 style='height:18.0pt;border-top:none'>(1)</td>
  <td class=xl29 style='border-top:none;border-left:none'>(2)</td>
  <td class=xl29 style='border-top:none;border-left:none'>(3)</td>
  <td class=xl29 style='border-top:none;border-left:none'>(4)</td>
  <td class=xl29 style='border-top:none;border-left:none'>(5)</td>
  <td class=xl29 style='border-top:none;border-left:none'>(6)</td>
  <td class=xl29 style='border-top:none;border-left:none'>(7)</td>
  <td class=xl29 style='border-top:none;border-left:none'>(8)</td>
  <td class=xl29 style='border-top:none;border-left:none'>(9)</td>
  <td class=xl29 style='border-top:none;border-left:none'>(10=6x7-8+9)</td>
 </tr>
 <%
    decimal qty = 0;
    decimal u_price = 0;
    decimal total = 0;
    for(int i = 0; i < dt_Detail.Rows.Count;i++)
    {
                
     %>
 <tr class=xl34 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl31 width=39 style='height:21.75pt;border-top:none; width:29pt' x:num><%=dt_Detail.Rows[i][0]%></td>
  <td class=xl32 width=491 style='border-top:none;border-left:none;width:368pt'><%=dt_Detail.Rows[i][12]%></td>
  <td class=xl31 width=68 style='border-top:none;border-left:none;width:51pt'>Kg</td>
  <td class=xl33 width=111 style='border-top:none;border-left:none;width:83pt'  x:num>346,456 </td>
  <td class=xl33 width=110 style='border-top:none;border-left:none;width:83pt'  x:num>5,678,567 </td>
  <td class=xl33 width=115 style='border-top:none;border-left:none;width:86pt'  x:num>45,646 </td>
  <td class=xl33 width=48 style='border-top:none;border-left:none;width:36pt'  x:num>5,646 </td>
  <td class=xl33 width=116 style='border-top:none;border-left:none;width:87pt'  x:num>356,345 </td>
  <td class=xl33 width=125 style='border-top:none;border-left:none;width:94pt'  x:num>3,456,346</td>
  <td class=xl33 width=141 style='border-top:none;border-left:none;width:106pt'x:num>563,456 </td>
 </tr>
  <%}        
    %>
 <tr class=xl37 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl42 style='border-right:.5pt solid black; height:18.75pt'>Tổng cộng:</td>
  <td class=xl35 style='border-top:none;border-left:none'></td>
  <td class=xl36 style='border-top:none;border-left:none' x:num>456,465 </td>
  <td class=xl36 style='border-top:none;border-left:none' x:num>456,456 </td>
  <td class=xl36 style='border-top:none;border-left:none' x:num>34,564,356 </td>
  <td class=xl36 style='border-top:none;border-left:none' x:num>678 </td>
  <td class=xl36 style='border-top:none;border-left:none' x:num>456,465 </td>
  <td class=xl36 style='border-top:none;border-left:none' x:num>6,769 </td>
  <td class=xl36 style='border-top:none;border-left:none' x:num>69,679 </td>
 </tr>
 <tr class=xl24 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=10 class=xl24 style='height:23.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl38>Người ký:</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=7 class=xl24 style='height:3.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=7 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl38>Ngày ký</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>16/10/2010</td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=39 style='width:29pt'></td>
  <td width=491 style='width:368pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=141 style='width:106pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
