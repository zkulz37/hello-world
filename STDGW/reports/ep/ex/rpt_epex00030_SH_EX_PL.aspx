<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("imex");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<% 
    string pk = Request.QueryString["pk"];

    DataTable dt1;
    dt1 = ESysLib.TableReadOpenCursor("imex.sp_rpt_epex00030_sh_ex_ci", "'" + pk + "'");  
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="epex00030_SH_EX_CI_files/filelist.xml">
<link rel=Edit-Time-Data href="epex00030_SH_EX_CI_files/editdata.mso">
<link rel=OLE-Object-Data href="epex00030_SH_EX_CI_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>shvtn16</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2009-12-07T03:20:08Z</o:LastPrinted>
  <o:Created>2008-08-28T07:56:11Z</o:Created>
  <o:LastSaved>2010-06-25T04:02:15Z</o:LastSaved>
  <o:Company>admin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.36in 0in .32in 0in;
	mso-header-margin:.22in;
	mso-footer-margin:.21in;}
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
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl73
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.xl76
	{mso-style-parent:style43;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl77
	{mso-style-parent:style43;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl78
	{mso-style-parent:style43;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;}
.xl79
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl80
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl82
	{mso-style-parent:style0;
	color:black;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.xl83
	{mso-style-parent:style0;
	color:black;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";}
.xl84
	{mso-style-parent:style0;
	color:black;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl85
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl87
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>EX_CV</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:ShowPageBreakZoom/>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>750</x:WindowTopX>
  <x:WindowTopY>-165</x:WindowTopY>
  <x:TabRatio>684</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=EX_CV!$A$1:$O$58</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=847 style='border-collapse:
 collapse;table-layout:fixed;width:638pt'>
 <col class=xl65 width=7 style='mso-width-source:userset;mso-width-alt:256;
 width:5pt'>
 <col class=xl65 width=64 style='width:48pt'>
 <col class=xl65 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl65 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl65 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl65 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl65 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl65 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl65 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl65 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl65 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl65 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl65 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl65 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl65 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl65 width=64 span=2 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=15 height=21 class=xl86 width=719 style='height:15.75pt;
  width:542pt'><a name="Print_Area">SUHEUNG VIETNAM CO., LTD.</a></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=15 height=27 class=xl66 style='height:20.25pt'>PACKING LIST</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=14 class=xl66 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl81>ORIGINAL</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl67 colspan=3 style='height:14.1pt;mso-ignore:colspan'>Shipper/Exporter:</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67 colspan=3 style='mso-ignore:colspan'>No. &amp; date of invoice</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=4 style='mso-ignore:colspan'>SUHEUNG VIETNAM CO., LTD.</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td class=xl65><%=dt1.Rows[0]["co_invoice_no"]%></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan' ><%=dt1.Rows[0]["co_invoice_date"]%></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=4 style='mso-ignore:colspan'>LONG THANH INDUSTRIAL
  ZONE</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67 colspan=4 style='mso-ignore:colspan'>No. &amp; date of L/C or
  Order</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=6 style='mso-ignore:colspan'>TAM AN VILLAGE, LONG
  THANH DISTRICT</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl82  ><%=dt1.Rows[0]["lc_no"]%></td>
  <td colspan=3 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl84 colspan=2 style='mso-ignore:colspan'  ><%=dt1.Rows[0]["lc_date"]%></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=4 style='mso-ignore:colspan'>DONG NAI PROVINCE,
  VIETNAM</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl67 colspan=4 style='height:14.1pt;mso-ignore:colspan'>Account
  &amp; Risk of Messrs.</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68 style='border-top:none'>&nbsp;</td>
  <td class=xl67 colspan=2 style='mso-ignore:colspan'>L/C issuing Bank</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan' ><%=dt1.Rows[0]["paid_name"]%></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'><%=dt1.Rows[0]["lc_bank"]%></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=6 style='mso-ignore:colspan'><%=dt1.Rows[0]["paid_add1"]%></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'><%=dt1.Rows[0]["paid_add2"]%></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'><%=dt1.Rows[0]["paid_add3"]%></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=7 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl67 colspan=3 style='height:14.1pt;mso-ignore:colspan'>Notify
  Party</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>Remarks:</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'><%=dt1.Rows[0]["notify_name"]%></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>*</td>
  <td class=xl82 colspan=7 style='mso-ignore:colspan'>PAYMENT: <%=dt1.Rows[0]["payment_term"]%></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=6 style='mso-ignore:colspan'><%=dt1.Rows[0]["notify_add1"]%></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'><%=dt1.Rows[0]["notify_add2"]%></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 style='height:14.1pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'><%=dt1.Rows[0]["notify_add3"]%></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=7 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=7 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=7 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl67 colspan=3 style='height:14.1pt;mso-ignore:colspan'>Port
  of Loading</td>
  <td class=xl68 colspan=4 style='mso-ignore:colspan'><%=dt1.Rows[0]["dm_port"]%></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67>Carrier</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68 colspan=3 style='mso-ignore:colspan'><%=dt1.Rows[0]["ship_no"]%></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=3 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl69 colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl67 colspan=3 style='height:14.1pt;mso-ignore:colspan'>Final
  Destination</td>
  <td class=xl68 colspan=4 style='mso-ignore:colspan'><%=dt1.Rows[0]["os_port"]%></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl67 colspan=3 style='mso-ignore:colspan'>Sailing on or about</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68 colspan=2 style='mso-ignore:colspan'><%=dt1.Rows[0]["ship_date"]%></td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=3 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl67 colspan=4 style='height:14.1pt;mso-ignore:colspan'>Marks
  and Number of PKGS</td>
  <td class=xl68 colspan=3 style='mso-ignore:colspan'>Description of Goods</td>
  <td class=xl68>&nbsp;</td>
  <td colspan=2 class=xl85>Quantity/Unit</td>
  <td colspan=3 class=xl87 style='border-right:.5pt solid black'>Unit-Price</td>
  <td colspan=2 class=xl85>Amount</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=4 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td class=xl65></td>
  <td class=xl71>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=17 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 colspan=2 style='height:14.1pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 colspan=2 style='height:14.1pt;mso-ignore:colspan'></td>
  <td colspan=15 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 
<%
     DataTable dt2;   
    
     dt2 = ESysLib.TableReadOpenCursor("imex.sp_rpt_epex00030_sh_ex_ci_1", pk);
     
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
     
%>      
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 colspan=3 style='height:14.1pt;mso-ignore:colspan'>
  </td>
  <td class=xl65></td>
  <td class=xl65><%=dt2.Rows[i]["t_size"]%></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl77  > <%=dt2.Rows[i]["inv_qty_01"]%> </td>
  <td class=xl65>PCS</td>
  <td class=xl65>USD</td>
  <td class=xl76 x:num=""> <%=dt2.Rows[i]["inv_uprice"]%> </td>
  <td class=xl65 >/1,000 PCS</td>
  <td class=xl65>USD</td>
  <td class=xl78 x:num=""> <%=dt2.Rows[i]["inv_amount"]%>  </td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl65 colspan=2 style='height:14.1pt;mso-ignore:colspan'> </td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl65 colspan=6 style='mso-ignore:colspan'><%=dt2.Rows[i]["c_color"]%> / <%=dt2.Rows[i]["b_color"]%></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
 }
 %>
 
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=8 class=xl65 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl76></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=4 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl74 x:str="TOTAL ">TOTAL<span style='mso-spacerun:yes'> </span></td>
  <td class=xl74>:</td>
  <td class=xl74 colspan=4 style='mso-ignore:colspan'>CIF PORT K'LANG, MALAYSIA</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl79 > <%=dt1.Rows[0]["inv_qty_01"]%> </td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'>PCS</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl65>USD</td>
  <td class=xl76  ><%=dt1.Rows[0]["inv_amount"]%>  </td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl65 colspan=9 style='mso-ignore:colspan'
  x:str="'//////////////////////////////////////////////////////////////////////////////////////////////////////////////">//////////////////////////////////////////////////////////////////////////////////////////////////////////////</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=17 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=17 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=3 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl65 colspan=11 style='mso-ignore:colspan' >*
  SAY <%=CommondLib.Num2EngText(dt1.Rows[0]["inv_amount"].ToString(), "USD")%> .<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=17 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=3 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl65 colspan=5 style='mso-ignore:colspan'> </td>
  <td class=xl77></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=17 class=xl65 style='height:14.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=11 class=xl65 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl75 colspan=4 style='mso-ignore:colspan'>SUHEUNG VIETNAM CO., LTD.</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=17 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl72>Signed by:</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'>AUTHORIZED SIGNATURE</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=7 style='width:5pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
