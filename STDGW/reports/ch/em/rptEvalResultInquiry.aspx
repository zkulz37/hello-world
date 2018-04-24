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
    string l_yyyy_seq="";
    string l_Eval_period="" ;
    string l_schedule ="";
    string l_photo_pk="" ;
    string l_dept_name ="";
    string l_code_name ="";
    string l_group_name ="";
    string l_emp_id_fullName ="";
    string l_date_emp_info ="";
    string l_emp_id ="";
    string l_fullName ="";
    string l_parameter = Request["p_thr_eva_emp_pk"];

    string sp = "sp_sel_chem00120_3";
    DataTable dt = ESysLib.TableReadOpenCursor(sp, l_parameter);
    if (dt.Rows.Count > 0)
    {
        l_yyyy_seq = dt.Rows[0][7].ToString();
        l_Eval_period= dt.Rows[0][8].ToString();
        l_schedule = dt.Rows[0][9].ToString();
        l_photo_pk = dt.Rows[0][4].ToString();
        l_dept_name = dt.Rows[0][2].ToString();
        l_code_name = dt.Rows[0][5].ToString();
        l_group_name = dt.Rows[0][3].ToString();
        l_emp_id = dt.Rows[0][0].ToString();
        l_fullName = dt.Rows[0][1].ToString();
        l_date_emp_info = dt.Rows[0][6].ToString();
    } 
    string l_parameter1 = Request["p_thr_eva_emp_pk"];
    string sp1 = "sp_sel_chem00120_1";
    DataTable dt1 = ESysLib.TableReadOpenCursor(sp1, l_parameter1);
    if (dt1.Rows.Count == 0)
    { 
         Response.Write("There is no data");
         Response.End();
    } 
    string l_parameter2 = Request["p_thr_eva_emp_pk"];
    string sp2 = "sp_sel_chem00120_2";
    DataTable dt2 = ESysLib.TableReadOpenCursor(sp2, l_parameter2);
    if (dt2.Rows.Count == 0)
    { 
         Response.Write("There is no data");
         Response.End();
    }       
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="inquiry_files/filelist.xml">
<link rel=Edit-Time-Data href="inquiry_files/editdata.mso">
<link rel=OLE-Object-Data href="inquiry_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-05-04T10:25:57Z</o:LastPrinted>
  <o:Created>2009-05-04T10:04:54Z</o:Created>
  <o:LastSaved>2009-05-21T03:29:42Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
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
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;
	}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border:.5pt solid windowtext;}
