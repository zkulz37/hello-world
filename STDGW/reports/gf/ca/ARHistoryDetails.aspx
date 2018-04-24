<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="AR%20History%20Details_files/filelist.xml">
<link rel=Edit-Time-Data href="AR%20History%20Details_files/editdata.mso">
<link rel=OLE-Object-Data href="AR%20History%20Details_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>OWNER</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2009-03-05T05:37:19Z</o:LastPrinted>
  <o:Created>2009-01-22T03:23:41Z</o:Created>
  <o:LastSaved>2011-07-23T01:54:37Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in 0in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font5
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
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
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
.style17
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
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
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";}
.xl27
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl28
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl34
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl55
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yyyy\;\@";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style17;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022_-\;_-\@_-";}
.xl74
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl85
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>YYYYMM</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>50</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>28</x:ActiveRow>
       <x:ActiveCol>20</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PublishObjects>
     <x:PublishObject>
      <x:Id>16850</x:Id>
      <x:DivID>gfca00030_AR History_Detail_16850</x:DivID>
      <x:SourceType>SourceSheet</x:SourceType>
      <x:HtmlType>HtmlStatic</x:HtmlType>
      <x:Location HRef="D:\WebProject\ESYS\reports\gf\ca\AR History Details.htm"/>
     </x:PublishObject>
    </x:PublishObjects>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7140</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=YYYYMM!$A$8:$AA$8</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>code131</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>code1312</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>
