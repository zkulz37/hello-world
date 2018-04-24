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
<%
    string l_tecps_requestpayment_pk = Request["p_pk"];

	string l_parameter = "";
    l_parameter = "'" + l_tecps_requestpayment_pk + "'";

	DataTable dt = ESysLib.TableReadOpenCursor("ec111.sp_rpt_kpcs314_3", l_parameter);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpcs314_request4payment_1_files/filelist.xml">
<link rel=Edit-Time-Data href="kpcs314_request4payment_1_files/editdata.mso">
<link rel=OLE-Object-Data href="kpcs314_request4payment_1_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:LastPrinted>2011-05-04T08:41:52Z</o:LastPrinted>
  <o:Created>2011-04-15T01:58:48Z</o:Created>
  <o:LastSaved>2011-06-22T08:34:34Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .24in .28in .22in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
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
.xl72
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl101
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-number-format:"\#\,\#\#0";}
.xl103
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-number-format:"\#\,\#\#0";}
.xl104
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl107
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	text-align:right;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl108
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl109
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-number-format:"\#\,\#\#0";}
.xl110
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-number-format:"\#\,\#\#0";}
.xl111
	{mso-style-parent:style0;
	font-weight:700;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl112

	{mso-style-parent:style0;
	font-weight:700;}
.xl113
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-number-format:"\#\,\#\#0";}
.xl116
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;		
	mso-number-format:"\#\,\#\#0";}
.xl117
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl118
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-number-format:"\#\,\#\#0";}
.xl119
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;		
	mso-number-format:"\#\,\#\#0";
	}
.xl120
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl121
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl122
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;}
.xl123
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl124
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl125
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl126
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl127
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-number-format:"\#\,\#\#0";}
.xl128
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-number-format:"\#\,\#\#0";}
.xl129
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl130
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl131
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-number-format:"\#\,\#\#0";}
.xl132
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-number-format:"\#\,\#\#0";}
.xl133
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl134
	{mso-style-parent:style0;
	color:red;
	font-weight:700;}
.xl135
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl136
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl137
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl138
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl139
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl140
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl141
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl142
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl143
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl144
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl145
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl146
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl147
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl148
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl149
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl150
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;	
	mso-number-format:"\#\,\#\#0";}
