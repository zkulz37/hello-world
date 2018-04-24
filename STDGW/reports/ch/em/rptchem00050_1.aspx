<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
  ESysLib.SetUser(Session("APP_DBUSER"));
  string eva_no = Request["eva_no"];
  string GradeType = Request["GradeType"];
  string Position = Request["Position"];
  string period = Request["period"];
  string schedule = Request["schedule"];
    string group = Request["group"];
    if(Request["group"].ToString()== "Select ALL")
    {
        group = "ALL";
    }else{
         group = Request["group"];
    }    
        
  
  string Org1 = Request["Org1"];
  if (Request["Org1"] == "")
  {
      Org1 = "ALL";
  
  }  
 // string grdtimes = Request["grdtimes"];    
 
  string p_year = Request["p_year"];
  string p_organization_pk = Request["p_organization_pk"];
  string p_emp_pk  = Request["p_emp_pk"];
  string p_position_id = Request["p_position_id"];
  string p_thr_eva_group_pk = Request["p_thr_eva_group_pk"];
  string p_company_pk = Request["p_company_pk"];
  string status = Request["status"]; 
    
  string l_parameter = "'" + p_year + "','" + p_organization_pk + "','" + p_emp_pk + "','" + p_position_id + "','" + p_thr_eva_group_pk + "','" + p_company_pk  + "','" + status + "'";

 //Response.Write(l_parameter);
 // Response.End();
  string l_SQLD = "hr_sel_chem00050_3" ;
  DataTable dt = ESysLib.TableReadOpenCursor(l_SQLD, l_parameter);
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
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AiLinh</o:Author>
  <o:LastAuthor>AiLinh</o:LastAuthor>
  <o:Created>2009-06-02T03:20:13Z</o:Created>
  <o:LastSaved>2009-06-02T04:00:22Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .5in .75in;
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
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt hairline windowtext;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt hairline windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	text-align:right;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	mso-number-format:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt hairline windowtext;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt hairline windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:500;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	color:blue;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	color:blue;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	color:blue;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl63
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;}
	.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl64
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
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
      <x:ValidPrinterInfo/>
      <x:Scale>74</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>95</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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
  <x:WindowHeight>9720</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1231 style='border-collapse:
 collapse;table-layout:fixed;width:925pt'>
 <col class=xl25 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl25 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl25 width=11 style='mso-width-source:userset;mso-width-alt:402;
 width:8pt'>
 <col class=xl25 width=146 style='mso-width-source:userset;mso-width-alt:5339;
 width:110pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <col class=xl25 width=135 style='mso-width-source:userset;mso-width-alt:4937;
 width:101pt'>
 <col class=xl25 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl25 width=160 style='mso-width-source:userset;mso-width-alt:5851;
 width:120pt'>
 <col class=xl25 width=14 style='mso-width-source:userset;mso-width-alt:512;
 width:11pt'>
 <col class=xl25 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
 <col class=xl25 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl25 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl25 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl25 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl25 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <tr height=34 style='height:25.5pt'>
  <td colspan=16 height=34 class=xl56 width=1231 style='border-right:1.0pt solid black;
  height:25.5pt;width:925pt'>List of evaluated employee</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl28 style='height:15.75pt'>Evaluation #</td>
  <td class=xl27>:</td>
  <td class=xl27><%=eva_no%></td>
  <td class=xl25></td>
  <td class=xl26>Organization</td>
  <td class=xl26>:</td>
  <td colspan=3 class=xl27 ><%=Org1%></td>
  <td class=xl25></td>
  <td class=xl26>Evaluation Period</td>
  <td class=xl26>:</td>
  <td colspan=3 class=xl26 style='border-right:1.0pt solid black'><%=period %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl28 style='height:15.75pt'>Eva. times</td>
  <td class=xl27>:</td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=GradeType %></td>
  <td class=xl26>Evaluation Group</td>
  <td class=xl26>:</td>
  <td colspan=3 class=xl26><%=group %></td>
  <td class=xl25></td>
  <td class=xl26>Schedule</td>
  <td class=xl26>:</td>
  <td colspan=3 class=xl26 style='border-right:1.0pt solid black'><%=schedule %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl28 style='height:15.75pt'>Position</td>
  <td class=xl27>:</td>
  <td class=xl27><%=Position %></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td class=xl26></td>
  <td colspan=3 class=xl26></td>
  <td class=xl26></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td class=xl26></td>
  <td colspan=13 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl29</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt'>No.</td>
  <td colspan=3 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Organization</td>
  <td class=xl39 style='border-left:none'>EMP ID</td>
  <td class=xl39 style='border-left:none'>EMP Name</td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Position</td>
  <td colspan=2 class=xl39 style='border-left:none'>Evaluation Group</td>
  <td colspan=2 class=xl39 style='border-left:none'>1st Reviewer</td>
  <td class=xl39 style='border-left:none'>Grade1</td>
  <td class=xl39 style='border-left:none'>2nd Reviewer</td>
  <td class=xl39 style='border-left:none'>Grade2</td>
  <td class=xl47 style='border-left:none'>Status</td>
 </tr>
  <%
  int i;
  for (i = 0; i < dt.Rows.Count - 1; i++)
  {
      if (i == 0)
      {
  %>
 <tr height=21 style='height:15.75pt'>
  <td height=21  class=xl40  align=right style='height:15.75pt;border-top:none'><%=i + 1%></td>
  <td colspan=3 class=xl43 style='border-left:none'><%= dt.Rows[i][3].ToString()%></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt.Rows[i][4].ToString()%></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt.Rows[i][5].ToString()%></td>
  <td colspan=2 class=xl62 style='border-right:.5pt hairline black;border-left:
  none'><%= dt.Rows[i][6].ToString()%></td>
  <td colspan=2 class=xl52 style='border-left:none'><%= dt.Rows[i][19].ToString()%></td>
  <td colspan=2 class=xl30 style='border-left:none'><%= dt.Rows[i][8].ToString()%></td>
  <td class=xl64 style='border-top:none;border-left:none'><%= dt.Rows[i][9].ToString()%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt.Rows[i][10].ToString()%></td>
  <td class=xl64 style='border-top:none;border-left:none'><%= dt.Rows[i][11].ToString()%></td>
  <td class=xl32 style='border-top:none;border-left:none'><%= dt.Rows[i][18].ToString()%></td>
 </tr>
  <%
      }
      else
      {
   %>
 
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl41  align=right style='height:15.75pt;border-top:none'><%=i + 1%></td>
  <td colspan=3 class=xl44 style='border-left:none'><%= dt.Rows[i][3].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][4].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][5].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt hairline black;border-left:
  none'><%= dt.Rows[i][6].ToString()%></td>
  <td colspan=2 class=xl34 style='border-left:none'><%= dt.Rows[i][19].ToString()%></td>
  <td colspan=2 class=xl34 style='border-left:none'><%= dt.Rows[i][8].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none'><%= dt.Rows[i][9].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%= dt.Rows[i][10].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none'><%= dt.Rows[i][11].ToString()%></td>
  <td class=xl35 style='border-top:none;border-left:none'><%= dt.Rows[i][18].ToString()%></td>
 </tr>
 <%
      }
     }
  %>
 
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl42 align=right style='height:16.5pt;border-top:none'
  x:num><%=i + 1%></td>
  <td colspan=3 class=xl45 style='border-left:none'><%= dt.Rows[i][3].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][4].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][5].ToString()%></td>
  <td colspan=2 class=xl50 style='border-right:.5pt hairline black;border-left:
  none'><%= dt.Rows[i][6].ToString()%></td>
  <td colspan=2 class=xl54 style='border-left:none'><%= dt.Rows[i][19].ToString()%></td>
  <td colspan=2 class=xl37 style='border-left:none'><%= dt.Rows[i][8].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%= dt.Rows[i][9].ToString()%></td>
  <td class=xl37 style='border-top:none;border-left:none'><%= dt.Rows[i][10].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%= dt.Rows[i][11].ToString()%></td>
  <td class=xl38 style='border-top:none;border-left:none'><%= dt.Rows[i][18].ToString()%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=26 style='width:20pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=11 style='width:8pt'></td>
  <td width=146 style='width:110pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=14 style='width:11pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
