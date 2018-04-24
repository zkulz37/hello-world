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
	DataTable  dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_fnb_session_yearly",p_year);
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
<link rel=File-List href="rpt_jama000150_fnb_sesion_yearly_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_jama000150_fnb_sesion_yearly_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_jama000150_fnb_sesion_yearly_files/oledata.mso">
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
  <o:LastPrinted>2011-06-20T07:29:17Z</o:LastPrinted>
  <o:Created>2011-06-17T09:24:21Z</o:Created>
  <o:LastSaved>2011-06-20T07:29:24Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.43in .24in .13in .24in;
	mso-header-margin:.45in;
	mso-footer-margin:.15in;
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
.style56
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
.xl66
	{mso-style-parent:style56;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;}
.xl67
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style56;
	color:black;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style56;
	color:black;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style56;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style56;
	color:black;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style56;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style56;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	text-align:center;}
.xl76
	{mso-style-parent:style0;
	color:red;
	font-size:22.0pt;
	text-align:center;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style56;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
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
      <x:Scale>33</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>17115</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2840 style='border-collapse:
 collapse;table-layout:fixed;width:2131pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=64 style='width:48pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=64 style='width:48pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=64 style='width:48pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=64 style='width:48pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=64 style='width:48pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=64 style='width:48pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=64 style='width:48pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=64 style='width:48pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=64 span=5 style='width:48pt'>
 <tr height=90 style='mso-height-source:userset;height:67.5pt'>
  <td colspan=3 height=90 width=203 style='height:67.5pt;width:152pt'
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
   margin-left:3.75pt;margin-top:3pt;width:117.75pt;height:62.25pt;z-index:1'>
   <v:imagedata src="rpt_jama000150_fnb_sesion_yearly_files/image001.jpg"
    o:title="AMCO"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:5px;margin-top:4px;width:157px;
  height:83px'><img width=157 height=83
  src="rpt_jama000150_fnb_sesion_yearly_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=90 class=xl75 width=203 style='height:67.5pt;
    width:152pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=37 class=xl76 width=2445 style='width:1835pt'>F&amp;B Yearly
  Forcasting</td>
  <td colspan=2 height=90 width=128 style='height:67.5pt;width:96pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:1.5pt;margin-top:2.25pt;width:93pt;
   height:64.5pt;z-index:2'>
   <v:imagedata src="rpt_jama000150_fnb_sesion_yearly_files/image003.png"
    o:title="Songgia"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:2px;margin-top:3px;width:124px;
  height:86px'><img width=124 height=86
  src="rpt_jama000150_fnb_sesion_yearly_files/image004.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=90 class=xl75 width=128 style='height:67.5pt;
    width:96pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl80 style='height:18.0pt'>Year: &nbsp;&nbsp;<%=p_year%></td>
  <td colspan=35 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl74></td>
  <td colspan=2 class=xl79>Print Time:</td>
  <td colspan=2 class=xl78><%=l_print_date%></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td rowspan=2 height=40 class=xl73 style='height:30.0pt'>Point</td>
  <td rowspan=2 class=xl77>Material</td>
  <td rowspan=2 class=xl73>Siosion</td>
  <td colspan=3 class=xl72 style='border-left:none'>January</td>
  <td colspan=3 class=xl72 style='border-left:none'>February</td>
  <td colspan=3 class=xl72 style='border-left:none'>March</td>
  <td colspan=3 class=xl72 style='border-left:none'>April</td>
  <td colspan=3 class=xl72 style='border-left:none'>May</td>
  <td colspan=3 class=xl72 style='border-left:none'>June</td>
  <td colspan=3 class=xl72 style='border-left:none'>July</td>
  <td colspan=3 class=xl72 style='border-left:none'>August</td>
  <td colspan=3 class=xl72 style='border-left:none'>September</td>
  <td colspan=3 class=xl72 style='border-left:none'>October</td>
  <td colspan=3 class=xl72 style='border-left:none'>November</td>
  <td colspan=3 class=xl72 style='border-left:none'>December</td>
  <td colspan=3 class=xl73 style='border-left:none'>Total</td>
  <td></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl70 style='height:13.5pt;border-top:none;border-left:
  none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td class=xl70 style='border-top:none;border-left:none'>Cover</td>
  <td class=xl70 style='border-top:none;border-left:none'>Avr Check</td>
  <td class=xl70 style='border-top:none;border-left:none'>Revenue</td>
  <td></td>
 </tr>
 <%       
   string l_begin_bold="",l_end_bold="";
	for (int i=0;i<dt.Rows.Count;i++)
    {
		if(dt.Rows[i][1].ToString()=="Total"|| dt.Rows[i][2].ToString()=="Sub Total"||dt.Rows[i][2].ToString()=="Total"||dt.Rows[i][0].ToString()=="Grand Total")
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
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl68 style='height:15.0pt;border-top:none'><%=l_begin_bold%><%=dt.Rows[i][0].ToString()%><%=l_end_bold%></td>
  <td class=xl69 style='border-top:none;border-left:none'><%=l_begin_bold%><%=dt.Rows[i][1].ToString()%><%=l_end_bold%></td>
  <td class=xl68 style='border-top:none;border-left:none'><%=l_begin_bold%><%=dt.Rows[i][2].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][3].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][4].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][5].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][6].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][7].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][8].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][9].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][10].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][11].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][12].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][13].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][14].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][15].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][16].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][17].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][18].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][19].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][20].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][21].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][22].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][23].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][24].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][25].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][26].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][27].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][28].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][29].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][30].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][31].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][32].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][33].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][34].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][35].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][36].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][37].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][38].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][39].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][40].ToString()%><%=l_end_bold%></td>
  <td class=xl71 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][41].ToString()%><%=l_end_bold%></td>
  <td class=xl66></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=85 style='width:64pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=79 style='width:59pt'></td>
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
