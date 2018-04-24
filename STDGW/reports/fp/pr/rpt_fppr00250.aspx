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
    string p_master_pk = Request.QueryString["p_master_pk"];
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("LG_RPT_FPPR00250", "'" + p_master_pk + "'");
    dt1 = ESysLib.TableReadOpenCursor("LG_RPT_FPPR00250_1", "'" + p_master_pk + "'");
    dt2 = ESysLib.TableReadOpenCursor("LG_RPT_FPPR00250_2", "'" + p_master_pk + "'");
    if(dt == null && dt.Rows.Count == 0) Response.End();
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00250_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00250_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00250_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-08-16T03:54:37Z</o:LastPrinted>
  <o:LastSaved>2012-08-16T03:54:41Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .2in .5in .2in;
	mso-header-margin:0in;
	mso-footer-margin:.25in;
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
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:26.0pt;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>rpt_fppr00250</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5520</x:WindowHeight>
  <x:WindowWidth>18060</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1206 style='border-collapse:
 collapse;table-layout:fixed;width:908pt'>
 <col width=29 style='mso-width-source:userset;mso-width-alt:1060;width:22pt'>
 <col width=64 style='width:48pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=129 style='mso-width-source:userset;mso-width-alt:4717;width:97pt'>
 <col width=10 style='mso-width-source:userset;mso-width-alt:365;width:8pt'>
 <col width=29 style='mso-width-source:userset;mso-width-alt:1060;width:22pt'>
 <col width=64 style='width:48pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=129 style='mso-width-source:userset;mso-width-alt:4717;width:97pt'>
 <tr height=44 style='mso-height-source:userset;height:33.0pt'>
  <td colspan=17 height=44 class=xl41 width=1206 style='height:33.0pt;
  width:908pt'>PROD INCOMING</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl39 style='height:22.5pt'>Slip No</td>
  <td class=xl38 x:num><%= dt.Rows[0]["slip_no"] %></td>
  <td class=xl39>Ref No</td>
  <td class=xl38 x:num><%= dt.Rows[0]["ref_no"] %></td>
  <td class=xl37></td>
  <td class=xl39>Date</td>
  <td class=xl38><%= dt.Rows[0]["prod_date"]%></td>
  <td class=xl37></td>
  <td colspan=2 class=xl39>Charger</td>
  <td class=xl38 colspan=2 style='mso-ignore:colspan'><%= dt.Rows[0]["full_name"]%></td>
  <td colspan=4 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl39 style='height:22.5pt'>In W/H</td>
  <td class=xl38 colspan=2 style='mso-ignore:colspan'><%= dt.Rows[0]["in_wh"]%></td>
  <td colspan=5 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl39>In Line</td>
  <td class=xl38 colspan=2 style='mso-ignore:colspan'><%= dt.Rows[0]["in_line"]%></td>
  <td colspan=4 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl39 style='height:22.5pt'>Out W/H</td>
  <td class=xl38 colspan=2 style='mso-ignore:colspan'><%= dt.Rows[0]["out_wh"]%></td>
  <td colspan=5 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl39>Out Line</td>
  <td class=xl38 colspan=2 style='mso-ignore:colspan'><%= dt.Rows[0]["out_line"]%></td>
  <td colspan=4 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl40 style='height:22.5pt'>Remark</td>
  <td class=xl38><%= dt.Rows[0]["description"]%></td>
  <td colspan=14 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=8 height=23 class=xl34 style='border-right:.5pt solid black;
  height:17.25pt'>IN</td>
  <td class=xl24>&nbsp;</td>
  <td colspan=8 class=xl34 style='border-right:.5pt solid black;border-left:
  none'>OUT</td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'>Seq</td>
  <td class=xl27>Ref No</td>
  <td class=xl27>Item Code</td>
  <td class=xl27>Item Name</td>
  <td class=xl27>UOM</td>
  <td class=xl27>Qty</td>
  <td class=xl27>Lot No</td>
  <td class=xl27>Remark</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl27>Seq</td>
  <td class=xl27>Ref No</td>
  <td class=xl27>Item Code</td>
  <td class=xl27>Item Name</td>
  <td class=xl27>UOM</td>
  <td class=xl27>Qty</td>
  <td class=xl27>Lot No</td>
  <td class=xl27>Remark</td>
 </tr>
 <%
     int r_count = dt1.Rows.Count > dt2.Rows.Count ? dt1.Rows.Count : dt2.Rows.Count;
     if (dt1.Rows.Count > dt2.Rows.Count)
     {
         for (int a = 0; a < dt1.Rows.Count - dt2.Rows.Count; a++)
         {
             DataRow r = dt2.NewRow();
             dt2.Rows.Add(r);
         }
     }
     else
     {
         for (int a = 0; a < dt2.Rows.Count - dt1.Rows.Count; a++)
         {
             DataRow r = dt1.NewRow();
             dt1.Rows.Add(r);
         }
     }
     for (int i = 0; i < r_count; i++)
     {
      %>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt' x:num><%= dt1.Rows[i]["seq"] %></td>
  <td class=xl30 align=right x:num><%= dt1.Rows[i]["ref_no"]%></td>
  <td class=xl30><%= dt1.Rows[i]["item_code"]%></td>
  <td class=xl30><%= dt1.Rows[i]["item_name"]%></td>
  <td class=xl31><%= dt1.Rows[i]["in_uom"]%></td>
  <td class=xl32 align=right x:num><%= dt1.Rows[i]["in_qty"]%></td>
  <td class=xl30><%= dt1.Rows[i]["lot_no"]%></td>
  <td class=xl30><%= dt1.Rows[i]["description"]%></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl31 x:num><%= dt2.Rows[i]["seq"] %></td>
  <td class=xl30 align=right x:num><%= dt2.Rows[i]["ref_no"]%></td>
  <td class=xl30><%= dt2.Rows[i]["item_code"]%></td>
  <td class=xl30><%= dt2.Rows[i]["item_name"]%></td>
  <td class=xl31><%= dt2.Rows[i]["out_uom"]%></td>
  <td class=xl32 align=right x:num><%= dt2.Rows[i]["out_qty"]%></td>
  <td class=xl30><%= dt2.Rows[i]["lot_no"]%></td>
  <td class=xl30><%= dt2.Rows[i]["description"]%></td>
 </tr>
 <% } %>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=16 style='height:12.75pt;mso-ignore:colspan'></td>
  <td><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=129 style='width:97pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
