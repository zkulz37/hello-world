<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("CRM");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
   string  p_year = Request["p_year"];
	DataTable  dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_golf_revenue_yearly",p_year);
	string l_print_date="";
		string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy hh24:mi') print_date from dual";
		DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
		if (dt_sysdate.Rows.Count > 0)
		{
			l_print_date = dt_sysdate.Rows[0][0].ToString();
		}
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_golf_Revenue_Yearly_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_golf_Revenue_Yearly_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_golf_Revenue_Yearly_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr.Quyen</o:Author>
  <o:LastAuthor>Mr.Quyen</o:LastAuthor>
  <o:LastPrinted>2011-06-15T13:54:23Z</o:LastPrinted>
  <o:Created>2011-06-15T04:01:43Z</o:Created>
  <o:LastSaved>2011-06-15T13:54:51Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .19in .22in .13in;
	mso-header-margin:.5in;
	mso-footer-margin:.24in;
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
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	color:red;
	font-size:15.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}	
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
      <x:Scale>21</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>76</x:ActiveCol>
       <x:RangeSelection>$BY$2:$BZ$2</x:RangeSelection>
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
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=4817 style='border-collapse:
 collapse;table-layout:fixed;width:3629pt'>
 <col class=xl26 width=102 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl26 width=35 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl26 width=54 span=7 style='mso-width-source:userset;mso-width-alt:
 1974;width:41pt'>
 <col class=xl26 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl26 width=54 span=26 style='mso-width-source:userset;mso-width-alt:
 1974;width:41pt'>
 <col class=xl26 width=64 style='width:48pt'>
 <col class=xl26 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl26 width=75 span=3 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl26 width=64 span=39 style='width:48pt'>
 <tr height=89 style='mso-height-source:userset;height:66.75pt'>
  <td colspan=4 height=89 width=245 style='height:66.75pt;width:185pt'
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
   margin-left:3pt;margin-top:2.25pt;width:148.5pt;height:63pt;z-index:1'>
   <v:imagedata src="rpt_golf_Revenue_Yearly_files/image001.jpg" o:title="AMCO"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:4px;margin-top:3px;width:198px;
  height:84px'><img width=198 height=84
  src="rpt_golf_Revenue_Yearly_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=4 height=89 class=xl25 width=245 style='height:66.75pt;
    width:185pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=70 class=xl37 width=1733 style='width:1315pt'>Golf Revenue Yearly</td>
  
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td colspan=3 height=89 width=192 style='height:66.75pt;width:144pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:31.5pt;margin-top:3pt;width:108.75pt;
   height:61.5pt;z-index:2'>
   <v:imagedata src="rpt_golf_Revenue_Yearly_files/image003.png" o:title="Songgia"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:42px;margin-top:4px;width:145px;
  height:82px'><img width=145 height=82
  src="rpt_golf_Revenue_Yearly_files/image004.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=89 class=xl25 width=192 style='height:66.75pt;
    width:144pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl27 style='height:17.25pt'>Year:&nbsp;&nbsp;<%=p_year%></td>
  <td class=xl27></td>
  <td colspan=2 class=xl28>&nbsp;</td>
  <td colspan=30 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29>&nbsp;</td>
  <td colspan=2 class=xl30>&nbsp;</td>
  <td class=xl31></td>
  <td colspan=2 class=xl32>&nbsp;</td>
  <td colspan=35 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl38>Print Time:</td>
  <td colspan=2 class=xl24><%=l_print_date%></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td rowspan=3 height=71 class=xl33 style='height:53.25pt'>Holes</td>
  <td rowspan=3 class=xl33>Customers</td>
  <td colspan=6 class=xl33 style='border-left:none'>January</td>
  <td colspan=6 class=xl33 style='border-left:none'>February</td>
  <td colspan=6 class=xl33 style='border-left:none'>March</td>
  <td colspan=6 class=xl33 style='border-left:none'>April</td>
  <td colspan=6 class=xl33 style='border-left:none'>May</td>
  <td colspan=6 class=xl33 style='border-left:none'>June</td>
  <td colspan=6 class=xl33 style='border-left:none'>July</td>
  <td colspan=6 class=xl33 style='border-left:none'>August</td>
  <td colspan=6 class=xl33 style='border-left:none'>September</td>
  <td colspan=6 class=xl33 style='border-left:none'>October</td>
  <td colspan=6 class=xl33 style='border-left:none'>November</td>
  <td colspan=6 class=xl33 style='border-left:none'>December</td>
  <td colspan=6 class=xl33 style='border-left:none'>Total</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl33 style='height:15.0pt;border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekday</td>
  <td colspan=3 class=xl33 style='border-left:none'>Weekend</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt;border-top:none;border-left:
  none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
  <td class=xl33 style='border-top:none;border-left:none'>Guest</td>
  <td class=xl33 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span>Avg</td>
  <td class=xl33 style='border-top:none;border-left:none'>Amt</td>
 </tr>
 <%       
    string l_begin_bold="",l_end_bold="";
	for (int i=0;i<dt.Rows.Count;i++)
    {
		if(dt.Rows[i][1].ToString()=="Sub Total" || dt.Rows[i][1].ToString()=="Grand Total")
		{
			l_begin_bold="<b>";
			l_end_bold="</b>";
		}
		else
		{
			l_begin_bold="";
			l_end_bold="";
		}
%>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt;border-top:none' x:num><%=l_begin_bold%><%=dt.Rows[i][0].ToString()%><%=l_end_bold%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:str><%=l_begin_bold%><%=dt.Rows[i][1].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none'
  x:num><%=l_begin_bold%><%=dt.Rows[i][2].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][3].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][4].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][5].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][6].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][7].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][8].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][9].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][10].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][11].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][12].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][13].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][14].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][15].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][16].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][17].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][18].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][19].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][20].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][21].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][22].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][23].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][24].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][25].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][26].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][27].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][28].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][29].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][30].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][31].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][32].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][33].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][34].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][35].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][36].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][37].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][38].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][39].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][40].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][41].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][42].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][43].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][44].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][45].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][46].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][47].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][48].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][49].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][50].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][51].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][52].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][53].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][54].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][55].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][56].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][57].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][58].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][59].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][60].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][61].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][62].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][63].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][64].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][65].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][66].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][67].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][68].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][69].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][70].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][71].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][72].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][73].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][74].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][75].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][76].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][77].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][78].ToString()%><%=l_end_bold%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][79].ToString()%><%=l_end_bold%></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=102 style='width:77pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
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
