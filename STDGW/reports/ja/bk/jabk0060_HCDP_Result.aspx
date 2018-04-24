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
	string l_rank_type =Request["p_rank_type"];
	string l_tournament  = Request["p_tournament"];
	string l_locker_name = Request["p_locker_name"];
    string l_parameter="",l_tournament_name="",l_ranktype_name="",l_print_date="",l_parameter_gross="";
     l_parameter = "'" + l_rank_type + "','" + l_tournament + "','" + l_locker_name + "'";
     DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_jabk00060_final_result", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	l_parameter_gross = "'" + l_tournament + "'," + l_rank_type + ""; 
	DataTable dt_BestGross = ESysLib.TableReadOpenCursor("CRM.sp_jabk0060_lkp_by_rank_type", l_parameter_gross);

    string SQL1 = " SELECT REGEXP_REPLACE (A.EVENT_NAME, '<[^>]+>', NULL) FROM CRM.TGM_TOURNAMENT A WHERE A.DEL_IF =0 and A.PK ='" + l_tournament+ "'";
    DataTable dt_tournament = ESysLib.TableReadOpen(SQL1);
    if (dt_tournament.Rows.Count > 0)
    {
        l_tournament_name = dt_tournament.Rows[0][0].ToString();
    }
    string SQL2 = "select decode('" + l_rank_type+ "','10','HANDICAP DIVISION','20','CALLAWAY DIVISION','30','BEST GROSS','40','NEAREST PIN','50','LONGEST DRIVE',140,'SYSTEM 36') from dual";
    DataTable dt_ranktype = ESysLib.TableReadOpen(SQL2);
    if (dt_ranktype.Rows.Count > 0)
    {
        l_ranktype_name = dt_ranktype.Rows[0][0].ToString();
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
<link rel=File-List href="jabk0060_HCDP_Result_files/filelist.xml">
<link rel=Edit-Time-Data href="jabk0060_HCDP_Result_files/editdata.mso">
<link rel=OLE-Object-Data href="jabk0060_HCDP_Result_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>dieu</o:Author>
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-11-23T09:10:05Z</o:LastPrinted>
  <o:Created>2010-10-26T01:12:00Z</o:Created>
  <o:LastSaved>2010-11-23T09:11:05Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .2in .2in .2in;
	mso-header-margin:.31in;
	mso-footer-margin:.31in;
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
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	text-align:right;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl45
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"General Date";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9180</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1635</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1023 style='border-collapse:
 collapse;table-layout:fixed;width:769pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=31 style='mso-width-source:userset;mso-width-alt:1133;width:23pt'>
 <col width=30 style='mso-width-source:userset;mso-width-alt:1097;width:23pt'>
 <col width=28 span=9 style='mso-width-source:userset;mso-width-alt:1024;
 width:21pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=28 span=9 style='mso-width-source:userset;mso-width-alt:1024;
 width:21pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=64 style='width:48pt'>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 rowspan=2 height=87 width=156 style='height:65.25pt;width:118pt'
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   margin-left:2.25pt;margin-top:3.75pt;width:102.75pt;height:50.25pt;
   z-index:2'>
   <v:imagedata src="jabk0060_HCDP_Result_files/huyndai_amco.jpg" o:title="huyndai_amco"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:3px;margin-top:5px;width:137px;
  height:67px'><img width=137 height=67 src="jabk0060_HCDP_Result_files/huyndai_amco.jpg"
  v:shapes="_x0000_s1026"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 rowspan=2 height=87 class=xl44 width=156 style='height:65.25pt;
    width:118pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=20 rowspan=2 class=xl49 width=658 style='width:494pt'><%=l_tournament_name %></td>
  <td colspan=5 rowspan=2 height=87 width=145 style='height:65.25pt;width:109pt'
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
   direction:LTR;text-align:left;margin-left:1.5pt;margin-top:0;width:105.75pt;
   height:64.5pt;z-index:1'>
   <v:imagedata src="jabk0060_HCDP_Result_files/image001.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:2px;margin-top:0px;width:141px;
  height:86px'><img width=141 height=86
  src="jabk0060_HCDP_Result_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=5 rowspan=2 height=87 class=xl44 width=145 style='height:65.25pt;
    width:109pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=64 style='mso-height-source:userset;height:48.0pt'>
  <td height=64 style='height:48.0pt'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 align=left style='height:15.75pt'>Stroke:</td>
  <td colspan=16 class=xl45><%=l_ranktype_name %></td>
  <td colspan=6 class=xl46>Print Date:</td>
  <td colspan=4 class=xl47 x:str><%=l_print_date %></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl26 height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>Rank</td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>Name</td>
  <td class=xl28>Locker#</td>
  <td class=xl28>Gross</td>
  <td class=xl28>HDCP</td>
  <td class=xl28>Net</td>
  <td class=xl28 x:num>1</td>
  <td class=xl28 x:num>2</td>
  <td class=xl28 x:num>3</td>
  <td class=xl28 x:num>4</td>
  <td class=xl28 x:num>5</td>
  <td class=xl28 x:num>6</td>
  <td class=xl28 x:num>7</td>
  <td class=xl28 x:num>8</td>
  <td class=xl28 x:num>9</td>
  <td class=xl28>Out</td>
  <td class=xl28 x:num>10</td>
  <td class=xl28 x:num>11</td>
  <td class=xl28 x:num>12</td>
  <td class=xl28 x:num>13</td>
  <td class=xl28 x:num>14</td>
  <td class=xl28 x:num>15</td>
  <td class=xl28 x:num>16</td>
  <td class=xl28 x:num>17</td>
  <td class=xl28 x:num>18</td>
  <td class=xl28>In</td>
  <td class=xl29></td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt' x:num><%=dt.Rows[i][1]%></td>
  <td colspan=2 class=xl39 style='border-right:.5pt solid black;border-left:
  none'><%=dt.Rows[i][3]%></td>
  <td class=xl31><%=dt.Rows[i][5]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][8]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][9]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][10]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][11]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][12]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][13]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][14]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][15]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][16]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][17]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][18]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][19]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][20]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][21]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][22]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][23]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][24]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][25]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][26]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][27]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][28]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][29]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][30]%></td>
  <td></td>
 </tr>
 <%}%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=27 height=17 class=xl41 style='height:12.75pt'>&nbsp;</td>
  <td></td>
 </tr>
 <%
     string best_gross_name = "", best_gross_value = "";
     if (dt_BestGross.Rows.Count == 0)
         {
             best_gross_name = "";
             best_gross_value = "";
         }
         else if (dt_BestGross.Rows.Count > 0)
         {
             best_gross_name = dt_BestGross.Rows[0][0].ToString();
             best_gross_value = dt_BestGross.Rows[0][1].ToString();   
         }
     %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 align=left style='height:12.75pt'>Best Gross:</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'><%=best_gross_name%></td>
  <td class=xl35 x:num><%=best_gross_value%></td>
  <td colspan=23 class=xl38 style='border-left:none'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=51 style='height:38.25pt;mso-xlrowspan:3'>
  <td height=51 colspan=28 style='height:38.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=15 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=70 style='width:53pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