.xl29
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
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
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
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:middle;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>6</x:ActiveCol>
       <x:RangeSelection>$G$1:$K$3</x:RangeSelection>
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
  <x:WindowHeight>9135</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=927 style='border-collapse:
 collapse;table-layout:fixed;width:695pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=64 span=9 style='width:48pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=51 span=2 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=6 rowspan=2 height=34 class=xl39 width=377 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:25.5pt;width:283pt'>Evaluation<span
  style='mso-spacerun:yes'>   </span>Card</td>
  <td colspan=5 rowspan=3 class=xl45 width=324 style='width:243pt'>EMPLOYEE<span
  style='mso-spacerun:yes'>  </span>INFO</td>
  <td colspan=4 rowspan=8 class=xl47 width=226 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:169pt'>
 <img  width=144 height=138
  src="../../../system/binary/ViewFile.aspx?img_pk=<%=l_photo_pk %>&table_name=TC_FSBINARY"  />
  </td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 rowspan=2 height=34 class=xl37 style='height:25.5pt'>YEAR #</td>
  <td colspan=3 rowspan=2 class=xl38><% =l_yyyy_seq %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl38 style='height:12.75pt;border-left:none'><%=l_emp_id %></td>
  <td colspan=3 class=xl37 style='border-left:none'><% = l_fullName %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 rowspan=2 height=34 class=xl37 style='height:25.5pt'>Evaluation
  Period</td>
  <td colspan=3 rowspan=2 class=xl38><% =l_Eval_period %></td>
  <td colspan=5 class=xl38 style='border-left:none'><%= l_dept_name %><span
  style='mso-spacerun:yes'>  </span><span style='mso-spacerun:yes'> 
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl38 style='height:12.75pt;border-left:none'><% = l_group_name %>
  <span style='mso-spacerun:yes'>  </span><span
  style='mso-spacerun:yes'>  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 rowspan=2 height=34 class=xl37 style='height:25.5pt'>Schedule</td>
  <td colspan=3 rowspan=2 class=xl38><%= l_schedule %></td>
  <td colspan=5 class=xl38 style='border-left:none'><%= l_date_emp_info  %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl38 style='height:12.75pt;border-left:none'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none'>Ele. Type</td>
  <td colspan=2 class=xl29 style='border-right:.5pt solid black;border-left:
  none'>Element</td>
  <td colspan=4 class=xl29 style='border-right:.5pt solid black;border-left:
  none'>Factor</td>
  <td colspan=4 class=xl29 style='border-right:.5pt solid black;border-left:
  none'>MBO</td>
  <td class=xl27 style='border-top:none;border-left:none'>Weight</td>
  <td class=xl27 style='border-top:none;border-left:none'>Sefl-Eva</td>
  <td class=xl27 style='border-top:none;border-left:none'>1st<span
  style='mso-spacerun:yes'>  </span>Rwr</td>
  <td class=xl27 style='border-top:none;border-left:none'>2nd<span
  style='mso-spacerun:yes'>  </span>Rwr</td>
 </tr>
 <%   
     for (int i = 0; i < dt1.Rows.Count; i++)
  {
   %>
 <tr height=80 style='mso-height-source:userset;height:40.5pt'>
  <td height=50 class=xl28 style='height:37.5pt;border-top:none'><% = dt1.Rows[i][0]%></td>
  <td colspan=2 class=xl32 style='border-right:.5pt solid black;border-left:
  none'><% = dt1.Rows[i][1]%></td>
  <td colspan=4 class=xl34 width=256 style='border-right:.5pt solid black;
  border-left:none;width:192pt'><% = dt1.Rows[i][2]%></td>
  <td colspan=4 class=xl34 width=260 style='border-right:.5pt solid black;
  border-left:none;width:195pt'><% = dt1.Rows[i][3]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><% = dt1.Rows[i][4]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><% = dt1.Rows[i][5]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><% = dt1.Rows[i][6]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><% = dt1.Rows[i][7]%></td>
 </tr>
 <%
   }
   %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=9 rowspan=2 height=34 class=xl57 style='height:25.5pt'>Evaluation</td>
  <td colspan=3 rowspan=3 class=xl59>Option on Evaluation</td>
  <td colspan=3 rowspan=3 class=xl61>Option Assignment of Position</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'>Times</td>
  <td colspan=3 class=xl26 style='border-left:none'>Evaluator</td>
  <td class=xl26 style='border-top:none;border-left:none'>A</td>
  <td class=xl26 style='border-top:none;border-left:none'>C</td>
  <td class=xl26 style='border-top:none;border-left:none'>T</td>
  <td class=xl26 style='border-top:none;border-left:none'>Rank</td>
  <td class=xl26 style='border-top:none;border-left:none'>Grade</td>
 </tr>
 <%   
     for (int i = 0; i < dt2.Rows.Count; i++)
  {
   %>
 <tr height=42 style='mso-height-source:userset;height:45.5pt'>
  <td height=42 class=xl24 style='height:31.5pt;border-top:none'><% = dt2.Rows[i][0]%></td>
  <td colspan=3 class=xl25 style='border-left:none'><% = dt2.Rows[i][1]%></td>
  <td class=xl24 align=right style='border-top:none;border-left:none' x:num><% = dt2.Rows[i][2]%></td>
  <td class=xl24 align=right style='border-top:none;border-left:none' x:num><% = dt2.Rows[i][3]%></td>
  <td class=xl24 align=right style='border-top:none;border-left:none' x:num><% = dt2.Rows[i][4]%></td>
  <td class=xl24 align=right style='border-top:none;border-left:none' x:num><% = dt2.Rows[i][5]%></td>
  <td class=xl24 style='border-top:none;border-left:none'><% = dt2.Rows[i][6]%></td>
  <td colspan=3 class=xl56 width=180 style='border-left:none;width:135pt'><% = dt2.Rows[i][7]%></td>
  <td colspan=3 class=xl56 width=178 style='border-left:none;width:133pt'><% = dt2.Rows[i][8]%></td>
 </tr>
 <%
   }
   %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=57 style='width:43pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=76 style='width:57pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
