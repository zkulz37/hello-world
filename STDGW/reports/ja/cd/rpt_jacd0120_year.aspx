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
    string dtYear = Request.QueryString["p_Year"];	
   string  Monthly="";
    string l_parameter = "'" + dtYear + "'";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_jacd0120",l_parameter);
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
<link rel=File-List href="rpt_jacd0120_year_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jacd0120_year_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jacd0120_year_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-05-16T07:18:52Z</o:LastPrinted>
  <o:Created>2011-05-16T06:57:51Z</o:Created>
  <o:LastSaved>2011-05-16T07:19:28Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.36in .18in .21in .17in;
	mso-header-margin:.33in;
	mso-footer-margin:.17in;}
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
.style61
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
.xl70
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\@";
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style61;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style61;
	color:#003300;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style61;
	color:#003300;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style61;
	color:red;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>81</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>8</x:SplitVertical>
     <x:LeftColumnRightPane>8</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:ActiveCol>20</x:ActiveCol>
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
  <x:WindowHeight>6405</x:WindowHeight>
  <x:WindowWidth>9435</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1028"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=887 style='border-collapse:
 collapse;table-layout:fixed;width:669pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=75 span=2 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=41 span=11 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <tr height=67 style='mso-height-source:userset;height:50.25pt'>
  <td colspan=3 height=67 width=186 style='height:50.25pt;width:140pt'
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
   margin-left:2.25pt;margin-top:2.25pt;width:134.25pt;height:46.5pt;z-index:1'>
   <v:imagedata src="rpt_jacd0120_year_files/image001.jpg" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:3px;width:179px;
  height:62px'><img width=179 height=62
  src="rpt_jacd0120_year_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=67 class=xl77 width=186 style='height:50.25pt;
    width:140pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=13 class=xl87 width=575 style='width:434pt'><%=dt.Rows[0][17]%><%=dtYear%></td>
  <td colspan=3 height=67 width=126 style='height:50.25pt;width:95pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1027" type="#_x0000_t75"
   style='position:absolute;margin-left:1.5pt;margin-top:1.5pt;width:92.25pt;
   height:46.5pt;z-index:2'>
   <v:imagedata src="rpt_jacd0120_year_files/image003.jpg" o:title="image002"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:2px;margin-top:2px;width:123px;
  height:62px'><img width=123 height=62
  src="rpt_jacd0120_year_files/image004.jpg" v:shapes="_x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=67 class=xl77 width=126 style='height:50.25pt;
    width:95pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=43 class=xl72 style='height:32.25pt;border-top:none'>No</td>
  <td colspan=3 rowspan=2 class=xl78 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Name</td>
  <td rowspan=2 class=xl73 style='border-top:none'>Caddie#</td>
  <td rowspan=2 class=xl72 style='border-top:none'>EMP#</td>
  <td colspan=12 class=xl72 style='border-left:none'>Month</td>
  <td rowspan=2 class=xl75 style='border-top:none'>Total</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl74 style='height:15.75pt;border-top:none;border-left:
  none' x:num>1</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl74 style='border-top:none;border-left:none' x:num>12</td>
 </tr>
 <%
	 for (int i = 0; i < dt.Rows.Count; i++)
     {
 %>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl70 style='height:12.75pt;border-top:none' x:num><%=dt.Rows[i][0]%></td>
  <td colspan=3 class=xl84 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[i][1]%></td>
  <td class=xl71 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl71 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][4]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][5]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][6]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][7]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][8]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][9]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][10]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][11]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][12]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][13]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][14]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][15]%></td>
  <td class=xl76 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][16]%></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=43 style='width:32pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>