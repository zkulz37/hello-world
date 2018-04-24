<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser(Session["APP_DBUSER"].ToString());%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="AR%20History%20Details_files/filelist.xml">
<link rel=Edit-Time-Data href="AR%20History%20Details_files/editdata.mso">
<link rel=OLE-Object-Data href="AR%20History%20Details_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>OWNER</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2009-03-05T05:37:19Z</o:LastPrinted>
  <o:Created>2009-01-22T03:23:41Z</o:Created>
  <o:LastSaved>2009-03-31T03:49:10Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in 0in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font7
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
.style44
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";}
.xl68
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl69
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style44;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022_-\;_-\@_-";}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl75
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl77
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl86
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl90
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl100
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl101
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl104
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl106
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl111
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl112
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl115
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl117
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl118
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>YYYYMM</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>50</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PublishObjects>
     <x:PublishObject>
      <x:Id>16850</x:Id>
      <x:DivID>gfca00030_AR History_Detail_16850</x:DivID>
      <x:SourceType>SourceSheet</x:SourceType>
      <x:HtmlType>HtmlStatic</x:HtmlType>
      <x:Location HRef="D:\WebProject\ESYS\reports\gf\ca\AR History Details.htm"/>
     </x:PublishObject>
    </x:PublishObjects>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11640</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=YYYYMM!$A$8:$X$10</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>code131</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>code1312</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="5121"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>
<%
	string SQL = "";
	string l_company_pk = "", l_tr_date_fr = "", l_tr_date_to = "" ;
	string l_tco_buspartner_pk = "", l_tr_status = "", l_tr_type = "";
	string l_tac_hgtrh_pk = "", l_voucherno = "", l_invoice_no = "";
	l_company_pk = Request["tco_company_pk"];
	l_tr_date_fr = Request["tr_date_fr"];
	l_tr_date_to = Request["tr_date_to"];
	l_tco_buspartner_pk = Request["tco_buspartner_pk"];
	l_tr_status = Request["tr_status"];
	l_tr_type = Request["tr_type"];
	l_tac_hgtrh_pk = Request["tac_hgtrh_pk"]; 
	l_voucherno = Request["voucherno"];  
	l_invoice_no = Request["invoice_no"];
