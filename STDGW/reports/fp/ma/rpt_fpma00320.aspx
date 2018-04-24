<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    DataTable dt = ESysLib.TableReadOpenCursor("LG_RPT_FPMA00320", "'" + p_from_date + "','" + p_to_date + "'");
    if (dt.Rows.Count == 0)
    {
        Response.Write("No data");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpma00320_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpma00320_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpma00320_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ACCOUNTING.HUNG</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-07-31T08:20:38Z</o:LastPrinted>
  <o:Created>2011-08-27T03:57:51Z</o:Created>
  <o:LastSaved>2012-07-31T08:23:35Z</o:LastSaved>
  <o:Company>ChangShin VN</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
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
.style58
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:.5pt solid #339966;
	border-left:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl68
	{mso-style-parent:style58;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:.5pt solid #339966;
	border-left:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:.5pt solid #339966;
	border-left:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:.5pt solid #339966;
	border-left:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:.5pt solid #339966;
	border-left:.5pt solid #339966;
	background:#3366FF;
	mso-pattern:auto none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style58;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style43;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:1.5pt solid windowtext;
	background:#FFFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style43;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:.5pt solid #339966;
	border-left:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:1.5pt solid windowtext;
	background:#FFFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:1.5pt solid windowtext;
	background:#FFFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	mso-number-format:"yyyy\\-mm\\-dd";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:.5pt solid #339966;
	border-left:.5pt solid #339966;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Malgun Gothic", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid #339966;
	border-bottom:.5pt solid #339966;
	border-left:.5pt solid #339966;
	background:white;
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
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6135</x:WindowHeight>
  <x:WindowWidth>15120</x:WindowWidth>
  <x:WindowTopX>180</x:WindowTopX>
  <x:WindowTopY>600</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>CODE</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=19104 style='border-collapse:
 collapse;table-layout:fixed;width:14328pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:3744;width:88pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:768;width:18pt'>
 <col width=64 style='mso-width-source:userset;mso-width-alt:2048;width:48pt'>
 <col width=144 style='mso-width-source:userset;mso-width-alt:4608;width:108pt'>
 <col width=319 style='mso-width-source:userset;mso-width-alt:10208;width:239pt'>
 <col width=82 span=2 style='mso-width-source:userset;mso-width-alt:2624;
 width:62pt'>
 <col width=149 style='mso-width-source:userset;mso-width-alt:4768;width:112pt'>
 <col width=99 span=3 style='mso-width-source:userset;mso-width-alt:3168;
 width:74pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3168;width:74pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2592;width:61pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:2912;width:68pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3168;width:74pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:2912;width:68pt'>
 <col width=130 style='mso-width-source:userset;mso-width-alt:4160;width:98pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3168;width:74pt'>
 <col width=72 span=238 style='width:54pt'>
 <tr height=51 style='mso-height-source:userset;height:38.25pt'>
  <td height=51 class=xl80 width=117 style='height:38.25pt;width:88pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl81 width=24 style='border-left:none;width:18pt'>&nbsp;</td>
  <td class=xl81 width=64 style='border-left:none;width:48pt'>MT Code</td>
  <td class=xl81 width=144 style='border-left:none;width:108pt'>Asset No</td>
  <td class=xl81 width=319 style='border-left:none;width:239pt'>Asset's Name
  English</td>
  <td class=xl81 width=82 style='border-left:none;width:62pt'>Declaration No</td>
  <td class=xl81 width=82 style='border-left:none;width:62pt'>Declaration Date</td>
  <td class=xl81 width=149 style='border-left:none;width:112pt'>Department</td>
  <td class=xl81 width=99 style='border-left:none;width:74pt'>Content Year</td>
  <td class=xl81 width=99 style='border-left:none;width:74pt'>Amorization Rate</td>
  <td class=xl81 width=99 style='border-left:none;width:74pt'>Status</td>
  <td class=xl78 width=99 style='border-left:none;width:74pt'>Acq Date</td>
  <td class=xl78 width=81 style='border-left:none;width:61pt'>Completion Date</td>
  <td class=xl81 width=91 style='border-left:none;width:68pt'
  x:str="Original Cost ">Original Cost<span style='mso-spacerun:yes'> </span></td>
  <td class=xl81 width=99 style='border-left:none;width:74pt'>Accumulated
  Amount [Depreciation]</td>
  <td class=xl81 width=91 style='border-left:none;width:68pt'>Depreciation Of
  This Term</td>
  <td class=xl81 width=130 style='border-left:none;width:98pt'>Depreciation Of
  End Of Term[Accumlated]</td>
  <td class=xl81 width=99 style='border-left:none;width:74pt'>Net Book Values</td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl66 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
  <td class=xl65 width=72 style='width:54pt'></td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
      %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl67 width=117 style='height:18.75pt;width:88pt'><%= dt.Rows[i]["group_"]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl67 width=24 style='border-left:none;width:18pt' x:num><%= dt.Rows[i]["seq"] %></td>
  <td class=xl67 width=64 style='border-left:none;width:48pt'><%= dt.Rows[i]["mt_code"]%></td>
  <td class=xl68 width=144 style='border-left:none;width:108pt'><%= dt.Rows[i]["asset_no"] %></td>
  <td class=xl67 width=319 style='border-left:none;width:239pt'><%= dt.Rows[i]["asset_fname"] %></td>
  <td class=xl69 width=82 style='border-left:none;width:62pt'><%= dt.Rows[i]["declaration_no"] %></td>
  <td class=xl69 width=82 style='border-left:none;width:62pt'><%= dt.Rows[i]["declaration_dt"] %></td>
  <td class=xl67 width=149 style='border-left:none;width:112pt'><%= dt.Rows[i]["department"] %></td>
  <td class=xl67 width=99 style='border-left:none;width:74pt' x:num><%= dt.Rows[i]["content_year"] %></td>
  <td class=xl68 width=99 style='border-left:none;width:74pt' x:num><%= dt.Rows[i]["amorization_rate"] %></td>
  <td class=xl83 width=99 style='border-left:none;width:74pt'><%= dt.Rows[i]["status"] %></td>
  <td class=xl82 align=right width=99 style='border-left:none;width:74pt' x:num><%= dt.Rows[i]["acq_date"] %></td>
  <td class=xl82 align=right width=81 style='border-left:none;width:61pt' x:num><%= dt.Rows[i]["completion_date"] %></td>
  <td class=xl79 width=91 style='border-left:none;width:68pt' x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[i]["original_cost"] %></td>
  <td class=xl70 width=99 style='border-left:none;width:74pt' x:num><%= dt.Rows[i]["accumulated_amount"] %></td>
  <td class=xl79 width=91 style='border-left:none;width:68pt' x:num><span style='mso-spacerun:yes'></span><%= dt.Rows[i]["depreciation_of_this_term"] %></td>
  <td class=xl70 width=130 style='border-left:none;width:98pt' x:num><%= dt.Rows[i]["depreciation_of_end_term"] %></td>
  <td class=xl71 width=99 style='border-left:none;width:74pt' x:num><%= dt.Rows[i]["net_book_values"] %></td>
  <td colspan=2 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
  <td colspan=229 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=117 style='width:88pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=144 style='width:108pt'></td>
  <td width=319 style='width:239pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=149 style='width:112pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
