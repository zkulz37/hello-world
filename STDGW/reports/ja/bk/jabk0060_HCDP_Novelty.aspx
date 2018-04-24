﻿<%@ Page Language="C#"%>
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
    string l_parameter = "", l_tournament_name = "", l_ranktype_name = "", l_print_date = "", l_parameter_gross = "", l_parameter_inearest_pin = "", l_parameter_longest_driver = "", l_parameter_inearest_line="";
     l_parameter = "'" + l_rank_type + "','" + l_tournament + "','" + l_locker_name + "'";
     
    DataTable dtA = ESysLib.TableReadOpenCursor("crm.sp_sel_jabk00060_hcdp_a", l_parameter);
    
    DataTable dtB = ESysLib.TableReadOpenCursor("crm.sp_sel_jabk00060_hcdp_b", l_parameter);
    
    DataTable dtC = ESysLib.TableReadOpenCursor("crm.sp_sel_jabk00060_hcdp_c", l_parameter);

    l_parameter_gross = "'" + l_tournament + "'," + l_rank_type + "";    
    DataTable dt_BestGross = ESysLib.TableReadOpenCursor("CRM.sp_jabk0060_lkp_by_rank_type", l_parameter_gross);

    l_parameter_inearest_pin = "'" + l_tournament + "'," + 40 + "";
    DataTable dt_inearest_pin = ESysLib.TableReadOpenCursor("CRM.sp_jabk0060_nearest_pin", l_parameter_inearest_pin);

    l_parameter_longest_driver = "'" + l_tournament + "'," +50 +"";
    DataTable dt_longest_driver = ESysLib.TableReadOpenCursor("CRM.sp_jabk0060_nearest_pin", l_parameter_longest_driver);

    l_parameter_inearest_line = "'" + l_tournament + "'," + 60 + "";
    DataTable dt_inearest_line = ESysLib.TableReadOpenCursor("CRM.sp_jabk0060_nearest_pin", l_parameter_inearest_line); 
    
    if (dtA.Rows.Count == 0 && dtB.Rows.Count == 0 && dtC.Rows.Count == 0)
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
    
    string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy  hh24:mi') print_date from dual";
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
<link rel=File-List href="jabk0060_HCDP_Novelty_files/filelist.xml">
<link rel=Edit-Time-Data href="jabk0060_HCDP_Novelty_files/editdata.mso">
<link rel=OLE-Object-Data href="jabk0060_HCDP_Novelty_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>&#12363;&#12431;&#12373;&#12365;</o:Author>
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-11-23T09:47:29Z</o:LastPrinted>
  <o:Created>2006-11-24T11:52:50Z</o:Created>
  <o:LastSaved>2010-11-23T09:47:37Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .21in .22in .26in;
	mso-header-margin:.2in;
	mso-footer-margin:.2in;}
