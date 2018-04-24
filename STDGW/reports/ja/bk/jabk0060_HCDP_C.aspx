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
    string l_parameter="",l_tournament_name="",l_ranktype_name="",l_print_date="";
     l_parameter = "'" + l_rank_type + "','" + l_tournament + "','" + l_locker_name + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_sel_jabk00060_hcdp_c", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string SQL1 = " SELECT REGEXP_REPLACE (A.EVENT_NAME, '<[^>]+>', NULL) FROM CRM.TGM_TOURNAMENT A WHERE A.DEL_IF =0 and A.PK ='" + l_tournament+ "'";
    DataTable dt_tournament = ESysLib.TableReadOpen(SQL1);
    if (dt_tournament.Rows.Count > 0)
    {
        l_tournament_name = dt_tournament.Rows[0][0].ToString();
    }
    string SQL2 = "select decode('" + l_rank_type+ "','10','HANDICAP DIVISION','20','CALLAWAY DIVISION','30','BEST GROSS','40','NEAREST PIN','50','LONGEST DRIVE') from dual";
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
<link rel=File-List href="jabk0060_HCDP_C_files/filelist.xml">
<link rel=Edit-Time-Data href="jabk0060_HCDP_C_files/editdata.mso">
<link rel=OLE-Object-Data href="jabk0060_HCDP_C_files/oledata.mso">
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
  <o:LastAuthor>CAN</o:LastAuthor>
  <o:LastPrinted>2011-03-25T06:52:37Z</o:LastPrinted>
  <o:Created>2010-10-26T07:02:03Z</o:Created>
  <o:LastSaved>2011-04-03T08:13:09Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .17in .2in .2in;
	mso-header-margin:.2in;
	mso-footer-margin:.2in;
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
.xl65
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
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
.xl67
	{mso-style-parent:style0;
	font-size:6.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0_ \;\[Red\]\\-\#\,\#\#0\\ ";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	color:red;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
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
.xl73
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	color:red;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
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
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>27</x:ActiveCol>
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
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="5121"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=982 style='border-collapse:
 collapse;table-layout:fixed;width:736pt'>
 <col width=64 style='width:48pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=134 style='mso-width-source:userset;mso-width-alt:4900;width:101pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=27 span=3 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col width=30 style='mso-width-source:userset;mso-width-alt:1097;width:23pt'>
 <col width=27 span=5 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=27 span=7 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=30 span=2 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 rowspan=6 height=98 width=106 style='border-bottom:.5pt solid black;
  height:73.5pt;width:80pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1031" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:3pt;width:77.25pt;height:68.25pt;z-index:2'>
   <v:imagedata src="jabk0060_HCDP_C_files/huyndai_amco.jpg" o:title="huyndai_amco"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:2px;margin-top:4px;width:103px;
  height:91px'><img width=103 height=91 src="jabk0060_HCDP_C_files/huyndai_amco.jpg"
  v:shapes="_x0000_s1031"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 rowspan=6 height=98 class=xl37 width=106 style='border-bottom:
    .5pt solid black;height:73.5pt;width:80pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=21 rowspan=5 class=xl75 width=743 style='width:555pt'><%=l_tournament_name %></td>
  <td width=30 style='width:23pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="Picture_x0020_5" o:spid="_x0000_s1030" type="#_x0000_t75"
   alt="image001" style='position:absolute;margin-left:.75pt;margin-top:1.5pt;
   width:97.5pt;height:57.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="jabk0060_HCDP_C_files/image001.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:1px;margin-top:2px;width:130px;
  height:77px'><img width=130 height=77 src="jabk0060_HCDP_C_files/image002.jpg"
  alt=image001 v:shapes="Picture_x0020_5"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl71 width=30 style='height:12.75pt;width:23pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl71 width=37 style='width:28pt'></td>
  <td class=xl70 width=32 style='width:24pt'></td>
  <td class=xl70 width=34 style='width:26pt'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=2 class=xl71 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=2 class=xl71 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=2 class=xl71 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=2 class=xl71 style='height:10.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl73>Print Date:</td>
  <td colspan=5 class=xl74><%=l_print_date %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl72 style='border-right:.5pt solid black;
  height:12.75pt'>No</td>
  <td class=xl65>Customer Name</td>
  <td class=xl65>Company</td>
  <td class=xl65 x:num>1</td>
  <td class=xl65 x:num>2</td>
  <td class=xl65 x:num>3</td>
  <td class=xl65 x:num>4</td>
  <td class=xl65 x:num>5</td>
  <td class=xl65 x:num>6</td>
  <td class=xl65 x:num>7</td>
  <td class=xl65 x:num>8</td>
  <td class=xl65 x:num>9</td>
  <td class=xl65>Out</td>
  <td class=xl65 x:num>10</td>
  <td class=xl65 x:num>11</td>
  <td class=xl65 x:num>12</td>
  <td class=xl65 x:num>13</td>
  <td class=xl65 x:num>14</td>
  <td class=xl65 style='border-top:none' x:num>15</td>
  <td class=xl65 style='border-top:none' x:num>16</td>
  <td class=xl66 x:num>17</td>
  <td class=xl66 x:num>18</td>
  <td class=xl66>In</td>
  <td class=xl66>Gross</td>
  <td class=xl66>H'cp</td>
  <td class=xl66>Net</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl72 style='border-right:.5pt solid black;
  height:12.75pt'>Par</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>3</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>5</td>
  <td class=xl66 x:num>3</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>5</td>
  <td class=xl66 x:num>36</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>3</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>5</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>4</td>
  <td class=xl66 x:num>3</td>
  <td class=xl66 x:num>5</td>
  <td class=xl66 x:num>36</td>
  <td class=xl66 x:num>72</td>
  <td class=xl66 x:num>0</td>
  <td class=xl66 x:num>72</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl79 style='border-right:.5pt solid black;
  height:12.75pt'><%=dt.Rows[i][0]%></td>
  <td class=xl67><%=dt.Rows[i][1]%></td>
  <td class=xl68><%=dt.Rows[i][2]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][3]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][4]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][5]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][6]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][7]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][8]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][9]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][10]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][11]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][12]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][13]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][14]%> </td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][15]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][16]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][17]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][18]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][19]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][20]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][21]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][22]%></td>
  <td class=xl69 align=right x:num><%=dt.Rows[i][23]%></td>
  <td class=xl81 align=right x:num><%=dt.Rows[i][24]%></td>
  <td class=xl81 align=right x:num><%=dt.Rows[i][25]%></td>
 </tr>
  <%
	}
          %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=34 style='width:26pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
