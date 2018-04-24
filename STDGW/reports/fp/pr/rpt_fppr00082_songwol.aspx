<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("sale");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_from_date    = Request.QueryString["from_dt"];
	string p_to_date      = Request.QueryString["to_dt"];
	string p_factory_pk   = Request.QueryString["wp_pk"];	
	string p_factory_name = Request.QueryString["wp_name"];
    string para = " '" + p_factory_pk + "','" + p_from_date + "','" + p_to_date + "'";

    DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_fppr00082_songwol", para);
    if (dt.Rows.Count == 0) { Response.Write("No Data"); Response.End(); }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="process_files/filelist.xml">
<link rel=Edit-Time-Data href="process_files/editdata.mso">
<link rel=OLE-Object-Data href="process_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-07-20T07:11:55Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-07-20T07:12:30Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&C&P of &N";
	margin:.25in .3in .37in .3in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:18.0pt;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:"d\\-mmm";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:1.0pt solid windowtext;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>15</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1011 style='border-collapse:
 collapse;table-layout:fixed;width:759pt'>
 <col width=64 style='width:48pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=64 style='width:48pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=64 style='width:48pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=64 style='width:48pt'>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td colspan=14 height=53 class=xl25 width=1011 style='height:39.75pt;
  width:759pt'>WEAVING BEAM MONTH IN. OUTPUT LIST</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=14 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td rowspan=2 height=40 class=xl29 style='height:30.0pt'>ITEM</td>
  <td rowspan=2 class=xl29>YARN</td>
  <td rowspan=2 class=xl30 width=77 style='width:58pt'>YARN <br>
    COUNT</td>
  <td rowspan=2 class=xl30 width=81 style='width:61pt'>WAPPING <br>
    MTR</td>
  <td rowspan=2 class=xl30 width=59 style='width:44pt'>SIZING <br>
    DATE</td>
  <td rowspan=2 class=xl29>REF. NO.</td>
  <td colspan=3 class=xl29 style='border-left:none'>INPUT</td>
  <td rowspan=2 class=xl29>M/C</td>
  <td colspan=3 class=xl29 style='border-left:none'>OUTPUT</td>
  <td rowspan=2 class=xl29>REMARK</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl29 style='height:16.5pt;border-top:none;border-left:
  none'>DATE</td>
  <td class=xl29 style='border-top:none;border-left:none'>mtr</td>
  <td class=xl29 style='border-top:none;border-left:none'>kg</td>
  <td class=xl29 style='border-top:none;border-left:none'>DATE</td>
  <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'>�</span>CHECK</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
%>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl26 style='height:16.5pt'><%= dt.Rows[i]["item"] %></td>
  <td class=xl26 style='border-left:none'><%= dt.Rows[i]["yarn"] %></td>
  <td class=xl26 style='border-left:none' x:num><%= dt.Rows[i]["yarn_count"] %></td>
  <td class=xl26 style='border-left:none'><%= dt.Rows[i]["wapping_mtr"] %></td>
  <td class=xl26 style='border-left:none'><%= dt.Rows[i]["sizing_date"] %></td>
  <td class=xl26 style='border-left:none'><%= dt.Rows[i]["ref_no"] %></td>
  <td class=xl28 style='border-left:none'><%= dt.Rows[i]["input_date"] %></td>
  <td class=xl28 style='border-left:none'><%= dt.Rows[i]["input_mtr"] %></td>
  <td class=xl27 style='border-left:none'><%= dt.Rows[i]["input_kg"] %></td>
  <td class=xl28 style='border-left:none' x:num><%= dt.Rows[i]["mc"] %></td>
  <td class=xl28 style='border-left:none'><%= dt.Rows[i]["output_date"] %></td>
  <td class=xl26 style='border-left:none'><%= dt.Rows[i]["output_"] %></td>
  <td class=xl26 style='border-left:none'><%= dt.Rows[i]["output_check"] %></td>
  <td class=xl26 style='border-left:none'><%= dt.Rows[i]["description"] %></td>
 </tr>
 <%     } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
