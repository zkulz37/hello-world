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
    string p_page = Request.QueryString["p_page"];
    string p_style = Request.QueryString["p_style"];
    
    string para = "'" + p_page + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("sale.sp_sel_dspc00031_1", para);
    para = "'" + p_page + "','" + p_style + "'";
    DataTable dt1 = ESysLib.TableReadOpenCursor("sale.sp_rpt_dspc00031", para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="processing%20fee_files/filelist.xml">
<link rel=Edit-Time-Data href="processing%20fee_files/editdata.mso">
<link rel=OLE-Object-Data href="processing%20fee_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-04-16T02:16:46Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-04-16T02:17:07Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font9
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
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
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
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
      <x:PaperSizeIndex>5</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1230 style='border-collapse:
 collapse;table-layout:fixed;width:923pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=176 style='mso-width-source:userset;mso-width-alt:6436;width:132pt'>
 <col width=64 span=15 style='width:48pt'>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=17 height=34 class=xl24 width=1230 style='height:25.5pt;
  width:923pt'>Processing Fee</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>Item Code</td>
  <td class=xl25 style='border-left:none'>Item Name</td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec01"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec02"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec03"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec04"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec05"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec06"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec07"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec08"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec09"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec10"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec11"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec12"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec13"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec14"] %></td>
  <td class=xl25 style='border-left:none'><%= dt.Rows[0]["spec15"] %></td>
 </tr>
 <% 
    for (int i = 0; i <  dt1.Rows.Count; i++)
    {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'><%= dt1.Rows[i]["item_code"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["item_name"]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec01"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec02"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec03"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec04"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec05"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec06"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec07"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec08"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec09"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec10"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec11"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec12"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec13"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec14"] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec15"] %></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=94 style='width:71pt'></td>
  <td width=176 style='width:132pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
