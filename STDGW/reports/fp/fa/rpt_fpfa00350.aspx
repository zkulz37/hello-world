<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string master_pk = Request.QueryString["master_pk"];
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("LG_RPT_FPFA00350", "'" + master_pk + "'");
    dt1 = ESysLib.TableReadOpenCursor("LG_RPT_FPFA00350_1", "'" + master_pk + "'");       
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bisc00070%20-%20Copy2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bisc00070%20-%20Copy2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bisc00070%20-%20Copy2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2012-09-21T08:27:04Z</o:LastPrinted>
  <o:LastSaved>2012-09-21T08:27:06Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .2in .5in .2in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font7
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
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
.xl24
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
	
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:black none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:black none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:28.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	color:windowtext;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:black none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:black none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:28.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>rpt_bisc00070 - Copy2</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/><x:FitToPage/>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11310</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Excel's Publish as Web
Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=1678 style='border-collapse:
 collapse;table-layout:fixed;width:1258pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl24 width=156 style='mso-width-source:userset;mso-width-alt:5705;
 width:117pt'>
 <col class=xl24 width=60 span=3 style='mso-width-source:userset;mso-width-alt:
 2194;width:45pt'>
 <col class=xl24 width=63 span=5 style='mso-width-source:userset;mso-width-alt:
 2304;width:47pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=148 style='mso-width-source:userset;mso-width-alt:5412;
 width:111pt'>
 <tr class=xl24 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=14 height=39 class=xl40 width=1103 style='height:29.25pt;
  width:827pt'>REPORT PACKING W/I</td>
 </tr>
 <tr class=xl24 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=14 height=39 class=xl41 width=1103 style='height:29.25pt;
  width:827pt'>Slip No:<font class="font8"> </font><font class="font9"><%= dt.Rows[0]["slip_no"]%></font><font
  class="font8"> </font><font class="font7"></font><font class="font8"> </font><font
  class="font9"></font></td>
 </tr>
 <tr class=xl24 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl24 style='height:21.0pt'></td>
  <td class=xl25>Date:</td>
  <td class=xl26><%= dt.Rows[0]["doc_date"]%></td>
  <td class=xl27></td>
  <td class=xl25>Project:</td>
  <td colspan=3 class=xl29><%= dt.Rows[0]["pl_nm"]%></td>
  <td colspan=4 class=xl24></td>
  <td class=xl46 rowspan=2>*<%= dt.Rows[0]["slip_no"]%>*</td>
  <td class=xl24></td>
 </tr>
 <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl25>Line:</td>
  <td class=xl29><%= dt.Rows[0]["line_nm"]%></td>
  <td class=xl27></td>
  <td class=xl32>Remark:</td>
  <td class=xl29><%= dt.Rows[0]["description"]%></td>
  <td class=xl30></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=24 style='height:5.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl33 style='height:18.75pt'>Seq</td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>Item Name</td>
  <td class=xl34>DWG No</td>
  <td class=xl34>IDMK</td>
  <td class=xl34>Mark</td>
  <td class=xl34>Spec 01</td>
  <td class=xl34>Spec 02</td>
  <td class=xl34 x:str="Spec 03 ">Spec 03<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34>Spec 04</td>
  <td class=xl34>Spec 05</td>
  <td class=xl34>Wi Qty</td>
  <td class=xl34>Item BC</td>
  <td class=xl34>Description</td>
 </tr>
 <%
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
  %>
 <tr class=xl24 height=59 style='mso-height-source:userset;height:44.25pt'>
  <td height=59 class=xl35 style='height:44.25pt' x:num><%= dt1.Rows[i]["seq"] %></td>
  <td colspan=2 class=xl44 width=225 style='border-right:.5pt solid black;
  border-left:none;width:169pt'><%= dt1.Rows[i]["item_name"] %></td>
  <td class=xl36><%= dt1.Rows[i]["dwg_no"] %></td>
  <td class=xl36><%= dt1.Rows[i]["idmk"] %></td>
  <td class=xl36><%= dt1.Rows[i]["mark"] %></td>
  <td class=xl36><%= dt1.Rows[i]["spec_01"] %></td>
  <td class=xl36><%= dt1.Rows[i]["spec_02"] %></td>
  <td class=xl36><%= dt1.Rows[i]["spec_03"] %></td>
  <td class=xl36><%= dt1.Rows[i]["spec_04"] %></td>
  <td class=xl36><%= dt1.Rows[i]["spec_05"] %></td>
  <td class=xl37 x:num><%= dt1.Rows[i]["req_pack_qty"]%></td>
  <td class=xl38>*<%= dt1.Rows[i]["item_bc"] %>*</td>
  <td class=xl39><%= dt1.Rows[i]["description"]%></td>
 </tr>
 <%} %>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=23 style='height:10.5pt;mso-ignore:colspan'></td>
  <td><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=156 style='width:117pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=148 style='width:111pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
