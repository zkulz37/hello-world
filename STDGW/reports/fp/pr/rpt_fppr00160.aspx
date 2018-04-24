<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%    
	string p_master_pk = Request.QueryString["master_pk"];
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fppr00160_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fppr00160_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fppr00160_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2011-03-18T07:45:12Z</o:LastPrinted>
  <o:Created>2011-03-16T09:02:31Z</o:Created>
  <o:LastSaved>2011-03-18T07:54:08Z</o:LastSaved>
  <o:Company>Prive</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.34in .25in .26in .25in;
	mso-header-margin:.27in;
	mso-footer-margin:.22in;
	mso-page-orientation:landscape;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:10.0pt;
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
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
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
	border-left:none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
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
	color:red;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>18075</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=910 style='border-collapse:
 collapse;table-layout:fixed;width:686pt'>
 <col class=xl24 width=90 span=2 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <col class=xl24 width=220 style='mso-width-source:userset;mso-width-alt:8045;
 width:165pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=70 span=5 style='mso-width-source:userset;mso-width-alt:
 2560;width:53pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>

 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=7 rowspan=2 height=60 class=xl42 width=690 style='border-right:
  .5pt solid black;height:45.0pt;width:520pt'>Warehouse Daily Closing</td>
  <td class=xl26 width=70 style='width:53pt'>PH&#7908; TRÁCH</td>
  <td class=xl26 width=70 style='width:53pt'>PHÓ G&#272; X&#431;&#7902;NG</td>
  <td class=xl26 width=80 style='width:60pt'>G&#272; X&#431;&#7902;NG</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 width=70 style='height:15.0pt;width:53pt'>&#45812;&#45817;</td>
  <td class=xl27 width=70 style='width:53pt'>&#51452;&#44288;</td>
  <td class=xl27 width=80 style='width:60pt'>&#44277;&#51109;&#51109;</td>
 </tr>
 
<%   
     string para = " '" + p_master_pk + "' ";
     DataTable dt;
     dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_fppr00160_1", para);
			         
     for (int i = 0; i < dt.Rows.Count; i++)
     {      
%>

 <tr height=57 style='mso-height-source:userset;height:42.75pt'>
  <td colspan=4 height=57 class=xl44 width=480 style='height:42.75pt;
  width:361pt'>W/H<font class="font0">: </font><font class="font8"><%=dt.Rows[i]["warehouse"].ToString()%><span
  style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></font><font class="font7">Stock
  Date</font><font class="font8"> </font><font class="font9">:</font><font
  class="font8"><%=dt.Rows[i]["stock_date"].ToString()%></font></td>
  <td colspan=3 class=xl45 width=210 style='border-right:.5pt solid black;
  width:159pt'>Print Date : <%=dt.Rows[i]["print_date"].ToString()%></td>
  <td class=xl28 width=70 style='width:53pt'>&nbsp;</td>
  <td class=xl28 width=70 style='width:53pt'>&nbsp;</td>
  <td class=xl28 width=80 style='width:60pt'>&nbsp;</td>
 </tr>
 
<%
 	}
%>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=6 class=xl25 style='height:11.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl47 width=210 style='width:159pt'>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl29 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl30 width=90 style='height:18.75pt;width:68pt'>PO</td>
  <td class=xl31 width=90 style='width:68pt'>Style</td>
  <td class=xl31 width=220 style='width:165pt'>Component ID-Name</td>
  <td class=xl31 width=80 style='width:60pt'>Spec</td>
  <td class=xl32 width=70 style='width:53pt'>Begin</td>
  <td class=xl32 width=70 style='width:53pt'>In</td>
  <td class=xl33 width=70 style='width:53pt'>Out</td>
  <td class=xl34 width=70 style='width:53pt'>Adjust</td>
  <td class=xl33 width=70 style='width:53pt'>End</td>
  <td class=xl35 width=80 style='width:60pt'>Remark</td>
 </tr>
 
 <%    
     dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_fppr00160_2", para);
			         
     for (int i = 0; i < dt.Rows.Count; i++)
     {      
%>

 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl36 width=90 style='height:15.0pt;width:68pt'><%=dt.Rows[i]["ref_po_no"].ToString()%></td>
  <td class=xl37 width=90 style='width:68pt'><%=dt.Rows[i]["style"].ToString()%></td>
  <td class=xl37 width=220 style='width:165pt'><%=dt.Rows[i]["component"].ToString()%></td>
  <td class=xl37 width=80 style='width:60pt'><%=dt.Rows[i]["spec"].ToString()%></td>
  <td class=xl38 align=right width=70 style='width:53pt' x:num><%=dt.Rows[i]["begin_qty"].ToString()%></td>
  <td class=xl38 align=right width=70 style='width:53pt' x:num><%=dt.Rows[i]["in_qty"].ToString()%></td>
  <td class=xl38 align=right width=70 style='width:53pt' x:num><%=dt.Rows[i]["out_qty"].ToString()%></td>
  <td class=xl39 align=right width=70 style='width:53pt' x:num><%=dt.Rows[i]["adj_qty"].ToString()%></td>
  <td class=xl39 align=right width=70 style='width:53pt' x:num><%=dt.Rows[i]["end_qty"].ToString()%></td>
  <td class=xl37 width=80 style='width:60pt'><%=dt.Rows[i]["description"].ToString()%></td>
 </tr>
 <%
 	  }
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl36 width=90 style='height:15.0pt;width:68pt'>&nbsp;</td>
  <td class=xl37 width=90 style='width:68pt'>&nbsp;</td>
  <td class=xl37 width=220 style='width:165pt'>&nbsp;</td>
  <td class=xl37 width=80 style='width:60pt'>&nbsp;</td>
  <td class=xl40 width=70 style='width:53pt'>&nbsp;</td>
  <td class=xl40 width=70 style='width:53pt'>&nbsp;</td>
  <td class=xl40 width=70 style='width:53pt'>&nbsp;</td>
  <td class=xl41 width=70 style='width:53pt'>&nbsp;</td>
  <td class=xl40 width=70 style='width:53pt'>&nbsp;</td>
  <td class=xl37 width=80 style='width:60pt'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=220 style='width:165pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
