<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%    
    string p_from_date = Request.QueryString["p_from_date"];
    string p_wh_pk = Request.QueryString["p_wh_pk"];
	string p_wh_name = Request.QueryString["p_wh_name"];
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bisc00031_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bisc00031_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bisc00031_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2011-05-11T07:21:35Z</o:LastPrinted>
  <o:Created>2011-05-11T06:40:24Z</o:Created>
  <o:LastSaved>2011-05-11T07:22:15Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.18in .17in .17in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
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
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl26
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl27
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
	border-left:none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	color:#993300;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}	
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>16155</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=971 style='border-collapse:
 collapse;table-layout:fixed;width:733pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=195 style='mso-width-source:userset;mso-width-alt:7131;width:146pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=62 span=8 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <tr height=50 style='mso-height-source:userset;height:37.5pt'>
  <td colspan=13 height=50 class=xl30 width=971 style='height:37.5pt;
  width:733pt'>W/H Monthly Closing</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl31 width=425 style='height:15.0pt;width:319pt'>W/H
  : <font class="font7"><%=p_wh_name%></font></td>
  <td colspan=5 class=xl31 width=298 style='width:226pt'>Stock Date : <font
  class="font7"><%=System.DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("MM/yyyy")%></font></td>
  <td colspan=4 class=xl31 width=248 style='width:188pt'>Print Date : <font
  class="font7"><%=System.DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss")%></font></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=13 height=17 class=xl32 width=971 style='height:12.75pt;
  width:733pt'>&nbsp;</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl24 width=40 style='height:22.5pt;width:30pt'>Seq</td>
  <td class=xl25 width=100 style='width:75pt'>Group</td>
  <td class=xl25 width=90 style='width:68pt'>Item Code</td>
  <td class=xl25 width=195 style='width:146pt'>Item Name</td>
  <td class=xl25 width=50 style='width:38pt'>UOM</td>
  <td class=xl25 width=62 style='width:47pt'>Begin Qty</td>
  <td class=xl25 width=62 style='width:47pt'>In Qty</td>
  <td class=xl25 width=62 style='width:47pt'>Sale</td>
  <td class=xl25 width=62 style='width:47pt'>FOC</td>
  <td class=xl25 width=62 style='width:47pt'>Trans</td>
  <td class=xl25 width=62 style='width:47pt'>Adjust Qty</td>
  <td class=xl25 width=62 style='width:47pt'>Out Qty</td>
  <td class=xl25 width=62 style='width:47pt'>End Qty</td>
 </tr>

<%
            string para = "'" + p_wh_pk + "','" + p_from_date + "'" ;
            DataTable dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_bisc00031", para);
			
			decimal TotalInQty = 0;
            decimal TotalBeginQty = 0;
            decimal TotalOutQty= 0;
            decimal TotalEndQty = 0;
			
            for (int i = 0; i < dt.Rows.Count; i++)
            { 
%> 

 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl26 width=40 style='height:18.75pt;width:30pt' x:num><%=i+1%></td>
  <td class=xl37 width=100 style='width:75pt'><%=dt.Rows[i]["grp_nm"]%></td>
  <td class=xl27 width=90 style='width:68pt'><%=dt.Rows[i]["item_code"]%></td>
  <td class=xl37 width=195 style='width:146pt'><%=dt.Rows[i]["item_name"]%></td>
  <td class=xl37 width=50 style='width:38pt'><%=dt.Rows[i]["uom"]%></td>
  <td class=xl33 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>���������� </span><%=dt.Rows[i]["begin_qty"]%></td>
  <td class=xl33 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span><%=dt.Rows[i]["in_qty"]%> </td>
  <td class=xl34 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>���������� </span><%=dt.Rows[i]["out_01_qty"]%></td>
  <td class=xl34 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span><%=dt.Rows[i]["out_02_qty"]%></td>
  <td class=xl34 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span><%=dt.Rows[i]["out_03_qty"]%> </td>
  <td class=xl34 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span><%=dt.Rows[i]["out_04_qty"]%> </td>
  <td class=xl33 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span><%=dt.Rows[i]["out_qty"]%> </td>
  <td class=xl33 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>� </span><%=dt.Rows[i]["end_qty"]%> </td>
 </tr>
 <%
            TotalBeginQty += Convert.ToDecimal(dt.Rows[i]["begin_qty"]);
	 		TotalInQty += Convert.ToDecimal(dt.Rows[i]["in_qty"]);
		    TotalOutQty += Convert.ToDecimal(dt.Rows[i]["out_qty"]);
     		TotalEndQty += Convert.ToDecimal(dt.Rows[i]["end_qty"]);
	 
 			}
 %>
 
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl28 width=40 style='height:18.75pt;width:30pt'>&nbsp;</td>
  <td class=xl29 width=100 style='width:75pt'>&nbsp;</td>
  <td class=xl29 width=90 style='width:68pt'>&nbsp;</td>
  <td class=xl29 width=195 style='width:146pt'>&nbsp;</td>
  <td class=xl29 width=50 style='width:38pt'>&nbsp;</td>
  <td class=xl35 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span><%=TotalBeginQty%></td>
  <td class=xl35 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>��� </span><%=TotalInQty%> </td>
  <td class=xl36 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span></td>
  <td class=xl36 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span></td>
  <td class=xl36 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span> </td>
  <td class=xl36 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span> </td>
  <td class=xl35 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span><%=TotalOutQty%> </td>
  <td class=xl35 width=62 style='width:47pt' x:num><span
  style='mso-spacerun:yes'>�������� </span><%=TotalEndQty%> </td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
