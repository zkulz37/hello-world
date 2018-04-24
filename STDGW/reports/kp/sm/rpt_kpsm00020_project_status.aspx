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
	string  p_company_pk = Request["p_company_pk"];
	string l_parameter="",l_budgetno="",l_company_name="",l_total="";
	 l_parameter = "'" + p_company_pk + "'";

     DataTable dt = ESysLib.TableReadOpenCursor("ec111.sp_sel_kpbp00030", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
     string SQL3 = " SELECT PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 and pk='" + p_company_pk+ "'";
    DataTable dtproject_name = ESysLib.TableReadOpen(SQL3);
    if (dtproject_name.Rows.Count > 0)
    {
        l_company_name = dtproject_name.Rows[0][0].ToString();
    }	
	 
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_kpsm00020_project_status_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_kpsm00020_project_status_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_kpsm00020_project_status_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-05-06T06:31:54Z</o:LastPrinted>
  <o:Created>2011-05-06T06:03:06Z</o:Created>
  <o:LastSaved>2011-08-12T07:44:59Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.21in .17in .2in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
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
.style21
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
	font-family:Tahoma;
	mso-generic-font-family:auto;
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
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style16;
	font-size:7.0pt;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#339966;
	mso-pattern:auto none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#339966;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>84</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
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
  <x:WindowHeight>9000</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>0</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1390 style='border-collapse:
 collapse;table-layout:fixed;width:1045pt'>
 <col width=29 style='mso-width-source:userset;mso-width-alt:1060;width:22pt'>
 <col width=64 style='width:48pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=141 style='mso-width-source:userset;mso-width-alt:5156;width:106pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=138 span=3 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=138 style='mso-width-source:userset;mso-width-alt:5046;width:104pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl34 width=365 style='height:15.75pt;
  width:274pt'>POSCO E&amp;C-VIETNAM CO.,LTD</td>
  <td width=103 style='width:77pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=138 style='width:104pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Address:</td>
  <td colspan=3 class=xl35></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=14 height=27 class=xl36 style='height:20.25pt'>Project Status
  Report</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl37 style='height:12.75pt'>Corporation:</td>
  <td colspan=4 class=xl38><%=l_company_name%></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td rowspan=2 height=48 class=xl39 style='border-bottom:.5pt solid black;
  height:36.0pt;border-top:none'>NO</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>CODE</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>NAME</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>MAJOR OWNER NAME</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>PM</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black;border-top:
  none'>PC</td>
  <td colspan=2 class=xl41 width=119 style='border-right:.5pt solid black;
  border-left:none;width:89pt'>CONTRACT PERIOD</td>
  <td rowspan=2 class=xl43 width=54 style='border-bottom:.5pt solid black;
  width:41pt'>CCY</td>
  <td rowspan=2 class=xl43 width=138 style='border-bottom:.5pt solid black;
  width:104pt'>CONT.AMT (THIS YEAR)</td>
  <td rowspan=2 class=xl39 style='border-bottom:.5pt solid black'>CONTRACT
  AMOUNT</td>
  <td rowspan=2 class=xl43 width=138 style='border-bottom:.5pt solid black;
  width:104pt'>COLLECTED AMOUNT</td>
  <td rowspan=2 class=xl43 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>WORKING RATE(%)</td>
  <td rowspan=2 class=xl43 width=138 style='border-bottom:.5pt solid black;
  width:104pt'>CONTRACT BALANCE</td>
 </tr>
 <tr class=xl25 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl26 width=60 style='height:23.25pt;width:45pt'>START
  DATE</td>
  <td class=xl27>EXP.DATE</td>
 </tr>
 <%
	for (int i = 1; i < dt.Rows.Count; i++)
     {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'><%=i%></td>
  <td class=xl29 width=64 style='width:48pt'><%=dt.Rows[i][1]%></td>
  <td class=xl29 width=131 style='width:98pt'><%=dt.Rows[i][2]%></td>
  <td class=xl29 width=141 style='width:106pt'><%=dt.Rows[i][3]%></td>
  <td class=xl30><%=dt.Rows[i][4]%></td>
  <td class=xl31><%=dt.Rows[i][5]%></td>
  <td class=xl32><%=dt.Rows[i][6]%></td>
  <td class=xl32><%=dt.Rows[i][7]%></td>
  <td class=xl32><%=dt.Rows[i][8]%></td>
  <td class=xl33 x:num><%=dt.Rows[i][9]%></td>
  <td class=xl33 x:num><%=dt.Rows[i][10]%></td>
  <td class=xl33 x:num><%=dt.Rows[i][11]%></td>
  <td class=xl33 x:num><%=dt.Rows[i][12]%></td>
  <td class=xl33 x:num><%=dt.Rows[i][13]%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=138 style='width:104pt'></td>
 </tr>
 <![endif]><%} %>
</table>

</body>

</html>
