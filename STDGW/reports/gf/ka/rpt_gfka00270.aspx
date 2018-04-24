﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    ESysLib.SetUser("acnt");
  string l_kind=Request["p_kind"];  
  string l_status=Request["p_status"];
  string l_tco_company_pk=Request["p_tco_company_pk"];
  string l_date_fr=Request["p_date_fr"];
  string l_date_to=Request["p_date_to"];
  string l_date_type=Request["p_date_type"];
  string l_Scale = Request["p_Scale"];
  string l_ccy = Request["p_ccy"];

  string p_xls_ccy_format = "";

  if (l_ccy == "VND")
  {
      p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
  }
  else
  {
      p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
  }
    
  string fr_dt, to_dt, l_cmp_name, l_cmp_add, l_cmp_taxcode, to_dt_e;
  fr_dt = "";
  to_dt = "";
  l_cmp_name = "";
  l_cmp_add = "";
  l_cmp_taxcode = "";
  to_dt_e = "";

  string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE "+
      ",to_char(to_date('" + l_date_fr + "','yyyymmdd'),'dd/mm/yyyy') fr_dt,to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd/mm/yyyy') to_dt"+
      ",to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd-Mon-yyyy') sign_dt"+
    " FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";
      
  DataTable dt_f = ESysLib.TableReadOpen(SQL1);
  if (dt_f.Rows.Count > 0)
  {
      l_cmp_name = dt_f.Rows[0][0].ToString();
      l_cmp_add = dt_f.Rows[0][1].ToString();
      l_cmp_taxcode = dt_f.Rows[0][3].ToString();
      fr_dt = dt_f.Rows[0][4].ToString();
      to_dt = dt_f.Rows[0][5].ToString();
      to_dt_e = dt_f.Rows[0][6].ToString();
  }



  
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptProjectIncome_accumulate_files/filelist.xml">
<link rel=Edit-Time-Data href="rptProjectIncome_accumulate_files/editdata.mso">
<link rel=OLE-Object-Data href="rptProjectIncome_accumulate_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>khoa</o:Author>
  <o:LastAuthor>AiLinh</o:LastAuthor>
  <o:Created>2006-08-10T03:28:12Z</o:Created>
  <o:LastSaved>2009-07-23T03:38:22Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.52in .23in .7in .3in;
	mso-header-margin:.32in;
	mso-footer-margin:.41in;
	mso-page-orientation:landscape;}
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-weight:1000;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	text-align:center;}
.xl37
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
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
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>10</x:SplitHorizontal>
     <x:TopRowBottomPane>10</x:TopRowBottomPane>
     <x:SplitVertical>2</x:SplitVertical>
     <x:LeftColumnRightPane>2</x:LeftColumnRightPane>
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
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
<meta http-equiv=Expires content="Mon,06 Jan 1990 00:00:01 GMT">
</head>

<style>
@media all 
{
	gw\:smallIcon  {  behavior: url(/genuSuite/lib/controls/gwIcon.htc) ;  }
	gw\:gwImage {  behavior: url(/genuSuite/lib/controls/gwImage.htc) ;  }	
}
</style>

<LINK href="/genuSuite/default.css" rel="stylesheet" />

<script>
var rooturl = "/genuSuite";
</script>

<SCRIPT LANGUAGE="JavaScript" SRC="/genuSuite/system/lib/vsflexgridconst.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="/genuSuite/system/lib/default.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="/genuSuite/system/lib/common.js"></script>

<SCRIPT LANGUAGE="JavaScript" SRC="/genuSuite/system/lib/template.js"></script>
<SCRIPT LANGUAGE="JavaScript" SRC="/genuSuite/lib/globalVar.js"></script>

<style>
@media all 
{
	gw\:textbox  {  behavior: url(/genuSuite/system/controls/textbox.htc) ;  }
	gw\:button  {  behavior: url(/genuSuite/system/controls/button.htc) ;  }
	gw\:icon {  behavior: url(/genuSuite/system/controls/icon.htc) ;  }
	gw\:label {  behavior: url(/genuSuite/system/controls/label.htc) ;  }
	gw\:htmledit {  behavior: url(/genuSuite/system/controls/htmledit.htc) ;  }
	gw\:treeview {  behavior: url(/genuSuite/system/controls/treeview.htc) ;  }	
	gw\:grid {  behavior: url(/genuSuite/system/controls/grid.htc) ;  }	
	gw\:gridhtml {  behavior: url(/genuSuite/system/controls/gridhtml.htc) ;  }	
	gw\:textarea {  behavior: url(/genuSuite/system/controls/textarea.htc) ;  }	
	gw\:radio {  behavior: url(/genuSuite/system/controls/radio.htc) ;  }	
	gw\:checkbox {  behavior: url(/genuSuite/system/controls/checkbox.htc) ;  }	
	gw\:list {  behavior: url(/genuSuite/system/controls/list.htc) ; }	
	gw\:tab {  behavior: url(/genuSuite/system/controls/tab.htc) ;  }	
	gw\:datebox {  behavior: url(/genuSuite/system/controls/datebox.htc) ;  }	
	gw\:image{  behavior: url(/genuSuite/system/controls/image.htc) ;  }	
	
	gw\:data{  behavior: url(/genuSuite/system/controls/data.htc) ;  }	
	gw\:tree {  behavior: url(/genuSuite/system/controls/tree.htc) ;  }	
	gw\:download  {  behavior: url(/genuSuite/system/controls/download.htc) ;  }	
	
	gw\:imgBtn {  behavior: url(/genuSuite/system/controls/imageBtn.htc) ;  }		
	gw\:neogrid{  behavior: url(/genuSuite/system/controls/neogrid.htc) ;  }		
	gw\:label2 {  behavior: url(/genuSuite/system/controls/label2.htc) ;  }
	gw\:DataNavigator {  behavior: url(/genuSuite/system/controls/DataNavigator.htc) ;  }
}

