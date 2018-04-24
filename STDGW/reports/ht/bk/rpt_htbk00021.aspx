<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("crm");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_from_dt="", l_to_dt="", l_parameter="";
	
	l_from_dt =Request["from_dt"];
	l_to_dt =Request["to_dt"];
	
	l_parameter = "'" + l_from_dt + "','" + l_to_dt + "'";
	
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_htbk00021", l_parameter);
    
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
	l_arrival_depart = "   " + l_from_dt.Substring(6, 2) + "/" + l_from_dt.Substring(4, 2) + "/" + l_from_dt.Substring(0, 4) + "  ~  " + l_to_dt.Substring(6, 2) + "/" + l_to_dt.Substring(4, 2) + "/" + l_to_dt.Substring(0, 4);
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htbk00021_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_htbk00021_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_htbk00021_files/oledata.mso">
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
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-12-05T03:40:31Z</o:LastPrinted>
  <o:Created>2010-12-05T02:51:03Z</o:Created>
  <o:LastSaved>2010-12-10T03:44:45Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:7.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"Short Date";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0\.0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:7.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>16</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8790</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
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

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=897 style='border-collapse:
 collapse;table-layout:fixed;width:675pt'>
 
 <col width=102 style='mso-width-source:userset;mso-width-alt:2200;width:77pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:2800;width:27pt'>
 <col width=53 span=2 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2969;width:55pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1282;width:35pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1245;width:34pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:6584;width:74pt'>
 
 <tr height=81 style='mso-height-source:userset;height:60.75pt'>
  <td height=81 class=xl25 width=102 style='height:60.75pt;width:77pt'></td>
  <td colspan=13 class=xl40 width=697 style='width:524pt'
  x:str=" CANCEL LIST "><span
  style='mso-spacerun:yes'>�</span>CANCEL<span style='mso-spacerun:yes'>�
  </span><span style='mso-spacerun:yes'>� </span>LIST<span
  style='mso-spacerun:yes'>�</span></td>
  <td width=98 style='width:74pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s1029" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:.75pt;width:73.5pt;height:59.25pt;z-index:1'>
   <v:imagedata src="rpt_htbk00021_files/image001.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt' ><b>Total:</b></td>
  <td colspan=3 class=xl26 x:num><%=dt.Rows.Count%> Rooms</td>
  <td class=xl38 colspan="5"><b>Date:</b><%=l_arrival_depart%></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td colspan=2 class=xl39>Print Date :</td>
  <td class=xl27><%=l_print_date%></td>
 </tr>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Last Name</td>
  <td class=xl29>First Name</td>
  <td class=xl29>Arrival</td>
  <td class=xl29>Departure</td>
  <td class=xl30>Deposit</td>
  <td class=xl30>Rate</td>
  <td class=xl30>Room#</td>
  <td class=xl30>Room Type</td>
  <td class=xl30>Contact Name</td>
  <td class=xl30>Phone</td>
  <td class=xl30>Email</td>
  <td class=xl30>Adult</td>
  <td class=xl30>Child</td>
  <td class=xl30>RSV#</td>
  <td class=xl29>Request</td>
 </tr>
 
<%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
		  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'><%=dt.Rows[i][3]%></td>
  <td class=xl32><%=dt.Rows[i][4]%></td>
  <td class=xl33><%=dt.Rows[i][6]%></td>
  <td class=xl34><%=dt.Rows[i][7]%></td>
  <td class=xl35 align=right x:num><%=dt.Rows[i][8]%></td>
  <td class=xl36 align=right x:num><%=dt.Rows[i][9]%></td>
  <td class=xl33 x:num><%=dt.Rows[i][10]%></td>
  <td class=xl37><%=dt.Rows[i][11]%></td>
  <td class=xl32><%=dt.Rows[i][12]%></td>
  <td class=xl33 x:num><%=dt.Rows[i][13]%></td>
  <td class=xl37><%=dt.Rows[i][14]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][15]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][16]%></td>
  <td class=xl32><%=dt.Rows[i][18]%></td>
  <td class=xl37><%=dt.Rows[i][21]%></td>
 </tr>
<%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=102 style='width:77pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=98 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