.font10
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
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
	font-family:"\FF2D\FF33 \FF30\30B4\30B7\30C3\30AF", monospace;
	mso-font-charset:128;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\FF2D\FF33 \FF30\30B4\30B7\30C3\30AF", monospace;
	mso-font-charset:128;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl32
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl35
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl36
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:10;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:right;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"General Date";
	text-align:right;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:"General Date";
	text-align:right;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"\.VnTime";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Ket Qua</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1147 style='border-collapse:
 collapse;table-layout:fixed;width:862pt'>
 <col width=141 style='mso-width-source:userset;mso-width-alt:4512;width:106pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:1792;width:42pt'>
 <col width=72 style='width:54pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:1984;width:47pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1568;width:37pt'>
 <col width=72 style='width:54pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1568;width:37pt'>
 <col width=72 style='width:54pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2496;width:59pt'>
 <col width=72 style='width:54pt'>
 <col width=64 style='mso-width-source:userset;mso-width-alt:2048;width:48pt'>
 <col width=72 span=5 style='width:54pt'>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td rowspan=2 height=101 width=141 style='height:75.75pt;width:106pt'
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
   margin-left:1.5pt;margin-top:2.25pt;width:102.75pt;height:50.25pt;z-index:2'>
   <v:imagedata src="jabk0060_HCDP_Novelty_files/huyndai_amco.jpg" o:title="huyndai_amco"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:2px;margin-top:3px;width:137px;
  height:67px'><img width=137 height=67 src="jabk0060_HCDP_Novelty_files/huyndai_amco.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=101 class=xl39 width=141 style='height:75.75pt;
    width:106pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 rowspan=2 class=xl45 width=510 style='width:384pt'><%=l_tournament_name %></td>
  <td colspan=2 rowspan=2 height=101 width=136 style='height:75.75pt;
  width:102pt' align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
   margin-left:0;margin-top:2.25pt;width:99.75pt;height:72.75pt;z-index:1'>
   <v:imagedata src="jabk0060_HCDP_Novelty_files/image001.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:3px;width:133px;
  height:97px'><img width=133 height=97
  src="jabk0060_HCDP_Novelty_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 rowspan=2 height=101 class=xl41 width=136 style='height:75.75pt;
    width:102pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=72 style='width:54pt'></td>
  <td class=xl24 width=72 style='width:54pt'></td>
  <td class=xl24 width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <tr height=66 style='mso-height-source:userset;height:49.5pt'>
  <td height=66 colspan=3 class=xl24 style='height:49.5pt;mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=7 height=21 class=xl37 style='height:15.75pt'>Division A :</td>
  <td colspan=2 class=xl42>Print Date:</td>
  <td colspan=2 class=xl43 x:num><%=l_print_date %></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=11 height=17 class=xl33 style='height:12.75pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string rank_A1_name = "", rank_A1_net = "";
         if (dtA.Rows.Count == 0)
         {
             rank_A1_name = "";
             rank_A1_net = "";
         }
         else if (dtA.Rows.Count > 0)
         {
             rank_A1_name = dtA.Rows[0][1].ToString();
             rank_A1_net = dtA.Rows[0][25].ToString();   
         }
          %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl36 style='height:15.0pt'
  x:str="Champion A  : ">Champion A<span style='mso-spacerun:yes'> 
  </span>:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl31><%=rank_A1_name%></td>
  <td colspan=2 class=xl30>Net Score :</td>
  <td class=xl25 x:num><%=rank_A1_net%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=11 height=17 class=xl26 style='height:12.75pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string rank_A2_name = "", rank_A2_net = "";
         if (dtA.Rows.Count < 2)
         {
             rank_A2_name = "";
             rank_A2_net = "";
         }
         else if (dtA.Rows.Count > 1)
         {
             rank_A2_name = dtA.Rows[1][1].ToString();
             rank_A2_net = dtA.Rows[1][25].ToString();   
         }
          %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl36 style='height:15.0pt'>1<font class="font14"><sup>st</sup></font><font
  class="font10"> Runner Up:</font></td>
  <td colspan=6 class=xl26><%=rank_A2_name%></td>
  <td colspan=2 class=xl30>Net Score :</td>
  <td class=xl25 x:num><%=rank_A2_net%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=11 height=20 class=xl26 style='height:15.0pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <%
     string rank_A3_name = "", rank_A3_net = "";
         if (dtA.Rows.Count < 3)
         {
             rank_A3_name = "";
             rank_A3_net = "";
         }
         else if (dtA.Rows.Count > 2)
         {
             rank_A3_name = dtA.Rows[2][1].ToString();
             rank_A3_net = dtA.Rows[2][25].ToString();   
         }
          %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl36 style='height:15.0pt'>2<font class="font14"><sup>nd</sup></font><font
  class="font10"> Runer Up:</font></td>
  <td colspan=6 class=xl26><%=rank_A3_name%></td>
  <td colspan=2 class=xl30>Net Score :</td>
  <td class=xl25 x:num><%=rank_A3_net%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=11 height=16 class=xl26 style='height:12.0pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=11 height=21 class=xl37 style='height:15.75pt'>Division B :</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=11 height=20 class=xl33 style='height:15.0pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
  <%
     string rank_B_1_name = "", rank_B1_net = "";
         if (dtB.Rows.Count ==0)
         {
             rank_B_1_name = "";
             rank_B1_net = "";
         }
         else if (dtB.Rows.Count > 0)
         {
             rank_B_1_name = dtB.Rows[0][1].ToString();
             rank_B1_net = dtB.Rows[0][25].ToString();   
         }
          %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl38 style='height:15.0pt'>Champion B<span
  style='mso-spacerun:yes'>  </span>:</td>
  <td colspan=6 class=xl26><%=rank_B_1_name%></td>
  <td colspan=2 class=xl30>Net Score :</td>
  <td class=xl25 x:num><%=rank_B1_net%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=11 height=20 class=xl26 style='height:15.0pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
  <%
     string rank_B2_name = "", rank_B2_net = "";
         if (dtB.Rows.Count < 2)
         {
             rank_B2_name = "";
             rank_B2_net = "";
         }
         else if (dtB.Rows.Count > 1)
         {
             rank_B2_name = dtB.Rows[1][1].ToString();
             rank_B2_net = dtB.Rows[1][25].ToString();   
         }
          %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl36 style='height:15.0pt'>1<font class="font14"><sup>st</sup></font><font
  class="font10"> Runner Up:</font></td>
  <td colspan=6 class=xl26><%=rank_B2_name%></td>
  <td colspan=2 class=xl30>Net Score :</td>
  <td class=xl25 x:num><%=rank_B2_net%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=11 height=20 class=xl26 style='height:15.0pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
  <%
     string rank_B3_name = "", rank_B3_net = "";
         if (dtB.Rows.Count < 3)
         {
             rank_B3_name = "";
             rank_B3_net = "";
         }
         else if (dtB.Rows.Count > 2)
         {
             rank_B3_name = dtB.Rows[2][1].ToString();
             rank_B3_net = dtB.Rows[2][25].ToString();   
         }
          %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl36 style='height:15.0pt'>2<font class="font14"><sup>nd</sup></font><font
  class="font10"> Runer Up:</font></td>
  <td colspan=6 class=xl26><%=rank_B3_name%></td>
  <td colspan=2 class=xl30>Net Score :</td>
  <td class=xl25 x:num><%=rank_B3_net%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=11 height=18 class=xl33 style='height:13.5pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=11 height=21 class=xl37 style='height:15.75pt'>Division C :</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=11 height=20 class=xl33 style='height:15.0pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
  <%
     string rank_C_1_name = "", rank_C1_net = "";
         if (dtC.Rows.Count == 0)
         {
             rank_C_1_name = "";
             rank_C1_net = "";
         }
         else if (dtC.Rows.Count > 0)
         {
             rank_C_1_name = dtC.Rows[0][1].ToString();
             rank_C1_net = dtC.Rows[0][25].ToString();   
         }
          %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl38 style='height:15.0pt'>Champion C<span
  style='mso-spacerun:yes'>  </span>:</td>
  <td colspan=6 class=xl26><%=rank_C_1_name%></td>
  <td colspan=2 class=xl30>Net Score :</td>
  <td class=xl25 x:num><%=rank_C1_net%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=11 height=16 class=xl26 style='height:12.0pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string rank_C_2_name = "", rank_C2_net = "";
         if (dtC.Rows.Count < 2)
         {
             rank_C_2_name = "";
             rank_C2_net = "";
         }
         else if (dtC.Rows.Count > 1)
         {
             rank_C_2_name = dtC.Rows[1][1].ToString();
             rank_C2_net = dtC.Rows[1][25].ToString();   
         }
          %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl36 style='height:15.0pt'>1<font class="font14"><sup>st</sup></font><font
  class="font10"> Runner Up:</font></td>
  <td colspan=6 class=xl26><%=rank_C_2_name%></td>
  <td colspan=2 class=xl30>Net Score :</td>
  <td class=xl25 x:num><%=rank_C2_net%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=11 height=16 class=xl26 style='height:12.0pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
  <%
     string rank_C_3_name = "", rank_C3_net = "";
         if (dtC.Rows.Count < 3)
         {
             rank_C_3_name = "";
             rank_C3_net = "";
         }
         else if (dtC.Rows.Count > 2)
         {
             rank_C_3_name = dtC.Rows[2][1].ToString();
             rank_C3_net = dtC.Rows[2][25].ToString();   
         }
          %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl36 style='height:15.0pt'>2<font class="font14"><sup>nd
  </sup></font><font class="font10">Runer Up:</font></td>
  <td colspan=6 class=xl26><%=rank_C_3_name%></td>
  <td colspan=2 class=xl30>Net Score :</td>
  <td class=xl25 x:num><%=rank_C3_net%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=11 height=16 class=xl26 style='height:12.0pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
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
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl34 style='height:21.0pt'>Best Gross:</td>
  <td colspan=6 class=xl26><%=best_gross_name%></td>
  <td colspan=2 class=xl35>Gross:</td>
  <td class=xl26 x:num><%=best_gross_value%></td>
  <td class=xl28></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td colspan=11 height=15 class=xl33 style='height:11.25pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string inearest_pin_name1 = "", inearest_pin_value1 = "";
     if (dt_inearest_pin.Rows.Count == 0)
         {
             inearest_pin_name1 = "";
             inearest_pin_value1 = "";
         }
         else if (dt_inearest_pin.Rows.Count > 0)
         {
             inearest_pin_name1 = dt_inearest_pin.Rows[0][0].ToString();
             inearest_pin_value1 = dt_inearest_pin.Rows[0][1].ToString();   
         }
     %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl30 style='height:15.0pt'>Nearest To The
  Pin<span style='mso-spacerun:yes'>  </span>Hole #<span
  style='mso-spacerun:yes'>  </span>03</td>
  <td colspan=6 class=xl31><%=inearest_pin_name1%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=11 height=16 class=xl30 style='height:12.0pt'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
  <%
     string inearest_pin_name2 = "", inearest_pin_value2 = "";
     if (dt_inearest_pin.Rows.Count <2)
     {
         inearest_pin_name2 = "";
         inearest_pin_value2 = "";
     }
     else if (dt_inearest_pin.Rows.Count > 1)
     {
         inearest_pin_name2 = dt_inearest_pin.Rows[1][0].ToString();
         inearest_pin_value2 = dt_inearest_pin.Rows[1][1].ToString();
     }
     %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl30 style='height:15.0pt'>Nearest To The
  Pin<span style='mso-spacerun:yes'>  </span>Hole #<span
  style='mso-spacerun:yes'>  </span>06</td>
  <td colspan=6 class=xl31><%=inearest_pin_name2%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td colspan=11 height=15 class=xl30 style='height:11.25pt'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <%
     string inearest_pin_name3 = "", inearest_pin_value3 = "";
     if (dt_inearest_pin.Rows.Count < 3)
     {
         inearest_pin_name3 = "";
         inearest_pin_value3 = "";
     }
     else if (dt_inearest_pin.Rows.Count > 2)
     {
         inearest_pin_name3 = dt_inearest_pin.Rows[2][0].ToString();
         inearest_pin_value3 = dt_inearest_pin.Rows[2][1].ToString();
     }
     %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl30 style='height:15.0pt'>Nearest To The
  Pin<span style='mso-spacerun:yes'>  </span>Hole #<span
  style='mso-spacerun:yes'>  </span>12</td>
  <td colspan=6 class=xl31><%=inearest_pin_name3%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=11 height=16 class=xl30 style='height:12.0pt'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <%
     string inearest_pin_name4 = "", inearest_pin_value4 = "";
     if (dt_inearest_pin.Rows.Count < 4)
     {
         inearest_pin_name4 = "";
         inearest_pin_value4 = "";
     }
     else if (dt_inearest_pin.Rows.Count > 3)
     {
         inearest_pin_name4 = dt_inearest_pin.Rows[3][0].ToString();
         inearest_pin_value4 = dt_inearest_pin.Rows[3][1].ToString();
     }
     %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl30 style='height:15.0pt'>Nearest To The
  Pin<span style='mso-spacerun:yes'>  </span>Hole #<span
  style='mso-spacerun:yes'>  </span>17</td>
  <td colspan=6 class=xl31><%=inearest_pin_name4%></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td colspan=11 height=13 class=xl30 style='height:9.75pt'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <%
     string longest_driver_name1 = "", longest_driver_value1 = "";
     if (dt_longest_driver.Rows.Count ==0)
     {
         longest_driver_name1 = "";
         longest_driver_value1 = "";
     }
     else if (dt_longest_driver.Rows.Count > 0)
     {
         longest_driver_name1 = dt_longest_driver.Rows[0][0].ToString();
         longest_driver_value1 = dt_longest_driver.Rows[0][1].ToString();
     }
     %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl30 style='height:15.0pt'>Longest Drive For
  Hole<span style='mso-spacerun:yes'>  </span>#<span style='mso-spacerun:yes'> 
  </span>05</td>
  <td colspan=6 class=xl31><%=longest_driver_name1 %></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=11 height=18 class=xl32 style='height:13.5pt'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <%
     string longest_driver_name2 = "", longest_driver_value2 = "";
     if (dt_longest_driver.Rows.Count < 0)
     {
         longest_driver_name2 = "";
         longest_driver_value2 = "";
     }
     else if (dt_longest_driver.Rows.Count > 1)
     {
         longest_driver_name2 = dt_longest_driver.Rows[1][0].ToString();
         longest_driver_value2 = dt_longest_driver.Rows[1][1].ToString();
     }
     %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl30 style='height:15.0pt'>Longest Drive Hole #
  9</td>
  <td colspan=6 class=xl31><%=longest_driver_name2 %></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=11 height=20 class=xl32 style='height:15.0pt'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <%
     string longest_driver_name3 = "", longest_driver_value3 = "";
     if (dt_longest_driver.Rows.Count < 3)
     {
         longest_driver_name3 = "";
         longest_driver_value3 = "";
     }
     else if (dt_longest_driver.Rows.Count > 2)
     {
         longest_driver_name3 = dt_longest_driver.Rows[2][0].ToString();
         longest_driver_value3 = dt_longest_driver.Rows[2][1].ToString();
     }
     %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl30 style='height:15.0pt'>Longest Drive Hole #
  14</td>
  <td colspan=6 class=xl31><%=longest_driver_name3 %></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td colspan=11 height=14 class=xl32 style='height:10.5pt'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
  <%
     string longest_driver_name4 = "", longest_driver_value4 = "";
     if (dt_longest_driver.Rows.Count < 4)
     {
         longest_driver_name4 = "";
         longest_driver_value4 = "";
     }
     else if (dt_longest_driver.Rows.Count > 3)
     {
         longest_driver_name4 = dt_longest_driver.Rows[3][0].ToString();
         longest_driver_value4 = dt_longest_driver.Rows[3][1].ToString();
     }
     %>
 <tr height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl30 style='height:15.0pt'>Longest Drive Hole #
  18</td>
  <td colspan=6 class=xl31><%=longest_driver_name4 %></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 colspan=16 style='height:9.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=141 style='width:106pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=64 style='width:48pt'></td>
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