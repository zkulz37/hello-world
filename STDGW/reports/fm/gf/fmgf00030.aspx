<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%
	string SQL = "";
	string l_parameter = "";
	string l_compk = "", l_dt_from = "", l_dt_to = "", l_whpk = "", l_slip_no = "", l_ac_cd = "", l_ac_nm = "";
	string l_item_code = "", l_item_name = "";
	l_compk = Request["com_pk"];
	l_dt_from = Request["dt_from"];
	l_dt_to = Request["dt_to"];
	l_whpk = Request["wh_pk"];
	l_slip_no = Request["slip_no"];
	l_ac_cd = Request["ac_cd"];
	l_ac_nm = Request["ac_nm"];
	l_item_code = Request["item_code"];
	l_item_name = Request["item_name"];
	l_parameter = "'" + l_compk + "', '" + l_dt_from + "', '" + l_dt_to + "', '" + l_whpk + "', '" ;
	l_parameter += l_slip_no + "', '" + l_ac_cd + "', '" + l_ac_nm + "', '" + l_item_code + "', '" ;
	l_parameter += l_item_name + "'" ;	
	DataTable dt = new DataTable();
	dt = ESysLib.TableReadOpenCursor("acnt.sp_sel_fmgf00030", l_parameter);
	SQL = "select partner_name, TAX_CODE from comm.tco_company where del_if = 0 and pk = '" +  l_compk + "' ";
	DataTable dtComp = new DataTable();	
	dtComp = ESysLib.TableReadOpen(SQL);
	string l_fromto_date = "";
	l_fromto_date = "Từ ngày " + l_dt_from.Substring(6, 2) + "/" + l_dt_from.Substring(4, 2) + "/" + l_dt_from.Substring(0, 4);
	l_fromto_date += " đến ngày " + l_dt_to.Substring(6, 2) + "/" + l_dt_to.Substring(4, 2) + "/" + l_dt_to.Substring(0, 4);
	DateTime l_to_day = DateTime.Today;
	string ls_today = l_to_day.ToString("ddMMyyyy");	
	
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="MAU%20BAO%20CAO%20NHAP%20HANG_files/filelist.xml">
<link rel=Edit-Time-Data href="MAU%20BAO%20CAO%20NHAP%20HANG_files/editdata.mso">
<link rel=OLE-Object-Data href="MAU%20BAO%20CAO%20NHAP%20HANG_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>OWNER</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2009-11-25T05:55:35Z</o:LastPrinted>
  <o:Created>2009-11-23T03:19:48Z</o:Created>
  <o:LastSaved>2009-11-25T09:28:22Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in .25in .25in .75in;
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
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>FG Inquiry</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12120</x:WindowHeight>
  <x:WindowWidth>17400</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:Calculation>SemiAutomaticCalculation</x:Calculation>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='FG Inquiry'!$A$6:$I$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1020 style='border-collapse:
 collapse;table-layout:fixed;width:766pt'>
 <col class=xl25 width=111 style='mso-width-source:userset;mso-width-alt:3157;
 width:83pt'>
 <col class=xl25 width=101 style='mso-width-source:userset;mso-width-alt:2872;
 width:76pt'>
 <col class=xl25 width=93 style='mso-width-source:userset;mso-width-alt:2645;
 width:70pt'>
 <col class=xl25 width=182 style='mso-width-source:userset;mso-width-alt:5176;
 width:137pt'>
 <col class=xl25 width=104 style='mso-width-source:userset;mso-width-alt:2958;
 width:78pt'>
 <col class=xl25 width=206 style='mso-width-source:userset;mso-width-alt:5859;
 width:155pt'>
 <col class=xl25 width=45 style='mso-width-source:userset;mso-width-alt:1280;
 width:34pt'>
 <col class=xl25 width=91 style='mso-width-source:userset;mso-width-alt:2588;
 width:68pt'>
 <col class=xl25 width=87 style='mso-width-source:userset;mso-width-alt:2474;
 width:65pt'>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 width=111 style='height:17.1pt;width:83pt'>Tên công
  ty</td>
  <td class=xl25 width=101 style='width:76pt'><%=dtComp.Rows[0][0]%></td>
  <td class=xl25 width=93 style='width:70pt'></td>
  <td class=xl25 width=182 style='width:137pt'></td>
  <td class=xl25 width=104 style='width:78pt'></td>
  <td class=xl25 width=206 style='width:155pt'></td>
  <td class=xl25 width=45 style='width:34pt'></td>
  <td class=xl25 width=91 style='width:68pt'></td>
  <td class=xl25 width=87 style='width:65pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'>Mã số thuế</td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'><%=dtComp.Rows[0][1]%></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=9 height=27 class=xl39 style='height:20.25pt'>SUMMARY FINISH
  GOODS/BÁO CÁO SỐ LƯỢNG HOÀN THÀNH TRONG KỲ</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=9 height=22 class=xl40 style='height:17.1pt'><%=l_fromto_date%></td>
 </tr>
 <tr height=22 style='height:17.1pt'>
  <td height=22 colspan=9 class=xl25 style='height:17.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=57 style='height:42.75pt'>
  <td height=57 class=xl28 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$6:$I$6" width=111 style='height:42.75pt;width:83pt'>Voucher
  No<br>
    Số chứng từ</td>
  <td class=xl28 id="_x0000_s1026" x:autofilter="all" width=101
  style='border-left:none;width:76pt'>Trans Date<br>
    Ngày chứng từ</td>
  <td class=xl28 id="_x0000_s1027" x:autofilter="all" width=93
  style='border-left:none;width:70pt'>Account<br>
    <span style='mso-spacerun:yes'> </span>Code<br>
    Mã TK</td>
  <td class=xl28 id="_x0000_s1028" x:autofilter="all" width=182
  style='border-left:none;width:137pt'>Account Name<br>
    Tên TK</td>
  <td class=xl28 id="_x0000_s1029" x:autofilter="all" width=104
  style='border-left:none;width:78pt'>Item Code<br>
    Mã hàng</td>
  <td class=xl28 id="_x0000_s1030" x:autofilter="all" width=206
  style='border-left:none;width:155pt'>Item Name<br>
    Tên mặt hàng</td>
  <td class=xl28 id="_x0000_s1031" x:autofilter="all" width=45
  style='border-left:none;width:34pt' x:str="UOM&#10;ĐVT ">UOM<br>
    ĐVT<span style='mso-spacerun:yes'> </span></td>
  <td class=xl28 id="_x0000_s1032" x:autofilter="all" width=91
  style='border-left:none;width:68pt'>Quantity<br>
    Số lượng</td>
  <td class=xl28 id="_x0000_s1033" x:autofilter="all" width=87
  style='border-left:none;width:65pt'>Warehouse<br>
    Kho</td>
 </tr>
 <% 
	int i ;
	decimal l_qty = 0;
	string ls_tr_date = "";
	for(i = 0; i < dt.Rows.Count; i++)
	{
		l_qty += decimal.Parse(dt.Rows[i][7].ToString());
		ls_tr_date = dt.Rows[i][1].ToString();
		ls_tr_date = ls_tr_date.Substring(6,2) + "/" + ls_tr_date.Substring(4,2) + "/" + ls_tr_date.Substring(0,4);
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'><%=dt.Rows[i][0]%></td>
  <td class=xl31 style='border-left:none' x:str><%=ls_tr_date%></td>
  <td class=xl32 style='border-left:none' x:str><%=dt.Rows[i][2]%></td>
  <td class=xl30 style='border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl30 style='border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl30 style='border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl30 style='border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl33 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][7]%> </td>
  <td class=xl30 style='border-left:none'><%=dt.Rows[i][8]%></td>
 </tr>
 <%
	}
 %>
 <tr class=xl27 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl26 style='height:17.1pt'>&nbsp;</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-left:none' x:str="Tổng cộng ">Tổng cộng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=l_qty%><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl35 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=7 class=xl27 style='height:17.1pt;mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl27></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=6 class=xl25 style='height:17.1pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl41>Ngày <%=ls_today.Substring(0,2)%> tháng <%=ls_today.Substring(2,2)%> năm <%=ls_today.Substring(4,4)%></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=2 height=22 class=xl27 style='height:17.1pt'>Người lập</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27>Giám đốc/Quản lý sản xuất</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=111 style='width:83pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=206 style='width:155pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=87 style='width:65pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
