<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string master_pk = Request.QueryString["master_pk"];
    DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_bini00030_1", "'" + master_pk + "'");
    DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_bini00030", "'" + master_pk + "'");

    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    DataTable dt1 = ESysLib.TableReadOpen(str_sql);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bini00030_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bini00030_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bini00030_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-10-06T03:01:11Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-10-06T03:01:39Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .1in .4in .1in;
	mso-header-margin:0in;
	mso-footer-margin:0in;}
.font7
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
.style22
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
	mso-style-name:Normal_PNAP;}
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
	font-family:돋움, monospace;
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
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;}
.xl42
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl43
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl47
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:23.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:23.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
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
.xl53
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
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
.xl54
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
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
.xl55
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
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
.xl56
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
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
.xl57
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl59
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
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
.xl60
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
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
.xl61
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl63
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>210</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>14</x:ActiveCol>
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
  <x:WindowHeight>12825</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>1095</x:WindowTopX>
  <x:WindowTopY>2535</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$12:$13</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=849 style='border-collapse:
 collapse;table-layout:fixed;width:638pt'>
 <col class=xl26 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col class=xl26 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl26 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl26 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl26 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl26 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl26 width=53 span=2 style='mso-width-source:userset;mso-width-alt:
 1938;width:40pt'>
 <col class=xl26 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl26 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl26 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl26 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl26 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl26 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl26 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 width=27 style='height:15.0pt;width:20pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl28 width=83 style='width:62pt'></td>
  <td class=xl28 width=104 style='width:78pt'><%= dt1.Rows[0]["partner_name"]%></td>
  <td class=xl28 width=17 style='width:13pt'></td>
  <td class=xl27 width=69 style='width:52pt'></td>
  <td class=xl26 width=52 style='width:39pt'></td>
  <td class=xl29 width=53 style='width:40pt'></td>
  <td class=xl29 width=53 style='width:40pt'></td>
  <td class=xl29 width=70 style='width:53pt'></td>
  <td colspan=3 class=xl46 width=194 style='width:146pt'>Tel: <%= dt1.Rows[0]["phone_no"]%></td>
  <td class=xl29 width=71 style='width:53pt'></td>
  <td class=xl29 width=56 style='width:42pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl27><%= dt1.Rows[0]["addr1"]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl46 width=194 style='width:146pt'>Fax: <%= dt1.Rows[0]["fax_no"]%></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl27>Tax code: <%= dt1.Rows[0]["tax_code"]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl47 width=194 style='width:146pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=12 rowspan=3 height=66 class=xl48 width=722 style='height:49.5pt;
  width:543pt'>PHIẾU NHẬP KHO<br>
    <font class="font9">(Incoming Slip - Số : <%= dt.Rows[0]["slip_no"]%> )</font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=2 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=2 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=12 height=25 class=xl50 style='height:18.75pt'>Ngày <font
  class="font11"><%= dt.Rows[0]["dd"]%></font><font class="font10">tháng </font><font class="font11"><%= dt.Rows[0]["mm"]%></font><font
  class="font10">năm </font><font class="font11"><%= dt.Rows[0]["yyyy"]%><span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=12 class=xl31 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=6 height=25 class=xl51 style='height:18.75pt'>Nhà cung cấp:<font
  class="font13"> </font><font class="font14"><%= dt.Rows[0]["supplier_name"] %></font><font class="font11"><span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=6 class=xl51>Nhập Kho :<font class="font13"> </font><font
  class="font14"><%= dt.Rows[0]["wh_name"] %><span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=6 height=25 class=xl51 style='height:18.75pt'>Ghi chú:<font
  class="font13"> <%=dt.Rows[0]["description"] %></font></td>
  <td colspan=6 class=xl51>Số P/O :<font class="font13"> </font><font
  class="font14"><%=dt.Rows[0]["ref_no"]%></font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=5 class=xl27 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=76 class=xl52 width=27 style='border-bottom:.5pt solid black;
  height:57.0pt;width:20pt'>STT<br>
    <font class="font7">No</font></td>
  <td colspan=3 rowspan=2 class=xl54 width=204 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:153pt'>Tên<br>
    <font class="font7">Name</font></td>
  <td rowspan=2 class=xl52 width=69 style='border-bottom:.5pt solid black;
  width:52pt'>Mã số<br>
    <font class="font7">Code</font></td>
  <td rowspan=2 class=xl52 width=52 style='border-bottom:.5pt solid black;
  width:39pt'>Đvt<br>
    <font class="font7">Uom</font></td>
  <td colspan=2 class=xl59 width=106 style='border-right:.5pt solid black;
  border-left:none;width:80pt'>Số lượng <font class="font7">Qty</font></td>
  <td rowspan=2 class=xl52 width=70 style='border-bottom:.5pt solid black;
  width:53pt'>Đơn giá<br>
    <font class="font7">Unit Price</font></td>
  <td rowspan=2 class=xl52 width=76 style='border-bottom:.5pt solid black;
  width:57pt'>Thành tiền<br>
    <font class="font7">Amount</font></td>
  <td rowspan=2 class=xl52 width=32 style='border-bottom:.5pt solid black;
  width:24pt'>VAT (%)</td>
  <td rowspan=2 class=xl52 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>Thành tiền<br>
    <font class="font7">Total Amount</font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=56 style='mso-height-source:userset;height:42.0pt'>
  <td height=56 class=xl34 width=53 style='height:42.0pt;width:40pt'>Theo
  c.từ<br>
    <font class="font7">Reg Qty</font></td>
  <td class=xl34 width=53 style='width:40pt'>Thực<br>
    nhập<br>
    <font class="font7">In Qty</font></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
