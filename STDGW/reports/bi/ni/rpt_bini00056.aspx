﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string master_pk = Request.QueryString["master_pk"];
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM  tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM  tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    DataTable dt = ESysLib.TableReadOpen(str_sql);
    
    DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_bini00050", "'" + master_pk + "'");    
    DataTable dt2 = ESysLib.TableReadOpenCursor("lg_rpt_bini00050_1", "'" + master_pk + "'");       
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bini00056_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bini00056_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bini00056_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VNG</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2012-03-15T09:03:15Z</o:LastPrinted>
  <o:Created>2011-11-15T06:42:07Z</o:Created>
  <o:LastSaved>2012-03-15T09:05:58Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.31in .24in .2in .28in;
	mso-header-margin:.16in;
	mso-footer-margin:.39in;}
.font6
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
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
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style21
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
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl25
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl59
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style21;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl74
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>OUTGOING SLIP</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>89</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='OUTGOING SLIP'!$9:$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3084"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="3"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=810 style='border-collapse:
 collapse;table-layout:fixed;width:611pt'>
 <col class=xl25 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl25 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl25 width=230 style='mso-width-source:userset;mso-width-alt:8411;
 width:173pt'>
 <col class=xl25 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl25 width=70 span=3 style='mso-width-source:userset;mso-width-alt:
 2560;width:53pt'>
 <col class=xl25 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl25 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 width=30 style='height:15.0pt;width:23pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><![endif]--><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl27 width=30 style='height:15.0pt;width:23pt'><v:shape id="_x0000_s3073" type="#_x0000_t75" style='position:absolute;
   direction:LTR;text-align:left;margin-left:5pt;margin-top:1pt;width:70.5pt;
   height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape></td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 width=90 style='width:68pt'></td>
  <td colspan=5 class=xl52 width=485 style='width:366pt'><%=dt.Rows[0]["partner_name"]%></td>
  <td class=xl26 width=90 style='width:68pt'></td>
  <td class=xl28 width=115 style='width:86pt'>Tel: <%=dt.Rows[0]["phone_no"]%></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl53 width=485 style='width:366pt'><%=dt.Rows[0]["addr1"]%></td>
  <td class=xl29></td>
  <td class=xl28>Fax: <%=dt.Rows[0]["fax_no"]%></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td colspan=5 class=xl54>Tax No: <%=dt.Rows[0]["tax_code"]%></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>Print Date: <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
 </tr>
 <tr class=xl32 height=65 style='mso-height-source:userset;height:48.75pt'>
  <td colspan=9 height=65 class=xl55 style='height:48.75pt'>PHI&#7870;U
  XU&#7844;T KHO<font class="font10"> </font><font class="font11">(OUTGOING
  SLIP)</font></td>
 </tr>
 <tr class=xl32 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=9 height=30 class=xl56 style='height:22.5pt'>Slip No :<font
  class="font12"> <%=dt1.Rows[0]["slip_no"] %> </font><font class="font6">Date :</font><font
  class="font12"> </font><font class="font13"><%=dt1.Rows[0]["dd"] %>/<%=dt1.Rows[0]["mm"] %>/<%=dt1.Rows[0]["yyyy"] %></font></td>
 </tr>
 <tr class=xl32 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl57 width=120 style='height:22.5pt;width:91pt'>Xu&#7845;t
  cho <font class="font9">Outgo To</font></td>
  <td colspan=2 class=xl58><%=dt1.Rows[0]["supplier_name"] %></td>
  <td colspan=2 class=xl59>Kho<font class="font9"> Out WH</font></td>
  <td colspan=3 class=xl60><%=dt1.Rows[0]["wh_name"] %></td>
 </tr>
 <tr class=xl32 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl57 width=120 style='height:22.5pt;width:91pt'>Người nhận <font class="font9">Receiver</font></td>
  <td colspan=2 class=xl61><%=dt1.Rows[0]["receiver"]%></td>
  <td colspan=2 class=xl59>S&#7889; P/O <font class="font9">PO No</font></td>
  <td colspan=3 class=xl60><%=dt1.Rows[0]["ref_no"] %></td>
 </tr>
  <tr class=xl32 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl57 width=120 style='height:22.5pt;width:91pt'>Di&#7877;n
  gi&#7843;i <font class="font9">Remark</font></td>
  <td colspan=7 class=xl61><%=dt1.Rows[0]["description"] %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=59 class=xl62 width=30 style='border-bottom:.5pt solid black;
  height:44.25pt;width:23pt'>TT<br>
    <font class="font9">No</font></td>
  <td rowspan=2 class=xl64 width=90 style='border-bottom:.5pt solid black;
  width:68pt'>Mã hàng<br>
    <font class="font9">Item Code</font></td>
  <td rowspan=2 class=xl64 width=230 style='border-bottom:.5pt solid black;
  width:173pt'>Tên hàng<br>
    <font class="font9">Item Description</font></td>
  <td rowspan=2 class=xl64 width=45 style='border-bottom:.5pt solid black;
  width:34pt'>&#272;VT<br>
    <font class="font9">Unit</font></td>
  <td colspan=2 class=xl66 width=140 style='border-right:.5pt hairline black;
  border-left:none;width:106pt'>S&#7889; l&#432;&#7907;ng<font class="font9">
  Quantity</font></td>
  <td rowspan=2 class=xl64 width=70 style='border-bottom:.5pt solid black;
  width:53pt'>&#272;&#417;n giá<br>
    <font class="font9">Unit Price</font></td>
  <td rowspan=2 class=xl64 width=90 style='border-bottom:.5pt solid black;
  width:68pt'>Thành ti&#7873;n VND<br>
    <font class="font9">Amount</font></td>
  <td rowspan=2 class=xl68 width=115 style='border-bottom:.5pt solid black;
  width:86pt'>Ghi chú<br>
    <font class="font9">Remark</font></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl34 width=70 style='height:26.25pt;width:53pt'>Ch&#7913;ng
  t&#7915;<br>
    <font class="font9">Req</font></td>
  <td class=xl34 width=70 style='width:53pt'>Th&#7921;c xu&#7845;t<br>
    <font class="font9">Actual</font></td>
 </tr>
   <%
     double total1 = 0, total2 = 0, total3 = 0, total4 = 0, total5 = 0;
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
         total1 = total1 + CommondLib.ConvertToDbl(dt2.Rows[i]["req_qty"]);
         total2 = total2 + CommondLib.ConvertToDbl(dt2.Rows[i]["out_qty"]);
         total3 = total3 + CommondLib.ConvertToDbl(dt2.Rows[i]["item_amount"]);
         total4 = total4 + CommondLib.ConvertToDbl(dt2.Rows[i]["vat_amount"]);
         total5 = total5 + CommondLib.ConvertToDbl(dt2.Rows[i]["total_amount"]);
         
         %>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl35 width=30 style='height:26.25pt;width:23pt' x:num><%=i+1 %></td>
  <td class=xl37 width=90 style='width:68pt' x:num><%=dt2.Rows[i]["item_code"]%></td>
  <td class=xl38 width=230 style='width:173pt'><%=dt2.Rows[i]["item_name"]%></td>
  <td class=xl39 width=45 style='width:34pt'><%=dt2.Rows[i]["out_uom"]%></td>
  <td class=xl40 width=70 style='width:53pt' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt2.Rows[i]["req_qty"]%></td>
  <td class=xl41 width=70 style='width:53pt' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt2.Rows[i]["out_qty"]%></td>
  <td class=xl40 width=70 style='width:53pt' x:num><span
  style='mso-spacerun:yes'>           </span><%=dt2.Rows[i]["unit_price"]%></td>
  <td class=xl40 width=90 style='width:68pt' x:num><span
  style='mso-spacerun:yes'>      </span><%=dt2.Rows[i]["item_amount"]%></td>
  <td class=xl42 width=115 style='width:86pt'><%=dt2.Rows[i]["description"]%></td>
 </tr>
          <% 
     }
  %>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=3 rowspan=3 height=105 class=xl70 style='border-bottom:.5pt solid black;
  height:78.75pt'>&nbsp;</td>
  <td colspan=3 class=xl76>Thành ti&#7873;n<font class="font6"> </font><font
  class="font9">Item Amount</font></td>
  <td colspan=2 class=xl77 x:num><span
  style='mso-spacerun:yes'>                            </span><%= total3 %></td>
  <td class=xl50>VND</td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=3 height=35 class=xl78 style='height:26.25pt'>Thu&#7871;<font
  class="font6"> </font><font class="font9">Tax</font></td>
  <td colspan=2 class=xl79 x:num><span
  style='mso-spacerun:yes'>                            </span><%= total4 %></td>
  <td class=xl50>VND</td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=3 height=35 class=xl80 style='height:26.25pt'>T&#7893;ng
  ti&#7873;n<font class="font6"> </font><font class="font9">Total Amount</font></td>
  <td colspan=2 class=xl81 x:num><span
  style='mso-spacerun:yes'>                            </span><%= total5 %></td>
  <td class=xl51>VND</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s3083"
   type="#_x0000_t75" style='position:absolute;margin-left:124.5pt;
   margin-top:9.75pt;width:364.5pt;height:102pt;z-index:2'>
   <v:imagedata src="rpt_bini00056_files/image003.gif" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:166px;margin-top:13px;width:486px;
  height:136px'><img width=486 height=136 src="rpt_bini00056_files/image003.gif"
  v:shapes="_x0000_s3083"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl25 width=230 style='height:12.75pt;width:173pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=230 style='width:173pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=115 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
