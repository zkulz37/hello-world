<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string _from_date    = Request.QueryString["from_dt"];
	string _to_date      = Request.QueryString["to_dt"];
	string _factory_pk   = Request.QueryString["factory_pk"];	
	string _factory_name = Request.QueryString["factory_name"];	
	string _para = " '" + _factory_pk + "','" + _from_date + "','" + _to_date + "'";

    DataTable dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00081", _para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00081_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00081_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00081_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2012-02-14T07:18:03Z</o:LastPrinted>
  <o:Created>2012-02-13T04:20:10Z</o:Created>
  <o:LastSaved>2012-02-14T07:18:50Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.31in .31in .28in .26in;
	mso-header-margin:.28in;
	mso-footer-margin:.24in;}
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
.xl65
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
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
      <x:Scale>98</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$3:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=715 style='border-collapse:
 collapse;table-layout:fixed;width:536pt'>
 <col class=xl65 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl65 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl65 width=140 style='mso-width-source:userset;mso-width-alt:5120;
 width:105pt'>
 <col class=xl65 width=80 span=5 style='mso-width-source:userset;mso-width-alt:
 2925;width:60pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=8 height=40 class=xl75 width=715 style='height:30.0pt;width:536pt'>Daily
  Production Report</td>
 </tr>
 <tr class=xl66 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl70 style='height:15.0pt'>Fac</td>
  <td colspan=4 class=xl77><%=_factory_name %></td>
  <td class=xl70>Date</td>
  <td colspan=2 class=xl76><%=_from_date.Substring(6,2) %>/<%=_from_date.Substring(4,2) %>/<%=_from_date.Substring(0,4) %> - <%=_to_date.Substring(6,2) %>/<%=_to_date.Substring(4, 2)%>/<%=_to_date.Substring(0, 4)%></td>
 </tr>
 <tr class=xl68 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl67 style='height:18.75pt'>Line</td>
  <td class=xl67 style='border-top:none;border-left:none'>P/O</td>
  <td class=xl67 style='border-top:none;border-left:none'>Style</td>
  <td class=xl67 style='border-top:none;border-left:none'>Spec 01</td>
  <td class=xl67 style='border-top:none;border-left:none'>Spec 02</td>
  <td class=xl67 style='border-left:none'>Spec 03</td>
  <td class=xl67 style='border-top:none;border-left:none'>Prod Qty</td>
  <td class=xl67 style='border-top:none;border-left:none'>Def Qty</td>
 </tr>
 <%
     string line_group = "";
     double tot1 = 0, tot2 = 0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         tot1 = tot1 + CommondLib.ConvertToDbl(dt.Rows[i]["prod_qty"]);
         tot2 = tot2 + CommondLib.ConvertToDbl(dt.Rows[i]["defect_qty"]);
         if (line_group != dt.Rows[i]["line_group"].ToString())
         {
             %>
<tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=8 height=25 class=xl81 style='border-right:.5pt solid black;
  height:18.75pt'><%=dt.Rows[i]["line_group"] %></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl72 style='height:18.75pt;border-top:none'><%=dt.Rows[i]["line"] %></td>
  <td class=xl73 style='border-top:none;border-left:none'><%=dt.Rows[i]["ref_po_no"] %></td>
  <td class=xl72 style='border-top:none;border-left:none'><%=dt.Rows[i]["style_name"] %></td>
  <td class=xl69 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec01"] %></td>
  <td class=xl69 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec02"] %></td>
  <td class=xl69 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec03"] %></td>
  <td class=xl74 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["prod_qty"] %></td>
  <td class=xl74 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["defect_qty"] %></td>
 </tr>
             <% 
             line_group = dt.Rows[i]["line_group"].ToString();
         }
         else
         {
             %>
<tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl72 style='height:18.75pt;border-top:none'><%=dt.Rows[i]["line"] %></td>
  <td class=xl73 style='border-top:none;border-left:none'><%=dt.Rows[i]["ref_po_no"] %></td>
  <td class=xl72 style='border-top:none;border-left:none'><%=dt.Rows[i]["style_name"] %></td>
  <td class=xl69 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec01"] %></td>
  <td class=xl69 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec02"] %></td>
  <td class=xl69 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec03"] %></td>
  <td class=xl74 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["prod_qty"] %></td>
  <td class=xl74 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["defect_qty"] %></td>
 </tr>
             <%
         }
     } 
  %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=6 height=25 class=xl78 style='border-right:.5pt solid black;
  height:18.75pt'>Total</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=tot1 %></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=tot2 %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=80 style='width:60pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
