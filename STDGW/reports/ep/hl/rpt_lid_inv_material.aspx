<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("imex");%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<% 
    string mst_pk = Request.QueryString["mst_pk"];
    DataTable dt_mst, dt_dtl;
    string com_name = "", add = "", com_no = "", delc_no = "";
    dt_mst = ESysLib.TableReadOpenCursor("imex.sp_rpt_ephl00020_7_mst", "'" + mst_pk + "'");
    if (dt_mst.Rows.Count > 0)
    {
        com_name = dt_mst.Rows[0]["partner_name"].ToString();
        add = dt_mst.Rows[0]["addr1"].ToString();
        com_no = dt_mst.Rows[0]["masodn"].ToString();
        delc_no = dt_mst.Rows[0]["liquid_doc_no"].ToString();
    }
    dt_dtl = ESysLib.TableReadOpenCursor("imex.sp_rpt_ephl00020_7", "'" + mst_pk + "'");
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_lid_inv_material_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_lid_inv_material_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_lid_inv_material_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>FPTELEAD</o:Author>
  <o:LastAuthor>AILINH</o:LastAuthor>
  <o:LastPrinted>2008-11-13T06:51:44Z</o:LastPrinted>
  <o:Created>2007-06-12T04:02:21Z</o:Created>
  <o:LastSaved>2008-11-17T07:53:21Z</o:LastSaved>
  <o:Company>FPT</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P";
	margin:.25in 0in .25in .25in;
	mso-header-margin:.39in;
	mso-footer-margin:.22in;
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime";
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
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;}
.xl25
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style16;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl31
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:top;}
.xl37
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;}
.xl42
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;}
.xl44
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:top;}
.xl45
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl47
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl48
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:top;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;}
.xl53
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;
	border:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:right;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl81
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
.xl83
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>180</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5895</x:WindowHeight>
  <x:WindowWidth>11640</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl30>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1336 style='border-collapse:
 collapse;table-layout:fixed;width:1004pt'>
 <col class=xl30 width=32 style='mso-width-source:userset;mso-width-alt:1024;
 width:24pt'>
 <col class=xl45 width=155 style='mso-width-source:userset;mso-width-alt:4960;
 width:116pt'>
 <col class=xl43 width=104 style='mso-width-source:userset;mso-width-alt:3328;
 width:78pt'>
 <col class=xl44 width=53 style='mso-width-source:userset;mso-width-alt:1696;
 width:40pt'>
 <col class=xl43 width=57 style='mso-width-source:userset;mso-width-alt:1824;
 width:43pt'>
 <col class=xl43 width=71 style='mso-width-source:userset;mso-width-alt:2272;
 width:53pt'>
 <col class=xl30 width=40 style='mso-width-source:userset;mso-width-alt:1280;
 width:30pt'>
 <col class=xl45 width=106 style='mso-width-source:userset;mso-width-alt:3392;
 width:80pt'>
 <col class=xl30 width=100 style='mso-width-source:userset;mso-width-alt:3200;
 width:75pt'>
 <col class=xl44 width=53 style='mso-width-source:userset;mso-width-alt:1696;
 width:40pt'>
 <col class=xl43 width=60 style='mso-width-source:userset;mso-width-alt:1920;
 width:45pt'>
 <col class=xl30 width=40 style='mso-width-source:userset;mso-width-alt:1280;
 width:30pt'>
 <col class=xl43 width=58 style='mso-width-source:userset;mso-width-alt:1856;
 width:44pt'>
 <col class=xl43 width=80 style='mso-width-source:userset;mso-width-alt:2560;
 width:60pt'>
 <col class=xl43 width=89 style='mso-width-source:userset;mso-width-alt:2848;
 width:67pt'>
 <col class=xl43 width=55 style='mso-width-source:userset;mso-width-alt:1760;
 width:41pt'>
 <col class=xl43 width=73 style='mso-width-source:userset;mso-width-alt:2336;
 width:55pt'>
 <col class=xl30 width=66 style='mso-width-source:userset;mso-width-alt:2112;
 width:50pt'>
 <col class=xl30 width=44 style='mso-width-source:userset;mso-width-alt:1408;
 width:33pt'>
 <tr height=12 style='height:9.0pt'>
  <td height=12 class=xl41 width=32 style='height:9.0pt;width:24pt'></td>
  <td class=xl42 width=155 style='width:116pt'></td>
  <td class=xl43 style="width:77pt"></td>
  <td class=xl44 width=53 style='width:40pt'></td>
  <td class=xl43 width=57 style='width:43pt'></td>
  <td class=xl43 width=71 style='width:53pt'></td>
  <td class=xl30 width=40 style='width:30pt'></td>
  <td class=xl45 width=106 style='width:80pt'></td>
  <td class=xl30 width=100 style='width:75pt'></td>
  <td class=xl44 width=53 style='width:40pt'></td>
  <td class=xl43 width=60 style='width:45pt'></td>
  <td class=xl46 width=40 style='width:30pt'></td>
  <td class=xl43 width=58 style='width:44pt'></td>
  <td class=xl43 width=80 style='width:60pt'></td>
  <td class=xl43 width=89 style='width:67pt'></td>
  <td class=xl43 width=55 style='width:41pt'></td>
  <td class=xl43 width=73 style='width:55pt'></td>
  <td class=xl30 width=66 style='width:50pt'></td>
  <td class=xl30 width=44 style='width:33pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=18 class=xl73><span style='mso-spacerun:yes'> &nbsp;&nbsp; &nbsp; </span>BÁO CÁO
  NGUYÊN LI&#7878;U, V&#7852;T T&#431; NH&#7852;P-XU&#7844;T-T&#7890;N</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=19 height=17 class=xl74 width=1336 style='height:12.75pt;
  width:1004pt'>(Ban hành kèm theo Thông t&#432; s&#7889; 59/2007/TT-BTC ngày
  14/6/2007 c&#7911;a B&#7897; Tài chính h&#432;&#7899;ng d&#7851;n thi hành
  thu&#7871; xu&#7845;t kh&#7849;u, thu&#7871; nh&#7853;p kh&#7849;u,
  qu&#7843;n lý thu&#7871; &#273;&#7889;i v&#7899;i hàng hoá xu&#7845;t
  kh&#7849;u, nh&#7853;p kh&#7849;u)</td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td height=12 class=xl24 style='height:9.0pt'></td>
  <td class=xl39></td>
  <td class=xl33 style="width: 77pt"></td>
  <td class=xl36></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl39></td>
  <td class=xl24></td>
  <td class=xl36></td>
  <td class=xl33></td>
  <td class=xl24></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td class=xl47 colspan=3 style="height:13pt;mso-ignore:colspan">Tên
  Doanh nghi&#7879;p: <%=com_name %></td>
  <td class=xl44 style="height: 13pt"></td>
  <td colspan=2 class=xl43 style="mso-ignore:colspan; height: 13pt;"></td>
  <td class=xl49 style="height: 13pt"></td>
  <td class=xl50 width=106 style="width:80pt; height: 13pt;">&#272;&#7883;a ch&#7881;:</td>
  <td class=xl60 style="height: 13pt"><%=add %></td>
  <td class=xl36 style="height: 13pt"></td>
  <td class=xl33 style="height: 13pt"></td>
  <td class=xl49 style="height: 13pt"></td>
  <td colspan=5 class=xl43 style="mso-ignore:colspan; height: 13pt;"></td>
  <td colspan=2 class=xl30 style="mso-ignore:colspan; height: 13pt;"></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td class=xl47 colspan=2 style="height:13pt;mso-ignore:colspan">Mã
  s&#7889; doanh nghi&#7879;p: <%=com_no %></td>
  <td class=xl33 style="width: 77pt; height: 13pt"></td>
  <td class=xl44 style="height: 13pt"></td>
  <td colspan=2 class=xl43 style="mso-ignore:colspan; height: 13pt;"></td>
  <td class=xl49 style="height: 13pt"></td>
  <td class=xl51 style="height: 13pt"></td>
  <td class=xl49 style="height: 13pt"></td>
  <td class=xl44 style="height: 13pt"></td>
  <td class=xl43 style="height: 13pt"></td>
  <td class=xl49 style="height: 13pt"></td>
  <td colspan=5 class=xl43 style="mso-ignore:colspan; height: 13pt;"></td>
  <td colspan=2 class=xl30 style="mso-ignore:colspan; height: 13pt;"></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl47 colspan=2 style='height:12.75pt;mso-ignore:colspan'>S&#7889;
  h&#7891; s&#417; thanh kho&#7843;n: <%=delc_no %></td>
  <td class=xl33 style="width: 77pt"></td>
  <td class=xl44></td>
  <td class=xl52 colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td class=xl45></td>
  <td class=xl52 colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td class=xl49></td>
  <td colspan=5 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td height=12 class=xl49 style='height:9.0pt'></td>
  <td class=xl48></td>
  <td class=xl33 style="width: 77pt"></td>
  <td class=xl44></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl49></td>
  <td class=xl51></td>
  <td class=xl49></td>
  <td class=xl44></td>
  <td class=xl43></td>
  <td class=xl49></td>
  <td colspan=5 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td rowspan=3 height=72 class=xl64 width=32 style='border-right:.5pt solid black;
  height:54.0pt;width:24pt'>STT</td>
  <td class=xl40 width=155 style="border-left:none;width:116pt; height: 9pt;">&nbsp;</td>
  <td class=xl26 style="width: 77pt; height: 9pt;">Nguyên li&#7879;u, v&#7853;t t&#432;<span
  style='mso-spacerun:yes'>&nbsp; </span>(NL, VT) nh&#7853;p kh&#7849;u</td>
  <td class=xl37 style="border-left:none; height: 9pt;">&nbsp;</td>
  <td class=xl32 style="border-left:none; height: 9pt;">&nbsp;</td>
  <td class=xl38 style="border-left:none; height: 9pt;">&nbsp;</td>
  <td class=xl25 style="border-left:none; height: 9pt;">&nbsp;</td>
  <td colspan=6 class=xl64 width=417 style="border-left:none;width:314pt; height: 9pt;">Nguyên
  li&#7879;u, v&#7853;t t&#432; &#273;ã s&#7917; d&#7909;ng s&#7843;n
  xu&#7845;t s&#7843;n ph&#7849;m xu&#7845;t kh&#7849;u</td>
  <td class=xl34 style="height: 9pt">&nbsp;</td>
  <td colspan=2 class=xl71 style="border-right:.5pt solid black;border-left:
  none; height: 9pt;"><span style='mso-spacerun:yes'>     &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
      &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; </span>NL, VT xu&#7845;t tr&#7843;
  l&#7841;i</td>
  <td rowspan=3 class=xl68 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>L&#432;&#7907;ng NL, VT t&#7891;n cu&#7889;i k&#7923;</td>
  <td colspan=2 class=xl64 width=110 style="border-right:.5pt solid black;
  border-left:none;width:83pt; height: 9pt;">X&#7917; lý NL, VT t&#7891;n cu&#7889;i k&#7923;</td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td rowspan=2 height=60 class=xl27 width=155 style='height:45.0pt;width:116pt'>Tên/
  Mã nguyên li&#7879;u, v&#7853;t t&#432;</td>
  <td colspan=4 class=xl64 width=285 style='border-right:.5pt solid black;
  border-left:none;width:214pt'>T&#7901; khai nh&#7853;p kh&#7849;u</td>
  <td rowspan=2 class=xl72 width=40 style='border-top:none;width:30pt'>&#272;&#417;n
  v&#7883; tính</td>
  <td rowspan=2 class=xl27 width=106 style='border-top:none;width:80pt'>Tên/ Mã
  s&#7843;n ph&#7849;m xu&#7845;t kh&#7849;u</td>
  <td colspan=3 class=xl64 width=213 style='border-right:.5pt solid black;
  border-left:none;width:160pt'>T&#7901; khai xu&#7845;t kh&#7849;u</td>
  <td rowspan=2 class=xl72 width=40 style='border-top:none;width:30pt'>&#272;&#417;n<span
  style='mso-spacerun:yes'>&nbsp; </span>v&#7883; tính</td>
  <td rowspan=2 class=xl68 width=58 style='border-bottom:.5pt solid black;
  border-top:none;width:44pt'>&#272;&#7883;nh m&#7913;c NL,VT (k&#7875;
  c&#7843; hao h&#7909;t)/ &#273;&#417;n<span style='mso-spacerun:yes'>&nbsp;
  </span>v&#7883; s&#7843;n ph&#7849;m</td>
  <td rowspan=2 class=xl68 width=80 style='border-bottom:.5pt solid black;
  border-top:none;width:60pt'>L&#432;&#7907;ng NL, VT s&#7917; d&#7909;ng
  s&#7843;n xu&#7845;t SP XK</td>
  <td rowspan=2 class=xl68 width=89 style='border-bottom:.5pt solid black;
  border-top:none;width:67pt'>T&#7901; khai xu&#7845;t kh&#7849;u (s&#7889;; ký
  hi&#7879;u; ngày &#273;&#259;ng ký)</td>
  <td rowspan=2 class=xl68 width=55 style='border-bottom:.5pt solid black;
  border-top:none;width:41pt' x:str="L&#432;&#7907;ng NL, VT xu&#7845;t tr&#7843; l&#7841;i ">L&#432;&#7907;ng
  NL, VT xu&#7845;t tr&#7843; l&#7841;i<span style='mso-spacerun:yes'>&nbsp;</span></td>
  <td rowspan=2 class=xl68 width=66 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt'>Thanh kho&#7843;n ti&#7871;p</td>
  <td rowspan=2 class=xl68 width=44 style='border-bottom:.5pt solid black;
  border-top:none;width:33pt'>Chuy&#7875;n m&#7909;c &#273;ích khác</td>
 </tr>
 <tr height=48 style='height:36.0pt'>
  <td class=xl35 style="height:36.0pt;border-top:none;
  border-left:none;width:77pt; text-align: center;">S&#7889;; ký hi&#7879;u; ngày &#273;&#259;ng ký</td>
  <td class=xl31 width=53 style="border-top:none;border-left:none;width:40pt; height: 36pt;">Ngày
  hoàn thành th&#7911; t&#7909;c</td>
  <td class=xl27 width=57 style="border-top:none;border-left:none;width:43pt; height: 36pt;">L&#432;&#7907;ng
  NL,VT nh&#7853;p kh&#7849;u</td>
  <td class=xl28 width=71 style="border-left:none;width:53pt; height: 36pt;">L&#432;&#7907;ng
  NL,VT t&#7891;n &#273;&#7847;u k&#7923; ch&#432;a thanh kho&#7843;n</td>
  <td class=xl27 width=100 style="border-top:none;border-left:none;width:75pt; height: 36pt;">S&#7889;;
  ký hi&#7879;u; ngày &#273;&#259;ng ký</td>
  <td class=xl31 width=53 style="border-top:none;border-left:none;width:40pt; height: 36pt;"
  x:str="Ngày hoàn thành th&#7911; t&#7909;c h&#7843;i quan ">Ngày hoàn thành
  th&#7911; t&#7909;c h&#7843;i quan<span style='mso-spacerun:yes'>&nbsp;</span></td>
  <td class=xl29 width=60 style="border-left:none;width:45pt; height: 36pt;"
  x:str="L&#432;&#7907;ng s&#7843;n ph&#7849;m xu&#7845;t kh&#7849;u        "><span
  style='mso-spacerun:yes'> &nbsp;&nbsp; &nbsp; </span>L&#432;&#7907;ng s&#7843;n ph&#7849;m
  xu&#7845;t kh&#7849;u<span style='mso-spacerun:yes'> &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span></td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td class=xl55 width=32 style='height:9.0pt;border-top:none;
  width:24pt' x:num="-1">(1)</td>
  <td class=xl55 width=155 style="border-top:none;border-left:none;width:116pt; height: 9pt;"
  x:num="-2">(2)</td>
  <td class=xl55 style="border-top:none;border-left:none;width:77pt; height: 9pt;"
  x:num="-3">(3)</td>
  <td class=xl55 width=53 style="border-top:none;border-left:none;width:40pt; height: 9pt;"
  x:num="-4">(4)</td>
  <td class=xl55 width=57 style="border-top:none;border-left:none;width:43pt; height: 9pt;"
  x:num="-5">(5)</td>
  <td class=xl55 width=71 style="border-top:none;border-left:none;width:53pt; height: 9pt;"
  x:num="-6">(6)</td>
  <td class=xl55 width=40 style="border-top:none;border-left:none;width:30pt; height: 9pt;"
  x:num="-7">(7)</td>
  <td class=xl55 width=106 style="border-top:none;border-left:none;width:80pt; height: 9pt;"
  x:num="-8">(8)</td>
  <td class=xl55 width=100 style="border-top:none;border-left:none;width:75pt; height: 9pt;"
  x:num="-9">(9)</td>
  <td class=xl55 width=53 style="border-top:none;border-left:none;width:40pt; height: 9pt;"
  x:num="-10">(10)</td>
  <td class=xl56 width=60 style="border-top:none;border-left:none;width:45pt; height: 9pt;"
  x:num="-11">(11)</td>
  <td class=xl55 width=40 style="border-top:none;border-left:none;width:30pt; height: 9pt;"
  x:num="-12">(12)</td>
  <td class=xl55 width=58 style="border-top:none;border-left:none;width:44pt; height: 9pt;"
  x:num="-13">(13)</td>
  <td class=xl55 width=80 style="border-top:none;border-left:none;width:60pt; height: 9pt;"
  x:num="-14">(14)</td>
  <td class=xl55 width=89 style="border-top:none;border-left:none;width:67pt; height: 9pt;"
  x:num="-15">(15)</td>
  <td class=xl56 width=55 style="border-top:none;border-left:none;width:41pt; height: 9pt;"
  x:num="-16">(16)</td>
  <td class=xl55 width=73 style="border-top:none;border-left:none;width:55pt; height: 9pt;"
  x:num="-17">(17)</td>
  <td class=xl55 width=66 style="border-top:none;border-left:none;width:50pt; height: 9pt;"
  x:num="-18">(18)</td>
  <td class=xl55 width=44 style="border-top:none;border-left:none;width:33pt; height: 9pt;"
  x:num="-19">(19)</td>
 </tr>
 <%
     for (int i = 1; i < dt_dtl.Rows.Count; i++)
     {
         %>
 <tr height=12 style='height:9.0pt'>
  <td class=xl58 style='height:9.0pt;border-top:none'><%=dt_dtl.Rows[i]["seq"] %></td>
  <td class=xl59 width=155 style="border-top:none;border-left:none;width:116pt; height: 9pt;"><%=dt_dtl.Rows[i]["item_code"]%>&nbsp;<%=dt_dtl.Rows[i]["item_name"]%></td>
  <td class=xl54 style="border-top:none;border-left:none; width: 77pt; height: 9pt;"><%=dt_dtl.Rows[i]["decl_no"]%>&nbsp; <%=dt_dtl.Rows[i]["decl_date"]%></td>
  <td class=xl53 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["export_date"]%></td>
  <td class=xl54 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["qty_01"]%></td>
  <td class=xl54 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["stock_qty"]%></td>
  <td class=xl58 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["uom_01"]%></td>
  <td class=xl59 width=106 style="border-top:none;border-left:none;width:80pt; height: 9pt;"><%=dt_dtl.Rows[i]["item_code_ex"]%>&nbsp;<%=dt_dtl.Rows[i]["item_name_ex"]%></td>
  <td class=xl58 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["decl_no_ex"]%>&nbsp;<%=dt_dtl.Rows[i]["decl_date_ex"]%></td>
  <td class=xl53 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["export_date_ex"]%></td>
  <td class=xl54 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["req_qty"]%></td>
  <td class=xl58 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["unit"]%></td>
  <td class=xl54 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["cons_qty"]%></td>
  <td class=xl54 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["prod_mat_qty"]%></td>
  <td class=xl54 style="border-top:none;border-left:none; height: 9pt;"></td>
  <td class=xl54 style="border-top:none;border-left:none; height: 9pt;">&nbsp;</td>
  <td class=xl54 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["ton_cuoi_ki"] %></td>
  <td class=xl58 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["thanh_khoan_tiep"]%></td>
  <td class=xl58 style="border-top:none;border-left:none; height: 9pt;"><%=dt_dtl.Rows[i]["muc_dich_cuoi"]%></td>
 </tr>
         <% 
     }
      %>
 
 <tr height=12 style='height:9.0pt'>
  <td height=12 class=xl30 style='height:9.0pt'></td>
  <td colspan=3 class=xl81 width=312 style='width:234pt'><span
  style='mso-spacerun:yes'> &nbsp;&nbsp; &nbsp; </span>&#272;&#7891;ng Nai, ngày ....... tháng
  ........ n&#259;m ..........</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl45></td>
  <td class=xl30></td>
  <td class=xl44></td>
  <td colspan=5 class=xl82><span
  style='mso-spacerun:yes'> &nbsp;&nbsp; &nbsp; </span>&#272;&#7891;ng Nai, ngày<span
  style='mso-spacerun:yes'> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; </span>tháng<span
  style='mso-spacerun:yes'> &nbsp; &nbsp;&nbsp; </span>n&#259;m 2008</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td class=xl30 style="height:11pt"></td>
  <td colspan=3 class=xl83 width=312 style="width:234pt; height: 11pt;">Công ch&#7913;c
  H&#7843;i quan ki&#7875;m tra, &#273;&#7889;i chi&#7871;u</td>
  <td colspan=2 class=xl43 style="mso-ignore:colspan; height: 11pt;"></td>
  <td class=xl30 style="height: 11pt"></td>
  <td colspan=2 class=xl63 width=206 style="width:155pt; height: 11pt;">Ng&#432;&#7901;i
  l&#7853;p bi&#7875;u</td>
  <td class=xl44 style="height: 11pt"></td>
  <td colspan=5 class=xl84 style="height: 11pt">Giám &#273;&#7889;c doanh nghi&#7879;p</td>
  <td colspan=2 class=xl43 style="mso-ignore:colspan; height: 11pt;"></td>
  <td colspan=2 class=xl30 style="mso-ignore:colspan; height: 11pt;"></td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td height=12 class=xl30 style='height:9.0pt'></td>
  <td colspan=3 class=xl79 width=312 style='width:234pt'><span
  style='mso-spacerun:yes'>   &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; </span>(Ký tên, &#273;óng d&#7845;u công
  ch&#7913;c)</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl45></td>
  <td class=xl30></td>
  <td class=xl44></td>
  <td colspan=5 class=xl80><span style='mso-spacerun:yes'>   &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
  </span>(Ký,
  &#273;óng d&#7845;u, ghi rõ h&#7885;, tên)</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td height=12 class=xl30 style='height:9.0pt'></td>
  <td class=xl45></td>
  <td class=xl43 style="width: 77pt"></td>
  <td class=xl44></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl45></td>
  <td class=xl30></td>
  <td class=xl44></td>
  <td class=xl43></td>
  <td class=xl30></td>
  <td colspan=5 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td height=12 class=xl30 style='height:9.0pt'></td>
  <td class=xl45></td>
  <td class=xl43 style="width: 77pt"></td>
  <td class=xl44></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl45></td>
  <td class=xl30></td>
  <td class=xl44></td>
  <td class=xl43></td>
  <td class=xl30></td>
  <td colspan=5 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td height=12 class=xl30 style='height:9.0pt'></td>
  <td class=xl45></td>
  <td class=xl43 style="width: 77pt"></td>
  <td class=xl44></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl45></td>
  <td class=xl30></td>
  <td class=xl44></td>
  <td class=xl43></td>
  <td class=xl30></td>
  <td colspan=5 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='height:9.0pt'>
  <td height=12 class=xl30 style='height:9.0pt'></td>
  <td class=xl45></td>
  <td class=xl43 style="width: 77pt"></td>
  <td class=xl44></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl45></td>
  <td class=xl30></td>
  <td class=xl44></td>
  <td class=xl43></td>
  <td class=xl30></td>
  <td colspan=5 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='height:10.5pt'>
  <td class=xl30 style="height:11pt"></td>
  <td class=xl45 style="height: 11pt"></td>
  <td class=xl43 style="width: 77pt; height: 11pt;"></td>
  <td class=xl44 style="height: 11pt"></td>
  <td colspan=2 class=xl43 style="mso-ignore:colspan; height: 11pt;"></td>
  <td class=xl30 style="height: 11pt"></td>
  <td colspan=2 class=xl63 width=206 style="width:155pt; height: 11pt;">&#272;&#7895;
  Th&#7883; Linh</td>
  <td class=xl44 style="height: 11pt"></td>
  <td class=xl43 style="height: 11pt"></td>
  <td class=xl30 style="height: 11pt"></td>
  <td colspan=5 class=xl43 style="mso-ignore:colspan; height: 11pt;"></td>
  <td colspan=2 class=xl30 style="mso-ignore:colspan; height: 11pt;"></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=155 style='width:116pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=44 style='width:33pt'></td>
 </tr>
 <![endif]></table>

</body>

</html>
