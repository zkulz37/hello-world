<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<%
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_comp = "" + Request["company_pk"];    
    string p_kind = ""+Request["KindCode"];
	string p_dept = ""+Request["DeptPK"];
	string p_status = ""+Request["Status"];
	string p_fa_acc = ""+ Request["AssetAccCode"];
	string p_depr_acc = ""+ Request["AssetDepr"]	;
	string p_expe_acc = ""+ Request["ExpAcc"];
    string p_from = "" + Request["dtFrom"];
    string p_to = "" + Request["dtTo"];
    string p_Asset_Cd = "" + Request["Assetcd"];
    string kind_code = "";
     string depr_yn="";
    string from_month = p_from.Substring(4, 2) + "/" + p_from.Substring(0, 4);
    string to_month = p_to.Substring(4, 2) + "/" + p_to.Substring(0, 4);
    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = "";

    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + p_comp + "' ";
    DataTable dt = ESysLib.TableReadOpen(SQL1);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][3].ToString();
    }

    string sql2 = "SELECT SF_A_GET_DEFAULT('ACBG0040') FROM DUAL ";
    string l_ccy = "";
    DataTable dt_bccy = ESysLib.TableReadOpen(sql2);
    if (dt_bccy.Rows.Count > 0)
    {
        l_ccy = dt_bccy.Rows[0][0].ToString();
    }

    string l_parameter1 = "'" + p_from + "','" + p_to + "','" + p_comp + "','" + p_kind + "','" + p_dept + "','" + p_status + "', '" + l_ccy + "', '" + p_Asset_Cd+ "'";
    string l_parameter = "'" + p_from + "','" + p_to + "','" + p_comp + "','" + p_kind + "','" + p_dept + "','" + p_status + "', '" + l_ccy + "'";
    //Response.Write(l_parameter);
    //Response.End();
    DataTable dt_grp_kind = ESysLib.TableReadOpenCursor("AC_SEL_60130140_04_DEPARTMENT", l_parameter1);
    
    DataTable dt_detail = ESysLib.TableReadOpenCursor("AC_sel_60130140_04", l_parameter1);
    if (dt_detail.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="Copy%20of%20gfgf00040_02_VIE%201%20_files/filelist.xml">
<link rel=Edit-Time-Data
href="Copy%20of%20gfgf00040_02_VIE%201%20_files/editdata.mso">
<link rel=OLE-Object-Data
href="Copy%20of%20gfgf00040_02_VIE%201%20_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Acc</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-10-14T01:46:58Z</o:LastPrinted>
  <o:Created>2008-11-06T07:21:07Z</o:Created>
  <o:LastSaved>2011-10-14T01:47:26Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.52in 0in .27in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.25in;
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
	font-family:Arial, sans-serif;
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
	font-family:Arial, sans-serif;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	white-space:normal;
	vertical-align:middle;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
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
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
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
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
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
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
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
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl50
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
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl52
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
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl53
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
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
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
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Amended Depreciation List</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>57</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>13</x:TabColorIndex>
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
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9360</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1560</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Amended Depreciation List'!$A$8:$P$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1840 style='border-collapse:
 collapse;table-layout:fixed;width:1385pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=185 style='mso-width-source:userset;mso-width-alt:6765;width:139pt'>
 <col width=110 span=11 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=79 span=2 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=64 style='width:48pt'>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 width=32 style='height:10.5pt;width:24pt'></td>
  <td width=185 style='width:139pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl38 colspan=2 style='height:14.25pt;mso-ignore:colspan'><%=l_cmp_name %></td>
  <td colspan=16 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl28 colspan=3 style='height:12.75pt;mso-ignore:colspan'><%=l_cmp_add %></td>
  <td colspan=15 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
  <td class=xl39 colspan=4 style='mso-ignore:colspan'>BẢNG TỔNG HỢP KHẤU HAO TÀI SẢN CỐ ĐỊNH</td>
  <td colspan=8 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 style='height:14.25pt'></td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan'>Từ ngày: <%=from_month%> Đến: <%=to_month%></td>
  <td></td>
  <td colspan=9 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=18 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td rowspan=2 height=68 class=xl43 width=32 style='border-bottom:.5pt solid black;  height:51.0pt;width:24pt' >STT</td>
  <td rowspan=2 class=xl45 width=185 style='width:139pt' >Bộ phận</td>
  <td colspan=3 class=xl50 width=330 style='border-right:.5pt solid black;  width:249pt'>Số đầu kỳ(<%=from_month %>)</td>
  <td colspan=2 class=xl52 width=220 style='border-right:.5pt solid black;  border-left:none;width:166pt'>Mua mới</td>
  <td colspan=2 class=xl52 width=220 style='border-right:.5pt solid black;  border-left:none;width:166pt'>Thanh lý</td>
  <td rowspan=2 class=xl48 width=110 style='width:83pt'>Số khấu hao(của tháng này)</td>
  <td colspan=3 class=xl54 width=330 style='border-right:.5pt solid black;  border-left:none;width:249pt'>Cuối kỳ</td>
  <td rowspan=2 class=xl48 width=91 style='width:68pt'>Số khấu hao(mỗi tháng)</td>
  <td rowspan=2 class=xl48 width=79 style='width:59pt'>Tài khoản TS</td>
  <td rowspan=2 class=xl48 width=79 style='width:59pt'>Tài khoản chi phí</td>
  <td rowspan=2 class=xl48 width=100 style='width:75pt'>Tài khoản khấu hao</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl41 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl40 id="_x0000_s1030" x:autofilter="all" width=110  style='height:30.0pt;border-top:none;width:83pt' x:autofilter="all"
  x:autofilterrange="$A$8:$P$8">Nguyên giá</td>
  <td class=xl40 id="_x0000_s1031" x:autofilter="all" width=110  style='border-top:none;width:83pt'>Số khấu hao lũy kế</td>
  <td class=xl40 id="_x0000_s1032" x:autofilter="all" width=110  style='border-top:none;width:83pt'>Giá trị còn lại</td>
  <td class=xl40 id="_x0000_s1033" x:autofilter="all" width=110  style='border-top:none;width:83pt'>Mua mới</td>
  <td class=xl40 id="_x0000_s1034" x:autofilter="all" width=110  style='border-top:none;width:83pt'>Thay thế</td>
  <td class=xl40 id="_x0000_s1035" x:autofilter="all" width=110  style='border-top:none;width:83pt'>Giảm nguyên giá</td>
  <td class=xl40 id="_x0000_s1036" x:autofilter="all" width=110  style='border-top:none;width:83pt'>Giá trị lũy kế giảm</td>
  <td class=xl40 id="_x0000_s1038" x:autofilter="all" width=110  style='border-top:none;width:83pt'>Nguyên giá</td>
  <td class=xl40 id="_x0000_s1039" x:autofilter="all" width=110  style='border-top:none;width:83pt'>Lũy kế</td>
  <td class=xl40 id="_x0000_s1040" x:autofilter="all" width=110  style='border-top:none;width:83pt'>Giá trị còn lại</td>
  <td class=xl41></td>
 </tr>
 <%   
     decimal _1 = 0, _2 = 0, _3 = 0, _4 = 0, _5 = 0, _6 = 0, _7 = 0, _8 = 0, _9 = 0, _10 = 0, _11 = 0, _12 = 0;
     if (dt_grp_kind.Rows.Count > 0)
              {
                  for (int ki = 0; ki < dt_grp_kind.Rows.Count; ki++)
                  {
                      kind_code = dt_grp_kind.Rows[ki]["tco_org_pk"].ToString();
                      //if (dt_grp_kind.Rows[ki]["depr_yn"].ToString() == depr_yn)
                      // {
 %>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none;text-align:center;vertical-align:middle'></td>
  <td class=xl30 style='border-top:none;border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none'><%=dt_grp_kind.Rows[ki]["fa_kind_NM"].ToString()%></td>
  <td class=xl32 style="font-weight:700;background:#99CCFF;mso-pattern:auto none" x:num><%= dt_grp_kind.Rows[ki]["origin_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none;' x:num><%= dt_grp_kind.Rows[ki]["acc_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["remain_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["new_pur_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["sub_acc_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["dis_dec_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["dis_dec_acc_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["depr_peirod"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["end_org_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["end_acc_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["end_remain"].ToString()%></td>
  <td class=xl32 style='border-left:none;font-weight:700;background:#99CCFF;mso-pattern:auto none' x:num><%= dt_grp_kind.Rows[ki]["depr_month_amt"].ToString()%></td>
  <td class=xl33 style='border-left:none;background:#99CCFF;mso-pattern:auto none'></td>
  <td class=xl33 style='border-left:none;text-align:center;background:#99CCFF;mso-pattern:auto none'></td>
  <td class=xl33 style='border-left:none;text-align:center;background:#99CCFF;mso-pattern:auto none'></td>
  <td class=xl28></td>
 </tr>
 <%
     
     int stt = 0;
     
     for (int i = 0; i < dt_detail.Rows.Count; i++)
     {

         if (dt_detail.Rows[i]["tco_org_pk"].ToString() == kind_code)
         {

             stt++;
             if (dt_detail.Rows[i]["origin_amt"].ToString().Trim() != "")
             {
                 _1 += decimal.Parse(dt_detail.Rows[i]["origin_amt"].ToString());
             }
             else
             {
                 _1 += 0;
             }

             if (dt_detail.Rows[i]["acc_amt"].ToString().Trim() != "")
             {
                 _2 += decimal.Parse(dt_detail.Rows[i]["acc_amt"].ToString());
             }
             else
             {
                 _2 += 0;
             }

             if (dt_detail.Rows[i]["remain_amt"].ToString().Trim() != "")
             {
                 _3 += decimal.Parse(dt_detail.Rows[i]["remain_amt"].ToString());
             }
             else
             {
                 _3 += 0;
             }

             if (dt_detail.Rows[i]["new_pur_amt"].ToString().Trim() != "")
             {
                 _4 += decimal.Parse(dt_detail.Rows[i]["new_pur_amt"].ToString());
             }
             else
             {
                 _4 += 0;
             }

             if (dt_detail.Rows[i]["sub_acc_amt"].ToString().Trim() != "")
             {
                 _5 += decimal.Parse(dt_detail.Rows[i]["sub_acc_amt"].ToString());
             }
             else
             {
                 _5 += 0;
             }

             if (dt_detail.Rows[i]["dis_dec_amt"].ToString().Trim() != "")
             {
                 _6 += decimal.Parse(dt_detail.Rows[i]["dis_dec_amt"].ToString());
             }
             else
             {
                 _6 += 0;
             }

             if (dt_detail.Rows[i]["dis_dec_acc_amt"].ToString().Trim() != "")
             {
                 _7 += decimal.Parse(dt_detail.Rows[i]["dis_dec_acc_amt"].ToString());
             }
             else
             {
                 _7 += 0;
             }

             if (dt_detail.Rows[i]["depr_peirod"].ToString().Trim() != "")
             {
                 _8 += decimal.Parse(dt_detail.Rows[i]["depr_peirod"].ToString());
             }
             else
             {
                 _8 += 0;
             }

             if (dt_detail.Rows[i]["end_org_amt"].ToString().Trim() != "")
             {
                 _9 += decimal.Parse(dt_detail.Rows[i]["end_org_amt"].ToString());
             }
             else
             {
                 _9 += 0;
             }

             if (dt_detail.Rows[i]["end_acc_amt"].ToString().Trim() != "")
             {
                 _10 += decimal.Parse(dt_detail.Rows[i]["end_acc_amt"].ToString());
             }
             else
             {
                 _10 += 0;
             }

             if (dt_detail.Rows[i]["end_remain"].ToString().Trim() != "")
             {
                 _11 += decimal.Parse(dt_detail.Rows[i]["end_remain"].ToString());
             }
             else
             {
                 _11 += 0;
             }

             if (dt_detail.Rows[i]["depr_month_amt"].ToString().Trim() != "")
             {
                 _12 += decimal.Parse(dt_detail.Rows[i]["depr_month_amt"].ToString());
             }
             else
             {
                 _12 += 0;
             }
 %>   
 <tr class=xl28 height=17 style='mso-height-source:auto;height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none;text-align:center;vertical-align:middle'><%=stt%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt_detail.Rows[i]["fa_nm"].ToString()%></td>
  <td class=xl32 x:num><%= dt_detail.Rows[i]["origin_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["acc_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["remain_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["new_pur_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["sub_acc_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["dis_dec_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["dis_dec_acc_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["depr_peirod"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["end_org_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["end_acc_amt"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["end_remain"].ToString()%></td>
  <td class=xl32 style='border-left:none' x:num><%= dt_detail.Rows[i]["depr_month_amt"].ToString()%></td>
  <td class=xl33 style='border-left:none'></td>
  <td class=xl33 style='border-left:none;text-align:center'><%=dt_detail.Rows[i]["exp_acc"].ToString()%></td>
  <td class=xl33 style='border-left:none;text-align:center'><%=dt_detail.Rows[i]["depr_acc"].ToString()%></td>
  <td class=xl28></td>
 </tr>
 <%}
     }
                  }
              }
  %>
 <tr class=xl31 height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl46 style='height:15.0pt'>Tổng cộng</td>
  <td class=xl42 align=right style='border-top:none;font-weight:700' x:num><%=_1 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_2 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_3 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_4 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_5 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_6 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_7 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_8 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_9 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_10 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_11 %></td>
  <td class=xl42 align=right style='border-top:none;border-left:none;font-weight:700'  x:num><%=_12 %></td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31></td>
 </tr>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=185 style='width:139pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
