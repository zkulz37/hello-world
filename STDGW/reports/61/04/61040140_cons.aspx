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
	l_parameter = "'" + l_project_pk + "','" + l_budget_no + "','" + l_order_work + "','" + l_lst_filter + "','" + l_filter + "'";
	DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_kpbm00050_cons", l_parameter);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpbm00050_cons_files/filelist.xml">
<link rel=Edit-Time-Data href="kpbm00050_cons_files/editdata.mso">
<link rel=OLE-Object-Data href="kpbm00050_cons_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>ISA_SERVER</o:LastAuthor>
  <o:LastPrinted>2011-04-19T08:33:22Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-04-19T08:35:52Z</o:LastSaved>
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
	white-space:normal;}
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
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
.xl33
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
.xl34
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	background:silver;
	mso-pattern:auto none;
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
      <x:Scale>65</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>24</x:ActiveRow>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1566 style='border-collapse:
 collapse;table-layout:fixed;width:1174pt'>
 <col width=1000 span=2 style='mso-width-source:userset;mso-width-alt:4000;
 width:48pt'>
 <col width=1000 style='mso-width-source:userset;mso-width-alt:8000;
 width:48pt'>
 <col width=1000 style='mso-width-source:userset;mso-width-alt:4000;
 width:48pt'>
 <col width=1000 style='mso-width-source:userset;mso-width-alt:2500;
 width:48pt'>
 <col width=1000 style='mso-width-source:userset;mso-width-alt:2500;
 width:48pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:4352;width:89pt'>
 <col width=103 span=4 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col width=64 style='width:48pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=61 span=2 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col width=64 style='width:48pt'>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=21 height=43 class=xl32 width=1566 style='height:32.25pt;
  width:1174pt'>BCWS Details Registration - Construction</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=48 class=xl29 width=64 style='border-bottom:.5pt solid black;
  height:36.0pt;border-top:none;width:48pt'>Level</td>
  <td rowspan=2 height=48 class=xl29 width=64 style='border-bottom:.5pt solid black;
  height:36.0pt;border-top:none;width:48pt'>Code</td>
  <td rowspan=2 class=xl29 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Name</td>
  <td rowspan=2 class=xl29 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Standard</td>
  <td colspan=8 class=xl31 style='border-left:none'>Working(Changed)</td>
  <td colspan=2 class=xl31 style='border-left:none'>Order W. Div.</td>
  <td rowspan=2 class=xl29 width=84 style='border-bottom:.5pt solid black;
  border-top:none;width:63pt'>Excution (Yes/No)</td>
  <td rowspan=2 class=xl29 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Dir. Mgt Outsrc</td>
  <td rowspan=2 class=xl29 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Budget Code</td>
  <td rowspan=2 class=xl29 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>Standard Code</td>
  <td rowspan=2 class=xl29 width=61 style='border-bottom:.5pt solid black;
  border-top:none;width:46pt'>Calc. Basic</td>
  <td rowspan=2 class=xl29 width=61 style='border-bottom:.5pt solid black;
  border-top:none;width:46pt'>Order Status</td>
  <td rowspan=2 class=xl29 width=64 style='border-bottom:.5pt solid black;
  border-top:none;width:48pt'>A. Rslt Rcpt Y/N</td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl28 width=64 style='height:18.0pt;border-top:none;
  border-left:none;width:48pt'>Unit</td>
  <td class=xl28 width=64 style='border-top:none;border-left:none;width:48pt'>CCY</td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Quantity</td>
  <td class=xl28 width=119 style='border-top:none;border-left:none;width:89pt'>Raw
  Mtrl. Cost U/P</td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Labor
  Cost U/P</td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Exp.
  U/P</td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Unit
  Price</td>
  <td class=xl28 width=103 style='border-top:none;border-left:none;width:77pt'>Amount</td>
  <td class=xl28 width=64 style='border-top:none;border-left:none;width:48pt'>Code</td>
  <td class=xl28 width=86 style='border-top:none;border-left:none;width:65pt'>Name</td>
 </tr>
 <%
	for(int row = 1; row < dt.Rows.Count; row++)
	{
        if (dt.Rows[row]["col00"].ToString() == "")
        {
 %>
 <tr class=xl26 height=25 style='mso-height-source:userset;height:30pt' >
  <td height=50 class=xl25 style='height:30pt;border-top:none'><%=dt.Rows[row]["col00"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col01"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col02"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col03"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col04"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col05"].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col06"].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col07"].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col08"].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col09"].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col10"].ToString()%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col11"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col13"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col14"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col15"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col16"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col18"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col19"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col20"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col21"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dt.Rows[row]["col22"].ToString()%></td>
 </tr>
 <%
     }
     else
     {
    %>
    <tr class=xl26 height=25 style='mso-height-source:userset;height:30pt' >
  <td height=50 class=xl34 style='height:30pt;border-top:none'><%=dt.Rows[row]["col00"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col01"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col02"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col03"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col04"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col05"].ToString()%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col06"].ToString()%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col07"].ToString()%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col08"].ToString()%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col09"].ToString()%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col10"].ToString()%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row]["col11"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col13"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col14"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col15"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col16"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col18"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col19"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col20"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col21"].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[row]["col22"].ToString()%></td>
 </tr>

    <%
     }
	}
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=103 style='width:77pt'></td>
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
  <td width=61 style='width:46pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
