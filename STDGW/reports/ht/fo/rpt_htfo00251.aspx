<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p1= Request.QueryString["p1"];
	string l_parameter = "'" +  p1 + "'";
	
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_htfo00251",l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="htfo00040_files/filelist.xml">
<link rel=Edit-Time-Data href="htfo00040_files/editdata.mso">
<link rel=OLE-Object-Data href="htfo00040_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2010-11-30T10:21:24Z</o:LastPrinted>
  <o:Created>2010-11-30T08:32:49Z</o:Created>
  <o:LastSaved>2010-11-30T10:30:29Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .2in .5in .2in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"Short Date";}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\@";}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl32
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl38
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>9</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
       <x:RangeSelection>$K$20:$L$20</x:RangeSelection>
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
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=715 style='border-collapse:
 collapse;table-layout:fixed;width:538pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=64 style='width:48pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=64 style='width:48pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>

 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=12 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 colspan=2 style='height:15.0pt;mso-ignore:colspan'
  x:str="TÊN / Name : ">TÊN / Name :<span style='mso-spacerun:yes'> </span></td>
  <td></td>
  <td colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0][2]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>THU NGÂN / Cashier# :</td>
  <td colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0][6]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 colspan=3 style='height:15.0pt;mso-ignore:colspan'
  x:str="MÃ S&#7888; THU&#7870; / Tax code : ">MÃ S&#7888; THU&#7870; / Tax
  code :<span style='mso-spacerun:yes'> </span></td>
  <td class=xl29 colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0][4]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>NGÀY &#272;&#7870;N /
  Arrival :</td>
  <td class=xl28 align=right x:num><%=dt.Rows[0][7]%></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 colspan=3 style='height:15.0pt;mso-ignore:colspan'
  x:str="&#272;&#7882;A CH&#7880; / Address : ">&#272;&#7882;A CH&#7880; /
  Address :<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0][3]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>NGÀY &#272;I / Departure
  :</td>
  <td class=xl28 align=right x:num><%=dt.Rows[0][8]%></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 colspan=3 style='height:15.0pt;mso-ignore:colspan'>S&#7888;
  PHÒNG / Room# :</td>
  <td class=xl27 x:num><%=dt.Rows[0][5]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'
  x:str="S&#7888; &#272;ÊM / No. Night : ">S&#7888; &#272;ÊM / No. Night :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 x:num><%=dt.Rows[0][13]%></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 colspan=3 style='height:15.0pt;mso-ignore:colspan'>MÃ
  KH / Guest code :</td>
  <td></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'
  x:str="S&#7888; TRANG / Page# : ">S&#7888; TRANG / Page# :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29>1/1</td>
  <td></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=12 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl42 style='height:15.0pt'>STT</td>
  <td colspan=5 class=xl43>Tên hàng hóa, d&#7883;ch v&#7909;</td>
  <td class=xl43>&#272;VT</td>
  <td class=xl43>S&#7889; l&#432;&#7907;ng</td>
  <td colspan=2 class=xl43>&#272;&#417;n giá</td>
  <td colspan=2 class=xl43 style='border-right:1.0pt solid black'>Thành
  ti&#7873;n</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'>No.</td>
  <td colspan=5 class=xl45>Items</td>
  <td class=xl45>Unit</td>
  <td class=xl45>Quantity</td>
  <td colspan=2 class=xl45>Unit Price</td>
  <td colspan=2 class=xl45 style='border-right:1.0pt solid black'>Amout</td>
 </tr>
 <%for (int i = 0; i < dt.Rows.Count; i++){%>
 <tr class=xl35 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl33 style='height:18.0pt' x:num><%=dt.Rows[i][10]%></td>
  <td colspan=5 class=xl52><%=dt.Rows[i][11]%></td>
  <td class=xl34><%=dt.Rows[i][12]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][13]%></td>
  <td colspan=2 class=xl50 x:num><%=dt.Rows[i][14]%></td>
  <td colspan=2 class=xl50 style='border-right:1.0pt solid black' x:num=><%=dt.Rows[i][15]%></td>
 </tr>
 <%} %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt'>&nbsp;</td>
  <td colspan=9 class=xl54>C&#7897;ng / Sub Total</td>
  <td colspan=2 class=xl56 style='border-right:1.0pt solid black' x:num><%=dt.Rows[0][16]%></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=6 style='height:7.5pt;mso-ignore:colspan'></td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl31>Phí d&#7883;ch v&#7909; / SVC (5%):</td>
  <td colspan=2 class=xl50 x:num><%=dt.Rows[0][17]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl31>Ti&#7873;n thu&#7871; GTGT / VAT (10%):</td>
  <td colspan=2 class=xl50 x:num><%=dt.Rows[0][18]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl31>Chi&#7871;t kh&#7845;u / Discount :</td>
  <td colspan=2 class=xl50 x:num>- <%=dt.Rows[0][20]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl31>Đặt cọc / Diposit :</td>
  <td colspan=2 class=xl50 x:num>- <%=dt.Rows[0][21]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl31
  x:str>T&#7893;ng
  c&#7897;ng ti&#7873;n thanh toán / Amount due :<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50 x:num><%=dt.Rows[0][19]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl31 x:str="T&#7927; giá / Exchange rate (VND / USD): ">T&#7927;
  giá / Exchange rate (VND / USD):<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl51 x:num><%=dt.Rows[0][9]%></td>
  <td colspan=2 class=xl50 x:num><%=dt.Rows[0][23]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl31 x:str="Payment method:">Payment method:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl51 x:num><%=dt.Rows[0][22]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 colspan=4 style='height:15.0pt;mso-ignore:colspan'>S&#7889;
  ti&#7873;n b&#7857;ng ch&#7919; / In word:</td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=12 height=20 class=xl48 style='height:15.0pt'><%=CommondLib.Num2VNText(dt.Rows[0][19].ToString(),"VND") %></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl41 style='height:6.0pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=12 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=12 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=140 style='mso-height-source:userset;height:105.0pt;mso-xlrowspan:
  7'>
  <td height=140 colspan=12 style='height:105.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=68 style='width:51pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
