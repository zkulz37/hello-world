<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string _date         = Request.QueryString["p_from_date"];
	string _factory_pk   = Request.QueryString["p_factory_pk"];	
	string _factory_name = Request.QueryString["p_factory_name"];	
	string _para = " '" + _factory_pk + "','" + _date + "'";
	
	DataTable dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00097", _para);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00097_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00097_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00097_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ThuyKim</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2011-04-15T08:46:35Z</o:LastPrinted>
  <o:Created>2010-05-08T06:07:47Z</o:Created>
  <o:LastSaved>2011-04-15T10:12:02Z</o:LastSaved>
  <o:Company>Simone</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.23in .17in .19in .17in;
	mso-header-margin:.18in;
	mso-footer-margin:.17in;
	mso-page-orientation:landscape;}
.font10
	{color:#993300;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
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
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;
	 
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:6.5pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt double windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Hourly Result</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:RangeSelection>$A$3:$G$3</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5175</x:WindowHeight>
  <x:WindowWidth>6945</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl35>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1060 style='border-collapse:
 collapse;table-layout:fixed;width:794pt'>
 <col class=xl35 width=65 style='mso-width-source:userset;mso-width-alt:1848;
 width:49pt'>
 <col class=xl35 width=70 span=3 style='mso-width-source:userset;mso-width-alt:
 1991;width:53pt'>
 <col class=xl35 width=60 span=3 style='mso-width-source:userset;mso-width-alt:
 1706;width:45pt'>
 <col class=xl35 width=55 span=11 style='mso-width-source:userset;mso-width-alt:
 1564;width:41pt'>
 <tr height=36 style='height:27.0pt'>
  <td colspan=14 height=36 class=xl40 width=840 style='height:27.0pt;
  width:630pt'>LINE HOURLY REPORT <font class="font10"><%=_factory_name%></font></td>
  <td colspan=4 class=xl39 width=220 style='width:164pt'><%= System.DateTime.ParseExact(_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl43 style='height:18.75pt;border-top:none'>Buyer</td>
  <td class=xl44 style='border-top:none;border-left:none'>P/O</td>
  <td class=xl44 style='border-top:none;border-left:none'>Style</td>
  <td class=xl44 style='border-top:none;border-left:none'>Spec</td>
  <td class=xl44 style='border-top:none;border-left:none'>Ord Qty</td>
  <td class=xl44 style='border-top:none;border-left:none'>Prod Qty</td>
  <td class=xl44 style='border-top:none;border-left:none'>Bal Qty</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>07:30~08:30</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>08:30~09:30</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>09:30~10:30</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>10:30~11:30</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>12:30~13:30</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>13:30~14:30</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>14:30~15:30</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>15:30~17:00</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>17:00~18:00</td>
  <td class=xl45 width=55 style='border-top:none;border-left:none;width:41pt'>18:00~19:00</td>
  <td class=xl46 style='border-top:none;border-left:none'>Total</td>
 </tr>
 <%
 	 int order_qty = 0;
	 int prod_qty  = 0;
	 int bal_qty   = 0;
	 
 	 int result_s_8 = 0;
	 int result_s_9 = 0;
	 int result_s_10 = 0;
	 int result_s_11 = 0;
	 int result_s_13 = 0;
	 int result_s_14 = 0;
	 int result_s_15 = 0;
	 int result_s_17 = 0;
	 int result_s_18 = 0;
	 int result_s_19 = 0;
	 int result_total_s = 0;
	 
 	 int target_s_8 = 0;
	 int target_s_9 = 0;
	 int target_s_10 = 0;
	 int target_s_11 = 0;
	 int target_s_13 = 0;
	 int target_s_14 = 0;
	 int target_s_15 = 0;
	 int target_s_17 = 0;
	 int target_s_18 = 0;
	 int target_s_19 = 0;
	 int target_total_s = 0;	 
	
 	 for (int i = 0; i < dt.Rows.Count; i++)
     {   	  			
 	    if ( "1" == dt.Rows[i]["seq"].ToString() )
		{	
			target_s_8 	   = target_s_8  	+ Convert.ToInt32(dt.Rows[i]["s_8"].ToString()) ; 
			target_s_9 	   = target_s_9  	+ Convert.ToInt32(dt.Rows[i]["s_9"].ToString()) ; 
			target_s_10    = target_s_10  	+ Convert.ToInt32(dt.Rows[i]["s_10"].ToString()) ; 
			target_s_11	   = target_s_11  	+ Convert.ToInt32(dt.Rows[i]["s_11"].ToString()) ; 
			target_s_13    = target_s_13  	+ Convert.ToInt32(dt.Rows[i]["s_13"].ToString()) ; 
			target_s_14    = target_s_14  	+ Convert.ToInt32(dt.Rows[i]["s_14"].ToString()) ; 
			target_s_15    = target_s_15  	+ Convert.ToInt32(dt.Rows[i]["s_15"].ToString()) ; 
			target_s_17    = target_s_17  	+ Convert.ToInt32(dt.Rows[i]["s_17"].ToString()) ; 
			target_s_18    = target_s_18  	+ Convert.ToInt32(dt.Rows[i]["s_18"].ToString()) ; 
			target_s_19    = target_s_19  	+ Convert.ToInt32(dt.Rows[i]["s_19"].ToString()) ; 
			target_total_s = target_total_s	+ Convert.ToInt32(dt.Rows[i]["total_s"].ToString()) ;			 
 %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=7 height=25 class=xl41 style='height:18.75pt'><%=dt.Rows[i]["routing_group"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_8"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_9"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_10"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_11"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_13"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_14"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_15"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_17"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_18"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_19"].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_s"].ToString()%></td>
 </tr>
 <%
 		}		
		else if ( "2" == dt.Rows[i]["seq"].ToString() )	
		{	
			order_qty = order_qty + Convert.ToInt32(dt.Rows[i]["plan_qty"].ToString()) ;
			prod_qty  = prod_qty  + Convert.ToInt32(dt.Rows[i]["result_qty"].ToString()) ;
			bal_qty   = bal_qty   + Convert.ToInt32(dt.Rows[i]["bal_qty"].ToString()) ;
			
			result_s_8 	   = result_s_8  	+ Convert.ToInt32(dt.Rows[i]["s_8"].ToString()) ; 
			result_s_9 	   = result_s_9  	+ Convert.ToInt32(dt.Rows[i]["s_9"].ToString()) ; 
			result_s_10    = result_s_10  	+ Convert.ToInt32(dt.Rows[i]["s_10"].ToString()) ; 
			result_s_11	   = result_s_11  	+ Convert.ToInt32(dt.Rows[i]["s_11"].ToString()) ; 
			result_s_13    = result_s_13  	+ Convert.ToInt32(dt.Rows[i]["s_13"].ToString()) ; 
			result_s_14    = result_s_14  	+ Convert.ToInt32(dt.Rows[i]["s_14"].ToString()) ; 
			result_s_15    = result_s_15  	+ Convert.ToInt32(dt.Rows[i]["s_15"].ToString()) ; 
			result_s_17    = result_s_17  	+ Convert.ToInt32(dt.Rows[i]["s_17"].ToString()) ; 
			result_s_18    = result_s_18  	+ Convert.ToInt32(dt.Rows[i]["s_18"].ToString()) ; 
			result_s_19    = result_s_19  	+ Convert.ToInt32(dt.Rows[i]["s_19"].ToString()) ; 
			result_total_s = result_total_s	+ Convert.ToInt32(dt.Rows[i]["total_s"].ToString()) ; 
 %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl31 width=65 style='height:18.75pt;border-top:none;
  width:49pt'><%=dt.Rows[i]["partner_id"].ToString()%></td>
  <td class=xl32 width=70 style='border-top:none;border-left:none;width:53pt'><%=dt.Rows[i]["ref_po_no"].ToString()%></td>
  <td class=xl32 width=70 style='border-top:none;border-left:none;width:53pt'><%=dt.Rows[i]["item_code"].ToString()%></td>
  <td class=xl32 width=70 style='border-top:none;border-left:none;width:53pt'><%=dt.Rows[i]["spec"].ToString()%></td>
  <td class=xl36 width=60 style='border-top:none;border-left:none;width:45pt'
  x:num ><%=dt.Rows[i]["plan_qty"].ToString()%></td>
  <td class=xl36 width=60 style='border-top:none;border-left:none;width:45pt'
  x:num ><%=dt.Rows[i]["result_qty"].ToString()%></td>
  <td class=xl36 width=60 style='border-top:none;border-left:none;width:45pt'
  x:num ><%=dt.Rows[i]["bal_qty"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_8"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_9"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_10"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_11"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_13"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_14"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_15"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_17"].ToString()%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_18"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["s_19"].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_s"].ToString()%></td>
 </tr>
 <%
 		}
 	}
 %>
 <!-- <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=7 height=25 class=xl37 style='height:18.75pt'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num="4916">4,916</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num="4916">4,916</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num="1369">1,369</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>484</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none' x:num="124124">124,124</td>
 </tr> -->
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=4 height=25 class=xl47 style='height:18.75pt'>Total Target</td>
  <td rowspan=2  class=xl53 style='border-left:none' x:num><%=order_qty%></td>
  <td rowspan=2  class=xl53 style='border-left:none' x:num><%=prod_qty%></td>
  <td rowspan=2  class=xl53 style='border-left:none' x:num><%=bal_qty%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_8%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_9%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_10%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_11%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_13%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_14%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_15%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_17%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_18%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%=target_s_19%></td>
  <td class=xl50 style='border-top:none;border-left:none' x:num><%=target_total_s%></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=4 height=25 class=xl51 style='height:18.75pt'>Total Result</td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_8%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_9%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_10%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_11%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_13%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_14%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_15%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_17%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_18%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%=result_s_19%></td>
  <td class=xl54 style='border-top:none;border-left:none' x:num><%=result_total_s%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=18 class=xl35 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=65 style='width:49pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
