<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("CRM");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_member_pk =Request["p_member_pk"];
	string l_member_id =Request["p_member_id"];
	string l_member_name =Request["p_member_name"];
    string l_member_type=Request["p_member_type"];
	string l_gender =Request["p_gender"];
	string l_parameter="",l_print_date="";
	l_parameter = "'" +l_member_pk+ "','"+l_member_id+"','" +l_member_name +"','"+l_member_type +"','"+l_gender+ "'";
    DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_jams00100_detail", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
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
<link rel=File-List href="rpt_jams100_detail_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jams100_detail_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jams100_detail_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nghia</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-04-28T03:36:12Z</o:LastPrinted>
  <o:Created>2011-01-12T18:02:19Z</o:Created>
  <o:LastSaved>2011-04-28T03:36:38Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.21in .35in .37in .38in;
	mso-header-margin:.21in;
	mso-footer-margin:.17in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
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
	font-size:8.0pt;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	color:red;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style16;
	font-size:8.0pt;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;}
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>12</x:SplitVertical>
     <x:LeftColumnRightPane>12</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9000</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>0</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=934 style='border-collapse:
 collapse;table-layout:fixed;width:706pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=41 style='mso-width-source:userset;mso-width-alt:1499;width:31pt'>
 <col width=33 span=8 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=33 span=9 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <tr height=75 style='mso-height-source:userset;height:56.25pt'>
  <td colspan=4 height=75 width=186 style='height:56.25pt;width:140pt'
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
  </v:shapetype><v:shape id="_x0000_s1027" type="#_x0000_t75" style='position:absolute;
   margin-left:3pt;margin-top:1.5pt;width:109.5pt;height:54.75pt;z-index:2'>
   <v:imagedata src="rpt_jams100_detail_files/image001.jpg" o:title="huyndai_amco"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:4px;margin-top:2px;width:146px;
  height:73px'><img width=146 height=73
  src="rpt_jams100_detail_files/image002.jpg" v:shapes="_x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=4 height=75 class=xl32 width=186 style='height:56.25pt;
    width:140pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=16 class=xl25 width=564 style='width:427pt'>Handicap's Detail</td>
  <td colspan=5 height=75 width=184 style='height:56.25pt;width:139pt'
  align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:.75pt;margin-top:3.75pt;width:93pt;
   height:51pt;z-index:1'>
   <v:imagedata src="rpt_jams100_detail_files/image003.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:1px;margin-top:5px;width:124px;
  height:68px'><img width=124 height=68
  src="rpt_jams100_detail_files/image004.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=5 height=75 class=xl26 width=184 style='height:56.25pt;
    width:139pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl36 style='height:12.75pt' x:str="Member ID:  ">Member
  ID:<span style='mso-spacerun:yes'>  </span></td>
  <td colspan=7 class=xl27><%=l_member_id%></td>
  <td colspan=3 class=xl28>Member Type:</td>
  <td colspan=6 class=xl29><%=l_member_type%></td>
  <td colspan=3 class=xl30>Print Date:</td>
  <td colspan=4 class=xl31><%=l_print_date%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl37 style='height:12.75pt'>Member Name:</td>
  <td colspan=7 class=xl24><%=l_member_name %></td>
  <td colspan=3 class=xl28>Gender:</td>
  <td colspan=13 class=xl27><%=l_gender%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 style='height:12.75pt;border-top:none'>No</td>
  <td class=xl33 style='border-top:none;border-left:none'>Date</td>
  <td class=xl33 style='border-top:none;border-left:none'>Caddy#</td>
  <td class=xl33 style='border-top:none;border-left:none'>HDCP</td>
  <td class=xl33 style='border-top:none;border-left:none'>Gross</td>
  <td class=xl33 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl33 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl33 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl33 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl33 style='border-left:none' x:num>5</td>
  <td class=xl33 style='border-left:none' x:num>6</td>
  <td class=xl33 style='border-left:none' x:num>7</td>
  <td class=xl33 style='border-left:none' x:num>8</td>
  <td class=xl33 style='border-left:none' x:num>9</td>
  <td class=xl33 style='border-left:none'>OUT</td>
  <td class=xl33 style='border-left:none' x:num>10</td>
  <td class=xl33 style='border-left:none' x:num>11</td>
  <td class=xl33 style='border-left:none' x:num>12</td>
  <td class=xl33 style='border-left:none' x:num>13</td>
  <td class=xl33 style='border-left:none' x:num>14</td>
  <td class=xl33 style='border-left:none' x:num>15</td>
  <td class=xl33 style='border-left:none' x:num>16</td>
  <td class=xl33 style='border-left:none' x:num>17</td>
  <td class=xl33 style='border-left:none' x:num>18</td>
  <td class=xl33 style='border-left:none'>IN</td>
 </tr>
 <%
		for(int i=0;i<dt.Rows.Count;i++)
		{
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt;border-top:none' x:num><%=i+1%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][11]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][12]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][13]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][14]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][15]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][16]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][17]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][18]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][19]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][20]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][21]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][22]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][23]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][24]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][25]%></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=52 style='width:39pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
