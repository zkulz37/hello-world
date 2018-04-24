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
      
    string p_pk = Request.QueryString["master_pk"];
    
    DataTable dt,dt1;
    dt = ESysLib.TableReadOpenCursor("lg_rpt_fpfa00401", "'" + p_pk + "'");
    //Response.Write(dt);
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_fpfa00401_1", "'" + p_pk + "'");
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpfa00310_1_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpfa00310_1_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpfa00310_1_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NhanNT</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2012-10-11T08:11:28Z</o:LastPrinted>
  <o:Created>2012-07-18T07:52:42Z</o:Created>
  <o:LastSaved>2012-10-11T08:26:42Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .5in .2in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-horizontal-page-align:center;}
.font0
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.font7
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Symbol, serif;
	mso-font-charset:2;}
.font10
	{color:black;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-family:Symbol, serif;
	mso-font-charset:2;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-family:Symbol, serif;
	mso-font-charset:2;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-family:Symbol, serif;
	mso-font-charset:2;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl48
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl49
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double black;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:top;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:top;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:top;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;}
.xl73
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl80
	{mso-style-parent:style0;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl87
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl90
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double black;
	border-bottom:none;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl97
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl100
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid black;}
.xl101
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>RFI</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>88</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:ShowPageBreakZoom/>
     <x:PageBreakZoom>100</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
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
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8745</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=RFI!$1:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=832 style='border-collapse:
 collapse;table-layout:fixed;width:624pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1248;
 width:29pt'>
 <col class=xl24 width=170 style='mso-width-source:userset;mso-width-alt:5440;
 width:128pt'>
 <col class=xl24 width=48 style='mso-width-source:userset;mso-width-alt:1536;
 width:36pt'>
 <col class=xl24 width=155 style='mso-width-source:userset;mso-width-alt:4960;
 width:116pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1344;
 width:32pt'>
 <col class=xl24 width=57 style='mso-width-source:userset;mso-width-alt:1824;
 width:43pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1632;
 width:38pt'>
 <col class=xl24 width=43 style='mso-width-source:userset;mso-width-alt:1376;
 width:32pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2560;
 width:60pt'>
 <col class=xl24 width=147 style='mso-width-source:userset;mso-width-alt:4704;
 width:110pt'>
 <col class=xl24 width=73 span=246 style='mso-width-source:userset;mso-width-alt:
 2336;width:55pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 width=39 style='height:30.0pt;width:29pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_7" o:spid="_x0000_s1025" type="#_x0000_t75"
   alt="logo-E&amp;C-VIETNAM.jpg" style='position:absolute;margin-left:12.75pt;
   margin-top:6pt;width:136.5pt;height:36.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_fpfa00310_1_files/image001.jpg" o:title="logo-E&amp;C-VIETNAM"
    croptop="8977f" cropbottom="14663f" cropleft="6242f" cropright="4993f"/>
   <v:path arrowok="t"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:17px;margin-top:8px;width:182px;
  height:49px'><img width=182 height=49 src="rpt_fpfa00310_1_files/image002.jpg"
  alt="logo-E&amp;C-VIETNAM.jpg" v:shapes="Picture_x0020_7"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=40 class=xl25 width=39 style='height:30.0pt;width:29pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 width=170 style='width:128pt'>&nbsp;</td>
  <td colspan=5 rowspan=4 class=xl57 width=353 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:265pt'>REQUEST FOR INSPECTION
  (Production)</td>
  
  <td colspan=3 class=xl72 width=270 style='border-right:.5pt solid black;
  border-left:none;width:202pt'>*<%= dt.Rows[0]["bc"] %>*</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl27 style='height:18.0pt'>&nbsp;</td>
  <td class=xl24></td>
  <td colspan=3 class=xl66 style='border-right:2.0pt double black;border-left:
  none'>Req.No: <%= dt.Rows[0]["slip_no"] %></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl27 style='height:18.0pt'>&nbsp;</td>
  <td class=xl24></td>
  <td colspan=3 class=xl69 style='border-right:2.0pt double black;border-left:
  none'>Date: <%= dt.Rows[0]["doc_date"]%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl28 style='height:18.0pt'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl69 style='border-right:2.0pt double black;border-left:
  none'>Page: 1/1</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=10 height=28 class=xl55 style='border-right:2.0pt double black;
  height:21.0pt'>Project Name: <%= dt.Rows[0]["pl_nm"] %></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=4 height=28 class=xl55 style='height:21.0pt'>Team : <%= dt.Rows[0]["TEAM_NAME"] %></td>
  <td colspan=6 class=xl56 style='border-right:2.0pt double black'>Inspection
  date:</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl30 colspan=2 style='height:21.0pt;mso-ignore:colspan'>Inspection<span
  style='mso-spacerun:yes'>  </span>Activities :FIT-U<span style='display:none'>P
  &amp; WELDING</span></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'>No.</td>
  <td class=xl35>Drawing No.</td>
  <td class=xl35>Rev.</td>
  <td class=xl35>Item No.</td>
  <td class=xl35>Q'ty.</td>
  <td colspan=4 class=xl76 style='border-right:.5pt solid black;border-left:
  none'>Result</td>
  <td class=xl36 width=147 style='width:110pt'>Receiving by</td>
 </tr>
 <%
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
  %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl37 style='height:20.1pt'><%= dt1.Rows[i]["seq"]%></td>
  <td class=xl38><%= dt1.Rows[i]["dwg_no"]%></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38><%= dt1.Rows[i]["idmk"]%></td>
  <td class=xl38><%= dt1.Rows[i]["wi_qty"]%></td>
  
  <td class=xl39 colspan=4 style='mso-ignore:colspan;border-right:.5pt solid black'>&#159;<font
  class="font0"> Accept<span style='mso-spacerun:yes'>    </span></font><font
  class="font7">&#159;</font><font class="font0"> Holding<span
  style='mso-spacerun:yes'>     </span></font><font class="font7">&#159; </font><font
  class="font0">Rejec</font><span style='display:none'><font class="font0">t</font></span></td>
  <td class=xl42>&nbsp;</td>
  <%
  }
   %>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=2 height=26 class=xl79 style='height:20.1pt'>Comment:</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td colspan=3 class=xl44>&nbsp;</td>
  <td class=xl45></td>
  <td class=xl46>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl47 style='height:20.1pt'>&nbsp;</td>
  <td colspan=4 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl45></td>
  <td class=xl45></td>
  <td class=xl43>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 style='height:20.1pt'>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td colspan=3 class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=2 height=38 class=xl81 style='border-right:.5pt solid black;
  height:28.5pt'>Prepared by</td>
  <td colspan=3 class=xl83 width=245 style='border-right:.5pt solid black;
  border-left:none;width:184pt'>Checked by QC</td>
  <td colspan=5 class=xl86 style='border-right:2.0pt double black;border-left:
  none'>Checked by Client</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl89 style='border-right:.5pt solid black;
  height:19.5pt'>Name:</td>
  <td colspan=3 class=xl91 style='border-right:.5pt solid black;border-left:
  none' x:str="Name:                                      ">Name:<span
  style='mso-spacerun:yes'>                                      </span></td>
  <td colspan=5 class=xl91 style='border-right:2.0pt double black;border-left:
  none' x:str="Name:                                      ">Name:<span
  style='mso-spacerun:yes'>                                      </span></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl94 style='border-right:.5pt solid black;
  height:19.5pt'>&nbsp;</td>
  <td colspan=2 class=xl96 style='border-left:none'>Acceptance</td>
  <td height=26 class=xl51 width=42 style='height:19.5pt;width:32pt'><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_14" o:spid="_x0000_s1026" style='position:absolute;
   margin-left:1.5pt;margin-top:.75pt;width:14.25pt;height:12.75pt;z-index:2;
   visibility:visible' o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=1 height=0></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=21 height=19 src="rpt_fpfa00310_1_files/image003.gif"
    v:shapes="Rectangle_x0020_14"></td>
    <td width=20></td>
   </tr>
   <tr>
    <td height=7></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:31.5pt;height:19.5pt'></span><![endif]--></td>
  <td colspan=4 class=xl96 style='border-left:none'>Acceptance</td>
  <td height=26 class=xl52 width=147 style='height:19.5pt;width:110pt'><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_17" o:spid="_x0000_s1029" style='position:absolute;
   margin-left:32.25pt;margin-top:.75pt;width:14.25pt;height:12.75pt;z-index:5;
   visibility:visible' o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=42 height=0></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=21 height=19 src="rpt_fpfa00310_1_files/image003.gif"
    v:shapes="Rectangle_x0020_17"></td>
    <td width=84></td>
   </tr>
   <tr>
    <td height=7></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:110.25pt;height:19.5pt'></span><![endif]--></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl89 style='border-right:.5pt solid black;
  height:19.5pt'>Signature:</td>
  <td colspan=3 class=xl91 style='border-right:.5pt solid black;border-left:
  none'>Signature:<span style='mso-spacerun:yes'>                          
  </span><font class="font10"><span style='mso-spacerun:yes'> </span></font></td>
  <td colspan=5 class=xl91 style='border-right:2.0pt double black;border-left:
  none' x:str="Signature:           ">Signature:<span
  style='mso-spacerun:yes'>           </span></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl94 style='border-right:.5pt solid black;
  height:19.5pt'>&nbsp;</td>
  <td colspan=2 class=xl96 style='border-left:none'>Acceptance with comment</td>
  <td height=26 class=xl51 width=42 style='height:19.5pt;width:32pt'><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_15" o:spid="_x0000_s1027" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:14.25pt;height:12.75pt;z-index:3;
   visibility:visible' o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=1 height=1></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=21 height=19 src="rpt_fpfa00310_1_files/image003.gif"
    v:shapes="Rectangle_x0020_15"></td>
    <td width=20></td>
   </tr>
   <tr>
    <td height=6></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:31.5pt;height:19.5pt'></span><![endif]--></td>
  <td colspan=4 class=xl96 style='border-left:none'>Acceptance with comment</td>
  <td height=26 class=xl52 width=147 style='height:19.5pt;width:110pt'><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_18" o:spid="_x0000_s1030" style='position:absolute;
   margin-left:32.25pt;margin-top:2.25pt;width:14.25pt;height:12.75pt;
   z-index:6;visibility:visible' o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=42 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=21 height=19 src="rpt_fpfa00310_1_files/image003.gif"
    v:shapes="Rectangle_x0020_18"></td>
    <td width=84></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:110.25pt;height:19.5pt'></span><![endif]--></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl89 style='border-right:.5pt solid black;
  height:19.5pt'>Date:</td>
  <td colspan=3 height=26 width=245 style='border-right:.5pt solid black;
  height:19.5pt;width:184pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_16" o:spid="_x0000_s1028" style='position:absolute;
   margin-left:153.75pt;margin-top:19.5pt;width:14.25pt;height:12.75pt;
   z-index:4;visibility:visible' o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:4;margin-left:204px;margin-top:25px;width:21px;height:19px'><img
  width=21 height=19 src="rpt_fpfa00310_1_files/image003.gif" v:shapes="Rectangle_x0020_16"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=26 class=xl102 width=245 style='border-right:.5pt solid black;
    height:19.5pt;border-left:none;width:184pt'
    x:str="Date:                              ">Date:<span
    style='mso-spacerun:yes'>                              </span></td>
   </tr>
  </table>
  </span></td>
  <td colspan=5 class=xl91 style='border-right:2.0pt double black;border-left:
  none' x:str="Date:                  ">Date:<span
  style='mso-spacerun:yes'>                  </span></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl98 style='border-right:.5pt solid black;
  height:19.5pt'>&nbsp;</td>
  <td colspan=2 class=xl100 style='border-left:none'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  Rejection</td>
  <td class=xl53>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td colspan=4 class=xl100 style='border-left:none'>Rejection</td>
  <td height=26 class=xl54 width=147 style='height:19.5pt;width:110pt'><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_19" o:spid="_x0000_s1031" style='position:absolute;
   margin-left:32.25pt;margin-top:.75pt;width:14.25pt;height:12.75pt;z-index:7;
   visibility:visible' o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=42 height=0></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=21 height=19 src="rpt_fpfa00310_1_files/image003.gif"
    v:shapes="Rectangle_x0020_19"></td>
    <td width=84></td>
   </tr>
   <tr>
    <td height=7></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:110.25pt;height:19.5pt'></span><![endif]--></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=39 style='width:29pt'></td>
  <td width=170 style='width:128pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=155 style='width:116pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=147 style='width:110pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
