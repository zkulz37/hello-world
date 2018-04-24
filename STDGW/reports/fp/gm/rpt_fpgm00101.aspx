<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_ordplan_pk = Request.QueryString["p_pp_ordplan_pk"];
	string p_style		= Request.QueryString["p_style"];
	string p_wp_type	= Request.QueryString["p_wp_type"];
	string p_spec01_pk  = Request.QueryString["p_spec01_pk"];
	string p_spec02_pk  = Request.QueryString["p_spec02_pk"];
	string p_spec03_pk  = Request.QueryString["p_spec03_pk"];
	string p_spec04_pk  = Request.QueryString["p_spec04_pk"];
	string p_spec05_pk  = Request.QueryString["p_spec05_pk"];
	string p_date		= Request.QueryString["p_date"];
	String p_lang		= Request.QueryString["p_lang"];

    string para = "'" + p_ordplan_pk + "','" + p_wp_type + "','" + p_spec01_pk +"','" + p_spec02_pk + "','" + p_spec03_pk + "','" + p_spec04_pk +"','" + p_spec05_pk + "','" + p_date + "'";

	DataTable dt1;
    dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_fpgm00101", para);  
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpgm00101_files/filelist.xml">
<link rel=Edit-Time-Data href="fpgm00101_files/editdata.mso">
<link rel=OLE-Object-Data href="fpgm00101_files/oledata.mso">
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
  <o:LastPrinted>2011-03-07T04:17:14Z</o:LastPrinted>
  <o:Created>2011-02-24T07:26:18Z</o:Created>
  <o:LastSaved>2011-03-09T06:22:56Z</o:LastSaved>
  <o:Company>Prive</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .24in .2in .23in;
	mso-header-margin:.2in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
.font10
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;
	background:white;
	mso-pattern:#CCCCFF gray-25;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;
	background:white;
	mso-pattern:silver gray-25;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;
	background:white;
	mso-pattern:silver gray-25;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:2.0pt double navy;
	background:white;
	mso-pattern:#CCCCFF gray-25;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:2.0pt double navy;
	border-bottom:2.0pt double navy;
	border-left:none;
	background:white;
	mso-pattern:silver gray-25;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:.5pt dashed navy;
	border-left:.5pt solid navy;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dashed navy;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:2.0pt double windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:dd;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:2.0pt double navy;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:dd;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:2.0pt double navy;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:.5pt solid navy;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:\AD81\C11C, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:2.0pt double windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:\AD81\C11C, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:\AD81\C11C, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double navy;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl56
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:.5pt solid navy;
	background:white;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;
	background:white;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:.5pt solid navy;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:2.0pt double navy;
	border-bottom:none;
	border-left:.5pt solid navy;}
