<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string Master_pk = Request.QueryString["Master_pk"];
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("inv.sp_rpt_bisa00090", "'" + Master_pk + "'");
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="report100_files/filelist.xml">
<link rel=Edit-Time-Data href="report100_files/editdata.mso">
<link rel=OLE-Object-Data href="report100_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Dang Thi Thuy Van</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2010-11-15T01:56:57Z</o:LastPrinted>
  <o:Created>2010-11-11T08:40:01Z</o:Created>
  <o:LastSaved>2010-11-15T01:57:23Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .17in .24in .28in;
	mso-header-margin:.28in;
	mso-footer-margin:.25in;}
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
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Report</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet2</x:CodeName>
     <x:TabColorIndex>15</x:TabColorIndex>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>98</x:ActiveRow>
       <x:ActiveCol>44</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8835</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Report!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=999 style='border-collapse:
 collapse;table-layout:fixed;width:748pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=202 style='mso-width-source:userset;mso-width-alt:7387;width:152pt'>
 <col width=83 span=8 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col width=64 style='width:48pt'>
 <tr height=27 style='height:20.25pt'>
  <td height=27 width=69 style='height:20.25pt;width:52pt'></td>
  <td width=202 style='width:152pt'></td>
  <td width=83 style='width:62pt'></td>
  <td class=xl44 colspan=4 width=332 style='mso-ignore:colspan;width:248pt'>W/H
  Stock Closing For Materials</td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>W/H</td>
  <%
      if (dt.Rows.Count > 0)
      {
          %>
            <td class=xl25><%=dt.Rows[0]["ware_house"].ToString()%></td>
          <% 
      }
      else
      {
          %>
            <td class=xl25></td>
          <% 
      }
       %>
  <td></td>
  <td>Stock Date:</td>
  <%
      if (dt.Rows.Count > 0)
      {
          %>
            
            <td class=xl45><%=dt.Rows[0]["dt_from"]%>~</td>
          <% 
      }
      else
      {
          %>
            <td class=xl45></td>
          <% 
      }
 %>
  
  <%
      if (dt.Rows.Count > 0)
      {
          %>
            <td class=xl26 x:num><%=dt.Rows[0]["dt_to"] %></td>
          <% 
      }
      else
      {
          %>
            <td class=xl26 x:num></td>
          <% 
      }
 %>
  <td></td>
  <td>Charger:</td>
  <%
      if (dt.Rows.Count > 0)
      {
          %>
            <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0]["emp_name"].ToString()%></td>
          <% 
      }
      else
      {
          %>
            <td class=xl25 colspan=2 style='mso-ignore:colspan'></td>
          <% 
      }
 %>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>Item Code</td>
  <td class=xl24 style='border-left:none'>Item Name</td>
  <td class=xl24 style='border-left:none'>UOM</td>
  <td class=xl24 style='border-left:none'>Lot No</td>
  <td class=xl24 style='border-left:none'>Begin Qty</td>
  <td class=xl24 style='border-left:none'>In Qty</td>
  <td class=xl24 style='border-left:none'>Out Qty</td>
  <td class=xl24 style='border-left:none'>Adjust Qty</td>
  <td class=xl24 style='border-left:none'>Check Qty</td>
  <td class=xl24 style='border-left:none'>Remark</td>
  <td></td>
 </tr>
 <%
     double tot1 = 0;
     double tot2 = 0;
     double tot3 = 0;
     double tot4 = 0;
     double tot5 = 0;
     
     for (int i = 1; i < dt.Rows.Count; i++)
     {
         tot1 = tot1 + CommondLib.ConvertToDbl(dt.Rows[i]["begin_qty"].ToString());
         tot2 = tot2 + CommondLib.ConvertToDbl(dt.Rows[i]["in_qty"].ToString());
         tot3 = tot3 + CommondLib.ConvertToDbl(dt.Rows[i]["out_qty"].ToString());
         tot4 = tot4 + CommondLib.ConvertToDbl(dt.Rows[i]["adjust_qty"].ToString());
         tot5 = tot5 + CommondLib.ConvertToDbl(dt.Rows[i]["end_qty"].ToString());
         
        %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl38 style='height:17.25pt;border-top:none'><%=dt.Rows[i]["item_code"]%></td>
  <td class=xl38 style='border-top:none'><%=dt.Rows[i]["item_name"]%></td>
  <td class=xl39 style='border-top:none'><%=dt.Rows[i]["uom"]%></td>
  <td class=xl38 style='border-top:none'><%=dt.Rows[i]["lot_no"]%></td>
  <td class=xl40 align=right style='border-top:none' x:num><%=dt.Rows[i]["begin_qty"]%></td>
  <td class=xl40 align=right style='border-top:none' x:num><%=dt.Rows[i]["in_qty"]%></td>
  <td class=xl40 align=right style='border-top:none' x:num><%=dt.Rows[i]["out_qty"]%></td>
  <td class=xl40 align=right style='border-top:none' x:num><%=dt.Rows[i]["adjust_qty"]%></td>
  <td class=xl40 align=right style='border-top:none' x:num><%=dt.Rows[i]["end_qty"]%></td>
  <td class=xl39 style='border-top:none'><%=dt.Rows[i]["description"]%></td>
  <td></td>
 </tr>
        <% 
     }
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt'>TOTAL</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl37 align=right x:num><%=tot1 %></td>
  <td class=xl37 align=right x:num><%=tot2 %></td>
  <td class=xl37 align=right x:num><%=tot3 %></td>
  <td class=xl37 align=right x:num><%=tot4 %></td>
  <td class=xl37 align=right x:num><%=tot5 %></td>
  <td class=xl36>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl30>Manager 1</td>
  <td class=xl30 style='border-left:none'>Manager 2</td>
  <td class=xl30 style='border-left:none'>Manager 3</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none;border-left:none'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28 style='border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-left:none'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=69 style='width:52pt'></td>
  <td width=202 style='width:152pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
