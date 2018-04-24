<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("ec111");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_project_pk = Request["p_project_pk"];
	string l_version	= Request["p_version"];
	string l_from		= Request["p_from"];
	string l_to			= Request["p_to"];

	string l_parameter = "";
	l_parameter = "'" + l_project_pk + "','" + l_version + "','" + l_from + "','" + l_to + "'";

	DataTable dt = ESysLib.TableReadOpenCursor("ec111.sp_sel_kpsh00010_dtl", l_parameter);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpsh00010_files/filelist.xml">
<link rel=Edit-Time-Data href="kpsh00010_files/editdata.mso">
<link rel=OLE-Object-Data href="kpsh00010_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>ISA_SERVER</o:LastAuthor>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-04-18T06:36:31Z</o:LastSaved>
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
.style56
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl66
	{mso-style-parent:style0;
	mso-protection:unlocked visible;}
.xl67
	{mso-style-parent:style56;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style56;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style56;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style56;
	color:black;
	font-size:9.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl72
	{mso-style-parent:style56;
	color:black;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitVertical>7</x:SplitVertical>
     <x:LeftColumnRightPane>7</x:LeftColumnRightPane>
     <x:ActivePane>1</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>True</x:ProtectContents>
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

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2398 style='border-collapse:
 collapse;table-layout:fixed;width:1792pt'>
 <col class=xl66 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl66 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl66 width=64 style='width:48pt'>
 <col class=xl66 width=75 span=4 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
	<%
		for (int col = 8; col <= 79; col+=3)
		{
			if(string.IsNullOrEmpty(dt.Rows[1][col].ToString()))
	%>				 
			<col class=xl66 width=75 style='mso-width-source:userset;mso-width-alt: 0;width:56pt'>
	<%
			else
	%>
			<col class=xl66 width=75 style='mso-width-source:userset;mso-width-alt: 2742;width:56pt'>
	<%
		}
	%>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=48 class=xl71 width=89 style='height:36.0pt;width:67pt'>Large
  Division</td>
  <td rowspan=2 class=xl72 width=145 style='width:109pt'>Detail Item</td>
  <td rowspan=2 class=xl72 width=64 style='width:48pt'>Unit</td>
  <td rowspan=2 class=xl72 width=75 style='width:56pt'>Weight Factory</td>
  <td rowspan=2 class=xl72 width=75 style='width:56pt'>Total Plan Q'ty</td>
  <td rowspan=2 class=xl72 width=75 style='width:56pt'>A. Rslt Q'ty</td>
  <td rowspan=2 class=xl72 width=75 style='width:56pt'>Distribution Backlog</td>
  <td colspan=12 class=xl73 width=900 style='border-right:.5pt solid black;
  border-left:none;width:672pt' x:num>2011</td>
  <td colspan=12 class=xl73 width=900 style='border-right:.5pt solid black;
  border-left:none;width:672pt' x:num>2011</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl76 style='height:18.0pt;border-top:none;border-left:
  none' x:num>1</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>12</td>
 </tr>
 <%

	for(int row = 1; row < dt.Rows.Count; row++)
	{
%>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl67 style='height:20.1pt;border-top:none'><%=dt.Rows[row][1]%></td>
  <td class=xl67 style='border-top:none;border-left:none'><%=dt.Rows[row][2]%></td>
  <td class=xl67 style='border-top:none;border-left:none'><%=dt.Rows[row][3]%></td>
  <td class=xl68 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row][4]%></td>
  <td class=xl69 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row][5]%></td>
  <td class=xl69 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row][6]%></td>
  <td class=xl69 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row][7]%></td>
	 <%
		for (int col = 8; col <= 79; col+=3)
		{
	%>
		<td class=xl70 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[row][col]%></td>
	<%
		}
	}
  %>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=89 style='width:67pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
