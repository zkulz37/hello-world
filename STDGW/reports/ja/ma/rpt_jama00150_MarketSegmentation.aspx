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
	DataTable  dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_market_segment_yearly",p_year);
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
<link rel=File-List href="rpt_jama00150_MarketSegmentation_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_jama00150_MarketSegmentation_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_jama00150_MarketSegmentation_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>TuyetIT</o:Author>
  <o:LastAuthor>Mr.Quyen</o:LastAuthor>
  <o:LastPrinted>2011-06-17T02:14:10Z</o:LastPrinted>
  <o:Created>2011-06-17T01:39:08Z</o:Created>
  <o:LastSaved>2011-06-17T02:14:47Z</o:LastSaved>
  <o:Company>AMB</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .12in .2in .12in;
	mso-header-margin:.2in;
	mso-footer-margin:.2in;}
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
.style56
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
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
	mso-style-name:"Normal 2";}
td
	{mso-style-parent:style0;
	padding:0px;
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
.xl67
	{mso-style-parent:style56;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style56;
	color:windowtext;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style56;
	color:red;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style56;
	color:windowtext;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style56;
	color:windowtext;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style56;
	color:windowtext;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style56;
	color:windowtext;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style56;
	color:windowtext;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>62</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>15</x:ActiveCol>
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
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7620</x:WindowHeight>
  <x:WindowWidth>13215</x:WindowWidth>
  <x:WindowTopX>510</x:WindowTopX>
  <x:WindowTopY>315</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1287 style='border-collapse:
 collapse;table-layout:fixed;width:966pt'>
 <col width=166 style='mso-width-source:userset;mso-width-alt:5312;width:125pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:3616;width:85pt'>
 <col width=72 span=14 style='width:54pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=2 height=84 width=166 style='height:63.0pt;width:125pt'
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
   margin-left:2.25pt;margin-top:3.75pt;width:120pt;height:56.25pt;z-index:1'>
   <v:imagedata src="rpt_jama00150_MarketSegmentation_files/image001.jpg"
    o:title="AMCO"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:5px;width:160px;
  height:75px'><img width=160 height=75
  src="rpt_jama00150_MarketSegmentation_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=84 class=xl68 width=166 style='height:63.0pt;
    width:125pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=12 rowspan=2 class=xl69 width=905 style='width:679pt'>Market
  Segmentation</td>
  <td colspan=2 rowspan=2 height=84 width=144 style='height:63.0pt;width:108pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:2.25pt;margin-top:2.25pt;width:104.25pt;
   height:60.75pt;z-index:2'>
   <v:imagedata src="rpt_jama00150_MarketSegmentation_files/image003.png"
    o:title="Songgia"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:3px;margin-top:3px;width:139px;
  height:81px'><img width=139 height=81
  src="rpt_jama00150_MarketSegmentation_files/image004.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 rowspan=2 height=84 class=xl68 width=144 style='height:63.0pt;
    width:108pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl67 width=72 style='width:54pt'></td>
 </tr>
 <tr height=65 style='mso-height-source:userset;height:48.75pt'>
  <td height=65 class=xl67 style='height:48.75pt'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl70 style='height:18.75pt'>Year: &nbsp;&nbsp;<%=p_year%></td>
  <td class=xl71></td>
  <td colspan=9 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl73>Print Time:</td>
  <td colspan=2 class=xl74><%=l_print_date%></td>
  <td class=xl67></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl76 style='height:16.5pt'>Segment Name</td>
  <td class=xl76 style='border-left:none'>Segment Group</td>
  <td class=xl76 style='border-left:none'>Jan</td>
  <td class=xl76 style='border-left:none'>Feb</td>
  <td class=xl76 style='border-left:none'>Mar</td>
  <td class=xl76 style='border-left:none'>Apr</td>
  <td class=xl76 style='border-left:none'>May</td>
  <td class=xl76 style='border-left:none'>Jun</td>
  <td class=xl76 style='border-left:none'>Jul</td>
  <td class=xl76 style='border-left:none'>Aug</td>
  <td class=xl76 style='border-left:none'>Sept</td>
  <td class=xl76 style='border-left:none'>Oct</td>
  <td class=xl76 style='border-left:none'>Nov</td>
  <td class=xl76 style='border-left:none'>Dec</td>
  <td class=xl76 style='border-left:none'>YTD</td>
  <td class=xl67></td>
 </tr>
 <% 
  string l_begin_bold="",l_end_bold=""; 
    for (int i=0;i<dt.Rows.Count;i++)
    {
		if(dt.Rows[i][0].ToString()=="Total" || dt.Rows[i][0].ToString()=="Sub Total" || dt.Rows[i][0].ToString()=="Room Sold"|| dt.Rows[i][0].ToString()=="Room Rate"||dt.Rows[i][0].ToString()=="Room Revenue"||dt.Rows[i][0].ToString()=="Grand Total")
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
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl77 style='height:15.0pt;border-top:none'><%=l_begin_bold%><%=dt.Rows[i][0].ToString()%><%=l_end_bold%></td>
  <td class=xl77 style='border-top:none;border-left:none'><%=l_begin_bold%><%=dt.Rows[i][1].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][2].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][3].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][4].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][5].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][6].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][7].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][8].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][9].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][10].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][11].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][12].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][13].ToString()%><%=l_end_bold%></td>
  <td class=xl78 align=right style='border-top:none;border-left:none' x:num><%=l_begin_bold%><%=dt.Rows[i][14].ToString()%><%=l_end_bold%></td>
  <td></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=166 style='width:125pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
