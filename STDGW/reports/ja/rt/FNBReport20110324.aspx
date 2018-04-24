<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p1= Request.QueryString["dtfr"];
	string p2= Request.QueryString["dtTo"];
	string l_parameter = "'" +  p1 + "','" + p2 + "'";
	
	DataTable dt;
    dt = ESysLib.TableReadOpenCursor("crm.sp_sel_jart00060_rpt_session",l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="F_B%20Report_files/filelist.xml">
<link rel=Edit-Time-Data href="F_B%20Report_files/editdata.mso">
<link rel=OLE-Object-Data href="F_B%20Report_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Le Huu Phuc</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-03-24T09:54:41Z</o:LastPrinted>
  <o:Created>2011-03-24T09:08:34Z</o:Created>
  <o:LastSaved>2011-03-24T09:54:49Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in 0in 0in 0in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	font-weight:700;
	text-align:center;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;}
.xl67
	{mso-style-parent:style0;
	text-align:right;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style43;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-rotate:-90;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-rotate:-90;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-rotate:-90;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-rotate:-90;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-rotate:-90;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-rotate:-90;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-rotate:-90;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-rotate:-90;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-rotate:-90;}
.xl81
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	text-align:center;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-rotate:-90;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>35</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11640</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>315</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=699 style='border-collapse:
 collapse;table-layout:fixed;width:524pt'>
 <col class=xl66 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col class=xl69 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl67 width=115 span=5 style='mso-width-source:userset;mso-width-alt:
 4205;width:86pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 width=34 style='height:15.0pt;width:26pt'></td>
  <td width=38 style='width:29pt'></td>
  <td class=xl69 width=52 style='width:39pt'></td>
  <td class=xl67 width=115 style='width:86pt'></td>
  <td class=xl67 width=115 style='width:86pt'></td>
  <td class=xl67 width=115 style='width:86pt'></td>
  <td class=xl67 width=115 style='width:86pt'></td>
  <td class=xl67 width=115 style='width:86pt'></td>
 </tr>
 <tr height=38 style='height:28.5pt'>
  <td colspan=8 height=38 class=xl81 style='height:28.5pt'>F&amp;B REPORT</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=5 height=27 class=xl82 style='height:20.25pt'><%=dt.Rows[0][0]%></td>
  <td class=xl70>&nbsp;</td>
  <td colspan=2 class=xl83><%=dt.Rows[0][1]%></td>
 </tr>
 <tr class=xl69 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=3 height=31 class=xl68 style='height:23.25pt'>Outlet</td>
  <td class=xl68 style='border-top:none;border-left:none'>Hotel</td>
  <td class=xl68 style='border-top:none;border-left:none'>Club House</td>
  <td class=xl68 style='border-top:none;border-left:none'>Academy</td>
  <td class=xl68 style='border-top:none;border-left:none'>Teahouse 1</td>
  <td class=xl68 style='border-top:none;border-left:none'>Teehouse 2</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=2 rowspan=5 height=160 class=xl75 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:120.0pt'>Total</td>
  <td class=xl68 style='border-top:none;border-left:none'>Food</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][3]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][3]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][3]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][3]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][3]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Bever</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][4]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][4]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][4]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][4]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][4]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Other</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][5]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][5]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][5]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][5]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][5]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Total</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][6]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][6]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][6]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][6]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][6]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Cover</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][7]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][7]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][7]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][7]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][7]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=5 height=160 class=xl84 style='height:120.0pt;border-top:none'>Breakfash</td>
  <td rowspan=5 class=xl84 style='border-top:none'>6.00 AM - 11.00 AM</td>
  <td class=xl68 style='border-top:none;border-left:none'>Food</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][8]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][8]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][8]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][8]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][8]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Bever</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][9]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][9]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][9]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][9]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][9]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Other</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][10]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][10]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][10]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][10]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][10]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Total</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][11]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][11]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][11]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][11]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][11]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Cover</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][12]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][12]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][12]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][12]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][12]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=5 height=160 class=xl72 style='border-bottom:.5pt solid black;
  height:120.0pt;border-top:none'>Lunch</td>
  <td rowspan=5 class=xl72 style='border-bottom:.5pt solid black;border-top:
  none'>11.00 AM - 4.00 PM</td>
  <td class=xl68 style='border-top:none;border-left:none'>Food</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][13]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][13]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][13]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][13]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][13]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Bever</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][14]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][14]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][14]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][14]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][14]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Other</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][15]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][15]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][15]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][15]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][15]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Total</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][16]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][16]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][16]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][16]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][16]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Cover</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][17]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][17]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][17]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][17]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][17]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=5 height=160 class=xl72 style='border-bottom:.5pt solid black;
  height:120.0pt;border-top:none'>Dinner</td>
  <td rowspan=5 class=xl72 style='border-bottom:.5pt solid black;border-top:
  none'>4.00 PM - 10.00 PM</td>
  <td class=xl68 style='border-top:none;border-left:none'>Food</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][18]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][18]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][18]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][18]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][18]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Bever</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][19]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][19]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][19]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][19]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][19]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Other</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][20]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][20]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][20]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][20]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][20]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Total</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][21]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][21]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][21]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][21]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][21]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Cover</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][22]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][22]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][22]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][22]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][22]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=5 height=160 class=xl72 style='border-bottom:.5pt solid black;
  height:120.0pt;border-top:none'>Night</td>
  <td rowspan=5 class=xl72 style='border-bottom:.5pt solid black;border-top:
  none'>10.00 PM - 6.00 AM</td>
  <td class=xl68 style='border-top:none;border-left:none'>Food</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][23]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][23]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][23]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][23]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][23]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Bever</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][24]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][24]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][24]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][24]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][24]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Other</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][25]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][25]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][25]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][25]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][25]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Total</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][26]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][26]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][26]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][26]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][26]%></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl68 style='height:24.0pt;border-top:none;border-left:
  none'>Cover</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[0][27]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[1][27]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[2][27]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[3][27]%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt.Rows[4][27]%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 style='height:15.0pt'></td>
  <td></td>
  <td class=xl69></td>
  <td colspan=5 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 style='height:15.0pt'></td>
  <td></td>
  <td colspan=2 class=xl69>Prepared by:</td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl65>Approved by:</td>
  <td class=xl67></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