<%
	string SQL = "";
	string l_company_pk = "", l_tr_date_fr = "", l_tr_date_to = "" ;
	string l_tco_buspartner_pk = "", l_tr_status = "", l_tr_type = "";
	string l_tac_hgtrh_pk = "", l_voucherno = "", l_invoice_no = "";
	l_company_pk = Request["tco_company_pk"];
	l_tr_date_fr = Request["tr_date_fr"];
	l_tr_date_to = Request["tr_date_to"];
	l_tco_buspartner_pk = Request["tco_buspartner_pk"];
	l_tr_status = Request["tr_status"];
	l_tr_type = Request["tr_type"];
	l_tac_hgtrh_pk = Request["tac_hgtrh_pk"]; 
	l_voucherno = Request["voucherno"];  
	l_invoice_no = Request["invoice_no"]; 	
	// thong tin cua cong ty
    SQL
	= "select PARTNER_NAME, TAX_CODE, NVL(ADDR1, '') || NVL(ADDR2, ' ') || NVL(ADDR3, ' ') address, initcap(to_char(sysdate, 'day, month dd, yyyy')) to_day, " + 
		" to_char(to_date('" + l_tr_date_fr + "', 'yyyymmdd'), 'dd/mm/yyyy') dt_from, to_char(to_date('" + l_tr_date_to + "', 'yyyymmdd'), 'dd/mm/yyyy') dt_to " +
        "from tco_company  " +
        "where del_if = 0  " +
        "and pk = " + l_company_pk ;    
    DataTable dtComp = new DataTable ();
    dtComp = ESysLib.TableReadOpen(SQL); 
    if(dtComp.Rows.Count == 0)
    {
        Response.Write("There is not enough information to display!!!");
        Response.End();
    }
	// thong tin item chi tiet 
	if(	l_tr_status != "ALL")
	{
	 SQL
		= "select h.pk seq, c.voucherno, to_char(h.tr_date, 'dd/mm/yyyy') tr_date, " + 
	        "	   c.invoice_no inv_no, " +
			"      to_char(to_date(c.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') inv_date, " +
	        "	    c.serial_no, " +
			"   e.partner_id, e.partner_name, d.remark2, " +
	        "	   f.ac_cd accd_dr, f1.ac_cd accd_cr1, f2.ac_cd accd_cr2, i.item_code, i.uom, d.qty, " +
            "	   NVL(d.order_uprice, d.u_price) u_price, nvl(d.order_tramt, d.net_tr_amt) net_tr_amt, decode(nvl(c.order_trrate, 0), 0, c.tr_rate, c.order_trrate) tr_rate, d.net_bk_amt, decode(d.vat_rate, '01', 'none', '00', '0', d.vat_rate) vat_rate, " +
            "	   d.vat_tr_amt, d.vat_bk_amt, nvl(nvl(d.order_tramt, d.net_tr_amt), 0) + nvl(d.vat_tr_amt, 0) trans_amt, " +
	        "	   nvl(d.net_bk_amt,0) + nvl(d.vat_bk_amt, 0) books_amt, i.item_name, (select pl_cd from v_abplcenter where tac_abplcenter_pk = d.tac_abplcenter_pk) pl_cd, " +
            "      (select pl_nm from v_abplcenter where tac_abplcenter_pk = d.tac_abplcenter_pk) pl_nm " + 
	        "from tac_hgtrh h, " +
	        "	 tac_crca c, " +
	        "	 tac_crcad d, " +
	        "	 tco_buspartner e, " +
	        "	 tac_abacctcode f, " +
	        "	 tac_abacctcode f1, " +
	        "	 tac_abacctcode f2, " +
	        "	 tlg_it_item i " +
	        "	 where h.del_if = 0 " +
	        "	 and c.del_if = 0 " +
	        "	 and d.del_if = 0 " +       
			"    and i.del_if(+) = 0 " +	
	        "	 and h.tr_tablenm = 'TAC_CRCA' " +
	        "	 and h.tr_table_pk = c.pk " +
	        "	 and c.pk = d.tac_crca_pk " +
	        "	 and c.tco_buspartner_pk = e.pk(+) " +
	        "	 and c.tac_abacctcode_pk = f.pk(+) " +
	        "	 and d.tac_abacctcode_pk = f1.pk(+) " +
	        "	 and d.tac_abacctcode_pk_vat = f2.pk(+) " +
	        "	 and d.tco_item_pk = i.pk(+) " +
	        "	 and to_char(h.tr_date, 'yyyymmdd') between '" + l_tr_date_fr + "' and '" + l_tr_date_to + "' " +
	        "	 and ( c.tco_buspartner_pk = '" + l_tco_buspartner_pk + "' or '" + l_tco_buspartner_pk + "' is null)  " +
	        "	 and h.tr_status = '" + l_tr_status + "' " +
	        "	 and (c.tr_type = '" + l_tr_type + "' or '" + l_tr_type + "' = 'ALL')  " +
	 		"	 and h.pk like NVL('" + l_tac_hgtrh_pk + "', '%') " + 
        "			 and ('%' || upper(h.voucherno) || '%' like '%' || upper('" + l_voucherno + "') || '%' " +
        "			 	 or '" + l_voucherno + "' is null) " +
        "			 and ( '%' || upper(c.invoice_no) || '%' like '%' || upper('" + l_invoice_no + "') || '%' " +
        "			 			 	 or '" + l_invoice_no + "' is null ) order by c.tr_date    			  " ;			
		}
		else
		{
	 	SQL
        = "select h.pk seq, c.voucherno, to_char(h.tr_date, 'dd/mm/yyyy') tr_date, " +
            "	   c.invoice_no inv_no, " +
            "      to_char(to_date(c.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') inv_date, " +
            "	    c.serial_no, " +
            "   e.partner_id, e.partner_name, d.remark2, " +
            "	   f.ac_cd accd_dr, f1.ac_cd accd_cr1, f2.ac_cd accd_cr2, i.item_code, i.uom, d.qty, " +
            "	   NVL(d.order_uprice, d.u_price) u_price, nvl(d.order_tramt, d.net_tr_amt) net_tr_amt, decode(nvl(c.order_trrate, 0), 0, c.tr_rate, c.order_trrate) tr_rate, d.net_bk_amt, decode(d.vat_rate, '01', 'none', '00', '0', d.vat_rate) vat_rate, " +
            "	   d.vat_tr_amt, d.vat_bk_amt, nvl(nvl(d.order_tramt, d.net_tr_amt), 0) + nvl(d.vat_tr_amt, 0) trans_amt, " +
            "	   nvl(d.net_bk_amt,0) + nvl(d.vat_bk_amt, 0) books_amt, i.item_name, (select pl_cd from v_abplcenter where tac_abplcenter_pk = d.tac_abplcenter_pk) pl_cd, " +
            "      (select pl_nm from v_abplcenter where tac_abplcenter_pk = d.tac_abplcenter_pk) pl_nm " +
            "from tac_hgtrh h, " +
	        "	 tac_crca c, " +
	        "	 tac_crcad d, " +
	        "	 tco_buspartner e, " +
	        "	 tac_abacctcode f, " +
	        "	 tac_abacctcode f1, " +
	        "	 tac_abacctcode f2, " +
	        "	 tlg_it_item i " +
	        "	 where h.del_if = 0 " +
	        "	 and c.del_if = 0 " +
	        "	 and d.del_if = 0 " +       
			"    and i.del_if(+) = 0 " +	
	        "	 and h.tr_tablenm = 'TAC_CRCA' " +
	        "	 and h.tr_table_pk = c.pk " +
	        "	 and c.pk = d.tac_crca_pk " +
	        "	 and c.tco_buspartner_pk = e.pk(+) " +
	        "	 and c.tac_abacctcode_pk = f.pk(+) " +
	        "	 and d.tac_abacctcode_pk = f1.pk(+) " +
	        "	 and d.tac_abacctcode_pk_vat = f2.pk(+) " +
	        "	 and d.tco_item_pk = i.pk(+) " +
	        "	 and to_char(h.tr_date, 'yyyymmdd') between '" + l_tr_date_fr + "' and '" + l_tr_date_to + "' " +
	        "	 and ( c.tco_buspartner_pk = '" + l_tco_buspartner_pk + "' or '" + l_tco_buspartner_pk + "' is null)  " +
	        "	 and h.tr_status in ('2', '0', '4') " +
	        "	 and (c.tr_type = '" + l_tr_type + "' or '" + l_tr_type + "' = 'ALL')  " +
	 		"	 and h.pk like NVL('" + l_tac_hgtrh_pk + "', '%') " + 
        "			 and ('%' || upper(h.voucherno) || '%' like '%' || upper('" + l_voucherno + "') || '%' " +
        "			 	 or '" + l_voucherno + "' is null) " +
        "			 and ( '%' || upper(c.invoice_no) || '%' like '%' || upper('" + l_invoice_no + "') || '%' " +
        "			 			 	 or '" + l_invoice_no + "' is null ) order by c.tr_date  " ;					
		}
		DataTable dtItem = new DataTable();
        //Response.Write(SQL);
        //Response.End();
    dtItem = ESysLib.TableReadOpen(SQL); 
    if(dtItem.Rows.Count == 0)
    {
        Response.Write("There is not enough information to display!!!");
        Response.End();
    }	
	// buspartner 
	string l_buspartner_code = "", l_buspartner_name = "";
	if(l_tco_buspartner_pk != "")
	{
		SQL = "select partner_id, partner_name from tco_buspartner where del_if = 0 and pk = '" + l_tco_buspartner_pk + "'";
		DataTable dtPartner = new DataTable();
		dtPartner = ESysLib.TableReadOpen(SQL); 
		l_buspartner_code = dtPartner.Rows[0][0].ToString();
		l_buspartner_name = dtPartner.Rows[0][1].ToString();
	}
	else
	{
		l_buspartner_code = "";
		l_buspartner_name = "";
	}
	// status of Confirmed or Approved
	string ls_status = "";
	if(l_tr_status == "2")
		ls_status = "Confirmed";
	else if(l_tr_status == "0")
		ls_status = "Approved";
	// Domestic hay Oversea
	string ls_tr_type = "";
	if(l_tr_type == "DO")
	{
		ls_tr_type = "Domestic";
	}
	else if(l_tr_type == "OS")
	{
		ls_tr_type = "Oversea";
	}
	else
		ls_tr_type = "Domestic/Oversea";
