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
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00110_standard_po");
	string p_po_pk	=	Request.QueryString["p_po_pk"];
    dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00110_1_standard_po", "'" + p_po_pk + "'");
    dt2 = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00110_2_standard_po", "'" + p_po_pk + "'");
    string str = CommondLib.Num2EngText(dt1.Rows[0]["total_amt"].ToString(),"USD");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00110_ST_PO_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="mau don hang_12796_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl2412796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2512796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2612796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2712796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2812796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2912796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3012796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3112796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3212796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3312796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3412796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3512796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3612796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3712796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3812796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3912796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4012796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4112796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4212796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4312796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4412796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4512796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4612796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4712796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4812796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4912796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5012796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5112796
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="mau don hang_12796" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=829 class=xl2412796
 style='border-collapse:collapse;table-layout:fixed;width:624pt'>
 <col class=xl2412796 width=54 style='mso-width-source:userset;mso-width-alt:
 1536;width:41pt'>
 <col class=xl2412796 width=118 style='mso-width-source:userset;mso-width-alt:
 3356;width:89pt'>
 <col class=xl2412796 width=123 style='mso-width-source:userset;mso-width-alt:
 3498;width:92pt'>
 <col class=xl2412796 width=102 style='mso-width-source:userset;mso-width-alt:
 2901;width:77pt'>
 <col class=xl2412796 width=46 style='mso-width-source:userset;mso-width-alt:
 1308;width:35pt'>
 <col class=xl2412796 width=61 style='mso-width-source:userset;mso-width-alt:
 1735;width:46pt'>
 <col class=xl2412796 width=99 style='mso-width-source:userset;mso-width-alt:
 2816;width:74pt'>
 <col class=xl2412796 width=108 style='mso-width-source:userset;mso-width-alt:
 3072;width:81pt'>
 <col class=xl2412796 width=118 style='mso-width-source:userset;mso-width-alt:
 3356;width:89pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=8 height=20 width=711 style='height:15.0pt;width:535pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
   margin-left:0;margin-top:3.75pt;width:81pt;height:40.5pt;z-index:1'
   filled="t" fillcolor="white [9]">
   <v:imagedata src="rpt_epbp00110_ST_PO_files/mau%20don%20hang_12796_image001.jpg"
    o:title="Logo-mr chau" cropbottom="37277f" cropright="33128f"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:Locked>False</x:Locked>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:5px;width:108px;
  height:54px'><img width=108 height=54
  src="rpt_epbp00110_ST_PO_files/mau%20don%20hang_12796_image002.gif" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=8 height=20 class=xl4812796 width=711 style='height:15.0pt;
    width:535pt'>BK VINA CO., LTD</td>
   </tr>
  </table>
  </span></td>
  <td class=xl2412796 width=118 style='width:89pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=8 height=20 class=xl4912796 style='height:15.0pt'>LOT A-5C-CN, MY
  PHUOC 3 I.P., BEN CAT DIST., BINH DUONG PROVINCE, VIETNAM</td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=8 height=20 class=xl5012796 style='height:15.0pt'>TEL:
  84-650-559825<span style='mso-spacerun:yes'>     </span>FAX:
  84-650-559831<span style='mso-spacerun:yes'>     </span>TAX CODE: 3700798566</td>
  <td class=xl2412796></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl2412796 style='height:14.25pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=8 height=24 class=xl5112796 style='height:18.0pt'>PURCHASE ORDER</td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 style='height:15.0pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796>NO.:</td>
  <td class=xl2412796 colspan=2><%=dt1.Rows[0]["po_no"]%></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 style='height:15.0pt'></td>
  <td class=xl2412796></td>
  <td class=xl2512796></td>
  <td class=xl2512796></td>
  <td class=xl2412796></td>
  <td class=xl2412796>DATE:</td>
  <td class=xl2612796 align=right x:num="39617">18-Jun-08</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl2412796 style='height:14.25pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796 colspan=2>PURCHASER: MS.NHAÕ</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2712796 style='height:15.0pt'>Messrs:</td>
  <td class=xl2512796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2512796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl2412796 style='height:14.25pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl2412796 style='height:12.0pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=7 style='height:15.0pt'>We've the
  pleasure of placing the following orders with you on the terms and conditions
  stated below:</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr class=xl3012796 height=42 style='height:31.5pt'>
  <td height=42 class=xl2812796 style='height:31.5pt'>No.</td>
  <td class=xl2812796 style='border-left:none'>Description</td>
  <td class=xl2812796 style='border-left:none'>Specification</td>
  <td class=xl2812796 style='border-left:none'>Packing</td>
  <td class=xl2812796 style='border-left:none'>Unit</td>
  <td class=xl2812796 style='border-left:none'>Quantity</td>
  <td class=xl2912796 width=99 style='border-left:none;width:74pt'>Unit
  Price<br>
    (VND)</td>
  <td class=xl2912796 width=108 style='border-left:none;width:81pt'>Amount<br>
    (VND)</td>
  <td class=xl3012796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt' x:num>1</td>
  <td class=xl3212796 style='border-left:none'>PE - 6002</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl4312796 align=right style='border-left:none' x:num>10.05</td>
  <td class=xl3712796 style='border-left:none' x:num="10000.88"><span
  style='mso-spacerun:yes'>            </span>10,000.88 </td>
  <td class=xl3412796 style='border-left:none' x:num="100508.844"
  x:fmla="=F14*G14"><span style='mso-spacerun:yes'>                 
  </span>100,509 </td>
  <td class=xl3512796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3412796 style='border-left:none'>&nbsp;</td>
  <td class=xl3412796 style='border-left:none'>&nbsp;</td>
  <td class=xl3512796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3412796 style='border-left:none'>&nbsp;</td>
  <td class=xl3412796 style='border-left:none'>&nbsp;</td>
  <td class=xl3512796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl2412796></td>
  <td class=xl3212796>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3412796 style='border-left:none'>&nbsp;</td>
  <td class=xl3412796 style='border-left:none'>&nbsp;</td>
  <td class=xl3612796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3612796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3612796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl3112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3212796 style='border-left:none'>&nbsp;</td>
  <td class=xl3112796 style='border-left:none'>&nbsp;</td>
  <td class=xl3312796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl3712796 style='border-left:none'>&nbsp;</td>
  <td class=xl2412796></td>
 </tr>
 <tr class=xl2512796 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl4512796 style='border-right:.5pt solid black;
  height:15.0pt'>Total</td>
  <td class=xl3812796 style='border-left:none'>&nbsp;</td>
  <td class=xl4412796 align=right style='border-left:none' x:num
  x:fmla="=SUM(F14:F25)">10.05</td>
  <td class=xl3912796 style='border-left:none'>&nbsp;</td>
  <td class=xl4012796 style='border-left:none' x:num="100508.844"
  x:fmla="=SUM(H14:H25)"><span style='mso-spacerun:yes'>                   
  </span>100,509 </td>
  <td class=xl2512796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2512796 colspan=8 style='height:15.0pt'>Say Total:
  VIETNAM DONGS THIRTY FOUR MILLIONS<span style='mso-spacerun:yes'> 
  </span>NINE HUNDRED THIRTY EIGHT<span style='mso-spacerun:yes'> 
  </span>THOUSAND ONLY***</td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2512796 colspan=5 style='height:15.0pt'>(The above
  prices is including transportation, but excluding 5% VAT )</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=3 style='height:15.0pt'>1. QUALITY:
  EXPORT STANDARD</td>
  <td class=xl2512796></td>
  <td rowspan=9 height=180 class=xl2412796 width=46 style='mso-ignore:colspan-rowspan;
  height:135.0pt;width:35pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t88"
   coordsize="21600,21600" o:spt="88" adj="1800,10800" path="m,qx10800@0l10800@2qy21600@11,10800@3l10800@1qy,21600e"
   filled="f">
   <v:formulas>
    <v:f eqn="val #0"/>
    <v:f eqn="sum 21600 0 #0"/>
    <v:f eqn="sum #1 0 #0"/>
    <v:f eqn="sum #1 #0 0"/>
    <v:f eqn="prod #0 9598 32768"/>
    <v:f eqn="sum 21600 0 @4"/>
    <v:f eqn="sum 21600 0 #1"/>
    <v:f eqn="min #1 @6"/>
    <v:f eqn="prod @7 1 2"/>
    <v:f eqn="prod #0 2 1"/>
    <v:f eqn="sum 21600 0 @9"/>
    <v:f eqn="val #1"/>
   </v:formulas>
   <v:path arrowok="t" o:connecttype="custom" o:connectlocs="0,0;21600,@11;0,21600"
    textboxrect="0,@4,7637,@5"/>
   <v:handles>
    <v:h position="center,#0" yrange="0,@8"/>
    <v:h position="bottomRight,#1" yrange="@9,@10"/>
   </v:handles>
  </v:shapetype><v:shape id="_x0000_s1028" type="#_x0000_t88" style='position:absolute;
   margin-left:3pt;margin-top:3pt;width:12pt;height:117.75pt;z-index:2'
   fillcolor="window [65]" strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=3 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=18 height=159
    src="rpt_epbp00110_ST_PO_files/mau%20don%20hang_12796_image003.gif" v:shapes="_x0000_s1028"></td>
    <td width=25></td>
   </tr>
   <tr>
    <td height=18></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:34.5pt;height:135.0pt'></span><![endif]--></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=2 style='height:15.0pt'>2. DELIVERY
  TERMS: N/M</td>
  <td class=xl2512796></td>
  <td class=xl2512796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=2 style='height:15.0pt'>3. SHIP BY:
  TRUCK</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=4 style='height:15.0pt'>4. PLACE OF
  DELIVERY: AT BK VINA CO.LTD ' S WAREHOUSE</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=3 style='height:15.0pt'>5. TIME OF
  DELIVERY: 18/06/2008</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=2 style='height:15.0pt'>6.
  TRANSHIPMENT: N/M</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=3 style='height:15.0pt'>7. PARTIAL
  SHIPMENT: PROHIBITED</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=3 style='height:15.0pt'>8. PAYMENT
  TERMS: T/T AFTER 30 DAYS</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2412796 style='height:15.0pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=3 style='height:15.0pt'>Please notify
  us immediately if this order</td>
  <td class=xl2412796></td>
  <td class=xl2412796 colspan=3>We accept to sell the above goods</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=3 style='height:15.0pt'>can not be
  shipped complete on or before</td>
  <td class=xl2412796></td>
  <td class=xl2412796 colspan=3>with the specifications, prices and</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl4112796 style='height:15.0pt'>&nbsp;</td>
  <td class=xl4112796>&nbsp;</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796 colspan=3>delivery time as this order.</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl2412796 style='height:14.25pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl2412796 colspan=3 style='height:14.25pt'>For and on
  behalf of THE BUYER</td>
  <td class=xl2412796></td>
  <td class=xl2412796 colspan=3>For and on behalf of THE SELLER</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl2512796 colspan=2 style='height:15.75pt'>BK VINA CO.,
  LTD</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2512796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl2412796 style='height:14.25pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl2412796 style='height:14.25pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl2412796 style='height:15.0pt'></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2512796 colspan=2 style='height:15.0pt'>LEE SOON SUB
  (MR.)</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl4212796 colspan=3>Please sign, chop and fax back to</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2412796 colspan=2 style='height:15.0pt'>General
  Director</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl4212796 colspan=2>BK VINA Co., Ltd.</td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
  <td class=xl2412796></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=54 style='width:41pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=118 style='width:89pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
