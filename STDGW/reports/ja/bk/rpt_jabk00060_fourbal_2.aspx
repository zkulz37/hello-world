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
    string l_parameter="",l_tournament_name="",l_ranktype_name="",l_print_date="",l_parameter_inearest_pin ="",l_parameter_longest_driver="",l_best_net="",l_parameter_gross="";
     l_parameter = "'" + l_rank_type + "','" + l_tournament + "','" + l_locker_name + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_jabk00060_fourball_2", l_parameter);
     DataTable  dt_cnt = ESysLib.TableReadOpenCursor("crm.sp_rpt_jabk00060_team_grp_fb", l_parameter);	
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string SQL2 = "select decode('" + l_rank_type+ "','10','HANDICAP DIVISION','20','CALLAWAY DIVISION','30','BEST GROSS','40','NEAREST PIN','50','LONGEST DRIVE','110','Four Ball') from dual";
    DataTable dt_ranktype = ESysLib.TableReadOpen(SQL2);
    if (dt_ranktype.Rows.Count > 0)
    {
        l_ranktype_name = dt_ranktype.Rows[0][0].ToString();
    }
    string SQL3 = "select to_char(sysdate,'Mon dd,yyyy') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString(); 
    }
    l_parameter_inearest_pin = "'" + l_tournament + "'," + 40 + "";
    DataTable dt_inearest_pin = ESysLib.TableReadOpenCursor("CRM.sp_jabk0060_nearest_pin", l_parameter_inearest_pin);
    l_parameter_longest_driver = "'" + l_tournament + "'," +50 +"";
    DataTable dt_longest_driver = ESysLib.TableReadOpenCursor("CRM.sp_jabk0060_nearest_pin", l_parameter_longest_driver);	
    
	string  SQL_best_net = "select min(a.net) net,min(a.golfer_name) golfer_name  from crm.tgm_tournament_result a, tgm_visitorfee_golfer b where a.del_if = 0 and a.rank_type = '" + l_rank_type+ "' and a.tgm_tournament_pk = '" + l_tournament + "' and a.tgm_visitorfee_golfer_pk = b.pk and a.gross > 0 and a.hdcp > 0 order by net,hdcp,gross,hole18,hole17";
    DataTable  dt_best_net = ESysLib.TableReadOpen(SQL_best_net);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_best_net = dt_best_net.Rows[0][1].ToString(); 
    }
	
    string SQL_tournament = " SELECT REGEXP_REPLACE (A.EVENT_NAME, '<[^>]+>', NULL) FROM CRM.TGM_TOURNAMENT A WHERE A.DEL_IF =0 and A.PK ='" + l_tournament+ "'";
    DataTable dt_tournament = ESysLib.TableReadOpen(SQL_tournament);
    if (dt_tournament.Rows.Count > 0)
    {
        l_tournament_name = dt_tournament.Rows[0][0].ToString();
    }	
    
     l_parameter_gross = "'" + l_tournament + "'," + l_rank_type + "";    
    DataTable dt_BestGross = ESysLib.TableReadOpenCursor("CRM.sp_jabk0060_lkp_by_rank_type", l_parameter_gross);	
	
      DataTable dtA = ESysLib.TableReadOpenCursor("crm.sp_rpt_jabk00060_hdcp_a_new", l_parameter);
    
    DataTable dtB = ESysLib.TableReadOpenCursor("crm.sp_rpt_jabk00060_hdcp_b_new", l_parameter);
    
    DataTable dtC = ESysLib.TableReadOpenCursor("crm.sp_rpt_jabk00060_hdcp_c_new", l_parameter);	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_jabk00060_fourbal_2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_jabk00060_fourbal_2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_jabk00060_fourbal_2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nhat</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-05-27T10:14:12Z</o:LastPrinted>
  <o:Created>2011-05-24T01:03:43Z</o:Created>
  <o:LastSaved>2011-05-27T10:14:46Z</o:LastSaved>
  <o:Company>housekeeping</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.32in .3in .75in .34in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;}
