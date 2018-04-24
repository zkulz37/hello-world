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
    string l_pks = Request.QueryString["p_pks"];
    string l_taxcode = Request.QueryString["p_taxcode"];
    string l_company_name = Request.QueryString["p_company_name"];
    string l_company_adress = Request.QueryString["p_company_adress"];
    
    DataTable dt,dt1;
    string l_parameter = "'" + l_pks + "','" + l_taxcode + "','" + l_company_name + "','" + l_company_adress;
    dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_jarc00040_invoice_print", l_parameter);
    string sql = "select to_char(to_date(sysydate,'yyyymmdd'),'dd/mm/yyyy'),to_char(to_date(sysydate,'yyyymmdd'),'yyyy/mm/dd') from dual";
    dt1 = ESysLib.TableReadOpen(sql);
    string to_day = dt1.Rows[0][0].ToString();
    string to_day2 = dt1.Rows[0][1].ToString();
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Rpt_CheckOut_Bill2_files/filelist.xml">
<link rel=Edit-Time-Data href="Rpt_CheckOut_Bill2_files/editdata.mso">
<link rel=OLE-Object-Data href="Rpt_CheckOut_Bill2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>User</o:LastAuthor>
  <o:LastPrinted>2010-07-09T17:19:59Z</o:LastPrinted>
  <o:Created>2010-07-09T13:52:54Z</o:Created>
  <o:LastSaved>2010-07-09T17:20:46Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.49in .6in .5in .47in;
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl51
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl55
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl56
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>20</x:ActiveCol>
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
  <x:WindowHeight>6405</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=669 style='border-collapse:
 collapse;table-layout:fixed;width:503pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=64 style='width:48pt'>
 <col width=118 style='mso-width-source:userset;mso-width-alt:4315;width:89pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=30 style='mso-width-source:userset;mso-width-alt:1097;width:23pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1097'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:1133'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:4352;width:89pt'>
 <col width=1 style='mso-width-source:userset;mso-width-alt:36;width:1pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:36'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=14 rowspan=6 height=102 width=669 style='height:76.5pt;
  width:503pt' align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:198pt;margin-top:11.25pt;width:112.5pt;height:63pt;z-index:1'>
   <v:imagedata src="Rpt_CheckOut_Bill2_files/image001.jpg" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:264px;margin-top:15px;width:150px;
  height:84px'><img width=150 height=84
  src="Rpt_CheckOut_Bill2_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=14 rowspan=6 height=102 class=xl35 width=669 style='height:
    76.5pt;width:503pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=0></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=12 height=17 class=xl57 style='height:12.75pt'>Date:</td>
  <td class=xl35>yyyymmdd</td>
  <td class=xl35></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 colspan=3 style='height:12.75pt;mso-ignore:colspan;
  border-right:.5pt solid black'>&#272;&#7883;a Ch&#7881; / Address :</td>
  <td colspan=11 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>dia chi cty</td>
  <td class=xl26>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 colspan=3 style='height:12.75pt;mso-ignore:colspan;
  border-right:.5pt solid black'>S&#7889; Tài Kho&#7843;n / Account No :</td>
  <td colspan=11 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>tai khoan cty</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 colspan=3 style='height:12.75pt;mso-ignore:colspan;
  border-right:.5pt solid black'>&#272;i&#7879;n Tho&#7841;i / Tel :</td>
  <td colspan=11 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>dt cty gofl</td>
  <td class=xl27>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 colspan=3 style='height:12.75pt;mso-ignore:colspan;
  border-right:.5pt solid black'>Mã S&#7889; Thu&#7871; / Tax Code :</td>
  <td colspan=11 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>taxcode gofl</td>
  <td class=xl28>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl47 style='border-right:.5pt solid black;
  height:12.75pt'>Khách Hàng /Customer Name :</td>
  <td colspan=11 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>ten khach hang</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl47 style='border-right:.5pt solid black;
  height:12.75pt' x:str="Tên Công Ty / Company Name : ">Tên Công Ty / Company
  Name :<span style='mso-spacerun:yes'> </span></td>
  <td colspan=11 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>ten cty khach hang</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl47 style='border-right:.5pt solid black;
  height:12.75pt'>&#272;&#7883;a Ch&#7881; / Address :</td>
  <td colspan=11 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>dchi khang</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl47 style='border-right:.5pt solid black;
  height:12.75pt'>S&#7889; Tài Kho&#7843;n / Account No :</td>
  <td colspan=11 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>tai khoan k.hang</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl47 style='border-right:.5pt solid black;
  height:12.75pt'>Hình Th&#7913;c Thanh Toán/ Payment:</td>
  <td colspan=11 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>method pay</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none'>No</td>
  <td colspan=2 class=xl29 style='border-left:none'>Invoice No</td>
  <td colspan=3 class=xl29 style='border-left:none'>Caddy Fee</td>
  <td colspan=3 class=xl29 style='border-left:none'>Green Fee</td>
  <td colspan=5 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>Amount(VND)</td>
  <td></td>
 </tr>
  <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt' x:num><%=dt.Rows[i][0]%></td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[i][2]%> No</td>
  <td colspan=3 class=xl46 style='border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td colspan=3 class=xl46 style='border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td colspan=5 class=xl43 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[i][3]%></td>
  <td></td>
 </tr>
      <% 
     }
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl54 style='height:12.75pt'
  x:str="Thu&#7871; Su&#7845;t GTGT / VAT Rate :     ">Thu&#7871; Su&#7845;t
  GTGT / VAT Rate :<span style='mso-spacerun:yes'>     </span></td>
  <td class=xl36 x:num="0.1">10%</td>
  <td colspan=2 class=xl50></td>
  <td colspan=6 class=xl30>C&#7897;ng Ti&#7873;n Hàng / Net Total :</td>
  <td colspan=2 class=xl53 x:num="12346642">12,346,642</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl30 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl50></td>
  <td colspan=6 class=xl30 x:str="Ti&#7873;n Thu&#7871;  GTGT / VAT Amount : ">Ti&#7873;n
  Thu&#7871;<span style='mso-spacerun:yes'>  </span>GTGT / VAT Amount :<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl53 x:num="12345665">12,345,665</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl30><span style='mso-spacerun:yes'> </span>Gi&#7843;m
  Giá / Discount :</td>
  <td colspan=2 class=xl53 x:num="12345678">12,345,678</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=5 class=xl30>T&#7893;ng Ti&#7873;n Thanh Toán(VND)/Gross Total :</td>
  <td colspan=2 class=xl53 x:num="12345678">12,345,678</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl54 style='height:12.75pt'
  x:str="T&#7927; Giá Ngo&#7841;i T&#7879; / Change Rate :  ">T&#7927; Giá
  Ngo&#7841;i T&#7879; / Change Rate :<span style='mso-spacerun:yes'>  </span></td>
  <td colspan=2 class=xl55 x:num="41231243">41,231,243</td>
  <td class=xl30></td>
  <td colspan=6 class=xl30>T&#7893;ng Ti&#7873;n Thanh Toán(USD)/Gross Total :</td>
  <td colspan=2 class=xl56 x:num="12345678">12,345,678.00</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=40 style='width:30pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=1 style='width:1pt'></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
