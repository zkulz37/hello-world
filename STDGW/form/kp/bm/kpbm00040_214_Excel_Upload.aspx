<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("ec111");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="1234321_files/filelist.xml">
<link rel=Edit-Time-Data href="1234321_files/editdata.mso">
<link rel=OLE-Object-Data href="1234321_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:Created>2011-03-11T07:37:45Z</o:Created>
  <o:LastSaved>2011-03-17T02:06:21Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
.xl24
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:Standard;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>27</x:ActiveCol>
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
  <x:WindowHeight>9000</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>0</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2820 style='border-collapse:
 collapse;table-layout:fixed;width:2119pt'>
 <col width=64 style='width:48pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=115 style='mso-width-source:userset;mso-width-alt:4205;width:86pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:4132;width:85pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <col width=118 style='mso-width-source:userset;mso-width-alt:4315;width:89pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=64 span=3 style='width:48pt'>
 <col width=128 style='mso-width-source:userset;mso-width-alt:4681;width:96pt'>
 <col width=126 style='mso-width-source:userset;mso-width-alt:4608;width:95pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=136 style='mso-width-source:userset;mso-width-alt:4973;width:102pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=162 style='mso-width-source:userset;mso-width-alt:5924;width:122pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=201 style='mso-width-source:userset;mso-width-alt:7350;width:151pt'>
 <col width=181 style='mso-width-source:userset;mso-width-alt:6619;width:136pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl24 width=64 style='height:23.25pt;width:48pt'>Seq. No.</td>
  <td class=xl25 width=78 style='width:59pt'>Level</td>
  <td class=xl25 width=92 style='width:69pt'>Level Cde</td>
  <td class=xl25 width=115 style='width:86pt'>Wkng Seq. No.</td>
  <td class=xl25 width=113 style='width:85pt'>Wkng Dtals No.</td>
  <td class=xl25 width=121 style='width:91pt'>Dtals Journal. No.</td>
  <td class=xl25 width=118 style='width:89pt'>Dtals Description</td>
  <td class=xl25 width=68 style='width:51pt'>Currency</td>
  <td class=xl25 width=108 style='width:81pt'>Name</td>
  <td class=xl25 width=64 style='width:48pt'>Std</td>
  <td class=xl25 width=64 style='width:48pt'>Unit</td>
  <td class=xl25 width=64 style='width:48pt'>Q'ty</td>
  <td class=xl25 width=128 style='width:96pt'>Raw Mtrl. Cost U/P</td>
  <td class=xl25 width=126 style='width:95pt'>Raw Mtrl. Cost Amt</td>
  <td class=xl25 width=100 style='width:75pt'>Labor Cost U/P</td>
  <td class=xl25 width=104 style='width:78pt'>Labor Cost Amt</td>
  <td class=xl25 width=65 style='width:49pt'>Exp. U/P</td>
  <td class=xl25 width=66 style='width:50pt'>Exp. Amt</td>
  <td class=xl25 width=64 style='width:48pt'>U/P</td>
  <td class=xl25 width=64 style='width:48pt'>Amt</td>
  <td class=xl25 width=136 style='width:102pt'>Order Work Div. Cde</td>
  <td class=xl25 width=75 style='width:56pt'>Exec. (Y/N)</td>
  <td class=xl25 width=162 style='width:122pt'>Dir. Mgt Outsrc. Descrip.</td>
  <td class=xl25 width=107 style='width:80pt'>Bdgt. Item Cde</td>
  <td class=xl25 width=70 style='width:53pt'>Std Cde</td>
  <td class=xl25 width=201 style='width:151pt'>Legal O/H Expns. Excl. Subj.</td>
  <td class=xl25 width=181 style='width:136pt'>Sfty Cost Non-Appl. Items</td>
  <td class=xl25 width=102 style='width:77pt'>Calc. Basis</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl29></td>
  <td class=xl27></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td></td>
  <td class=xl26></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=136 style='width:102pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=162 style='width:122pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=201 style='width:151pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=102 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
