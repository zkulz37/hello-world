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
<link rel=File-List href="jast00110_files/filelist.xml">
<link rel=Edit-Time-Data href="jast00110_files/editdata.mso">
<link rel=OLE-Object-Data href="jast00110_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2010-11-18T10:30:02Z</o:LastPrinted>
  <o:Created>2010-11-18T10:04:35Z</o:Created>
  <o:LastSaved>2010-11-19T02:19:13Z</o:LastSaved>
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
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl34
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>66</x:Scale>
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
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1439 style='border-collapse:
 collapse;table-layout:fixed;width:1076pt'>
 <col class=xl25 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=111 span=4 style='mso-width-source:userset;mso-width-alt:
 4059;width:83pt'>
 <col class=xl25 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl24 width=111 span=4 style='mso-width-source:userset;mso-width-alt:
 4059;width:83pt'>
 <col class=xl25 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl24 width=111 span=4 style='mso-width-source:userset;mso-width-alt:
 4059;width:83pt'>
 <tr height=15 style='height:11.25pt'>
  <td colspan=15 rowspan=2 height=30 class=xl34 width=1439 style='height:22.5pt;
  width:1076pt'>TEETIME SHEET STATUS</td>
 </tr>
 <tr height=15 style='height:11.25pt'>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl25 style='height:11.25pt'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl35 width=222 style='width:166pt'>Date : <%=dt_dt.Rows[0][1].ToString()%></td>
  <td colspan=2 class=xl35 width=222 style='width:166pt'>Print Date : <%=dt_dt.Rows[0][0].ToString()%></td>
  <td class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl25 style='height:11.25pt'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td colspan=5 height=15 class=xl36 width=481 style='border-right:.5pt solid black;
  height:11.25pt;width:360pt'>OI - OUT-IN (18)</td>
  <td colspan=5 class=xl39 width=479 style='border-right:.5pt solid black;
  border-left:none;width:358pt'>IO - IN-OUT (18)</td>
  <td colspan=5 class=xl42 width=479 style='border-right:.5pt solid black;
  border-left:none;width:358pt'>E9 - EXECUTIVE SHORT 9H</td>
 </tr>
 <tr class=xl25 height=15 style='height:11.25pt'>
  <td height=15 class=xl26 style='height:11.25pt'>T.O.T</td>
  <td class=xl27>Player A</td>
  <td class=xl27>Player B</td>
  <td class=xl27>Player C</td>
  <td class=xl27>Player D</td>
  <td class=xl28>T.O.T</td>
  <td class=xl27>Player A</td>
  <td class=xl27>Player B</td>
  <td class=xl27>Player C</td>
  <td class=xl27>Player D</td>
  <td class=xl29>T.O.T</td>
  <td class=xl27>Player A</td>
  <td class=xl27>Player B</td>
  <td class=xl27>Player C</td>
  <td class=xl27>Player D</td>
 <%for (int x = 0; x < temp; x++){%>
 <tr height=15 style='height:11.25pt'>
    <td height=15 class=xl30 style='height:11.25pt'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][1].ToString() %><%}%></td>
    <td class=xl31><%if(dt.Rows.Count > x) {%><%=dt.Rows[x][2].ToString()   %><%}%></td>
    <td class=xl31><%if(dt.Rows.Count > x) {%><%=dt.Rows[x][5].ToString()   %><%}%></td>
    <td class=xl31><%if(dt.Rows.Count > x) {%><%=dt.Rows[x][8].ToString()   %><%}%></td>
    <td class=xl31><%if(dt.Rows.Count > x) {%><%=dt.Rows[x][11].ToString()  %><%}%></td>
    <td class=xl32><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][1].ToString()  %><%}%></td>
    <td class=xl31><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][2].ToString()  %><%}%></td>
    <td class=xl31><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][5].ToString()  %><%}%></td>
    <td class=xl31><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][8].ToString()  %><%}%></td>
    <td class=xl31><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][11].ToString() %><%}%></td>
    <td class=xl33><%if(dt2.Rows.Count > x){%><%=dt2.Rows[x][1].ToString()  %><%}%></td>
    <td class=xl31><%if(dt2.Rows.Count > x){%><%=dt2.Rows[x][2].ToString()  %><%}%></td>
    <td class=xl31><%if(dt2.Rows.Count > x){%><%=dt2.Rows[x][5].ToString()  %><%}%></td>
    <td class=xl31><%if(dt2.Rows.Count > x){%><%=dt2.Rows[x][8].ToString()  %><%}%></td>
    <td class=xl31><%if(dt2.Rows.Count > x){%><%=dt2.Rows[x][11].ToString() %><%}%></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
