<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_schedule_detail_sample_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_schedule_detail_sample_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_schedule_detail_sample_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:Created>2011-02-10T04:34:14Z</o:Created>
  <o:LastSaved>2011-02-19T09:57:06Z</o:LastSaved>
  <o:Company>Customer</o:Company>
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
.xl65
	{mso-style-parent:style0;
	text-align:left;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>87</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
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
  <x:WindowHeight>12240</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$2:$AC$10</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=885 style='border-collapse:
 collapse;table-layout:fixed;width:671pt'>
 <col class=xl65 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col width=29 span=31 style='mso-width-source:userset;mso-width-alt:1560;
 width:22pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 width=73 style='height:12.75pt;width:55pt'>Mã số</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>1</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>2</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>3</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>4</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>5</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>6</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>7</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>8</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>9</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>10</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>11</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>12</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>13</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>14</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>15</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>16</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>17</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>18</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>19</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>20</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>21</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>22</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>23</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>24</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>25</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>26</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>27</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>28</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>29</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>30</td>
  <td class=xl66 width=29 style='border-left:none;width:22pt' x:num>31</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl68 style='height:15.0pt;border-top:none' x:num>200103</td>
  <td class=xl67 style='border-top:none;border-left:none' >DD</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >ND</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >ND</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >DD</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >ND</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none' >&nbsp;</td>
 </tr>
 
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=73 style='width:55pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=29 style='width:22pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