.xl151
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl152
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl153
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl154
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl155
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl156
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl157
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl158
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl159
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl160
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl161
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl162
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl163
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl164
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl165
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;}
.xl166
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl167
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl168
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl169
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl170
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl180
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-number-format:0%;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>payment proposal</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>61</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>50</x:TabColorIndex>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>39</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>30</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
       <x:RangeSelection>$K$31:$M$31</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>13830</x:WindowHeight>
  <x:WindowWidth>28800</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="14337"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="9"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1840 style='border-collapse:
 collapse;table-layout:fixed;width:1386pt'>
 <col width=14 style='mso-width-source:userset;mso-width-alt:448;width:11pt'>
 <col width=31 style='mso-width-source:userset;mso-width-alt:992;width:23pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2584;width:47pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:2880;width:68pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:4300;width:65pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:2784;width:65pt'>
 <col width=86 span=3 style='mso-width-source:userset;mso-width-alt:2752;
 width:65pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2240;width:53pt'>
 <col width=18 span=2 style='mso-width-source:userset;mso-width-alt:576;
 width:14pt'>
 <col width=154 style='mso-width-source:userset;mso-width-alt:4928;width:116pt'>
 <col width=130 style='mso-width-source:userset;mso-width-alt:4160;width:98pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:2816;width:66pt'>
 <col width=14 style='mso-width-source:userset;mso-width-alt:448;width:11pt'>
 <col width=72 span=10 style='width:54pt'>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl72 width=14 style='height:9.95pt;width:11pt'>&nbsp;</td>
  <td class=xl73 width=31 style='width:23pt'>&nbsp;</td>
  <td class=xl73 width=62 style='width:47pt'>&nbsp;</td>
  <td class=xl73 width=90 style='width:68pt'>&nbsp;</td>
  <td class=xl73 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl88 width=87 style='width:65pt'>&nbsp;</td>
  <td class=xl73 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl73 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl73 width=86 style='width:65pt'>&nbsp;</td>
  <td class=xl73 width=70 style='width:53pt'>&nbsp;</td>
  <td class=xl89 width=18 style='width:14pt'>&nbsp;</td>
  <td class=xl73 width=18 style='width:14pt'>&nbsp;</td>
  <td class=xl73 width=154 style='width:116pt'>&nbsp;</td>
  <td class=xl73 width=130 style='width:98pt'>&nbsp;</td>
  <td class=xl73 width=88 style='width:66pt'>&nbsp;</td>
  <td class=xl74 width=14 style='width:11pt'>&nbsp;</td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl75 style='height:14.25pt'>&nbsp;</td>
  <td colspan=4 rowspan=3 height=57 width=269 style='mso-ignore:colspan-rowspan;
  height:42.75pt;width:203pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s9455" type="#_x0000_t75"
   alt="newlogo.JPG" style='position:absolute;margin-left:6.75pt;margin-top:0;
   width:179.25pt;height:39.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="kpcs314_request4payment_1_files/image001.jpg" o:title="newlogo"/>
   <v:path arrowok="t"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=9 height=0></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=239 height=53
    src="kpcs314_request4payment_1_files/image002.jpg" alt=newlogo.JPG v:shapes="Picture_x0020_1"></td>
    <td width=21></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:201.75pt;height:42.75pt'></span><![endif]--></td>
  <td height=19 class=xl80 width=87 style='height:14.25pt;width:65pt'><!--[if gte vml 1]><v:shapetype
   id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="TextBox_x0020_2" o:spid="_x0000_s9456" type="#_x0000_t202"
   style='position:absolute;margin-left:16.5pt;margin-top:3.75pt;width:16.5pt;
   height:7.5pt;z-index:2;visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=26 height=14
    src="kpcs314_request4payment_1_files/image003.gif" v:shapes="TextBox_x0020_2"></td>
    <td width=41></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:65.25pt;height:14.25pt'></span><![endif]--></td>
  <td>Date:</td>
  <td>: <%=dt.Rows[0]["req_dt"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl81>&nbsp;</td>
  <td></td>
  <td height=19 width=154 style='height:14.25pt;width:116pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_5" o:spid="_x0000_s9459" type="#_x0000_t202" style='position:absolute;
   margin-left:19.5pt;margin-top:3.75pt;width:16.5pt;height:7.5pt;z-index:5;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=24 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=26 height=14
    src="kpcs314_request4payment_1_files/image003.gif" v:shapes="TextBox_x0020_5"></td>
    <td width=104></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:115.5pt;height:14.25pt'></span><![endif]--></td>
  <td>Routine</td>
  <td></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl75 style='height:14.25pt'>&nbsp;</td>
  <td height=19 class=xl80 width=87 style='height:14.25pt;width:65pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_3" o:spid="_x0000_s9457" type="#_x0000_t202" style='position:absolute;
   margin-left:16.5pt;margin-top:3pt;width:16.5pt;height:7.5pt;z-index:3;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=26 height=14
    src="kpcs314_request4payment_1_files/image003.gif" v:shapes="TextBox_x0020_3"></td>
    <td width=41></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:65.25pt;height:14.25pt'></span><![endif]--></td>
  <td>Doc.No.</td>
  <td>: <%=dt.Rows[0]["req_no"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl81>&nbsp;</td>
  <td></td>
  <td height=19 width=154 style='height:14.25pt;width:116pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_6" o:spid="_x0000_s9460" type="#_x0000_t202" style='position:absolute;
   margin-left:19.5pt;margin-top:3pt;width:16.5pt;height:7.5pt;z-index:6;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=24 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=26 height=14
    src="kpcs314_request4payment_1_files/image003.gif" v:shapes="TextBox_x0020_6"></td>
    <td width=104></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:115.5pt;height:14.25pt'></span><![endif]--></td>
  <td>Urgent</td>
  <td></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl75 style='height:14.25pt'>&nbsp;</td>
  <td height=19 class=xl80 width=87 style='height:14.25pt;width:65pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_4" o:spid="_x0000_s9458" type="#_x0000_t202" style='position:absolute;
   margin-left:16.5pt;margin-top:3.75pt;width:16.5pt;height:7.5pt;z-index:4;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=26 height=14
    src="kpcs314_request4payment_1_files/image003.gif" v:shapes="TextBox_x0020_4"></td>
    <td width=41></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:65.25pt;height:14.25pt'></span><![endif]--></td>
  <td>Ref.</td>
  <td>:</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl81>&nbsp;</td>
  <td></td>
  <td height=19 width=154 style='height:14.25pt;width:116pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_7" o:spid="_x0000_s9461" type="#_x0000_t202" style='position:absolute;
   margin-left:19.5pt;margin-top:3.75pt;width:16.5pt;height:7.5pt;z-index:7;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=24 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=26 height=14
    src="kpcs314_request4payment_1_files/image003.gif" v:shapes="TextBox_x0020_7"></td>
    <td width=104></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:115.5pt;height:14.25pt'></span><![endif]--></td>
  <td>Confidential</td>
  <td></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl86 style='height:9.95pt'>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=4 rowspan=10 height=205 class=xl135 width=197 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:153.75pt;width:149pt'>PROPOSAL
  SHEET</td>
  <td colspan=3 class=xl144 style='border-right:.5pt solid black;border-left:
  none'>Prepared by</td>
  <td colspan=3 class=xl144 style='border-right:.5pt solid black;border-left:
  none'>Checked by</td>
  <td colspan=3 class=xl144 style='border-right:.5pt solid black;border-left:
  none'>Review by</td>
  <td colspan=3 class=xl144 style='border-right:1.0pt solid black;border-left:
  none'>Approved by</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl80 style='height:14.25pt;border-left:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td></td>
  <td class=xl120 style='border-top:none'>&nbsp;</td>
  <td></td>
  <td class=xl85 style='border-top:none'>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl80 style='height:14.25pt;border-left:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl80 style='height:14.25pt;border-left:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl80 style='height:14.25pt;border-left:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl80 style='height:14.25pt;border-left:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl80 style='height:14.25pt;border-left:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl80 style='height:14.25pt;border-left:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl82 style='height:14.25pt;border-left:none'>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl92 style='height:21.0pt;border-top:none;border-left:
  none'>Name:</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl92 style='border-top:none'>Name:</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl92 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>Name:</td>
  <td class=xl90 style='border-top:none'>Name:</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none'>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=16 height=36 class=xl147 style='border-right:1.0pt solid black;
  height:27.0pt'>Subject: <%=dt.Rows[0]["description"]%></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl75 style='height:9.0pt'>&nbsp;</td>
  <td colspan=14 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td class=xl97 colspan=7 style='mso-ignore:colspan'>We would like to propose
  the BOD approve to payment as follows:</td>
  <td colspan=7 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl96 style='height:7.5pt'>&nbsp;</td>
  <td colspan=14 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td></td>
  <td class=xl97 colspan=2 style='mso-ignore:colspan'>1. Project code:</td>
  <td colspan=11 class=xl97 style='mso-ignore:colspan'><%=dt.Rows[0]["projectcode"]%></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td></td>
  <td class=xl97 colspan=2 style='mso-ignore:colspan'>2. Project name:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=11 class=xl97 style='mso-ignore:colspan'><%=dt.Rows[0]["projectname"]%></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td></td>
  <td class=xl97 colspan=2 style='mso-ignore:colspan'>3. Subcontractor:</td>
  <td colspan=11 class=xl97 style='mso-ignore:colspan'><%=dt.Rows[0]["partner_name"]%></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td></td>
  <td class=xl97 colspan=2 style='mso-ignore:colspan'>4. Contract No.:</td>
  <td colspan=11 class=xl97 style='mso-ignore:colspan'><%=dt.Rows[0]["contract_cd"]%></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td></td>
  <td class=xl97 colspan=2 style='mso-ignore:colspan'>5. Scope of work:</td>
  <td colspan=11 class=xl97 style='mso-ignore:colspan'><%=dt.Rows[0]["contract_nm"]%></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td></td>
  <td class=xl97 colspan=2 style='mso-ignore:colspan'>6. Contract period:</td>
  <td colspan=11 class=xl97 style='mso-ignore:colspan'><%=dt.Rows[0]["contract_from_dt"]%> ~ <%=dt.Rows[0]["contract_to_dt"]%></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td></td>
  <td class=xl97 colspan=2 style='mso-ignore:colspan'>7. Contract amount:</td>
  <td class=xl97 style='mso-ignore:colspan' x:num><%=dt.Rows[0]["net_cont"].ToString()%></td>
  <td colspan=10 class=xl97 style='mso-ignore:colspan' x:num><%=dt.Rows[0]["ccy"].ToString()%></td>
  <td class=xl76></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td></td>
  <td class=xl97 colspan=2 style='mso-ignore:colspan'>8. Details:</td>
  <td colspan=11 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl96 style='height:8.25pt'>&nbsp;</td>
  <td colspan=14 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl96 style='height:23.25pt'>&nbsp;</td>
  <td rowspan=2 class=xl123 style='border-bottom:.5pt solid black'>No.</td>
  <td colspan=2 rowspan=2 class=xl127 style='border-bottom:.5pt solid black'>Description</td>
  <td colspan=2 rowspan=2 class=xl123 style='border-bottom:.5pt solid black'>Contract
  amount</td>
  <td colspan=2 rowspan=2 class=xl123 style='border-bottom:.5pt solid black'>Previous
  payment</td>
  <td colspan=2 rowspan=2 class=xl123 style='border-bottom:.5pt solid black'
  x:str="This time ">This time<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 rowspan=2 class=xl123 style='border-bottom:.5pt solid black'>Accumulated</td>
  <td rowspan=2 class=xl156 style='border-bottom:.5pt solid black'>Balance</td>
  <td rowspan=2 class=xl123 style='border-bottom:.5pt solid black'>Remark</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl96 style='height:24.75pt'>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl112 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl108 style='height:30.0pt'>&nbsp;</td>
  <td class=xl113 x:str="'1.">1.</td>
  <td colspan=2 class=xl158>Net Amount</td>
  <td colspan=2 class=xl150 x:num><%=dt.Rows[0]["net_cont"].ToString()%></td>
  <td colspan=2 class=xl150 style='border-left:none' x:num><%=dt.Rows[0]["net_pre"].ToString()%></td>
  <td colspan=2 class=xl150 style='border-left:none' x:num><%=dt.Rows[0]["net_this"].ToString()%></td>
  <td colspan=3 class=xl150 style='border-left:none' x:num x:fmla="=G31+I31">  </td>
  <td class=xl109 x:num x:fmla="=E31-K31">N31</td>
  <td class=xl110 style='border-left:none'>&nbsp;</td>
  <td class=xl111>&nbsp;</td>
  <td colspan=10 class=xl112 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td class=xl114>&nbsp;</td>
  <td colspan=2 class=xl160>VAT (<%=dt.Rows[0]["TAX_RATE"].ToString()%>%)</td>
  <td colspan=2 class=xl116 x:num><%=dt.Rows[0]["vat_cont"].ToString()%></td>
  <td colspan=2 class=xl116 style='border-left:none' x:num><%=dt.Rows[0]["vat_pre"].ToString()%></td>
  <td colspan=2 class=xl116 style='border-left:none' x:num ><%=dt.Rows[0]["vat_this"].ToString()%> </td>
  <td colspan=3 class=xl116 style='border-left:none' x:num x:fmla="=I32+G32">0</td>
  <td class=xl115 x:num x:fmla="=E32-K32">N32</td>
  <td class=xl116 style='border-left:none'>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl112 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl108 style='height:30.0pt'>&nbsp;</td>
  <td class=xl117 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl154>Total</td>
  <td colspan=2 class=xl119 x:num  x:fmla="=E31+E32" ></td>
  <td colspan=2 class=xl119 style='border-left:none' x:num x:fmla="=G31+G32">0</td>
  <td colspan=2 class=xl119 style='border-left:none' x:num x:fmla="=I31+I32">I33</td>
  <td colspan=3 class=xl119 style='border-left:none' x:num x:fmla="=I33+G33">0</td>
  <td class=xl118 style='border-top:none' x:num x:fmla="=E33-K33">0</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111>&nbsp;</td>
  <td colspan=10 class=xl112 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl112 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl108 style='height:30.0pt'>&nbsp;</td>
  <td class=xl117 style='border-top:none' x:str="'2.">2.</td>
  <td colspan=2 class=xl154>Advance (<%=dt.Rows[0]["adv"].ToString()%>%)</td>
  <td colspan=2 class=xl119 x:num><%=dt.Rows[0]["adv_cont"].ToString()%></td>
  <td colspan=2 class=xl119 style='border-left:none' x:num><%=dt.Rows[0]["adv_deduct_cont"].ToString()%></td>
  <td colspan=2 class=xl119 style='border-left:none' x:num>0</td>
  <td colspan=3 class=xl119 style='border-left:none' x:num x:fmla="=I34+G34">0</td>
  <td class=xl118 style='border-top:none' x:num x:fmla="=E34-K34">0</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111>&nbsp;</td>
  <td colspan=10 class=xl112 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl112 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl108 style='height:30.0pt'>&nbsp;</td>
  <td class=xl117 style='border-top:none' x:str="'3.">3.</td>
  <td colspan=2 class=xl154>Retention (<%=dt.Rows[0]["reten"].ToString()%>%)</td>
  <td colspan=2 class=xl119 x:num><%=dt.Rows[0]["reten_cont"].ToString()%></td>
  <td colspan=2 class=xl119 style='border-left:none' x:num>0</td>
  <td colspan=2 class=xl119 style='border-left:none' x:num>0</td>
  <td colspan=3 class=xl119 style='border-left:none' x:num x:fmla="=I35+G35">0</td>
  <td class=xl118 style='border-top:none' x:num x:fmla="=E35-K35">0</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111>&nbsp;</td>
  <td colspan=10 class=xl112 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl112 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl108 style='height:30.0pt'>&nbsp;</td>
  <td class=xl117 style='border-top:none' x:str="'4.">4.</td>
  <td colspan=2 class=xl154>Deducting</td>
  <td colspan=2 class=xl119>&nbsp;</td>
  <td colspan=2 class=xl119 style='border-left:none'></td>
  <td colspan=2 class=xl119 style='border-left:none'></td>
  <td colspan=3 class=xl119 style='border-left:none'></td>
  <td class=xl118 style='border-top:none'></td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111>&nbsp;</td>
  <td colspan=10 class=xl112 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td class=xl114 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl160>Advance (<%=dt.Rows[0]["adv"].ToString()%>%)</td>
  <td colspan=2 class=xl116 x:num x:fmla="=E34" >E37</td>
  <td colspan=2 class=xl116 style='border-left:none' x:num ><%=dt.Rows[0]["adv_deduct_pre"].ToString()%></td>
  <td colspan=2 class=xl116 style='border-left:none' x:num ><%=dt.Rows[0]["adv_deduct_this"].ToString()%></td>
  <td colspan=3 class=xl116 style='border-left:none' x:num x:fmla="=I37+G37">0</td>
  <td class=xl115 style='border-top:none' x:num x:fmla="=E37-K37">0</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl134 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl129 style='height:30.0pt'>&nbsp;</td>
  <td class=xl130 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl162>Withholding tax (<%=dt.Rows[0]["withtax"].ToString()%>%)</td>
  <td colspan=2 class=xl131 x:num><%=dt.Rows[0]["with_deduct_cont"].ToString()%></td>
  <td colspan=2 class=xl131 style='border-left:none' x:num><%=dt.Rows[0]["with_deduct_pre"].ToString()%></td>
  <td colspan=2 class=xl131 style='border-left:none' x:num><%=dt.Rows[0]["with_deduct_this"].ToString()%></td>
  <td colspan=3 class=xl131 style='border-left:none' x:num x:fmla="=I38+G38">0</td>
  <td class=xl132 style='border-top:none' x:num x:fmla="=E38-K38">0</td>
  <td class=xl131 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl133>&nbsp;</td>
  <td class=xl134 colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl96 style='height:30.0pt'>&nbsp;</td>
  <td class=xl114 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl160>Retention (<%=dt.Rows[0]["reten"].ToString()%>%)</td>
  <td colspan=2 class=xl116 x:num x:fmla="=E35">E39</td>
  <td colspan=2 class=xl116 style='border-left:none' x:num ><%=dt.Rows[0]["reten_deduct_pre"].ToString()%></td>
  <td colspan=2 class=xl116 style='border-left:none' x:num ><%=dt.Rows[0]["reten_deduct_this"].ToString()%></td>
  <td colspan=3 class=xl116 style='border-left:none' x:num x:fmla="=I39+G39"></td>
  <td class=xl115 style='border-top:none' x:num x:fmla="=E39-K39"></td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl112 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl108 style='height:30.0pt'>&nbsp;</td>
  <td class=xl117 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl154>Total deduct</td>
  <td colspan=2 class=xl119 x:num x:fmla="=E39+E38+E37" ></td>
  <td colspan=2 class=xl119 style='border-left:none' x:num x:fmla="=G37+G38+G39" >0</td>
  <td colspan=2 class=xl119 style='border-left:none' x:num x:fmla="=I37+I38+I39">I40</td>
  <td colspan=3 class=xl119 style='border-left:none' x:num x:fmla="=I40+G40">0</td>
  <td class=xl118 style='border-top:none' x:num x:fmla="=E40-K40">0</td>
  <td class=xl119 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl111>&nbsp;</td>
  <td colspan=10 class=xl112 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl112 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl108 style='height:30.0pt'>&nbsp;</td>
  <td class=xl113 x:str="'5.">5.</td>
  <td colspan=2 class=xl164>Actual Payment</td>
  <td colspan=2 class=xl110 x:num x:fmla="=E33">E41</td>
  <td colspan=2 class=xl110 style='border-left:none' x:num x:fmla="=G33+G34+G35-G40">I41</td>
  <td colspan=2 class=xl110 style='border-left:none' x:num x:fmla="=I33+I34+I35-I40">I41</td>
  <td colspan=3 class=xl110 style='border-left:none' x:num x:fmla="=I41+G41">K41</td>
  <td class=xl109  x:num x:fmla="=E41-K41">N41</td>
  <td class=xl110 style='border-left:none' ></td>
  <td class=xl111>&nbsp;</td>
  <td colspan=10 class=xl112 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl96 style='height:9.0pt'>&nbsp;</td>
  <td class=xl106>&nbsp;</td>
  <td colspan=2 class=xl167>&nbsp;</td>
  <td colspan=2 class=xl166>&nbsp;</td>
  <td colspan=2 class=xl166 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl166 style='border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl166 style='border-left:none'>&nbsp;</td>
  <td class=xl107  ></td>
  <td class=xl99 style='border-left:none'>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl96 style='height:20.1pt'>&nbsp;</td>
  <td class=xl122 colspan=2 style='mso-ignore:colspan'>Status:</td>
  <td colspan=12 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl96 style='height:8.25pt'>&nbsp;</td>
  <td colspan=14 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl96 style='height:34.5pt'>&nbsp;</td>
  <td colspan=3 class=xl151 width=183 style='border-right:.5pt solid black;
  width:138pt'>Contract amount ( Incl. VAT)</td>
  <td colspan=2 class=xl170 style='border-right:.5pt solid black'>Previous</td>
  <td colspan=2 class=xl101 style='border-right:.5pt solid black'>This time</td>
  <td colspan=2 class=xl101 style='border-right:.5pt solid black'>Accumulated</td>
  <td colspan=3 class=xl101 style='border-right:.5pt solid black'>Ratio</td>
  <td class=xl100>Balance</td>
  <td class=xl98 style='border-left:none'>Remark</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl96 style='height:27.0pt'>&nbsp;</td>
  <td colspan=3 class=xl127 style='border-right:.5pt solid black' x:num  x:fmla="=E31+E32"></td>
  <td colspan=2 class=xl127 style='border-left:none' x:num x:fmla="=G41">0</td>
  <td colspan=2 class=xl128 x:num x:fmla="=I41">&nbsp;</td>
  <td colspan=2 class=xl128 x:num x:fmla="=K41">I47</td>
  <td colspan=3 class=xl180 style='border-top:none' x:num x:fmla="=K41/E41*100%"></td>
  <td class=xl103 style='border-top:none'  x:num x:fmla="=N41"></td>
  <td class=xl123 style='border-top:none;border-left:none' >&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl96 style='height:9.75pt'>&nbsp;</td>
  <td colspan=3 class=xl148 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl148 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl149 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl149 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=3 class=xl104 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td class=xl124 style='border-left:none'>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td class=xl97></td>
  <td class=xl97 colspan=3 style='mso-ignore:colspan'>Attachment as below;</td>
  <td colspan=10 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl97>1./ Claim</td>
  <td colspan=11 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl97 colspan=2 style='mso-ignore:colspan'>2./ Confirmed BOQ</td>
  <td colspan=10 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl97 colspan=3 style='mso-ignore:colspan'>I would like to get your
  approval</td>
  <td colspan=9 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl96 style='height:15.0pt'>&nbsp;</td>
  <td colspan=14 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl76>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl93 style='height:15.0pt'>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl95 colspan=6 style='mso-ignore:colspan'>POSCO ENGINEERING &amp;
  CONSTRUCTION VIETNAM CO.,LTD</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl94>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl77 style='height:9.95pt'>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=14 style='width:11pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=14 style='width:11pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
