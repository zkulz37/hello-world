﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string strSQL = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk 
                      FROM comm.tco_company 
                      WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM comm.tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    string master_pk = Request.QueryString["master_pk"];

    DataTable dt, dt1;
    dt = ESysLib.TableReadOpen(strSQL);
    dt1 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpip00110", "'" + master_pk + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsbs00020_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsbs00020_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsbs00020_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>SERVER_LG</o:LastAuthor>
  <o:LastPrinted>2011-07-15T01:48:08Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-07-15T01:49:09Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&C&\0022Arial\,Bold\0022\000AGiao hng \0111�ng h\1EB9n - Ch\1EA5t l\01B0\1EE3ng t\1ED1t nh\1EA5t&\0022Arial\,Regular\0022 &\0022Arial\,Italic\0022Ontime Delivery - Best Quality&RPage &P of &N";
	margin:.07in .24in .25in .28in;
	mso-header-margin:0in;
	mso-footer-margin:.07in;
	mso-page-orientation:landscape;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font13
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
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
.font17
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font23
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font25
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font26
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font28
	{color:windowtext;
	font-size:12.0pt;
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
.xl25
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style21;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style21;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style21;
	color:green;
	font-size:34.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl33
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl42
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl44
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
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style21;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style21;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl52
	{mso-style-parent:style21;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl53
	{mso-style-parent:style21;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl55
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl61
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"d\\-mmm";}
.xl62
	{mso-style-parent:style21;
	color:green;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style21;
	color:green;
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
.xl64
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl65
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
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
.xl78
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
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
.xl80
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl82
	{mso-style-parent:style21;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl84
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9150</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$11:$11</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1264 style='border-collapse:
 collapse;table-layout:fixed;width:950pt'>
 <col class=xl25 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl25 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl25 width=151 style='mso-width-source:userset;mso-width-alt:5522;
 width:113pt'>
 <col class=xl25 width=194 style='mso-width-source:userset;mso-width-alt:7094;
 width:146pt'>
 <col class=xl25 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl25 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl25 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl25 width=130 style='mso-width-source:userset;mso-width-alt:4754;
 width:98pt'>
 <col class=xl25 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl25 width=64 span=3 style='width:48pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 rowspan=3 height=72 class=xl62 width=150 style='border-bottom:
  2.0pt double black;height:54.0pt;width:113pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:20.5pt;margin-top:5.5pt;width:78pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <%
      if (dt1.Rows.Count > 1)
      {
          %>
            <td class=xl26 colspan=2 width=345 style='mso-ignore:colspan;width:259pt'><%= dt.Rows[0]["partner_name"]%></td>
          <% 
      }
      else
      {
          %>
          <td class=xl26 colspan=2 width=345 style='mso-ignore:colspan;width:259pt'></td>
          <%     
      }
  %>
  
  <td class=xl27 width=86 style='width:65pt'></td>
  <td class=xl27 width=53 style='width:40pt'></td>
  <td class=xl25 width=71 style='width:53pt'></td>
  <td class=xl25 width=130 style='width:98pt'></td>
  <%
      if (dt1.Rows.Count > 1)
      {
          %>
           <td class=xl26 colspan=2 width=237 style='mso-ignore:colspan;width:178pt'>Tel: <%= dt.Rows[0]["phone_no"] %></td>
          <% 
      }
      else
      {
          %>
          <td class=xl26 colspan=2 width=237 style='mso-ignore:colspan;width:178pt'>Tel: </td>
          <%     
      }
  %>
  
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <%
      if (dt1.Rows.Count > 1)
      {
          %>
            <td height=24 class=xl26 colspan=2 style='height:18.0pt;mso-ignore:colspan'><%= dt.Rows[0]["addr1"] %></td>
          <% 
      }
      else
      {
          %>
          <td height=24 class=xl26 colspan=2 style='height:18.0pt;mso-ignore:colspan'></td>
          <%     
      }
  %>
  
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <%
      if (dt1.Rows.Count > 1)
      {
          %>
            <td class=xl26 colspan=2 style='mso-ignore:colspan'>Fax: <%= dt.Rows[0]["fax_no"] %></td>
          <% 
      }
      else
      {
          %>
          <td class=xl26 colspan=2 style='mso-ignore:colspan'>Fax: </td>
          <%     
      }
  %>
  
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 style='height:18.0pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl32 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl33 colspan=2 style='mso-ignore:colspan'>Print date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=58 style='mso-height-source:userset;height:43.5pt'>
  <td colspan=4 height=58 class=xl80 width=495 style='height:43.5pt;width:372pt'>CH&#7880;
  TH&#7882; S&#7842;N XU&#7844;T<br>
    <font class="font28">( WORK INSTRUCTION )</font></td>
  <td class=xl34></td>
  <td colspan=2 class=xl81 width=124 style='border-right:.5pt solid black;
  width:93pt'>Ng&#432;&#7901;i yêu c&#7847;u<font class="font5"><br>
    </font><font class="font25">Request by<span
  style='mso-spacerun:yes'></span></font></td>
  <td class=xl82 width=130 style='width:98pt'>T&#7893; tr&#432;&#7903;ng<font
  class="font13"><br>
    </font><font class="font26">Chief</font></td>
  <td class=xl82 width=113 style='width:85pt'>Qu&#7843;n lý<font class="font13"><br>
    </font><font class="font26">Manager</font></td>
  <td class=xl82 width=124 style='width:93pt'>Giám &#273;&#7889;c<font
  class="font13"><br>
    </font><font class="font26">Director</font></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <%
      if (dt1.Rows.Count > 1)
      {
          %>
            <td colspan=4 height=20 class=xl66 style='height:15.0pt'>WI No :<%=dt1.Rows[0]["slip_no"]%> </td>
          <% 
      }
      else
      {
          %>
          <td colspan=4 height=20 class=xl66 style='height:15.0pt'>WI No : </td>
          <%     
      }
  %>
  
  <td class=xl35></td>
  <td colspan=2 rowspan=4 class=xl67 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td rowspan=4 class=xl74 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=4 class=xl74 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=4 class=xl74 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td colspan=3 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl76 style='height:15.0pt'></td>
  <td class=xl37></td>
  <td colspan=3 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <%
      if (dt1.Rows.Count > 1)
      {
          %>
            <td height=25 class=xl38 colspan=4 style='height:18.75pt;mso-ignore:colspan'>WI
  Date<font class="font17"> : <%=dt1.Rows[0]["ins_dt"]%></font></td>
          <% 
      }
      else
      {
          %>
          <td height=25 class=xl38 colspan=4 style='height:18.75pt;mso-ignore:colspan'>WI
  Date<font class="font17"> : </font></td>
          <%     
      }
  %>
  
  <td class=xl39></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl40 style='height:18.75pt'>To:</td>
  <%
      if (dt1.Rows.Count > 1)
      {
          %>
            <td class=xl41><%=dt1.Rows[0]["line_name"]%></td>
          <% 
      }
      else
      {
          %>
          <td class=xl41></td>
          <%     
      }
  %>
  
  <td class=xl42></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl44 style='height:18.75pt'>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl45 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl84 width=49 style='height:23.25pt;border-top:none;
  width:37pt'>STT<br>
    <font class="font23">No</font></td>
  <td class=xl84 width=101 style='border-top:none;border-left:none;width:76pt'>Ngày
  ch&#7881; th&#7883; SX<br>
    <font class="font23">WI Date</font></td>
  <td class=xl84 width=151 style='border-top:none;border-left:none;width:113pt'>Khách
  hàng<br>
    <font class="font23">Customer</font></td>
  <td class=xl84 width=194 style='border-top:none;border-left:none;width:146pt'>Tên
  hàng<br>
    <font class="font23">Item Description</font></td>
  <td class=xl84 width=86 style='border-top:none;border-left:none;width:65pt'>Màu<br>
    <font class="font23">Color</font></td>
  <td class=xl84 width=53 style='border-top:none;border-left:none;width:40pt'>&#272;VT<br>
    <font class="font23">Unit</font></td>
  <td class=xl84 width=71 style='border-top:none;border-left:none;width:53pt'>S&#7889;
  l&#432;&#7907;ng<br>
    <font class="font23">Qty</font></td>
  <td class=xl84 width=130 style='border-top:none;border-left:none;width:98pt'>S&#7889;
  &#273;&#7889;i chi&#7871;u<br>
    <font class="font23">PO Ref No</font></td>
  <td class=xl84 width=113 style='border-top:none;border-left:none;width:85pt'>Ngày
  giao<br>
    <font class="font23">Delivery Date</font></td>
  <td class=xl84 width=124 style='border-left:none;width:93pt'>Ghi chú<br>
    <font class="font23">Remark</font></td>
  <td colspan=3 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
     double total = 0;
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         total = total + CommondLib.ConvertToDbl(dt1.Rows[i]["ins_qty"]);
         %>
         
<tr class=xl45 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl46 width=49 style='height:29.25pt;width:37pt' x:num><%=i+1%></td>
  <td class=xl47 width=101 style='width:76pt'><%=dt1.Rows[i]["start_dt"]%> - <%=dt1.Rows[i]["end_dt"]%></td>
  <td class=xl47 width=151 style='width:113pt'><%=dt1.Rows[i]["partner_name"]%></td>
  <td class=xl83 width=194 style='width:146pt'><%=dt1.Rows[i]["item_name"]%></td>
  <td class=xl48 width=86 style='width:65pt'><%=dt1.Rows[i]["color"]%></td>
  <td class=xl49 width=53 style='width:40pt'><%=dt1.Rows[i]["uom"]%></td>
  <td class=xl50 width=71 style='width:53pt' x:num><%=dt1.Rows[i]["ins_qty"]%></td>
  <td class=xl51 width=130 style='width:98pt'><%=dt1.Rows[i]["po_no"]%></td>
  <td class=xl52 width=113 style='width:85pt'><%=dt1.Rows[i]["item_etd"]%></td>
  <td class=xl53 width=124 style='width:93pt'><%=dt1.Rows[i]["ins_remark"]%></td>
  <td colspan=3 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
         
         <% 
     }
      %>
 
 
 <tr class=xl54 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=6 height=39 class=xl77 width=634 style='border-right:.5pt solid black;
  height:29.25pt;width:477pt'>Total</td>
  <td class=xl55 width=71 style='width:53pt' x:num><%=total%></td>
  <td class=xl56 width=130 style='width:98pt'>&nbsp;</td>
  <td class=xl56 width=113 style='width:85pt'>&nbsp;</td>
  <td class=xl56 width=124 style='width:93pt'>&nbsp;</td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl57 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl57></td>
  <td class=xl35></td>
  <td class=xl58></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl59 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl60></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl61 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=49 style='width:37pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=151 style='width:113pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</htm