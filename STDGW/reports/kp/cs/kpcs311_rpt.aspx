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
	string p_tecps_projectsumm_pk  =Request["tecps_projectsumm_pk"];
	string l_parameter = "'" +p_tecps_projectsumm_pk +"'";

    DataTable dt = ESysLib.TableReadOpenCursor("ec111.sp_sel_kpcs311_rpt",l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptkpcs3111_files/filelist.xml">
<link rel=Edit-Time-Data href="rptkpcs3111_files/editdata.mso">
<link rel=OLE-Object-Data href="rptkpcs3111_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nghia</o:Author>
  <o:LastAuthor>Nghia</o:LastAuthor>
  <o:LastPrinted>2011-04-29T15:30:07Z</o:LastPrinted>
  <o:Created>2011-04-29T15:16:07Z</o:Created>
  <o:LastSaved>2011-04-29T15:34:54Z</o:LastSaved>
  <o:Version>11.6568</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .25in 1.0in .75in;
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
	color:red;
	font-size:26.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	color:black;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:6.0pt;
	text-align:right;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:6.0pt;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";}
.xl32
	{mso-style-parent:style0;
	font-size:6.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:6.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
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
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>17115</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=895 style='border-collapse:
 collapse;table-layout:fixed;width:674pt'>
 <col width=22 style='mso-width-source:userset;mso-width-alt:804;width:17pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=28 style='mso-width-source:userset;mso-width-alt:1024;width:21pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=64 style='width:48pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=17 rowspan=2 height=34 class=xl24 width=895 style='height:25.5pt;
  width:674pt'>Subcontract List</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=3 height=27 class=xl25 width=133 style='height:20.25pt;
  width:101pt'>Project</td>
  <td colspan=14 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=60 style='height:45.0pt'>
  <td height=60 class=xl26 width=22 style='height:45.0pt;border-top:none;
  width:17pt'><br>
    No</td>
  <td class=xl27 style='border-top:none;border-left:none' x:str="Code ">Code<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28 width=77 style='border-top:none;border-left:none;width:58pt'>Order
  W. <br>
    Div. Name</td>
  <td class=xl28 width=36 style='border-left:none;width:27pt'>Prog. <br>
    Status</td>
  <td class=xl28 width=32 style='border-left:none;width:24pt'>Cont <br>
    S/No</td>
  <td class=xl27 style='border-left:none'>SubCont. Name</td>
  <td class=xl27 style='border-left:none'>Curr.</td>
  <td class=xl27 style='border-left:none'>BCWS(Adj.)</td>
  <td class=xl28 width=64 style='border-left:none;width:48pt'>Subcontract<br>
    amount</td>
  <td class=xl28 width=70 style='border-left:none;width:53pt'>Chg. Subcontract
  <br>
    amount</td>
  <td class=xl28 width=34 style='border-left:none;width:26pt'>Settle <br>
    (Y/N)</td>
  <td class=xl28 width=37 style='border-left:none;width:28pt'>Reg.<br>
    <span style='mso-spacerun:yes'> </span>W.D</td>
  <td class=xl28 width=55 style='border-left:none;width:41pt'>Cont. Type</td>
  <td class=xl28 width=64 style='border-left:none;width:48pt'>Quotation <br>
    W/O<br>
    Q'ty (Yes/No)</td>
  <td class=xl28 width=50 style='border-left:none;width:38pt'>Start <br>
    Date</td>
  <td class=xl27 style='border-left:none'>Exp. Date</td>
  <td class=xl27 style='border-left:none'>Contract No</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none' x:num><%=i + 1 %></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][2]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][11]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][12]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][13]%></td>
  <td class=xl32 style='border-top:none;border-left:none' <%=dt.Rows[i][14]%></td>
  <td class=xl32 style='border-top:none;border-left:none' ><%=dt.Rows[i][15]%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][16]%></td>
 </tr>
  <%}%>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=17 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=102 style='height:76.5pt;mso-xlrowspan:6'>
  <td height=102 colspan=17 style='height:76.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=22 style='width:17pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=108 style='width:81pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
