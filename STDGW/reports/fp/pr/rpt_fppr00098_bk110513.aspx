<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string _from_date    = Request.QueryString["p_from_date"];
	string _to_date      = Request.QueryString["p_to_date"];
	string _factory_pk   = Request.QueryString["p_factory_pk"];	
	string _factory_name = Request.QueryString["p_factory_name"];	
	string _para = " '" + _factory_pk + "','" + _from_date + "','" + _to_date + "'";
	
	DataTable dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00098", _para);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00098_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00098_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00098_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2011-05-03T04:16:07Z</o:LastPrinted>
  <o:Created>2011-04-21T02:34:57Z</o:Created>
  <o:LastSaved>2011-05-03T04:18:59Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.19in .17in .16in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
.font7
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
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double black;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
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
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
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
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$2</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1063 style='border-collapse:
 collapse;table-layout:fixed;width:803pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=65 span=3 style='mso-width-source:userset;mso-width-alt:
 2377;width:49pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=50 span=4 style='mso-width-source:userset;mso-width-alt:
 1828;width:38pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=50 span=4 style='mso-width-source:userset;mso-width-alt:
 1828;width:38pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=36 style='height:27.0pt'>
  <td colspan=18 height=36 class=xl26 width=1063 style='height:27.0pt;
  width:803pt'><font class="font7"><%=_factory_name%> </font>R/G PRODUCTION SCHEDULE <font class="font7"><%= System.DateTime.ParseExact(_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yy")%> - <%= System.DateTime.ParseExact(_to_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yy")%></font> ( <%= System.Now.ToString("dd/MM/yy HH:mm")%> )</td>
 </tr>
 <tr class=xl35 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl32 width=40 style='height:26.25pt;border-top:none;
  width:30pt'>R/G</td>
  <td class=xl33 width=65 style='border-top:none;width:49pt'>BUYER</td>
  <td class=xl33 width=65 style='border-top:none;width:49pt'>P/O</td>
  <td class=xl33 width=65 style='border-top:none;width:49pt'>STYLE</td>
  <td class=xl33 width=70 style='border-top:none;width:53pt'>SKETCH</td>
  <td class=xl33 width=64 style='border-top:none;width:48pt'>SPEC</td>
  <td class=xl33 width=50 style='border-top:none;width:38pt'>QTY</td>
  <td class=xl33 width=50 style='border-top:none;width:38pt'>PROD QTY</td>
  <td class=xl33 width=50 style='border-top:none;width:38pt'>BAL QTY</td>
  <td class=xl33 width=50 style='border-top:none;width:38pt'>ETD</td>
  <td class=xl33 width=40 style='border-top:none;width:30pt'>CS</td>
  <td class=xl33 width=50 style='border-top:none;width:38pt'>DAILY TAGET</td>
  <td class=xl33 width=50 style='border-top:none;width:38pt'>FR DATE</td>
  <td class=xl33 width=50 style='border-top:none;width:38pt'>TO DATE</td>
  <td class=xl33 width=50 style='border-top:none;width:38pt'>Days Num</td>
  <td class=xl33 width=100 style='border-top:none;width:75pt'>Group</td>
  <td class=xl33 width=90 style='border-top:none;width:68pt'>Material</td>
  <td class=xl34 width=64 style='border-top:none;width:48pt'>Remark</td>
 </tr>
 
