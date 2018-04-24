<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
%>

<%
    string master_pk = "";
    master_pk = Request.QueryString["master_pk"];

    DataTable dt = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsep00030_st", master_pk);
    
%>
 
 
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsep00030_st_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsep00030_st_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsep00030_st_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>QuangNguyen</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2010-03-25T05:54:13Z</o:LastPrinted>
  <o:Created>2010-03-25T02:50:57Z</o:Created>
  <o:LastSaved>2010-03-26T04:25:41Z</o:LastSaved>
  <o:Company>VinaGenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.24in .19in .2in .17in;
	mso-header-margin:.25in;
	mso-footer-margin:.18in;
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
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
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
	font-size:8.0pt;
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
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
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$2:$I$2</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1030 style='border-collapse:
 collapse;table-layout:fixed;width:773pt'>
 <col class=xl25 width=120 span=2 style='mso-width-source:userset;mso-width-alt:
 4388;width:90pt'>
 <col class=xl25 width=210 style='mso-width-source:userset;mso-width-alt:7680;
 width:158pt'>
 <col class=xl25 width=100 span=5 style='mso-width-source:userset;mso-width-alt:
 3657;width:75pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=9 height=30 class=xl32 width=1030 style='height:22.5pt;
  width:773pt'>Packing List</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt;border-top:none'>Box ID</td>
  <td class=xl24 style='border-top:none;border-left:none'>Style Code</td>
  <td class=xl24 style='border-top:none;border-left:none'>Style name</td>
  <td class=xl24 style='border-top:none;border-left:none'>Spec 01</td>
  <td class=xl24 style='border-top:none;border-left:none'>Spec 02</td>
  <td class=xl24 style='border-top:none;border-left:none'>Spec 03</td>
  <td class=xl24 style='border-top:none;border-left:none'>Spec 04</td>
  <td class=xl24 style='border-top:none;border-left:none'>Spec 05</td>
  <td class=xl24 style='border-top:none;border-left:none'>Qty</td>
 </tr>
 
  
 <tr class=xl26 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl29 style='height:13.5pt;border-top:none'>qwwdqwr</td>
  <td colspan=8 class=xl33 style='border-right:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr class=xl26 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl30 style='height:13.5pt;border-top:none'>wqr</td>
  <td colspan=8 class=xl35 style='border-right:.5pt solid black'>&nbsp;</td>
 </tr>
 <%
     string item_bc = "";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
  %>
 <tr class=xl26 height=18 style='mso-height-source:userset;height:13.5pt'>
    <%
       if ( item_bc != dt.Rows[i]["item_bc"].ToString() )
       {
           item_bc = dt.Rows[i]["item_bc"].ToString();
     %>
  <td height=18 class=xl31 style='height:13.5pt;border-top:none' rowspan=<%=dt.Rows[i]["pack_count"].ToString()%> ><%=dt.Rows[i]["item_bc"].ToString()%></td>
  <%
      }
      
   %>  
   
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["style_code"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["style_name"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec01"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec02"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec03"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec04"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec05"].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i]["qty"].ToString()%></td>
 </tr>
 <%
     }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=120 style='width:90pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=210 style='width:158pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
