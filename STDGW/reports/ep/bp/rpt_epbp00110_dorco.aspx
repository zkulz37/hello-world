<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("SALE");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("lg_rpt_epbp00110_dorco");
	string p_po_pk	=	Request.QueryString["p_po_pk"];
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00110_1_dorco", "'" + p_po_pk + "'");
    dt2 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00110_2_dorco", "'" + p_po_pk + "'");
    string str = CommondLib.Num2EngText(dt1.Rows[0]["total_amt"].ToString(),dt1.Rows[0]["po_ccy"].ToString());
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="dorco_files/filelist.xml">
<link rel=Edit-Time-Data href="dorco_files/editdata.mso">
<link rel=OLE-Object-Data href="dorco_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Bill Gates</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-04-17T03:01:43Z</o:LastPrinted>
  <o:Created>2010-10-04T12:31:07Z</o:Created>
  <o:LastSaved>2012-04-17T03:03:29Z</o:LastSaved>
  <o:Company>Microsoft</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&C&\0022Tahoma\,Regular\0022Page &P of &N";
	margin:.27in .2in .43in .2in;
	mso-header-margin:.17in;
	mso-footer-margin:.17in;}
.font14
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
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
	font-family:돋움, monospace;
	mso-font-charset:129;
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
	font-family:돋움, monospace;
	mso-font-charset:129;
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0_ ";}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	font-size:16.0pt;
	font-weight:700;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:15px;
	mso-char-indent-count:1;}
.xl33
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:bottom;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:left;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl36
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:10.0pt;Remark
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:10.0pt;
	text-align:center;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;}
.xl60
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl61
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	color:black;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:45px;
	mso-char-indent-count:3;}
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:15px;
	mso-char-indent-count:1;}
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl66
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	padding-left:45px;
	mso-char-indent-count:3;
	
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	
	}
