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
	string l_report = Request["p_report"];
    string l_parameter="",l_parameter1="",l_parameter_tech="",l_tournament_name="",l_ranktype_name="",l_print_date="";
    l_parameter = "'" + l_rank_type + "','" + l_tournament + "','" + l_locker_name + "'";
	l_parameter1 = "'" + l_rank_type + "','" + l_tournament + "','" + l_locker_name + "','"+l_report+"'";
	l_parameter_tech = "'" + l_rank_type + "','" + l_tournament + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_sel_jabk00060_peoria", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	 DataTable dt_peoria_dtl = ESysLib.TableReadOpenCursor("crm.sp_rpt_jabk00060", l_parameter1);
    if (dt_peoria_dtl.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	DataTable dt_peoria_tech = ESysLib.TableReadOpenCursor("crm.sp_sel_jabk00060_peoria_tech", l_parameter_tech);
    string SQL1 = " SELECT REGEXP_REPLACE (A.EVENT_NAME, '<[^>]+>', NULL) FROM CRM.TGM_TOURNAMENT A WHERE A.DEL_IF =0 and A.PK ='" + l_tournament+ "'";
    DataTable dt_tournament = ESysLib.TableReadOpen(SQL1);
    if (dt_tournament.Rows.Count > 0)
    {
        l_tournament_name = dt_tournament.Rows[0][0].ToString();
    }
    string SQL2 = " SELECT  NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'TNMFMT'  and CODE ='" + l_rank_type+ "'";
    
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
<link rel=File-List href="jabk0060_HCDP_Peoria_Detail_Single_files/filelist.xml">
<link rel=Edit-Time-Data
href="jabk0060_HCDP_Peoria_Detail_Single_files/editdata.mso">
<link rel=OLE-Object-Data
href="jabk0060_HCDP_Peoria_Detail_Single_files/oledata.mso">
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
  <o:LastPrinted>2010-12-02T09:16:58Z</o:LastPrinted>
  <o:Created>2010-11-08T11:02:05Z</o:Created>
  <o:LastSaved>2010-12-02T09:17:03Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&RPage &P";
	margin:.2in .2in .2in .2in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
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
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:right;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"General Date";
	text-align:right;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>26</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Recovered_Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>23</x:ActiveCol>
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
  <x:Formula>=Sheet1!$1:$16</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=711 style='border-collapse:
 collapse;table-layout:fixed;width:529pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:4352;width:89pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=26 style='mso-width-source:userset;mso-width-alt:950;width:20pt'>
 <col width=23 span=8 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=23 span=9 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col width=36 style='mso-width-source:userset;mso-width-alt:1316;width:27pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=28 style='mso-width-source:userset;mso-width-alt:1024;width:21pt'>
 <tr height=76 style='mso-height-source:userset;height:57.0pt'>
  <td colspan=2 height=76 width=146 style='height:57.0pt;width:109pt'
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
  </v:shapetype><v:shape id="_x0000_s1030" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:3pt;width:102.75pt;height:50.25pt;z-index:2'>
   <v:imagedata src="jabk0060_HCDP_Peoria_Detail_Single_files/huyndai_amco.jpg" o:title="huyndai_amco"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:2px;margin-top:4px;width:137px;
  height:67px'><img width=137 height=67 src="jabk0060_HCDP_Peoria_Detail_Single_files/huyndai_amco.jpg" v:shapes="_x0000_s1030"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=76 class=xl73 width=146 style='height:57.0pt;
    width:109pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=19 class=xl33 width=445 style='width:330pt'><%=l_tournament_name %></td>
  <td colspan=4 height=76 width=120 style='height:57.0pt;width:90pt'
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
  </v:shapetype><v:shape id="_x0000_s1029" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:0;width:81.75pt;height:57pt;z-index:1'>
   <v:imagedata src="jabk0060_HCDP_Peoria_Detail_Single_files/image001.png"
    o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:109px;
  height:76px'><img width=109 height=76
  src="jabk0060_HCDP_Peoria_Detail_Single_files/image002.jpg" v:shapes="_x0000_s1029"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=4 height=76 class=xl37 width=120 style='height:57.0pt;
    width:90pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl36 style='height:15.0pt'></td>
  <td colspan=19 class=xl33><%=l_ranktype_name %></td>
  <td colspan=4 class=xl34 x:num><%=l_print_date %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=7 height=20 class=xl43 style='height:15.0pt'>Handicap limit:</td>
  <td colspan=18 class=xl38></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl44 style='height:15.0pt'><span
  style='mso-spacerun:yes'>� </span>Men</td>
  <td colspan=5 class=xl44 style='border-left:none'>Female</td>
  <td colspan=18 class=xl38></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl42 style='height:15.0pt'>Max: ���</td>
  <td colspan=5 class=xl42 style='border-left:none'>Max: ���</td>
  <td colspan=18 class=xl38></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl42 style='height:15.0pt'>Min:<span
  style='mso-spacerun:yes'>� </span>���</td>
  <td colspan=5 class=xl42 style='border-left:none'>Min:<span
  style='mso-spacerun:yes'>� </span>���</td>
  <td colspan=18 class=xl38></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=25 height=20 class=xl36 style='height:15.0pt'></td>
 </tr>
 <%
     string Tech_name = "", Tech_Score = "";
         if (dt_peoria_tech.Rows.Count ==0)
         {
             Tech_name = "";
             Tech_Score = "";
         }
         else if (dt_peoria_tech.Rows.Count > 0)
         {
             Tech_name = dt_peoria_tech.Rows[0][0].ToString();
             Tech_Score = dt_peoria_tech.Rows[0][1].ToString();   
         }
          %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl39 style='height:15.0pt'>GROSS :<font
  class="font9"> <%=Tech_name%></font></td>
  <td colspan=4 class=xl40 style='border-left:none'>Gross Score</td>
  <td colspan=4 class=xl41 style='border-left:none' x:num><%=Tech_Score%></td>
  <td colspan=5 class=xl40 style='border-left:none'>Different</td>
  <td colspan=8 class=xl47 style='border-left:none'>&nbsp;</td>
 </tr>
 <%
     string Tech_name1 = "", Tech_In_Score1 = "",Tech_Out_Score1 = "",Strat_Hole1_score="",str_l_start1="";
         if (dt_peoria_tech.Rows.Count < 2)
         {
             Tech_name1 = "";
			 Tech_In_Score1 = "";
			 Tech_Out_Score1 = "";
			 Strat_Hole1_score = "";
         }
         else if (dt_peoria_tech.Rows.Count > 1)
         {
             Tech_name1 = dt_peoria_tech.Rows[1][0].ToString();
             Tech_In_Score1 = dt_peoria_tech.Rows[1][3].ToString(); 
			 Tech_Out_Score1 = dt_peoria_tech.Rows[1][4].ToString();
             Strat_Hole1_score = dt_peoria_tech.Rows[1][1].ToString(); 
			if(Convert.ToDecimal(dt_peoria_tech.Rows[1][5])==0)
				{
					str_l_start1="";
				}
			else
				{
					if(Convert.ToDecimal(dt_peoria_tech.Rows[1][5]) <= 9)
					{
						str_l_start1="Out";
					}
					else
					{
						str_l_start1="IN";
					}
				}
         }
          %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl39 style='height:15.0pt'>ONAMI<span
  style='mso-spacerun:yes'>� </span>:<font class="font9"><%=Tech_name1%></font></td>
  <td colspan=4 class=xl45 style='border-left:none'>OUT :<font class="font10"><%=Tech_Out_Score1%></font></td>
  <td colspan=4 class=xl46 style='border-left:none'>IN :<font class="font0"><%=Tech_In_Score1%></font></td>
  <td colspan=5 class=xl47 style='border-left:none' x:num><%=Strat_Hole1_score%></td>
  <td colspan=8 class=xl48 style='border-left:none'>START :<font class="font9">
  <%=str_l_start1%></font></td>
 </tr>
 <%
     string Tech_name2 = "", Tech_In_Score2 = "",Tech_Out_Score2 = "",Strat_Hole1_score2="",str_l_start2="";
         if (dt_peoria_tech.Rows.Count < 3)
         {
             Tech_name2 = "";
			 Tech_In_Score2 = "";
			 Tech_Out_Score2 = "";
			 Strat_Hole1_score2 = "";
         }
         else if (dt_peoria_tech.Rows.Count > 2)
         {
             Tech_name2 = dt_peoria_tech.Rows[2][0].ToString();
             Tech_In_Score2 = dt_peoria_tech.Rows[2][3].ToString(); 
			 Tech_Out_Score2 = dt_peoria_tech.Rows[2][4].ToString();
             Strat_Hole1_score2 = dt_peoria_tech.Rows[2][1].ToString(); 
			 if(Convert.ToDecimal(dt_peoria_tech.Rows[2][5]) <= 9)
				{
					str_l_start2="Out";
				}
			else
				{
					str_l_start2="IN";
				}
         }
          %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl39 style='height:15.0pt'>KONAMI<font
  class="font9">:<%=Tech_name2%></font></td>
  <td colspan=4 class=xl45 style='border-left:none'>OUT :<font class="font10"><%=Tech_Out_Score2%></font></td>
  <td colspan=4 class=xl46 style='border-left:none'>IN :<font class="font0"><%=Tech_In_Score2%></font></td>
  <td colspan=5 class=xl47 style='border-left:none' x:num><%=Strat_Hole1_score2%></td>
  <td colspan=8 class=xl48 style='border-left:none'>START :<font class="font9">
  <%=str_l_start2%></font></td>
 </tr>
 <%
     string Tech_name3 = "", Tech_In_Score3 = "",Tech_Out_Score3 = "",Strat_Hole1_score3="",str_l_start3="";
         if (dt_peoria_tech.Rows.Count < 4)
         {
             Tech_name3 = "";
			 Tech_In_Score3 = "";
			 Tech_Out_Score3 = "";
			 Strat_Hole1_score3 = "";
         }
         else if (dt_peoria_tech.Rows.Count > 3)
         {
             Tech_name3 = dt_peoria_tech.Rows[3][0].ToString();
             Tech_In_Score3 = dt_peoria_tech.Rows[3][3].ToString(); 
			 Tech_Out_Score3 = dt_peoria_tech.Rows[3][4].ToString();
             Strat_Hole1_score3 = dt_peoria_tech.Rows[3][1].ToString(); 
			 if(Convert.ToDecimal(dt_peoria_tech.Rows[3][5]) <= 9)
				{
					str_l_start3="Out";
				}
			else
				{
					str_l_start3="IN";
				}
         }
          %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl39 style='height:15.0pt'>SUHEI<span
  style='mso-spacerun:yes'>�� </span>:<font class="font9"> <%=Tech_name3%></font></td>
  <td colspan=4 class=xl45 style='border-left:none'>OUT :<font class="font10">
  <%=Tech_Out_Score3%></font></td>
  <td colspan=4 class=xl46 style='border-left:none'>IN :<font class="font0"> <%=Tech_In_Score3%></font></td>
  <td colspan=5 class=xl47 style='border-left:none' x:num><%=Strat_Hole1_score3%></td>
  <td colspan=8 class=xl48 style='border-left:none'>START :<font class="font9">
  <%=str_l_start3%></font></td>
 </tr>
 <%
     string Tech_name4 = "", Tech_Net4 = "";
         if (dt_peoria_tech.Rows.Count < 5)
         {
             Tech_name4 = "";
			 Tech_Net4 = "";
         }
         else if (dt_peoria_tech.Rows.Count > 4)
         {
             Tech_name4 = dt_peoria_tech.Rows[4][0].ToString();
             Tech_Net4 = dt_peoria_tech.Rows[4][1].ToString(); 
         }
          %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl39 style='height:15.0pt'>BOOBY :<font
  class="font9"> <%=Tech_name4%></font></td>
  <td colspan=4 class=xl46 style='border-left:none'>Net</td>
  <td colspan=4 class=xl41 style='border-left:none' x:num><%=Tech_Net4%></td>
  <td colspan=13 class=xl47 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=25 height=18 class=xl49 style='height:13.5pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=3 height=51 class=xl30 style='height:38.25pt;border-top:none'>Rank</td>
  <td rowspan=3 class=xl30 style='border-top:none'>Golfer Name</td>
  <td colspan=20 class=xl30 style='border-left:none'>Peoria Handicap(Single)</td>
  <td rowspan=3 class=xl31 style='border-top:none'>Gross</td>
  <td rowspan=3 class=xl30 style='border-top:none'>H'Cap</td>
  <td rowspan=3 class=xl30 style='border-top:none'>Net</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=20 height=17 class=xl30 style='height:12.75pt;border-left:none'>Hidden
  holes:( <%=dt.Rows[0][11]%> , <%=dt.Rows[0][12]%> <span style='mso-spacerun:yes'>� </span>,<%=dt.Rows[0][13]%>,<%=dt.Rows[0][14]%> ,<%=dt.Rows[0][15]%> ,<%=dt.Rows[0][16]%><span
  style='mso-spacerun:yes'>� </span>)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 align=right style='height:12.75pt;border-top:none;
  border-left:none' x:num>1</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl24 style='border-top:none;border-left:none'>OUT</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>11</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>12</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>13</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>14</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>15</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>16</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>17</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num>18</td>
  <td class=xl24 style='border-top:none;border-left:none'>IN</td>
 </tr>
 <%
     string under_line="";
	  string color="";
	 for (int i = 0; i < dt_peoria_dtl.Rows.Count; i++)
     {
		if((Tech_name == dt_peoria_dtl.Rows[i][3].ToString())||(Tech_name1 == dt_peoria_dtl.Rows[i][3].ToString())||(Tech_name2 == dt_peoria_dtl.Rows[i][3].ToString())||(Tech_name3 == dt_peoria_dtl.Rows[i][3].ToString())||(Tech_name4 == dt_peoria_dtl.Rows[i][3].ToString()))
		  {
			under_line="text-decoration:underline";
			color="color:fuchsia";
		  }
		  else
		  {
			under_line="";
			color="";
		  }
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][1]%></td>
  <td class=xl26 style='border-top:none;border-left:none;<%=under_line%>;<%=color%>'><%=dt_peoria_dtl.Rows[i][3]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][11]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][12]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][13]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][14]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][15]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][16]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][17]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][18]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][19]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][20]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][21]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][22]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][23]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][24]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][25]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][26]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][27]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][28]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][29]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][30]%></td>
  <td class=xl28 style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][8]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][9]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt_peoria_dtl.Rows[i][10]%></td>
 </tr>
 <%
 }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=36 style='width:27pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=28 style='width:21pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
