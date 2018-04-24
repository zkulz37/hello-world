<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string _date         = Request.QueryString["p_date"];
	string _factory_pk   = Request.QueryString["p_factory_pk"];	
	string _factory_name = Request.QueryString["p_factory_name"];	
	
    string _prod_dt= "", SQL="", _process="";
    int _row = 5, _start_group = 6;

    SQL = "Select to_char(to_date('" + _date + "','yyyymmdd'),'Mon.dd.yyyy') prod_dt from dual";

    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        _prod_dt = dt.Rows[0]["prod_dt"].ToString();
    }

	string _para = " '" + _date + "','" + _factory_pk + "' ";    
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00094", _para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpgm00034_3_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpgm00034_3_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpgm00034_3_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>Ngale</o:LastAuthor>
  <o:LastPrinted>2010-03-08T02:34:41Z</o:LastPrinted>
  <o:Created>2008-11-04T04:34:59Z</o:Created>
  <o:LastSaved>2010-03-08T03:54:12Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.44in .28in .43in .45in;
	mso-header-margin:.3in;
	mso-footer-margin:.31in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style19
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma_Sheet1;}
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
.style30
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
.xl39
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style19;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl44
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl45
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl46
	{mso-style-parent:style30;
	font-size:11.0pt;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;}
.xl47
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style19;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style19;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style19;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl64
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style30;
	color:blue;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style30;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style19;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style30;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl71
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style30;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style30;
	color:#993366;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style30;
	color:#993366;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style30;
	color:#993366;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
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
      <x:Scale>71</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
      </x:Pane>
     </x:Panes>
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
  <x:WindowHeight>11640</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1465 style='border-collapse:
 collapse;table-layout:fixed;width:1098pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:4059;width:83pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=96 span=5 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=75 span=2 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col width=64 span=8 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl43 width=330 style='height:15.75pt;
  width:247pt'></td>
  <td class=xl43 width=96 style='width:72pt'></td>
  <td class=xl44 width=96 style='width:72pt'></td>
  <td class=xl45 width=96 style='width:72pt'></td>
  <td class=xl45 width=96 style='width:72pt'></td>
  <td class=xl45 width=89 style='width:67pt'></td>
  <td class=xl45 width=75 style='width:56pt'></td>
  <td class=xl45 width=75 style='width:56pt'></td>
  <td class=xl45 width=64 style='width:48pt'></td>
  <td class=xl45 width=64 style='width:48pt'></td>
  <td class=xl45 width=64 style='width:48pt'></td>
  <td class=xl45 width=64 style='width:48pt'></td>
  <td class=xl45 width=64 style='width:48pt'></td>
  <td class=xl45 width=64 style='width:48pt'></td>
  <td class=xl46 width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
 
  <td colspan=10 class=xl75 style='border-right:.5pt solid black'>DAILY PRODUCTION <%=_factory_name%></td>
  
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl45 style='height:21.75pt'></td>
  <td class=xl44></td>
  <td class=xl53>&nbsp;</td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl67>DATE : <%=_prod_dt %></td>
  <td colspan=8 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
  <td></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td rowspan=2 height=42 class=xl73 style='height:31.5pt'>LINE</td>
  <td rowspan=2 class=xl73>P/O</td>
  <td rowspan=2 class=xl73>STYLE</td>
  <td rowspan=2 class=xl73>Spec 1</td>
  <td rowspan=2 class=xl73>Spec 2</td>
  <td rowspan=2 class=xl73>Spec 3</td>
  <td rowspan=2 class=xl73>Spec 4</td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt hairline black;border-top:
  none'>Spec 5</td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt hairline black'>Prod. Qty</td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt hairline black'>Defect</td>
  <td colspan=7 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl45 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl46></td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {       
  %>
  <%
     if (_process != dt.Rows[i]["process_name"].ToString())
     {
         _process = dt.Rows[i]["process_name"].ToString();
   %>
  <%
     if (i != 0)
     {
         _row = _row + 1;
   %> 
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'>TOTAL</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl63 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(I<%=_start_group %>:I<%=(_row-1) %>)"></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(J<%=_start_group %>:J<%=(_row-1)%>)"></td>
  <td colspan=6 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
  <td></td>
 </tr>
 <%} %>
 <% 
     _row = _row + 1;
     _start_group = _row + 1;
 %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl70 style='height:15.75pt'
  x:str><%=_process%></td>
  <td class=xl57 style='border-top:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none'>&nbsp;</td>
  <td class=xl57 style='border-top:none'>&nbsp;</td>
  <td class=xl58 style='border-top:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none'>&nbsp;</td>
  <td class=xl61 style='border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none'>&nbsp;</td>
  <td colspan=6 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
  <td></td>
 </tr>
 <%} %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'><%=dt.Rows[i]["line_name"]%></td>
  <td class=xl47 style='border-top:none'><%=dt.Rows[i]["ref_po_no"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt.Rows[i]["item_code"]%></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec_id01"]%></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec_id02"]%></td>
  <td class=xl48 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec_id03"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec_id04"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec_id05"]%></td>
  <td class=xl68 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["prod_qty"]%></td>
  <td class=xl68 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["defect_qty"]%></td>
  <td colspan=7 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
 </tr>
 <%
     _row = _row + 1;

     } %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'>TOTAL</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl63 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(I<%=_start_group %>:I<%=(_row) %>)"></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(J<%=_start_group %>:J<%=(_row)%>)"></td>
  <td colspan=6 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl64 style='height:12.75pt;'>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=111 style='width:83pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
