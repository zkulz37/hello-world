<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" 
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string master_pk = Request.QueryString["master_pk"];
    DataTable dt = ESysLib.TableReadOpenCursor("lg_RPT_BIAS00010_2", "'" + master_pk + "'");
    
    DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_bias00010", "'" + master_pk + "'");
    DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_bias00010_1", "'" + master_pk + "'");        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bias00013_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bias00013_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bias00013_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VNG</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-09-14T03:41:49Z</o:LastPrinted>
  <o:Created>2011-11-15T06:42:07Z</o:Created>
  <o:LastSaved>2012-09-14T03:48:06Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.44in .31in .59in .38in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font6
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font13
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
.style44
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style56
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
	mso-style-name:Normal_PNAP;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl66
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style56;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:right;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style56;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
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
.xl94
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl96
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline black;
	border-bottom:none;
	border-left:none;}
.xl97
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl100
	{mso-style-parent:style56;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl101
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
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style56;
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
.xl104
	{mso-style-parent:style56;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl108
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl111
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Transfer Slip</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>79</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1110 style='border-collapse:
 collapse;table-layout:fixed;width:833pt'>
 <col class=xl66 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl66 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl66 width=232 style='mso-width-source:userset;mso-width-alt:8484;
 width:174pt'>
 <col class=xl66 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl66 width=91 span=5 style='mso-width-source:userset;mso-width-alt:
 3328;width:68pt'>
 <col class=xl66 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl66 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <tr class=xl67 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl68 width=30 style='height:15.0pt;width:23pt'><v:shape id="_x0000_s8193" type="#_x0000_t75" style='position:absolute;
   margin-left:7.5pt;margin-top:3pt;width:80.25pt;height:38.25pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape></td>
  <td class=xl69 width=90 style='width:68pt'></td>
  <td class=xl69 colspan=2 width=316 style='mso-ignore:colspan;width:237pt'><%=dt.Rows[0]["partner_name"] %></td>
  <td class=xl67 width=91 style='width:68pt'></td>
  <td class=xl67 width=91 style='width:68pt'></td>
  <td class=xl67 width=91 style='width:68pt'></td>
  <td class=xl67 width=91 style='width:68pt'></td>
  <td class=xl70 width=91 style='width:68pt'>Tel: <%=dt.Rows[0]["phone_no"] %></td>
  <td class=xl67 width=110 style='width:83pt'></td>
  <td class=xl67 width=109 style='width:82pt'></td>
 </tr>
 <tr class=xl67 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt'></td>
  <td class=xl69></td>
  <td colspan=5 class=xl94 width=589 style='width:441pt'><%=dt.Rows[0]["addr1"] %></td>
  <td class=xl67></td>
  <td class=xl70>Fax: <%=dt.Rows[0]["fax_no"] %></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl71 style='height:15.0pt'>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl71>Tax No: <%=dt.Rows[0]["tax_code"] %></td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl112>Print Date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl67 style='height:7.5pt'></td>
  <td class=xl69></td>
  <td class=xl67></td>
  <td class=xl69></td>
  <td colspan=4 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=7 rowspan=2 height=50 class=xl95 style='border-right:.5pt hairline black;
  height:37.5pt'>PHI&#7870;U GIAO NH&#7852;N<font class="font10"> </font><font
  class="font11">(HANDOVER SLIP)</font></td>
  <td class=xl75>S&#7889; <font class="font9">Slip No</font></td>
  <td class=xl76 x:num><%=dt1.Rows[0]["slip_no"]%></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl77 style='height:18.75pt'>Ngày<font class="font6"> </font><font
  class="font9">Date</font></td>
  <td class=xl78><%=dt1.Rows[0]["dd"] %>/<%=dt1.Rows[0]["mm"] %>/<%=dt1.Rows[0]["yyyy"] %></td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl74 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl97 width=120 style='height:22.5pt;width:91pt'
  x:str="Ng&#432;&#7901;i nh&#7853;n: ">Ng&#432;&#7901;i nh&#7853;n:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl98><%=dt1.Rows[0]["charger_name"] %></td>
  <td colspan=3 class=xl100></td>
  <td colspan=2 class=xl92>&nbsp;</td>
  <td class=xl80></td>
  <td class=xl74></td>
 </tr>
 <tr class=xl74 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl101 width=120 style='height:22.5pt;
  width:91pt' x:str="B&#7897; ph&#7853;n:  ">B&#7897; ph&#7853;n:<span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=2 class=xl102><%=dt1.Rows[0]["description"] %></td>
  <td colspan=3 class=xl103>&nbsp;</td>
  <td colspan=2 class=xl104>&nbsp;</td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=55 class=xl93 width=30 style='height:41.25pt;border-top:
  none;width:23pt'>TT<br>
    <font class="font9">No</font></td>
  <td rowspan=2 class=xl93 width=90 style='border-top:none;width:68pt'>Mã
  hàng<br>
    <font class="font9">Item Code</font></td>
  <td rowspan=2 class=xl93 width=232 style='border-top:none;width:174pt'>Tên
  hàng<br>
    <font class="font9">Item Description</font></td>
  <td rowspan=2 class=xl93 width=84 style='border-top:none;width:63pt'>&#272;VT<br>
    <font class="font9">Unit</font></td>
  <td rowspan=2 class=xl93 width=91 style='border-top:none;width:68pt'>SL
  Th&#7921;c xu&#7845;t<br>
    <font class="font9">Actual Qty</font></td>
  <td rowspan=2 class=xl93 width=91 style='border-top:none;width:68pt'>&#272;&#417;n
  Giá<br>
    <font class="font9">U/Price</font></td>
  <td rowspan=2 class=xl93 width=91 style='border-top:none;width:68pt'>Thành
  Ti&#7873;n<br>
    <font class="font9">Amount</font></td>
  <td colspan=2 rowspan=2 class=xl93 width=182 style='width:136pt'>Ghi
  chú<br>
    <font class="font9">Remark</font></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 colspan=2 class=xl66 style='height:26.25pt;mso-ignore:colspan'></td>
 </tr>
  <%
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
            %> 
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl81 width=30 style='height:30.0pt;width:23pt' x:num><%=i+1 %></td>
  <td class=xl82 width=90 style='width:68pt'><%=dt2.Rows[i]["item_code"]%></td>
  <td class=xl83 width=232 style='width:174pt'><%=dt2.Rows[i]["item_name"]%></td>
  <td class=xl82 width=84 style='width:63pt'><%=dt2.Rows[i]["req_uom"]%></td>
  <td class=xl85 width=91 style='border-top:none;border-left:none;width:68pt'
  x:num><span style='mso-spacerun:yes'>                   </span><%=dt2.Rows[i]["tr_qty"]%></td>
  <td class=xl85 width=91 style='border-top:none;width:68pt' x:num><span
  style='mso-spacerun:yes'>         </span><%=dt2.Rows[i]["unit_price"]%></td>
  <td class=xl86 width=91 style='border-top:none;width:68pt' x:num><span
  style='mso-spacerun:yes'>         </span><%=dt2.Rows[i]["item_amount"]%></td>
  <td colspan=2 class=xl108 width=182 style='border-right:.5pt solid black;
  width:136pt'><%=dt2.Rows[i]["description"]%></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
              <% 
     }
      %>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=4 height=38 class=xl90 width=436 style='height:28.5pt;width:328pt'>T&#7893;ng
  c&#7897;ng<span style='mso-spacerun:yes'>  </span><font class="font13">Total</font></td>
  <td class=xl87 style='border-top:none' x:num x:fmla="=SUM(<% if(dt2.Rows.Count > 0){%>E11:E<%= dt2.Rows.Count+10%><%}else{%>E13:E13<%}%>)"><span
  style='mso-spacerun:yes'>                   </span></td>
  <td class=xl88 style='border-top:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt2.Rows.Count > 0){%>G11:G<%= dt2.Rows.Count+10%><%}else{%>G13:G13<%}%>)"><span style='mso-spacerun:yes'>         </span></td>
  <td colspan=2 class=xl110 width=182 style='border-right:.5pt solid black;
  width:136pt'>&nbsp;</td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=11 class=xl66 style='height:21.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 colspan=4 class=xl66 style='height:30.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl106 width=182 style='width:136pt'><font class="font12">Ph&#7909;
  Trách Mua Hàng</font><font class="font5"><br>
    (</font><font class="font13">Purchasing Dept</font><font class="font5">)</font></td>
  <td colspan=2 class=xl106 width=182 style='border-left:none;width:136pt'><font
  class="font12">Ng&#432;&#7901;i Nh&#7853;n</font><font class="font5"><br>
    (</font><font class="font13">Receiver</font><font class="font5">)</font></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 rowspan=6 class=xl105>Date:</td>
  <td colspan=2 rowspan=6 class=xl105>Date:</td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl66 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=232 style='width:174pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=109 style='width:82pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
