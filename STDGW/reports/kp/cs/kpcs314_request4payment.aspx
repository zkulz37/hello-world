<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("ec111");
	Response.ContentType = "application/vnd.ms-excel";
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
<link rel=File-List href="kpcs314_request4payment_files/filelist.xml">
<link rel=Edit-Time-Data href="kpcs314_request4payment_files/editdata.mso">
<link rel=OLE-Object-Data href="kpcs314_request4payment_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Daeyou</o:Author>
  <o:LastAuthor>ISA_SERVER</o:LastAuthor>
  <o:LastPrinted>2011-04-13T09:39:14Z</o:LastPrinted>
  <o:Created>2009-10-14T09:29:25Z</o:Created>
  <o:LastSaved>2011-04-29T03:52:59Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .38in .5in .56in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font25
	{color:blue;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font26
	{color:blue;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style58
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	color:windowtext;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	color:#333333;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl67
	{mso-style-parent:style0;
	color:#333333;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl68
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl70
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	color:#333333;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl76
	{mso-style-parent:style43;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	color:#333333;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl80
	{mso-style-parent:style43;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl83
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl84
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl85
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl86
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl87
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl93
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(\0022$\0022* \#\,\#\#0\.00_\)\;_\(\0022$\0022* \\\(\#\,\#\#0\.00\\\)\;_\(\0022$\0022* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl105
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	vertical-align:middle;}
.xl109
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl110
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl114
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl116
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl118
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;}
.xl119
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	color:windowtext;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl121
	{mso-style-parent:style43;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl122
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl125
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl126
	{mso-style-parent:style43;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl127
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl128
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0000";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl132
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl133
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(\0022$\0022* \#\,\#\#0\.00_\)\;_\(\0022$\0022* \\\(\#\,\#\#0\.00\\\)\;_\(\0022$\0022* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl134
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl135
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl136
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl137
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl138
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;}
.xl139
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl140
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl141
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl142
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl143
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl144
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl145
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl146
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl147
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl148
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl149
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl150
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl151
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl152
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl153
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl154
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl155
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl156
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl157
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl158
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl159
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl160
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl161
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl162
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl163
	{mso-style-parent:style58;
	color:red;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl164
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl165
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl166
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl167
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl168
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl169
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl170
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl171
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl172
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl173
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl174
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl175
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl176
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl177
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl178
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl179
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl180
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl181
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl182
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl183
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl184
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl185
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl186
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl187
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl188
	{mso-style-parent:style0;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl189
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl190
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl191
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl192
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(\0022$\0022* \#\,\#\#0\.00_\)\;_\(\0022$\0022* \\\(\#\,\#\#0\.00\\\)\;_\(\0022$\0022* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl193
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(\0022$\0022* \#\,\#\#0\.00_\)\;_\(\0022$\0022* \\\(\#\,\#\#0\.00\\\)\;_\(\0022$\0022* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl194
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl195
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl196
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl197
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl198
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl199
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl200
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl201
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl202
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl203
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl204
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl205
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl206
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl207
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl208
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl209
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;}
.xl210
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl211
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl212
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl213
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl214
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl215
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl216
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl217
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl218
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl219
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl220
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl221
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl222
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl223
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl224
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl225
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl226
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl227
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl228
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl229
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl230
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;}
.xl231
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl232
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl233
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl234
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl235
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl236
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;}
.xl237
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl238
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl239
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl240
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl241
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl242
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl243
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl244
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl245
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl246
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ d\\\,\\ yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl247
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl248
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl249
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl250
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl251
	{mso-style-parent:style43;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl252
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;}
.xl253
	{mso-style-parent:style0;
	color:blue;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl254
	{mso-style-parent:style0;
	color:blue;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl255
	{mso-style-parent:style0;
	color:blue;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl256
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl257
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl258
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl259
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl260
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl261
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl262
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl263
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.5pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl264
	{mso-style-parent:style0;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl265
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl266
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>1st</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>13</x:TabColorIndex>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9540</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='1st'!$A$1:$L$49</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1167 style='border-collapse:
 collapse;table-layout:fixed;width:876pt'>
 <col class=xl66 width=34 style='mso-width-source:userset;mso-width-alt:1088;
 width:26pt'>
 <col class=xl66 width=118 style='mso-width-source:userset;mso-width-alt:3776;
 width:89pt'>
 <col class=xl66 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:800'>
 <col class=xl66 width=99 style='mso-width-source:userset;mso-width-alt:3168;
 width:74pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3296;
 width:77pt'>
 <col class=xl66 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1760'>
 <col class=xl66 width=101 style='mso-width-source:userset;mso-width-alt:3232;
 width:76pt'>
 <col class=xl66 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1504'>
 <col class=xl66 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:480'>
 <col class=xl66 width=93 style='mso-width-source:userset;mso-width-alt:2976;
 width:70pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3296;
 width:77pt'>
 <col class=xl66 width=96 style='mso-width-source:userset;mso-width-alt:3072;
 width:72pt'>
 <col class=xl66 width=73 style='mso-width-source:userset;mso-width-alt:2336;
 width:55pt'>
 <col class=xl66 width=143 style='mso-width-source:userset;mso-width-alt:4576;
 width:107pt'>
 <col class=xl66 width=73 style='mso-width-source:userset;mso-width-alt:2336;
 width:55pt'>
 <col class=xl66 width=131 style='mso-width-source:userset;mso-width-alt:4192;
 width:98pt'>
 <col class=xl66 width=73 span=240 style='mso-width-source:userset;mso-width-alt:
 2336;width:55pt'>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=5 rowspan=3 height=61 width=354 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:45.75pt;width:266pt' align=left
  valign=top><!--[if gte vml 1]><v:rect id="HideTemplatePointer" o:spid="_x0000_s1187"
   style='position:absolute;margin-left:0;margin-top:0;width:12.75pt;height:2.25pt;
   z-index:1;visibility:visible' stroked="f" strokeweight="3e-5mm">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:SizeWithCells/>
    <x:PrintObject>False</x:PrintObject>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:0px;margin-top:0px;width:17px;height:3px'><img
  width=17 height=3 src="kpcs314_request4payment_files/image001.gif" v:shapes="HideTemplatePointer"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=5 rowspan=3 height=61 class=xl226 width=354 style='border-right:
    .5pt solid black;border-bottom:.5pt solid black;height:45.75pt;width:266pt'><a
    name="Print_Area">PROPOSAL SHEET</a></td>
   </tr>
  </table>
  </span></td>
  <td class=xl105 width=0 style='border-left:none'>Document No. :</td>
  <td rowspan=3 class=xl235 width=101 style='border-bottom:.5pt solid black;
  width:76pt'>Doc. No.</td>
  <td class=xl106 width=0>&nbsp;</td>
  <td class=xl106 width=0>&nbsp;</td>
  <td colspan=2 rowspan=3 class=xl238 width=196 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:147pt'>March 01st, 2011</td>
  <td class=xl191 width=96 style='border-left:none;width:72pt'>□ Routine</td>
  <td class=xl66 width=73 style='width:55pt'></td>
  <td class=xl66 width=143 style='width:107pt'></td>
  <td class=xl66 width=73 style='width:55pt'></td>
  <td class=xl66 width=131 style='width:98pt'></td>
 </tr>
 <tr class=xl67 height=20 style='height:15.0pt'>
  <td height=20 class=xl107 style='height:15.0pt;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl108 style='mso-ignore:colspan'></td>
  <td class=xl111 style='border-left:none'><span
  style='mso-spacerun:yes'> </span>□<span style='mso-spacerun:yes'> 
  </span>Urgent</td>
  <td colspan=4 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=20 style='height:15.0pt'>
  <td height=20 class=xl109 style='height:15.0pt;border-left:none'>&nbsp;</td>
  <td class=xl110>&nbsp;</td>
  <td class=xl110>&nbsp;</td>
  <td class=xl112 style='border-left:none'><span
  style='mso-spacerun:yes'> </span>□<span style='mso-spacerun:yes'> 
  </span>Confidential</td>
  <td colspan=4 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td colspan=3 height=42 class=xl216 width=152 style='border-right:.5pt solid black;
  height:31.5pt;width:115pt'>&nbsp;</td>
  <td colspan=3 class=xl244 style='border-right:.5pt solid black;border-left:
  none'>Checked by</td>
  <td colspan=4 class=xl247 style='border-left:none'>Reviewed by</td>
  <td colspan=2 class=xl222 style='border-right:.5pt solid black'>Approved by</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='height:15.0pt'>
  <td colspan=3 rowspan=8 height=144 class=xl210 width=152 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:108.0pt;width:115pt'>Signature</td>
  <td colspan=3 rowspan=8 class=xl210 width=202 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:151pt'>&nbsp;</td>
  <td class=xl82 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl83 style='border-top:none'>&nbsp;</td>
  <td class=xl83 style='border-top:none'>&nbsp;</td>
  <td class=xl83 style='border-top:none'>&nbsp;</td>
  <td colspan=2 rowspan=8 class=xl208 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='height:15.0pt'>
  <td height=20 class=xl84 style='height:15.0pt;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='height:15.0pt'>
  <td height=20 class=xl84 style='height:15.0pt;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85><span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='height:15.0pt'>
  <td height=20 class=xl84 style='height:15.0pt;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl84 style='height:10.5pt;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='height:15.0pt'>
  <td height=20 class=xl84 style='height:15.0pt;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='height:15.0pt'>
  <td height=20 class=xl84 style='height:15.0pt;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl86 style='height:7.5pt;border-left:none'>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=3 height=33 class=xl224 width=152 style='border-right:.5pt solid black;
  height:24.75pt;width:115pt'>&nbsp;</td>
  <td colspan=3 class=xl224 width=202 style='border-right:.5pt solid black;
  border-left:none;width:151pt'>Mr. Tran Quoc Viet</td>
  <td colspan=4 class=xl224 width=194 style='border-left:none;width:146pt'>Mr.
  Kim Hee Jung</td>
  <td colspan=2 class=xl250 style='border-right:.5pt solid black'>Mr. Cho Han Un</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=12 height=33 class=xl205 width=747 style='border-right:.5pt solid black;
  height:24.75pt;width:561pt'>Subject: Request of 1st progress payment for …….
  Co., Ltd.</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=9 height=20 class=xl122 width=455 style='height:15.0pt;
  width:342pt'><span style='mso-spacerun:yes'>      </span>I would like to
  propose the payment to B.O.D as follows:</td>
  <td colspan=2 class=xl88 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl119 width=96 style='width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl120 style='height:15.0pt'>&nbsp;</td>
  <td colspan=4 class=xl209>1/ Project summmany</td>
  <td class=xl115>&nbsp;</td>
  <td colspan=3 class=xl115 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl121>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl122 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td colspan=3 class=xl88 width=217 style='width:163pt' x:str="Project Name: ">Project
  Name:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl88 width=204 style='width:153pt'>CHARM PLAZA</td>
  <td colspan=2 class=xl90 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl90 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl123 width=96 style='width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl122 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td colspan=3 class=xl88 width=217 style='width:163pt' x:str="Project Code: ">Project
  Code:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl90 width=103 style='width:77pt'>CT0234</td>
  <td colspan=7 class=xl88 width=393 style='border-right:.5pt solid black;
  width:295pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl122 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td colspan=3 class=xl88 width=217 style='width:163pt'
  x:str="Project Period: ">Project Period:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=8 class=xl88 width=496 style='border-right:.5pt solid black;
  width:372pt'>1 Oct 2010 ~ 30 Nov 2012</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl89></td>
  <td class=xl65></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl122 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td colspan=3 class=xl256 width=217 style='width:163pt'>2/ Contents</td>
  <td colspan=8 class=xl253 width=496 style='border-right:.5pt solid black;
  width:372pt'>Request of 1st progress payment for ……... Co., Ltd.</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl122 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td class=xl92 x:str="Subcontractor: ">Subcontractor:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl93></td>
  <td class=xl91></td>
  <td class=xl200>……... Co., Ltd.</td>
  <td class=xl91></td>
  <td colspan=5 class=xl91 style='mso-ignore:colspan'></td>
  <td class=xl184>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl122 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td class=xl95>Contract No.:</td>
  <td class=xl95>&nbsp;</td>
  <td class=xl89></td>
  <td colspan=3 class=xl252>2011-………….</td>
  <td colspan=2 class=xl89 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td class=xl94></td>
  <td class=xl124>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl125 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td class=xl95>Scope of work</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl89></td>
  <td class=xl200>Water work</td>
  <td class=xl91></td>
  <td colspan=4 class=xl91 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl125 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td colspan=3 class=xl92>Contract Period:</td>
  <td colspan=7 class=xl258>10 Mar 2011 <font class="font26">~ 29</font><font
  class="font25"> Feb 2012</font></td>
  <td class=xl126>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl125 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td class=xl92>Contrac Value</td>
  <td class=xl96>&nbsp;</td>
  <td class=xl89></td>
  <td colspan=7 class=xl255>3,400,349,036 VND (Excluding 10%VAT)</td>
  <td class=xl126>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl125 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl96>&nbsp;</td>
  <td class=xl89></td>
  <td class=xl117>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl185 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl201 width=34 style='height:29.25pt;width:26pt'>No</td>
  <td class=xl199 width=118 style='width:89pt'>Description</td>
  <td class=xl199 width=0>&nbsp;</td>
  <td class=xl201 width=99 style='width:74pt'>Value Work Done Status</td>
  <td class=xl202 width=103 style='border-top:none;border-left:none;width:77pt'>Previous
  Payment</td>
  <td class=xl202 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl203 width=101 style='border-top:none;width:76pt'>This Month</td>
  <td colspan=3 class=xl202 width=93 style='border-right:.5pt solid black;
  border-left:none;width:70pt'>Acc. Amount</td>
  <td class=xl204 width=103 style='border-top:none;width:77pt'>Balance</td>
  <td class=xl203 width=96 style='border-left:none;width:72pt'>Remarks</td>
  <td colspan=4 class=xl185 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl148 width=34 style='height:15.0pt;border-top:none;
  width:26pt' x:num>1</td>
  <td class=xl141 width=118 style='border-top:none;width:89pt'>Net Amount</td>
  <td class=xl97 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl144 width=99 style='border-top:none;width:74pt' x:num="3400349036">3,400,349,036</td>
  <td class=xl144 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num>0</td>
  <td colspan=2 class=xl262 width=101 style='border-right:.5pt solid black;
  border-left:none;width:76pt' x:num="64754919.723000005"
  x:fmla="=102788.85*629.98">64,754,920</td>
  <td class=xl145 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl145 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl146 align=right width=93 style='border-top:none;border-left:none;
  width:70pt' x:num="64754919.723000005" x:fmla="=E28+F28">64,754,920</td>
  <td class=xl144 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num="3335594116.277" x:fmla="=D28-J28">3,335,594,116</td>
  <td class=xl81 width=96 style='border-top:none;border-left:none;width:72pt'>Excl.VAT</td>
  <td class=xl65></td>
  <td class=xl138></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl264 width=34 style='border-bottom:.5pt solid black;
  height:30.0pt;border-top:none;width:26pt'>&nbsp;</td>
  <td class=xl149 width=118 style='border-top:none;border-left:none;width:89pt'>VAT
  10%</td>
  <td class=xl150 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl151 width=99 style='border-top:none;width:74pt'
  x:num="340034903.60000002" x:fmla="=D28*10%">340,034,904</td>
  <td class=xl152 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num x:fmla="=E28*10%">0</td>
  <td class=xl152 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl152 width=101 style='border-top:none;border-left:none;width:76pt'
  x:num="6475492" x:fmla="=ROUND(F28*10%,0)">6,475,492</td>
  <td class=xl153 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl153 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl154 align=right width=93 style='border-top:none;border-left:none;
  width:70pt' x:num="6475492" x:fmla="=E29+G29">6,475,492</td>
  <td class=xl152 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num="333559411.60000002" x:fmla="=D29-J29">333,559,412</td>
  <td class=xl155 width=96 style='border-top:none;border-left:none;width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl156 width=118 style='height:15.0pt;border-top:none;
  border-left:none;width:89pt'>Total Workdone</td>
  <td class=xl157 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl158 width=99 style='border-top:none;width:74pt'
  x:num="3740383939.5999999" x:fmla="=D28+D29">3,740,383,940</td>
  <td class=xl158 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num x:fmla="=E28+E29">0</td>
  <td class=xl158 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl186 width=101 style='border-top:none;border-left:none;width:76pt'
  x:num="71230411.723000005" x:fmla="=F28+G29">71,230,412</td>
  <td class=xl189 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl189 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl190 align=right width=93 style='border-top:none;border-left:none;
  width:70pt' x:num="71230411.723000005" x:fmla="=E30+G30">71,230,412</td>
  <td class=xl159 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num="3669153527.8769999" x:fmla="=D30-J30">3,669,153,528</td>
  <td class=xl160 width=96 style='border-top:none;border-left:none;width:72pt'>Incl.VAT</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl148 width=34 style='height:15.0pt;border-top:none;
  width:26pt' x:num>2</td>
  <td class=xl142 width=118 style='border-top:none;width:89pt'>Advance (10%)</td>
  <td class=xl77 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl144 width=99 style='border-top:none;border-left:none;width:74pt'
  x:num="340034903.60000002" x:fmla="=D28*10%">340,034,904</td>
  <td class=xl144 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num="340034903.60000002" x:fmla="=D28*10%">340,034,904</td>
  <td class=xl144 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl144 width=101 style='border-top:none;border-left:none;width:76pt'>&nbsp;</td>
  <td class=xl145 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl145 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl146 align=right width=93 style='border-top:none;border-left:none;
  width:70pt' x:num="340034903.60000002" x:fmla="=E31+G31">340,034,904</td>
  <td class=xl144 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num x:fmla="=D31-J31">0</td>
  <td class=xl81 width=96 style='border-top:none;border-left:none;width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl173 width=34 style='height:15.0pt;width:26pt' x:num>3</td>
  <td class=xl183 width=118 style='width:89pt'>Retention (5%)</td>
  <td class=xl175 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl180 width=99 style='border-left:none;width:74pt'
  x:num="170017451.80000001" x:fmla="=D28*5%">170,017,452</td>
  <td class=xl181 width=103 style='border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl181 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl181 width=101 style='border-left:none;width:76pt'>&nbsp;</td>
  <td class=xl181 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl181 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl182 width=93 style='border-left:none;width:70pt'>&nbsp;</td>
  <td class=xl180 width=103 style='border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl177 width=96 style='border-left:none;width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl173 width=34 style='height:15.0pt;width:26pt' x:num>4</td>
  <td class=xl179 width=118 style='width:89pt'>Deducting</td>
  <td class=xl175 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl180 width=99 style='border-left:none;width:74pt'>&nbsp;</td>
  <td class=xl181 width=103 style='border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl181 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl180 width=101 style='border-left:none;width:76pt'>&nbsp;</td>
  <td class=xl181 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl181 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl182 width=93 style='border-left:none;width:70pt'>&nbsp;</td>
  <td class=xl180 width=103 style='border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl177 width=96 style='border-left:none;width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl166 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td class=xl167 width=118 style='width:89pt' x:str="Advance ">Advance<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl168 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl169 width=99 style='border-left:none;width:74pt'
  x:num="340034903.60000002" x:fmla="=D31">340,034,904</td>
  <td class=xl169 width=103 style='border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl170 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl169 width=101 style='border-left:none;width:76pt'
  x:num="6475491.9723000005" x:fmla="=F28*10%">6,475,492</td>
  <td class=xl169 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl169 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl171 align=right width=93 style='border-left:none;width:70pt'
  x:num="6475491.9723000005" x:fmla="=E34+G34">6,475,492</td>
  <td class=xl169 width=103 style='border-left:none;width:77pt'
  x:num="333559411.62770003" x:fmla="=D34-J34">333,559,412</td>
  <td class=xl172 width=96 style='border-left:none;width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl164 width=34 style='height:15.0pt;border-top:none;
  width:26pt'>&nbsp;</td>
  <td class=xl178 width=118 style='border-top:none;width:89pt'>Retention (5%)</td>
  <td class=xl165 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl159 width=99 style='border-top:none;border-left:none;width:74pt'
  x:num="170017451.80000001" x:fmla="=D32">170,017,452</td>
  <td class=xl159 width=103 style='border-top:none;border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl159 width=0 style='border-top:none;border-left:none' x:num
  x:fmla="=F33+F34">0</td>
  <td class=xl159 width=101 style='border-top:none;border-left:none;width:76pt'
  x:num="3237745.9861500002" x:fmla="=F28*5%">3,237,746</td>
  <td class=xl159 width=0 style='border-top:none;border-left:none' x:num
  x:fmla="=H33+H34">0</td>
  <td class=xl159 width=0 style='border-top:none;border-left:none' x:num
  x:fmla="=I33+I34">0</td>
  <td class=xl159 width=93 style='border-top:none;border-left:none;width:70pt'
  x:num="3237745.9861500002" x:fmla="=E35+G35">3,237,746</td>
  <td class=xl159 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num="166779705.81385002" x:fmla="=D35-J35">166,779,706</td>
  <td class=xl160 width=96 style='border-top:none;border-left:none;width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl173 width=34 style='height:15.0pt;width:26pt'>&nbsp;</td>
  <td class=xl174 width=118 style='width:89pt'>Total Deduct</td>
  <td class=xl175 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl176 width=99 style='border-left:none;width:74pt'
  x:num="510052355.40000004" x:fmla="=D34+D35">510,052,355</td>
  <td class=xl176 width=103 style='border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl176 width=0 style='border-left:none' x:num x:fmla="=F34+F35">0</td>
  <td class=xl176 width=101 style='border-left:none;width:76pt'
  x:num="9713237.9584500007" x:fmla="=SUM(G33:G35)">9,713,238</td>
  <td class=xl176 width=0 style='border-left:none' x:num x:fmla="=H34+H35">0</td>
  <td class=xl176 width=0 style='border-left:none' x:num x:fmla="=I34+I35">0</td>
  <td class=xl176 width=93 style='border-left:none;width:70pt'
  x:num="9713237.9584500007" x:fmla="=J34+J35">9,713,238</td>
  <td class=xl176 width=103 style='border-left:none;width:77pt'
  x:num="500339117.44155002" x:fmla="=D36-J36">500,339,117</td>
  <td class=xl177 width=96 style='border-left:none;width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl143 width=34 style='height:3.75pt;border-top:none;
  width:26pt'>&nbsp;</td>
  <td class=xl97 width=118 style='border-top:none;width:89pt'>&nbsp;</td>
  <td class=xl139 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl147 width=99 style='border-top:none;width:74pt'>&nbsp;</td>
  <td class=xl147 width=103 style='border-top:none;width:77pt'>&nbsp;</td>
  <td class=xl147 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl147 width=101 style='border-top:none;width:76pt'>&nbsp;</td>
  <td class=xl147 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl147 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl147 width=93 style='border-top:none;width:70pt'>&nbsp;</td>
  <td class=xl147 width=103 style='border-top:none;width:77pt'>&nbsp;</td>
  <td class=xl140 width=96 style='border-top:none;width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl148 width=34 style='height:21.75pt;border-top:none;
  width:26pt' x:num>5</td>
  <td class=xl161 width=118 style='border-top:none;width:89pt'>This Payment</td>
  <td class=xl162 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl187 width=99 style='border-top:none;border-left:none;width:74pt'
  x:num="3740383939.5999999" x:fmla="=D30">3,740,383,940</td>
  <td class=xl187 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num="340034903.60000002" x:fmla="=E30+E31-E36">340,034,904</td>
  <td class=xl187 width=0 style='border-top:none;border-left:none' x:num
  x:fmla="=F30+F31-F35">0</td>
  <td class=xl188 width=101 style='border-top:none;border-left:none;width:76pt'
  x:num="61517173.76455" x:fmla="=G30-G36">61,517,174</td>
  <td class=xl187 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl187 width=0 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl187 width=93 style='border-top:none;border-left:none;width:70pt'
  x:num="401552077.36454999" x:fmla="=E38+G38">401,552,077</td>
  <td class=xl188 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num="3338831862.2354498" x:fmla="=D38-J38">3,338,831,862</td>
  <td class=xl163 width=96 style='border-top:none;border-left:none;width:72pt'
  x:num="0.10735584470707901" x:fmla="=J38/D38*100%">11%</td>
  <td class=xl65></td>
  <td class=xl118></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl127 style='height:10.5pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl99 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl99 width=101 style='border-top:none;width:76pt'>&nbsp;</td>
  <td class=xl99 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl99 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl99 width=93 style='border-top:none;width:70pt'>&nbsp;</td>
  <td class=xl99 width=103 style='border-top:none;width:77pt'>&nbsp;</td>
  <td class=xl128 width=96 style='border-top:none;width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=5 height=20 class=xl265 width=354 style='height:15.0pt;
  width:266pt'>Paid Amount Status</td>
  <td class=xl100>&nbsp;</td>
  <td colspan=5 class=xl100 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl129 width=96 style='width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl130 width=34 style='height:11.25pt;width:26pt'>&nbsp;</td>
  <td colspan=10 class=xl100 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl129 width=96 style='width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td colspan=2 height=42 class=xl259 width=152 style='height:31.5pt;
  width:115pt'>Contract Value</td>
  <td class=xl97 width=0>&nbsp;</td>
  <td class=xl77 width=99 style='width:74pt'>Previous</td>
  <td class=xl77 width=103 style='border-left:none;width:77pt'>This time
  payment</td>
  <td class=xl77 width=0 style='border-left:none'>This Time</td>
  <td class=xl77 width=101 style='border-left:none;width:76pt'>Accumulation</td>
  <td class=xl77 width=0 style='border-left:none'>Accumulation</td>
  <td class=xl77 width=0 style='border-left:none'>Accumulation</td>
  <td class=xl77 width=93 style='border-left:none;width:70pt'>Total Amount</td>
  <td class=xl77 width=103 style='border-left:none;width:77pt'>Balance</td>
  <td class=xl77 width=96 style='border-left:none;width:72pt'>Remarks</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=2 height=26 class=xl260 style='height:20.1pt'
  x:num="3740383939.5999999" x:fmla="=D38">3,740,383,940</td>
  <td class=xl113 style='border-top:none'>&nbsp;</td>
  <td class=xl114 align=right style='border-top:none' x:num="340034903.60000002"
  x:fmla="=E38">340,034,904</td>
  <td class=xl137 align=right style='border-top:none;border-left:none'
  x:num="61517173.76455" x:fmla="=G38">61,517,174</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 align=right style='border-top:none;border-left:none'
  x:num="401552077.36454999" x:fmla="=J38">401,552,077</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl114 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl137 align=right style='border-top:none;border-left:none'
  x:num="401552077.36454999" x:fmla="=G43">401,552,077</td>
  <td class=xl137 align=right style='border-top:none;border-left:none'
  x:num="3338831862.2354498" x:fmla="=K38">3,338,831,862</td>
  <td class=xl116 style='border-top:none;border-left:none'
  x:num="0.10735584470707901" x:fmla="=+L38">11%</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl131 style='height:12.0pt'>&nbsp;</td>
  <td colspan=3 class=xl103 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl104 style='mso-ignore:colspan'></td>
  <td class=xl132>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl192 style='height:16.5pt' x:str="* Enclosure(s):"><span
  style='mso-spacerun:yes'> </span>* Enclosure(s):<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl98 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl193 colspan=2 style='mso-ignore:colspan'
  x:str="1/ Request of payment"><span style='mso-spacerun:yes'> </span>1/
  Request of payment<span style='mso-spacerun:yes'> </span></td>
  <td class=xl98>&nbsp;</td>
  <td colspan=5 class=xl98 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl133 width=96 style='width:72pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl194 style='height:20.1pt'
  x:str="                        "><span style='mso-spacerun:yes'>       
  </span><span style='display:none'><span
  style='mso-spacerun:yes'>                </span></span></td>
  <td colspan=2 class=xl195 style='mso-ignore:colspan'></td>
  <td class=xl193 x:str="2/ Minutes of acceptance"><span
  style='mso-spacerun:yes'> </span>2/ Minutes of acceptance<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=7 class=xl195 style='mso-ignore:colspan'></td>
  <td class=xl196>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl194 style='height:20.1pt'
  x:str="                        "><span style='mso-spacerun:yes'>       
  </span><span style='display:none'><span
  style='mso-spacerun:yes'>                </span></span></td>
  <td colspan=2 class=xl195 style='mso-ignore:colspan'></td>
  <td class=xl193>&nbsp;</td>
  <td colspan=7 class=xl195 style='mso-ignore:colspan'></td>
  <td class=xl196>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl134 style='height:11.25pt'>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl135>&nbsp;</td>
  <td class=xl136>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl198 colspan=4 style='height:20.1pt;mso-ignore:colspan'
  x:str="I would like to get your consideration ">I would like to get your
  consideration<span style='mso-spacerun:yes'> </span></td>
  <td class=xl197 width=103 style='border-top:none;width:77pt'>&nbsp;</td>
  <td class=xl197 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl197 width=101 style='border-top:none;width:76pt'>&nbsp;</td>
  <td class=xl197 width=0 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl101 colspan=2 style='mso-ignore:colspan'>POSCO E&amp;C-VIETNAM</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='height:15.0pt'>
  <td height=20 colspan=16 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='height:15.0pt'>
  <td height=20 colspan=16 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=16 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=20 style='height:15.0pt'>
  <td height=20 colspan=16 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td colspan=12 height=21 class=xl74 width=747 style='height:15.75pt;
  width:561pt'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 colspan=8 class=xl65 style='height:32.25pt;mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl65></td>
  <td class=xl71></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl65></td>
  <td class=xl72></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td class=xl72></td>
  <td class=xl65></td>
  <td class=xl72></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl69 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td colspan=8 class=xl79 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl69>&nbsp;</td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl69 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl69 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl69 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl74 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl68 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl78 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl257></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl75 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=34 style='width:26pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=0></td>
  <td width=99 style='width:74pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=0></td>
  <td width=101 style='width:76pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=93 style='width:70pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
