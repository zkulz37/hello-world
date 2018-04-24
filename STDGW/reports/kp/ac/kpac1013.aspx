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
    string p_TCO_COMPANY_PK = Request["TCO_COMPANY_PK"];
    string p_TECPS_PROJECTSUMM_PK = Request["TECPS_PROJECTSUMM_PK"];
    string p_TECPS_UNDERTAKELEVELCODE_PK = Request["TECPS_UNDERTAKELEVELCODE_PK"];
    string p_REPORT_TYPE = Request["REPORT_TYPE"];

    string l_parameter = "'" + p_TCO_COMPANY_PK + "', ";
    l_parameter += "'" + p_TECPS_PROJECTSUMM_PK + "', ";
    l_parameter += "'" + p_TECPS_UNDERTAKELEVELCODE_PK + "', ";
    l_parameter += "'" + p_REPORT_TYPE + "' ";

    DataTable dt = ESysLib.TableReadOpenCursor("SP_SEL_kpac1013_report", l_parameter);
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="1.0.13_files/filelist.xml">
<link rel=Edit-Time-Data href="1.0.13_files/editdata.mso">
<link rel=OLE-Object-Data href="1.0.13_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-08-04T10:05:09Z</o:LastPrinted>
  <o:Created>2011-08-04T07:39:22Z</o:Created>
  <o:LastSaved>2011-08-04T10:05:45Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
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
	 mso-pattern:auto none;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;
	mso-pattern:auto none;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	mso-pattern:auto none;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	mso-pattern:auto none;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	}
.xl33
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
	
	.xl42
{mso-style-parent:style0;
font-size:12.0pt;
font-family:"Times New Roman", serif;
mso-font-charset:0;
mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
vertical-align:middle;
border-top:.5pt hairline windowtext;
border-right:.5pt solid windowtext;
border-bottom:.5pt hairline windowtext;
border-left:none;
background:#FFFF99;
mso-pattern:auto none;
white-space:normal;
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
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>200</x:HorizontalResolution>
      <x:VerticalResolution>200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1266 style='border-collapse:
 collapse;table-layout:fixed;width:951pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=215 span=3 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=70 style='height:12.75pt;width:53pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=50 style='height:37.5pt'>
  <td colspan=11 height=50 class=xl32 style='border-right:none;  height:37.5pt'>Report Form Design (Compare)</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl27 style='height:19.5pt'>Type</td>
  <td class=xl27 style='border-left:none'>Print Seq</td>
  <td class=xl27 style='border-left:none'>Level Code</td>
  <td class=xl27 style='border-left:none'>Name</td>
  <td class=xl27 style='border-left:none'>Local Name</td>
  <td class=xl27 style='border-left:none'>Korea Name</td>
  <td class=xl27 style='border-left:none'>Color</td>
  <td class=xl27 style='border-left:none'>Font Style</td>
  <td class=xl27 style='border-left:none'>Formula</td>
  <td class=xl27 style='border-left:none'>Print Y/N</td>
  <td class=xl27 style='border-left:none'>Level</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
     int i = 0;
     string _Color = "";
     string _Font = "";
     int p_Print_YN = 0;
     for (i = 0; i < dt.Rows.Count; i++)
     {
         p_Print_YN = int.Parse(dt.Rows[i][9].ToString());
         _Color = dt.Rows[i][11].ToString();
         if (dt.Rows[i][12].ToString() == "B")
         {
             _Font = "font-weight:700";
         }
         else if (dt.Rows[i][12].ToString() == "I")
         {
             _Font = "font-style:italic";
         }
         else
         {
             _Font = "";
         }
      %>
 <tr class=xl24 height=24 style='mso-height-source:auto;height:18.0pt'>
  <td height=24 class=xl30 style='height:18.0pt;border-top:none;background:#<%=_Color%>;<%=_Font%>'><%=dt.Rows[i][0]%></td>
  <td class=xl30 style='border-top:none;border-left:none;background:#<%=_Color%>;<%=_Font%>' x:num><%=dt.Rows[i][1]%></td>
  <td class=xl29 style='border-top:none;border-left:none;background:#<%=_Color%>;<%=_Font%>'><%=dt.Rows[i][2]%></td>
  <td class=xl28 width=215 style='border-top:none;border-left:none;width:161pt;background:#<%=_Color%>;<%=_Font%>'><%=dt.Rows[i][3]%></td>
  <td class=xl28 width=215 style='border-top:none;border-left:none;width:161pt;background:#<%=_Color%>;<%=_Font%>'><%=dt.Rows[i][4]%></td>
  <td class=xl28 width=215 style='border-top:none;border-left:none;width:161pt;background:#<%=_Color%>;<%=_Font%>'><%=dt.Rows[i][5]%></td>
  <td class=xl30 style='border-top:none;border-left:none;background:#<%=_Color%>;<%=_Font%>'><%=dt.Rows[i][6]%></td>
  <td class=xl30 style='border-top:none;border-left:none;background:#<%=_Color%>;<%=_Font%>'><%=dt.Rows[i][7]%></td>
  <td class=xl30 style='border-top:none;border-left:none;background:#<%=_Color%>;<%=_Font%>'><%=dt.Rows[i][8]%></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=_Color%>'><%if (p_Print_YN == -1)
                                                            { %>þ<%}
                                                            else
                                                            { %>¨<%} %></td>
  <td class=xl29 style='border-top:none;border-left:none;background:#<%=_Color%>;<%=_Font%>;text-align:center'><%=dt.Rows[i][10]%></td>
 </tr>
 <%} %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=70 style='width:53pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=62 style='width:47pt;'></td>
  <td width=50 style='width:38pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
