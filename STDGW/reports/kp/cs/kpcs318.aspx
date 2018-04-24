<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser("ec111");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%><html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_From = Request["From"];
    string p_To = Request["To"];
    string p_Status = Request["Status"];

    string l_parameter = "'" + p_From + "',";
    l_parameter += "'" + p_To + "',";
    l_parameter += "'" + p_Status + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("ec111.sp_sel_kpcs318", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    p_From = p_From.Substring(6, 2) + "/" + p_From.Substring(4, 2) + "/" + p_From.Substring(0, 4);
    p_To = p_To.Substring(6, 2) + "/" + p_To.Substring(4, 2) + "/" + p_To.Substring(0, 4);
    if (p_Status == "0")
    {
        p_Status = "Approved";
    }
    else if (p_Status == "1")
    {
        p_Status = "Saved";
    }
    else if (p_Status == "2")
    {
       p_Status = "Confirmed";
    }
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="3.1.8_files/filelist.xml">
<link rel=Edit-Time-Data href="3.1.8_files/editdata.mso">
<link rel=OLE-Object-Data href="3.1.8_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-07-15T04:16:54Z</o:LastPrinted>
  <o:Created>2011-07-15T03:30:20Z</o:Created>
  <o:LastSaved>2011-07-15T04:17:49Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .5in .25in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:28.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
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
      <x:Scale>58</x:Scale>
      <x:HorizontalResolution>200</x:HorizontalResolution>
      <x:VerticalResolution>200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
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
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9780</x:WindowHeight>
  <x:WindowWidth>15315</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1685 style='border-collapse:
 collapse;table-layout:fixed;width:1264pt'>
 <col class=xl30 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=215 span=2 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <col width=131 span=2 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col width=71 span=2 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=215 style='mso-width-source:userset;mso-width-alt:7862;width:161pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 width=54 style='height:12.75pt;width:41pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=215 style='width:161pt'></td>
 </tr>
 <tr height=47 style='height:35.25pt'>
  <td colspan=14 height=47 class=xl35 style='height:35.25pt'>SUBCONTRACT
  REQUEST LIST</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'></td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl33 colspan=2 style='height:19.5pt;mso-ignore:colspan'>Trans  Date: <%=p_From%>~<%=p_To%></td>
  <td class=xl34></td>
  <td class=xl34>Status: <%=p_Status%></td>
  <td colspan=10 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=34 style='height:25.5pt'>
  <td height=34 class=xl25 width=54 style='height:25.5pt;border-top:none;width:41pt'>No</td>
  <td class=xl25 width=110 style='border-top:none;border-left:none;width:83pt'>Project Code</td>
  <td class=xl25 width=215 style='border-left:none;width:161pt'>Project Name</td>
  <td class=xl25 width=215 style='border-left:none;width:161pt'>Nature Work</td>
  <td class=xl25 width=110 style='border-left:none;width:83pt'>Req. No</td>
  <td class=xl25 width=71 style='border-left:none;width:53pt'>Req. Date</td>
  <td class=xl25 width=78 style='border-left:none;width:59pt'>Approval Date</td>
  <td class=xl25 width=145 style='border-left:none;width:109pt'>Approve By</td>
  <td class=xl25 width=131 style='border-left:none;width:98pt'>Main Contract (A)</td>
  <td class=xl25 width=131 style='border-left:none;width:98pt'>Budget (B)</td>
  <td class=xl25 width=71 style='border-left:none;width:53pt'>From Date</td>
  <td class=xl25 width=71 style='border-left:none;width:53pt'>To Date</td>
  <td class=xl25 width=68 style='border-left:none;width:51pt'>Status</td>
  <td class=xl25 width=215 style='border-left:none;width:161pt'>Remark</td>
 </tr>
 <%
    int i = 0;
    for (i = 0; i < dt.Rows.Count; i++)
    {
      %>
 <tr class=xl27 height=20 style='mso-height-source:auto;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt;border-top:none' x:num><%=dt.Rows[i][0]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl28 width=215 style='border-top:none;border-left:none;width:161pt'><%=dt.Rows[i][2]%></td>
  <td class=xl28 width=215 style='border-top:none;border-left:none;width:161pt'><%=dt.Rows[i][3]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][8]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][9]%></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][10]%></td>
  <td class=xl32 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][11]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=p_Status%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][13]%></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=54 style='width:41pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=215 style='width:161pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
