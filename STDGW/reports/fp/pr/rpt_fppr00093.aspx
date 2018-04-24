<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html 
xmlns:v="urn:schemas-microsoft-com:vml" 
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string from_dt = Request.QueryString["p_from_date"];
    string factory = Request.QueryString["p_factory"];
    string factory_name = Request.QueryString["p_factory_name"];
    string date = from_dt.Substring(6, 2) + "/" + from_dt.Substring(4, 2) + "/" + from_dt.Substring(0, 4);
    string para = "'" + from_dt + "','" + factory + "'";
    DataTable dt1;
    dt1 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00093", para);  
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fppr00093_files/filelist.xml">
<link rel=Edit-Time-Data href="fppr00093_files/editdata.mso">
<link rel=OLE-Object-Data href="fppr00093_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2010-11-26T04:12:43Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-11-26T05:41:40Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
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
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
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
      <x:Scale>66</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$3:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1474 style='border-collapse:
 collapse;table-layout:fixed;width:1108pt'>
 <col width=64 style='width:48pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=89 span=2 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=64 style='width:48pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=64 span=13 style='width:48pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=21 height=33 class=xl30 width=1474 style='height:24.75pt;
  width:1108pt'>LINE TARGET <%= factory_name %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan="2">DATE:<%=date%> </td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td rowspan=2 height=34 class=xl31 style='height:25.5pt'>LINE</td>
  <td rowspan=2 class=xl35 width=86 style='width:65pt'>BUYER<br>
    VMO- NO</td>
  <td rowspan=2 class=xl31>SI#</td>
  <td rowspan=2 class=xl36 style='border-bottom:.5pt solid black'>SKETCH</td>
  <td rowspan=2 class=xl31>Q'TY</td>
  <td colspan=2 rowspan=2 class=xl31>TARGET</td>
  <td colspan=14 class=xl31 style='border-left:none'>TIME</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none;border-left:
  none' x:str="'08:30">08:30</td>
  <td class=xl26 style='border-top:none;border-left:none' x:str="'09:30">09:30</td>
  <td class=xl26 style='border-top:none;border-left:none' x:str="'10:30">10:30</td>
  <td class=xl26 style='border-top:none;border-left:none' x:str="'11:30">11:30</td>
  <td class=xl27 style='border-top:none;border-left:none'>TOTAL</td>
  <td class=xl26 style='border-top:none;border-left:none' x:str="'13:30">13:30</td>
  <td class=xl26 style='border-top:none;border-left:none' x:str="'14:30">14:30</td>
  <td class=xl26 style='border-top:none;border-left:none' x:str="'15:30">15:30</td>
  <td class=xl26 style='border-top:none;border-left:none' x:str="'17:30">17:30</td>
  <td class=xl27 style='border-top:none;border-left:none'>TOTAL</td>
  <td class=xl26 style='border-top:none;border-left:none' x:str="'18:30">18:30</td>
  <td class=xl26 style='border-top:none;border-left:none' x:num="0.8125">19:30</td>
  <td class=xl28 style='border-top:none;border-left:none'>TOTAL</td>
  <td class=xl26 style='border-top:none;border-left:none'>SUB TOTAL</td>
 </tr>
 <%
     if (dt1.Rows.Count > 0)
     {
         string st_line = "";
         st_line = dt1.Rows[0]["routing_group"].ToString();
         int int_count = 0;
         int i_index = 0;
         int[] intArray;
         intArray = new int[100];
         for (int j = 0; j < dt1.Rows.Count; j++)
         {
             if (dt1.Rows[j]["routing_group"].ToString() == st_line)
             {
                 int_count++;
             }
             else
             {
                 st_line = dt1.Rows[j]["routing_group"].ToString();
                 intArray[i_index] = int_count;
                 int_count = 1;
                 i_index++;
             }
         }
         intArray[i_index] = int_count;

         i_index = 0;
         st_line = "";
         for (int i = 0; i < dt1.Rows.Count; i++)
         {
     
%>      
 <tr class=xl29 height=17 style='height:12.75pt'>
  <%
    if(dt1.Rows[i]["routing_group"].ToString() != st_line)
    {
  %>
  <td rowspan=<%=intArray[i_index] * 4 %> height=68 class=xl32 style='border-bottom:.5pt solid black;
  height:51.0pt;border-top:none' x:num><%=dt1.Rows[i]["routing_group"]%> </td>
  <%
      i_index ++;
      st_line = dt1.Rows[i]["routing_group"].ToString();
    }
   %>
  <td rowspan=4 class=xl32 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=dt1.Rows[i]["ref_po_no"]%> </td>
  <td rowspan=4 class=xl32 style='border-bottom:.5pt solid black;border-top:
  none' ><%=dt1.Rows[i]["item_code"]%></td>
  <td rowspan=4 height=68 width=89 style='border-bottom:.5pt solid black;
  height:51.0pt;width:67pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:2.25pt;margin-top:3pt;width:63pt;height:45pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[i]["TCO_STITEMPHOTO_PK"]%>&table_name=TCO_STITEMPHOTO" o:title="02"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>  
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:4px;width:84px;
  height:60px'><img width=84 height=60 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[i]["TCO_STITEMPHOTO_PK"]%>&table_name=TCO_STITEMPHOTO"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=4 height=68 class=xl32 width=89 style='border-bottom:.5pt solid black;
    height:51.0pt;border-top:none;width:67pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td rowspan=4 class=xl32 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=dt1.Rows[i]["plan_qty"]%></td>
  <td rowspan=4 class=xl32 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=dt1.Rows[i]["total_target"]%></td>
  <td class=xl38 style='border-top:none;border-left:none'>TARGET</td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_8"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_9"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_10"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_11"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_mr"]%></td> 
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_13"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_14"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_15"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_17"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_af"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_18"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["s_19"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_ot"]%></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_target"]%></td>
 </tr>
 <tr class=xl29 height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt;border-top:none;border-left:
  none'>PRODUCTION</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_8"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_9"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_10"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_11"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_p_mr"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_13"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_14"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_15"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_17"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_p_af"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_18"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["p_19"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_p_ot"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_p"]%></td>
 </tr>
 <tr class=xl29 height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt;border-top:none;border-left:
  none'>QC</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_8"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_9"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_10"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_11"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_q_mr"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_13"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_14"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_15"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_17"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_q_af"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_18"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["q_19"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_q_ot"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_q"]%></td>
 </tr>
 <tr class=xl29 height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt;border-top:none;border-left:
  none'>PACKING</td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_8"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_9"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_10"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_11"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_pk_mr"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_13"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_14"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_15"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_17"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_pk_af"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_18"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pk_19"]%></td>
  <td class=xl25 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_pk_ot"]%></td>
  <td class=xl24 style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["total_pk"]%></td>
 </tr>
 <% }
}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=82 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
