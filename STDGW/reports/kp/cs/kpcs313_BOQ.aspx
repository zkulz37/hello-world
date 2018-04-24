<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("ec111");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
        string p_Pk = Request["Pk"];
        string p_Project = Request["Project"];
        string p_Nature_Work = Request["Nature_Work"];
        string p_TECPS_PROJECTSUMM_PK = Request["TECPS_PROJECTSUMM_PK"];
        string p_TECPS_SUBSTRP12000_PK = Request["TECPS_SUBSTRP12000_PK"];
    string p_Unit = Request["Unit"];
        string l_parameter = "'" + p_TECPS_PROJECTSUMM_PK + "',";
        l_parameter += "'" + p_TECPS_SUBSTRP12000_PK + "',";
        l_parameter += "'" + p_Pk + "'";
        //Response.Write(l_parameter);
        //Response.End();
        DataTable dt = ESysLib.TableReadOpenCursor("EC111.sp_sel_kpcs313_BOQ", l_parameter);
        if (dt.Rows.Count == 0)
        {
            Response.Write("There is no data to show");
            Response.End();
        }
        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpcs313_files/filelist.xml">
<link rel=Edit-Time-Data href="kpcs313_files/editdata.mso">
<link rel=OLE-Object-Data href="kpcs313_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>kenzie</o:LastAuthor>
  <o:LastPrinted>2011-06-27T03:59:55Z</o:LastPrinted>
  <o:Created>2011-05-17T06:10:14Z</o:Created>
  <o:LastSaved>2011-06-27T04:00:08Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.34in .17in .2in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style17
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
	{mso-style-parent:style17;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";}
.xl25
	{mso-style-parent:style17;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;}
.xl26
	{mso-style-parent:style17;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style17;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style17;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style17;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;}
.xl38
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
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
.xl46
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style17;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style17;
	font-size:28.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;}
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
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>65</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1572 style='border-collapse:
 collapse;table-layout:fixed;width:1183pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=223 style='mso-width-source:userset;mso-width-alt:8155;width:167pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=110 span=6 style='mso-width-source:userset;mso-width-alt:4022; width:83pt'>
 <col width=106 span=2 style='mso-width-source:userset;mso-width-alt:3876; width:80pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=110 span=2 style='mso-width-source:userset;mso-width-alt:4022; width:83pt'>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=15 height=43 class=xl50 width=1572 style='height:32.25pt;  width:1183pt'> BILL OF QUANTITY</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 colspan=3 style='height:15.75pt;mso-ignore:colspan' >Project: <%=p_Project%></td>
  <td colspan=2 class=xl37></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl37></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 colspan=3 style='height:15.75pt;mso-ignore:colspan' >Nature of work: <%=p_Nature_Work%></td>
  <td colspan=2 class=xl26>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>Unit: <%=p_Unit %></td>
  <td class=xl28>&nbsp;</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td rowspan=2 height=47 class=xl38 style='border-bottom:.5pt solid black;  height:35.85pt' x:str="No.">No.</td>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black' x:str="Code">Code</td>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black'  x:str="Description">Description</td>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black;border-top:  none' x:str="Unit">Unit</td>
  <td colspan=3 class=xl41 style='border-right:.5pt solid black;border-left:  none' x:str="Budget">Budget</td>
  <td colspan=3 class=xl41 style='border-right:.5pt solid black;border-left:  none' x:str="Before Modified (A)">Before Modified (A)</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:  none' x:str="After Modified (B)">After  Modified (B)</td>
  <td colspan=2 class=xl44 width=212 style='border-right:.5pt solid black;  border-left:none;width:160pt' x:str="Balance (B-A)">Balance (B-A)</td>
  <td rowspan=2 class=xl46 width=75 style='border-bottom:.5pt solid black;  border-top:.5pt solid black;width:56pt' x:str="VAT Rate">VAT Rate</td>
  <td rowspan=2 class=xl46 width=110 style='border-bottom:.5pt solid black;  border-top:.5pt solid black;width:83pt' x:str="Vat Amount">Vat Amount</td>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black;border-top:  .5pt solid black' x:str="Total">Total</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
 <td height=29 class=xl29 style='height:21.75pt' x:str="Qty">Qty</td>
  <td class=xl29 x:str="Unit Price"><span style='mso-spacerun:yes'> </span>Unit Price</td>
  <td class=xl29 x:str="Amount">Amount</td>
  <td height=29 class=xl29 style='height:21.75pt' x:str="Qty">Qty</td>
  <td class=xl29 x:str="Unit Price"><span style='mso-spacerun:yes'> </span>Unit Price</td>
  <td class=xl29 x:str="Amount">Amount</td>
  <td class=xl29 x:str="Qty">Qty</td>
  <td class=xl29 x:str="Unit Price">Unit Price</td>
  <td class=xl29 x:str="Amount">Amount</td>
  <td class=xl30 width=106 style='width:80pt' x:str="Qty">Qty</td>
  <td class=xl30 width=106 style='width:80pt' x:str="Amount">Amount</td>
 </tr>
 <%
     decimal _B_Amt = 0, _A_Amt = 0, _Balance_Amt = 0, _VAT_Amt = 0, _Total = 0, VAT_AMT = 0, TOTAL = 0, _Budget_Amt=0;
     int i = 0;
     int k = 0;
     
         for (i = 0; i < dt.Rows.Count; i++)
         {
             if (dt.Rows[i][8].ToString().Trim() != "")
             {
                 _B_Amt += decimal.Parse(dt.Rows[i][8].ToString());
             }
             else
             {
                 _B_Amt += 0;
             }

             if (dt.Rows[i][11].ToString().Trim() != "" && dt.Rows[i][14].ToString().Trim() != "")
             {
                 _A_Amt += decimal.Parse(dt.Rows[i][11].ToString());
                 VAT_AMT = decimal.Parse(dt.Rows[i][11].ToString()) * decimal.Parse(dt.Rows[i][14].ToString()) / 100;
                 TOTAL = decimal.Parse(dt.Rows[i][11].ToString()) + VAT_AMT;
             }
             else
             {
                 _A_Amt += 0;
                 VAT_AMT = 0;
                 TOTAL = 0;
                 
             }

             if (dt.Rows[i][13].ToString().Trim() != "")
             {
                 _Balance_Amt += decimal.Parse(dt.Rows[i][13].ToString());
             }
             else
             {
                 _Balance_Amt += 0;
             }

             if (dt.Rows[i][5].ToString().Trim() != "")
             {
                 _Budget_Amt += decimal.Parse(dt.Rows[i][5].ToString());
             }
             else
             {
                 _Budget_Amt += 0;
             }

             _VAT_Amt += VAT_AMT;
             _Total += TOTAL; 
      %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'><%=k + 1%></td>
  <td class=xl32 ><%=dt.Rows[i][0]%></td>
  <td class=xl32 ><%=dt.Rows[i][1]%></td>
  <td class=xl33 ><%=dt.Rows[i][2]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][3]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][4]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][5]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][6]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][7]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][8]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][9]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][10]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][11]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][12]%></td>
  <td class=xl34 x:num><%=dt.Rows[i][13]%></td>
  <td class=xl34 style="text-align:right"><%=dt.Rows[i][14]%></td>
  <td class=xl34 x:num><%=VAT_AMT%></td>
  <td class=xl34 x:num><%=TOTAL%></td>
 </tr>
 <%k += 1;
         }
     %>

 <tr class=xl35 height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl48 style='height:12.75pt' x:str="GRAND TOTAL">GRAND TOTAL</td>
  <td class=xl36 style="border-left:.5pt solid windowtext">&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 align=right x:num><%=_Budget_Amt %></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 align=right x:num><%=_B_Amt%></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 align=right x:num><%=_A_Amt%></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 align=right x:num><%=_Balance_Amt%></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36 align=right x:num><%=_VAT_Amt%></td>
  <td class=xl36 align=right x:num><%=_Total%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=223 style='width:167pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