%>
<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2020 style='border-collapse:
 collapse;table-layout:fixed;width:1519pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl26 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl25 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl25 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl25 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl24 width=174 style='mso-width-source:userset;mso-width-alt:6363;
 width:131pt'>
 <col class=xl24 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl27 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl27 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl27 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl28 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl28 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl28 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl27 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl28 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=62 span=231 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 colspan=3 width=165 style='height:15.0pt;mso-ignore:
  colspan;width:124pt'><%=dtComp.Rows[0][0]%></td>
  <td class=xl32 width=54 style='width:41pt'></td>
  <td class=xl32 width=55 style='width:41pt'></td>
  <td class=xl32 width=62 style='width:47pt'></td>
  <td class=xl29 width=85 style='width:64pt'></td>
  <td class=xl29 width=124 style='width:93pt'></td>
  <td class=xl29 width=120 style='width:90pt'></td>
  <td class=xl30 width=47 style='width:35pt'></td>
  <td class=xl30 width=71 style='width:53pt'></td>
  <td class=xl30 width=47 style='width:35pt'></td>
  <td class=xl29 width=74 style='width:56pt'></td>
  <td class=xl29 width=174 style='width:131pt'></td>
  <td class=xl29 width=30 style='width:23pt'></td>
  <td class=xl34 width=79 style='width:59pt'></td>
  <td class=xl34 width=62 style='width:47pt'></td>
  <td class=xl34 width=79 style='width:59pt'></td>
  <td class=xl34 width=58 style='width:44pt'></td>
  <td class=xl34 width=96 style='width:72pt'></td>
  <td class=xl29 width=51 style='width:38pt'></td>
  <td class=xl29 width=75 style='width:56pt'></td>
  <td class=xl31 width=89 style='width:67pt'></td>
  <td class=xl34 width=89 style='width:67pt'></td>
  <td class=xl34 width=110 style='width:83pt'></td>
  <td class=xl29 width=62 style='width:47pt'></td>
  <td class=xl29 width=62 style='width:47pt'></td>
 </tr>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 colspan=4 style='height:15.0pt;mso-ignore:colspan'>as
  at <%=dtComp.Rows[0][3]%></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan'>Customer:<font
  class="font9"><span style='mso-spacerun:yes'>  </span>||<span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl37 colspan=5 style='mso-ignore:colspan'>Date:<font class="font9"><span
  style='mso-spacerun:yes'>                    </span><%=dtComp.Rows[0][4].ToString()%> ~ <%=dtComp.Rows[0][5].ToString()%></font></td>
  <td class=xl24></td>
  <td class=xl36 colspan=2 style='mso-ignore:colspan'>Status:<font class="font5"><span
  style='mso-spacerun:yes'>          </span><%=ls_status%><span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl33>Origin:<font class="font5"><span
  style='mso-spacerun:yes'>          </span><%=ls_tr_type%><span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=5 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl27></td>
  <td class=xl28></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=20 style='height:15.0pt'>
  <td rowspan=2 height=58 class=xl80 style='border-bottom:.5pt solid black;
  height:43.5pt'>Seq</td>
  <td colspan=2 class=xl76 style='border-right:.5pt solid black;border-left:
  none'>Chứng từ/<font class="font10">Voucher</font></td>
  <td colspan=3 class=xl76 style='border-right:.5pt solid black;border-left:
  none'>Hóa đơn GTGT</td>
  <td colspan=2 class=xl76 style='border-right:.5pt solid black;border-left:
  none'>Khách hàng/<font class="font10">Customer</font></td>
  <td rowspan=2 class=xl86 width=120 style='border-bottom:.5pt solid black;
  width:90pt'>Diễn Giải<br>
    <font class="font10">Description</font></td>
  <td rowspan=2 class=xl86 width=47 style='border-bottom:.5pt solid black;
  width:35pt'>TK<br>
    <span style='mso-spacerun:yes'> </span>nợ</td>
  <td colspan=2 rowspan=2 class=xl94 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Tài khoản có</td>
  <td rowspan=2 class=xl86 width=74 style='border-bottom:.5pt solid black;
  width:56pt'>Code <br>
    finished good</td>
  <td rowspan=2 class=xl86 width=174 style='border-bottom:.5pt solid black;
  width:131pt'>Name of finished<br>
    good</td>
  <td rowspan=2 class=xl80 style='border-bottom:.5pt solid black'>Unit</td>
  <td rowspan=2 class=xl82 style='border-bottom:.5pt solid black'
  x:str="Quantity"><span style='mso-spacerun:yes'> </span>Quantity<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl82 style='border-bottom:.5pt solid black' x:str="Price "><span
  style='mso-spacerun:yes'> </span>Price<span
  style='mso-spacerun:yes'>  </span></td>
  <td rowspan=2 class=xl84 width=79 style='border-bottom:.5pt solid black;
  width:59pt' x:str="Amount &#10;(Trans)"><span
  style='mso-spacerun:yes'> </span>Amount <br>
    (Trans)<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl90 width=58 style='border-bottom:.5pt solid black;
  width:44pt' x:str="Exchange rate"><span
  style='mso-spacerun:yes'> </span>Exchange rate<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl74 width=96 style='border-bottom:.5pt solid black;
  width:72pt' x:str="Amount &#10;(Books"><span
  style='mso-spacerun:yes'> </span>Amount <br>
    (Books<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl76 style='border-right:.5pt solid black;border-left:
  none' x:str="VAT ">VAT<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl79 style='border-left:none' x:str="Grantotal"><span
  style='mso-spacerun:yes'> </span>Grantotal<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl74 width=62 style='border-bottom:.5pt solid black;
  width:47pt' x:str="PL Code"><span style='mso-spacerun:yes'> </span>PL
  Code<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl74 width=62 style='border-bottom:.5pt solid black;
  width:47pt' x:str="PL Name"><span style='mso-spacerun:yes'> </span>PL
  Name<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl33 height=38 style='height:28.5pt'>
  <td height=38 class=xl38 style='height:28.5pt'>Số/<font class="font10">No</font></td>
  <td class=xl38>Ngày/<font class="font10">Date</font></td>
  <td class=xl38>Số/<font class="font10">No</font></td>
  <td class=xl38>Ngày/<font class="font10">Date</font></td>
  <td class=xl39>Serial</td>
  <td class=xl39>Code</td>
  <td class=xl39>Name</td>
  <td class=xl40 width=51 style='width:38pt'>rate (%)</td>
  <td class=xl38>Trans</td>
  <td class=xl41 x:str="Books"><span
  style='mso-spacerun:yes'> </span>Books<span style='mso-spacerun:yes'> </span></td>
  <td class=xl42 style='border-top:none'>Trans</td>
  <td class=xl92 style='border-top:none' x:str="Books"><span
  style='mso-spacerun:yes'> </span>Books<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl32 height=20 style='height:15.0pt'>
  <td height=20 class=xl43 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$8:$AA$8" style='height:15.0pt'>&nbsp;</td>
  <td class=xl44 id="_x0000_s1026" x:autofilter="all">&nbsp;</td>
  <td class=xl44 id="_x0000_s1027" x:autofilter="all">&nbsp;</td>
  <td class=xl45 id="_x0000_s1028" x:autofilter="all">&nbsp;</td>
  <td class=xl46 id="_x0000_s1029" x:autofilter="all">&nbsp;</td>
  <td class=xl44 id="_x0000_s1030" x:autofilter="all">&nbsp;</td>
  <td class=xl47 id="_x0000_s1031" x:autofilter="all">&nbsp;</td>
  <td class=xl48 id="_x0000_s1032" x:autofilter="all">&nbsp;</td>
  <td class=xl45 id="_x0000_s1033" x:autofilter="all">&nbsp;</td>
  <td class=xl49 id="_x0000_s1034" x:autofilter="all">Debit</td>
  <td class=xl49 id="_x0000_s1035" x:autofilter="all">Credit</td>
  <td class=xl49 id="_x0000_s1036" x:autofilter="all">Credit</td>
  <td class=xl45 id="_x0000_s1037" x:autofilter="all">&nbsp;</td>
  <td class=xl45 id="_x0000_s1049" x:autofilter="all">&nbsp;</td>
  <td class=xl45 id="_x0000_s1038" x:autofilter="all">&nbsp;</td>
  <td class=xl50 id="_x0000_s1039" x:autofilter="all">&nbsp;</td>
  <td class=xl50 id="_x0000_s1040" x:autofilter="all">&nbsp;</td>
  <td class=xl50 id="_x0000_s1041" x:autofilter="all">&nbsp;</td>
  <td class=xl51 id="_x0000_s1042" x:autofilter="all">&nbsp;</td>
  <td class=xl51 id="_x0000_s1043" x:autofilter="all">&nbsp;</td>
  <td class=xl45 id="_x0000_s1044" x:autofilter="all">&nbsp;</td>
  <td class=xl44 id="_x0000_s1045" x:autofilter="all">&nbsp;</td>
  <td class=xl52 id="_x0000_s1046" x:autofilter="all">&nbsp;</td>
  <td class=xl53 id="_x0000_s1048" x:autofilter="all">&nbsp;</td>
  <td class=xl93 id="_x0000_s1047" x:autofilter="all">&nbsp;</td>
  <td class=xl93 id="_x0000_s1050" x:autofilter="all">&nbsp;</td>
  <td class=xl93 id="_x0000_s1051" x:autofilter="all">&nbsp;</td>
 </tr>
  <%
	int i ;
	// tong cong
	decimal l_sum_qty = 0, l_sum_trans_amt = 0, l_sum_book_amt = 0 ;
	decimal l_vat_trans_amt = 0, l_vat_book_amt = 0, l_grand_trans_amt = 0, l_grand_book_amt = 0;
    for (i = 0; i < dtItem.Rows.Count; i++)
    {
        if (dtItem.Rows[i][14].ToString().Trim() != "")
            l_sum_qty += decimal.Parse(dtItem.Rows[i][14].ToString());
        if (dtItem.Rows[i][16].ToString().Trim() != "")
            l_sum_trans_amt += decimal.Parse(dtItem.Rows[i][16].ToString());
        if (dtItem.Rows[i][18].ToString().Trim() != "")
            l_sum_book_amt += decimal.Parse(dtItem.Rows[i][18].ToString());
        if (dtItem.Rows[i][20].ToString().Trim() != "")
            l_vat_trans_amt += decimal.Parse(dtItem.Rows[i][20].ToString());
        if (dtItem.Rows[i][21].ToString().Trim() != "")
            l_vat_book_amt += decimal.Parse(dtItem.Rows[i][21].ToString());
        if (dtItem.Rows[i][22].ToString().Trim() != "")
            l_grand_trans_amt += decimal.Parse(dtItem.Rows[i][22].ToString());
        if (dtItem.Rows[i][23].ToString().Trim() != "")
            l_grand_book_amt += decimal.Parse(dtItem.Rows[i][23].ToString());			
 %>

 <tr class=xl54 height=40 style='height:30.0pt'>
  <td height=40 class=xl55 align=right style='height:30.0pt' x:num><%=dtItem.Rows[i][0]%></td>
  <td class=xl56><%=dtItem.Rows[i][1]%> </td>
  <td class=xl57><%=dtItem.Rows[i][2]%></td>
  <td class=xl57><%=dtItem.Rows[i][3]%></td>
  <td class=xl57><%=dtItem.Rows[i][4]%></td>
  <td class=xl58><%=dtItem.Rows[i][5]%></td>
  <td class=xl58><%=dtItem.Rows[i][6]%></td>
  <td class=xl58><%=dtItem.Rows[i][7]%></td>
  <td class=xl58><%=dtItem.Rows[i][8]%></td>
  <td class=xl57 x:str><%=dtItem.Rows[i][9]%></td>
  <td class=xl57 x:str><%=dtItem.Rows[i][10]%></td>
  <td class=xl57><%=dtItem.Rows[i][11]%></td>
  <td class=xl58><%=dtItem.Rows[i][12]%></td>
  <td class=xl89 width=174 style='width:131pt'><%=dtItem.Rows[i][24]%></td>
  <td class=xl58><%=dtItem.Rows[i][13]%></td>
  <td class=xl59 align=right x:num><%=dtItem.Rows[i][14]%></td>
  <td class=xl59 align=right x:num><%=dtItem.Rows[i][15]%></td>
  <td class=xl60 x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][16]%> </td>
  <td class=xl61 align=right x:num><%=dtItem.Rows[i][17]%></td>
  <td class=xl61 align=right x:num><%=dtItem.Rows[i][18]%></td>
  <td class=xl62><%=dtItem.Rows[i][19]%></td>
  <td class=xl59 align=right x:num><%=dtItem.Rows[i][20]%></td>
  <td class=xl63 x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][21]%> </td>
  <td class=xl60 x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][22]%> </td>
  <td class=xl63 x:num><span
  style='mso-spacerun:yes'> </span><%=dtItem.Rows[i][23]%> </td>
  <td class=xl97 style='border-left:none'><%=dtItem.Rows[i][25]%></td>
  <td class=xl97 style='border-left:none'><%=dtItem.Rows[i][26]%></td>
 </tr>
 <% 
      }
 %>
 <tr class=xl32 height=19 style='height:14.25pt'>
  <td height=19 class=xl64 style='height:14.25pt'>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl65 x:str="TOTAL ">TOTAL<span style='mso-spacerun:yes'> </span></td>
  <td class=xl65>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl68 align=right x:num><%=l_sum_qty%></td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69 x:num><span
  style='mso-spacerun:yes'> </span><%=l_sum_trans_amt%>  </td>
  <td class=xl70>&nbsp;</td>
  <td class=xl70 align=right x:num><%=l_sum_book_amt%></td>
  <td class=xl65>&nbsp;</td>
  <td class=xl71 align=right x:num><%=l_vat_trans_amt%></td>
  <td class=xl72 x:num><span
  style='mso-spacerun:yes'> </span><%=l_vat_book_amt%> </td>
  <td class=xl69 x:num><span
  style='mso-spacerun:yes'> </span><%=l_grand_trans_amt%> </td>
  <td class=xl72 x:num><span
  style='mso-spacerun:yes'> </span><%=l_grand_book_amt%> </td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl27></td>
  <td class=xl28></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl27></td>
  <td class=xl28></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=62 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
