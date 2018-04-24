<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p1= Request.QueryString["p1"];
	string p2= Request.QueryString["p2"];
	string p3= Request.QueryString["p3"];
	string p4= Request.QueryString["p4"];
	string l_parameter = "'" +  p1 + "','" + p2 + "','" +  p3 + "','" +  p4 + "'";
	
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_htfo00040",l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Previews_files/filelist.xml">
<link rel=Edit-Time-Data href="Previews_files/editdata.mso">
<link rel=OLE-Object-Data href="Previews_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-01-16T03:56:10Z</o:LastPrinted>
  <o:Created>2010-11-30T08:32:49Z</o:Created>
  <o:LastSaved>2011-01-16T03:57:51Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .2in .5in .2in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
.xl24
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\@";}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"Short Date";}
.xl31
	{mso-style-parent:style0;
	text-align:left;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl42
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	text-align:left;}
.xl65
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;}
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
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>33</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>16</x:ActiveCol>
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
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$16</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2398 style='border-collapse:
 collapse;table-layout:fixed;width:1801pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=64 style='width:48pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=64 style='width:48pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=64 span=5 style='width:48pt'>
 <tr height=31 style='height:23.25pt'>
  <td height=31 width=40 style='height:23.25pt;width:30pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   margin-left:3pt;margin-top:5.25pt;width:114pt;height:46.5pt;z-index:1'>
   <v:imagedata src="Previews_files/image001.jpg" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:4px;margin-top:7px;width:152px;
  height:62px'><img width=152 height=62 src="Previews_files/image002.jpg"
  v:shapes="_x0000_s1026"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=31 width=40 style='height:23.25pt;width:30pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=64 style='width:48pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
  <td class=xl24 width=72 style='width:54pt'></td>
  <td class=xl24 width=66 style='width:50pt'></td>
  <td class=xl24 width=59 style='width:44pt'></td>
  <td width=61 style='width:46pt'></td>
  <td class=xl25 width=51 style='width:38pt'></td>
  <td class=xl25 width=34 style='width:26pt'></td>
  <td class=xl25 width=74 style='width:56pt'></td>
  <td class=xl25 width=68 style='width:51pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td class=xl24 width=47 style='width:35pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=66 style='width:50pt'></td>
  <td class=xl24 width=60 style='width:45pt'></td>
  <td class=xl25 width=57 style='width:43pt'></td>
  <td class=xl25 width=46 style='width:35pt'></td>
  <td class=xl25 width=69 style='width:52pt'></td>
  <td class=xl25 width=56 style='width:42pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td class=xl24 width=39 style='width:29pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl25 width=50 style='width:38pt'></td>
  <td class=xl25 width=43 style='width:32pt'></td>
  <td class=xl25 width=71 style='width:53pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=4 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>GUEST FOLIO</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27 x:str=""></td>
  <td></td>
  <td class=xl28></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
  <td class=xl28></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
  <td class=xl28></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=8 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>Li�n 2: Giao kh�ch h�ng</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>K� hi&#7879;u</td>
  <td class=xl28>S&#7889; :</td>
  <td class=xl28></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>Second copy : To customer</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl27>M� s&#7889; thu&#7871;<span style='display:none'> :</span></td>
  <td colspan=3 height=20 width=186 style='mso-ignore:colspan-rowspan;
  height:15.0pt;width:140pt'><!--[if gte vml 1]><v:shape id="_x0000_s1027"
   type="#_x0000_t75" style='position:absolute;margin-left:14.25pt;
   margin-top:.75pt;width:123pt;height:14.25pt;z-index:2'>
   <v:imagedata src="Previews_files/image003.jpg" o:title="0811_billform_Internal"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=19 height=1></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=164 height=19 src="Previews_files/image004.jpg" v:shapes="_x0000_s1027"></td>
    <td width=3></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:139.5pt;height:15.0pt'></span><![endif]--></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>Ng�y / Date : <%=dt.Rows[0][0]%></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 colspan=2 style='height:15.0pt;mso-ignore:colspan'
  x:str="T�N / Name : ">T�N / Name :<span style='mso-spacerun:yes'>�</span></td>
  <td></td>
  <td colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0][2]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>THU NG�N / Cashier# :</td>
  <td colspan=2 style='mso-ignore:colspan'><%=dt.Rows[0][6]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 colspan=4 style='height:15.0pt;mso-ignore:colspan'
  x:str="M� S&#7888; THU&#7870; / Tax code : ">M� S&#7888; THU&#7870; / Tax
  code :<span style='mso-spacerun:yes'>�</span></td>
  <td class=xl29><%=dt.Rows[0][4]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>NG�Y &#272;&#7870;N /
  Arrival :</td>
  <td class=xl30 align=right x:num><%=dt.Rows[0][7]%></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 colspan=3 style='height:15.0pt;mso-ignore:colspan'
  x:str="&#272;&#7882;A CH&#7880; / Address : ">&#272;&#7882;A CH&#7880; /
  Address :<span style='mso-spacerun:yes'>�</span></td>
  <td colspan=4 style='mso-ignore:colspan'><%=dt.Rows[0][3]%></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>NG�Y &#272;I / Departure
  :</td>
  <td class=xl30 align=right x:num><%=dt.Rows[0][8]%></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 colspan=3 style='height:15.0pt;mso-ignore:colspan'>S&#7888;
  PH�NG / Room# :</td>
  <td class=xl31 x:num><%=dt.Rows[0][5]%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'
  x:str="S&#7888; &#272;�M / No. Night : ">S&#7888; &#272;�M / No. Night :<span
  style='mso-spacerun:yes'>�</span></td>
  <td class=xl31 x:num><%=dt.Rows[0][13]%></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 colspan=3 style='height:15.0pt;mso-ignore:colspan'>M�
  KH / Guest code :</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'
  x:str="S&#7888; TRANG / Page# : ">S&#7888; TRANG / Page# :<span
  style='mso-spacerun:yes'>�</span></td>
  <td class=xl29>1/1</td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=40 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>STT</td>
  <td colspan=5 class=xl33>T�n h�ng h�a, d&#7883;ch v&#7909;</td>
  <td class=xl33>&#272;VT</td>
  <td class=xl33>S&#7889; l&#432;&#7907;ng</td>
  <td colspan=2 class=xl33>&#272;&#417;n gi�</td>
  <td colspan=2 class=xl33 style='border-right:1.0pt solid black'>Th�nh
  ti&#7873;n</td>
  <td colspan=24 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'>No.</td>
  <td colspan=5 class=xl35>Items</td>
  <td class=xl35>Unit</td>
  <td class=xl35>Quantity</td>
  <td colspan=2 class=xl35>Unit Price</td>
  <td colspan=2 class=xl35 style='border-right:1.0pt solid black'>Amout</td>
  <td colspan=24 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <%for (int i = 0; i < dt.Rows.Count; i++){%>
 <tr class=xl36 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl37 style='height:18.0pt' x:num><%=dt.Rows[i][10]%></td>
  <td colspan=5 class=xl57><%=dt.Rows[i][11]%></td>
  <td class=xl62><%=dt.Rows[i][12]%></td>
  <td class=xl62 x:num><%=dt.Rows[i][13]%></td>
  <td colspan=2 class=xl52 x:num><%=dt.Rows[i][14]%></td>
  <td colspan=2 class=xl52 style='border-right:1.0pt solid black'
  x:num><%=dt.Rows[i][15]%></td>
  <td class=xl61></td>
  <td colspan=5 class=xl63 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl62 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl61></td>
  <td colspan=5 class=xl63 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl62 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl38 style='height:18.0pt'>&nbsp;</td>
  <td colspan=9 class=xl49>C&#7897;ng / Sub Total</td>
  <td colspan=2 class=xl50 style='border-right:1.0pt solid black' x:num><%=dt.Rows[0][16]%></td>
  <td></td>
  <td colspan=9 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=9 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=40 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl28>Ph� d&#7883;ch v&#7909; / SVC (5%):</td>
  <td colspan=2 class=xl43 x:num><%=dt.Rows[0][17]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl28>Ti&#7873;n thu&#7871; GTGT / VAT (10%):</td>
  <td colspan=2 class=xl43 x:num><%=dt.Rows[0][18]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl28>Chi&#7871;t kh&#7845;u / Discount :</td>
  <td colspan=2 class=xl43 x:num>- <%=dt.Rows[0][20]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl28>&#272;&#7863;t c&#7885;c / Diposit :</td>
  <td colspan=2 class=xl43 x:num>- <%=dt.Rows[0][21]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl28
  x:str="T&#7893;ng c&#7897;ng ti&#7873;n thanh to�n / Total due by customer : ">T&#7893;ng
  c&#7897;ng ti&#7873;n thanh to�n / <%if(p3 == "Y"){ %>Total due by customer<% } else {%>Amount due<%}%>  :<span
  style='mso-spacerun:yes'>�</span></td>
  <td colspan=2 class=xl43 x:num><%=dt.Rows[0][19]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 x:str="T&#7927; gi� / Exchange rate (VND / USD): ">T&#7927;
  gi� / Exchange rate (VND / USD):<span style='mso-spacerun:yes'>�</span></td>
  <td colspan=2 class=xl44 x:num><%=dt.Rows[0][9]%></td>
  <td colspan=2 class=xl43><%=dt.Rows[0][23]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28>Payment method:</td>
  <td colspan=4 class=xl44></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 colspan=4 style='height:15.0pt;mso-ignore:colspan'>S&#7889;
  ti&#7873;n b&#7857;ng ch&#7919; / In word:</td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=12 height=20 class=xl46 style='height:15.0pt'><%=CommondLib.Num2VNText(dt.Rows[0][19].ToString(),"VND") %></td>
  <td colspan=24 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=7 rowspan=3 height=60 class=xl48 width=427 style='height:45.0pt;
  width:321pt'>T�i cam k&#7871;t r&#7857;ng t�i c� ngh&#297;a v&#7909; thanh
  to�n h�a &#273;&#417;n n�y. N&#7871;u m&#7897;t c� nh�n, c�ng ty<br>
    hay m&#7897; t&#7893; ch&#7913;c n�o do t�i ch&#7881; ra s&#7869; kh�ng c�
  tr�ch nhi&#7879;m thanh to�n, tr&#7915; khi<br>
    ngh&#297;a v&#7909; thanh to�n c&#7911;a t�i c� li�n &#273;&#7899;i
  t&#7899;i c� nh�n, c�ng ty hay t&#7893; ch&#7913;c &#273;�.</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=5 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=5 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=7 rowspan=3 height=60 class=xl47 width=427 style='height:45.0pt;
  width:321pt'>I agree that I am personally liable for the payment of this bill
  and if the person, company<br>
    association indicated by me as responsible for payment of the same does not
  do so,<br>
    that my liability for such payment shall be joint and several with such
  person,<br>
    company or association.</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl45 style='height:15.0pt'>Thu Ng�n/Cashier</td>
  <td></td>
  <td colspan=2 class=xl45>Kh�ch h�ng / Guest</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=12 height=20 class=xl46 style='height:15.0pt'>&nbsp;</td>
  <td colspan=24 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl41 colspan=3 style='height:15.0pt;mso-ignore:colspan'>C�ng
  ty TNHH AMB Vina</td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=13 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl41 colspan=6 style='height:15.0pt;mso-ignore:colspan'>Website:
  www.songgia.com / E-mail : marketing@songgia.com</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 colspan=7 style='height:15.0pt;mso-ignore:colspan'>Ch&#7881;
  xu&#7845;t h�a &#273;&#417;n GTGT kh�ng qu� 5 ng�y k&#7875; t&#7915; ng�y in
  bill v� ph&#7843;i c�ng th�ng.</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 colspan=7 style='height:15.0pt;mso-ignore:colspan'>Only
  issue VAT invoice less than 5 days from the date in the bill and in the same
  month.</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl40 colspan=2 style='height:12.0pt;mso-ignore:colspan'>AMB
  Vina Co., Ltd</td>
  <td colspan=34 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl40 colspan=4 style='height:12.0pt;mso-ignore:colspan'>Song
  Gia Resort Complex Golf &amp; Coutry Club</td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=3 rowspan=3 height=48 class=xl40 width=176 style='mso-ignore:
  colspan-rowspan;height:36.0pt;width:133pt'><!--[if gte vml 1]><v:shape id="_x0000_s1028"
   type="#_x0000_t75" style='position:absolute;margin-left:6pt;margin-top:9.75pt;
   width:51pt;height:25.5pt;z-index:3'>
   <v:imagedata src="Previews_files/image005.jpg" o:title="logo1"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1029" type="#_x0000_t75" style='position:absolute;
   margin-left:64.5pt;margin-top:10.5pt;width:64.5pt;height:21pt;z-index:4'>
   <v:imagedata src="Previews_files/image006.jpg" o:title="logo2"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=8 height=13></td>
    <td width=68></td>
    <td width=10></td>
    <td width=86></td>
    <td width=4></td>
   </tr>
   <tr>
    <td height=1></td>
    <td rowspan=3 align=left valign=top><img width=68 height=34
    src="Previews_files/image007.jpg" v:shapes="_x0000_s1028"></td>
   </tr>
   <tr>
    <td height=28></td>
    <td></td>
    <td align=left valign=top><img width=86 height=28
    src="Previews_files/image008.jpg" v:shapes="_x0000_s1029"></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:132.0pt;height:36.0pt'></span><![endif]--></td>
  <td colspan=24 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl40 colspan=5 style='height:12.0pt;mso-ignore:colspan'>Ch&#7907;
  T&#7893;ng, L&#432;u Ki&#7871;m, Th&#7911;y Nguy�n, H&#7843;i Ph�ng -
  Vi&#7879;t Nam</td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=24 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl40 colspan=5 style='height:12.0pt;mso-ignore:colspan'>Tel.:
  (+84)31-396-3333 / Fax.: (+84)31-396-3332</td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=24 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl42 style='height:6.0pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=40 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=71 style='width:53pt'></td>
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