.xl67
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl68
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:bottom;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PO DORCO</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>330</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>72</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>40</x:TabColorIndex>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>23</x:ActiveRow>
       <x:RangeSelection>$A$24:$H$24</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:ColBreaks>
      <x:ColBreak>
       <x:Column>10</x:Column>
       <x:RowEnd>35</x:RowEnd>
      </x:ColBreak>
     </x:ColBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>13035</x:WindowHeight>
  <x:WindowWidth>19260</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='PO DORCO'!$A$1:$J$27</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='PO DORCO'!$16:$16</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1188 style='border-collapse:
 collapse;table-layout:fixed;width:891pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3360;
 width:75pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3360;
 width:79pt'>
 <col width=195 style='mso-width-source:userset;mso-width-alt:6240;width:146pt'>
 <col width=156 style='mso-width-source:userset;mso-width-alt:4992;width:117pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:1760;width:41pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:1920;width:45pt'>
 <col class=xl25 width=85 style='mso-width-source:userset;mso-width-alt:2720;
 width:64pt'>
 <col class=xl25 width=113 style='mso-width-source:userset;mso-width-alt:3616;
 width:85pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3200;
 width:75pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:3936;width:92pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:2912;width:68pt'>
 <col width=72 style='width:54pt'>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl26 width=33 style='height:16.5pt;width:25pt'><a
  name="Print_Area"></a></td>
  <td class=xl26 width=105 style='width:79pt'></td>
  <td class=xl27 width=195 style='width:146pt'></td>
  <td class=xl27 width=156 style='width:117pt'></td>
  <td class=xl27 width=55 style='width:41pt'></td>
  <td class=xl27 width=60 style='width:45pt'></td>
  <td class=xl28 width=85 style='width:64pt'></td>
  <td class=xl28 width=113 style='width:85pt'></td>
  <td class=xl28 width=100 style='width:75pt'></td>
  <td class=xl27 width=123 style='width:92pt'></td>
  <td class=xl27 width=91 style='width:68pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 colspan=2 class=xl26 style='height:39.75pt;mso-ignore:colspan'></td>
  <td height=53 class=xl27 width=195 style='height:39.75pt;width:146pt'><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><![endif]--></td>
  <td class=xl27><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:12.75pt;margin-top:10.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape></td>
  <td class=xl29 colspan=4 style='mso-ignore:colspan'><%= dt.Rows[0]["partner_name"] %></td>
  <td class=xl28></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl26 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=6 rowspan=2 class=xl70 width=536 style='width:402pt'><%= dt.Rows[0]["addr1"]%></td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl26 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl26 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>Fax :<%= dt.Rows[0]["fax_no"]%></td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'>Tax Code :<%= dt.Rows[0]["tax_code"]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl26 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'>E.mail :<%= dt1.Rows[0]["email"] %></td>
  <td class=xl27></td>
  <td class=xl28></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>

  <td colspan=10 height=30 class=xl71 style='height:22.5pt'>PURCHASE ORDER</td>
  <td class=xl27></td>
  <td></td>
 </tr>

 <tr height=30 style='mso-height-source:userset;height:22.5pt'>

 
   
  <td colspan=10 class=xl27 style='height:22.5pt' > <%=dt1.Rows[0]["po_no"]%></td>
  
  <td class=xl27></td>
  <td></td>
  
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl31 colspan=3 style='height:18.0pt;mso-ignore:colspan'>Vendor: <%= dt1.Rows[0]["partner_name"]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl33>Date</td>
  <td class=xl34><%= dt1.Rows[0]["po_date"]%></td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl35 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Address: <%= dt1.Rows[0]["addr1"]%></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl32></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl36>Sender</td>
  <td class=xl37><%= dt1.Rows[0]["full_name"]%></td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl35 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Representative: <%= dt1.Rows[0]["sale_rep"]%></td>
  <td class=xl35></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl36>Page</td>
  <td class=xl37 x:num>1</td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl35 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Dept: <%= dt1.Rows[0]["dept_name"]%></td>
  <td class=xl35></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl31 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Tel: <%= dt1.Rows[0]["phone_no"]%></td>
  <td class=xl31></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=2 class=xl26 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl39 style='height:27.75pt'>Ref No</td>
  <td class=xl40>-</td>
  <td class=xl40>Item Name</td>
  <td class=xl40>Item Code</td>
  <td class=xl40>Unit</td>
  <td class=xl40>Q'ty</td>
  <td class=xl41>Unit price</td>
  <td class=xl41>Amount(<%= dt1.Rows[0]["po_ccy"] %>)</td>
  <td class=xl41>Delivery Date</td>
  <td class=xl40>Size</td>
  <td class=xl27></td>
  <td></td>
 </tr>
  <% 
    double total = 0;
     for (int i = 0; i < dt2.Rows.Count; i++ )
     {
        total = total + CommondLib.ConvertToDbl(dt2.Rows[i]["po_qty_01"]);
    %>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl42 width=33 style='height:34.5pt;width:25pt' ><%= dt2.Rows[i]["ref_no"]%></td>
  <td class=xl75 width=105 style='width:79pt'><%= dt2.Rows[i]["ref_2"]%></td>
  <td class=xl43 width=195 style='width:146pt'><%= dt2.Rows[i]["po_item_name"]%></td>
  <td class=xl44 width=156 style='width:117pt'><%= dt2.Rows[i]["po_item_code"]%></td>
  <td class=xl45><%= dt2.Rows[i]["po_uom_01"]%></td>
  <td class=xl46 x:num><%= dt2.Rows[i]["po_qty_01"]%></td>
  <td class=xl47 x:num><%= dt2.Rows[i]["unit_price"]%></td>
  <td class=xl48 x:num><%= dt2.Rows[i]["po_amt"]%></td>
  <td class=xl45><%= dt2.Rows[i]["etd_from"]%></td>
  <td class=xl45><%= dt2.Rows[i]["po_size"]%></td>
  <td class=xl27></td>
  <td></td>
 </tr>
  <%
  } %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=10 height=20 class=xl72 width=1025 style='border-right:.5pt solid black;
  height:15.0pt;width:769pt'>&nbsp;</td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr class=xl49 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl50 style='height:15.0pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl51>SUB-TOTAL</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl55 x:num><font color="#FF0000" style='mso-ignore:color'><%=total %></font></td>
  <td class=xl56>&nbsp;</td>
  <td class=xl48 x:num><%= dt1.Rows[0]["po_amt"]%></td>
  <td class=xl56>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl38></td>
  <td class=xl49></td>
 </tr>
 <tr class=xl49 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl50 style='height:15.0pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl51>VAT(10%)</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl48 x:num><%= dt1.Rows[0]["vat_amt"]%></td>
  <td class=xl56>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl38></td>
  <td class=xl49></td>
 </tr>
 <tr class=xl49 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl50 style='height:15.0pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl51>TOTAL AMOUNT</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57 x:num><%= dt1.Rows[0]["total_amt"]%></td>
  <td class=xl58>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl59></td>
  <td class=xl49></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=2 class=xl26 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=3 height=18 class=xl60 style='height:13.5pt'><span
  style='mso-spacerun:yes'> </span>Remarks:</td>
  <td class=xl60></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=10 height=18 class=xl60 style='height:13.5pt'>1/ Total Amount must
  Payment: <font class="font14"><%= str %></font></td>
   
  <td class=xl28></td>
  <td class=xl25></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=9 height=18 class=xl60 style='height:13.5pt'>2/ Delivery
  Place:<span style='mso-spacerun:yes'>  </span><font class="font14">At DORCO
  VINA Co.,Ltd</font></td>
  <td class=xl27></td>
  <td class=xl28></td>
  <td></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=10 height=18 class=xl61 width=1025 style='height:13.5pt;
  width:769pt' >3/ Payment Term: <%= dt1.Rows[0]["payment_method"]%> <span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=10 height=18 class=xl61 width=1025 style='height:13.5pt;
  width:769pt'>4/ Remark</td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=3 height=18 class=xl61 width=333 style='height:13.5pt;width:250pt'>Thank
  you!</td>
  <td class=xl61></td>
  <td colspan=6 class=xl62 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=5 class=xl63 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl64></td>
  <td class=xl65></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl63 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl66>Made By</td>
  <td class=xl66>Approved By</td>
  <td class=xl63></td>
  <td class=xl64></td>
  <td class=xl67></td>
  <td class=xl68></td>
  <td class=xl29><span style='mso-spacerun:yes'>    </span>Seller</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl63 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl66 rowspan=5 > </td>
  <td class=xl66 rowspan=5 > </td>
  <td class=xl63></td>
  <td class=xl64></td>
  <td class=xl67></td>
  <td class=xl68></td>
  <td class=xl29><span style='mso-spacerun:yes'>    </span> </td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=5 class=xl63 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl64></td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=5 class=xl63 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl64></td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=5 class=xl63 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl64></td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'><%= dt1.Rows[0]["sale_rep"]%></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=2 class=xl26 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=2 class=xl26 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=156 style='width:117pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