<%
 	 int rg_total = 0;	
	 int prod_total = 0;	
	 int bal_total = 0;
	 
	 string routing_group = "";   
	
 	 for (int i = 0; i < dt.Rows.Count; i++)
     {   	  			
 	    if ( routing_group != "" && routing_group != dt.Rows[i]["routing_group"].ToString() )
		{	
			 	 
 %>
 
  <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl27 width=369 style='border-right:.5pt solid black;
  height:15.0pt;width:278pt'>Total</td>
  <td class=xl25 width=50 style='width:38pt' x:num><%=rg_total%></td>
  <td class=xl25 width=50 style='width:38pt' x:num><%=prod_total%></td>
  <td class=xl25 width=50 style='width:38pt' x:num><%=bal_total%></td>
  <td colspan=9 class=xl30 width=544 style='border-right:2.0pt double black;
  border-left:none;width:411pt'>&nbsp;</td>
 </tr>
  <%
 			rg_total = 0 ;
			prod_total = 0 ;
			bal_total = 0 ;
 		}
		
		rg_total = rg_total + Convert.ToInt32(dt.Rows[i]["plan_qty"].ToString());
		prod_total = prod_total + Convert.ToInt32(dt.Rows[i]["prod_qty"].ToString());
		bal_total = bal_total + Convert.ToInt32(dt.Rows[i]["bal_qty"].ToString());
			
		routing_group = dt.Rows[i]["routing_group"].ToString();		
 %>
 
 <tr height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 class=xl36 width=40 style='height:37.5pt;width:30pt'><%=dt.Rows[i]["routing_group"].ToString()%></td>
  <td class=xl37 width=65 style='width:49pt'><%=dt.Rows[i]["partner_id"].ToString()%></td>
  <td class=xl38 width=65 style='width:49pt'><%=dt.Rows[i]["ref_po_no"].ToString()%></td>
  <td class=xl38 width=65 style='width:49pt'><%=dt.Rows[i]["item_code"].ToString()%></td>
  <td height=50 class=xl37 width=70 style='height:37.5pt;width:53pt'><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:50.25pt;height:35.25pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["TCO_STITEMPHOTO_PK"]%>&table_name=TCO_STITEMPHOTO" o:title="my-linh-hat-sai"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=2 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=67 height=47 src="rpt_fppr00098_files/image002.jpg" v:shapes="_x0000_s1025"></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:52.5pt;height:37.5pt'></span><![endif]--></td>
  <td class=xl37 width=64 style='width:48pt'><%=dt.Rows[i]["spec"].ToString()%></td>
  <td class=xl43 width=50 style='width:38pt' x:num><%=dt.Rows[i]["plan_qty"].ToString()%></td>
  <td class=xl43 width=50 style='width:38pt' x:num><%=dt.Rows[i]["prod_qty"].ToString()%></td>
  <td class=xl43 width=50 style='width:38pt' x:num><%=dt.Rows[i]["bal_qty"].ToString()%></td>
  <td class=xl39 width=50 style='width:38pt' ><%=dt.Rows[i]["etd"].ToString()%></td>
  <td class=xl37 width=40 style='width:30pt'><%=dt.Rows[i]["cs"].ToString()%></td>
  <td class=xl43 width=50 style='width:38pt' x:num><%=dt.Rows[i]["daily_target"].ToString()%></td>
  <td class=xl42 width=50 style='width:38pt' ><%=dt.Rows[i]["from_dt"].ToString()%></td>
  <td class=xl42 width=50 style='width:38pt' ><%=dt.Rows[i]["to_dt"].ToString()%></td>
  <td class=xl44 width=50 style='width:38pt' x:num><%=dt.Rows[i]["days_num"].ToString()%></td>
  <td class=xl40 width=100 style='width:75pt'><%=dt.Rows[i]["t_group"].ToString()%></td>
  <td class=xl40 width=90 style='width:68pt'><%=dt.Rows[i]["t_material"].ToString()%></td>
  <td class=xl41 width=64 style='width:48pt'>&nbsp;</td>
 </tr>
 
  <%
 	}	
 %>
 
 
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl27 width=369 style='border-right:.5pt solid black;
  height:15.0pt;width:278pt'>Total</td>
  <td class=xl25 width=50 style='width:38pt' x:num><%=rg_total%></td>
  <td class=xl25 width=50 style='width:38pt' x:num><%=prod_total%></td>
  <td class=xl25 width=50 style='width:38pt' x:num><%=bal_total%></td>
  <td colspan=9 class=xl30 width=544 style='border-right:2.0pt double black;
  border-left:none;width:411pt'>&nbsp;</td>
 </tr>
 
 
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=18 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