v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}

.effect { behavior:  url(/genuSuite/system/lib/effect.htc) }

</style>

<script>

function CallDSO( id )
{
	System.NMCallDSO( this, id );
}

function CallDSOSQL( id , type )
{
	System.NMCallDSOSQL( this , id , type );
}


function FindDSOSQL( id )
{
	return System.NMFindDSOSQL( this,  id );	
}

function BodyInitInternal()
{
	if ( typeof(BodyInit) != "undefined" )
		window.setTimeout("BodyInit()", 0);
}

function BodyCloseInternal()
{

	if ( System ) 
	{
		System.UnregisterDSO( this );
	}
	
	if ( typeof(BodyClose) != "undefined" )
		BodyClose();
}

window.onload = BodyInitInternal;
window.onunload = BodyCloseInternal;


</script>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1458 style='border-collapse:
 collapse;table-layout:fixed;width:1093pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=267 style='mso-width-source:userset;mso-width-alt:9764;
 width:200pt'>
 <col class=xl24 width=96 span=11 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl26 colspan=2 width=331 style='height:17.1pt;mso-ignore:
  colspan;width:248pt'>CÔNG TY CƠ KHÍ VÀ XÂY DỰNG POSLILAMA</td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl27 width=96 style='width:72pt'></td>
  <td class=xl25 width=96 style='width:72pt'></td>
  <td class=xl25 width=96 style='width:72pt'></td>
  <td class=xl25 width=96 style='width:72pt'></td>
  <td class=xl25 width=71 style='width:53pt'></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl26 colspan=2 style='height:17.1pt;mso-ignore:colspan'>KHU
  CÔNG NGHIỆP NHƠN TRẠCH ĐỐNG NAI</td>
  <td colspan=7 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl28 colspan=2 style='height:17.1pt;mso-ignore:colspan'>MST/Tax
  Code: 3 6 0 0 2 5 4 8 5 1 - 1</td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl25 style='height:21.95pt'></td>
  <td colspan=12 class=xl37>PROJECT INCOME STATEMENT</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl25 style='height:21.95pt'></td>
  <td colspan=12 class=xl37>Month 07 Year 2009</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=14 class=xl25 style='height:17.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td rowspan=4 height=88 class=xl38 width=64 style='border-bottom:.5pt solid black;
  height:68.4pt;width:48pt'>CODE</td>
  <td rowspan=4 class=xl38 width=267 style='border-bottom:.5pt solid black;
  width:200pt'>NAME</td>
  <td rowspan=4 class=xl38 width=96 style='border-bottom:.5pt solid black;
  width:72pt'>TURNOVER</td>
  <td colspan=5 rowspan=2 class=xl41 width=480 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:360pt'>DIRECT COST OF TURNOVER</td>
  <td rowspan=4 class=xl38 width=96 style='border-bottom:.5pt solid black;
  width:72pt'>INDIRECT COST OF TURNOVER</td>
  <td colspan=2 rowspan=2 class=xl41 width=192 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:144pt'>GROSS MARGIN</td>
  <td colspan=2 rowspan=2 class=xl41 width=192 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:144pt'>CONTRACT</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td rowspan=2 height=44 class=xl49 width=96 style='border-bottom:.5pt solid black;
  height:34.2pt;border-top:none;width:72pt'>TOTAL</td>
  <td rowspan=2 class=xl49 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>MATERIAL</td>
  <td rowspan=2 class=xl49 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>LABOUR</td>
  <td rowspan=2 class=xl49 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>OUTSIDE ORDER</td>
  <td rowspan=2 class=xl49 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>EXPENSES</td>
  <td rowspan=2 class=xl49 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>DIRECT</td>
  <td rowspan=2 class=xl49 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>INDIRECT</td>
  <td rowspan=2 class=xl49 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>AMOUNT</td>
  <td rowspan=2 class=xl49 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>BUDGET</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl30 style='height:21.95pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl30 style='height:21.95pt'>&nbsp;</td>
  <td class=xl31 x:str="TOTAL"><span
  style='mso-spacerun:yes'> </span>TOTAL<span style='mso-spacerun:yes'> </span></td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl32></td>
  <td colspan=11 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl34>PREPARE BY</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl34>CHIEF ACC</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl34>DIRECTOR</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl36>Người lập biểu</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl36>Kế toán trưởng</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl36>Giám đốc</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl36>Sign/Ký</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl36>Sign/Ký</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl36>Sign/Ký</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=14 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=14 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=267 style='width:200pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=71 style='width:53pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
