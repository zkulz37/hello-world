
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
    dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_jast00110",l_parameter);
    l_parameter = "'" + dat + "','','2'";
    dt1 = ESysLib.TableReadOpenCursor("CRM.sp_rpt_jast00110",l_parameter);
    int temp = dt.Rows.Count;
    if(dt1.Rows.Count > temp) temp = dt1.Rows.Count;
    dt_dt = ESysLib.TableReadOpen(pt_dt);
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_jast00110_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jast00110_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jast00110_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-12-25T03:52:47Z</o:LastPrinted>
  <o:Created>2010-11-18T10:04:35Z</o:Created>
  <o:LastSaved>2010-12-25T03:52:53Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.23in .16in .22in .25in;
	mso-header-margin:.21in;
	mso-footer-margin:.2in;
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
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
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
	border:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFCC00;
	mso-pattern:auto none;}
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
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
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:WindowHeight>9195</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1010 style='border-collapse:
 collapse;table-layout:fixed;width:759pt'>
 <col class=xl25 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=118 span=2 style='mso-width-source:userset;mso-width-alt:
 4315;width:89pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl25 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl24 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl24 width=115 span=2 style='mso-width-source:userset;mso-width-alt:
 4205;width:86pt'>
 <col class=xl24 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <tr height=15 style='height:11.25pt'>
  <td colspan=10 rowspan=2 height=30 class=xl26 width=1010 style='height:22.5pt;
  width:759pt'>TEETIME SHEET STATUS</td>
 </tr>
 <tr height=15 style='height:11.25pt'>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl25 style='height:11.25pt'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl27 width=233 style='width:175pt'>Date : <%=dt_dt.Rows[0][1].ToString()%></td>
  <td colspan=2 class=xl27 width=234 style='width:175pt'>Print Date :
  <%=dt_dt.Rows[0][0].ToString()%></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl25 style='height:11.25pt'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td colspan=5 height=15 class=xl28 width=508 style='height:11.25pt;
  width:383pt'>OI - OUT-IN (18)</td>
  <td colspan=5 class=xl29 width=502 style='border-left:none;width:376pt'>IO -
  IN-OUT (18)</td>
 </tr>
 <tr class=xl25 height=15 style='height:11.25pt'>
  <td height=15 class=xl30 style='height:11.25pt;border-top:none'>T.O.T</td>
  <td class=xl31 style='border-top:none;border-left:none'>Player A</td>
  <td class=xl31 style='border-top:none;border-left:none'>Player B</td>
  <td class=xl31 style='border-top:none;border-left:none'>Player C</td>
  <td class=xl31 style='border-top:none;border-left:none'>Player D</td>
  <td class=xl32 style='border-top:none;border-left:none'>T.O.T</td>
  <td class=xl31 style='border-top:none;border-left:none'>Player A</td>
  <td class=xl31 style='border-top:none;border-left:none'>Player B</td>
  <td class=xl31 style='border-top:none;border-left:none'>Player C</td>
  <td class=xl31 style='border-top:none;border-left:none'>Player D</td>
 </tr>
 <%for (int x = 0; x < temp; x++){%>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl33 style='height:11.25pt;border-top:none'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][1].ToString() %><%}%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][2].ToString() %><%}%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][5].ToString() %><%}%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][8].ToString() %><%}%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][11].ToString() %><%}%></td>
  <td class=xl35 style='border-top:none;border-left:none'><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][1].ToString() %><%}%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][2].ToString() %><%}%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][5].ToString() %><%}%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][8].ToString() %><%}%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][11].ToString() %><%}%></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=119 style='width:89pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
