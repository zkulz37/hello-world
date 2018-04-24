<% 
	Response.ContentType = "application/x-excel" 
	Response.Buffer="False"
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<!-- #include file="../../../system/lib/form.inc"  -->
<!-- #include file="../db.inc"  -->
<%
	ConnectDBApp

	Dim p_lstPK, poum

	p_lstPK = Request.QueryString("lstPK")

	arrayPK = Split(p_lstPK, ",")

%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_Order_Sheet_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_Order_Sheet_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_Order_Sheet_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Le Huu Tho</o:LastAuthor>
  <o:LastPrinted>2007-10-19T06:54:24Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2007-10-19T06:58:26Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\;\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>360</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>54</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:LeftColumnVisible>3</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1880 style='border-collapse:
 collapse;table-layout:fixed;width:1411pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=191 style='mso-width-source:userset;mso-width-alt:6985;
 width:143pt'>
 <col class=xl24 width=410 style='mso-width-source:userset;mso-width-alt:14994;
 width:308pt'>
 <col class=xl24 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
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
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl24 width=112 style='mso-width-source:userset;mso-width-alt:4096;
 width:84pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=112 style='mso-width-source:userset;mso-width-alt:4096;
 width:84pt'>
 
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl26 colspan=3 width=665 style='height:24.95pt;
  mso-ignore:colspan;width:499pt'>CHUNSHIN PRECISION VINA CO,. LTD.</td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=131 style='width:98pt'></td>
  <td class=xl24 width=112 style='width:84pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl26 colspan=3 style='height:24.95pt;mso-ignore:colspan'>AN
  TÂY - BẾN CÁT - BÌNH DƯƠNG</td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl26 colspan=3 style='height:24.95pt;mso-ignore:colspan'>TEL
  : (0650)578 - 501/02/03. FAX : (0650) 578 - 504.</td>
  <td class=xl26></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl26 colspan=3 style='height:24.95pt;mso-ignore:colspan'>MS.HUỆ/HANDPHONE
  : 0919302012.</td>
  <td class=xl26></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
 	Dim po, cust, order
 	for i = 0 to Ubound(arrayPK) - 1
	
		SQL = " select res.po_num, res.cust_name, to_char(to_date(res.order_dt, 'YYYYMMDD'), 'MM/DD/YYYY') order_dt, res.item_code, res.item_name, res.uom, res.ord_qty, "
		SQL = SQL & "       to_char(to_date(substr (d1, 1, instr (d1, '#') - 1), 'YYYYMMDD'), 'MM/DD/YYYY' ) date1, nvl(substr (d1, instr (d1, '#') + 1),0) qty1, "
		SQL = SQL & "       to_char(to_date(substr (d2, 1, instr (d2, '#') - 1), 'YYYYMMDD'), 'MM/DD/YYYY' ) date2, nvl(substr (d2, instr (d2, '#') + 1),0) qty2,  "
		SQL = SQL & "       to_char(to_date(substr (d3, 1, instr (d3, '#') - 1), 'YYYYMMDD'), 'MM/DD/YYYY' ) date3, nvl(substr (d3, instr (d3, '#') + 1),0) qty3,  "
		SQL = SQL & "       to_char(to_date(substr (d4, 1, instr (d4, '#') - 1), 'YYYYMMDD'), 'MM/DD/YYYY' ) date4, nvl(substr (d4, instr (d4, '#') + 1),0) qty4,  "
		SQL = SQL & "       nvl(sumover,0)  "
		SQL = SQL & "  from (select order_num, a.PO_NUM, comm.sf_get_custnamebyid (a.bill_to) as cust_name, order_dt, c.item_code, c.item_name, c.uom, b.ord_qty,  "
		SQL = SQL & "               prod.sf_get_takeout_from_order(b.pk, 1) d1, prod.sf_get_takeout_from_order (b.pk, 2) d2,  "
		SQL = SQL & "               prod.sf_get_takeout_from_order(b.pk, 3) d3, prod.sf_get_takeout_from_order (b.pk, 4) d4,  "
		SQL = SQL & "               prod.sf_get_takeout_from_order(b.pk, 99) sumover  "
		SQL = SQL & "          from tsa_ccorderm a, tsa_ccorderd b, tco_ciitem c  "
		'SQL = SQL & "         where a.pk = b.ord_pk and b.item_pk = c.pk and b.del_if = 0 and a.pk = 8264) res "
		SQL = SQL & "         where a.pk = b.ord_pk and b.item_pk = c.pk and b.del_if = 0 and a.pk = "& arrayPK(i) &") res "

		'response.write SQL
		'response.end

		TableReadOpen rs, SQL
		if not rs.EOF then
			po    = rs("po_num")
			cust  = rs("cust_name")
			order = rs("order_dt")
		else
			po    = ""
			cust  = ""
			order = ""
		end if
		
		TableReadOpen rs1, SQL
		if not rs1.EOF then
			data = rs1.GetRows()
			ttdata = Ubound(data, 2) + 1
		else
			ttdata  = 0
		end if
 %>
 
 <tr height=46 style='mso-height-source:userset;height:35.1pt'>
  <td colspan=16 height=46 class=xl36 style='height:35.1pt'>ORDER SHEET &quot;
  <%=po%> &quot; - <%=cust%></td>
 </tr>
 <tr class=xl28 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 colspan=2 class=xl26 style='height:30.0pt;mso-ignore:colspan'></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl43>Order Date:</td>
  <td class=xl44 x:num><%=order%></td>
  <td class=xl42></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td rowspan=2 height=52 class=xl37 style='border-bottom:.5pt solid black;
  height:40.2pt'>No</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Item Code</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Item Name</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>U/T</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black'>Q' Ty</td>
  <td colspan=9 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>EVERYDAY DELIVERY DATE</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Total Del</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Bal</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl27 style='height:20.1pt'>Date</td>
  <td class=xl27>Q' Ty</td>
  <td class=xl27>Date</td>
  <td class=xl27>Q' Ty</td>
  <td class=xl27>Date</td>
  <td class=xl27>Q' Ty</td>
  <td class=xl27>Date</td>
  <td class=xl27>Q' Ty</td>
  <td class=xl27>Q' Ty</td>
 </tr>
 <%
	Dim j, a

 	for j = 0 to ttdata - 1
 %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl45 style='height:24.95pt' x:num><%=j+1%></td>
  <td class=xl29 x:num><%=data(3,j)%></td>
  <td class=xl30 x:num><%=data(4,j)%></td>
  <td class=xl31 x:num><%=data(5,j)%></td>
  <td class=xl32 x:num><%=data(6,j)%></td>
  <td class=xl33 x:num><%=data(7,j)%></td>
  <td class=xl32 x:num><%=data(8,j)%></td>
  <td class=xl33 x:num><%=data(9,j)%></td>
  <td class=xl32 x:num><%=data(10,j)%></td>
  <td class=xl33 x:num><%=data(11,j)%></td>
  <td class=xl32 x:num><%=data(12,j)%></td>
  <td class=xl33 x:num><%=data(13,j)%></td>
  <td class=xl32 x:num><%=data(14,j)%></td>
  <td class=xl32 x:num><%=data(15,j)%></td>
  <td class=xl32 x:num><%=Cdbl(data(8,j))+Cdbl(data(10,j))+Cdbl(data(12,j))+Cdbl(data(14,j))+Cdbl(data(15,j))%></td>
  <td class=xl32 x:num><%=Cdbl(data(6,j)) - Cdbl(data(8,j)) + Cdbl(data(10,j)) + Cdbl(data(12,j)) + Cdbl(data(14,j)) + Cdbl(data(15,j))%></td>
 </tr>
 <%
 	next
 %>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl35><%=a%></td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl35></td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl35></td>
  <td class=xl24></td>
  
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%next%>
 <%CloseDB%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=410 style='width:308pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=82 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
