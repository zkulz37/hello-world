<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("crm");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_dt_frm="",l_parameter="";
	l_dt_frm =Request["p_dt_frm"];
	l_parameter = "'" + l_dt_frm + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_room_daily_report", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string l_print_date="";
    string SQL3 = "select to_char(sysdate,'dd-mm-yyyy hh24:mi') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="htfo00050_files/filelist.xml">
<link rel=Edit-Time-Data href="htfo00050_files/editdata.mso">
<link rel=OLE-Object-Data href="htfo00050_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>dieu</o:Author>
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-12-15T08:36:56Z</o:LastPrinted>
  <o:Created>2010-12-15T07:52:16Z</o:Created>
  <o:LastSaved>2010-12-15T08:37:06Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.39in .2in .2in .2in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;}
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	text-align:right;}
.xl28
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	text-align:right;
	mso-font-charset:0;}
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=632 style='border-collapse:
 collapse;table-layout:fixed;width:475pt'>
 <col width=267 style='mso-width-source:userset;mso-width-alt:8264;width:200pt'>
 <col width=73 span=3 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col width=73  style='mso-width-source:userset;mso-width-alt:3300;
 width:55pt'>
  <col width=73  style='mso-width-source:userset;mso-width-alt:3300;
 width:55pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=267 style='height:12.75pt;width:200pt'>Song
  Gia Resort Complex</td>
  <td width=73 style='width:55pt'></td>
  <td colspan=2 class=xl32 width=146 style='width:110pt'>Print Date :</td>
  <td colspan=2 class=xl27 width=146 style='width:110pt'><%=l_print_date%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>Daily Revenue Report</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=1 class=xl33 style='mso-ignore:colspan'><b>Date Closing:</b></td>
  <td colspan=1 class=xl33 style='mso-ignore:colspan'><%=dt.Rows[0][6]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>Hotel &amp; Serviced villas</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl30 style='border-left:none'>MTD</td>
  <td colspan=2 class=xl30 style='border-left:none'>YTD</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>Today</td>
  <td class=xl31 style='border-top:none;border-left:none'>Actual</td>
  <td class=xl31 style='border-top:none;border-left:none'>Budget</td>
  <td class=xl31 style='border-top:none;border-left:none'>Actual</td>
  <td class=xl31 style='border-top:none;border-left:none'>Budget</td>
 </tr>
<%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
		  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1]%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2]%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl26 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
 </tr>
<%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=267 style='width:200pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