.xl61
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;}
.xl62
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:.5pt solid navy;
	border-left:2.0pt double windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;}
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;}
.xl65
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:.5pt solid navy;
	background:white;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;
	background:white;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:2.0pt double navy;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double navy;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>COMP_BAL</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>375</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>18</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9465</x:WindowHeight>
  <x:WindowWidth>17835</x:WindowWidth>
  <x:WindowTopX>600</x:WindowTopX>
  <x:WindowTopY>300</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="7169"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="3"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=950 style='border-collapse:
 collapse;table-layout:fixed;width:717pt'>
 <col class=xl24 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=45 span=15 style='mso-width-source:userset;mso-width-alt:
 1645;width:34pt'>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td colspan=3 rowspan=3 height=105 width=185 style='height:78.75pt;
  width:139pt' align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s3073" type="#_x0000_t75" style='position:absolute;
   margin-left:6pt;margin-top:3.75pt;width:128.25pt;height:71.25pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_stitemphoto_pk"]%>&table_name=TCO_STITEMPHOTO" o:title="f15111"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:8px;margin-top:5px;width:171px;
  height:95px'><img width=84 height=60 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_stitemphoto_pk"]%>&table_name=TCO_STITEMPHOTO" v:shapes="_x0000_s3073">
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 rowspan=3 height=105 class=xl53 width=185 style='height:78.75pt;
    width:139pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=16 class=xl50 width=765 style='border-right:2.0pt double black;
  width:578pt'>Component
  Balance Hourly</td>
 </tr>
 <tr class=xl25 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=5 height=29 class=xl62 style='height:21.75pt'><font class="font11">P/O No :</font><font
  class="font10"> </font><font class="font12"><%= dt1.Rows[0]["ref_po_no"] %></font></td>
  <td colspan=6 class=xl45 style='border-right:.5pt solid black'><font class="font11">Style :</font><font
  class="font10"> </font><font class="font12"><%= dt1.Rows[0]["style_name"] %></font></td>
  <td colspan=5 class=xl69 style='border-right:2.0pt double black'>Buyer :<font class="font10"> </font><font
  class="font12"><%= dt1.Rows[0]["partner_name"] %></font></td>
 </tr>
 <tr class=xl25 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=5 height=29 class=xl34 style='border-right:.5pt solid black;
  height:21.75pt'><font class="font11">W/P
  Type:</font><font class="font10"> </font><font class="font12"><%= dt1.Rows[0]["wp_type"] %></font></td>
  <td colspan=3 class=xl48 style='border-right:.5pt solid black;border-left:
  none'><font class="font11">Spec :</font><font
  class="font10"> </font><font class="font12"><%= dt1.Rows[0]["spec"] %></font></td>
  <td colspan=3 class=xl48 style='border-right:.5pt solid black;border-left:
  none'><font class="font11">Target :</font><font
  class="font10"> </font><font class="font12"><%= dt1.Rows[0]["plan_qty"] %></font></td>
  <td colspan=5 class=xl43 style='border-right:2.0pt double black'><font class="font11">Date :</font><font
  class="font10"> </font><font class="font12"><%= dt1.Rows[0]["prod_date"] %></font></td>
 </tr>
 <tr class=xl25 height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl30 width=25 style='height:33.75pt;width:19pt'>No</td>
  <td class=xl26 width=60 style='border-left:none;width:45pt'>PATTERN<br>
    NO</td>
  <td width=100 style='width:75pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s3075" type="#_x0000_t75" style='position:absolute;margin-left:75pt;
   margin-top:33.75pt;width:0;height:0;z-index:2'>
   <v:imagedata src="fpgm00101_files/image003.png" o:title=""/>
  </v:shape><v:shapetype id="_x0000_t135" coordsize="21600,21600" o:spt="135"
   path="m10800,qx21600,10800,10800,21600l,21600,,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect" textboxrect="0,3163,18437,18437"/>
  </v:shapetype><v:shape id="_x0000_s3076" type="#_x0000_t135" style='position:absolute;
   margin-left:75pt;margin-top:33.75pt;width:0;height:0;rotation:270;z-index:3'
   fillcolor="window [65]" strokecolor="windowText [64]" o:insetmode="auto"/><v:shape
   id="_x0000_s3093" type="#_x0000_t75" style='position:absolute;margin-left:3pt;
   margin-top:38.25pt;width:69pt;height:29.25pt;z-index:4'>
   <v:imagedata src="fpgm00101_files/image003.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:4px;margin-top:44px;width:97px;
  height:46px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=92></td>
    <td width=3></td>
    <td width=2></td>
   </tr>
   <tr>
    <td height=2></td>
    <td colspan=2></td>
    <td align=left valign=top></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
   <tr>
    <td height=39></td>
    <td align=left valign=top></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=45 class=xl26 width=100 style='height:33.75pt;border-left:none;
    width:75pt'>Image</td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 width=90 style='border-top:none;border-left:none;width:68pt'>Comp
  <br>
    ID-Name</td>
  <td class=xl26 width=45 style='border-top:none;border-left:none;width:34pt'>In
  Qty</td>
  <td class=xl26 width=45 style='border-top:none;border-left:none;width:34pt'>Req
  Qty</td>
  <td class=xl27 width=45 style='border-top:none;border-left:none;width:34pt'>BF<br>
    Qty</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>8:30</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>9:30</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>10:30</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>11:30</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>13:30</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>14:30</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>15:30</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>16:30</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>18:30</td>
  <td class=xl29 width=45 style='border-top:none;border-left:none;width:34pt'
  x:num>19:30</td>
  <td class=xl27 width=45 style='border-top:none;border-left:none;width:34pt'>Bal</td>
  <td class=xl31 width=45 style='border-top:none;width:34pt'>Bal (%)</td>
 </tr>
  <%
	para = "'" + p_ordplan_pk + "','" + p_style + "','" + p_wp_type + "','" + p_spec01_pk +"','" + p_spec02_pk + "','" + p_spec03_pk + "','" + p_spec04_pk +"','" + p_spec05_pk + "','" + p_date + "','" + p_lang + "'" ;

	DataTable dt2;
    dt2 = ESysLib.TableReadOpenCursor("prod.sp_rpt_fpgm00101_1", para);  
	int a = 0; 
	for( int i = 0; i < dt2.Rows.Count; i++)
	{
 %>
 <tr class=xl28 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td rowspan=2 height=50 class=xl37 style='border-bottom:2.0pt double navy;
  height:37.5pt;border-top:none' x:num><%= i+1 %></td>
  <td rowspan=2 class=xl67 width=60 style='border-bottom:2.0pt double navy;
  border-top:none;width:45pt'><%= dt2.Rows[i]["group_id"] %></td>
  <td rowspan=2 class=xl39 style='border-bottom:2.0pt double navy;border-top:
  none'><img width=84 height=60 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt2.Rows[i]["tes_lgpicture_pk"]%>&table_name=ESYS.TES_LGPICTURE" v:shapes="_x0000_s3073"></td>
  <td rowspan=2 class=xl41 width=90 style='border-bottom:2.0pt double navy;
  border-top:none;width:68pt'><%= dt2.Rows[i]["comp_name"] %></td>
  <td rowspan=2 class=xl56 style='border-bottom:2.0pt double navy;border-top:
  none' x:num><%= dt2.Rows[i]["input_qty"] %></td>
  <td rowspan=2 class=xl65 style='border-bottom:2.0pt double navy;border-top:
  none' x:num><%= dt2.Rows[i]["req_qty"] %></td>
  <td rowspan=2 class=xl58 style='border-bottom:2.0pt double navy;border-top:
  none' x:num><%= dt2.Rows[i]["before_qty"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_01"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_02"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_03"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_04"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_05"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_06"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_07"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_08"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_09"] %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%= dt2.Rows[i]["prod_qty_10"] %></td>
  <td rowspan=2 class=xl58 style='border-bottom:2.0pt double navy;border-top:
  none' x:num x:fmla="=F<%= a + 5 %>-Q<%= a + 6 %>"></td>
  <td rowspan=2 class=xl60 style='border-bottom:2.0pt double navy;border-top:
  none' x:num x:fmla="=R<%= 5 + a %>/F<%= 5 + a %>"></td>
 </tr>
 <tr class=xl28 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl33 style='height:18.75pt;border-top:none;border-left:
  none' x:num x:fmla="=H<%= 5 + a %>+G<%= a + 5 %>"></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num x:fmla="=I<%= 5 + a %>+H<%= a + 6 %>"></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num x:fmla="=J<%= 5 + a %>+I<%= a + 6 %>"></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num x:fmla="=K<%= 5 + a %>+J<%= a + 6 %>"></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num x:fmla="=L<%= 5 + a %>+K<%= a + 6 %>"></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num x:fmla="=M<%= 5 + a %>+L<%= a + 6 %>"></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num x:fmla="=N<%= 5 + a %>+M<%= a + 6 %>"></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num x:fmla="=O<%= 5 + a %>+N<%= a + 6 %>"></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num x:fmla="=P<%= 5 + a %>+O<%= a + 6 %>"></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num x:fmla="=Q<%= 5 + a %>+P<%= a + 6 %>"></td>
 </tr>
  <% a += 2; } %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=19 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=19 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=19 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=19 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=19 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=19 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=19 class=xl24 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=25 style='width:19pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
