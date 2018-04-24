<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
        string p_Project_Pk = Request["Project_Pk"];
        string p_Project_Cd = "";
        string p_Project_Nm;
        string p_Location = "";
        string p_Period = "";
        string p_Date = "";
        string SQL = "select A.PROJECTCODE, A.PROJECTNAME, A.SITE_ADDR, to_char(to_date(A.VALID_FROM ,'YYYYMMDD'),'DD/MM/YYYY')||'~'||to_char(to_date(A.VALID_TO ,'YYYYMMDD'),'DD/MM/YYYY') ,  " +
        "to_char(to_date(A.PR_DATE,'YYYYMMDD'),'DD/MM/YYYY') " +
        "from tecps_projectsumm a " +
        "where a.del_if = 0 " +
        "and a.pk = '"+p_Project_Pk+"' ";
        
        DataTable dt = ESysLib.TableReadOpen(SQL);
        if (dt.Rows.Count == 0)
        {
            Response.Write("There is no data!!");
            Response.End();
        }
        
        p_Project_Cd = dt.Rows[0][0].ToString();
        p_Project_Nm = dt.Rows[0][1].ToString();
        p_Location = dt.Rows[0][2].ToString();
        p_Period = dt.Rows[0][3].ToString();
        p_Date = dt.Rows[0][4].ToString();
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="budgetcover_files/filelist.xml">
<link rel=Edit-Time-Data href="budgetcover_files/editdata.mso">
<link rel=OLE-Object-Data href="budgetcover_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>kenzie</o:LastAuthor>
  <o:LastPrinted>2011-06-24T03:42:23Z</o:LastPrinted>
  <o:Created>2011-06-11T01:58:05Z</o:Created>
  <o:LastSaved>2011-06-24T03:42:28Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .51in .5in .56in;
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
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Helv, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Helv, sans-serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Helv, sans-serif;
	mso-font-charset:0;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:VNI-Helve-Condense, sans-serif;
	mso-font-charset:0;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl107
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	color:windowtext;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>budget cover</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>75</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>22</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7875</x:WindowHeight>
  <x:WindowWidth>18735</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>300</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl76>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1078 style='border-collapse:
 collapse;table-layout:fixed;width:811pt'>
 <col class=xl76 width=54 span=9 style='mso-width-source:userset;mso-width-alt:
 1974;width:41pt'>
 <col class=xl76 width=67 span=8 style='mso-width-source:userset;mso-width-alt:
 2450;width:50pt'>
 <col class=xl76 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 width=54 style='height:14.25pt;width:41pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_3" o:spid="_x0000_s1025" type="#_x0000_t75"
   alt="newlogo.JPG" style='position:absolute;margin-left:39.75pt;margin-top:12pt;
   width:190.5pt;height:32.25pt;z-index:1;visibility:visible'>
   <v:imagedata src="budgetcover_files/image001.jpg" o:title="newlogo"/>
   <v:path arrowok="t"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:53px;margin-top:16px;width:254px;
  height:43px'><img width=254 height=43 src="budgetcover_files/image002.jpg"
  alt=newlogo.JPG v:shapes="Picture_x0020_3"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl72 width=54 style='height:14.25pt;width:41pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl73 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl73 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl73 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl73 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl73 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl73 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl73 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl73 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl74 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl74 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl74 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl74 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl74 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl74 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl74 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl74 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl75 width=56 style='width:42pt'>&nbsp;</td>
 </tr>
 <tr class=xl79 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl77 style='height:30.0pt'>&nbsp;</td>
  <td colspan=6 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl77 style='height:6.0pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td class=xl81 colspan=9 style='mso-ignore:colspan'>POSCO ENGINEERING &amp;
  CONSTRUCTION VIETNAM CO.,LTD</td>
  <td colspan=7 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl77 style='height:22.5pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl103 style='border-right:.5pt solid black'>Prepared by</td>
  <td colspan=2 class=xl103 style='border-right:.5pt solid black;border-left:
  none'>Reivewed by</td>
  <td colspan=4 class=xl103 style='border-right:.5pt solid black;border-left:
  none'>Approved by</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl77 style='height:27.0pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl106 style='border-right:.5pt solid black'>Engineer</td>
  <td colspan=2 class=xl106 style='border-right:.5pt solid black;border-left:
  none'>Site manager</td>
  <td colspan=2 class=xl108 width=134 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>Project Director<span
  style='mso-spacerun:yes'>  </span>/Group leader</td>
  <td colspan=2 class=xl106 style='border-right:.5pt solid black;border-left:
  none'>General director</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td class=xl82>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none'>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td class=xl82>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td class=xl82>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td class=xl82>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td class=xl88>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90 style='border-left:none'>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl90 style='border-left:none'>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl90 style='border-left:none'>&nbsp;</td>
  <td class=xl91>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black'>Name</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Name</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Name</td>
  <td colspan=2 class=xl103 style='border-right:.5pt solid black;border-left:
  none'>Oh Young Whan</td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=54 style='mso-height-source:userset;height:40.5pt'>
  <td colspan=18 height=54 class=xl112 width=1078 style='border-right:2.0pt double black;
  height:40.5pt;width:811pt' x:str="WORKING BUDGET ">WORKING BUDGET<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl79 height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl77 style='height:9.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl81 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=18 height=30 class=xl92 width=1078 style='border-right:2.0pt double black;
  height:23.1pt;width:811pt'>FOR</td>
 </tr>
 <tr class=xl79 height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl77 style='height:9.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl81 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=18 height=30 class=xl92 width=1078 style='border-right:2.0pt double black;
  height:23.1pt;width:811pt' >PROJECT NAME: <%=p_Project_Nm%><span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl81 height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=18 height=30 class=xl92 width=1078 style='border-right:2.0pt double black;
  height:23.1pt;width:811pt' >PROJECT CODE: <%=p_Project_Cd%><span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl79 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=18 height=27 class=xl92 width=1078 style='border-right:2.0pt double black;
  height:20.25pt;width:811pt' >LOCATION : <%=p_Location%><span
  style='mso-spacerun:yes'>  </span></td>
 </tr>
 <tr class=xl79 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=18 height=27 class=xl92 width=1078 style='border-right:2.0pt double black;
  height:20.25pt;width:811pt' >PERIOD : <%=p_Period%><span
  style='mso-spacerun:yes'>  </span></td>
 </tr>
 <tr class=xl79 height=27 style='height:20.25pt'>
  <td height=27 class=xl92 width=54 style='height:20.25pt;width:41pt'>&nbsp;</td>
  <td colspan=8 class=xl93 style='mso-ignore:colspan'></td>
  <td class=xl94></td>
  <td colspan=7 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=27 style='height:20.25pt'>
  <td height=27 class=xl92 width=54 style='height:20.25pt;width:41pt'>&nbsp;</td>
  <td colspan=8 class=xl93 style='mso-ignore:colspan'></td>
  <td class=xl94></td>
  <td colspan=7 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=27 style='height:20.25pt'>
  <td height=27 class=xl92 width=54 style='height:20.25pt;width:41pt'>&nbsp;</td>
  <td colspan=8 class=xl93 style='mso-ignore:colspan'></td>
  <td class=xl94></td>
  <td colspan=7 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=27 style='height:20.25pt'>
  <td height=27 class=xl92 width=54 style='height:20.25pt;width:41pt'>&nbsp;</td>
  <td colspan=8 class=xl93 style='mso-ignore:colspan'></td>
  <td class=xl94></td>
  <td colspan=7 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=27 style='height:20.25pt'>
  <td height=27 class=xl92 width=54 style='height:20.25pt;width:41pt'>&nbsp;</td>
  <td colspan=8 class=xl93 style='mso-ignore:colspan'></td>
  <td class=xl94></td>
  <td colspan=7 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=27 style='height:20.25pt'>
  <td height=27 class=xl92 width=54 style='height:20.25pt;width:41pt'>&nbsp;</td>
  <td colspan=8 class=xl93 style='mso-ignore:colspan'></td>
  <td class=xl94></td>
  <td colspan=7 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=27 style='height:20.25pt'>
  <td height=27 class=xl92 width=54 style='height:20.25pt;width:41pt'>&nbsp;</td>
  <td colspan=8 class=xl93 style='mso-ignore:colspan'></td>
  <td class=xl94></td>
  <td colspan=7 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=27 style='height:20.25pt'>
  <td height=27 class=xl77 style='height:20.25pt'>&nbsp;</td>
  <td colspan=5 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl93 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl79 height=21 style='height:15.75pt'>
  <td height=21 class=xl77 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl78 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
 </tr>
 <tr class=xl95 height=25 style='height:18.75pt'>
  <td colspan=18 height=25 class=xl115 style='border-right:2.0pt double black;
  height:18.75pt' >DATE: <%=p_Date%><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl79 height=22 style='height:16.5pt'>
  <td height=22 class=xl96 style='height:16.5pt'>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl97>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl100 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=9 class=xl76 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=56 style='width:42pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
