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
    
	DataTable dt_m = ESysLib.TableReadOpenCursor("ec111.sp_rpt_kpcs314_M", l_parameter);
	
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpcs314_request4payment_2_files/filelist.xml">
<link rel=Edit-Time-Data href="kpcs314_request4payment_2_files/editdata.mso">
<link rel=OLE-Object-Data href="kpcs314_request4payment_2_files/oledata.mso">
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
  <o:LastSaved>2011-07-11T09:56:46Z</o:LastSaved>
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
.xl24
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;}
.xl40
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl45
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	color:red;
	font-weight:700;}
.xl62
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl76
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
.xl77
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
.xl78
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl79
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
.xl80
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl82
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
.xl83
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
.xl84
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl87
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl108
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl109
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl110
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl111
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl112
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl114
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl116
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl117
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
.xl118
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl119
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl121
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl122
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl123
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl124
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl125
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl126
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl127
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl128
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl129
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl130
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl132
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl133
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl134
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl135
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl136
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl137
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl138
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl139
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl140
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0%;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl141
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0%;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl142
	{mso-style-parent:style0;
	font-size:12.0pt;
	mso-number-format:0%;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl143
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl144
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl145
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl146
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl147
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
 <o:shapedefaults v:ext="edit" spidmax="9462"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="9"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1907 style='border-collapse:
 collapse;table-layout:fixed;width:1436pt'>
 <col width=14 style='mso-width-source:userset;mso-width-alt:448;width:11pt'>
 <col width=31 style='mso-width-source:userset;mso-width-alt:992;width:23pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2592;width:61pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:2880;width:68pt'>
 <col width=134 style='mso-width-source:userset;mso-width-alt:4288;width:101pt'>
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
  <td height=13 class=xl24 width=14 style='height:9.95pt;width:11pt'></td>
  <td class=xl25 width=31 style='width:23pt'></td>
  <td class=xl25 width=81 style='width:61pt'></td>
  <td class=xl25 width=90 style='width:68pt'></td>
  <td class=xl25 width=134 style='width:101pt'></td>
  <td class=xl26 width=87 style='width:65pt'></td>
  <td class=xl25 width=86 style='width:65pt'></td>
  <td class=xl25 width=86 style='width:65pt'></td>
  <td class=xl25 width=86 style='width:65pt'></td>
  <td class=xl25 width=70 style='width:53pt'></td>
  <td class=xl27 width=18 style='width:14pt'></td>
  <td class=xl25 width=18 style='width:14pt'></td>
  <td class=xl25 width=154 style='width:116pt'></td>
  <td class=xl25 width=130 style='width:98pt'></td>
  <td class=xl25 width=88 style='width:66pt'></td>
  <td class=xl28 width=14 style='width:11pt'></td>
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
  <td height=19 class=xl29 style='height:14.25pt'></td>
  <td colspan=4 rowspan=3 height=57 width=336 style='mso-ignore:colspan-rowspan;
  height:42.75pt;width:253pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
   <v:imagedata src="kpcs314_request4payment_2_files/image001.jpg" o:title="newlogo"/>
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
    src="kpcs314_request4payment_2_files/image002.jpg" alt=newlogo.JPG v:shapes="Picture_x0020_1"></td>
    <td width=88></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:252.0pt;height:42.75pt'></span><![endif]--></td>
  <td height=19 class=xl30 width=87 style='height:14.25pt;width:65pt'><!--[if gte vml 1]><v:shapetype
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
    src="kpcs314_request4payment_2_files/image003.gif" v:shapes="TextBox_x0020_2"></td>
    <td width=41></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:65.25pt;height:14.25pt'></span><![endif]--></td>
  <td>Date:</td>
  <td>:<%=dt_m.Rows[0]["req_dt"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
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
    src="kpcs314_request4payment_2_files/image003.gif" v:shapes="TextBox_x0020_5"></td>
    <td width=104></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:115.5pt;height:14.25pt'></span><![endif]--></td>
  <td>Routine</td>
  <td></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl29 style='height:14.25pt'></td>
  <td height=19 class=xl30 width=87 style='height:14.25pt;width:65pt'><!--[if gte vml 1]><v:shape
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
    src="kpcs314_request4payment_2_files/image003.gif" v:shapes="TextBox_x0020_3"></td>
    <td width=41></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:65.25pt;height:14.25pt'></span><![endif]--></td>
  <td>Doc.No.</td>
  <td>:<%=dt_m.Rows[0]["req_no"]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
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
    src="kpcs314_request4payment_2_files/image003.gif" v:shapes="TextBox_x0020_6"></td>
    <td width=104></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:115.5pt;height:14.25pt'></span><![endif]--></td>
  <td>Urgent</td>
  <td></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl29 style='height:14.25pt'></td>
  <td height=19 class=xl30 width=87 style='height:14.25pt;width:65pt'><!--[if gte vml 1]><v:shape
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
    src="kpcs314_request4payment_2_files/image003.gif" v:shapes="TextBox_x0020_4"></td>
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
  <td class=xl31></td>
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
    src="kpcs314_request4payment_2_files/image003.gif" v:shapes="TextBox_x0020_7"></td>
    <td width=104></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:115.5pt;height:14.25pt'></span><![endif]--></td>
  <td>Confidential</td>
  <td></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl33 style='height:9.95pt'></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl36></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl37></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=4 rowspan=10 height=205 class=xl76 width=216 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:153.75pt;width:163pt'>PROPOSAL
  SHEET</td>
  <td colspan=3 class=xl86 style='border-right:.5pt solid black;border-left:
  none'>Prepared by</td>
  <td colspan=3 class=xl86 style='border-right:.5pt solid black;border-left:
  none'>Checked by</td>
  <td colspan=3 class=xl86 style='border-right:.5pt solid black;border-left:
  none'>Review by</td>
  <td colspan=3 class=xl86 style='border-right:1.0pt solid black;border-left:
  none'>Approved by</td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=3 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td class=xl31></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=3 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td class=xl31></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=3 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td class=xl31></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=3 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td class=xl31></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=3 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td class=xl31></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=3 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td class=xl31></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=3 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td></td>
  <td class=xl31></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl34></td>
  <td class=xl36></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl37></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl34 style='height:21.0pt'>Name:</td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl35>Name:</td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl42 colspan=3 style='mso-ignore:colspan;border-right:.5pt solid black'>Name:</td>
  <td class=xl34>Name:</td>
  <td class=xl34></td>
  <td class=xl37></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=16 height=36 class=xl89 style='border-right:1.0pt solid black;
  height:27.0pt'>Subject:<%=dt_m.Rows[0]["description"]%></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl29 style='height:9.0pt'></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td class=xl44 colspan=6 style='mso-ignore:colspan'>We would like to propose
  the BOD approve to payment as follows:</td>
  <td colspan=8 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl43 style='height:7.5pt'></td>
  <td colspan=14 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>1. Project code:</td>
  <td class=xl44><%=dt_m.Rows[0]["projectcode"]%></td>
  <td colspan=10 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan' x:str="2. Project name: ">2.
  Project name:<span style='mso-spacerun:yes'>�</span></td>
  <td class=xl44><%=dt_m.Rows[0]["projectname"]%></td>
  <td colspan=10 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>3. Subcontractor:</td>
  <td class=xl44><%=dt_m.Rows[0]["partner_name"]%></td>
  <td colspan=10 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>4. Contract No.:</td>
  <td class=xl44><%=dt_m.Rows[0]["contract_cd"]%></td>
  <td colspan=10 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>5. Scope of work:</td>
  <td class=xl44><%=dt_m.Rows[0]["contract_nm"]%></td>
  <td colspan=10 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>6. Contract period:</td>
  <td class=xl44><%=dt_m.Rows[0]["contract_from_dt"]%>~<%=dt_m.Rows[0]["contract_to_dt"]%></td>
  <td colspan=10 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>7. Contract amount:</td>
  <td class=xl44 x:num><%=dt.Rows[0]["net_cont"].ToString()%></td>
  <td class=xl44><%=dt_m.Rows[0]["ccy"].ToString()%></td>
  <td colspan=9 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl45></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td></td>
  <td class=xl44>8. Details:</td>
  <td colspan=12 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl43 style='height:8.25pt'></td>
  <td colspan=14 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl43 style='height:23.25pt'></td>
  <td rowspan=2 class=xl92 style='border-bottom:.5pt solid black'>No.</td>
  <td colspan=2 rowspan=2 class=xl94 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Description</td>
  <td colspan=2 rowspan=2 class=xl98 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Contract amount</td>
  <td colspan=2 rowspan=2 class=xl98 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Previous payment</td>
  <td colspan=2 rowspan=2 class=xl98 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black' x:str="This time ">This time<span
  style='mso-spacerun:yes'>�</span></td>
  <td colspan=3 rowspan=2 class=xl98 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Accumulated</td>
  <td rowspan=2 class=xl92 style='border-bottom:.5pt solid black'>Balance</td>
  <td rowspan=2 class=xl92 style='border-bottom:.5pt solid black'>Remark</td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl43 style='height:24.75pt'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl47 style='height:30.0pt'></td>
  <td class=xl48 x:str="'1.">1.</td>
  <td colspan=2 class=xl103 style='border-right:.5pt solid black'>Net Amount</td>
  <td colspan=2 class=xl105 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0]["net_cont"].ToString()%></td>
  <td colspan=2 class=xl105 style='border-right:.5pt solid black;border-left:
  none' x:num></td>
  <td colspan=2 class=xl105 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=3 class=xl105 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=G31+I31"></td>
  <td class=xl50 x:num x:fmla="=E31-K31">0</td>
  <td class=xl50></td>
  <td class=xl51></td>
  <td colspan=10 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td class=xl52></td>
  <td colspan=2 class=xl108 style='border-right:.5pt solid black'>VAT (10%)</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0]["vat_cont"].ToString()%></td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=3 class=xl110 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=G32+I32"></td>
  <td class=xl53 x:num x:fmla="=E32-K32">0</td>
  <td class=xl53></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl47 style='height:30.0pt'></td>
  <td class=xl54></td>
  <td colspan=2 class=xl112 style='border-right:.5pt solid black'>Total</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0]["total_cont"].ToString()%></td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num>0</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=3 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I33+G33">0</td>
  <td class=xl55 x:num x:fmla="=E33-K33">0</td>
  <td class=xl55></td>
  <td class=xl51></td>
  <td colspan=10 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl47 style='height:30.0pt'></td>
  <td class=xl54 x:str="'2.">2.</td>
  <td colspan=2 class=xl112 style='border-right:.5pt solid black'>Advance (<%=dt.Rows[0]["adv"].ToString()%>%)</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0]["adv_cont"].ToString()%></td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0]["adv_deduct_cont"].ToString()%></td>
  <td colspan=3 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I34+G34">0</td>
  <td class=xl55 x:num x:fmla="=E34-K34">0</td>
  <td class=xl55></td>
  <td class=xl51></td>
  <td colspan=10 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl47 style='height:30.0pt'></td>
  <td class=xl54 x:str="'3.">3.</td>
  <td colspan=2 class=xl112 style='border-right:.5pt solid black'>Retention (<%=dt.Rows[0]["reten"].ToString()%>%)</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0]["reten_cont"].ToString()%></td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num>0</td>
  <td colspan=3 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num>0</td>
  <td class=xl55 x:num x:fmla="=E35-K35">0</td>
  <td class=xl55></td>
  <td class=xl51></td>
  <td colspan=10 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl47 style='height:30.0pt'></td>
  <td class=xl54 x:str="'4.">4.</td>
  <td colspan=2 class=xl112 style='border-right:.5pt solid black'>Deducting</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=3 class=xl114 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td class=xl55></td>
  <td class=xl55></td>
  <td class=xl51></td>
  <td colspan=10 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td class=xl56></td>
  <td colspan=2 class=xl108 style='border-right:.5pt solid black'>Advance (<%=dt.Rows[0]["adv"].ToString()%>%)</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=E34">0</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=3 class=xl110 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I37+G37">0</td>
  <td class=xl57 x:num x:fmla="=E37-K37">0</td>
  <td class=xl57></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl58 style='height:30.0pt'></td>
  <td class=xl59></td>
  <td colspan=2 class=xl117 style='border-right:.5pt solid black'>Withholding
  tax (<%=dt.Rows[0]["with_deduct_cont"].ToString()%>%)</td>
  <td colspan=2 class=xl119 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl119 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl119 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=3 class=xl119 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I38+G38">0</td>
  <td class=xl60 x:num x:fmla="=E38-K38">0</td>
  <td class=xl60></td>
  <td class=xl62></td>
  <td colspan=10 class=xl61 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl43 style='height:30.0pt'></td>
  <td class=xl56></td>
  <td colspan=2 class=xl108 style='border-right:.5pt solid black'>Retention (<%=dt.Rows[0]["reten"].ToString()%>%)</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=E35">0</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=3 class=xl110 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I39+G39">0</td>
  <td class=xl57 x:num x:fmla="=E39-K39">0</td>
  <td class=xl57></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl47 style='height:30.0pt'></td>
  <td class=xl54></td>
  <td colspan=2 class=xl112 style='border-right:.5pt solid black'>Total deduct</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num><%=dt.Rows[0]["total_deduct_cont"].ToString()%></td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I37+I38+I39">0</td>
  <td colspan=3 class=xl114 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I40+G40">0</td>
  <td class=xl55 x:num x:fmla="=E40-K40">0</td>
  <td class=xl55></td>
  <td class=xl51></td>
  <td colspan=10 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl47 style='height:30.0pt'></td>
  <td class=xl48 x:str="'5.">5.</td>
  <td colspan=2 class=xl122 style='border-right:.5pt solid black'>Actual
  Payment</td>
  <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left:lue
  none' x:num x:fmla="=E33">0</td>
  <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I34-I40">0</td>
  <td colspan=3 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I41+G41">0</td>
  <td class=xl50 x:num x:fmla="=E41-K41">0</td>
  <td class=xl50></td>
  <td class=xl51></td>
  <td colspan=10 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl43 style='height:9.0pt'></td>
  <td class=xl63></td>
  <td colspan=2 class=xl127 style='border-right:.5pt solid black'></td>
  <td colspan=2 class=xl127 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=2 class=xl127 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=2 class=xl127 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=3 class=xl127 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td class=xl64></td>
  <td class=xl65></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td colspan=14 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl43 style='height:20.1pt'></td>
  <td class=xl46 colspan=2 style='mso-ignore:colspan'>Status:</td>
  <td colspan=12 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl43 style='height:8.25pt'></td>
  <td colspan=14 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl43 style='height:34.5pt'></td>
  <td colspan=3 class=xl130 width=202 style='border-right:.5pt solid black;
  width:152pt'>Contract amount ( Incl. VAT)</td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none'>Previous</td>
  <td colspan=2 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>This time</td>
  <td colspan=2 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>Accumulated</td>
  <td colspan=3 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>Ratio</td>
  <td class=xl66>Balance</td>
  <td class=xl66>Remark</td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl43 style='height:27.0pt'></td>
  <td colspan=3 class=xl94 style='border-right:.5pt solid black' x:num><%=dt.Rows[0]["total_cont"].ToString() %></td>
  <td colspan=2 class=xl139 style='border-right:.5pt solid black;border-left:
  none'>0</td>
  <td colspan=2 class=xl94 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=I41">0</td>
  <td colspan=2 class=xl94 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=K41">0</td>
  <td colspan=3 class=xl140 style='border-right:.5pt solid black;border-left:
  none' x:err="#DIV/0!" x:fmla="=K41/E41*100%"></td>
  <td class=xl67 x:num x:fmla="=N41">0</td>
  <td class=xl68></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl43 style='height:9.75pt'></td>
  <td colspan=3 class=xl100 style='border-right:.5pt solid black'></td>
  <td colspan=2 class=xl100 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=2 class=xl144 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=2 class=xl144 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td colspan=3 class=xl146 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td class=xl69></td>
  <td class=xl70></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td colspan=14 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td colspan=14 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td class=xl44></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>Attachment as below;</td>
  <td colspan=11 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl44>1./ Claim</td>
  <td colspan=11 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>2./ Confirmed BOQ</td>
  <td colspan=10 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td colspan=14 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>I would like to get your
  approval</td>
  <td colspan=10 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'></td>
  <td colspan=14 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl71 style='height:15.0pt'></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td class=xl49 colspan=6 style='mso-ignore:colspan'>POSCO ENGINEERING &amp;
  CONSTRUCTION VIETNAM CO.,LTD</td>
  <td class=xl38></td>
  <td class=xl72></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl73 style='height:9.95pt'></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl74></td>
  <td class=xl75></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=14 style='width:11pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=134 style='width:101pt'></td>
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
