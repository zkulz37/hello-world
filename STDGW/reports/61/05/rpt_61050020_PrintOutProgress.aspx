<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Pk = Request["pk"];
    DataTable dt = ESysLib.TableReadOpenCursor("pm_rpt_61050020_progressm", p_Pk);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data !!");
        Response.End();
    }
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_61050020_PrintOutProgress_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_61050020_PrintOutProgress_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_61050020_PrintOutProgress_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-08-06T07:34:03Z</o:LastPrinted>
  <o:Created>2011-08-06T07:28:52Z</o:Created>
  <o:LastSaved>2011-08-06T07:34:21Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-header-data:&L&G;
	margin:.75in 0in 0in .17in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
.style60
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl80
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;}
.xl88
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt hairline windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl90
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl92
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl93
	{mso-style-parent:style60;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;}
.xl94
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style60;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl101
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl103
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl106
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl107
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl108
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl115
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl117
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>subcontract report PMS form</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>92</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
      <x:HeaderPicture>
       <x:Location>Left</x:Location>
       <x:Source>rpt_61050020_PrintOutProgress_files/image001.jpg</x:Source>
       <x:Height>42</x:Height>
       <x:Width>132.75</x:Width>
       <x:LockAspectRatio/>
       <x:ColorType>Automatic</x:ColorType>
      </x:HeaderPicture>
     </x:Print>
     <x:CodeName>Sheet2</x:CodeName>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>24</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7620</x:WindowHeight>
  <x:WindowWidth>18495</x:WindowWidth>
  <x:WindowTopX>600</x:WindowTopX>
  <x:WindowTopY>555</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl68>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1136 style='border-collapse:
 collapse;table-layout:fixed;width:851pt'>
 <col class=xl68 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl68 width=178 style='mso-width-source:userset;mso-width-alt:6509;
 width:134pt'>
 <col class=xl69 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl68 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl68 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl68 width=103 span=6 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl68 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl68 width=13 style='height:9.75pt;width:10pt'></td>
  <td class=xl68 width=178 style='width:134pt'></td>
  <td class=xl69 width=97 style='width:73pt'></td>
  <td class=xl68 width=103 style='width:77pt'></td>
  <td class=xl68 width=35 style='width:26pt'></td>
  <td class=xl68 width=103 style='width:77pt'></td>
  <td class=xl68 width=103 style='width:77pt'></td>
  <td class=xl68 width=103 style='width:77pt'></td>
  <td class=xl68 width=103 style='width:77pt'></td>
  <td class=xl68 width=103 style='width:77pt'></td>
  <td class=xl68 width=103 style='width:77pt'></td>
  <td class=xl68 width=92 style='width:69pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl70>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td colspan=11 class=xl104 style='border-right:.5pt solid black'>SUBCONTRACT INFORMATION</td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl68 style='height:9.0pt'></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl69></td>
  <td class=xl76></td>
  <td colspan=7 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl68 style='height:14.1pt'></td>
  <td class=xl78>Project Name</td>
  <td class=xl69><%=dt.Rows[0][0].ToString()%></td>
  <td colspan=7 class=xl69><%=dt.Rows[0][1].ToString()%></td>
  <td class=xl68></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>Subcontract No.</td>
  <td class=xl69><%=dt.Rows[0][2].ToString()%></td>
  <td colspan=7 class=xl69><%=dt.Rows[0][3].ToString()%></td>
  <td class=xl68></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>Original Contract Amount (Net)</td>
  <td class=xl69><%=dt.Rows[0][4].ToString()%></td>
  <td class=xl79 x:num><%=dt.Rows[0][5].ToString()%></td>
  <td class=xl68></td>
  <td class=xl68>Contract Period</td>
  <td colspan=4 class=xl107 ><%=dt.Rows[0][6].ToString()%> ~ <%=dt.Rows[0][7].ToString()%></td>
  <td class=xl68></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>Final Contract Amount (Net)</td>
  <td class=xl69><%=dt.Rows[0][8].ToString()%></td>
  <td class=xl79 x:num><%=dt.Rows[0][9].ToString()%></td>
  <td class=xl68></td>
  <td class=xl68>Warranty Period</td>
  <td colspan=2 class=xl80 ><%=dt.Rows[0][10].ToString()%> month(s)</td>
  <td class=xl80></td>
  <td class=xl81></td>
  <td class=xl68></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>Payment Condition</td>
  <td class=xl69>Advance</td>
  <td class=xl82 x:num><%=dt.Rows[0][11].ToString()%>%</td>
  <td class=xl68></td>
  <td class=xl68>Progress</td>
  <td class=xl82 x:num><%=dt.Rows[0][12].ToString()%>%</td>
  <td class=xl68>Retention</td>
  <td class=xl82 x:num><%=dt.Rows[0][13].ToString()%>%</td>
  <td class=xl68>Withholding Tax</td>
  <td class=xl83 x:num><%=dt.Rows[0][14].ToString()%>%</td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>&nbsp;</td>
  <td class=xl83></td>
  <td colspan=8 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl68 style='height:8.25pt'></td>
  <td class=xl78>&nbsp;</td>
  <td class=xl69></td>
  <td colspan=8 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td rowspan=2 class=xl108 style='border-bottom:.5pt hairline black'>PAYMENT STATUS</td>
  <td rowspan=2 class=xl110 style='border-bottom:.5pt hairline black'>Percentage</td>
  <td colspan=2 class=xl112 style='border-right:.5pt hairline black;border-left:  none'>Claimed Amount</td>
  <td class=xl84 style='border-left:none'>VAT</td>
  <td class=xl84 style='border-left:none'>Deduct AP</td>
  <td class=xl84 style='border-left:none'>Retention</td>
  <td class=xl85 style='border-left:none'>Withholding Tax</td>
  <td class=xl84 style='border-left:none'>Net Payable</td>
  <td class=xl84 style='border-left:none'>Total Payable</td>
  <td rowspan=2 class=xl114 style='border-bottom:.5pt hairline black'>Remark</td>
 </tr>
 <%
     DataTable dt_Detail_Sum = ESysLib.TableReadOpenCursor("pm_rpt_61050020_progressd_sum", p_Pk);
     string p_Sum0 = "", p_Sum1 = "", p_Sum2 = "", p_Sum3 = "", p_Sum4 = "", p_Sum5 = "", p_Sum6 = "";
     if (dt_Detail_Sum.Rows.Count > 0)
     {
         p_Sum0 = dt_Detail_Sum.Rows[0][0].ToString();
         p_Sum1 = dt_Detail_Sum.Rows[0][1].ToString();
         p_Sum2 = dt_Detail_Sum.Rows[0][2].ToString();
         p_Sum3 = dt_Detail_Sum.Rows[0][3].ToString();
         p_Sum4 = dt_Detail_Sum.Rows[0][4].ToString();
         p_Sum5 = dt_Detail_Sum.Rows[0][5].ToString();
         p_Sum6 = dt_Detail_Sum.Rows[0][6].ToString();
     }
  %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td colspan=2 class=xl86 style='border-right:.5pt hairline black;border-left:  none' x:num><%=p_Sum0%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=p_Sum1%></td>
  <td class=xl86 style='border-top:none' x:num><%=p_Sum2%></td>
  <td class=xl86 style='border-top:none' x:num><%=p_Sum3%></td>
  <td class=xl86 style='border-top:none' x:num><%=p_Sum4%></td>
  <td class=xl86 style='border-top:none' x:num><%=p_Sum5%></td>
  <td class=xl86 style='border-top:none' x:num><%=p_Sum6%></td>
 </tr>
 
 <%
     int i = 0;
     decimal p_Issued_Net = 0;
     decimal p_Issued_Net1 = 0;
     decimal p_Issued_VAT = 0;
     decimal p_Issued_VAT1 = 0;
     decimal p_Issued_Total = 0;
     decimal p_TotalPaid = 0;
     decimal p_F15 = 0;
     decimal p_J15 = 0;
     DataTable dt_Detail = ESysLib.TableReadOpenCursor("pm_rpt_61050020_progressd", p_Pk);
     for(i=0;i<dt_Detail.Rows.Count;i++)
     {
         if (dt_Detail.Rows[i][2].ToString().Trim() != "")
         {
             p_Issued_Net += decimal.Parse(dt_Detail.Rows[i][2].ToString());
             p_Issued_Net1 = p_Issued_Net - decimal.Parse(dt_Detail.Rows[0][2].ToString());
         }
         else
         {
             p_Issued_Net1 += 0;
         }

         if (dt_Detail.Rows[i][3].ToString().Trim() != "")
         {
             p_Issued_VAT += decimal.Parse(dt_Detail.Rows[i][3].ToString());
             p_Issued_VAT1 = p_Issued_VAT - decimal.Parse(dt_Detail.Rows[0][3].ToString());
         }
         else
         {
             p_Issued_VAT1 += 0;
         }

         p_F15=decimal.Parse(dt_Detail.Rows[i][3].ToString());
         p_J15 = decimal.Parse(dt_Detail.Rows[i][7].ToString());

         p_TotalPaid = p_F15 + p_J15;

         p_Issued_Total = p_Issued_Net1 + p_Issued_VAT1;
  %>
 <tr height=22 style='mso-height-source:auto;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl117 width=178 style='border-top:none;width:134pt'><%=dt_Detail.Rows[i][0]%></td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><%=dt_Detail.Rows[i][1]%></td>
  <td colspan=2 class=xl102 style='border-right:.5pt hairline black;border-left:  none' x:num><%=dt_Detail.Rows[i][2]%></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_Detail.Rows[i][3]%></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_Detail.Rows[i][4]%></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_Detail.Rows[i][5]%></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_Detail.Rows[i][6]%></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_Detail.Rows[i][7]%></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=dt_Detail.Rows[i][8]%></td>
  <td class=xl89 style='border-top:none;border-left:none'><%=dt_Detail.Rows[i][9]%></td>
 </tr>
 <%} %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>&nbsp;</td>
  <td class=xl69></td>
  <td colspan=8 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl90>SUMMARY</td>
  <td class=xl69></td>
  <td class=xl91>Net</td>
  <td class=xl91></td>
  <td class=xl91>VAT</td>
  <td class=xl91>Total</td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>Contract Amount</td>
  <td class=xl83></td>
  <td class=xl92 x:num><%=dt.Rows[0][5]%></td>
  <td class=xl68></td>
  <td class=xl79 x:num><%=dt.Rows[0][15]%></td>
  <td class=xl92 x:num><%=dt.Rows[0][16]%></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>Issued VAT invoice</td>
  <td class=xl69></td>
  <td class=xl92 x:num><%=p_Issued_Net1%></td>
  <td class=xl68></td>
  <td class=xl92 x:num><%=p_Issued_VAT1%></td>
  <td class=xl92 x:num><%=p_Issued_Total%></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>Remain VAT invoice</td>
  <td class=xl69></td>
  <td class=xl92 x:num><%= decimal.Parse(dt.Rows[0][5].ToString()) - p_Issued_Net1%></td>
  <td class=xl68></td>
  <td class=xl92 x:num><%= decimal.Parse(dt.Rows[0][15].ToString()) - p_Issued_VAT1%></td>
  <td class=xl92 x:num><%= decimal.Parse(dt.Rows[0][16].ToString()) - p_Issued_Total%></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
  <%
      decimal p_Paid_Percent = 0;
      decimal p_Paid_Net = 0;
      decimal p_Paid_VAT = 0;
      decimal p_Paid_Total = 0;
      DataTable dt_PaidAmt = ESysLib.TableReadOpenCursor("pm_rpt_61050020_progd_paidamt", p_Pk);
      if (dt_PaidAmt.Rows.Count > 0)
      {
          p_Paid_Percent = decimal.Parse(dt_PaidAmt.Rows[0][0].ToString());
          p_Paid_Net = decimal.Parse(dt_PaidAmt.Rows[0][1].ToString());
          p_Paid_VAT = decimal.Parse(dt_PaidAmt.Rows[0][2].ToString());
          p_Paid_Total = decimal.Parse(dt_PaidAmt.Rows[0][3].ToString());
      }
  %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl78>Paid Amount</td>
  <td class=xl93 x:num><%=p_Paid_Percent%></td>
  <td class=xl92 x:num><%=p_Paid_Net%></td>
  <td class=xl68></td>
  <td class=xl92 x:num><%=p_Paid_VAT%></td>
  <td class=xl92 x:num><%=p_Paid_Total%></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl94>Balance</td>
  <td class=xl95 x:num>96%</td>
  <td class=xl96 x:num><%= decimal.Parse(dt.Rows[0][5].ToString()) - p_Paid_Net%></td>
  <td class=xl97>&nbsp;</td>
  <td class=xl96 x:num><%= decimal.Parse(dt.Rows[0][15].ToString()) - p_Paid_VAT%></td>
  <td class=xl96 x:num><%= decimal.Parse(dt.Rows[0][16].ToString()) - p_Paid_Total%></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl68 style='height:17.1pt'></td>
  <td class=xl98>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl100>&nbsp;</td>
  <td class=xl101>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=13 style='width:10pt'></td>
  <td width=178 style='width:134pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=92 style='width:69pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
