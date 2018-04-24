<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%    
    string p_from_date = Request.QueryString["from_date"];
	
	string fr_date = p_from_date.Substring(6, 2) + "/" + p_from_date.Substring(4, 2) + "/" + p_from_date.Substring(0, 4);
	
    string factory_pk = Request.QueryString["factory_pk"];
    string factory_name = Request.QueryString["factory_name"];	
	
	string para = "'" + p_from_date + "','" + factory_pk + "'";
	
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00094_2", para); 
	
    DataTable dt_header;
    dt_header = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00094_3"); 			
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00094_2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00094_2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00094_2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2011-01-18T07:22:23Z</o:LastPrinted>
  <o:Created>2011-01-18T02:41:07Z</o:Created>
  <o:LastSaved>2011-01-18T08:23:13Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.18in .17in .17in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
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
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>180</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>83</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>16155</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1200 style='border-collapse:
 collapse;table-layout:fixed;width:900pt'>
 <col class=xl24 width=40 span=30 style='mso-width-source:userset;mso-width-alt:
 1462;width:30pt'>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=30 height=37 class=xl25 width=1200 style='height:27.75pt;
  width:900pt'>PREPARATION STATUS BY P/O</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=6 height=21 class=xl36 style='height:15.75pt'><%=factory_name%></td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25>Date</td>
  <td colspan=5 class=xl36><%=fr_date%></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl26 style='height:30.0pt;border-top:none'>P/O</td>
  <td class=xl26 style='border-top:none;border-left:none'>Style</td>
  <td class=xl26 style='border-top:none;border-left:none'>Color</td>
  <td class=xl26 style='border-top:none;border-left:none'>Plan</td>
  <td class=xl26 style='border-top:none;border-left:none'>Cut</td>
  <td class=xl31 width=40 style='border-top:none;border-left:none;width:30pt'><%=dt_header.Rows[0]["comp01"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp02"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp03"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp04"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp05"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp06"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp07"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp08"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp09"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp10"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp11"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp12"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp13"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp14"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp15"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp16"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp17"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp18"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp19"]%></td>
  <td class=xl31 width=40 style='border-left:none;width:30pt'><%=dt_header.Rows[0]["comp20"]%></td>
  <td class=xl31 width=40 style='border-top:none;border-left:none;width:30pt'><%=dt_header.Rows[0]["comp21"]%></td>
  <td class=xl31 width=40 style='border-top:none;border-left:none;width:30pt'><%=dt_header.Rows[0]["comp22"]%></td>
  <td class=xl31 width=40 style='border-top:none;border-left:none;width:30pt'><%=dt_header.Rows[0]["comp23"]%></td>
  <td class=xl31 width=40 style='border-top:none;border-left:none;width:30pt'><%=dt_header.Rows[0]["comp24"]%></td>
  <td class=xl31 width=40 style='border-top:none;border-left:none;width:30pt'><%=dt_header.Rows[0]["comp25"]%></td>
 </tr>
 <%
 	 for (int i = 0; i < dt.Rows.Count; i++)
     {
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl32 height:30.0pt'><%=dt.Rows[i]["ref_po_no"]%></td>
  <td rowspan=2 class=xl34><%=dt.Rows[i]["item_code"]%></td>
  <td rowspan=2 class=xl34><%=dt.Rows[i]["spec_id"]%></td>
  <td rowspan=2 class=xl37 x:num=""><%=dt.Rows[i]["plan_qty"]%></td>
  <td rowspan=2 class=xl37 x:num=""><%=dt.Rows[i]["cut_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp01_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp02_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp03_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp04_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp05_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp06_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp07_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp08_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp09_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp10_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp11_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp12_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp13_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp14_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp15_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp16_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp17_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp18_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp19_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp20_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp21_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp22_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp23_re_qty"]%></td>
  <td class=xl27 style='border-left:none' x:num><%=dt.Rows[i]["comp24_re_qty"]%></td>
  <td class=xl28 style='border-left:none' x:num><%=dt.Rows[i]["comp25_re_qty"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt;border-top:none;border-left:
  none' x:num=""><%=dt.Rows[i]["comp01_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp02_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp03_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp04_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp05_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp06_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp07_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp08_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp09_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp10_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp11_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp12_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp13_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp14_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp15_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp16_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp17_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp18_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp19_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp20_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp21_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp22_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp23_prod_qty"]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp24_prod_qty"]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["comp25_prod_qty"]%></td>
 </tr>
<%
	}
%>
 <tr height=13 style='height:9.75pt'>
  <td height=13 colspan=30 class=xl24 style='height:9.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
