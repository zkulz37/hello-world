<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
   ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_dt_frm="",l_dt_departure="",l_parameter="",l_guest_name="",l_total_room="";
	l_dt_frm =Request["p_dt_frm"];
	l_dt_departure =Request["p_dt_departure"];
	
	l_parameter = "'" + l_dt_frm + "','" + l_dt_departure + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("ht_rpt_60250040", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string l_print_date="";
    string SQL3 = "select to_char(sysdate,'dd-mm-yyyy hh24:mi') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString();
    }
    String l_arrival_depart="";
	l_arrival_depart = "   " + l_dt_frm.Substring(6, 2) + "/" + l_dt_frm.Substring(4, 2) + "/" + l_dt_frm.Substring(0, 4) + "  ~  " + l_dt_departure.Substring(6, 2) + "/" + l_dt_departure.Substring(4, 2) + "/" + l_dt_departure.Substring(0, 4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00020_departure_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_htfo00020_departure_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_htfo00020_departure_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nguyen Van Quyen</o:Author>
  <o:LastAuthor>Nguyen Van Quyen</o:LastAuthor>
  <o:LastPrinted>2011-12-29T04:16:35Z</o:LastPrinted>
  <o:Created>2011-12-29T03:54:01Z</o:Created>
  <o:LastSaved>2012-03-03T09:25:10Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&RPage &P";
	margin:.52in .17in .51in .19in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	color:red;
	font-size:15.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
      <x:Scale>61</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
  <x:WindowHeight>8745</x:WindowHeight>
  <x:WindowWidth>20490</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1574 style='border-collapse:
 collapse;table-layout:fixed;width:1183pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:4059;width:83pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=174 style='mso-width-source:userset;mso-width-alt:6363;width:131pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:3840;width:79pt'>
 <col width=173 style='mso-width-source:userset;mso-width-alt:6326;width:130pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=28 style='mso-width-source:userset;mso-width-alt:1024;width:21pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:4059;width:83pt'>
 <tr height=99 style='mso-height-source:userset;height:74.25pt'>
  <td height=99 width=111 style='height:74.25pt;width:83pt' align=left
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
   margin-left:3.75pt;margin-top:6pt;width:75.75pt;height:61.5pt;z-index:1'>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1027" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:2.25pt;width:81pt;height:69pt;z-index:3'>
   <v:imagedata src="rpt_htfo00020_departure_files/image001.png" o:title="LotusMuine"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:2px;margin-top:3px;width:108px;
  height:92px'><img width=108 height=92
  src="rpt_htfo00020_departure_files/image002.jpg" v:shapes="_x0000_s1025 _x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=99 width=111 style='height:74.25pt;width:83pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=17 class=xl45 width=1352 style='width:1017pt'>Departure Guest
  List Report</td>
  <td width=111 style='width:83pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:1.5pt;
   margin-top:2.25pt;width:79.5pt;height:70.5pt;z-index:2'>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:2px;margin-top:3px;width:106px;
  height:94px'><img width=106 height=94
  src="rpt_htfo00020_departure_files/image003.gif" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=99 width=111 style='height:74.25pt;width:83pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl39 style='border-right:.5pt solid black;
  height:12.75pt'>Date: <font class="font0"><%=l_arrival_depart%></font></td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td colspan=4 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td class=xl24 style='border-top:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none'>Print Time:</td>
  <td class=xl26><%=l_print_date%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td rowspan=2 height=43 class=xl37 style='border-bottom:.5pt solid black;
  height:32.25pt;border-top:none'>Last Name</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>First Name</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Gender</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Arrival</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Departure</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Rate</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>RM</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Room Type</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Contact Name</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Phone</td>
  <td rowspan=2 class=xl37 style='border-bottom:.5pt solid black;border-top:
  none'>Company</td>
  <td colspan=2 class=xl35 style='border-right:.5pt solid black;border-left:
  none'>Adult</td>
  <td colspan=2 class=xl35 style='border-right:.5pt solid black;border-left:
  none'>Child</td>
  <td class=xl27>Guest Name 2</td>
  <td class=xl27>Guest Name 3</td>
  <td class=xl27>Guest Name 4</td>
  <td class=xl27>Status</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>F</td>
  <td class=xl28>M</td>
  <td class=xl28>F</td>
  <td class=xl28>M</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <%
	string l_color="";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
		if(dt.Rows[i]["last_name"].ToString()=="Sub total")
		{
			l_color="background:silver";
		}
		else
		{
			l_color="";
		}
		  %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl30 style='height:13.5pt;<%=l_color%>'><%=dt.Rows[i]["last_name"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["first_name"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["gender"]%></td>
  <td class=xl32 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["from_date"]%></td>
  <td class=xl32 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["date_to"]%></td>
  <td class=xl33 align=right  style='height:13.5pt;border-top:none;<%=l_color%>' x:num><%=dt.Rows[i]["room_rate"]%></td>
  <td class=xl32 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["room_no"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["room_type"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["contact_person"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["phone"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["company_name"]%></td>
  <td class=xl34 style='height:13.5pt;border-top:none;<%=l_color%>' x:num><%=dt.Rows[i]["total_adult_female"]%></td>
  <td class=xl34 style='height:13.5pt;border-top:none;<%=l_color%>' x:num><%=dt.Rows[i]["total_adult"]%></td>
  <td class=xl34  style='height:13.5pt;border-top:none;<%=l_color%>' x:num><%=dt.Rows[i]["total_child_female"]%></td>
  <td class=xl34 style='height:13.5pt;border-top:none;<%=l_color%>' x:num><%=dt.Rows[i]["total_child"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["guest2_name"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["guest3_name"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["guest4_name"]%></td>
  <td class=xl31 style='height:13.5pt;border-top:none;<%=l_color%>'><%=dt.Rows[i]["guest_status"]%></td>
 </tr>
  <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=111 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=111 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