string    l_Item_pk = Request["Item_pk"];
string l_PLUnit = Request["PLUnit"];
string l_Nation = Request["Nation"]; 		
	// thong tin cua cong ty
    SQL
	= "select PARTNER_NAME, TAX_CODE, NVL(ADDR1, '') || NVL(ADDR2, ' ') || NVL(ADDR3, ' ') address, initcap(to_char(sysdate, 'day, month dd, yyyy')) to_day, " + 
		" to_char(to_date('" + l_tr_date_fr + "', 'yyyymmdd'), 'dd/mm/yyyy') dt_from, to_char(to_date('" + l_tr_date_to + "', 'yyyymmdd'), 'dd/mm/yyyy') dt_to " +
        "from tco_company  " +
        "where del_if = 0  " +
        "and pk = " + l_company_pk ;    
    DataTable dtComp = new DataTable ();
    dtComp = ESysLib.TableReadOpen(SQL); 
    if(dtComp.Rows.Count == 0)
    {
        Response.Write("There is not enough information to display!!!");
        Response.End();
    }
	// thong tin item chi tiet 
	if(	l_tr_status != "ALL")
	{
	 SQL
		= "select h.pk seq, h.voucherno, to_char(h.tr_date, 'dd/mm/yyyy') tr_date, " + 
	        "	   (select max(a.item) from tac_crcaditem a, tac_abitem b where a.del_if = 0 and b.del_if = 0 and a.TAC_ABITEM_PK = b.pk and a.tac_crca_pk = c.pk and b.item_nm = 'INVOICE NO') inv_no, " +
			"            	(select max(a.item) from tac_crcaditem a, tac_abitem b where a.del_if = 0 and b.del_if = 0 and a.TAC_ABITEM_PK = b.pk and a.tac_crca_pk = c.pk and b.item_nm = 'INVOICE DATE') inv_date, " +
	        "	       	(select max(a.item) from tac_crcaditem a, tac_abitem b where a.del_if = 0 and b.del_if = 0 and a.TAC_ABITEM_PK = b.pk and a.tac_crca_pk = c.pk and b.item_nm = 'SERIAL NO') serial_no, " +
			"   e.partner_id, e.partner_name, h.remark, " +
	        "	   f.ac_cd accd_dr, f1.ac_cd accd_cr1, f2.ac_cd accd_cr2, i.item_code, i.uom, d.qty, " +
	        "	   d.u_price, d.net_tr_amt, c.tr_rate, d.net_bk_amt, decode(d.vat_rate, '01', 'none', '00', '0', d.vat_rate) vat_rate, " +
	        "	   d.vat_tr_amt, d.vat_bk_amt, nvl(d.net_tr_amt,0) + nvl(d.vat_tr_amt, 0) trans_amt,  " +
            "	   nvl(d.net_bk_amt,0) + nvl(d.vat_bk_amt, 0) books_amt, " +
			
			
			"	(select  u.item " +
			"	  from tac_crcaditem u, tac_abitem v " +
			"	 where u.del_if       = 0 " +
			"	   and v.del_if       = 0 " +
			"	   and u.tac_crca_pk  = c.pk " +
			"	   and u.tac_abitem_pk = v.pk " +
			"	   and v.ITEM_NM ='CONTRACT NOAR') order_no,  " +
			
			"	c.tr_status, K.PL_CD||' - '||K.PL_NM,    " +
			
			
			
			"	(select  u.item " +
			"	  from tac_crcaditem u, tac_abitem v " +
			"	 where u.del_if       = 0 " +
			"	   and v.del_if       = 0 " +
			"	   and u.tac_crca_pk  = c.pk " +
			"	   and u.tac_abitem_pk = v.pk " +
			"	   and v.ITEM_NM ='PLACE OF RECEVING') Nation " +
   
	        "from tac_hgtrh h, " +
	        "	 tac_crca c, " +
	        "	 tac_crcad d, " +
	        "	 tco_buspartner e, " +
	        "	 tac_abacctcode f, " +
	        "	 tac_abacctcode f1, " +
	        "	 tac_abacctcode f2, " +
	        "	 tlg_it_item i, TAC_ABPLCENTER g, tac_abpl k " +
	        "	 where h.del_if = 0 " +
	        "	 and c.del_if = 0 " +
	        "	 and d.del_if = 0 " +       
			"    and i.del_if(+) = 0 and g.del_if(+) = 0 and k.del_if(+) = 0 " +	
	        "	 and h.tr_tablenm = 'TAC_CRCA' " +
	        "	 and h.tr_table_pk = c.pk " +
	        "	 and c.pk = d.tac_crca_pk " +
	        "	 and c.tco_buspartner_pk = e.pk(+) " +
	        "	 and c.tac_abacctcode_pk = f.pk(+) " +
	        "	 and d.tac_abacctcode_pk = f1.pk(+) " +
	        "	 and d.tac_abacctcode_pk_vat = f2.pk(+) " +
            "	 and d.tco_item_pk = i.pk(+) and D.TAC_ABPLCENTER_PK = g.pk(+) and G.TAC_ABPL_PK = k.pk(+) " +
	        "	 and to_char(h.tr_date, 'yyyymmdd') between '" + l_tr_date_fr + "' and '" + l_tr_date_to + "' " +
	        "	 and ( c.tco_buspartner_pk = '" + l_tco_buspartner_pk + "' or '" + l_tco_buspartner_pk + "' is null)  " +
	        "	 and h.tr_status = '" + l_tr_status + "' " +
	        "	 and (c.tr_type = '" + l_tr_type + "' or '" + l_tr_type + "' = 'ALL')  " +
            "	 and h.pk like NVL('" + l_tac_hgtrh_pk + "', '%') and ( D.TCO_ITEM_PK = '" + l_Item_pk + "' or '" + l_Item_pk + "' is null) AND (g.tac_abpl_pk = '" + l_PLUnit + "' OR '" + l_PLUnit + "' IS NULL) and (E.NATION = '" + l_Nation + "' or '" + l_Nation + "' = 'ALL') " + 
        "			 and ('%' || upper(h.voucherno) || '%' like '%' || upper('" + l_voucherno + "') || '%' " +
        "			 	 or '" + l_voucherno + "' is null) " +
        "			 and ( '%' || upper(c.invoice_no) || '%' like '%' || upper('" + l_invoice_no + "') || '%' " +
        "			 			 	 or '" + l_invoice_no + "' is null )     			  " ;			
		}
		else
		{
	 	SQL
		= "select h.pk seq, h.voucherno, to_char(h.tr_date, 'dd/mm/yyyy') tr_date, " + 
	        "	   (select max(a.item) from tac_crcaditem a, tac_abitem b where a.del_if = 0 and b.del_if = 0 and a.TAC_ABITEM_PK = b.pk and a.tac_crca_pk = c.pk and b.item_nm = 'INVOICE NO') inv_no, " +
			"            	(select max(a.item) from tac_crcaditem a, tac_abitem b where a.del_if = 0 and b.del_if = 0 and a.TAC_ABITEM_PK = b.pk and a.tac_crca_pk = c.pk and b.item_nm = 'INVOICE DATE') inv_date, " +
	        "	       	(select max(a.item) from tac_crcaditem a, tac_abitem b where a.del_if = 0 and b.del_if = 0 and a.TAC_ABITEM_PK = b.pk and a.tac_crca_pk = c.pk and b.item_nm = 'SERIAL NO') serial_no, " +
			"   e.partner_id, e.partner_name, h.remark, " +
	        "	   f.ac_cd accd_dr, f1.ac_cd accd_cr1, f2.ac_cd accd_cr2, i.item_code, i.uom, d.qty, " +
	        "	   d.u_price, d.net_tr_amt, c.tr_rate, d.net_bk_amt, decode(d.vat_rate, '01', 'none', '00', '0', d.vat_rate) vat_rate, " +
	        "	   d.vat_tr_amt, d.vat_bk_amt, nvl(d.net_tr_amt,0) + nvl(d.vat_tr_amt, 0) trans_amt,  " +
            "	   nvl(d.net_bk_amt,0) + nvl(d.vat_bk_amt, 0) books_amt, d.order_no, c.tr_status, K.PL_CD||' - '||K.PL_NM, (select COUNTRY_NM from imex.tie_country a where  a.del_if = 0 and A.COUNTRY_NO = E.NATION) Nation   " +
	        "from tac_hgtrh h, " +
	        "	 tac_crca c, " +
	        "	 tac_crcad d, " +
	        "	 tco_buspartner e, " +
	        "	 tac_abacctcode f, " +
	        "	 tac_abacctcode f1, " +
	        "	 tac_abacctcode f2, " +
            "	 tlg_it_item i, TAC_ABPLCENTER g, tac_abpl k " +
	        "	 where h.del_if = 0 " +
	        "	 and c.del_if = 0 " +
	        "	 and d.del_if = 0 " +
            "    and i.del_if(+) = 0 and g.del_if(+) = 0 and k.del_if(+) = 0 " +	
	        "	 and h.tr_tablenm = 'TAC_CRCA' " +
	        "	 and h.tr_table_pk = c.pk " +
	        "	 and c.pk = d.tac_crca_pk " +
	        "	 and c.tco_buspartner_pk = e.pk(+) " +
	        "	 and c.tac_abacctcode_pk = f.pk(+) " +
	        "	 and d.tac_abacctcode_pk = f1.pk(+) " +
	        "	 and d.tac_abacctcode_pk_vat = f2.pk(+) " +
	        "	 and d.tco_item_pk = i.pk(+) and D.TAC_ABPLCENTER_PK = g.pk(+) and G.TAC_ABPL_PK = k.pk(+) " +
	        "	 and to_char(h.tr_date, 'yyyymmdd') between '" + l_tr_date_fr + "' and '" + l_tr_date_to + "' " +
	        "	 and ( c.tco_buspartner_pk = '" + l_tco_buspartner_pk + "' or '" + l_tco_buspartner_pk + "' is null)  " +
	        "	 and h.tr_status in ('2', '0', '4') " +
            "	 and (c.tr_type = '" + l_tr_type + "' or '" + l_tr_type + "' = 'ALL') and ( D.TCO_ITEM_PK = '" + l_Item_pk + "' or '" + l_Item_pk + "' is null) AND (g.tac_abpl_pk = '" + l_PLUnit + "' OR '" + l_PLUnit + "' IS NULL) and (E.NATION = '" + l_Nation + "' or '" + l_Nation + "' = 'ALL')  " +
	 		"	 and h.pk like NVL('" + l_tac_hgtrh_pk + "', '%') " + 
        "			 and ('%' || upper(h.voucherno) || '%' like '%' || upper('" + l_voucherno + "') || '%' " +
        "			 	 or '" + l_voucherno + "' is null) " +
        "			 and ( '%' || upper(c.invoice_no) || '%' like '%' || upper('" + l_invoice_no + "') || '%' " +
        "			 			 	 or '" + l_invoice_no + "' is null )     			  " ;					
		}
    //Response.Write(SQL);
    //Response.End();
		DataTable dtItem = new DataTable();
    dtItem = ESysLib.TableReadOpen(SQL); 
    if(dtItem.Rows.Count == 0)
    {
        Response.Write("There is not enough information to display!!!");
        Response.End();
    }	
	// buspartner 
	string l_buspartner_code = "", l_buspartner_name = "";
	if(l_tco_buspartner_pk != "")
	{
		SQL = "select partner_id, partner_name from tco_buspartner where del_if = 0 and pk = '" + l_tco_buspartner_pk + "'";
		DataTable dtPartner = new DataTable();
		dtPartner = ESysLib.TableReadOpen(SQL); 
		l_buspartner_code = dtPartner.Rows[0][0].ToString();
		l_buspartner_name = dtPartner.Rows[0][1].ToString();
	}
	else
	{
		l_buspartner_code = "";
		l_buspartner_name = "";
	}
	// status of Confirmed or Approved
	string ls_status = "";
	if(l_tr_status == "2")
		ls_status = "Confirmed";
	else if(l_tr_status == "0")
		ls_status = "Approved";
	// Domestic hay Oversea
	string ls_tr_type = "";
	if(l_tr_type == "DO")
	{
		ls_tr_type = "Domestic";
	}
	else if(l_tr_type == "OS")
	{
		ls_tr_type = "Oversea";
	}
	else
		ls_tr_type = "Domestic/Oversea";
