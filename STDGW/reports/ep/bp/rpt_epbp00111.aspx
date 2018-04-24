<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("lg_rpt_epbp00111", "'" + Session["User_ID"].ToString() + "'");
	string p_po_pk	=	Request.QueryString["p_po_pk"];
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00111_1", "'" + p_po_pk + "'");
    dt2 = ESysLib.TableReadOpenCursor("lg_rpt_epbp00111_2", "'" + p_po_pk + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epbp00111_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epbp00111_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epbp00111_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-02-16T08:40:04Z</o:LastPrinted>
  <o:Created>2011-06-10T03:14:58Z</o:Created>
  <o:LastSaved>2012-02-17T08:11:35Z</o:LastSaved>
  <o:Company>Prive</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.39in .35in .5in .43in;
	mso-header-margin:.31in;
	mso-footer-margin:.5in;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font15
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font17
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font18
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font19
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
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
.style21
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl25
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style21;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl34
	{mso-style-parent:style21;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl38
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl39
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style21;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style21;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style21;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double black;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl66
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:none;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt dashed windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:none;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:none;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:none;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:none;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed windowtext;
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
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>81</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9450</x:WindowHeight>
  <x:WindowWidth>13410</x:WindowWidth>
  <x:WindowTopX>45</x:WindowTopX>
  <x:WindowTopY>0</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$11:$11</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1097 style='border-collapse:
 collapse;table-layout:fixed;width:826pt'>
 <col class=xl25 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl25 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl25 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl25 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl25 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl25 width=90 span=4 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <col class=xl25 width=64 span=4 style='width:48pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 rowspan=3 height=72 class=xl50 width=131 style='border-bottom:
  2.0pt double black;height:54.0pt;width:99pt'><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape></td>
  <td colspan=4 class=xl27 width=440 style='width:331pt'><%= dt.Rows[0]["partner_name"] %></td>
  <td class=xl27 width=90 style='width:68pt'></td>
  <td colspan=2 class=xl29 width=180 style='width:136pt'>Tel: <%= dt.Rows[0]["phone_no"] %></td>
  <td class=xl30 width=64 style='width:48pt'></td>
  <td class=xl30 width=64 style='width:48pt'></td>
  <td class=xl30 width=64 style='width:48pt'></td>
  <td class=xl30 width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl29 style='height:18.0pt'><%= dt.Rows[0]["addr1"] %></td>
  <td class=xl29></td>
  <td colspan=2 class=xl29>Fax: <%= dt.Rows[0]["fax_no"] %></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl31 style='height:18.0pt'>MST: <%= dt.Rows[0]["tax_code"] %></td>
  <td class=xl31>&nbsp;</td>
  <td colspan=2 class=xl52>Print date : <%=DateTime.Now.ToString("dd/MM/yyyy hh:mm") %></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=70 style='mso-height-source:userset;height:52.5pt'>
  <td colspan=9 height=70 class=xl53 width=841 style='height:52.5pt;width:634pt'>&#272;&#416;N
  MUA HÀNG<br>
    <font class="font12">PURCHASING ORDER</font></td>
  <td class=xl34></td>
  <td class=xl25></td>
  <td class=xl34></td>
  <td class=xl30></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=9 height=30 class=xl54 style='height:22.5pt'>P/R No :<font
  class="font14"> </font><font class="font15"><%=dt1.Rows[0]["po_no"]%><span
  style='mso-spacerun:yes'>           </span></font><font class="font8">Date :</font><font
  class="font5"> </font><font class="font15"><%=dt1.Rows[0]["po_date"]%></font></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl55 style='height:22.5pt'>NCC <font
  class="font10">Supplier</font></td>
  <td colspan=7 class=xl57 style='border-right:.5pt solid black'><%=dt1.Rows[0]["partner_name"]%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl59 style='height:22.5pt'>&#272;&#7883;a
  ch&#7881; <font class="font10">Address</font></td>
  <td colspan=7 class=xl61 style='border-right:.5pt solid black'><%=dt1.Rows[0]["addr1"]%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl56 style='height:22.5pt'>Ngày giao <font
  class="font10">ETD</font></td>
  <td class=xl36 x:num><%=dt1.Rows[0]["etd_to"]%></td>
  <td colspan=3 class=xl63>Thanh toán <font class="font10">Payment Type</font></td>
  <td colspan=3 class=xl57><%=dt1.Rows[0]["payment_term"]%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl27 style='height:22.5pt'>Ghi chú <font
  class="font10">Remark</font></td>
  <td colspan=7 class=xl64><%=dt1.Rows[0]["description"]%></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl32 style='height:9.75pt'></td>
  <td colspan=8 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl37 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl38 width=30 style='height:30.0pt;width:23pt'>STT<font
  class="font17"><br>
    </font><font class="font18">No</font></td>
  <td colspan=2 class=xl65 width=281 style='border-right:.5pt solid black;
  border-left:none;width:211pt'>M&#7863;t hàng<font class="font17"><br>
    </font><font class="font18">Item</font></td>
  <td class=xl39 width=120 style='width:90pt'>Quy cách<font class="font17"><br>
    </font><font class="font18">Spec</font></td>
  <td class=xl39 width=50 style='width:38pt'>&#272;VT<font class="font17"><br>
    </font><font class="font18">UOM</font></td>
  <td class=xl39 width=90 style='width:68pt'>S&#7889; l&#432;&#7907;ng<font
  class="font17"><br>
    </font><font class="font18">Qty</font></td>
  <td class=xl39 width=90 style='width:68pt'>&#272;&#417;n giá<font
  class="font17"> (VND)<br>
    </font><font class="font18">U/Price</font></td>
  <td class=xl39 width=90 style='width:68pt'>Thành ti&#7873;n<font
  class="font17"><br>
    </font><font class="font18">Amount</font></td>
  <td class=xl39 width=90 style='width:68pt'>Ghi chú<font class="font17"><br>
    </font><font class="font18">Remark</font></td>
  <td colspan=4 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <%
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
      %>
 <tr class=xl33 height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 class=xl40 width=30 style='height:37.5pt;width:23pt'><%=i+1 %></td>
  <td colspan=2 class=xl67 width=281 style='border-right:.5pt dashed black;
  border-left:none;width:211pt'><%=dt2.Rows[i]["po_item_name"]%><br>
    <font class="font19"><%=dt2.Rows[i]["po_item_name_2"]%><span style='mso-spacerun:yes'></span></font></td>
  <td class=xl41 width=120 style='width:90pt'><%=dt2.Rows[i]["spec"]%></td>
  <td class=xl42 width=50 style='width:38pt'><%=dt2.Rows[i]["po_uom_01"]%></td>
  <td class=xl43 width=90 style='width:68pt' x:num><span
  style='mso-spacerun:yes'></span><%=dt2.Rows[i]["po_qty_01"]%></td>
  <td class=xl43 width=90 style='width:68pt' x:num><span
  style='mso-spacerun:yes'></span><%=dt2.Rows[i]["unit_price"]%></td>
  <td class=xl43 width=90 style='width:68pt' x:num><span
  style='mso-spacerun:yes'></span><%=dt2.Rows[i]["po_amt"]%></td>
  <td class=xl44 width=90 style='width:68pt'><%=dt2.Rows[i]["description"]%></td>
 </tr>
 <%} %>
 <tr class=xl28 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl45 style='height:22.5pt'>&nbsp;</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl69>Sub Total</td>
  <td colspan=2 class=xl70 x:num><span style='mso-spacerun:yes'></span><% if(dt1.Rows.Count > 0){%><%= dt1.Rows[0]["po_amt"] %><%}%></td>
  <td class=xl46 x:str="VND"><span style='mso-spacerun:yes'> </span>VND<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl45 style='height:22.5pt'>&nbsp;</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71>VAT</td>
  <td colspan=2 class=xl72 x:num><span style='mso-spacerun:yes'></span><% if(dt1.Rows.Count > 0){%><%= dt1.Rows[0]["vat_amt"] %><%}%></td>
  <td class=xl46 x:str="VND"><span style='mso-spacerun:yes'> </span>VND<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl47 style='height:22.5pt'>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td colspan=2 class=xl73>Total Amount</td>
  <td colspan=2 class=xl74 x:num><span style='mso-spacerun:yes'></span><% if(dt1.Rows.Count > 0){%><%= dt1.Rows[0]["total_amt"] %><%}%></td>
  <td class=xl49 x:str="VND"><span style='mso-spacerun:yes'> </span>VND<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 rowspan=8 height=136 class=xl25 width=360 style='mso-ignore:
  colspan-rowspan;height:102.0pt;width:272pt'><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   margin-left:44.25pt;margin-top:.75pt;width:177pt;height:92.25pt;z-index:1'
   fillcolor="windowText [64]" strokecolor="window [65]" strokeweight="3e-5mm"
   o:insetmode="auto">
   <v:fill color2="window [65]"/>
   <v:imagedata src="rpt_epbp00111_files/image003.gif" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:AutoFill>False</x:AutoFill>
    <x:AutoLine>False</x:AutoLine>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=59 height=1></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=236 height=123 src="rpt_epbp00111_files/image003.gif"
    v:shapes="_x0000_s1026"></td>
    <td width=65></td>
   </tr>
   <tr>
    <td height=12></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:270.0pt;height:102.0pt'></span><![endif]--></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
