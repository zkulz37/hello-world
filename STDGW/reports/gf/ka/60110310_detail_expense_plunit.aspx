<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
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
<link rel=File-List href="60110310_detail_expense_plunit_files/filelist.xml">
<link rel=Edit-Time-Data
href="60110310_detail_expense_plunit_files/editdata.mso">
<link rel=OLE-Object-Data
href="60110310_detail_expense_plunit_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>Phan Thi Thanh Tuyen</o:LastAuthor>
  <o:LastPrinted>2010-05-19T03:38:51Z</o:LastPrinted>
  <o:Created>2010-05-19T03:31:22Z</o:Created>
  <o:LastSaved>2010-05-19T03:39:29Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>56</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>1</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>285</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1735 style='border-collapse:
 collapse;table-layout:fixed;width:1298pt'>
 <col width=20 style='mso-width-source:userset;mso-width-alt:731;width:15pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=215 style='mso-width-source:userset;mso-width-alt:7862;width:161pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=215 style='mso-width-source:userset;mso-width-alt:7862;width:161pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=215 span=3 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=20 style='height:12.75pt;width:15pt'></td>
  <td class=xl24 colspan=4 width=288 style='mso-ignore:colspan;width:215pt'>&nbsp;CÔNG
  TY C&#416; KHÍ VÀ XÂY D&#7920;NG POSLILAMA</td>
  <td width=215 style='width:161pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'>&nbsp;KHU CÔNG
  NGHI&#7878;P NH&#416;N TR&#7840;CH</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
  <td colspan=13 class=xl25>B&#7842;NG CHI TI&#7870;T CHI PHÍ/ DETAIL EXPENSE
  PL UNIT</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 style='height:15.75pt'></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'>T&#7915; 01/2008
  &#273;&#7871;n 09/2008</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl26>PL Unit</td>
  <td class=xl26>CODe</td>
  <td class=xl26>NAME</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 style='height:15.75pt'></td>
  <td class=xl27>Seq</td>
  <td class=xl27 style='border-left:none'>Voucher No</td>
  <td class=xl27 style='border-left:none'>Trans Date</td>
  <td class=xl27 style='border-left:none'>Acc. Code</td>
  <td class=xl27 style='border-left:none'>Acc. Name</td>
  <td class=xl27 style='border-left:none'>Trans Amount</td>
  <td class=xl27 style='border-left:none'>Books Amount</td>
  <td class=xl27 style='border-left:none'>Cust ID</td>
  <td class=xl27 style='border-left:none'>Cust Name</td>
  <td class=xl27 style='border-left:none'>PL Code</td>
  <td class=xl27 style='border-left:none'>PL Name</td>
  <td class=xl27 style='border-left:none'>Remark</td>
  <td class=xl27 style='border-left:none'>Remark</td>
 </tr>
 <tr height=63 style='height:47.25pt'>
  <td height=63 style='height:47.25pt'></td>
  <td class=xl28 style='border-top:none' x:num>627111</td>
  <td class=xl29 style='border-top:none;border-left:none'>PT-00001</td>
  <td class=xl30 style='border-top:none;border-left:none'>16/11/2007</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>111100</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl32 style='border-top:none;border-left:none' x:num="508967500"><span
  style='mso-spacerun:yes'> </span>508,967,500 </td>
  <td class=xl32 style='border-top:none;border-left:none' x:num="521371800"><span
  style='mso-spacerun:yes'> </span>521,371,800 </td>
  <td class=xl29 style='border-top:none;border-left:none'>PT-00001</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl29 style='border-top:none;border-left:none'>PT-00001</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
 </tr>
 <tr height=63 style='height:47.25pt'>
  <td height=63 style='height:47.25pt'></td>
  <td class=xl28 style='border-top:none' x:num>627111</td>
  <td class=xl29 style='border-top:none;border-left:none'>PT-00001</td>
  <td class=xl30 style='border-top:none;border-left:none'>16/11/2007</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>111100</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl32 style='border-top:none;border-left:none' x:num="508967500"><span
  style='mso-spacerun:yes'> </span>508,967,500 </td>
  <td class=xl32 style='border-top:none;border-left:none' x:num="521371800"><span
  style='mso-spacerun:yes'> </span>521,371,800 </td>
  <td class=xl29 style='border-top:none;border-left:none'>PT-00001</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl29 style='border-top:none;border-left:none'>PT-00001</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
 </tr>
 <tr height=63 style='height:47.25pt'>
  <td height=63 style='height:47.25pt'></td>
  <td class=xl28 style='border-top:none' x:num>627111</td>
  <td class=xl29 style='border-top:none;border-left:none'>PT-00001</td>
  <td class=xl30 style='border-top:none;border-left:none'>16/11/2007</td>
  <td class=xl29 style='border-top:none;border-left:none' x:num>111100</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl32 style='border-top:none;border-left:none' x:num="508967500"><span
  style='mso-spacerun:yes'> </span>508,967,500 </td>
  <td class=xl32 style='border-top:none;border-left:none' x:num="521371800"><span
  style='mso-spacerun:yes'> </span>521,371,800 </td>
  <td class=xl29 style='border-top:none;border-left:none'>PT-00001</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl29 style='border-top:none;border-left:none'>PT-00001</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
  <td class=xl31 width=215 style='border-top:none;border-left:none;width:161pt'>N&#7897;p
  ti&#7873;n ký qu&#7929; m&#7903; TK ACBggggggggggggggggggggggggggggggggg</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=20 style='width:15pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=215 style='width:161pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