%>
<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2190 style='border-collapse:
 collapse;table-layout:fixed;width:1645pt'>
 <col class=xl65 width=52 style='mso-width-source:userset;mso-width-alt:1479;
 width:39pt'>
 <col class=xl65 width=90 style='mso-width-source:userset;mso-width-alt:2560;
 width:68pt'>
 <col class=xl65 width=71 style='mso-width-source:userset;mso-width-alt:2019;
 width:53pt'>
 <col class=xl66 width=69 style='mso-width-source:userset;mso-width-alt:1962;
 width:52pt'>
 <col class=xl67 width=71 style='mso-width-source:userset;mso-width-alt:2019;
 width:53pt'>
 <col class=xl65 width=80 style='width:60pt'>
 <col class=xl65 width=109 style='mso-width-source:userset;mso-width-alt:3100;
 width:82pt'>
 <col class=xl65 width=160 style='mso-width-source:userset;mso-width-alt:4551;
 width:120pt'>
 <col class=xl65 width=154 style='mso-width-source:userset;mso-width-alt:4380;
 width:116pt'>
 <col class=xl66 width=61 span=3 style='mso-width-source:userset;mso-width-alt:
 1735;width:46pt'>
 <col class=xl65 width=95 style='mso-width-source:userset;mso-width-alt:2702;
 width:71pt'>
 <col class=xl65 width=39 style='mso-width-source:userset;mso-width-alt:1109;
 width:29pt'>
 <col class=xl68 width=102 style='mso-width-source:userset;mso-width-alt:2901;
 width:77pt'>
 <col class=xl68 width=80 style='width:60pt'>
 <col class=xl68 width=102 style='mso-width-source:userset;mso-width-alt:2901;
 width:77pt'>
 <col class=xl69 width=75 style='mso-width-source:userset;mso-width-alt:2133;
 width:56pt'>
 <col class=xl69 width=124 style='mso-width-source:userset;mso-width-alt:3527;
 width:93pt'>
 <col class=xl65 width=65 style='mso-width-source:userset;mso-width-alt:1848;
 width:49pt'>
 <col class=xl65 width=97 style='mso-width-source:userset;mso-width-alt:2759;
 width:73pt'>
 <col class=xl69 width=115 style='mso-width-source:userset;mso-width-alt:3271;
 width:86pt'>
 <col class=xl68 width=115 style='mso-width-source:userset;mso-width-alt:3271;
 width:86pt'>
 <col class=xl69 width=142 style='mso-width-source:userset;mso-width-alt:4039;
 width:107pt'>
 <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'> 
 <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:5000;
 width:81pt'> 
 <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:5000;
 width:81pt'> 
 <tr class=xl74 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl70 colspan=6 width=433 style='height:15.0pt;mso-ignore:
  colspan;width:325pt'><%=dtComp.Rows[0][0]%></td>
  <td class=xl74 width=109 style='width:82pt'></td>
  <td class=xl74 width=160 style='width:120pt'></td>
  <td class=xl74 width=154 style='width:116pt'></td>
  <td class=xl85 width=61 style='width:46pt'></td>
  <td class=xl85 width=61 style='width:46pt'></td>
  <td class=xl85 width=61 style='width:46pt'></td>
  <td class=xl74 width=95 style='width:71pt'></td>
  <td class=xl74 width=39 style='width:29pt'></td>
  <td class=xl74 width=102 style='width:77pt'></td>
  <td class=xl74 width=80 style='width:60pt'></td>
  <td class=xl74 width=102 style='width:77pt'></td>
  <td class=xl74 width=75 style='width:56pt'></td>
  <td class=xl74 width=124 style='width:93pt'></td>
  <td class=xl74 width=65 style='width:49pt'></td>
  <td class=xl74 width=97 style='width:73pt'></td>
  <td class=xl87 width=115 style='width:86pt'></td>
  <td class=xl74 width=115 style='width:86pt'></td>
  <td class=xl74 width=142 style='width:107pt'></td>
  <td class=xl29 width=108 style='width:81pt'></td>
  <td class=xl29 width=108 style='width:81pt'></td>
 </tr>
 <tr class=xl74 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl65 colspan=3 style='height:15.0pt;mso-ignore:colspan'>as at <%=dtComp.Rows[0][3]%></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl85 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl87></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl74 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td class=xl75 colspan=3 style='mso-ignore:colspan'>Customer:<font
  class="font13"><span style='mso-spacerun:yes'>  </span><%=l_buspartner_code%> || <%=l_buspartner_name%></font></td>
  <td colspan=2 class=xl75 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td colspan=2 class=xl76 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl85 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl87></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl74 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td class=xl77 colspan=4 style='mso-ignore:colspan'>Date:<font class="font13"><span
  style='mso-spacerun:yes'>                    </span><%=dtComp.Rows[0][4].ToString()%> ~ <%=dtComp.Rows[0][5].ToString()%></font></td>
  <td class=xl77></td>
  <td class=xl65></td>
  <td class=xl76 colspan=2 style='mso-ignore:colspan'>Status:<font class="font7"><span
  style='mso-spacerun:yes'>          </span><%=ls_status%><span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'></td>
  <td class=xl78>Origin:<font class="font7"><span
  style='mso-spacerun:yes'>          </span><%=ls_tr_type%><span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl76></td>
  <td colspan=8 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl87></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td class=xl68></td>
  <td class=xl69></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl78 height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl88 style='height:30.0pt'>Seq</td>
  <td colspan=2 class=xl88 style='border-left:none'>Chứng từ/<font class="font14">Voucher</font></td>
  <td colspan=3 class=xl88 style='border-left:none'>Hóa đơn GTGT</td>
  <td colspan=2 class=xl88 style='border-left:none'>Khách hàng/<font  class="font14">Customer</font></td>
  <td rowspan=2 class=xl89 width=154 style='width:116pt'>Diễn Giải<br><font class="font14">Description</font></td>
  <td rowspan=2 class=xl89 width=61 style='width:46pt'>TK<br><span style='mso-spacerun:yes'> </span>nợ</td>
  <td colspan=2 class=xl88 style='border-left:none'>Tài khoản có</td>
  <td rowspan=2 class=xl89 width=95 style='width:71pt'>Code <br>finish good</td>
  <td rowspan=2 class=xl88>Unit</td>
  <td rowspan=2 class=xl109 x:str="Quantity"><span  style='mso-spacerun:yes'> </span>Quantity<span  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl109 x:str="Price "><span  style='mso-spacerun:yes'> </span>Price<span  style='mso-spacerun:yes'>  </span></td>
  <td rowspan=2 class=xl110 width=102 style='width:77pt' x:str="Amount &#10;(Trans)"><span  style='mso-spacerun:yes'> </span>Amount <br>(Trans)<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl111 width=75 style='width:56pt' x:str="Exchange&#10; rate"><span  style='mso-spacerun:yes'> </span>Exchange<br><span style='mso-spacerun:yes'> </span>rate<span  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl111 width=124 style='width:93pt' x:str="Amount &#10;(Books"><span  style='mso-spacerun:yes'> </span>Amount <br> (Books<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl106 style='border-right:.5pt solid black;border-left:  none' x:str="VAT ">VAT<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl112 style='border-right:.5pt solid black;border-left:  none' x:str><span style='mso-spacerun:yes'> </span>Grand total<span  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl109 width=108 style='width:81pt' x:str="Order No"><span style='mso-spacerun:yes'> </span>Order No<span style='mso-spacerun:yes'> </span></td>  
  <td rowspan=2 class=xl109 width=108 style='width:81pt' x:str="PL Unit"><span style='mso-spacerun:yes'> </span>PL Unit<span style='mso-spacerun:yes'> </span></td>  
  <td rowspan=2 class=xl109 width=108 style='width:81pt' ><span style='mso-spacerun:yes'> </span>Nation<span style='mso-spacerun:yes'> </span></td>  
 </tr>
 <tr class=xl78 height=20 style='height:15.0pt'>
  <td height=20 class=xl88 style='height:15.0pt;border-top:none;border-left:  none'>Số/<font class="font14">No</font></td>
  <td class=xl88 style='border-top:none;border-left:none'>Ngày/<font  class="font14">Date</font></td>
  <td class=xl88 style='border-top:none;border-left:none'>Số/<font  class="font14">No</font></td>
  <td class=xl88 style='border-top:none;border-left:none'>Ngày/<font  class="font14">Date</font></td>
  <td class=xl104 style='border-top:none;border-left:none'>Serial</td>
  <td class=xl104 style='border-top:none;border-left:none'>Code</td>
  <td class=xl104 style='border-top:none;border-left:none'>Name</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 width=65 style='border-top:none;border-left:none;width:49pt'>rate (%)</td>
  <td class=xl88 style='border-top:none;border-left:none'>Trans</td>
  <td class=xl90 style='border-top:none;border-left:none' x:str="Books"><span  style='mso-spacerun:yes'> </span>Books<span style='mso-spacerun:yes'> </span></td>
  <td class=xl88 style='border-left:none'>Trans</td>
  <td class=xl88 style='border-left:none'>Books</td>
 </tr>
 <tr class=xl70 height=20 style='height:15.0pt'>
  <td height=20 class=xl91 id="_x0000_s1025" x:autofilter="all"  x:autofilterrange="$A$8:$Y$8" style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl92 id="_x0000_s1026" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl92 id="_x0000_s1027" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl91 id="_x0000_s1028" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl93 id="_x0000_s1029" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl92 id="_x0000_s1030" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl94 id="_x0000_s1031" x:autofilter="all">&nbsp;</td>
  <td class=xl92 id="_x0000_s1032" x:autofilter="all" style='border-top:none'>&nbsp;</td>
  <td class=xl91 id="_x0000_s1033" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl105 id="_x0000_s1034" x:autofilter="all" style='border-top:none;  border-left:none'>Debit</td>
  <td class=xl105 id="_x0000_s1035" x:autofilter="all" style='border-top:none;  border-left:none'>Credit</td>
  <td class=xl105 id="_x0000_s1036" x:autofilter="all" style='border-top:none;  border-left:none'>Credit</td>
  <td class=xl91 id="_x0000_s1037" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl91 id="_x0000_s1038" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl95 id="_x0000_s1039" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl95 id="_x0000_s1040" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl95 id="_x0000_s1041" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl96 id="_x0000_s1042" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl96 id="_x0000_s1043" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl91 id="_x0000_s1044" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl92 id="_x0000_s1045" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl97 id="_x0000_s1046" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl98 id="_x0000_s1047" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>
  <td class=xl96 id="_x0000_s1048" x:autofilter="all" style='border-top:none;  border-left:none'>&nbsp;</td>  
  <td class=xl96 id="_x0000_s1049" x:autofilter="all">&nbsp;</td>
  <td class=xl96 id="_x0000_s1050" x:autofilter="all" >&nbsp;</td>  
  <td class=xl96 id="Td1" x:autofilter="all" >&nbsp;</td>  
 </tr>
 <%
	int i ;
	// tong cong
	decimal l_sum_qty = 0, l_sum_trans_amt = 0, l_sum_book_amt = 0 ;
	decimal l_vat_trans_amt = 0, l_vat_book_amt = 0, l_grand_trans_amt = 0, l_grand_book_amt = 0;
	for(i = 0; i < dtItem.Rows.Count ; i++)
	{
		if(dtItem.Rows[i][14].ToString().Trim()!="")
			l_sum_qty += decimal.Parse(dtItem.Rows[i][14].ToString());
		if(dtItem.Rows[i][16].ToString().Trim()!="")
			l_sum_trans_amt += decimal.Parse(dtItem.Rows[i][16].ToString());
		if(dtItem.Rows[i][18].ToString().Trim()!="")
			l_sum_book_amt += decimal.Parse(dtItem.Rows[i][18].ToString());
		if(dtItem.Rows[i][20].ToString().Trim()!="")
			l_vat_trans_amt += decimal.Parse(dtItem.Rows[i][20].ToString());
		if(dtItem.Rows[i][21].ToString().Trim()!="")
			l_vat_book_amt += decimal.Parse(dtItem.Rows[i][21].ToString());
		if(dtItem.Rows[i][22].ToString().Trim()!="")
			l_grand_trans_amt += decimal.Parse(dtItem.Rows[i][22].ToString());
		if(dtItem.Rows[i][23].ToString().Trim()!="")
			l_grand_book_amt += decimal.Parse(dtItem.Rows[i][23].ToString());			
 %>
 <tr class=xl71 height=20 style='height:15.0pt'>
  <td height=20 class=xl80 align=right style='height:15.0pt' x:num><%=dtItem.Rows[i][0]%></td>
  <td class=xl79><%=dtItem.Rows[i][1]%></td>
  <td class=xl81 style='border-left:none' x:num><%=dtItem.Rows[i][2]%></td>
  <td class=xl82 style='border-left:none' x:num><%=dtItem.Rows[i][3]%></td>
  <td class=xl81 style='border-left:none' x:num><%=dtItem.Rows[i][4]%></td>
  <td class=xl80 style='border-left:none'><%=dtItem.Rows[i][5]%></td>
  <td class=xl80 style='border-left:none'><%=dtItem.Rows[i][6]%></td>
  <td class=xl80 style='border-left:none'><%=dtItem.Rows[i][7]%></td>
  <td class=xl80 style='border-left:none'><%=dtItem.Rows[i][8]%></td>
  <td class=xl82 style='border-left:none' x:num><%=dtItem.Rows[i][9]%></td>
  <td class=xl82 style='border-left:none' x:num><%=dtItem.Rows[i][10]%></td>
  <td class=xl82 style='border-left:none' x:num><%=dtItem.Rows[i][11]%></td>
  <td class=xl80 style='border-left:none'><%=dtItem.Rows[i][12]%></td>
  <td class=xl80 style='border-left:none'><%=dtItem.Rows[i][13]%></td>
  <td class=xl114 align=right style='border-left:none' x:num><%=dtItem.Rows[i][14]%></td>
  <td class=xl114 align=right style='border-left:none' x:num><%=dtItem.Rows[i][15]%></td>
  <td class=xl83 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][16]%> </td>
  <td class=xl116 align=right style='border-left:none' x:num><%=dtItem.Rows[i][17]%></td>
  <td class=xl116 align=right style='border-left:none' x:num><%=dtItem.Rows[i][18]%></td>
  <td class=xl84 style='border-left:none' x:num><%=dtItem.Rows[i][19]%>%</td>
  <td class=xl114 style='border-left:none' x:num><%=dtItem.Rows[i][20]%></td>
  <td class=xl86 style='border-left:none' x:num><%=dtItem.Rows[i][21]%></td>
  <td class=xl83 style='border-left:none' x:num><%=dtItem.Rows[i][22]%></td>
  <td class=xl86 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][23]%></td>
  <td class=xl79 ><%=dtItem.Rows[i][24]%></td>
  <td class=xl79 style='text-align:left;mso-text-control:shrinktofit'><%=dtItem.Rows[i][26]%></td>
  <td class=xl79 style='text-align:left;mso-text-control:shrinktofit'><%=dtItem.Rows[i][27]%></td>
 </tr>
 <%
	}
 %>
 
 <tr class=xl70 height=19 style='height:14.25pt'>
  <td height=19 class=xl99 style='height:14.25pt;border-top:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none' x:str>TOTAL<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl115 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_qty%></td>
  <td class=xl102 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none;border-left:none'
  x:num><span
  style='mso-spacerun:yes'> </span><%=l_sum_trans_amt%> </td>
  <td class=xl117 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl117 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_book_amt%></td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl118 align=right style='border-top:none;border-left:none' x:num><%=l_vat_trans_amt%></td>
  <td class=xl103 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=l_vat_book_amt%> </td>
  <td class=xl102 style='border-top:none;border-left:none' x:num><%=l_grand_trans_amt%> </td>
  <td class=xl103 style='border-top:none;border-left:none'
  x:num><span
  style='mso-spacerun:yes'> </span><%=l_grand_book_amt%> </td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl99 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td class=xl68></td>
  <td class=xl69></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td class=xl68></td>
  <td class=xl69></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=52 style='width:39pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=142 style='width:107pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
