<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    DataTable dt;
 	string project_pk	=	Request.QueryString["p_pl_pk"];
 	string item	=	Request.QueryString["item"];
    dt = ESysLib.TableReadOpenCursor("lg_rpt_fpfa00290_1", "'" + project_pk + "','"+item+"'");
   if (dt.Rows.Count ==0)   
   {
    Response.Write("No data found!");
    Response.End();
   }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpfa00290_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpfa00290_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpfa00290_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2012-09-21T06:40:23Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-09-21T06:45:46Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .75in .75in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font8
	{color:windowtext;
	font-size:10.0pt;
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
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
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
      <x:Scale>64</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1474 style='border-collapse:
 collapse;table-layout:fixed;width:1107pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=154 style='mso-width-source:userset;mso-width-alt:5632;width:116pt'>
 <col width=44 style='mso-width-source:userset;mso-width-alt:1609;width:33pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=64 style='mso-width-source:userset;mso-width-alt:2340;width:48pt'>
 <col width=206 style='mso-width-source:userset;mso-width-alt:7533;width:155pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=64 style='width:48pt'>
 <col width=76 span=2 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col width=64 style='width:48pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=126 style='mso-width-source:userset;mso-width-alt:4608;width:95pt'>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=17 height=30 class=xl24 width=1474 style='height:22.5pt;
  width:1107pt'>CUTTING PLAN</td>
 </tr>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 class=xl25 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Project
  name:<font class="font8"> <%=dt.Rows[0]["project_nm"].ToString() %></font></td>
  <td colspan=15 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 class=xl25 colspan=5 style='height:12.75pt;mso-ignore:colspan'>Item
  name : <font class="font8"><%=dt.Rows[0]["item_name"].ToString() %></font></td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 class=xl25 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Date:
  <font class="font8"><%=dt.Rows[0]["print_dt"].ToString() %></font></td>
  <td colspan=15 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>Rev: <font class="font8">0</font></td>
  <td colspan=16 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=51 style='mso-height-source:userset;height:38.25pt'>
  <td height=51 class=xl31 style='height:38.25pt'>No.</td>
  <td class=xl31 style='border-left:none'>Item</td>
  <td class=xl31 style='border-left:none'>DWG. NO</td>
  <td class=xl31 style='border-left:none'>REV.</td>
  <td class=xl31 style='border-left:none'>IDMK</td>
  <td class=xl31 style='border-left:none'>MARK</td>
  <td class=xl31 style='border-left:none'>Description</td>
  <td class=xl32 width=84 style='border-left:none;width:63pt'>Length/<br>
    area<br>
    (mm/m2)</td>
  <td class=xl31 style='border-left:none'>Q'ty</td>
  <td class=xl32 width=76 style='border-left:none;width:57pt'>U.Weight<br>
    (kg/m,m2)</td>
  <td class=xl32 width=76 style='border-left:none;width:57pt'>Weight<br>
    (kg)</td>
  <td class=xl31 style='border-left:none'>MAT'L</td>
  <td class=xl32 width=98 style='border-left:none;width:74pt'>Total
  Length/<br>
    Area(mm/m2)</td>
  <td class=xl32 width=64 style='border-left:none;width:48pt'>Loss Rate<br>
    (%)</td>
  <td class=xl31 style='border-left:none'>Remain</td>
  <td class=xl32 width=52 style='border-left:none;width:39pt'>Q'ty</td>
  <td class=xl32 width=126 style='border-left:none;width:95pt'>Remark</td>
 </tr>
 <tr class=xl25 height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl33 style='height:8.25pt;border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
        if(dt.Rows[i]["record_type"].ToString()=="D")
        {
      %>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i]["item_name"].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i]["dwg_no"].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["rev"].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%=dt.Rows[i]["idmk"].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%=dt.Rows[i]["mark"].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i]["description"].ToString() %></td>
  <td class=xl34 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["length"].ToString() %></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["plan_qty"].ToString() %></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["unit_wt"].ToString() %></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_wt"].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%=dt.Rows[i]["material"].ToString() %></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i]["total_length"].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i]["loss_rate"].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i]["remain_length"].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i]["remain_qty"].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i]["cut_remark"].ToString() %></td>
 </tr>
    <%
        }else
        {
     %>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none'><%=dt.Rows[i]["CP_NO"].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'><%=dt.Rows[i]["Description"].ToString() %></td>
  <td class=xl37 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["length"].ToString() %></td>
  <td class=xl38 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["plan_qty"].ToString() %></td>
  <td class=xl38 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["unit_wt"].ToString() %></td>
  <td class=xl38 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["total_wt"].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt.Rows[i]["material"].ToString() %></td>
  <td class=xl41 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i]["total_length"].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none'><%=dt.Rows[i]["loss_rate"].ToString() %></td>
  <td class=xl37 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["remain_length"].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none'><%=dt.Rows[i]["remain_qty"].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none'><%=dt.Rows[i]["cut_remark"].ToString() %></td>
 </tr>
 <%
        }
     }
  %>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='border-right:.5pt solid black'>TOTAL(B.O.M)</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num="7810.1">7,810.10</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='border-right:.5pt solid black'>TOTAL(CP)</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num="8035.2">8,035.20</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='border-right:.5pt solid black'>REMAIN</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>180.14</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='border-right:.5pt solid black'>LOSS RATE(%)</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num>0.6</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=52 style='width:39pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=206 style='width:155pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=126 style='width:95pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
