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

	DataTable dt_header;
    dt_header = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00095");
	  
    string p_prod_date = Request.QueryString["prod_date"];
		
	string prod_date = p_prod_date.Substring(0, 4) + "." + p_prod_date.Substring(4, 2) + "." + p_prod_date.Substring(6, 2);	 
	
    string factory_pk = Request.QueryString["factory_pk"];
    string factory_name = Request.QueryString["factory_name"];	
	
	string work_process_pk = Request.QueryString["work_process_pk"];
	
	string para = "'" + factory_pk + "','" + p_prod_date + "','" + work_process_pk + "'";
		
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00095_1", para); 	
	     		
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00095_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00095_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00095_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2011-04-27T06:15:12Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-04-27T06:15:35Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in .17in .19in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font8
	{color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font9
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	color:#993300;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	color:#993300;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	color:#993300;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	color:#993300;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>73</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1400 style='border-collapse:
 collapse;table-layout:fixed;width:1058pt'>
 <col class=xl25 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl25 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl25 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl25 width=70 span=15 style='mso-width-source:userset;mso-width-alt:
 2560;width:53pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=16 rowspan=2 height=70 class=xl42 width=1120 style='border-right:
  .5pt solid black;border-bottom:2.0pt double black;height:52.5pt;width:846pt'><%=factory_name%><font class="font8"> LINE RESULT </font><font class="font9"><%=prod_date%></font></td>
  <td class=xl31 width=70 style='border-left:none;width:53pt'>N.
  TR&#431;&#7902;NG</td>
  <td class=xl31 width=70 style='border-left:none;width:53pt'>T&#7892;
  TR&#431;&#7902;NG</td>
  <td class=xl31 width=70 style='border-left:none;width:53pt'>K&#296;
  THU&#7852;T</td>
  <td class=xl31 width=70 style='border-left:none;width:53pt'>QLÝ
  X&#431;&#7902;NG</td>
 </tr>
 <tr height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 class=xl26 style='height:37.5pt;border-top:none;border-left:
  none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl28 width=40 style='height:26.25pt;border-top:none;
  width:30pt'>R/G</td>
  <td class=xl24 width=60 style='border-top:none;border-left:none;width:45pt'>BUYER</td>
  <td class=xl24 width=80 style='border-top:none;border-left:none;width:60pt'>P/O</td>
  <td class=xl24 width=90 style='border-top:none;border-left:none;width:68pt'>STYLE</td>
  <td class=xl24 width=80 style='border-top:none;border-left:none;width:60pt'>SPEC</td>
  <td class=xl24 width=70 style='border-top:none;border-left:none;width:53pt'>PLAN
  Q'TY</td>
  <td class=xl24 width=70 style='border-top:none;border-left:none;width:53pt'>CUT
  QTY</td>
  <td class=xl29 width=70 style='border-top:none;border-left:none;width:53pt'><%=dt_header.Rows[0]["col_01"]%></td>
  <td class=xl29 width=70 style='border-top:none;border-left:none;width:53pt'><%=dt_header.Rows[0]["col_02"]%></td>
  <td class=xl29 width=70 style='border-top:none;border-left:none;width:53pt'><%=dt_header.Rows[0]["col_03"]%></td>
  <td class=xl29 width=70 style='border-top:none;border-left:none;width:53pt'><%=dt_header.Rows[0]["col_04"]%></td>
  <td class=xl24 width=70 style='border-top:none;border-left:none;width:53pt'>PROD
  Q'TY</td>
  <td class=xl24 width=70 style='border-top:none;border-left:none;width:53pt'>BAL
  QTY</td>
  <td class=xl29 width=70 style='border-top:none;border-left:none;width:53pt'>TODAY
  TARGET</td>
  <td class=xl29 width=70 style='border-top:none;border-left:none;width:53pt'>TODAY
  RESULT</td>
  <td class=xl24 width=70 style='border-top:none;border-left:none;width:53pt'>SEW
  Q'TY</td>
  <td class=xl24 width=70 style='border-top:none;border-left:none;width:53pt'>QC
  Q'TY</td>
  <td class=xl24 width=70 style='border-top:none;border-left:none;width:53pt'>PACKING
  Q'TY</td>
  <td colspan=2 class=xl46 width=140 style='border-right:2.0pt double black;
  border-left:none;width:106pt'>Remark</td>
 </tr>
 <%
 	string s_routing_group     = "";
	 
	int s_plan_qty = 0;	
    int s_cut_qty  = 0;
			
	int	s_wp01_qty = 0;
	int	s_wp02_qty = 0;
	int	s_wp03_qty = 0;
	int	s_wp04_qty = 0;
		
	int	s_prod_qty = 0;
	int	s_bal_qty  = 0;
		
	int	s_sew_qty  = 0;
	int	s_qc_qty   = 0;
	int	s_pack_qty = 0;		 
	 
	if ( dt.Rows.Count > 0 )
	{
	 	s_routing_group = dt.Rows[0]["routing_group"].ToString();
	}
	 
 	 for (int i = 0; i < dt.Rows.Count; i++)
     {
	 
	 	if ( s_routing_group != "" && s_routing_group != dt.Rows[i]["routing_group"].ToString() )
		{
 %>
		  <tr height=25 style='mso-height-source:userset;height:18.75pt'>
		  <td colspan=5 height=25 class=xl39 style='border-right:.5pt solid black;
		  height:18.75pt'>TOTAL</td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_plan_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_cut_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_wp01_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_wp02_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_wp03_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_wp04_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_prod_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_bal_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_sew_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_qc_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_pack_qty%></td>
		  <td colspan=2 class=xl50 style='border-right:2.0pt double black;border-left:
		  none'>&nbsp;</td>
		 </tr> 
 <%
 			s_routing_group = dt.Rows[i]["routing_group"].ToString();
			
			s_plan_qty = 0;
			s_cut_qty  = 0;
			
			s_wp01_qty = 0;
			s_wp02_qty = 0;
			s_wp03_qty = 0;
			s_wp04_qty = 0;
			
			s_prod_qty = 0;
			s_bal_qty  = 0;
			
			s_sew_qty  = 0;
			s_qc_qty   = 0;
			s_pack_qty = 0;	
 		}
		
		s_plan_qty = s_plan_qty + Convert.ToInt32(dt.Rows[i]["plan_qty"].ToString()) ;
		s_cut_qty  = s_cut_qty + Convert.ToInt32(dt.Rows[i]["cut_qty"].ToString()) ;
		 
		s_wp01_qty = s_wp01_qty + Convert.ToInt32(dt.Rows[i]["wp01_qty"].ToString()) ;
		s_wp02_qty = s_wp02_qty + Convert.ToInt32(dt.Rows[i]["wp02_qty"].ToString()) ;
		s_wp03_qty = s_wp03_qty + Convert.ToInt32(dt.Rows[i]["wp03_qty"].ToString()) ;
		s_wp04_qty = s_wp04_qty + Convert.ToInt32(dt.Rows[i]["wp04_qty"].ToString()) ;
		
		s_prod_qty = s_prod_qty + Convert.ToInt32(dt.Rows[i]["prod_qty"].ToString()) ;
		s_bal_qty  = s_bal_qty + Convert.ToInt32(dt.Rows[i]["bal_qty"].ToString()) ;
		
		s_sew_qty  = s_sew_qty + Convert.ToInt32(dt.Rows[i]["sew_qty"].ToString()) ;
		s_qc_qty   = s_qc_qty + Convert.ToInt32(dt.Rows[i]["qc_qty"].ToString()) ;
		s_pack_qty = s_pack_qty + Convert.ToInt32(dt.Rows[i]["pack_qty"].ToString()) ;
 %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl32 width=40 style='height:18.75pt;border-top:none;
  width:30pt' ><%=dt.Rows[i]["routing_group"]%></td>
  <td class=xl33 width=60 style='border-top:none;border-left:none;width:45pt'><%=dt.Rows[i]["partner_id"]%></td>
  <td class=xl34 width=80 style='border-top:none;border-left:none;width:60pt'><%=dt.Rows[i]["ref_po_no"]%></td>
  <td class=xl34 width=90 style='border-top:none;border-left:none;width:68pt'><%=dt.Rows[i]["style_id"]%></td>
  <td class=xl33 width=80 style='border-top:none;border-left:none;width:60pt'><%=dt.Rows[i]["spec"]%></td>
  <td class=xl35 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["plan_qty"]%></td>
  <td class=xl36 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["cut_qty"]%></td>
  <td class=xl37 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["wp01_qty"]%></td>
  <td class=xl37 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["wp02_qty"]%></td>
  <td class=xl37 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["wp03_qty"]%></td>
  <td class=xl37 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["wp04_qty"]%></td>
  <td class=xl36 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["prod_qty"]%></td>
  <td class=xl36 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["bal_qty"]%></td>
  <td class=xl38 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["target_qty"]%></td>
  <td class=xl38 width=70 style='border-top:none;border-left:none;width:53pt' x:num></td>
  <td class=xl36 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["sew_qty"]%></td>
  <td class=xl36 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["qc_qty"]%></td>
  <td class=xl36 width=70 style='border-top:none;border-left:none;width:53pt' x:num><%=dt.Rows[i]["pack_qty"]%></td>
  <td colspan=2 class=xl48 width=140 style='border-right:2.0pt double black;border-left:none;width:106pt'></td>
 </tr>
 <%
 		}
 %>
 
		  <tr height=25 style='mso-height-source:userset;height:18.75pt'>
		  <td colspan=5 height=25 class=xl39 style='border-right:.5pt solid black;
		  height:18.75pt'>TOTAL</td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_plan_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_cut_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_wp01_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_wp02_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_wp03_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_wp04_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_prod_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_bal_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_sew_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_qc_qty%></td>
		  <td class=xl30 style='border-top:none;border-left:none' x:num><%=s_pack_qty%></td>
		  <td colspan=2 class=xl50 style='border-right:2.0pt double black;border-left:
		  none'>&nbsp;</td>
		 </tr> 
 
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=20 class=xl25 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
