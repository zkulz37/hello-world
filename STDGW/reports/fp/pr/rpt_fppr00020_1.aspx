<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%  
    string p_tin_warehouse_name = Request.QueryString["p_tin_warehouse_name"];  
    string p_master_pk = Request.QueryString["master_pk"];
    string p_date = Request.QueryString["p_date"];
    
    DataTable dt,dt1;
    dt = ESysLib.TableReadOpenCursor("LG_RPT_fppr00020", "'" + Session["User_ID"].ToString() + "'");
    dt1 = ESysLib.TableReadOpenCursor("LG_RPT_fppr00020_3", "'" + p_master_pk + "'");
    if (dt.Rows.Count == 0) { Response.Write("There is no data"); Response.End(); }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="rpt_fppr00020_1_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_fppr00020_1_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_fppr00020_1_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2012-09-12T04:17:22Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-10-04T04:51:24Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .25in .3in .25in;
	mso-header-margin:0in;
	mso-footer-margin:.11in;}
.font7
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font8
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font11
	{color:black;
	font-size:8.0pt;
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
.style56
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF9900;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF9900;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FF9900;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF9900;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl82
	{mso-style-parent:style56;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style56;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl85
	{mso-style-parent:style56;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl86
	{mso-style-parent:style56;
	color:black;
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
.xl87
	{mso-style-parent:style56;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style56;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>210</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>96</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:RangeSelection>$9:$9</x:RangeSelection>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$6:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=736 style='border-collapse:
 collapse;table-layout:fixed;width:552pt'>
 <col class=xl66 width=129 style='mso-width-source:userset;mso-width-alt:4717;
 width:97pt'>
 <col class=xl66 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl66 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl66 width=201 style='mso-width-source:userset;mso-width-alt:7350;
 width:151pt'>
 <col class=xl66 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl66 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl66 width=123 style='mso-width-source:userset;mso-width-alt:4498;
 width:92pt'>
 
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
  %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 width=129 style='height:15.0pt;width:97pt'>
  <v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape>
  </td>
  <td class=xl68 colspan=2 width=137 style='mso-ignore:colspan;width:103pt'><%= dt.Rows[i]["partner_name"]%></td>
  <td class=xl66 width=201 style='width:151pt'></td>
  <td class=xl66 width=67 style='width:50pt'></td>
  <td colspan=2 class=xl81 width=202 style='width:151pt'>Tel: <%= dt.Rows[i]["phone_no"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt'></td>
  <td class=xl67 colspan=3 style='mso-ignore:colspan'><%= dt.Rows[i]["addr1"] %></td>
  <td class=xl66></td>
  <td colspan=2 class=xl81 width=202 style='width:151pt'>Fax: <%= dt.Rows[i]["fax_no"] %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'>&nbsp;</td>
  <td class=xl69>Tax code: <span style='display:none'><%= dt.Rows[i]["tax_code"] %></span></td>
  <td class=xl67></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82 width=202 style='width:151pt'>Print date: 
   <%=System.DateTime.Now.ToString("dd/MM/yyyy")%></td>
 </tr> 
 <%
     } %>
     
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=7 height=48 class=xl83 width=736 style='height:36.0pt;width:552pt'>DAILY
  PRODUCTION INJECTION REPORT</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl67 colspan=4 style='height:21.0pt;mso-ignore:colspan'>W/H
  Name: <font class="font7"><%=p_tin_warehouse_name %></font></td>
  <td class=xl70>Date: </td>
  <td class=xl71 colspan=2 style='mso-ignore:colspan'><%=System.DateTime.ParseExact(p_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td rowspan=2 height=50 class=xl84 width=129 style='border-bottom:.5pt solid black;
  height:37.5pt;width:97pt'>Phòng ban<br>
    <font class="font8">Dept</font></td>
  <td rowspan=2 class=xl84 width=69 style='border-bottom:.5pt solid black;
  width:52pt'>Mã máy<br>
    <font class="font8">Machine No</font></td>
  <td rowspan=2 class=xl84 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Mã hàng<br>
    <font class="font8">Item Code</font></td>
  <td rowspan=2 class=xl84 width=201 style='border-bottom:.5pt solid black;
  width:151pt'>Tên hàng<font class="font10"><br>
    </font><font class="font8">Item Description</font></td>
  <td rowspan=2 class=xl86 width=67 style='width:50pt'>S&#7889;
  l&#432;&#7907;ng<br>
    <font class="font8">Quantity</font></td>
  <td rowspan=2 class=xl87 width=79 style='border-bottom:.5pt solid black;
  width:59pt'><font class="font11">S&#7889; l&#432;&#7907;ng</font><font
  class="font10"><br>
    </font><font class="font8">Quantity(KG)</font></td>
  <td rowspan=2 class=xl84 width=123 style='border-bottom:.5pt solid black;
  width:92pt'>Ghi Chú<br>
    <span style='mso-spacerun:yes'> </span><font class="font8">Remark</font></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
 </tr>
 
 <%
     int sum_qty = 0; int sum_qty_kg = 0;
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
      %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl76 width=129 style='height:22.5pt;border-top:none;
  width:97pt'><%=dt1.Rows[i]["dept_nm"]%></td>
  <td class=xl76 width=69 style='border-top:none;border-left:none;width:52pt'
  x:num><%=dt1.Rows[i]["machine_no"]%></td>
  <td class=xl73 width=68 style='border-top:none;width:51pt'><%=dt1.Rows[i]["item_code"]%></td>
  <td class=xl72 width=201 style='border-top:none;width:151pt'><%=dt1.Rows[i]["item_name"]%></td>
  <td class=xl77 width=67 style='border-top:none;width:50pt' x:num><%=dt1.Rows[i]["in_qty"]%></td>
  <td class=xl77 width=79 style='border-top:none;width:59pt' x:num><%=dt1.Rows[i]["ref_no"]%></td>
  <td class=xl75 style='border-top:none'></td>
 </tr>
 <%
     sum_qty += Convert.ToInt32(dt1.Rows[i]["in_qty"]);
     sum_qty_kg += Convert.ToInt32(dt1.Rows[i]["ref_no"]);  
     }
          %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=4 height=30 class=xl79 width=467 style='height:22.5pt;width:351pt'><span
  style='mso-spacerun:yes'> </span>Total</td>
  <td class=xl78 width=67 style='border-top:none;width:50pt' x:num><%= sum_qty%></td>
  <td class=xl78 width=79 style='border-top:none;width:59pt' x:num><%= sum_qty_kg %></td>
  <td class=xl74 style='border-top:none'>&nbsp;</td>
 </tr>
 
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 style='height:10.5pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_9" o:spid="_x0000_s1041" type="#_x0000_t75"
   style='position:absolute;margin-left:88.5pt;margin-top:2.25pt;width:462pt;
   height:92.25pt;z-index:1;visibility:visible' strokeweight="3e-5mm">
   <v:imagedata src="rpt_fppr00020_1_files/image001.png"
    o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:118px;margin-top:3px;width:616px;
  height:123px'><img width=616 height=123
  src="rpt_fppr00020_1_files/image002.jpg" v:shapes="Picture_x0020_9"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=14 class=xl66 width=129 style='height:10.5pt;width:97pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=7 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td height=14 colspan=7 class=xl66 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=129 style='width:97pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=201 style='width:151pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=123 style='width:92pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