.font5
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
.xl24
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ \;\[Red\]\\-\#\,\#\#0\\ ";
	text-align:center;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>-3</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10440</x:WindowHeight>
  <x:WindowWidth>17280</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>0</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1410 style='border-collapse:
 collapse;table-layout:fixed;width:1059pt'>
 <col class=xl25 width=202 style='mso-width-source:userset;mso-width-alt:7387;
 width:152pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=219 style='mso-width-source:userset;mso-width-alt:8009;
 width:164pt'>
 <col class=xl25 width=64 span=2 style='width:48pt'>
 <col class=xl25 width=174 style='mso-width-source:userset;mso-width-alt:6363;
 width:131pt'>
 <col class=xl25 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl25 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl24 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl25 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=64 span=3 style='width:48pt'>
 <tr height=77 style='mso-height-source:userset;height:57.75pt'>
  <td height=77 width=202 style='height:57.75pt;width:152pt' align=left
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
   margin-left:3pt;margin-top:3pt;width:102.75pt;height:50.25pt;z-index:1'>
   <v:imagedata src="rpt_jabk00060_fourbal_2_files/image001.jpg" o:title="HuynDai_Amco"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:4px;margin-top:4px;width:137px;
  height:67px'><img width=137 height=67
  src="rpt_jabk00060_fourbal_2_files/image001.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=77 class=xl26 width=202 style='height:57.75pt;width:152pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 class=xl37 width=805 style='width:604pt'><%=l_tournament_name%></td>
  <td width=120 style='width:90pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:1.5pt;
   margin-top:4.5pt;width:86.25pt;height:51.75pt;z-index:2'>
   <v:imagedata src="rpt_jabk00060_fourbal_2_files/image002.jpg" o:title="image002"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:2px;margin-top:6px;width:115px;
  height:69px'><img width=115 height=69
  src="rpt_jabk00060_fourbal_2_files/image003.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=77 class=xl26 width=120 style='height:57.75pt;width:90pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=49 style='width:37pt'></td>
  <td class=xl25 width=42 style='width:32pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=3 height=20 class=xl27 style='height:15.0pt'>Golf Operations:<font
  class="font5">&nbsp;&nbsp;&nbsp;<%=l_print_date%></font></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>Rank Type:</td>
  <td colspan=2 class=xl25><%=l_ranktype_name%></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl29 style='height:23.25pt'>PRIZE</td>
  <td class=xl29 style='border-left:none'>TEAM NO</td>
  <td class=xl29 style='border-left:none'>PLAYER’S NAME</td>
  <td class=xl29 style='border-left:none'>LOCKER</td>
  <td class=xl29 style='border-left:none'>GROSS</td>
  <td class=xl29 style='border-left:none'>TEAM GROSS SCORE</td>
  <td class=xl29 style='border-left:none'>HANDICAP</td>
  <td class=xl29 style='border-left:none'>TEAM HDCP</td>
  <td class=xl29 style='border-left:none'>NET</td>
  <td class=xl29 style='border-left:none'>TEAM NET SCORE</td>
  <td colspan=2 class=xl40 style='border-left:none'>Max-3</td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <%
		 int j = 0;
		for (int i = 0; i < dt.Rows.Count; i++)
		 { 
			  %>
 <tr height=20 style='height:15.0pt'>
 <%
	if(i==0)
	{
  %>
  <td height=20 rowspan="<%=int.Parse(dt_cnt.Rows[j][2].ToString())%>" class=xl41 width=202 style='height:15.0pt;border-top:none;
  width:152pt'><%=dt.Rows[i][0]%></td>
  <td class=xl42 rowspan="<%=int.Parse(dt_cnt.Rows[j][2].ToString())%>" style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <%
	}
	else  if ( dt.Rows[i][1].ToString()!=dt.Rows[i-1][1].ToString())
	{
	%>
	<td height=20 rowspan="<%=int.Parse(dt_cnt.Rows[j][2].ToString())%>" class=xl41 width=202 style='height:15.0pt;border-top:none;
  width:152pt'><%=dt.Rows[i][0]%></td>
  <td class=xl42 rowspan="<%=int.Parse(dt_cnt.Rows[j][2].ToString())%>" style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
	<%
	}
	%>
  <td class=xl43 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
   <%
	if(i==0)
	{
  %>
  <td class=xl46 rowspan="<%=int.Parse(dt_cnt.Rows[j][2].ToString())%>" align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
   <%
	}
	else  if ( dt.Rows[i][1].ToString()!=dt.Rows[i-1][1].ToString())
	{
	%>
	<td class=xl46 rowspan="<%=int.Parse(dt_cnt.Rows[j][2].ToString())%>" align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
	<%
	}
	%>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6]%></td>
   <%
	if(i==0)
	{
  %>
  <td class=xl46 rowspan="<%=int.Parse(dt_cnt.Rows[j][2].ToString())%>" align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7]%></td>
  <%
	}
	else  if ( dt.Rows[i][1].ToString()!=dt.Rows[i-1][1].ToString())
	{
	%>
	<td class=xl46 rowspan="<%=int.Parse(dt_cnt.Rows[j][2].ToString())%>" align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7]%></td>
	<%
	}
	%>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8]%></td>
  <%
	if(i==0)
	{
  %>
  <td class=xl46 rowspan="<%=int.Parse(dt_cnt.Rows[j++][2].ToString())%>" align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
  <%
	}
	else  if ( dt.Rows[i][1].ToString()!=dt.Rows[i-1][1].ToString())
	{
	%>
	<td class=xl46 rowspan="<%=int.Parse(dt_cnt.Rows[j++][2].ToString())%>" align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
	<%
	}
	%>
  <td class=xl47 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10]%> </td>
  <td class=xl47 style='border-top:none;border-left:none' x:num><font
  color="#FF0000" style='mso-ignore:color'><%=dt.Rows[i][11]%></font></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%}%>
 <tr height=20 style='height:15.0pt'>
  <td colspan=12 height=20 class=xl38 style='border-right:.5pt solid black;
  height:15.0pt'>&nbsp;</td>
  <td class=xl24></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl29 style='height:23.25pt;border-top:none'>PRIZE</td>
  <td class=xl30 style='border-top:none'>TEAM NO</td>
  <td class=xl30 style='border-top:none'>PLAYER’S NAME</td>
  <td class=xl30 style='border-top:none'>LOCKER</td>
  <td class=xl30 style='border-top:none'>GROSS</td>
  <td class=xl30 style='border-top:none'>TEAM GROSS SCORE</td>
  <td class=xl30 style='border-top:none'>HANDICAP</td>
  <td class=xl30 style='border-top:none'>TEAM HDCP</td>
  <td class=xl30 style='border-top:none'>NET</td>
  <td class=xl30 colspan=3 style='border-top:none'>TEAM NET SCORE</td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string best_gross_name = "", best_gross_value = "",locker_no="",l_handicap="";
     if (dt_BestGross.Rows.Count == 0)
         {
             best_gross_name = "";
             best_gross_value = "";
	l_handicap="";
	locker_no="";
         }
         else if (dt_BestGross.Rows.Count > 0)
         {
             best_gross_name = dt_BestGross.Rows[0][0].ToString();
             best_gross_value = dt_BestGross.Rows[0][1].ToString();  
           l_handicap= dt_BestGross.Rows[0][2].ToString(); 
           locker_no= dt_BestGross.Rows[0][3].ToString(); 		   
         }
     %>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>Individual<font class="font11">
  Best Gross:<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32><%=best_gross_name%></td>
  <td class=xl34><%=locker_no%></td>
  <td class=xl34 x:num><%=best_gross_value%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 x:num><%=l_handicap%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 colspan=3 >&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string rank_a_name = "", rank_a_net = "",locker_a="",hdcp_a="",gross_a="";
         if (dtA.Rows.Count == 0)
         {
             rank_a_name = "";
             rank_a_net = "";
	locker_a="";
	hdcp_a="";
	gross_a="";	
         }
         else if (dtA.Rows.Count > 0)
         {
             rank_a_name = dtA.Rows[0][0].ToString();
	locker_a=dtA.Rows[0][1].ToString();
             rank_a_net = dtA.Rows[0][2].ToString();
	hdcp_a=dtA.Rows[0][3].ToString();
	gross_a=	dtA.Rows[0][4].ToString();
         }
          %>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>Individual <font class="font11">Best
  Net A(0~18)</font></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32><%=rank_a_name%></td>
  <td class=xl34><%=locker_a%></td>
  <td class=xl34 x:num><%=gross_a%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 x:num><%=hdcp_a%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 x:num><%=rank_a_net%></td>
  <td class=xl34 colspan=3>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string rank_b_name = "", rank_b_net = "",locker_b="",hdcp_b="",gross_b="";
         if (dtB.Rows.Count ==0)
         {
             rank_b_name = "";
	locker_b="";
             rank_b_net = "";
	 hdcp_b="";
	 gross_b="";
         }
         else if (dtB.Rows.Count > 0)
         {
		rank_b_name = dtB.Rows[0][0].ToString();
		locker_b= dtB.Rows[0][1].ToString();
		rank_b_net= dtB.Rows[0][2].ToString();
		 hdcp_b= dtB.Rows[0][3].ToString();
		 gross_b=dtB.Rows[0][4].ToString();
         }
          %>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl33 style='height:16.5pt'>Individual <font class="font11">Best
  Net B(19~28)</font></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32><%=rank_b_name%></td>
  <td class=xl34><%=locker_b%></td>
  <td class=xl34 x:num><%=gross_b%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 x:num><%=hdcp_b%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 x:num><%=rank_b_net%></td>
  <td class=xl34 colspan=3>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'>Nearest to the Pin #.......</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 colspan=3>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'>Longest Drive #...........</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 colspan=3>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl36 style='height:18.75pt'>Hole in one #......</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 colspan=3>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl25 style='height:31.5pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl25 style='height:31.5pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl25 style='height:31.5pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl25 style='height:31.5pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl25 style='height:31.5pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl25 style='height:31.5pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=202 style='width:152pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=219 style='width:164pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
