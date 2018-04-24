<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%        
    string p_in_type            = Request.QueryString["p_in_type"];
    string p_whtype             = Request.QueryString["p_whtype"];
    string p_from_date          = Request.QueryString["p_from_date"];
    string p_to_date            = Request.QueryString["p_to_date"];
    string p_tin_warehouse_pk   = Request.QueryString["p_tin_warehouse_pk"]; 
    string p_po_vendor          = Request.QueryString["p_po_vendor"];
    string p_item               = Request.QueryString["p_item"];
    string p_wh_name = "-";
    
    string para = " '" + p_whtype + "','" + p_tin_warehouse_pk + "','" + p_from_date + "','" + p_to_date + "','" + p_po_vendor + "','" + p_item + "'";

    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("LG_RPT_BINI00020_SAMIL", para);
    dt1 = ESysLib.TableReadOpenCursor("LG_SEL_BINI00020_3", "'" + p_tin_warehouse_pk + "'");
    if (dt1.Rows.Count > 0) p_wh_name = dt1.Rows[0][0].ToString();
    if (dt.Rows.Count == 0) Response.End();
        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bini00020_SAMIL_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bini00020_SAMIL_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bini00020_SAMIL_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VNG</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-06-20T09:05:52Z</o:LastPrinted>
  <o:Created>2012-04-24T05:09:54Z</o:Created>
  <o:LastSaved>2012-06-20T09:10:28Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
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
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font7
	{color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style17
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
.style21
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\] 2 2";}
.style22
	{mso-number-format:General;
	mso-style-name:"Comma \[0\]_Sheet1";}
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
.style23
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
	mso-style-name:"Normal 2";}
