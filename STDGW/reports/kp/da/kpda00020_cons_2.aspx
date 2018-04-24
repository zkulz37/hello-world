<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("ec111");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_project_pk = Request["p_project_pk"];
	string l_budget_no  = Request["p_budget_no"];
	string l_lst_filter = Request["p_lst_filter"];
	string l_filter		= Request["p_filter"];

	string l_parameter = "";
    l_parameter = "'" + l_project_pk + "','" + l_budget_no + "','" + l_lst_filter + "','" + l_filter + "'";
   
    DataTable dt = ESysLib.TableReadOpenCursor("EC111.sp_rpt_kpda00020_cons_compare", l_parameter); 
   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="New%20Microsoft%20Excel%20Worksheet_files/filelist.xml">
<link rel=Edit-Time-Data
href="New%20Microsoft%20Excel%20Worksheet_files/editdata.mso">
<link rel=OLE-Object-Data
href="New%20Microsoft%20Excel%20Worksheet_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>ISA_SERVER</o:LastAuthor>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-06-21T07:10:04Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
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
.xl65
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000000000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	text-align:right;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022?????_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	text-align:right;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022?????_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	text-align:right;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022?????_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	text-align:right;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022?????_\)\;_\(\@_\)";	 
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	 text-align:right;
	mso-number-format:"_\(* \#\,\#\#0\.00000_\)\;_\(* \\\(\#\,\#\#0\.00000\\\)\;_\(* \0022-\0022?????_\)\;_\(\@_\)";	 
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>CONS</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2736 style='border-collapse:
 collapse;table-layout:fixed;width:2051pt'>
 <col width=64 style='width:48pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <col width=215 style='mso-width-source:userset;mso-width-alt:7862;width:161pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=96 span=5 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=96 span=5 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=96 span=5 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <tr height=34 style='height:25.5pt'>
  <td colspan=12 height=34 class=xl65 width=1258 style='height:25.5pt;
  width:943pt'>BCWS Details Registration - Construction</td>
  <td class=xl81 width=64 style='width:48pt'></td>
  <td class=xl81 width=64 style='width:48pt'></td>
  <td class=xl81 width=131 style='width:98pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
  <td class=xl81 width=64 style='width:48pt'></td>
  <td class=xl81 width=64 style='width:48pt'></td>
  <td class=xl81 width=131 style='width:98pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
  <td class=xl81 width=96 style='width:72pt'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td rowspan=2 height=69 class=xl66 width=64 style='border-bottom:.5pt solid black;
  height:51.75pt;border-top:none;width:48pt'>Level</td>
  <td rowspan=2 class=xl66 width=145 style='border-bottom:.5pt solid black;
  border-top:none;width:109pt'>Code</td>
  <td rowspan=2 class=xl66 width=215 style='border-bottom:.5pt solid black;
  border-top:none;width:161pt'>Name</td>
  <td rowspan=2 class=xl66 width=95 style='border-bottom:.5pt solid black;
  border-top:none;width:71pt'>Standard</td>
  <td colspan=8 class=xl77 style='border-right:.5pt solid black;border-left:
  none'>Before Changed</td>
  <td colspan=8 class=xl77 style='border-right:.5pt solid black;border-left:
  none'>After Changed</td>
  <td colspan=8 class=xl77 style='border-right:.5pt solid black;border-left:
  none'>Incr./ Decr.</td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl70 width=64 style='height:25.5pt;width:48pt'>Unit</td>
  <td class=xl70 width=64 style='width:48pt'>CCY</td>
  <td class=xl70 width=131 style='width:98pt'>Quantity</td>
  <td class=xl70 width=96 style='width:72pt'>Raw Mtrl. Cost U/P</td>
  <td class=xl70 width=96 style='width:72pt'>Labor Cost U/P</td>
  <td class=xl70 width=96 style='width:72pt'>Exp. U/P</td>
  <td class=xl70 width=96 style='width:72pt'>Unit Price</td>
  <td class=xl70 width=96 style='width:72pt'>Amount</td>
  <td class=xl70 width=64 style='width:48pt'>Unit</td>
  <td class=xl70 width=64 style='width:48pt'>CCY</td>
  <td class=xl70 width=131 style='width:98pt'>Quantity</td>
  <td class=xl70 width=96 style='width:72pt'>Raw Mtrl. Cost U/P</td>
  <td class=xl70 width=96 style='width:72pt'>Labor Cost U/P</td>
  <td class=xl70 width=96 style='width:72pt'>Exp. U/P</td>
  <td class=xl70 width=96 style='width:72pt'>Unit Price</td>
  <td class=xl70 width=96 style='width:72pt'>Amount</td>
  <td class=xl70 width=64 style='width:48pt'>Unit</td>
  <td class=xl70 width=64 style='width:48pt'>CCY</td>
  <td class=xl70 width=131 style='width:98pt'>Quantity</td>
  <td class=xl70 width=96 style='width:72pt'>Raw Mtrl. Cost U/P</td>
  <td class=xl70 width=96 style='width:72pt'>Labor Cost U/P</td>
  <td class=xl70 width=96 style='width:72pt'>Exp. U/P</td>
  <td class=xl70 width=96 style='width:72pt'>Unit Price</td>
  <td class=xl70 width=96 style='width:72pt'>Amount</td>
 </tr>
 <%
     for (int row = 0; row < dt.Rows.Count; row++)
     {
         if (dt.Rows[row]["COL32"].ToString() == "1")
         {     
 %>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl71 width=64 style='height:35.25pt;width:48pt'><%=dt.Rows[row][0].ToString()%></td>
  <td class=xl72 width=145 style='width:109pt'><%=dt.Rows[row][1].ToString()%></td>
  <td class=xl72 width=215 style='width:161pt'><%=dt.Rows[row][2].ToString()%></td>
  <td class=xl72 width=95 style='width:71pt'><%=dt.Rows[row][3].ToString()%></td>
  <td class=xl72 width=64 style='width:48pt'><%=dt.Rows[row][4].ToString()%></td>
  <td class=xl72 width=64 style='width:48pt'><%=dt.Rows[row][5].ToString()%></td>
  <td class=xl73><%=dt.Rows[row][6].ToString()%></td>
  <td class=xl80 align=right x:num><%=dt.Rows[row][7].ToString()%></td>
  <td class=xl80 align=right x:num><%=dt.Rows[row][8].ToString()%></td>
  <td class=xl80 align=right x:num><%=dt.Rows[row][9].ToString()%></td>
  <td class=xl73><%=dt.Rows[row][10].ToString()%></td>
  <td class=xl73 align=right x:num><%=dt.Rows[row][11].ToString()%>
  <td class=xl72 width=64 style='width:48pt'></td>
  <td class=xl72 width=64 style='width:48pt'></td>
  <td class=xl73><%=dt.Rows[row][12].ToString()%></td>
  <td class=xl80 align=right x:num><%=dt.Rows[row][13].ToString()%></td>
  <td class=xl80 align=right x:num><%=dt.Rows[row][14].ToString()%></td>
  <td class=xl80 align=right x:num><%=dt.Rows[row][15].ToString()%></td>
  <td class=xl73><%=dt.Rows[row][16].ToString()%></td>
  <td class=xl73 align=right x:num><%=dt.Rows[row][17].ToString()%></td>
  <td class=xl72 width=64 style='width:48pt'></td>
  <td class=xl72 width=64 style='width:48pt'></td>
  <td class=xl73><%=dt.Rows[row][18].ToString()%></td>
  <td class=xl85 align=right x:num><%=dt.Rows[row][19].ToString()%></td>
  <td class=xl85 align=right x:num><%=dt.Rows[row][20].ToString()%></td>
  <td class=xl85 align=right x:num><%=dt.Rows[row][21].ToString()%></td>
  <td class=xl86 ><%=dt.Rows[row][22].ToString()%></td>
  <td class=xl86 align=right x:num><%=dt.Rows[row][23].ToString()%></td>
 </tr>
 <%
        }
         else
         {        
 %>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl74 width=64 style='height:35.25pt;width:48pt'><%=dt.Rows[row][0].ToString()%></td>
  <td class=xl75 width=145 style='width:109pt'><%=dt.Rows[row][1].ToString()%></td>
  <td class=xl75 width=215 style='width:161pt'><%=dt.Rows[row][2].ToString()%></td>
  <td class=xl75 width=95 style='width:71pt'><%=dt.Rows[row][3].ToString()%></td>
  <td class=xl75 width=64 style='width:48pt'><%=dt.Rows[row][4].ToString()%></td>
  <td class=xl75 width=64 style='width:48pt'><%=dt.Rows[row][5].ToString()%></td>
  <td class=xl78 align=right x:num><%=dt.Rows[row][6].ToString()%></td>
  <td class=xl79 align=right x:num><%=dt.Rows[row][7].ToString()%></td>
  <td class=xl79 align=right x:num><%=dt.Rows[row][8].ToString()%></td>
  <td class=xl79 align=right x:num><%=dt.Rows[row][9].ToString()%></td>
  <td class=xl79 align=right x:num><%=dt.Rows[row][10].ToString()%></td>
  <td class=xl76 align=right x:num><%=dt.Rows[row][11].ToString()%></td>
  <td class=xl75 width=64 style='width:48pt'></td>
  <td class=xl75 width=64 style='width:48pt'></td>
  <td class=xl78 align=right x:num><%=dt.Rows[row][12].ToString()%></td>
  <td class=xl79 align=right x:num><%=dt.Rows[row][13].ToString()%></td>
  <td class=xl79 align=right x:num><%=dt.Rows[row][14].ToString()%></td>
  <td class=xl79 align=right x:num><%=dt.Rows[row][15].ToString()%></td>
  <td class=xl79 align=right x:num><%=dt.Rows[row][16].ToString()%></td>
  <td class=xl76 align=right x:num><%=dt.Rows[row][17].ToString()%></td>
  <td class=xl75 width=64 style='width:48pt'></td>
  <td class=xl75 width=64 style='width:48pt'></td>
  <td class=xl82 align=right x:num><%=dt.Rows[row][18].ToString()%></td>
  <td class=xl83 align=right x:num><%=dt.Rows[row][19].ToString()%></td>
  <td class=xl83 align=right x:num><%=dt.Rows[row][20].ToString()%></td>
  <td class=xl83 align=right x:num><%=dt.Rows[row][21].ToString()%></td>
  <td class=xl83 align=right x:num><%=dt.Rows[row][22].ToString()%></td>
  <td class=xl84 align=right x:num><%=dt.Rows[row][23].ToString()%></td>
 </tr>
 <% 
        }
     }        
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
