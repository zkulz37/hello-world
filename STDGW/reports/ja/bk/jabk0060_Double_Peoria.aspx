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
    string l_parameter="",l_parameter_tech="",l_tournament_name="",l_ranktype_name="",l_print_date="";
    l_parameter = "'" + l_rank_type + "','" + l_tournament + "','" + l_locker_name + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_sel_jabk00060_double_peoria", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	l_parameter_tech = "'" + l_rank_type + "','" + l_tournament + "'";
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
    string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy') print_date from dual";
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
<link rel=File-List href="jabk0060_Double_Peoria_files/filelist.xml">
<link rel=Edit-Time-Data href="jabk0060_Double_Peoria_files/editdata.mso">
<link rel=OLE-Object-Data href="jabk0060_Double_Peoria_files/oledata.mso">
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
  <o:LastPrinted>2010-12-02T08:16:44Z</o:LastPrinted>
  <o:Created>2010-11-08T11:02:05Z</o:Created>
  <o:LastSaved>2010-12-02T08:18:15Z</o:LastSaved>
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
	mso-footer-margin:.5in;}
.font8
	{color:windowtext;
	font-size:8.0pt;
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
	font-family:Arial, sans-serif;
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl54
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>16</x:ActiveCol>
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
  <x:Formula>=Sheet1!$1:$15</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=578 style='border-collapse:
 collapse;table-layout:fixed;width:435pt'>
 <col width=29 style='mso-width-source:userset;mso-width-alt:1060;width:22pt'>
 <col width=125 style='mso-width-source:userset;mso-width-alt:4571;width:94pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=23 span=3 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=23 style='mso-width-source:userset;mso-width-alt:841;width:17pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=38 style='mso-width-source:userset;mso-width-alt:1389;width:29pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <tr height=70 style='mso-height-source:userset;height:52.5pt'>
  <td colspan=2 height=70 class=xl37 width=154 style='height:52.5pt;width:116pt'>AMB
  - VINA</td>
  <td colspan=13 class=xl38 width=337 style='width:253pt'><%=l_tournament_name %></td>
  <td colspan=2 height=70 width=87 style='height:52.5pt;width:66pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:0;margin-top:.75pt;width:65.25pt;
   height:50.25pt;z-index:1'>
   <v:imagedata src="jabk0060_Double_Peoria_files/image001.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:1px;width:87px;
  height:67px'><img width=87 height=67
  src="jabk0060_Double_Peoria_files/image002.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=70 class=xl39 width=87 style='height:52.5pt;
    width:66pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl40 style='height:18.0pt'></td>
  <td colspan=13 class=xl38><%=l_ranktype_name %></td>
  <td colspan=2 class=xl56><%=l_print_date %></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=8 height=24 class=xl42 style='height:18.0pt'>Handicap limit:</td>
  <td colspan=9 class=xl38></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl44 style='height:18.0pt'><span
  style='mso-spacerun:yes'>  </span>Men</td>
  <td colspan=6 class=xl44 style='border-left:none'>Female:</td>
  <td colspan=9 class=xl38></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl43 style='height:18.0pt'>Max: ………</td>
  <td colspan=6 class=xl43 style='border-left:none'>Max…………</td>
  <td colspan=9 class=xl38></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl43 style='height:18.0pt'>Min:<span
  style='mso-spacerun:yes'>  </span>………</td>
  <td colspan=6 class=xl43 style='border-left:none'>Min:<span
  style='mso-spacerun:yes'>  </span>………</td>
  <td colspan=9 class=xl38></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=17 height=19 class=xl40 style='height:14.25pt'></td>
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
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl24 style='border-right:.5pt solid black;
  height:18.0pt'>Gross Score :<span style='mso-spacerun:yes'>  </span><font
  class="font9"><%=Tech_name%></font></td>
  <td colspan=2 class=xl27 style='border-right:.5pt solid black;border-left:
  none'>Score</td>
  <td colspan=2 class=xl29 style='border-right:.5pt solid black;border-left:
  none' x:num><%=Tech_Score%></td>
  <td colspan=3 class=xl27 style='border-right:.5pt solid black;border-left:
  none'>Different</td>
  <td colspan=5 class=xl29 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
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
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl24 style='border-right:.5pt solid black;
  height:18.0pt'>ONAMI :<font class="font8"><span style='mso-spacerun:yes'> 
  </span><%=Tech_name1%></font></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>OUT :<font class="font8"><%=Tech_Out_Score1%></font></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>IN :<font class="font8"> <%=Tech_In_Score1%></font></td>
  <td colspan=3 class=xl29 style='border-right:.5pt solid black;border-left:
  none' x:num><%=Strat_Hole1_score%></td>
  <td colspan=5 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>START :<font class="font8"><%=str_l_start1%></font></td>
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
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl24 style='border-right:.5pt solid black;
  height:18.0pt'>KONAMI :<font class="font8"><span style='mso-spacerun:yes'> 
  </span><%=Tech_name2%></font></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>OUT :<font class="font8"><%=Tech_Out_Score2%></font></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>IN : <font class="font8"><%=Tech_In_Score2%></font></td>
  <td colspan=3 class=xl29 style='border-right:.5pt solid black;border-left:
  none' x:num><%=Strat_Hole1_score2%></td>
  <td colspan=5 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>START :<font class="font8"><%=str_l_start2%></font></td>
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
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl24 style='border-right:.5pt solid black;
  height:18.0pt'>SUIHEI :<font class="font8"><span style='mso-spacerun:yes'> 
  </span><%=Tech_name3%></font></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>OUT :<font class="font8"><%=Tech_Out_Score3%></font></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>IN :<font class="font8"> <%=Tech_In_Score3%></font></td>
  <td colspan=3 class=xl29 style='border-right:.5pt solid black;border-left:
  none' x:num><%=Strat_Hole1_score3%></td>
  <td colspan=5 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>START :<font class="font8"><%=str_l_start3%></font></td>
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
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl24 style='border-right:.5pt solid black;
  height:18.0pt'>BOOBY :<font class="font8"><span style='mso-spacerun:yes'> 
  </span><%=Tech_name4%></font></td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>Net</td>
  <td colspan=2 class=xl53 style='border-right:.5pt solid black;border-left:
  none' x:num><%=Tech_Net4%></td>
  <td colspan=3 class=xl29 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=5 class=xl29 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=17 height=21 class=xl41 style='height:15.75pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl45 style='height:25.5pt;border-top:none'>Rank</td>
  <td rowspan=2 class=xl45 style='border-top:none'>Golfer Name</td>
  <td colspan=12 class=xl45 style='border-left:none'>Peoria Handicap(Double)</td>
  <td rowspan=2 class=xl32 style='border-bottom:.5pt solid black;border-top:
  none'>Gross</td>
  <td rowspan=2 class=xl45 style='border-top:none'>H'Cap</td>
  <td rowspan=2 class=xl45 style='border-top:none'>Net</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=12 height=17 class=xl34 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Hidden holes: ( <%=dt.Rows[0][17]%> , <%=dt.Rows[0][18]%><span
  style='mso-spacerun:yes'>  </span>,<%=dt.Rows[0][19]%> , <%=dt.Rows[0][20]%> , <%=dt.Rows[0][21]%> , <%=dt.Rows[0][22]%> , <%=dt.Rows[0][23]%>, <%=dt.Rows[0][24]%> , <%=dt.Rows[0][25]%> , <%=dt.Rows[0][26]%> , <%=dt.Rows[0][27]%> , <%=dt.Rows[0][28]%> )</td>
 </tr>
 <%
     string under_line="";
	 string color="";
	 for (int i = 0; i < dt.Rows.Count; i++)
     {
		if((Tech_name == dt.Rows[i][1].ToString())||(Tech_name1 == dt.Rows[i][1].ToString())||(Tech_name2 == dt.Rows[i][1].ToString())||(Tech_name3 == dt.Rows[i][1].ToString())||(Tech_name4 == dt.Rows[i][1].ToString()))
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
  <td height=17 class=xl46 style='height:12.75pt;border-top:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][0]%></td>
  <td class=xl47 align=left style='border-top:none;border-left:none;<%=under_line%>;<%=color%>'><%=dt.Rows[i][1]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][10]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][11]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][12]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][13]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][14]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][2]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][15]%></td>
  <td class=xl48 align=right style='border-top:none;border-left:none;<%=under_line%>;<%=color%>' x:num><%=dt.Rows[i][16]%></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=50 style='width:38pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
