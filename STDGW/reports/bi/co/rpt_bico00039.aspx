﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
    
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string from_date = Request.QueryString["p_from_date"];
    string to_date = Request.QueryString["p_to_date"];
    DataTable dt, dt1;
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM comm.tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM comm.tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    dt = ESysLib.TableReadOpen(str_sql);
    dt1 = ESysLib.TableReadOpenCursor("INV.sp_rpt_bico00039", "'" + from_date + "','" + to_date + "'"); 
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bico00039_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bico00039_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bico00039_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2012-01-18T09:37:04Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2012-01-18T09:38:31Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .25in .43in .25in;
	mso-header-margin:0in;
	mso-footer-margin:.11in;}
.font5
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font7
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font14
	{color:black;
	font-size:8.0pt;
	font-weight:400;
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
.style21
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
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
	padding:0px;
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
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt dashed windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
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
     <x:DefaultRowHeight>210</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>93</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
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
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$6:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=755 style='border-collapse:
 collapse;table-layout:fixed;width:565pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl25 width=115 span=5 style='mso-width-source:userset;mso-width-alt:
 4205;width:86pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 width=80 style='height:15.0pt;width:60pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:2.25pt;margin-top:4.5pt;width:54.75pt;height:33.75pt;z-index:1'>
   <v:imagedata src="rpt_bico00039_files/image001.jpg" o:title="vinagenuwin"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:6px;width:73px;
  height:45px'><img width=73 height=45 src="rpt_bico00039_files/image003.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl26 width=80 style='height:15.0pt;width:60pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 width=100 style='width:75pt'><%=dt.Rows[0]["partner_name"] %></td>
  <td class=xl27 width=115 style='width:86pt'></td>
  <td class=xl25 width=115 style='width:86pt'></td>
  <td colspan=3 class=xl29 width=345 style='width:258pt'>Tel: <%=dt.Rows[0]["phone_no"] %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0]["addr1"] %></td>
  <td class=xl25></td>
  <td colspan=3 class=xl29 width=345 style='width:258pt'>Fax: <%=dt.Rows[0]["fax_no"] %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'>Tax code: <%=dt.Rows[0]["tax_code"] %></td>
  <td class=xl25></td>
  <td colspan=3 class=xl30 width=345 style='width:258pt'>Print date :
  <%=DateTime.Now.ToString("dd/MM/yyyy HH:mm")%></td>
 </tr>
 <tr height=80 style='mso-height-source:userset;height:60.0pt'>
  <td colspan=7 height=80 class=xl31 width=755 style='height:60.0pt;width:565pt'>BÁO
  CÁO CHI PHÍ<br>
    <font class="font9">( COST REPORT )</font></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=4 height=40 class=xl32 style='height:30.0pt'>Ngày ( <font
  class="font10">Date</font><font class="font5"> ) :</font><font class="font11">
  </font><font class="font12"><%=from_date.Substring(6,2)%>/<%=from_date.Substring(4,2)%>/<%=from_date.Substring(0,4)%> - <%=to_date.Substring(6,2)%>/<%=to_date.Substring(4, 2)%>/<%=to_date.Substring(0, 4)%></font></td>
  <td colspan=3 class=xl32>Lo&#7841;i ti&#7873;n ( <font class="font10">CCY</font><font
  class="font5"> ) :</font><font class="font11"> </font><font class="font12">USD</font></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 rowspan=2 height=65 class=xl48 width=180 style='height:48.75pt;
  width:135pt'>Tháng<br>
    <font class="font7">Month</font></td>
  <td rowspan=2 class=xl48 width=115 style='border-top:none;width:86pt'>Doanh
  thu<font class="font14"><br>
    </font><font class="font7">Revenue</font></td>
  <td colspan=3 class=xl48 width=345 style='border-left:none;width:258pt'>Chi
  phí <font class="font7">Cost</font></td>
  <td rowspan=2 class=xl48 width=115 style='border-top:none;width:86pt'>S&#7889;
  d&#432;<br>
    <font class="font7"><span style='mso-spacerun:yes'> </span>Income</font></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl48 width=115 style='height:30.0pt;border-top:none;
  border-left:none;width:86pt'>NVL<br>
    <font class="font7">Material</font></td>
  <td class=xl48 width=115 style='border-top:none;border-left:none;width:86pt'>Nhân
  công<br>
    <font class="font7">Labour</font></td>
  <td class=xl48 width=115 style='border-top:none;border-left:none;width:86pt'>Chi
  phí khác <font class="font7"><br>
    Others</font></td>
 </tr>
 <%
     double total1 = 0, total2 = 0, total3 = 0, total4 = 0, total5 = 0;
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         total1 = total1 + CommondLib.ConvertToDbl(dt1.Rows[i]["income_amt"]);
         total2 = total2 + CommondLib.ConvertToDbl(dt1.Rows[i]["mat_amt"]);
         total3 = total3 + CommondLib.ConvertToDbl(dt1.Rows[i]["hr_amt"]);
         total4 = total4 + CommondLib.ConvertToDbl(dt1.Rows[i]["others_amt"]);
         total5 = total5 + CommondLib.ConvertToDbl(dt1.Rows[i]["total_amt"]);
         %>
<tr class=xl33 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=2 height=40 class=xl40 width=180 style='height:30.0pt;width:135pt'><%=dt1.Rows[i]["tr_month"]%></td>
  <td class=xl42 width=115 style='border-top:none;border-left:none;width:86pt'x:num><%=dt1.Rows[i]["income_amt"]%></td>
  <td class=xl42 width=115 style='border-top:none;border-left:none;width:86pt'x:num><%=dt1.Rows[i]["mat_amt"]%></td>
  <td class=xl42 width=115 style='border-top:none;border-left:none;width:86pt'x:num><%=dt1.Rows[i]["hr_amt"]%></td>
  <td class=xl42 width=115 style='border-top:none;border-left:none;width:86pt'x:num><%=dt1.Rows[i]["others_amt"]%></td>
  <td class=xl43 width=115 style='border-top:none;border-left:none;width:86pt'x:num><%=dt1.Rows[i]["total_amt"]%></td>
 </tr>
         <% 
     }
      %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl49 style='height:22.5pt'>Grand Total</td>
  <td class=xl34 width=115 style='border-top:none;border-left:none;width:86pt'
  x:num><%=total1 %></td>
  <td class=xl34 width=115 style='border-top:none;border-left:none;width:86pt'
  x:num><%=total2 %></td>
  <td class=xl34 width=115 style='border-top:none;border-left:none;width:86pt'
  x:num><%=total3 %></td>
  <td class=xl34 width=115 style='border-top:none;border-left:none;width:86pt'
  x:num><%=total4 %></td>
  <td class=xl35 width=115 style='border-top:none;border-left:none;width:86pt'
  x:num><%=total5 %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=80 style='width:60pt'></td>
  <td width=100 style='width:75pt'></td>
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
