<%@ page language="C#" %>

<%@ import namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string strSQL = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk 
                      FROM comm.tco_company 
                      WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM comm.tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
												  
    string p_partner_pk = Request.QueryString["p_partner_pk"];
    string p_out_type = Request.QueryString["p_out_type"];
	string p_po = Request.QueryString["p_po"];
    string p_item = Request.QueryString["p_item"];

    
    string para = "'" + p_partner_pk + "','" + p_out_type + "','" + p_po + "','" + p_item + "'";
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpen(strSQL);
    dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00170", "'" + p_partner_pk + "'");
    dt2 = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00170_1", para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="epbp270_files/filelist.xml">
<link rel=Edit-Time-Data href="epbp270_files/editdata.mso">
<link rel=OLE-Object-Data href="epbp270_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Khanh</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-11-01T04:06:07Z</o:LastPrinted>
  <o:Created>2007-01-10T03:24:47Z</o:Created>
  <o:LastSaved>2011-11-01T04:08:33Z</o:LastSaved>
  <o:Company>VINAGENUWIN</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.1in .17in .4in .17in;
	mso-header-margin:0in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
.font7
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
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
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
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
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>23</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5745</x:WindowHeight>
  <x:WindowWidth>19125</x:WindowWidth>
  <x:WindowTopX>195</x:WindowTopX>
  <x:WindowTopY>5355</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$10:$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1485 style='border-collapse:
 collapse;table-layout:fixed;width:1113pt'>
 <col class=xl24 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=268 style='mso-width-source:userset;mso-width-alt:9801;
 width:201pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl24 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl24 width=64 span=3 style='width:48pt'>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 width=37 style='height:15.0pt;width:28pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:15.5pt;margin-top:.5pt;width:78pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl26 width=99 style='width:74pt'></td>
  <td class=xl26 align=left width=75 style='width:56pt'><%= dt.Rows[0]["partner_name"] %></td>
  <td class=xl26 width=111 style='width:83pt'></td>
  <td class=xl26 width=114 style='width:86pt'></td>
  <td class=xl27 width=268 style='width:201pt'></td>
  <td class=xl26 width=47 style='width:35pt'></td>
  <td class=xl26 width=69 style='width:52pt'></td>
  <td class=xl26 width=84 style='width:63pt'></td>
  <td class=xl26 width=107 style='width:80pt'></td>
  <td class=xl26 width=55 style='width:41pt'></td>
  <td colspan=2 class=xl50 width=227 style='width:170pt'>Tel: <%= dt.Rows[0]["phone_no"] %></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td class=xl25 align=left><%= dt.Rows[0]["addr1"] %></td>
  <td colspan=8 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl50>Fax: <%= dt.Rows[0]["fax_no"] %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td class=xl25 align=left>Tax No: <%= dt.Rows[0]["tax_code"] %></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl51>Print Date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=13 rowspan=2 height=35 class=xl43 style='height:26.25pt'>DEBIT
  NOTE <%= p_out_type %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl24 style='height:22.5pt'></td>
  <td colspan=2 class=xl45 width=174 style='width:130pt'>Khách hàng <font
  class="font9">Customer</font><font class="font7">:<span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=10 class=xl46><%= dt1.Rows[0]["partner_name"] %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt'></td>
  <td colspan=2 class=xl45 width=174 style='width:130pt'>Điện thoại <font
  class="font9">TEL</font><font class="font7"> :</font></td>
  <td class=xl24><%= dt1.Rows[0]["phone_no"] %></td>
  <td class=xl28>Fax :</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'><%= dt1.Rows[0]["fax_no"] %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt'></td>
  <td colspan=2 class=xl45 width=174 style='width:130pt'>Địa chỉ <font
  class="font9">Address</font><font class="font7"> :<span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=10 class=xl47><%= dt1.Rows[0]["addr1"] %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=16 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl30 width=37 style='height:30.0pt;width:28pt'>TT<br>
    <font class="font9">No</font></td>
  <td class=xl31 width=99 style='width:74pt'>Số Phiếu Nhập<br>
    <font class="font9">T/O Req No</font></td>
  <td class=xl31 width=75 style='width:56pt'>Ngày nhập<br>
    <font class="font9">T/O Date</font></td>
  <td class=xl31 width=111 style='width:83pt'>Số PO<br>
    <font class="font9">PO. Number</font></td>
  <td class=xl31 width=114 style='width:86pt'>Mã hàng<br>
    <font class="font9">Item Code</font></td>
  <td class=xl31 width=268 style='width:201pt'>Tên hàng<br>
    <font class="font9">Item Description</font></td>
  <td class=xl31 width=47 style='width:35pt'>ĐVT<br>
    <font class="font9">Unit</font></td>
  <td class=xl31 width=69 style='width:52pt'>Số lượng<br>
    <font class="font9">Quantity</font></td>
  <td class=xl31 width=84 style='width:63pt'>Đơn giá<br>
    <font class="font9">Unit Price</font></td>
  <td class=xl31 width=107 style='width:80pt'>Thành tiền<br>
    <font class="font9">Sel Amt</font></td>
  <td class=xl31 width=55 style='width:41pt'>Ngoại tệ<br>
    <font class="font9">CCY</font></td>
  <td class=xl31 width=107 style='width:80pt'>Thành tiền<br>
    <font class="font9">Tax Amount</font></td>
  <td class=xl31 width=120 style='width:90pt'>Ghi chú<br>
    <font class="font9">Remark</font></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
            decimal sel_amt = 0;
			decimal tax_amt = 0; 
            for (int i = 0; i < dt2.Rows.Count; i++)
            {
                
             %>
 <tr class=xl29 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl32 width=37 style='height:16.5pt;width:28pt' x:num><%= i + 1 %></td>
  <td class=xl33 width=99 style='width:74pt'><%= dt2.Rows[i]["slip_no"]  %></td>
  <td class=xl33 width=75 style='width:56pt'><%= dt2.Rows[i]["out_date"] %></td>
  <td class=xl33 width=111 style='width:83pt'><%= dt2.Rows[i]["ref_no"] %></td>
  <td class=xl33 width=114 style='width:86pt'><%= dt2.Rows[i]["item_code"] %></td>
  <td class=xl33 width=268 style='width:201pt'><%= dt2.Rows[i]["item_name"] %></td>
  <td class=xl33 width=47 style='width:35pt'><%= dt2.Rows[i]["uom"] %></td>
  <td class=xl34 width=69 style='width:52pt' x:num><span
  style='mso-spacerun:yes'>     </span><%= dt2.Rows[i]["out_qty"] %></td>
  <td class=xl34 width=84 style='width:63pt' x:num><span
  style='mso-spacerun:yes'>        </span><%= dt2.Rows[i]["unit_price"] %></td>
  <td class=xl34 width=107 style='width:80pt' x:num><span
  style='mso-spacerun:yes'>           </span><%= dt2.Rows[i]["sel_amt"] %></td>
  <td class=xl34 width=55 style='width:41pt' x:str><span
  style='mso-spacerun:yes'> </span><%= dt2.Rows[i]["tr_ccy"] %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl34 width=107 style='width:80pt' x:num><span
  style='mso-spacerun:yes'>           </span><%= dt2.Rows[i]["tax_amount"] %></td>
  <td class=xl33 width=120 style='width:90pt'><%= dt2.Rows[i]["description"] %></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
     sel_amt += Convert.ToDecimal(dt2.Rows[i]["sel_amt"]);
     tax_amt += Convert.ToDecimal(dt2.Rows[i]["tax_amount"]);
            } %>
 <!--
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl35 style='height:18.75pt'>Sum</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38 x:num="1000"><span style='mso-spacerun:yes'>    
  </span>1,000.00 </td>
  <td class=xl38 x:num="120000"><span style='mso-spacerun:yes'>     
  </span>120,000.00 </td>
  <td class=xl38 x:num="125000"><span style='mso-spacerun:yes'>             
  </span>125,000.00 </td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38 x:num="152000"><span style='mso-spacerun:yes'>             
  </span>152,000.00 </td>
  <td class=xl39>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>-->
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=6 height=34 class=xl48 width=704 style='height:25.5pt;width:528pt'>Tổng
  cộng <font class="font11">Total</font></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl42 width=107 style='width:80pt' x:num="0"><span
  style='mso-spacerun:yes'> </span><%= sel_amt %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl40></td>
  <td class=xl42 width=107 style='width:80pt' x:num="0"><span
  style='mso-spacerun:yes'> </span><%= tax_amt %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl40></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl41 colspan=3 align=left style='mso-ignore:colspan'><%= dt.Rows[0]["partner_name"] %></td>
  <td class=xl41></td>
  <td class=xl41 colspan=2 align=left style='mso-ignore:colspan'><%= dt1.Rows[0]["partner_name"] %></td>
  <td colspan=7 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=268 style='width:201pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
