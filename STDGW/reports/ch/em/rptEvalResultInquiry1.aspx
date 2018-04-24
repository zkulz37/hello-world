<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser(Session("APP_DBUSER"));%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
%>
<%
    string l_empployee = Request["p_thr_eva_emp_pk"];
    string l_evamaster = Request["p_evamaster"];
    string l_parameter = "";
    l_parameter = "'" + l_evamaster + "','" + l_empployee + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_chem00160_1", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!");
        Response.End();
    } 
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="000120_files/filelist.xml">
<link rel=Edit-Time-Data href="000120_files/editdata.mso">
<link rel=OLE-Object-Data href="000120_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-07-09T09:37:25Z</o:LastPrinted>
  <o:Created>2009-07-09T09:34:23Z</o:Created>
  <o:LastSaved>2009-08-20T03:22:25Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.25in .75in 1.0in .75in;
	mso-header-margin:1.25in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
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
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
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
  <x:WindowHeight>8400</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1935</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2818 style='border-collapse:
 collapse;table-layout:fixed;width:2107pt'>
 <col class=xl24 width=171 style='mso-width-source:userset;mso-width-alt:6253;
 width:128pt'>
 <col class=xl24 width=162 style='mso-width-source:userset;mso-width-alt:5924;
 width:122pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=123 style='mso-width-source:userset;mso-width-alt:4498;
 width:92pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=55 span=8 style='mso-width-source:userset;mso-width-alt:0;width:41pt'> 
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:
 2011;width:41pt'>
 <col class=xl24 width=55 span=18 style='mso-width-source:userset;mso-width-alt:0;width:41pt'>
 <col class=xl24 width=55 span=3 style='mso-width-source:userset;mso-width-alt:0;width:41pt'>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 rowspan=2 height=32 class=xl36 width=333 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:24.0pt;width:250pt'>Organization</td>
  <td rowspan=3 class=xl40 width=44 style='border-bottom:.5pt solid black;
  width:33pt'>Emp ID</td>
  <td rowspan=3 class=xl40 width=123 style='border-bottom:.5pt solid black;
  width:92pt'>Emp Name</td>
  <td rowspan=3 class=xl40 width=96 style='border-bottom:.5pt solid black;
  width:72pt'>Joined Date</td>
  <td rowspan=3 class=xl40 width=88 style='border-bottom:.5pt solid black;
  width:66pt'>Worked Month</td>
  <td rowspan=3 class=xl40 width=71 style='border-bottom:.5pt solid black;
  width:53pt'>Emp Status</td>
  <td rowspan=3 class=xl40 width=90 style='border-bottom:.5pt solid black;
  width:68pt'>Job Title</td>
  <td rowspan=3 class=xl40 width=60 style='border-bottom:.5pt solid black;
  width:45pt'>Eval.Group</td>
  <td rowspan=3 class=xl40 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>First Reviewer</td>
  <td rowspan=3 class=xl40 width=102 style='border-bottom:.5pt solid black;
  width:77pt'>Second Reviewer</td>
  <td rowspan=3 class=xl40 width=72 style='border-bottom:.5pt solid black;
  width:54pt'>Status</td>
  <td colspan=30 class=xl44 width=1650 style='border-right:.5pt solid black;
  border-left:none;width:1230pt'>Score</td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td colspan=9 height=15 class=xl44 style='border-right:.5pt solid black;
  height:11.25pt;border-left:none'>Final</td>
  <td colspan=9 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>Second<span style='mso-spacerun:yes'>  </span>Reviewer</td>
  <td colspan=9 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>First<span style='mso-spacerun:yes'>  </span>Riviewer</td>
  <td colspan=3 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>Seft Evaluation</td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl25 style='height:11.25pt'>Dept</td>
  <td class=xl26>Team/section</td>
  <td class=xl27>A - Score</td>
  <td class=xl27>A -Rank</td>
  <td class=xl27 x:str="A - Grade ">A - Grade<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27>C - Score</td>
  <td class=xl27>C - Rank</td>
  <td class=xl27>C -Grade</td>
  <td class=xl27>T - Score</td>
  <td class=xl27>T - Rank</td>
  <td class=xl27>T - Grade</td>
  <td class=xl27>A - Score</td>
  <td class=xl27>A - Rank</td>
  <td class=xl27>A - Grade</td>
  <td class=xl27>C - Score</td>
  <td class=xl27>C - Rank</td>
  <td class=xl27>C - Grade</td>
  <td class=xl27>T - Score</td>
  <td class=xl27>T - Rank</td>
  <td class=xl27>T - Grade</td>
  <td class=xl27>A - Score</td>
  <td class=xl27>A - Rank</td>
  <td class=xl27>A - Grade</td>
  <td class=xl27>C - Score</td>
  <td class=xl27>C - Rank</td>
  <td class=xl27>C - Grade</td>
  <td class=xl27>T - Score</td>
  <td class=xl27>T - Rank</td>
  <td class=xl27>T - Grade</td>
  <td class=xl28><span style='mso-spacerun:yes'> </span>A - Score</td>
  <td class=xl28>C - Score</td>
  <td class=xl28 x:str="T - Score ">T - Score<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
  <%   
     for (int i = 0; i < dt.Rows.Count; i++)
     {
   %>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl29 style='height:11.25pt'><% = dt.Rows[i][0]%></td>
  <td class=xl30><% = dt.Rows[i][1]%></td>
  <td class=xl30 x:num><% = dt.Rows[i][2]%></td>
  <td class=xl30><% = dt.Rows[i][3]%></td>
  <td class=xl30 x:string><% = dt.Rows[i][4]%></td>
  <td class=xl30 x:num><% = dt.Rows[i][5]%></td>
  <td class=xl30><% = dt.Rows[i][6]%></td>
  <td class=xl30><% = dt.Rows[i][7]%></td>
  <td class=xl30><% = dt.Rows[i][8]%></td>
  <td class=xl30><% = dt.Rows[i][9]%></td>
  <td class=xl30><% = dt.Rows[i][10]%></span></td>
  <td class=xl30 x:str><% = dt.Rows[i][11]%><span style='display:none'><span
  style='mso-spacerun:yes'> </span></span></td>
  <td class=xl31><% = dt.Rows[i][12]%></td>
  <td class=xl31><% = dt.Rows[i][13]%></td>
  <td class=xl31 x:str><% = dt.Rows[i][14]%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl31><% = dt.Rows[i][15]%></td>
  <td class=xl31><% = dt.Rows[i][16]%></td>
  <td class=xl31><% = dt.Rows[i][17]%></td>
  <td class=xl31 x:num><% = dt.Rows[i][18]%></td>
  <td class=xl31><% = dt.Rows[i][19]%></td>
  <td class=xl31><% = dt.Rows[i][20]%></td>
  <td class=xl31 x:num><% = dt.Rows[i][21]%></td>
  <td class=xl31><% = dt.Rows[i][22]%></td>
  <td class=xl31><% = dt.Rows[i][23]%></td>
  <td class=xl31 x:num><% = dt.Rows[i][24]%></td>
  <td class=xl31><% = dt.Rows[i][25]%></td>
  <td class=xl31><% = dt.Rows[i][26]%></td>
  <td class=xl31 x:num><% = dt.Rows[i][27]%></td>
  <td class=xl31><% = dt.Rows[i][28]%></td>
  <td class=xl31><% = dt.Rows[i][29]%></td>
  <td class=xl31 x:num><% = dt.Rows[i][30]%></td>
  <td class=xl31><% = dt.Rows[i][31]%></td>
  <td class=xl31><% = dt.Rows[i][32]%></td>
  <td class=xl31 x:num><% = dt.Rows[i][33]%></td>
  <td class=xl31><% = dt.Rows[i][34]%></td>
  <td class=xl31><% = dt.Rows[i][35]%></td>
  <td class=xl31 x:num><% = dt.Rows[i][36]%></td>
  <td class=xl31><% = dt.Rows[i][37]%></td>
  <td class=xl32><% = dt.Rows[i][38]%></td>
  <td class=xl33 x:num><% = dt.Rows[i][39]%></td>
  <td class=xl34 x:num><% = dt.Rows[i][40]%></td>
  <td class=xl34 x:num ><% = dt.Rows[i][41]%> <span style='mso-spacerun:yes'> </span></td>
 </tr>
 <%
     } %>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=42 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=16 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=25 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=171 style='width:128pt'></td>
  <td width=162 style='width:122pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
