<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string dat = Request.QueryString["p_dt"];
    string pt_dt = " SELECT to_char(sysdate,'yyyy-MM-dd'), to_char(to_date('" + dat + "','yyyyMMdd'),'yyyy-MM-dd') from dual";
    DataTable dt, dt1, dt2, dt_dt;
    string l_parameter = "'" + dat + "','','1'";
    dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_jast00110",l_parameter);
    l_parameter = "'" + dat + "','','2'";
    dt1 = ESysLib.TableReadOpenCursor("CRM.sp_sel_jast00110",l_parameter);
    l_parameter = "'" + dat + "','','3'";
    dt2 = ESysLib.TableReadOpenCursor("CRM.sp_sel_jast00110",l_parameter);
    int temp = dt.Rows.Count;
    if(dt1.Rows.Count > temp) temp = dt1.Rows.Count;
    if(dt2.Rows.Count > temp) temp = dt2.Rows.Count;
    dt_dt = ESysLib.TableReadOpen(pt_dt);
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="jast00110_color_files/filelist.xml">
<link rel=Edit-Time-Data href="jast00110_color_files/editdata.mso">
<link rel=OLE-Object-Data href="jast00110_color_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2010-11-19T03:21:15Z</o:LastPrinted>
  <o:Created>2010-11-18T10:04:35Z</o:Created>
  <o:LastSaved>2010-11-19T03:21:35Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.68in .22in 1.0in .23in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:red;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:red;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:red;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:red;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	color:#333399;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl44
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:red;
	mso-pattern:auto none;}
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
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
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
  <x:WindowHeight>9285</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=960 style='border-collapse:
 collapse;table-layout:fixed;width:720pt'>
 <col class=xl47 width=64 style='width:48pt'>
 <col class=xl25 width=64 span=4 style='width:48pt'>
 <col class=xl47 width=64 style='width:48pt'>
 <col class=xl25 width=64 span=4 style='width:48pt'>
 <col class=xl47 width=64 style='width:48pt'>
 <col class=xl25 width=64 span=4 style='width:48pt'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=15 rowspan=2 height=34 class=xl24 width=960 style='height:25.5pt;
  width:720pt'>TEETIME SHEET STATUS</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt'>&nbsp;</td>
  <td class=xl43>Available</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl43>None</td>
  <td class=xl25></td>
  <td colspan=2 class=xl27 width=128 style='width:96pt'>Date : <%=dt_dt.Rows[0][1].ToString()%></td>
  <td class=xl25></td>
  <td colspan=3 class=xl27 width=192 style='width:144pt'>Print Date : <%=dt_dt.Rows[0][0].ToString()%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 style='height:12.75pt'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl47></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl28 width=320 style='border-right:.5pt solid black;
  height:12.75pt;width:240pt'>OI - OUT-IN (18)</td>
  <td colspan=5 class=xl31 width=320 style='border-right:.5pt solid black;
  border-left:none;width:240pt'>IO - IN-OUT (18)</td>
  <td colspan=5 class=xl34 width=320 style='border-right:.5pt solid black;
  border-left:none;width:240pt'>E9 - EXECUTIVE SHORT 9H</td>
 </tr>
 <tr class=xl26 height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt'>T.O.T</td>
  <td class=xl38>Player A</td>
  <td class=xl38>Player B</td>
  <td class=xl38>Player C</td>
  <td class=xl38>Player D</td>
  <td class=xl39>T.O.T</td>
  <td class=xl38>Player A</td>
  <td class=xl38>Player B</td>
  <td class=xl38>Player C</td>
  <td class=xl38>Player D</td>
  <td class=xl40>T.O.T</td>
  <td class=xl38>Player A</td>
  <td class=xl38>Player B</td>
  <td class=xl38>Player C</td>
  <td class=xl38>Player D</td>
 </tr>
 <%for (int x = 0; x < temp; x++){%>
 <tr height=15 style='height:11.25pt'>
    <td height=15 class=xl30 style='height:11.25pt'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][1].ToString() %><%}%></td>
    <% if(dt.Rows.Count > x) {if(dt.Rows[x][2].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <% if(dt.Rows.Count > x) {if(dt.Rows[x][5].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <% if(dt.Rows.Count > x) {if(dt.Rows[x][8].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <% if(dt.Rows.Count > x) {if(dt.Rows[x][11].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <td class=xl48><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][1].ToString()  %><%}%></td>
    <% if(dt1.Rows.Count > x) {if(dt1.Rows[x][2].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <% if(dt1.Rows.Count > x) {if(dt1.Rows[x][5].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <% if(dt1.Rows.Count > x) {if(dt1.Rows[x][8].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <% if(dt1.Rows.Count > x) {if(dt1.Rows[x][11].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <td class=xl49><%if(dt2.Rows.Count > x){%><%=dt2.Rows[x][1].ToString()  %><%}%></td>
    <% if(dt2.Rows.Count > x) {if(dt2.Rows[x][2].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <% if(dt2.Rows.Count > x) {if(dt2.Rows[x][5].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <% if(dt2.Rows.Count > x) {if(dt2.Rows[x][8].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td>
    <% if(dt2.Rows.Count > x) {if(dt2.Rows[x][11].ToString() != ""){%><td class=xl42 style='border-top:none;border-left:none'><%}else{%><td class=xl41<%}} else {%><td class=xl41><%} %></td
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