.style24
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\B9D1\C740 \ACE0\B515", sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2 2";}
.style25
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\B9D1\C740 \ACE0\B515", monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2 2 3";}
.style26
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
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style24;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style24;
	font-size:8.0pt;
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
.xl37
	{mso-style-parent:style24;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl38
	{mso-style-parent:style17;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl39
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
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
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style17;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl42
	{mso-style-parent:style24;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl43
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style26;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style25;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style25;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#D3CFC6;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#D3CFC6;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style24;
	font-size:8.0pt;
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
.xl56
	{mso-style-parent:style24;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style26;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style26;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#D3CFC6;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style23;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}	
.xl63
	{
    mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>203</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>17595</x:WindowWidth>
  <x:WindowTopX>840</x:WindowTopX>
  <x:WindowTopY>630</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl30>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1010 style='border-collapse:
 collapse;table-layout:fixed;width:759pt'>
 <col class=xl30 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl30 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl30 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl30 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl30 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl30 width=106 span=2 style='mso-width-source:userset;mso-width-alt:
 3876;width:80pt'>
 <col class=xl30 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl30 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl30 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl30 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl30 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=12 height=38 class=xl53 width=1010 style='height:28.5pt;
  width:759pt'>&#51068;&#51068; &#51077;&#44256;<font class="font7"> - BÁO CÁO
  NH&#7852;P H&#7856;NG NGÀY</font></td>
 </tr>
 <tr class=xl31 height=19 style='height:14.25pt'>
  <td height=19 class=xl32 style='height:14.25pt'>WH: <%= p_wh_name %></td>
  <td class=xl33></td>
  <td class=xl31></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl31></td>
  <td class=xl33><%=System.DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%> ~ <%=System.DateTime.ParseExact(p_to_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td colspan=5 class=xl33 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=10 class=xl34 style='height:12.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl54>Print date : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl35 width=79 style='height:33.75pt;width:59pt'>&#51068;&#51088;<br>
   Ngày nh&#7853;p</td>
  <td class=xl36 width=91 style='width:68pt'>&#51204;&#54364;&#48264;&#54840;<br>
    S&#7889; phi&#7871;u</td>
  <td class=xl36 width=99 style='width:74pt'>&#49345;&#54840;<br>
    Tên cty</td>
  <td colspan=2 class=xl55 width=128 style='border-right:.5pt solid black;
  border-left:none;width:96pt'>&#54408;&#47749;<br>
    Tên hàng (VN)</td>
  <td class=xl36 width=106 style='width:80pt'>&#54408;&#47749;<br>
    Tên hàng (KR)</td>
  <td class=xl37 width=106 style='width:80pt'>&#44508;&#44201;<br>
    Quy cách</td>
  <td class=xl38 width=46 style='width:35pt' x:str="&#45800;&#50948;&#10;&#272;VT"><span
  style='mso-spacerun:yes'> </span>&#45800;&#50948;<br>
    &#272;VT<span style='mso-spacerun:yes'> </span></td>
  <td class=xl39 width=77 style='width:58pt' x:str="&#49688;&#47049;&#10;S&#7889; l&#432;&#7907;ng"><span
  style='mso-spacerun:yes'> </span>&#49688;&#47049;<br>
    S&#7889; l&#432;&#7907;ng<span style='mso-spacerun:yes'> </span></td>
  <td class=xl40 width=81 style='width:61pt' x:str="&#45800;&#44032;&#10;&#272;&#417;n Giá"><span
  style='mso-spacerun:yes'> </span>&#45800;&#44032;<br>
    &#272;&#417;n Giá<span style='mso-spacerun:yes'> </span></td>
  <td class=xl41 width=98 style='width:74pt' x:str="&#44552; &#50529;&#10;Thành ti&#7873;n"><span
  style='mso-spacerun:yes'> </span>&#44552; &#50529;<br>
    Thành ti&#7873;n<span style='mso-spacerun:yes'> </span></td>
  <td class=xl42 width=99 style='width:74pt'>&#48708;&#44256;<br>
    Ghi chú</td>
 </tr>
 <%
     string strDate = string.Empty;
     int[] arrDate_count = new int[dt.Rows.Count];
     int a = 0;
     int strDate_count = 1;

     for (int y = 0; y < dt.Rows.Count; y++)
     {
         if (string.IsNullOrEmpty(strDate))
         {
             strDate = dt.Rows[y]["in_date"].ToString();
             strDate_count = 1;
         }
         else
         {
             if (dt.Rows[y]["in_date"].ToString().Trim() != strDate.Trim())
             {
                 arrDate_count[a] = strDate_count;
                 strDate_count = 1;
                 a++;
                 strDate = dt.Rows[y]["in_date"].ToString();
             }
             else
             {
                 strDate_count++;
             }
         }
     }
     arrDate_count[a] = strDate_count;
     a = 0;
     strDate = string.Empty;
     //-----------
     string str_date = string.Empty;
     bool change = false;
     double total = 0, total_all = 0 ;
     try
     {
         for (int i = 0; i < dt.Rows.Count; i++)
         {
             if (string.IsNullOrEmpty(dt.Rows[i]["slip_no"].ToString()))
             {
                 change = true;
             }
             else
             {
                 change = false;
             }
 %>

<%     
     if (str_date != dt.Rows[i]["in_date"].ToString() && i > 1)
     {
             %>
              <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=7 height=21 class=xl59 style='border-right:.5pt solid black;
  height:15.75pt'>Total</td>
  <td class=xl51 style='border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl51 style='border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl51 style='border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl52 style='border-top:.5pt solid black' x:num><span
  style='mso-spacerun:yes'><%= total%></span></td>
  <td class=xl51 style='border-top:.5pt solid black'>&nbsp;</td>
 </tr>
             <%
     total = 0;
     }
            
%>
<tr height=22 style='mso-height-source:userset;height:16.5pt'>
          <%  if (str_date != dt.Rows[i]["in_date"].ToString())
              {%> 
  <td rowspan="<%=arrDate_count[a]%>"  height=22 class=<% if(change){ %>xl62<% total = 0; }else{%>xl43<%}%> style='height:16.5pt; border-bottom:.5pt hairline windowtext'><%= dt.Rows[i]["in_date"]%></td>
    <% 
     str_date = dt.Rows[i]["in_date"].ToString();
     a++;
              }
  %>  
  <td class=<% if(change){ %>xl62<%}else{%>xl44<%}%> style='border-bottom:.5pt hairline windowtext'><%= dt.Rows[i]["slip_no"]%></td>
  <td class=<% if(change){ %>xl62<%}else{%>xl44<%}%> style='border-bottom:.5pt hairline windowtext'><%= dt.Rows[i]["partner_name"]%></td>
  <td colspan=2 class=<% if(change){ %>xl62<%}else{%>xl57<%}%> style='border-right:.5pt solid black;border-left:
  none;border-bottom:.5pt hairline windowtext'><%= dt.Rows[i]["item_lname"]%></td>
  <td class=<% if(change){ %>xl62<%}else{%>xl45<%}%> style='border-bottom:.5pt hairline windowtext'><%= dt.Rows[i]["item_fname"]%></td>
  <td class=<% if(change){ %>xl62<%}else{%>xl46<%}%> style='border-bottom:.5pt hairline windowtext'><%= dt.Rows[i]["spec01_nm"]%></td>
  <td class=<% if(change){ %>xl62<%}else{%>xl46<%}%> style='border-bottom:.5pt hairline windowtext'><%= dt.Rows[i]["in_uom"]%></td>
  <td class=<% if(change){ %>xl62<%}else{%>xl48<%}%> x:num style='border-bottom:.5pt hairline windowtext'><%= dt.Rows[i]["in_qty"]%></td>
  <td class=<% if(change){ %>xl62<%}else{%>xl48<%}%> x:num style='border-bottom:.5pt hairline windowtext'><span style='mso-spacerun:yes'>              
  </span><%= dt.Rows[i]["unit_price"]%></td>
  <td class=<% if(change){ %>xl63<%}else{%>xl49<%}%> x:num style='border-bottom:.5pt hairline windowtext'><span style='mso-spacerun:yes'>            
  </span><%= dt.Rows[i]["item_amount"]%></td>
  <td class=<% if(change){ %>xl62<%}else{%>xl50<%}%> style='border-bottom:.5pt hairline windowtext'><%= dt.Rows[i]["description"]%></td>
 </tr>   
      <%
     total += Convert.ToDouble(dt.Rows[i]["item_amount"]);
     total_all += Convert.ToDouble(dt.Rows[i]["item_amount"]);
     if (change) { total = 0; total_all = 0; }
         }%>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=7 height=21 class=xl59 style='border-right:.5pt solid black;
  height:15.75pt'>Total</td>
  <td class=xl51 style='border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl51 style='border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl51 style='border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl52 style='border-top:.5pt solid black' x:num><span
  style='mso-spacerun:yes'><%= total%></span></td>
  <td class=xl51 style='border-top:.5pt solid black'>&nbsp;</td>
 </tr>     
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=7 height=25 class=xl62 style='border-right:.5pt solid black;
  height:22pt'>GRAND TOTAL</td>
  <td class=xl62 style='border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl62 style='border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl62 style='border-top:.5pt solid black'>&nbsp;</td>
  <td class=xl63 style='border-top:.5pt solid black' x:num><span
  style='mso-spacerun:yes'><%= total_all%></span></td>
  <td class=xl62 style='border-top:.5pt solid black'>&nbsp;</td>
 </tr>
<tr><td colspan=12 style='mso-ignore:colspan'></td></tr>
<tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt'></td>
  <td colspan=10 rowspan=12 height=204 class=xl30 width=832 style='mso-ignore:
  colspan-rowspan;height:153.0pt;width:626pt'><!--[if gte vml 1]><v:shapetype
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
   margin-left:9.75pt;margin-top:6pt;width:564.75pt;height:142.5pt;z-index:1'>
   <v:imagedata src="rpt_bini00020_SAMIL_files/image001.gif" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF></x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=13 height=8></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=753 height=190 src="rpt_bini00020_SAMIL_files/image001.gif"
    v:shapes="_x0000_s1025"></td>
    <td width=66></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:624.0pt;height:153.0pt'></span><![endif]--></td>
  <td class=xl30></td>
 </tr>
<%} catch(Exception ex) { %>
<tr>
    <td></td>
    <td colspan=11 style='mso-ignore:colspan'><%= ex.Message %>
    </td>
</tr>
<%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=79 style='width:59pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
