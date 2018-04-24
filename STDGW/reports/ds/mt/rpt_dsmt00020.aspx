<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_emp = Request.QueryString["p_emp"];
    string p_partner = Request.QueryString["p_partner"];
    string para = " '" + p_emp + "','" + p_partner + "'";
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("lg_rpt_dsmt00020", para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsmt00020_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsmt00020_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsmt00020_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-07-27T04:23:01Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-07-27T04:53:16Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in .1in .44in .1in;
	mso-header-margin:.17in;
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
	font-size:22.0pt;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
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
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1015 style='border-collapse:
 collapse;table-layout:fixed;width:763pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=182 style='mso-width-source:userset;mso-width-alt:6656;width:137pt'>
 <col width=135 style='mso-width-source:userset;mso-width-alt:4937;width:101pt'>
 <col width=182 style='mso-width-source:userset;mso-width-alt:6656;width:137pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=158 span=2 style='mso-width-source:userset;mso-width-alt:5778;
 width:119pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <tr height=51 style='mso-height-source:userset;height:38.25pt'>
  <td colspan=7 height=51 class=xl24 width=1015 style='height:38.25pt;
  width:763pt'>Buyer Charger</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt' x:str="Emp ID ">Emp ID<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25 style='border-left:none'>Full Name</td>
  <td class=xl25 style='border-left:none'>F Name</td>
  <td class=xl25 style='border-left:none'>Division Name</td>
  <td class=xl25 style='border-left:none'>Partner ID</td>
  <td class=xl25 style='border-left:none'>Partner Name</td>
  <td class=xl25 style='border-left:none'>Partner L Name</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'><%= dt.Rows[i]["emp_id"]%><span style='mso-spacerun:yes'></span></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["full_name"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["full_fname"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["division_name"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["partner_id"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["partner_name"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt.Rows[i]["partner_lname"]%></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=100 style='width:75pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=158 style='width:119pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
