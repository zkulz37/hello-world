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
	string para_dat = Request.QueryString["p_dt"];
    string pt_dt = " SELECT to_char(sysdate,'yyyy-MM-dd'), to_char(to_date('" + dat + "','yyyyMMdd'),'yyyy-MM-dd') from dual";
    DataTable dt, dt1, dt2, dt_dt;
    string l_parameter = "'" + dat + "','','1'";
    dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_jabk0090_2",l_parameter);
    l_parameter = "'" + dat + "','','2'";
    dt1 = ESysLib.TableReadOpenCursor("CRM.sp_rpt_jabk0090_2",l_parameter);
    int temp = dt.Rows.Count;
    if(dt1.Rows.Count > temp) temp = dt1.Rows.Count;
    dt_dt = ESysLib.TableReadOpen(pt_dt);
	string print_date_system="";
    string SQL2 = " select TO_CHAR(sysdate,'dd/mm/yyyy hh24:mi') dt_print  from dual ";
    DataTable dt_sys = ESysLib.TableReadOpen(SQL2);
    if (dt_sys.Rows.Count > 0)
    {
        print_date_system = dt_sys.Rows[0][0].ToString();
    }
	string strdt_para = para_dat.Substring(6, 2) + "/" + para_dat.Substring(4, 2)+ "/" +para_dat.Substring(0, 4);//2009.08
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_jabk0090_2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jabk0090_2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jabk0090_2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nhat</o:Author>
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-12-26T03:06:24Z</o:LastPrinted>
  <o:Created>2010-12-24T20:58:30Z</o:Created>
  <o:LastSaved>2010-12-26T03:06:33Z</o:LastSaved>
  <o:Company>housekeeping</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&Rpage &P";
	margin:.28in .08in .35in .08in;
	mso-header-margin:.2in;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	vertical-align:middle;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"Short Time";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8130</x:WindowHeight>
  <x:WindowWidth>18975</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$3:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1050 style='border-collapse:
 collapse;table-layout:fixed;width:789pt'>
 <col class=xl67 width=40 style='mso-width-source:userset;mso-width-alt:1280;
 width:30pt'>
 <col width=116 style='mso-width-source:userset;mso-width-alt:3712;width:87pt'>
 <col width=121 span=2 style='mso-width-source:userset;mso-width-alt:3872;
 width:91pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:3808;width:89pt'>
 <col class=xl67 width=37 style='mso-width-source:userset;mso-width-alt:1184;
 width:28pt'>
 <col width=121 span=2 style='mso-width-source:userset;mso-width-alt:3872;
 width:91pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4096;width:96pt'>
 <col width=126 style='mso-width-source:userset;mso-width-alt:4032;width:95pt'>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=10 height=48 class=xl74 width=1050 style='height:36.0pt;
  width:789pt'>CUSTOMER START LIST TABLE</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl78 style='height:15.75pt'>Date:</td>
  <td colspan=2 class=xl79><%=strdt_para%></td>
  <td colspan=5 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl80>Print Date:</td>
  <td class=xl80><%=print_date_system%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=5 height=19 class=xl70 style='height:14.25pt'>RIVER COURSE</td>
  <td colspan=5 class=xl75 style='border-right:.5pt solid black;border-left:
  none'>OCEAN COURSE</td>
 </tr>
 <tr class=xl66 height=19 style='height:14.25pt'>
  <td height=19 class=xl69 style='height:14.25pt;border-top:none' x:str="Time ">Time<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl69 style='border-top:none;border-left:none'>Player 1</td>
  <td class=xl69 style='border-top:none;border-left:none'>Player 2</td>
  <td class=xl69 style='border-top:none;border-left:none'>Player 3</td>
  <td class=xl70 style='border-top:none;border-left:none'>Player 4</td>
  <td class=xl68 style='border-top:none;border-left:none' x:str="Time ">Time<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl68 style='border-top:none;border-left:none'>Player 1</td>
  <td class=xl68 style='border-top:none;border-left:none'>Player 2</td>
  <td class=xl68 style='border-top:none;border-left:none'>Player 3</td>
  <td class=xl68 style='border-top:none;border-left:none'>Player 4</td>
 </tr>
 <%for (int x = 0; x < temp; x++){%>
 <tr class=xl65 height=59 style='mso-height-source:userset;height:44.25pt'>
  <td height=59 class=xl71 width=40 style='height:44.25pt;border-top:none;
  width:30pt' x:num><%if(dt.Rows.Count > x){%><%=dt.Rows[x][1].ToString() %><%}%></td>
  <td class=xl72 width=116 style='border-top:none;border-left:none;width:87pt'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][2].ToString() %><%}%><br><%if(dt.Rows.Count > x){%><%=dt.Rows[x][17].ToString() %><%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(dt.Rows.Count > x){%><%=dt.Rows[x][21].ToString() %><%}%></td>
  <td class=xl72 width=121 style='border-top:none;border-left:none;width:91pt'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][5].ToString() %><%}%><br><%if(dt.Rows.Count > x){%><%=dt.Rows[x][18].ToString() %><%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(dt.Rows.Count > x){%><%=dt.Rows[x][22].ToString() %><%}%></td>
  <td class=xl72 width=121 style='border-top:none;border-left:none;width:91pt'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][8].ToString() %><%}%><br><%if(dt.Rows.Count > x){%><%=dt.Rows[x][19].ToString() %><%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(dt.Rows.Count > x){%><%=dt.Rows[x][23].ToString() %><%}%></td>
  <td class=xl73 width=119 style='border-top:none;border-left:none;width:89pt'><%if(dt.Rows.Count > x){%><%=dt.Rows[x][11].ToString() %><%}%><br><%if(dt.Rows.Count > x){%><%=dt.Rows[x][20].ToString() %><%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(dt.Rows.Count > x){%><%=dt.Rows[x][24].ToString() %><%}%></td>
  <td class=xl71 width=37 style='border-top:none;border-left:none;width:28pt'
  x:num><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][1].ToString() %><%}%></td>
  <td class=xl72 width=121 style='border-top:none;border-left:none;width:91pt'><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][2].ToString() %><%}%><br><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][17].ToString() %><%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][21].ToString() %><%}%></td>
  <td class=xl72 width=121 style='border-top:none;border-left:none;width:91pt'><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][5].ToString() %><%}%><br><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][18].ToString() %><%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][22].ToString() %><%}%></td>
  <td class=xl72 width=128 style='border-top:none;border-left:none;width:96pt'><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][8].ToString() %><%}%><br><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][19].ToString() %><%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][23].ToString() %><%}%></td>
  <td class=xl72 width=126 style='border-top:none;border-left:none;width:95pt'><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][11].ToString() %><%}%><br><%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][20].ToString() %><%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if(dt1.Rows.Count > x){%><%=dt1.Rows[x][24].ToString() %><%}%></td>
 </tr>
 <%}%>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl67 style='height:14.25pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl67></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=126 style='width:95pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
