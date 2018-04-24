<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
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
	string l_work		= Request["p_work"];
	string l_order_work = Request["p_order_work"];
	string l_lst_filter = Request["p_lst_filter"];
	string l_filter		= Request["p_filter"];

	string l_parameter = "";
	l_parameter = "'" + l_project_pk + "','" + l_budget_no + "','" + l_work + "','" + l_order_work + "','" + l_lst_filter + "','" + l_filter + "'";
	DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_kpbm00050_eq", l_parameter);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpbm00050_eq_files/filelist.xml">
<link rel=Edit-Time-Data href="kpbm00050_eq_files/editdata.mso">
<link rel=OLE-Object-Data href="kpbm00050_eq_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>ISA_SERVER</o:LastAuthor>
  <o:LastPrinted>2011-04-19T07:03:18Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-04-19T07:04:01Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .2in .2in .2in;
	mso-header-margin:.2in;
	mso-footer-margin:.2in;
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
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
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
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1345 style='border-collapse:
 collapse;table-layout:fixed;width:1009pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=103 span=3 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col width=64 style='width:48pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=64 style='width:48pt'>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=18 height=43 class=xl32 width=1345 style='height:32.25pt;
  width:1009pt'>BCWS Details Registration - Equipment</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=48 class=xl28 width=64 style='border-bottom:.5pt solid black;
  height:36.0pt;border-top:none;width:48pt'>Level</td>
  <td rowspan=2 class=xl28 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Item No</td>
  <td rowspan=2 class=xl28 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Name</td>
  <td rowspan=2 class=xl28 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Standard</td>
  <td rowspan=2 class=xl28 width=101 style='border-bottom:.5pt solid black;
  border-top:none;width:76pt'>Weight</td>
  <td colspan=5 class=xl29 style='border-left:none'>Working(Changed)</td>
  <td colspan=2 class=xl29 style='border-left:none'>Order W. Div.</td>
  <td rowspan=2 class=xl28 width=84 style='border-bottom:.5pt solid black;
  border-top:none;width:63pt'>Excution (Yes/No)</td>
  <td rowspan=2 class=xl28 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Budget Code</td>
  <td rowspan=2 class=xl28 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Standard PBS</td>
  <td rowspan=2 class=xl28 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Delivery Term</td>
  <td rowspan=2 class=xl28 width=61 style='border-bottom:.5pt solid black;
  border-top:none;width:46pt'>Order Status</td>
  <td rowspan=2 class=xl28 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>A. Rslt Rcpt(Y/N)</td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl31 width=64 style='height:18.0pt;border-top:none;
  border-left:none;width:48pt'>Unit</td>
  <td class=xl31 width=64 style='border-top:none;border-left:none;width:48pt'>CCY</td>
  <td class=xl31 width=103 style='border-top:none;border-left:none;width:77pt'>Quantity</td>
  <td class=xl31 width=103 style='border-top:none;border-left:none;width:77pt'>Unit
  Cost</td>
  <td class=xl31 width=103 style='border-top:none;border-left:none;width:77pt'>Amount</td>
  <td class=xl31 width=64 style='border-top:none;border-left:none;width:48pt'>Code</td>
  <td class=xl31 width=86 style='border-top:none;border-left:none;width:65pt'>Name</td>
 </tr>
 <%
	for(int row = 1; row < dt.Rows.Count; row++)
	{
 %>
 <tr class=xl26 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl25 style='height:18.75pt;border-top:none'><%=dt.Rows[row][2].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][3].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][4].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][5].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[row][6].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][7].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][8].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[row][9].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row][10].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row][11].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][13].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][14].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][15].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][17].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][18].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][19].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][20].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row][21].ToString()%></td>
 </tr>
 <%
	}
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
