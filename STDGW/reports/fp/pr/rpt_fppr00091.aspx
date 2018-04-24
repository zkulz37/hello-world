<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%    
    string from_date = Request.QueryString["p_from_date"];	
	
    string factory_pk = Request.QueryString["p_factory_pk"];
    string factory_name = Request.QueryString["p_factory_name"];	
	
	string para = "'" + factory_pk + "','" + from_date + "'";
	
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00091", para); 			
%>


<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00091_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00091_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00091_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2011-05-13T01:53:42Z</o:LastPrinted>
  <o:Created>2011-05-13T01:41:04Z</o:Created>
  <o:LastSaved>2011-05-13T01:57:49Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.2in .16in .18in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;}
.font5
	{color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font6
	{color:#993300;
	font-size:20.0pt;
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
.style21
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl25
	{mso-style-parent:style21;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style21;
	color:#993300;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double olive;
	border-right:.5pt solid olive;
	border-bottom:.5pt solid olive;
	border-left:2.0pt double olive;}
.xl30
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double olive;
	border-right:.5pt solid olive;
	border-bottom:.5pt solid olive;
	border-left:.5pt solid olive;}
.xl31
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double olive;
	border-right:.5pt solid olive;
	border-bottom:.5pt solid olive;
	border-left:.5pt solid olive;
	background:yellow;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double olive;
	border-left:none;}
.xl33
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid olive;
	border-right:.5pt solid olive;
	border-bottom:2.0pt double olive;
	border-left:2.0pt double olive;
	white-space:normal;}
.xl35
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid olive;
	border-right:.5pt solid olive;
	border-bottom:2.0pt double olive;
	border-left:.5pt solid olive;
	white-space:normal;}
.xl36
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid olive;
	border-right:.5pt solid olive;
	border-bottom:2.0pt double olive;
	border-left:.5pt solid olive;
	white-space:normal;}
.xl37
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid olive;
	border-right:.5pt solid olive;
	border-bottom:2.0pt double olive;
	border-left:.5pt solid olive;
	white-space:normal;}
.xl38
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid olive;
	border-right:.5pt solid olive;
	border-bottom:2.0pt double olive;
	border-left:.5pt solid olive;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl39
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid olive;
	border-right:2.0pt double olive;
	border-bottom:2.0pt double olive;
	border-left:.5pt solid olive;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double olive;
	border-right:2.0pt double olive;
	border-bottom:.5pt solid olive;
	border-left:.5pt solid olive;
	background:#CCFFFF;
	mso-pattern:auto none;}
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
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
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
  <x:Formula>=Sheet1!$1:$1</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=780 style='border-collapse:
 collapse;table-layout:fixed;width:587pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=120 style='mso-width-source:userset;mso-width-alt:4388;width:90pt'>
 <col width=140 style='mso-width-source:userset;mso-width-alt:5120;width:105pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=90 span=4 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <tr height=35 style='height:26.25pt'>
  <td colspan=8 height=35 class=xl26 width=780 style='height:26.25pt;
  width:587pt'><%=factory_name%><font class="font5"> LINE TARGET </font><font
  class="font6">SEWING</font></td>
 </tr>
 
 <%
 	string s_routing_group = "0";		   
	 	 	
	for (int i = 0; i < dt.Rows.Count; i++)
    {
	 	if ( s_routing_group != dt.Rows[i]["routing_group"].ToString() )
		{
		
 %>
 
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl33 style='height:30.0pt'>DATE</td>
  <td colspan=2 class=xl32 ><%= System.DateTime.ParseExact(from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl28 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl29 style='height:30.0pt'>LINE</td>
  <td class=xl30 style='border-top:none;border-left:none'>VMO</td>
  <td class=xl30 style='border-top:none;border-left:none'>STYLE</td>
  <td class=xl30 style='border-left:none'>COLOR</td>
  <td class=xl30 style='border-left:none'>Q'TY</td>
  <td class=xl31 style='border-left:none' x:str="TARGET ">TARGET<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl30 style='border-left:none'>TOTAL</td>
  <td class=xl40 style='border-left:none'>BALANCE</td>
 </tr>
 <%
 			s_routing_group = dt.Rows[i]["routing_group"].ToString();
 		}
 %>      
 <tr height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 class=xl34 width=60 style='height:37.5pt;border-top:none;
  width:45pt' ><%=dt.Rows[i]["routing_group"]%></td>
  <td class=xl35 width=120 style='border-top:none;border-left:none;width:90pt'
 ><%=dt.Rows[i]["ref_po_no"]%></td>
  <td class=xl35 width=140 style='border-top:none;border-left:none;width:105pt'
  ><%=dt.Rows[i]["style_id"]%></td>
  <td class=xl36 width=100 style='border-top:none;border-left:none;width:75pt'><%=dt.Rows[i]["spec"]%></td>
  <td class=xl37 width=90 style='border-top:none;border-left:none;width:68pt'
  x:num><%=dt.Rows[i]["line_target_qty"]%> </td>
  <td class=xl38 width=90 style='border-top:none;border-left:none;width:68pt'
  x:num><%=dt.Rows[i]["today_target_qty"]%> </td>
  <td class=xl37 width=90 style='border-top:none;border-left:none;width:68pt'
  x:num><%=dt.Rows[i]["prod_qty"]%> </td>
  <td class=xl39 width=90 style='border-top:none;border-left:none;width:68pt'
  x:num><%=dt.Rows[i]["bal_qty"]%></td>
 </tr>
 <%
 }
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=8 style='height:13.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=60 style='width:45pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