%>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 width=27 style='height:12.75pt;width:20pt' x:num><%=dt2.Rows[i]["seq"]%></td>
  <td colspan=3 class=xl62 width=204 style='border-right:.5pt solid black;
  border-left:none;width:153pt'><%=dt2.Rows[i]["item_name"]%></td>
  <td class=xl36 width=69 style='width:52pt'><%=dt2.Rows[i]["item_code"] %></td>
  <td class=xl36 width=52 style='width:39pt'><%=dt2.Rows[i]["in_uom"]%></td>
  <td class=xl37 width=53 style='width:40pt' x:num><span
  style='mso-spacerun:yes'>           </span><%=dt2.Rows[i]["req_qty"] %><span style='mso-spacerun:yes'>  
  </span></td>
  <td class=xl38 width=53 style='width:40pt' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt2.Rows[i]["in_qty"] %></td>
  <td class=xl39 width=70 style='width:53pt' x:num><span
  style='mso-spacerun:yes'>      </span><%=dt2.Rows[i]["unit_price"] %></td>
  <td class=xl40 width=76 style='width:57pt' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt2.Rows[i]["item_amount"] %></td>
  <td class=xl64 align=center width=32 style='width:24pt' x:num><%=dt2.Rows[i]["vat_rate"]%></td>
  <td class=xl40 width=86 style='width:65pt' x:num><span
  style='mso-spacerun:yes'>     </span><%=dt2.Rows[i]["total_amount"] %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
<% } %> 
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 width=27 style='height:12.75pt;width:20pt' x:num></td>
  <td colspan=3 class=xl62 width=204 style='border-right:.5pt solid black;
  border-left:none;width:153pt'>Cộng</td>
  <td class=xl36 width=69 style='width:52pt'></td>
  <td class=xl36 width=52 style='width:39pt'></td>
  <td class=xl37 width=53 style='width:40pt' x:num><span
  style='mso-spacerun:yes'>           </span><span style='mso-spacerun:yes'>  
  </span></td>
  <td class=xl38 width=53 style='width:40pt' x:num><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 width=70 style='width:53pt' x:num><span
  style='mso-spacerun:yes'>      </span></td>
  <td class=xl40 width=76 style='width:57pt' x:num x:fmla="=SUM(<% if(dt2.Rows.Count > 0){%>J14:J<%= dt2.Rows.Count+13%><%}else{%>J16:J16<%}%>)"><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl64 align=center width=32 style='width:24pt' x:num></td>
  <td class=xl40 width=86 style='width:65pt' x:num x:fmla="=SUM(<% if(dt2.Rows.Count > 0){%>L14:L<%= dt2.Rows.Count+13%><%}else{%>L16:L16<%}%>)"><span
  style='mso-spacerun:yes'>     </span></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl41 colspan=2 style='mso-ignore:colspan'>Người lập phiếu</td>
  <td class=xl41 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>Người giao hàng</td>
  <td></td>
  <td class=xl41 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>       </span>Thủ kho</td>
  <td class=xl41 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>               </span>Thủ trưởng đơn vị</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl42 style='height:14.25pt'></td>
  <td class=xl43></td>
  <td colspan=6 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl45></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl42 style='height:14.25pt'></td>
  <td class=xl43></td>
  <td colspan=6 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl42 style='height:14.25pt'></td>
  <td class=xl43></td>
  <td colspan=6 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td><%=dt.Rows[0]["charger_name"]%></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=56 style='width:42pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
