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
    string p_spec_chk = Request.QueryString["p_spec_chk"];
	string p_page = Request.QueryString["p_page"];

    string para = "'" + p_from_date + "','" + factory_pk + "','" + p_spec_chk + "','" + p_page + "'";
	
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00094_4", para); 
	
	para = "'" + p_page + "'";
	
    DataTable dt_header;
    dt_header = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00094_3", para); 			
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00094_4_1_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00094_4_1_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00094_4_1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-01-26T17:47:01Z</o:LastPrinted>
  <o:Created>2011-01-18T02:41:07Z</o:Created>
  <o:LastSaved>2011-01-26T17:47:20Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.18in .05in .17in .05in;
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
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
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
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
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
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>180</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:LeftColumnVisible>3</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1030 style='border-collapse:
 collapse;table-layout:fixed;width:785pt'>
 <col class=xl24 width=40 span=7 style='mso-width-source:userset;mso-width-alt:
 1462;width:30pt'>
 <col class=xl24 width=30 span=25 style='mso-width-source:userset;mso-width-alt:
 1097;width:23pt'>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=32 height=37 class=xl25 width=1030 style='height:27.75pt;
  width:785pt'>R/G LINE PREPARATION <%=p_page%></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=8 height=21 class=xl31 style='height:15.75pt'><%=factory_name%></td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25>Date</td>
  <td colspan=5 class=xl31><%=fr_date%></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl39 style='height:30.0pt;border-top:none'>R/G</td>
  <td class=xl26>P/O</td>
  <td class=xl26>Style</td>
  <td class=xl26>Spec</td>
  <td class=xl26>Ord Targer</td>
  <td class=xl26>Daily Target</td>
  <td class=xl26>Prod Qty</td>
  <td class=xl27 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp01"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp02"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp03"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp04"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp05"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp06"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp07"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp08"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp09"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp10"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp11"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp12"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp13"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp14"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp15"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp16"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp17"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp18"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp19"]%></td>
  <td class=xl28 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp20"]%></td>
  <td class=xl27 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp21"]%></td>
  <td class=xl27 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp22"]%></td>
  <td class=xl27 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp23"]%></td>
  <td class=xl27 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp24"]%></td>
  <td class=xl27 width=30 style='width:23pt'><%=dt_header.Rows[0]["comp25"]%></td>
 </tr>
   <%
  	 int s_prod_qty      	    = 0;
	 int s_bal01_qty 	    = 0;
	 int s_bal02_qty 	    = 0;
	 int s_bal03_qty 	    = 0;
	 int s_bal04_qty 	    = 0;
	 int s_bal05_qty 	    = 0;
	 int s_bal06_qty 	    = 0;
	 int s_bal07_qty 	    = 0;
	 int s_bal08_qty 	    = 0;
	 int s_bal09_qty 	    = 0;
	 int s_bal10_qty 	    = 0;
	 int s_bal11_qty 	    = 0;
	 int s_bal12_qty	    = 0;
	 int s_bal13_qty 	    = 0;
	 int s_bal14_qty 	    = 0;
	 int s_bal15_qty 	    = 0;
	 int s_bal16_qty 	    = 0;
	 int s_bal17_qty 	    = 0;
	 int s_bal18_qty 	    = 0;
	 int s_bal19_qty 	    = 0;
	 int s_bal20_qty 	    = 0;
	 int s_bal21_qty 	    = 0;
	 int s_bal22_qty 	    = 0;
	 int s_bal23_qty 	    = 0;
	 int s_bal24_qty 	    = 0;
	 int s_bal25_qty 	    = 0;
	 
 	 for (int i = 0; i < dt.Rows.Count; i++)
     {
	 
     s_prod_qty      	    = s_prod_qty         + Convert.ToInt32(dt.Rows[i]["prod_qty"].ToString()) ;
	 
	 if ( Convert.ToInt32(dt.Rows[i]["bal01_qty"].ToString()) < 0 )
	 {
	 	s_bal01_qty 	    = s_bal01_qty  + Convert.ToInt32(dt.Rows[i]["bal01_qty"].ToString());
	 }		 
	 if ( Convert.ToInt32(dt.Rows[i]["bal02_qty"].ToString()) < 0 )
	 {
	 	s_bal02_qty 	    = s_bal02_qty  + Convert.ToInt32(dt.Rows[i]["bal02_qty"].ToString());
	 }		 
	 if ( Convert.ToInt32(dt.Rows[i]["bal03_qty"].ToString()) < 0 )
	 {
	 	s_bal03_qty 	    = s_bal03_qty  + Convert.ToInt32(dt.Rows[i]["bal03_qty"].ToString());
	 }	
	 if ( Convert.ToInt32(dt.Rows[i]["bal04_qty"].ToString()) < 0 )
	 {
	 	s_bal04_qty 	    = s_bal04_qty  + Convert.ToInt32(dt.Rows[i]["bal04_qty"].ToString());
	 }	
	 if ( Convert.ToInt32(dt.Rows[i]["bal05_qty"].ToString()) < 0 )
	 {
	 	s_bal05_qty 	    = s_bal05_qty  + Convert.ToInt32(dt.Rows[i]["bal05_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal06_qty"].ToString()) < 0 )
	 {
	 	s_bal06_qty 	    = s_bal06_qty  + Convert.ToInt32(dt.Rows[i]["bal06_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal07_qty"].ToString()) < 0 )
	 {
	 	s_bal07_qty 	    = s_bal07_qty  + Convert.ToInt32(dt.Rows[i]["bal07_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal08_qty"].ToString()) < 0 )
	 {
	 	s_bal08_qty 	    = s_bal08_qty  + Convert.ToInt32(dt.Rows[i]["bal08_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal09_qty"].ToString()) < 0 )
	 {
	 	s_bal09_qty 	    = s_bal04_qty  + Convert.ToInt32(dt.Rows[i]["bal09_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal10_qty"].ToString()) < 0 )
	 {
	 	s_bal10_qty 	    = s_bal10_qty  + Convert.ToInt32(dt.Rows[i]["bal10_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal11_qty"].ToString()) < 0 )
	 {
	 	s_bal11_qty 	    = s_bal11_qty  + Convert.ToInt32(dt.Rows[i]["bal11_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal12_qty"].ToString()) < 0 )
	 {
	 	s_bal12_qty 	    = s_bal12_qty  + Convert.ToInt32(dt.Rows[i]["bal12_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal13_qty"].ToString()) < 0 )
	 {
	 	s_bal13_qty 	    = s_bal13_qty  + Convert.ToInt32(dt.Rows[i]["bal13_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal14_qty"].ToString()) < 0 )
	 {
	 	s_bal14_qty 	    = s_bal14_qty  + Convert.ToInt32(dt.Rows[i]["bal14_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal15_qty"].ToString()) < 0 )
	 {
	 	s_bal15_qty 	    = s_bal15_qty  + Convert.ToInt32(dt.Rows[i]["bal15_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal16_qty"].ToString()) < 0 )
	 {
	 	s_bal16_qty 	    = s_bal16_qty  + Convert.ToInt32(dt.Rows[i]["bal16_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal17_qty"].ToString()) < 0 )
	 {
	 	s_bal17_qty 	    = s_bal17_qty  + Convert.ToInt32(dt.Rows[i]["bal17_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal18_qty"].ToString()) < 0 )
	 {
	 	s_bal18_qty 	    = s_bal18_qty  + Convert.ToInt32(dt.Rows[i]["bal18_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal19_qty"].ToString()) < 0 )
	 {
	 	s_bal19_qty 	    = s_bal19_qty  + Convert.ToInt32(dt.Rows[i]["bal19_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal20_qty"].ToString()) < 0 )
	 {
	 	s_bal20_qty 	    = s_bal20_qty  + Convert.ToInt32(dt.Rows[i]["bal20_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal21_qty"].ToString()) < 0 )
	 {
	 	s_bal21_qty 	    = s_bal21_qty  + Convert.ToInt32(dt.Rows[i]["bal21_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal22_qty"].ToString()) < 0 )
	 {
	 	s_bal22_qty 	    = s_bal22_qty  + Convert.ToInt32(dt.Rows[i]["bal22_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal23_qty"].ToString()) < 0 )
	 {
	 	s_bal23_qty 	    = s_bal23_qty  + Convert.ToInt32(dt.Rows[i]["bal23_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal24_qty"].ToString()) < 0 )
	 {
	 	s_bal24_qty 	    = s_bal24_qty  + Convert.ToInt32(dt.Rows[i]["bal24_qty"].ToString());
	 }
	 if ( Convert.ToInt32(dt.Rows[i]["bal25_qty"].ToString()) < 0 )
	 {
	 	s_bal25_qty 	    = s_bal25_qty  + Convert.ToInt32(dt.Rows[i]["bal25_qty"].ToString());
	 }
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl40 style='border-bottom:.5pt solid black;
  height:30.0pt'><%=dt.Rows[i]["routing_group"]%></td>
  <td rowspan=2 class=xl32 style='border-bottom:.5pt solid black'><%=dt.Rows[i]["ref_po_no"]%></td>
  <td rowspan=2 class=xl32 style='border-bottom:.5pt solid black'><%=dt.Rows[i]["item_code"]%></td>
  <td rowspan=2 class=xl34 style='border-bottom:.5pt solid black'><%=dt.Rows[i]["spec_id"]%></td>
  <td rowspan=2 class=xl34 style='border-bottom:.5pt solid black'><%=dt.Rows[i]["ord_target"]%></td>
  <td rowspan=2 class=xl34 style='border-bottom:.5pt solid black'><%=dt.Rows[i]["daily_target"]%></td>
  <td rowspan=2 class=xl34 style='border-bottom:.5pt solid black' x:num><%=dt.Rows[i]["prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp01_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp02_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp03_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp04_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp05_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp06_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp07_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp08_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp09_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp10_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp11_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp12_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp13_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp14_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp15_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp16_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp17_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp18_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp19_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp20_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp21_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp22_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp23_prod_qty"]%></td>
  <td class=xl29 x:num><%=dt.Rows[i]["comp24_prod_qty"]%></td>
  <td class=xl37 style='border-left:none' x:num><%=dt.Rows[i]["comp25_prod_qty"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt' x:num><%=dt.Rows[i]["bal01_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal02_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal03_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal04_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal05_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal06_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal07_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal08_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal09_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal10_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal11_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal12_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal13_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal14_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal15_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal16_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal17_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal18_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal19_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal20_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal21_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal22_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal23_qty"]%></td>
  <td class=xl30 x:num><%=dt.Rows[i]["bal24_qty"]%></td>
  <td class=xl38 style='border-left:none' x:num><%=dt.Rows[i]["bal25_qty"]%></td>
 </tr>
 <%
 }
 %>
 <tr height=13 style='height:9.75pt'>
  <td height=13 class=xl36 style='height:9.75pt'>&nbsp;</td>
  <td colspan=5 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>TOTAL</td>
  <td class=xl45 style='border-left:none' x:num ><%=s_prod_qty%></td>
  <td class=xl45 style='border-left:none' x:num ><%=s_bal01_qty%></td>
  <td class=xl45 style='border-left:none' x:num ><%=s_bal02_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal03_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal04_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal05_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal06_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal07_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal08_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal09_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal10_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal11_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal12_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal13_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal14_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal15_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal16_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal17_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal18_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal19_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal20_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal21_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal22_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal23_qty%></td>
  <td class=xl46 style='border-left:none' x:num ><%=s_bal24_qty%></td>
  <td class=xl47 style='border-left:none' x:num ><%=s_bal25_qty%></td>
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
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
